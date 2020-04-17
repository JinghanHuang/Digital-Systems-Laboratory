//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              Clk,
                      input is_ball_1, is_ball_2, is_opening, is_bomb, is_explosion, is_status, is_grass,
                      input is_tree, is_cursor, is_startbutton, is_ending, is_shoe, is_room,
                      input [9:0] DrawX, DrawY,       // Current pixel coordinates
                      input logic [9:0] cursorX, cursorY,
                      input logic [15:0] Color_Idx, // from SRAM
                      input logic [5:0] player_color_Idx_1, player_color_Idx_2,
                      input logic [4:0] bomb_color_Idx,
                      input logic [3:0] startbutton_color_Idx, end_color_Idx, shoe_color_Idx, room_color_Idx, tree_color_Idx,
                      input logic [2:0] status_color_Idx, explosion_color_Idx,
                      input logic [1:0] grass_color_Idx, cursor_color_Idx,
                      output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );

    always_comb
    begin
        if(DrawX[0] == 0)
            title_Color_Idx = Color_Idx[7:0];
        else
            title_Color_Idx = Color_Idx[15:8];
    end

    logic [7:0] Red, Green, Blue;
    logic [7:0] title_Color_Idx;
    logic [7:0] title_Red, title_Green, title_Blue;
    logic [7:0] cursor_Red, cursor_Green, cursor_Blue;
    logic [7:0] startbutton_Red, startbutton_Green, startbutton_Blue;
    logic [7:0] status_Red, status_Green, status_Blue;
    logic [7:0] ending_Red, ending_Green, ending_Blue;
    logic [7:0] player1_Red, player1_Green, player1_Blue;
    logic [7:0] player2_Red, player2_Green, player2_Blue;
    logic [7:0] room_Red, room_Green, room_Blue;
    logic [7:0] explosion_Red, explosion_Green, explosion_Blue;
    logic [7:0] tree_Red, tree_Green, tree_Blue;
    logic [7:0] shoe_Red, shoe_Green, shoe_Blue;
    logic [7:0] bomb_Red, bomb_Green, bomb_Blue;
    logic [7:0] grass_Red, grass_Green, grass_Blue;

	 // obtain color data from the palette
    title_palette title_palette_ins(.*, .Color_Idx(title_Color_Idx));
    cursor_palette cursor_palette_ins(.*, .Red(cursor_Red), .Green(cursor_Green), .Blue(cursor_Blue));
    startbutton_palette startbutton_palette_ins(.*, .Red(startbutton_Red), .Green(startbutton_Green), .Blue(startbutton_Blue));
    status_palette status_palette_ins(.*, .Red(status_Red), .Green(status_Green), .Blue(status_Blue));
    ending_palette ending_palette_ins(.*, .Red(ending_Red), .Green(ending_Green), .Blue(ending_Blue));
    player1_palette player1_palette_ins(.*, .Red(player1_Red), .Green(player1_Green), .Blue(player1_Blue));
    player2_palette player2_palette_ins(.*, .Red(player2_Red), .Green(player2_Green), .Blue(player2_Blue));
    room_palette room_palette_ins(.*, .Red(room_Red), .Green(room_Green), .Blue(room_Blue));
    explosion_palette explosion_palette_ins(.*, .Red(explosion_Red), .Green(explosion_Green), .Blue(explosion_Blue));
    tree_palette tree_palette_ins(.*, .Red(tree_Red), .Green(tree_Green), .Blue(tree_Blue));
    shoe_palette shoe_palette_ins(.*, .Red(shoe_Red), .Green(shoe_Green), .Blue(shoe_Blue));
    bomb_palette bomb_palette_ins(.*, .Red(bomb_Red), .Green(bomb_Green), .Blue(bomb_Blue));
    grass_palette grass_palette_ins(.*, .Red(grass_Red), .Green(grass_Green), .Blue(grass_Blue));

    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;

    // Assign color based on signals
    always_comb
    begin
          if (is_opening == 1'b1 && !(is_cursor == 1'b1 && cursor_color_Idx != 16'd0) && !(is_startbutton == 1'b1))
          begin
              Red = title_Red;
              Green = title_Green;
              Blue = title_Blue;
          end
          else if(is_cursor == 1'b1 && cursor_color_Idx != 16'd0)
          begin
              Red = cursor_Red;
              Green = cursor_Green;
              Blue = cursor_Blue;
          end
          else if(is_startbutton == 1'b1 && is_opening == 1'b1)
          begin
              Red = cursor_Red;
              Green = cursor_Green;
              Blue = cursor_Blue;
          end
          else if (is_status == 1'b1 && status_color_Idx != 16'd0)
          begin
              Red = status_Red;
              Green = status_Green;
              Blue = status_Blue;
          end
          else if (is_ending == 1'b1 && end_color_Idx != 16'd0)
          begin
              Red = ending_Red;
              Green = ending_Green;
              Blue = ending_Blue;
          end
          else if (is_ball_1 == 1'b1 && player_color_Idx_1 != 16'd0)
          begin
              Red = player1_Red;
              Green = player1_Green;
              Blue = player1_Blue;
          end
          else if (is_ball_2 == 1'b1 && player_color_Idx_2 != 16'd0)
          begin
              Red = player2_Red;
              Green = player2_Green;
              Blue = player2_Blue;
          end
          else if (is_room == 1'b1)
          begin
              Red = room_Red;
              Green = room_Green;
              Blue = room_Blue;
          end
          else if (is_explosion == 1'b1 && explosion_color_Idx != 16'd0)
          begin
              Red = explosion_Red;
              Green = explosion_Green;
              Blue = explosion_Blue;
          end
          else if (is_tree == 1'b1 && tree_color_Idx != 16'd12)
          begin
              Red = tree_Red;
              Green = tree_Green;
              Blue = tree_Blue;
          end
          else if (is_shoe == 1'b1)
          begin
              Red = shoe_Red;
              Green = shoe_Green;
              Blue = shoe_Blue;
          end
          else if (is_bomb == 1'b1 && bomb_color_Idx != 16'd0)
          begin
              Red = bomb_Red;
              Green = bomb_Green;
              Blue = bomb_Blue;
          end
          else if (is_grass == 1'b1)
          begin
              Red = grass_Red;
              Green = grass_Green;
              Blue = grass_Blue;
          end
        else
        begin
            Red = 8'h10;
            Green = 8'h78;
            Blue = 8'h7f - {1'b0, DrawX[9:3]};

            if(DrawY < 10'd31)
            begin
                Red = 8'hF0;
                Green = 8'h80;
                Blue = 8'h00;
            end
            else if(DrawY == 10'd32 || DrawY == 10'd31)
            begin
                Red = 8'h90;
                Green = 8'h0F;
                Blue = 8'h00;
            end
        end
    end
endmodule
