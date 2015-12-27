class CreateBookCharacters < ActiveRecord::Migration
  def change
    create_table :book_characters do |t|
      t.belongs_to :character, index: true, foreign_key: true
      t.belongs_to :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
