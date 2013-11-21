class PaymentNotification < ActiveRecord::Base
  belongs_to :contribution
  serialize :params
  after_create :update_contribution_status

  private
    def update_contribution_status
      contribution.update_attributes(payment_status: payment_status)
    end
end
