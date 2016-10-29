class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :tipe

      t.timestamps null: false
    end
  end
end
