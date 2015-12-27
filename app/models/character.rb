class Character < ActiveRecord::Base

  has_many :book_characters
  has_many :books, through: :book_characters

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
