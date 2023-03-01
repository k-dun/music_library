Albums Model and Repository Classes Design Recipe

1. 

Table: artists

Columns:
id | name | genre

----

Table: albums

Columns:
id | title | release_year | artist_id


2. Create Test SQL seeds

-- (file: spec/seeds_artists.sql)

TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO students (name, genre) VALUES ('J Dilla', 'Neo-Soul');
INSERT INTO students (name, genre) VALUES ('Clipse', 'Hip-Hop');
INSERT INTO students (name, genre) VALUES ('Anderson Paak', 'R&B');

-----

-- (file: spec/seeds_albums.sql)

TRUNCATE TABLE albums RESTART IDENTITY;

INSERT INTO albums (title, release_year, artist_id) VALUES ('The Shining', '2006', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Hell Hath No Fury', '2006', '2');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Malibu', '2016', '3');

3. 
# Table name: students

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end

4. 
# Table name: artists

# Model class
# (in lib/artist.rb)

class Artist
  attr_accessor :id, :name, :genre
end

# Repository class
# (in lib/artist_repository.rb)

class ArtistRepository
  attr_accessor :id, :title, :release_year, :artist_id
end

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# Table name: artists

# Repository class
# (in lib/artist_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists WHERE id = $1;
    # Returns a single Artist object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(name, genre)
    # Executes the SQL query:
    # INSERT INTO artists (name, genre) VALUES ('name', 'genre');
    # No return.
  end

  def update(id, column, new_value)
    # Executes the SQL query:
    # UPDATE artists SET column = new_value WHERE id = condition;
    # No return.
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM artists WHERE id = condition;
    # No return.
  end
end

6.
# 1
# Get all artists

repo = ArtistRepository.new

artists = repo.all

artists.length # =>  3

artists[0].id # =>  1
artists[0].name # =>  'J Dilla'
artists[0].genre # =>  'Neo-Soul'

artists[1].id # =>  2
artists[1].name # =>  'Clipse'
artists[1].genre # =>  'Hip-Hop'

# 2
# Get a single student

repo = ArtistRepository.new

artist = repo.find(1)

artist.id # =>  1
artist.name # =>  'J Dilla'
artist.genre # =>  'Neo-Soul'

# 3
# Create a new student record
  
repo = ArtistRepository.new

artist = repo.update('name', '', 'UK Rap')

artist.id # => 4
artist.name # => 'Knucks'
artist.genre # => 'UK Rap'

# 4
# Update student record

repo = ArtistRepository.new

artist = repo.update($2, 'Clipse', 'Hip-Hop', 'Rap')

artist.id # => 2
artist.name # => 'Clipse'
artist.genre # => 'Rap'

# 5
# Delete student record

repo = ArtistRepository.new

artist = repo.delete($3)

repo.find($3) # => nil

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_artists_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'artists' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_artists_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.