class Project < ActiveRecord::Base
  belongs_to :user
  has_many :contributions, dependent: :destroy

  def total_contributed
    Contribution
      .where(project_id: self.id)
      .group(:project_id)
      .sum(:amount)
      .values[0]
  end

  def total_contributors
   contributions.select('DISTINCT(user_id)').count
  end
end
