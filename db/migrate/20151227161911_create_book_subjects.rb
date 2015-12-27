class CreateBookSubjects < ActiveRecord::Migration
  def change
    create_table :book_subjects do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.belongs_to :subject, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
