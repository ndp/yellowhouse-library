class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :isbn10, :string
    add_column :books, :isbn13, :string
    add_column :books, :summary, :string
  end
end
