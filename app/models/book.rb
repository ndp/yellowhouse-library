class Book < ActiveRecord::Base

  belongs_to :genre
  belongs_to :author

  has_many :book_characters
  has_many :book_subjects

  has_many :characters, through: :book_characters
  has_many :subjects, through: :book_subjects

  include AlgoliaSearch
  algoliasearch index_name: "Book_#{Rails.env}" do
    attribute :title, :author_name, :genre_name, :subject_names, :character_names, :isbn13
  end

  def fetch_and_save_book_info
    json = fetch_book_info
    if json['data']
      data= json['data'].first
      self.isbn10 = data['isbn10'] unless data['isbn10'].blank?
      self.isbn13 = data['isbn13'] unless data['isbn13'].blank?
      self.summary = data['summary'] unless data['summary'].blank?
      # Data looks bad:
      # if data['subject_ids']
      #   self.subjects << data['subject_ids'].map do |sid|
      #     sid.gsub('amazon_com_', '')
      #   end.map do |sid|
      #     sid.gsub('_', ' ')
      #   end.map do |s|
      #     Subject.find_or_create_by!(name: s)
      #   end
      # end
      self.save!
    else
      puts "No data found for book #{id}: #{title}"
    end
  end

  private
  def fetch_book_info
    conn = Faraday.new(:url => "http://isbndb.com/api/v2/json/#{ENV['ISBNDB_KEY']}/book")
    response = conn.get title.parameterize('_')
    JSON.parse(response.body)
  end

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
      field :isbn10
      field :isbn13
      field :author
      field :genre
      field :subjects
      field :characters
      field :summary, :text
    end
  end

end
