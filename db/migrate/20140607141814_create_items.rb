class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock
      t.references :user, index: true

      t.timestamps
    end
  end
end
