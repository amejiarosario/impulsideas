# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  orderable_id   :integer
#  orderable_type :string(255)
#  payment_uid    :string(255)
#  amount         :decimal(8, 2)
#  description    :string(255)
#  raw            :hstore
#  completed      :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#

class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers

  serialize :raw

  belongs_to :user
  belongs_to :orderable, polymorphic: true

  attr_accessor :approval_url, :paypal_errors

  after_create :create_payment

  validates :amount, presence: true
  validates :description, presence: true

  scope :completed, ->{ where(completed: true) }

  def create_payment
    payment = PayPal::SDK::REST::Payment.new(payment_params)
    payment.create

    if payment.success?
      self.update_column(:payment_uid, payment.id)
      @approval_url = payment.links[1].href
    else
      messages = payment.error.details.map(&:issue).join(". ")
      logger.error messages
      errors.add(:paypal, messages)
    end

    self.update_column(:raw, payment.to_hash)
    logger.debug "------- #{payment.to_hash}"
  end

  def executed_payment? (params)
    return false if params[:cancel]

    payment = PayPal::SDK::REST::Payment.find(self.payment_uid)
    status = false

    if payment.execute(payer_id: params[:PayerID])
      self.update_columns(completed: true, raw: payment.to_hash)

      logger.debug "------- #{payment.to_hash}"
      status = true
    else
      self.update_column(:raw, payment.to_hash.merge({ errors: payment.error }))
      logger.error "------- #{payment.error}"
      @paypal_errors = "Paypal no pudo realizar la transacción. #{payment.error.try(:[], :message)}"
    end

    status
  end

  def payment_params
    host = Rails.env.production? ? 'beta.impulsideas.com' : '0.0.0.0:4000'
    url = "#{execute_order_url(self.id, host: host)}"

    {
      :intent => "sale",
      :payer => {
        :payment_method => "paypal" },
      :redirect_urls => {
        :return_url => "#{url}?success=true",
        :cancel_url => "#{url}?cancel=true" },
      :transactions => [ {
        :amount => {
          :total => "#{number_to_currency(self.amount, unit: "")}",
          :currency => "USD" },
        :description => "#{self.description}" } ]
    }
  end
end
