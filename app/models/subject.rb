class Subject < ActiveRecord::Base
  has_many :book_subjects
  has_many :books, through: :book_subjects

  rails_admin do
    list do
      field :name
      field :books
    end
    show do
      field :name
      field :books
    end
    edit do
      field :name
    end
  end
end
