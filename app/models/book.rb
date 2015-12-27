class Book < ActiveRecord::Base

  belongs_to :genre
  belongs_to :author

  has_many :book_characters
  has_many :book_subjects

  has_many :characters, through: :book_characters
  has_many :subjects, through: :book_subjects

  rails_admin do
    list do
      field :title
      field :author
      field :genre
      field :subjects
      field :characters
    end
    edit do
      field :title
      field :author
      field :genre
      field :subjects
      field :characters
    end
  end

end
