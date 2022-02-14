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


#! get image and its values from the stated path
def get_artwork(path)
    image = Gosu::Image.new(path)
    x_coff = (289.0 / image.width)
    y_coff = (289.0 / image.height)
    art = Artwork.new(image, x_coff, y_coff)
    return art
end