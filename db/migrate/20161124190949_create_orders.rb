class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date
      t.float :amount
      t.boolean :status
      t.boolean :paid
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
