class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.string :payment_uid
      t.decimal :amount, precision: 8, scale: 2
      t.string :description

      t.timestamps
    end
  end
end
