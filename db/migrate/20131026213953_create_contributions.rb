class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.float :amount
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end