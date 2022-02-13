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

Fancy_Player.new.show()
