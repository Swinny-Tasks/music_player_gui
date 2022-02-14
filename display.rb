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

