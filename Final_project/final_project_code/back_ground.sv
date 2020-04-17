module  back_ground ( input  Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0]   DrawX, DrawY,       // Current pixel coordinates
                input logic [9:0] Ball_X_Pos, Ball_Y_Pos, Ball_X_Pos_2, Ball_Y_Pos_2, // Position of players
                input logic space_pressed, zero_pressed, r_pressed,
                input logic is_ending_exist,
                output logic [9:0] Bomb_X_Pos, Bomb_Y_Pos, Bomb_X_Pos_2, Bomb_Y_Pos_2,
                output logic [4:0] bomb_color_Idx,
                output logic [3:0] tree_color_Idx, room_color_Idx, shoe_color_Idx,
                output logic [2:0] explosion_color_Idx,
                output logic [1:0] grass_color_Idx,
                output logic [7:0] can_pass,
                output logic speed_up_1, speed_up_2,
                output logic is_bomb_place, is_bomb_place_2,
                output logic is_back, is_room, is_tree, is_bomb, is_shoe, is_explosion, is_grass,
                output logic explosion_signal, explosion_signal_2, explosion_start_signal, explosion_start_signal_2
              );

        // The orignal 20 * 14 map (width * height)
        // 3'h0 - grass (open space)
        // 3'h1 - tree (destructible stump)
        // 3'h2 - room (nondestructible house)
        // 3'h3 - shoe
        // 3'h4 - stump with shoe
        parameter[0:20*14-1][2:0] original_map = {
            3'h0, 3'h0, 3'h1, 3'h0, 3'h0, 3'h4, 3'h0, 3'h0, 3'h0, 3'h1, 3'h1, 3'h0, 3'h0, 3'h1, 3'h0, 3'h4, 3'h0, 3'h1, 3'h0, 3'h0,
            3'h0, 3'h2, 3'h2, 3'h2, 3'h1, 3'h2, 3'h1, 3'h2, 3'h2, 3'h0, 3'h0, 3'h2, 3'h2, 3'h1, 3'h2, 3'h0, 3'h2, 3'h2, 3'h2, 3'h0,
            3'h0, 3'h2, 3'h0, 3'h2, 3'h0, 3'h2, 3'h0, 3'h0, 3'h0, 3'h1, 3'h1, 3'h0, 3'h1, 3'h0, 3'h2, 3'h1, 3'h2, 3'h1, 3'h2, 3'h0,
            3'h1, 3'h2, 3'h1, 3'h2, 3'h2, 3'h2, 3'h1, 3'h2, 3'h1, 3'h2, 3'h2, 3'h1, 3'h2, 3'h0, 3'h2, 3'h2, 3'h2, 3'h0, 3'h2, 3'h1,
            3'h0, 3'h0, 3'h0, 3'h4, 3'h1, 3'h0, 3'h0, 3'h1, 3'h1, 3'h0, 3'h0, 3'h4, 3'h1, 3'h0, 3'h1, 3'h0, 3'h4, 3'h1, 3'h1, 3'h1,
            3'h0, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h0, 3'h1, 3'h2, 3'h2, 3'h1, 3'h0, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h0,
            3'h0, 3'h2, 3'h1, 3'h0, 3'h0, 3'h2, 3'h2, 3'h4, 3'h0, 3'h0, 3'h0, 3'h0, 3'h1, 3'h2, 3'h2, 3'h1, 3'h0, 3'h0, 3'h2, 3'h1,
            3'h0, 3'h0, 3'h0, 3'h2, 3'h0, 3'h1, 3'h1, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h0, 3'h1, 3'h0, 3'h0, 3'h2, 3'h0, 3'h1, 3'h0,
            3'h1, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h1, 3'h1, 3'h2, 3'h2, 3'h1, 3'h0, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h2, 3'h4,
            3'h0, 3'h4, 3'h1, 3'h0, 3'h1, 3'h0, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0, 3'h0, 3'h1, 3'h4, 3'h1, 3'h0, 3'h1, 3'h1, 3'h0, 3'h0,
            3'h0, 3'h2, 3'h1, 3'h2, 3'h2, 3'h2, 3'h0, 3'h2, 3'h1, 3'h2, 3'h2, 3'h1, 3'h2, 3'h0, 3'h2, 3'h2, 3'h2, 3'h0, 3'h2, 3'h1,
            3'h1, 3'h2, 3'h0, 3'h2, 3'h0, 3'h2, 3'h0, 3'h0, 3'h1, 3'h1, 3'h1, 3'h4, 3'h1, 3'h0, 3'h2, 3'h0, 3'h2, 3'h1, 3'h2, 3'h1,
            3'h0, 3'h2, 3'h2, 3'h2, 3'h0, 3'h2, 3'h0, 3'h2, 3'h2, 3'h1, 3'h0, 3'h2, 3'h2, 3'h1, 3'h2, 3'h1, 3'h2, 3'h2, 3'h2, 3'h0,
            3'h0, 3'h0, 3'h4, 3'h1, 3'h1, 3'h0, 3'h4, 3'h1, 3'h0, 3'h0, 3'h0, 3'h1, 3'h0, 3'h1, 3'h0, 3'h0, 3'h1, 3'h0, 3'h0, 3'h0,
        };

        parameter [9:0] Back_X_Min = 10'd0;
        parameter [9:0] Back_X_Max = 10'd639;
        parameter [9:0] Back_Y_Min = 10'd32;
        parameter [9:0] Back_Y_Max = 10'd479;
        parameter [9:0] Unit_Size = 10'd32;

        logic [0:20*14-1][2:0] map, map_in;
        logic speed_up_1_in, speed_up_2_in;


        /*****************************************************************/
        /************************ Map Update Part ************************/
        /*****************************************************************/

        // Update map
        always_ff @ (posedge frame_clk)
        begin
            if(Reset)
                map <= original_map;
            else if(r_pressed && is_ending_exist == 1'b1)
                map <= original_map;
            else
                map <= map_in;
        end

        // Update speed up state
        always_ff @ (posedge Clk)
        begin
            if(Reset)
            begin
                speed_up_1 <= 1'b0;
                speed_up_2 <= 1'b0;
            end
            else
            begin
                speed_up_1 <= speed_up_1_in;
                speed_up_2 <= speed_up_2_in;
            end
        end

        always_comb
        begin
            map_in = map;
            speed_up_1_in = 1'b0;
            speed_up_2_in = 1'b0;

            // Check picking up shoes
            if(map[player_1_index] ==  4'h3)
            begin
                speed_up_1_in = 1'b1;
                map_in[player_1_index] = 4'h0;
            end

            if(map[player_2_index] ==  4'h3)
            begin
                speed_up_2_in = 1'b1;
                map_in[player_2_index] = 4'h0;
            end

            // Check explosion of the bomb
            if(explosion_signal)
            begin
                if(map[bomb_1_index] == 4'h1)
                    map_in[bomb_1_index] = 4'h0;
                if((bomb_1_index % 20 != 0) && map[bomb_1_index - 1] == 4'h1)
                    map_in[bomb_1_index - 1] = 4'h0;
                if((bomb_1_index % 20 != 19) && map[bomb_1_index + 1] == 4'h1)
                    map_in[bomb_1_index + 1] = 4'h0;
                if((bomb_1_index >= 20) && map[bomb_1_index - 20] == 4'h1)
                    map_in[bomb_1_index - 20] = 4'h0;
                if((bomb_1_index < 20*13) && map[bomb_1_index + 20] == 4'h1)
                    map_in[bomb_1_index + 20] = 4'h0;

                if(map[bomb_1_index] == 4'h4)
                    map_in[bomb_1_index] = 4'h3;
                if((bomb_1_index % 20 != 0) && map[bomb_1_index - 1] == 4'h4)
                    map_in[bomb_1_index - 1] = 4'h3;
                if((bomb_1_index % 20 != 19) && map[bomb_1_index + 1] == 4'h4)
                    map_in[bomb_1_index + 1] = 4'h3;
                if((bomb_1_index >= 20) && map[bomb_1_index - 20] == 4'h4)
                    map_in[bomb_1_index - 20] = 4'h3;
                if((bomb_1_index < 20*13) && map[bomb_1_index + 20] == 4'h4)
                    map_in[bomb_1_index + 20] = 4'h3;
            end

            if(explosion_signal_2)
            begin
                if(map[bomb_2_index] == 4'h1)
                    map_in[bomb_2_index] = 4'h0;
                if((bomb_2_index % 20 != 0) && map[bomb_2_index - 1] == 4'h1)
                    map_in[bomb_2_index - 1] = 4'h0;
                if((bomb_2_index % 20 != 19) && map[bomb_2_index + 1] == 4'h1)
                    map_in[bomb_2_index + 1] = 4'h0;
                if((bomb_2_index >= 20) && map[bomb_2_index - 20] == 4'h1)
                    map_in[bomb_2_index - 20] = 4'h0;
                if((bomb_2_index < 20*13) && map[bomb_2_index + 20] == 4'h1)
                    map_in[bomb_2_index + 20] = 4'h0;

                if(map[bomb_2_index] == 4'h4)
                    map_in[bomb_2_index] = 4'h3;
                if((bomb_2_index % 20 != 0) && map[bomb_2_index - 1] == 4'h4)
                    map_in[bomb_2_index - 1] = 4'h3;
                if((bomb_2_index % 20 != 19) && map[bomb_2_index + 1] == 4'h4)
                    map_in[bomb_2_index + 1] = 4'h3;
                if((bomb_2_index >= 20) && map[bomb_2_index - 20] == 4'h4)
                    map_in[bomb_2_index - 20] = 4'h3;
                if((bomb_2_index < 20*13) && map[bomb_2_index + 20] == 4'h4)
                    map_in[bomb_2_index + 20] = 4'h3;
            end
        end

        // Calculate the index of player and bomb in the map
        int Size;
        assign Size = Unit_Size;
        logic [18:0] read_address;
        int map_index, bomb_1_index, bomb_2_index, player_1_index, player_2_index;
        always_comb begin
            map_index = (DrawX) / Size + ((DrawY - 10'd32)/Size) * 20;
            bomb_1_index = (Bomb_X_Pos) / Size + ((Bomb_Y_Pos - 10'd32)/Size) * 20;
            bomb_2_index = (Bomb_X_Pos_2) / Size + ((Bomb_Y_Pos_2 - 10'd32)/Size) * 20;
            player_1_index = (Ball_X_Pos) / Size + ((Ball_Y_Pos - 10'd32)/Size) * 20;
            player_2_index = (Ball_X_Pos_2) / Size + ((Ball_Y_Pos_2 - 10'd32)/Size) * 20;
        end


        /*****************************************************************/
        /************************ Map Drawing Part ***********************/
        /*****************************************************************/
        always_comb begin
            is_room = 1'b0;
            is_tree = 1'b0;
            is_shoe = 1'b0;

            if (DrawY > 10'd32 && map[map_index] == 4'h3)
                is_shoe = 1'b1;

            if (DrawY > 10'd32 && map[map_index] == 4'h2)
                 is_room = 1'b1;

            if (DrawY > 10'd32 && (map[map_index] == 4'h1 || map[map_index] == 4'h4))
                 is_tree = 1'b1;

            read_address = (DrawX) % Size + ((DrawY - 10'd32)% Size) * Size;
        end

        treeRAM treeOCM(.read_address, .Clk, .data_Out(tree_color_Idx));
        roomRAM roomOCM(.read_address, .Clk, .data_Out(room_color_Idx));
        shoeRAM shoeOCM(.read_address, .Clk, .data_Out(shoe_color_Idx));

        // grass interface
        grass grass_ins(.*);

        always_comb
        begin
            is_bomb = is_bomb_1 || is_bomb_2;
            is_explosion = is_explosion_1 || is_explosion_2;
            bomb_color_Idx = 0;
            explosion_color_Idx = 0;

            if(is_bomb_1)
            begin
                bomb_color_Idx = bomb_color_Idx_1;
            end
            else if(is_bomb_2)
            begin
                bomb_color_Idx = bomb_color_Idx_2;
            end

            if(is_explosion_1)
            begin
                explosion_color_Idx = explosion_color_Idx_1;
            end
            else if(is_explosion_2)
            begin
                explosion_color_Idx = explosion_color_Idx_2;
            end
        end

        /*************************************************************************/
        /************************ Collision detection Part ***********************/
        /*************************************************************************/

        logic [7:0] can_pass_map;
        logic [7:0] can_pass_bomb, can_pass_bomb_2;
        always_comb
        begin
            can_pass_map[0] = (map[(Ball_X_Pos/Size) + ((Ball_Y_Pos - 10'd32)/Size - 1)* 20] == 4'h0) || (map[(Ball_X_Pos/Size) + ((Ball_Y_Pos - 10'd32)/Size - 1)* 20] == 4'h3);
            can_pass_map[1] = (map[(Ball_X_Pos/Size) + ((Ball_Y_Pos - 10'd32)/Size + 1)* 20] == 4'h0) || (map[(Ball_X_Pos/Size) + ((Ball_Y_Pos - 10'd32)/Size + 1)* 20] == 4'h3);
            can_pass_map[2] = (map[(Ball_X_Pos/Size) - 1 + (Ball_Y_Pos - 10'd32)/Size * 20] == 4'h0) || (map[(Ball_X_Pos/Size) - 1 + (Ball_Y_Pos - 10'd32)/Size * 20] == 4'h3);
            can_pass_map[3] = (map[(Ball_X_Pos/Size) + 1 + (Ball_Y_Pos - 10'd32)/Size * 20] == 4'h0) || (map[(Ball_X_Pos/Size) + 1 + (Ball_Y_Pos - 10'd32)/Size * 20] == 4'h3);
            can_pass_map[4] = (map[(Ball_X_Pos_2/Size) + ((Ball_Y_Pos_2 - 10'd32)/Size - 1)* 20] == 4'h0) || (map[(Ball_X_Pos_2/Size) + ((Ball_Y_Pos_2 - 10'd32)/Size - 1)* 20] == 4'h3);
            can_pass_map[5] = (map[(Ball_X_Pos_2/Size) + ((Ball_Y_Pos_2 - 10'd32)/Size + 1)* 20] == 4'h0) || (map[(Ball_X_Pos_2/Size) + ((Ball_Y_Pos_2 - 10'd32)/Size + 1)* 20] == 4'h3);
            can_pass_map[6] = (map[(Ball_X_Pos_2/Size) - 1 + (Ball_Y_Pos_2 - 10'd32)/Size * 20] == 4'h0) || (map[(Ball_X_Pos_2/Size) - 1 + (Ball_Y_Pos_2 - 10'd32)/Size * 20] == 4'h3);
            can_pass_map[7] = (map[(Ball_X_Pos_2/Size) + 1 + (Ball_Y_Pos_2 - 10'd32)/Size * 20] == 4'h0) || (map[(Ball_X_Pos_2/Size) + 1 + (Ball_Y_Pos_2 - 10'd32)/Size * 20] == 4'h3);
        end

        assign can_pass[0] = !(Ball_X_Pos == Ball_X_Pos_2 && Ball_Y_Pos ==  Ball_Y_Pos_2 + 10'd32) && can_pass_bomb[0] && can_pass_bomb_2[4] && can_pass_map[0];
        assign can_pass[1] = !(Ball_X_Pos == Ball_X_Pos_2 && Ball_Y_Pos + 10'd32 ==  Ball_Y_Pos_2) && can_pass_bomb[1] && can_pass_bomb_2[5] && can_pass_map[1];
        assign can_pass[2] = !(Ball_X_Pos == Ball_X_Pos_2 + 10'd32 && Ball_Y_Pos ==  Ball_Y_Pos_2) && can_pass_bomb[2] && can_pass_bomb_2[6] && can_pass_map[2];
        assign can_pass[3] = !(Ball_X_Pos + 10'd32 == Ball_X_Pos_2 && Ball_Y_Pos ==  Ball_Y_Pos_2) && can_pass_bomb[3] && can_pass_bomb_2[7] && can_pass_map[3];
        assign can_pass[4] = !(Ball_X_Pos == Ball_X_Pos_2 && Ball_Y_Pos + 10'd32 ==  Ball_Y_Pos_2) && can_pass_bomb[4] && can_pass_bomb_2[0] && can_pass_map[4];
        assign can_pass[5] = !(Ball_X_Pos == Ball_X_Pos_2 && Ball_Y_Pos ==  Ball_Y_Pos_2 + 10'd32) && can_pass_bomb[5] && can_pass_bomb_2[1] && can_pass_map[5];
        assign can_pass[6] = !(Ball_X_Pos + 10'd32 == Ball_X_Pos_2 && Ball_Y_Pos ==  Ball_Y_Pos_2) && can_pass_bomb[6] && can_pass_bomb_2[2] && can_pass_map[6];
        assign can_pass[7] = !(Ball_X_Pos == Ball_X_Pos_2 + 10'd32 && Ball_Y_Pos ==  Ball_Y_Pos_2) && can_pass_bomb[7] && can_pass_bomb_2[3] && can_pass_map[7];


        /***********************************************************/
        /************************ Bomb Part ************************/
        /***********************************************************/

        logic is_bomb_1, is_bomb_2;
        logic is_explosion_1, is_explosion_2;
        logic [4:0] bomb_color_Idx_1, bomb_color_Idx_2;
        logic [2:0] explosion_color_Idx_1, explosion_color_Idx_2;
        logic is_bomb_exist, is_bomb_exist_2;

        bomb bomb_instance(.*, .is_explosion(is_explosion_1), .is_bomb(is_bomb_1), .can_pass(can_pass_bomb),
                                    .bomb_color_Idx(bomb_color_Idx_1), .explosion_color_Idx(explosion_color_Idx_1));
        bomb bomb_instance_2(.*, .Ball_X_Pos(Ball_X_Pos_2), .Ball_Y_Pos(Ball_Y_Pos_2),
                                    .Ball_X_Pos_2(Ball_X_Pos), .Ball_Y_Pos_2(Ball_Y_Pos),
                                    .is_bomb_exist(is_bomb_exist_2), .is_explosion(is_explosion_2),
                                    .is_bomb(is_bomb_2), .is_bomb_place(is_bomb_place_2),
                                    .Bomb_X_Pos(Bomb_X_Pos_2), .Bomb_Y_Pos(Bomb_Y_Pos_2),
                                    .can_pass(can_pass_bomb_2), .explosion_signal(explosion_signal_2),
                                    .bomb_color_Idx(bomb_color_Idx_2), .explosion_color_Idx(explosion_color_Idx_2), .explosion_start_signal(explosion_start_signal_2));

        always_ff @ (posedge frame_clk)
        begin
            is_bomb_place <= 1'b0;
            is_bomb_place_2 <= 1'b0;

            if(space_pressed && !is_ending_exist)
            begin
                if(is_bomb_exist == 1'b0)
                begin
                    is_bomb_place <= 1'b1;
                end
            end

            if(zero_pressed && !is_ending_exist)
            begin
                if(is_bomb_exist_2 == 1'b0)
                begin
                    is_bomb_place_2 <= 1'b1;
                end
            end
        end

endmodule
