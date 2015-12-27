class Book < ActiveRecord::Base
  belongs_to :genre
  belongs_to :author

  has_many :book_characters
  has_many :book_subjects

  has_many :characters, through: :book_characters
  has_many :subjects, through: :book_subjects

end
