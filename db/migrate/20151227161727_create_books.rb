class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.belongs_to :genre, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
