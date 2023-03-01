require_relative './artist'

class ArtistRepository
  @artists = []
  
  def initialize
  end

  def all
    @artists = []

    sql = "SELECT * FROM artists;"
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |item|
      artist = Artist.new

      artist.id = item["id"]
      artist.name = item["name"]
      artist.genre = item["genre"]

      @artists << artist
    end
    return @artists
  end

  def find(id)
    artists = all

    artists.each do |artist|
      return artist if artist.id == id
    end
  end

  def create(name, genre)
    artist = Artist.new
    artist.name = name
    artist.genre = genre

    sql = "INSERT INTO artists (name, genre) VALUES ($1, $2);"
    result_set = DatabaseConnection.exec_params(sql, [artist.name, artist.genre])
  end

  def update(id, column, new_value)
    sql = "UPDATE artists SET #{column} = $1 WHERE id = $2;"
    result_set = DatabaseConnection.exec_params(sql, [new_value, id])
  end

  def delete(id)
    sql = "DELETE FROM artists WHERE id = $1;"
    result_set = DatabaseConnection.exec_params(sql, [id])
  end

end