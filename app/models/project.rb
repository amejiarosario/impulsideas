class Project < ActiveRecord::Base
  belongs_to :user
  has_many :contributions, dependent: :destroy

  def total_contributed
    Contribution
      .where(project_id: self.id, payment_status: 'ACTIVE')
      .group(:project_id)
      .sum(:amount)
      .values[0]
  end

  def total_contributors
   contributions.where(payment_status: 'ACTIVE').select('DISTINCT(user_id)').count
  end
end
