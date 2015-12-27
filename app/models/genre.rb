class Genre < ActiveRecord::Base
  has_one :genre

  has_many :books

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
