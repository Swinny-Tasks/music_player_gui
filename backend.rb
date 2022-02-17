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

#! checks if mouse is over the specified program element
def mouse_over_element(x, y, element)
    case element
    when "right_slider"
        x_values = [495, 555]
        y_values = [104, 343]
    when "left_slider"
        x_values = [143, 206]
        y_values = [104, 343]
    when "menu"
        x_values = [9, 30]
        y_values = [10, 27]
    when "album_list"
        x_values = [40, 265]
        y_values = [8, 458]
    when "track_list"
        x_values = [276, 501]
        y_values = [8, 458]
    when "artwork"
        x_values = [207, 496]
        y_values = [80, 369]
    end
    return (x_values[0]...x_values[1]).include?(mouse_x) && (y_values[0]...y_values[1]).include?(mouse_y)
end

#! album selected from the list
def album_selected(album_list, y)
    for i in (0...album_list.size())
        album_row = (50 + (45*i))
        return i if (album_row...(album_row+44)).include?(y)
    end
    #? if click isn't on anything
    return -1
end

#! track selected from the list
def track_selected(track_list, y, x)
    for i in (0...track_list.size())
        track_row = (50 + (25*i))
        return i if (track_row...(track_row+24)).include?(y)
    end
    #? if click isn't on anything
    return -1
end

#! skip forward or backward a track
def change_track(data, album_list, action)
    if action == 1
        if album_list[data[0]].tracks.size() > data[1] + 1
            data[1] += 1
        else
            if (album_list.size() > data[0] + 1) then (data[0] += 1) else (data[0] = 0); end
            data[1] = 0
        end
    else
        if data[1] == 0
            if (data[0] == 0) then (data[0] = album_list.size() -1) else (data[0] -= 1); end
            data[1] = album_list[data[0]].tracks.size() -1
        else 
            data[1] -= 1
        end
    end
    return data
end

#! if song's playing then pause it, if its paused then play it
def pause_toggle(running_song)
    if running_song.paused? then running_song.play() else running_song.pause(); end
end

