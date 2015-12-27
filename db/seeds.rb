# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
spreadsheet = <<SPREADSHEET
American Sign Language Dictionary	Martin L.A. Sternberg	Reference	Sign Language, Signs
Animal Encyclopedia	Dorling Kindersley	Reference	Animals
Animal Kingdom	Eyewitness Books	Reference Book	Animals
Akata Witch	Nnedi Okorafor	Fantasy	Magic 	Sunny
Artemis Fowl	Eoin Colfer	Fantasy	Fairies, Criminal Mastermind	Artemis Fowl
Alices Adventures in Wonderland & Through the Looking Glass	Lewis Carroll	Fantasy	Wonderland, Adventure	Alice
Along Came a Dog	Meindert DeJong	Realistic Fiction	Friendship, Farm	Hen and Dog
Animal Farm	George Orwell	Allegory	Power, Rebellion, Classics	Pigs, Dogs and Other Farm Animals
The Alchemist	Michael Scott	Fantasy	Immortality, Sorcery, Secrets	Sophie and Josh Newman, Nicholas Flamel
The Adventures of Huckleberry Finn	Mr. Mark Twain	Historical Fiction	Jim, Adventure, Many Southern Dialects, Classics	Huckleberry Finn
Beryl: A Pig's Tale	Jane Simmons	Adventurous Fiction	Pigs, Adventure, Looking for a Home	Beryl
Brown Girl Dreaming	Jacqueline Woodson	Free Verse Autobiography	Family, Civil Rights Movement, 1960's and 1970's	Jacqueline Woodson
Book Scavenger	Jennifer Chambliss Bertman	Mystery Fiction	Books, Clues, Adventure, Scavenging	Emily and James
The Blackthorn Key	Kevin Sands	Mystery Fantasy	Potions and Medicines, Magic, Mystery	Christopher Rowe
Bliss	Kathryn Littlewood	Fantasy	Magic, Baking, Mystery	Rosemary
A Dash of Magic	Kathryn Littlewood	Fantasy	Aunt Lily, Magic, Baking	Rosemary
Bite-Sized Magic	Kathryn Littlewood	Fantasy	Mr. Butter, Baking, Society of the Rolling Pin, Magic	Rosemary
Not So True Stories & Unreasonable Rhymes	Carlin Berger	Poetry	Poems, Rhymes
The Boys in the Boat	Daniel James Brown	Biography	9 Boys Rowing in the Olympics, Triumph, Hard Times	Joe Rantz
Black Beauty	Anna Sewell	Animal Autobiography'	Horses, Farmer Grey, Life of a Horse, Classics	Black Beauty
The Birchbark House	Louise Erdrich	Realistic Fiction	Family, Change, Unknown Visitor	Omakayas
The Book of Three	Lloyd Alexander	Fantasy, Adventure	Adventures, Wars, 	Taran
Cinderella Retold in Verse	Alice Duer Miller	Poetry	Family, Fairy Godmother, Poetry, Classics	Cinderella
The 13 1/2 Lives of Captain Bluebear	Walter Moers	Fantasy, Adventure	Zamonia, Creatures, Adventures, Awesomeness	Bluebear
The Alchemasters Apprentice	Walter Moers	Fantasy	Zamonia, Alchemaster, Evil, Foods, Sickness, Awesomeness	Echo the Crat
Cartwheeling in Thunderstorms	Katherine Rundell	Realistic Fiction	(Main Character),
Centaur Rising	Jane Yolen	Fantasy	Centaur, Magic	Arianne, Kai
Completely Unexpected Tales	Roald Dahl
Chasing Vermeer	Blue Balliet
Charlotte's Web	E.B. White	Fiction	Classics
Chicken Soup With Rice	Maurice Sendak
The Cricket in Times Square	George Selden
The Cats of Tanglewood Forest	Charles De Lint
Charlie and the Chocolate Factory	Roald Dahl	Fantasy	Classics
Chew on This	Eric Schlosser & Charles Wilson	Informational
The Desperate Adventures of Xeno and Alya	Jane Kelley	Adventure	Food, Unexpectedness, Adventure	Xeno and Alya
The Dark is Rising	Susan Cooper
Dinotopia	James Gurney	Fantasy	Dinosaurs, Adventures, Dinotopia	?
The Doll Shop Downstairs	Yona Zeldis McDonough
Emmy and the Rats in the Belfry	Lynne Jonell
El Español: La Teoría y La Práctica	Bourne Silman Sobrino	Educational (Language)
Eesti Keele Harjutustik 1	Valdek Lenk	Educational (Language)
Ella Enchanted	Gail Carson Levine	Fantasy, Allegory
The Empty Pot	Demi	Allegory
Estonian Folktales	Anne Türnpu	Folktales
The Evolution of Calpurnia Tate	Jacqueline Kelly	Realistic Fiction	Science, Grandfather, 1800s, Relationship	Calpurnia Tate
A Family of Poems	Caroline Kennedy	Poetry
From the Mixed-Up Files of Mrs. Basil E. Frankweiler	E.L. Konigsburg	Realistic Fiction
The Fire Within	Chris D'Lacey
The Five Lives of Our Cat Zook	Joanne Rocklin	Realistic Fiction
Feed	M.T. Anderson
The False Prince	Jennifer A. Nielsen
Fools Fate	Robin Hobb
Fractured Fairy Tales	A.J. Jacobs	Fairytales, Funny
Fly By Night	Frances Hardinge
The Forbidden Library	Django Wexler	Fantasy
Favorite Folktales From Around the World	Jane Yolen	Folktales, Allegory
Finding Our Way	Streetside Stories	Real Tales
The Fourteenth Goldfish	Jennifer Holm	Science Fiction, Allegory
Five Children and It	E. Nesbit	Fantasy
SPREADSHEET

require 'csv'
puts "STARTING"

lines = spreadsheet.split("\n")
lines.each do |line|
  title, author, genre, subjects, main_characters = *line.split("\t")

  author = Author.find_or_create_by!(name: author)
  genre = Genre.find_or_create_by!(name: genre) unless genre.blank?

  unless subjects.blank?
    subjects = subjects.split(',').map(&:strip).map do |s|
      Subject.find_or_create_by!(name: s)
    end
  end
  unless main_characters.blank?
    characters = main_characters.split(/,| and /).map(&:strip).map do |s|
      Character.find_or_create_by!(name: s)
    end
  end

  Book.find_or_create_by!(title: title) do |book|
    book.author = author
    book.genre = genre unless genre.blank?
    book.subjects = subjects  unless subjects.blank?
    book.characters = characters unless characters.blank?
    book.save!
  end
end
