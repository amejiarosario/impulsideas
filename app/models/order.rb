# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  payment_uid  :string(255)
#  amount      :decimal(, )
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers

  belongs_to :user

  attr_accessor :approval_url, :payer_id, :token, :paypal_errors

  after_create :create_payment

  # Create a payment by constructing a payment object using access token.
  # https://devtools-paypal.com/guide/pay_paypal/ruby?interactive=OFF&env=sandbox
  def create_payment
    payment = PayPal::SDK::REST::Payment.new(payment_params)
    logger.info payment_params

    payment.create

    if payment.success?
      logger.info "------- #{payment.id} | #{payment.to_hash}"
      self.update_column(:payment_uid, payment.id)
      @approval_url = payment.links[1].href
    else
      error_messages = payment.error.details.map(&:issue).join(". ")
      logger.info error_messages
      errors.add(:paypal, error_messages)
    end
  end

  def executed_payment? (params)
    payment = PayPal::SDK::REST::Payment.find(self.payment_uid)
    if payment.execute(payer_id: params[:PayerID])
      logger.info "------- #{payment.to_hash}"
      true
    else
      logger.error "------- #{payment.error.inspect}"
      paypal_errors = payment.error.details.map(&:issue).join(". ")
      false
    end
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
