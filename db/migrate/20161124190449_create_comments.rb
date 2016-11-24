class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :mail
      t.string :text

      t.timestamps null: false
    end
  end
end
