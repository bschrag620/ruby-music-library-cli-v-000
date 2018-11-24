require "pry"

class MusicLibraryController
  attr_accessor :path

  def initialize(path='./db/mp3s')
    @path = path
    music_importer = MusicImporter.new(@path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = true
    while input != "exit"
      input = gets.strip
    end
  end

  def list_songs
    sorted_list = Song.alphabetical_songs
    sorted_list.each do |song|
      current_song = Song.find_by_name(song)
      puts "#{i}. #{current_song.artist.name} - #{current_song.name} - #{current_song.genre.name}"
      i += 1
    end
  end

  def list_artists
    i = 1
    artist_list = []
    Artist.all.each do |artist|
      artist_list << artist.name
    end
    artist_list.sort.each do |artist|
      puts "#{i}. #{artist}"
      i += 1
    end
  end

  def list_genres
    i = 1
    genre_list = []
    Genre.all.each do |genre|
      genre_list << genre.name
    end
    genre_list.sort.each do |genre|
      puts "#{i}. #{genre}"
      i += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    if Artist.find_by_name(artist_name)
      artist = Artist.find_by_name(artist_name)
      i = 1
      unsorted_song_list = []
      artist.songs.each do |song|
        unsorted_song_list << song.name
      end
      unsorted_song_list.sort.each do |song|
        song_obj = Song.find_by_name(song)
        puts "#{i}. #{song_obj.name} - #{song_obj.genre.name}"
        i += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    if Genre.find_by_name(genre_name)
      i = 1
      unsorted_song_list = []
      genre = Genre.find_by_name(genre_name)
      genre.songs.each do |song|
        unsorted_song_list << song.name
      end
      unsorted_song_list.sort.each do |song|
        song_obj = Song.find_by_name(song)
        puts "#{i}. #{song_obj.artist.name} - #{song_obj.name}"
        i += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    self.list_songs
    user_choice = gets.strip.to_i
    if user_choice.between?(1, Song.all.count)
      puts "Playing "
    end
  end
end
