class Book < ActiveRecord::Base

  belongs_to :genre
  belongs_to :author

  has_many :book_characters
  has_many :book_subjects

  has_many :characters, through: :book_characters
  has_many :subjects, through: :book_subjects

  include AlgoliaSearch
  algoliasearch index_name: "Book_#{Rails.env}" do
    attribute :title, :author_name, :genre_name, :subject_names, :character_names
  end

  private
  def author_name
    author.name
  end

  def genre_name
    genre.try(:name)
  end

  def subject_names
    subjects.map(&:name).to_sentence
  end

  def character_names
    characters.map(&:name).to_sentence
  end


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
