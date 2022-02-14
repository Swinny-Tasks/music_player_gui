#!/usr/bin/env ruby

#! window background and sliders
def display_basic_layout(mouse_x, mouse_y, condition)
    # base rectangle
    Gosu.draw_rect(0, 0, 720, 480, 0xff_121212, 0)
        
    # left slider
    if mouse_over_element(mouse_x, mouse_y, "left_slider") && !condition
        slider_l_color = 0xff_FF9777
    else
        slider_l_color = 0xff_707070
    end
    draw_quad(140, 105, slider_l_color, 265, 138, slider_l_color, 140, 344, slider_l_color, 265, 311, slider_l_color, 0)
    
    # right slider
    if mouse_over_element(mouse_x, mouse_y, "right_slider") && !condition
        slider_r_color = 0xff_77FF77
    else 
        slider_r_color = 0xff_707070
    end
    draw_quad(433, 138, slider_r_color, 555, 105, slider_r_color, 433, 311, slider_r_color, 555, 344, slider_r_color, 0)

    #top left button
    i = 0; 3.times{
        if mouse_over_element(mouse_x, mouse_y, "menu") then menu_color = 0xff_cca328 else menu_color = 0xff_fff9ea; end
        Gosu.draw_rect(9, (10+i), 21, 3, menu_color, 0)
    i += 7}
end

#! makes background quite darker when menu's being shown
def background_fade()
    Gosu.draw_rect(0, 0, 720, 480, 0x90_000000, 2)
end

#! shows all album list
def display_album_list(album_list)
    #! can show max 9 albums at once.
    background_fade()
    Gosu.draw_rect(40, 8, 225, 450, 0xff_181818, 3)
    (Gosu::Font.new(25)).draw_text("albums", 50, 20, 4, 1.0, 1.0, 0xff_ffffff)
    for i in (0...album_list.size())
        draw_line(45, 95+(45*i), 0xff_535353, 260, 95+(45*i), 0xff_535353, 4)
        (Gosu::Font.new(17)).draw_text("#{i+1}. #{album_list[i].title}", 50, (55 + (45*i)), 4, 1, 1, 0xff_ffffff)
        (Gosu::Font.new(15)).draw_text("#{album_list[i].artist} • #{album_list[i].genre}", 50, (75 + (45*i)), 4, 1, 1, 0xff_6f6f6f)
    end
end

#! shows track list menu for the selected album
def display_track_list(track_list)#, album_list, start_index)
    Gosu.draw_rect(276, 8, 225, 450, 0xff_181818, 3)
    (Gosu::Font.new(25)).draw_text("songs", 290, 20, 4, 1.0, 1.0, 0xff_ffffff)
    for i in (0...track_list.size())
        draw_line(285, 75+(25*i), 0xff_535353, 490, 75+(25*i), 0xff_535353, 4)
        (Gosu::Font.new(17)).draw_text("#{i+1}: #{track_list[i].title}", 290, (55 + (25*i)), 4, 1, 1, 0xff_ffffff)
    end
end

#! shows playing track's information on screen
def display_playing_track(album_list, data)
    track_title = album_list[data[0]].tracks[data[1]].title
    down_info = album_list[data[0]].artist + " • "
    down_info += album_list[data[0]].title + " • "
    down_info += album_list[data[0]].genre

    (Gosu::Font.new(25)).draw_text(track_title, 206, 375, 1, 1, 1, 0xff_70f070)
    (Gosu::Font.new(15)).draw_text(down_info, 206, 400, 1, 1, 1, 0xff_707070)
end

#! shows album art when some song's playing (or paused)
def display_art(display_data, album_list)
    album_list[display_data[0]].artwork.cover_image.draw(207, 80, 1, album_list[display_data[0]].artwork.x_coff , album_list[display_data[0]].artwork.y_coff)
    display_playing_track(album_list ,display_data)
end
