#!/usr/bin/env ruby
require 'gosu'
require './backend.rb'
require './display.rb'

PATH = "./album.txt" #* hardcoded this since we dont have to prompt user for their input

class Fancy_Player < Gosu::Window
    def initialize()
        super 720, 480, false
        self.caption = "(ง ื▿ ื)ว Gosu Music Player▁ ▂ ▃ ▄"
        @selected_album = @selected_song = -1
        @show_menu = [false, false] #? [0] is menu of album list, [1] is menu of track list
        @music_running = false
        @album_list = read_album_list(PATH)
    end

    def needs_cursor?
        true
    end

    def update()
        @show_menu[1] = true if @selected_album >= 0
        @show_menu[1] = false if @show_menu[0] == false
        if (@now_playing_data != [@selected_album, @selected_song]) && (@selected_song >= 0)
            @now_playing_data = [@selected_album, @selected_song]
            @selected_song = -1; @selected_album = -1
            @show_menu[1] = false
            @music_running = true
            @album_list[@now_playing_data[0]].tracks[@now_playing_data[1]].path.play()
        end

        @now_playing_data = track_order(@now_playing_data, @album_list) if @now_playing_data != nil
    end

    def draw()
    end

    def button_down(id)
    end
end 

Fancy_Player.new.show()
