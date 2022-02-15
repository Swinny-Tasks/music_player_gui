#!/usr/bin/env ruby

class Album
    attr_accessor :title, :artist, :genre, :artwork ,:tracks
    def initialize(title, artist, genre, artwork, tracks)
        @title = title
        @artist = artist
        @artwork = artwork
        @tracks = tracks
        @genre = genre
    end
end

class Track
    attr_accessor :title, :path
    def initialize(title, path)
        @title = title
        @path = path
    end
end

class Artwork
    attr_accessor :cover_image, :x_coff, :y_coff
    def initialize(cover_image, x_coff, y_coff)
        @cover_image = cover_image
        @x_coff = x_coff
        @y_coff = y_coff
    end
end

#! returns a single album from the file in form of a class instance
def album_data(file)
    album_first_name = file.readline().chomp()
    artist_first_name = file.readline().chomp()
    genre = file.readline().chomp()

    artwork_path = file.readline().chomp()
    artwork = get_artwork(artwork_path)

    tracks = Array.new()
    track_number = file.readline().to_i()
    track_number.times{
        single_track_name = file.readline().chomp()
        single_track_location = file.readline().chomp()
        single_track_path = Gosu::Song.new(single_track_location)
        tracks.push(Track.new(single_track_name, single_track_path))
    }
    album = Album.new(album_first_name, artist_first_name, genre, artwork ,tracks)
    return album
end

#! get image and its values from the stated path
def get_artwork(path)
    image = Gosu::Image.new(path)
    x_coff = (289.0 / image.width)
    y_coff = (289.0 / image.height)
    art = Artwork.new(image, x_coff, y_coff)
    return art
end

#! returns array of all albums there in the file
def read_album_list(path)
    album_list = Array.new()
    File.open(path, "r") do |file|
        number_of_albums = file.readline.to_i()
        number_of_albums.times{
            single_album = album_data(file)
            album_list.push(single_album)
        }; end
    return album_list
end

#! adds whitespace to make text center align for the given line length
def make_center(text, line_size)
    space_before = space_after = (line_size - text.size())/2
    space_before += 1 if text.size() % 2 != 0
    space_before.times {text = " " + text}
    space_after.times {text = text + " "}
    return text
end