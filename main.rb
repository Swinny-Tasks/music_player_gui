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
        display_basic_layout(mouse_x, mouse_y, @show_menu[0])
        display_album_list(@album_list) if @show_menu[0]
        display_track_list(@album_list[@selected_album].tracks) if @show_menu[1] #&& (not @music_running)
        if @music_running then display_art(@now_playing_data, @album_list) else nothing_playing(); end
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        when Gosu::MS_LEFT
            track_clicked = track_selected(@album_list[@selected_album].tracks, mouse_y, mouse_x) if (@show_menu[1])
            @selected_song = track_clicked if (276...531).include?(mouse_x) && track_clicked != nil
            if @show_menu[0]
                album_clicked = album_selected(@album_list, mouse_y)
                @selected_album = album_clicked if (40...265).include?(mouse_x)
                @show_menu[0] = mouse_over_element(mouse_x, mouse_y, "album_list")
            end
        end
    end
end

Fancy_Player.new.show()
