module  bomb ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0]   DrawX, DrawY,       // Current pixel coordinates
                input logic [9:0] Ball_X_Pos, Ball_Y_Pos, Ball_X_Pos_2, Ball_Y_Pos_2,
                input logic  is_bomb_place,
                output logic [9:0] Bomb_X_Pos, Bomb_Y_Pos,
                output logic [7:0] can_pass,
                output logic [4:0] bomb_color_Idx,
                output logic [2:0] explosion_color_Idx,
                output logic is_bomb, is_explosion, is_bomb_exist,
                output logic explosion_signal, explosion_start_signal
              );

      parameter [9:0] Bomb_X_Size = 10'd32;
      parameter [9:0] Bomb_Y_Size = 10'd32;

      logic [18:0] bomb_address, explosion_address;
      int bomb_counter;

      // Place bomb based on the position of the player
      always_ff @ (posedge frame_clk)
      begin
            Bomb_X_Pos <= Bomb_X_Pos;
            Bomb_Y_Pos <= Bomb_Y_Pos;
            bomb_counter <= bomb_counter;
            explosion_signal <= 1'b0;
            explosion_start_signal <= 1'b0;

            if(Reset)
            begin
                Bomb_X_Pos <= 10'd0;
                Bomb_Y_Pos <= 10'd0;
                bomb_counter <= 0;
            end
            else if(is_bomb_place)
            begin
                Bomb_X_Pos <= Ball_X_Pos;
                Bomb_Y_Pos <= Ball_Y_Pos;
                bomb_counter <= 180;
            end
            else if(is_bomb_exist == 1'b0)
            begin
                Bomb_X_Pos <= 10'd0;
                Bomb_Y_Pos <= 10'd0;
            end

            if(bomb_counter > 0)
                bomb_counter <= bomb_counter - 1;

            if(bomb_counter == 1)
                explosion_signal <= 1'b1;

            if(bomb_counter == 1)
                explosion_start_signal <= 1'b1;
        end


        always_comb begin
            if(bomb_counter > 0)
                is_bomb_exist = 1'b1;
            else
                is_bomb_exist = 1'b0;
        end

        /**************************************************************/
        /************************ Drawing Part ************************/
        /**************************************************************/

        int DistX, DistY, X_Size, Y_Size;
        assign DistX = DrawX - Bomb_X_Pos;
        assign DistY = DrawY - Bomb_Y_Pos;
        assign X_Size = Bomb_X_Size;
        assign Y_Size = Bomb_Y_Size;

        int DistX_ex, DistY_ex, X_Size_ex, Y_Size_ex;
        assign DistX_ex = DrawX - (Bomb_X_Pos - 10'd32);
        assign DistY_ex = DrawY - (Bomb_Y_Pos - 10'd32);
        assign X_Size_ex = 10'd96;
        assign Y_Size_ex = 10'd96;

        always_comb begin
             if (bomb_counter > 30 && is_bomb_exist == 1'b1 && DistX < X_Size && DistX > 0 && DistY < Y_Size && DistY > 0)
                is_bomb = 1'b1;
             else
                is_bomb = 1'b0;

             if (bomb_counter <= 30 && bomb_counter > 0 && DistX_ex < X_Size_ex && DistX_ex > 0 && DistY_ex < Y_Size_ex && DistY_ex > 0)
                is_explosion = 1'b1;
             else
                is_explosion = 1'b0;
        end

        // Bomb Animation
        always_comb begin
            bomb_address = 0;
            explosion_address = 0;

            if(bomb_counter > 150 &&  bomb_counter <= 180)
                bomb_address = (DrawX - Bomb_X_Pos) + (DrawY - Bomb_Y_Pos)*32;
            else if(bomb_counter > 120 &&  bomb_counter <= 150)
                bomb_address = 32*32 + (DrawX - Bomb_X_Pos) + (DrawY - Bomb_Y_Pos)*32;
            else if(bomb_counter > 90 &&  bomb_counter <= 120)
                bomb_address = 32*32*2 + (DrawX - Bomb_X_Pos) + (DrawY - Bomb_Y_Pos)*32;
            else if(bomb_counter > 60 &&  bomb_counter <= 90)
                bomb_address = 32*32 + (DrawX - Bomb_X_Pos) + (DrawY - Bomb_Y_Pos)*32;
            else if(bomb_counter > 30 &&  bomb_counter <= 60)
                bomb_address = (DrawX - Bomb_X_Pos) + (DrawY - Bomb_Y_Pos)*32;

            if(bomb_counter > 24 &&  bomb_counter <= 30)
                explosion_address = (DrawX - (Bomb_X_Pos - 10'd32)) + (DrawY - (Bomb_Y_Pos - 10'd32))*96;
            else if(bomb_counter > 18 &&  bomb_counter <= 24)
                explosion_address = 96*96 + (DrawX - (Bomb_X_Pos - 10'd32)) + (DrawY - (Bomb_Y_Pos - 10'd32))*96;
            else if(bomb_counter > 12 &&  bomb_counter <= 18)
                explosion_address = 96*96*2 + (DrawX - (Bomb_X_Pos - 10'd32)) + (DrawY - (Bomb_Y_Pos - 10'd32))*96;
            else if(bomb_counter > 6 &&  bomb_counter <= 12)
                explosion_address = 96*96*3 + (DrawX - (Bomb_X_Pos - 10'd32)) + (DrawY - (Bomb_Y_Pos - 10'd32))*96;
            else if(bomb_counter > 0 &&  bomb_counter <= 6)
                explosion_address = 96*96*4 + (DrawX - (Bomb_X_Pos - 10'd32)) + (DrawY - (Bomb_Y_Pos - 10'd32))*96;
        end

        bombRAM bombOCM(.read_address(bomb_address), .Clk, .data_Out(bomb_color_Idx));
        explosionRAM explosionOCM(.read_address(explosion_address), .Clk, .data_Out(explosion_color_Idx));

        // Collision Detection
        always_comb
        begin
            can_pass[0] = !(Ball_X_Pos == Bomb_X_Pos && Ball_Y_Pos == Bomb_Y_Pos + 10'd32); // up
            can_pass[1] = !(Ball_X_Pos == Bomb_X_Pos && Ball_Y_Pos + 10'd32 == Bomb_Y_Pos); // down
            can_pass[2] = !(Ball_X_Pos == Bomb_X_Pos + 10'd32 && Ball_Y_Pos == Bomb_Y_Pos); // left
            can_pass[3] = !(Ball_X_Pos + 10'd32 == Bomb_X_Pos && Ball_Y_Pos == Bomb_Y_Pos); //right

            can_pass[4] = !(Ball_X_Pos_2 == Bomb_X_Pos && Ball_Y_Pos_2 == Bomb_Y_Pos + 10'd32); // up
            can_pass[5] = !(Ball_X_Pos_2 == Bomb_X_Pos && Ball_Y_Pos_2 + 10'd32 == Bomb_Y_Pos); // down
            can_pass[6] = !(Ball_X_Pos_2 == Bomb_X_Pos + 10'd32 && Ball_Y_Pos_2 == Bomb_Y_Pos); // left
            can_pass[7] = !(Ball_X_Pos_2 + 10'd32 == Bomb_X_Pos && Ball_Y_Pos_2 == Bomb_Y_Pos); //right
        end

endmodule
