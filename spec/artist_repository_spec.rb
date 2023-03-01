require 'artist_repository'

def reset_artists_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do
  before(:each) do 
    reset_artists_table
  end

  context '#all' do
    it 'returns how many artists in the database' do
      repo = ArtistRepository.new
      artists = repo.all
      expect(artists.length).to eq 3
    end

    it 'returns all artists' do
      repo = ArtistRepository.new
      artists = repo.all
      expect(artists[2].id).to eq '3'
      expect(artists[2].name).to eq 'Anderson Paak'
      expect(artists[2].genre).to eq 'R&B'
    end
  end

  context '#find' do
    it 'returns particular artist record' do
      repo = ArtistRepository.new
      find_artist = repo.find("2")
      expect(find_artist.id).to eq "2"
      expect(find_artist.name).to eq "Clipse"
      expect(find_artist.genre).to eq "Hip-Hop"
    end
  end

  context '#create' do
    it 'creates a new artist record' do
      repo = ArtistRepository.new
      repo.create("Drake", "Hip-Pop")
      artists = repo.all
      expect(artists[3].id).to eq "4"
      expect(artists[3].name).to eq "Drake"
      expect(artists[3].genre).to eq "Hip-Pop"
    end
  end

  context '#update' do
    it 'updates existing artist record' do
      repo = ArtistRepository.new
      
      repo.update('2', 'genre', 'Rap')
      artist = repo.all.last
      expect(artist.id).to eq '2'
      expect(artist.name).to eq 'Clipse'
      expect(artist.genre).to eq 'Rap'
    end
  end

  context '#delete' do
    it 'deletes an artist record' do
      repo = ArtistRepository.new
      repo.delete("1")
      artists = repo.all
      expect(artists.length).to eq 2
    end
  end
end