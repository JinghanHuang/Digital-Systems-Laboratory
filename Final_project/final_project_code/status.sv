module status( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0]  DrawX, DrawY,       // Current pixel coordinates
                input logic [9:0] Ball_X_Pos, Ball_Y_Pos, Ball_X_Pos_2, Ball_Y_Pos_2,
                input logic [9:0] Bomb_X_Pos, Bomb_Y_Pos, Bomb_X_Pos_2, Bomb_Y_Pos_2,
                input logic explosion_signal, explosion_signal_2, is_opening, r_pressed,
                output logic is_status,
                output logic [2:0] status_color_Idx,
                output logic white_win, black_win, tie, is_ending_exist
              );

        parameter [9:0] Num_X_Pos_1 = 10'd288;
        parameter [9:0] Num_Y_Pos_1 = 10'd1;
        parameter [9:0] Num_X_Pos_2 = 10'd304;
        parameter [9:0] Num_Y_Pos_2 = 10'd1;
        parameter [9:0] Num_X_Pos_3 = 10'd320;
        parameter [9:0] Num_Y_Pos_3 = 10'd1;
        parameter [9:0] Num_X_Pos_4 = 10'd336;
        parameter [9:0] Num_Y_Pos_4 = 10'd1;
        parameter [9:0] Num_X_Size = 10'd16;
        parameter [9:0] Num_Y_Size = 10'd28;

        parameter [9:0] Head_X_Pos_1 = 10'd114;
        parameter [9:0] Head_Y_Pos_1 = 10'd1;
        parameter [9:0] Num_X_Pos_5 = 10'd144;
        parameter [9:0] Num_Y_Pos_5 = 10'd1;
        parameter [9:0] Head_X_Pos_2 = 10'd450;
        parameter [9:0] Head_Y_Pos_2 = 10'd1;
        parameter [9:0] Num_X_Pos_6 = 10'd480;
        parameter [9:0] Num_Y_Pos_6 = 10'd1;
        parameter [9:0] Head_X_Size = 10'd28;
        parameter [9:0] Head_Y_Size = 10'd28;

        logic [2:0] num_color_Idx, head_color_Idx;
        logic [18:0] num_address, head_address;
        logic is_num, is_head;
        byte minute, second_1, second_2, time_counter;
        byte life_count_1, life_count_2;

        /********************************************************************/
        /************* Explision Detection and Game Status Part *************/
        /********************************************************************/

        always_ff @ (posedge frame_clk)
        begin
            if (Reset)
            begin
                life_count_1 <= 3;
                life_count_2 <= 3;
                is_ending_exist <= 1'b0;
                white_win <= 1'b0;
                black_win <= 1'b0;
                tie <= 1'b0;
            end
            else if(r_pressed && is_ending_exist == 1'b1)
            begin
                life_count_1 <= 3;
                life_count_2 <= 3;
                is_ending_exist <= 1'b0;
                white_win <= 1'b0;
                black_win <= 1'b0;
                tie <= 1'b0;
            end
            else
            begin
                life_count_1 <= life_count_1;
                life_count_2 <= life_count_2;
                is_ending_exist <= is_ending_exist;
                white_win <= white_win;
                black_win <= black_win;
                tie <= tie;

                // Game End Status
                if(life_count_1 == 0)
                begin
                    is_ending_exist <= 1'b1;
                    black_win <= 1'b1;
                end

                if(life_count_2 == 0)
                begin
                    is_ending_exist <= 1'b1;
                    white_win <= 1'b1;
                end

                if(minute == 0 && second_1 == 0 && second_2 == 0)
                begin
                    if(life_count_1 < life_count_2)
                    begin
                        is_ending_exist <= 1'b1;
                        black_win <= 1'b1;
                    end
                    else if(life_count_1 > life_count_2)
                    begin
                        is_ending_exist <= 1'b1;
                        white_win <= 1'b1;
                    end
                    else
                    begin
                        is_ending_exist <= 1'b1;
                        tie <= 1'b1;
                    end
                end

                // Explosion Detection
                if(((Bomb_X_Pos == Ball_X_Pos + 10'd32 && Bomb_Y_Pos == Ball_Y_Pos) ||
                        (Bomb_X_Pos + 10'd32 == Ball_X_Pos && Bomb_Y_Pos == Ball_Y_Pos) ||
                        (Bomb_X_Pos == Ball_X_Pos && Bomb_Y_Pos + 10'd32 == Ball_Y_Pos) ||
                        (Bomb_X_Pos == Ball_X_Pos && Bomb_Y_Pos == Ball_Y_Pos + 10'd32) ||
                        (Bomb_X_Pos == Ball_X_Pos && Bomb_Y_Pos == Ball_Y_Pos)) && explosion_signal && life_count_1 > 0)
                begin
                    life_count_1 <= life_count_1 - 1;
                end

                if(((Bomb_X_Pos_2 == Ball_X_Pos + 10'd32 && Bomb_Y_Pos_2 == Ball_Y_Pos) ||
                        (Bomb_X_Pos_2 + 10'd32 == Ball_X_Pos && Bomb_Y_Pos_2 == Ball_Y_Pos) ||
                        (Bomb_X_Pos_2 == Ball_X_Pos && Bomb_Y_Pos_2 + 10'd32 == Ball_Y_Pos) ||
                        (Bomb_X_Pos_2 == Ball_X_Pos && Bomb_Y_Pos_2 == Ball_Y_Pos + 10'd32) ||
                        (Bomb_X_Pos_2 == Ball_X_Pos && Bomb_Y_Pos_2 == Ball_Y_Pos)) && explosion_signal_2 && life_count_1 > 0)
                begin
                    life_count_1 <= life_count_1 - 1;
                end

                if(((Bomb_X_Pos == Ball_X_Pos_2 + 10'd32 && Bomb_Y_Pos == Ball_Y_Pos_2) ||
                        (Bomb_X_Pos + 10'd32 == Ball_X_Pos_2 && Bomb_Y_Pos == Ball_Y_Pos_2) ||
                        (Bomb_X_Pos == Ball_X_Pos_2 && Bomb_Y_Pos + 10'd32 == Ball_Y_Pos_2) ||
                        (Bomb_X_Pos == Ball_X_Pos_2 && Bomb_Y_Pos == Ball_Y_Pos_2 + 10'd32) ||
                        (Bomb_X_Pos == Ball_X_Pos_2 && Bomb_Y_Pos == Ball_Y_Pos_2)) && explosion_signal && life_count_2 > 0)
                begin
                    life_count_2 <= life_count_2 - 1;
                end

                if(((Bomb_X_Pos_2 == Ball_X_Pos_2 + 10'd32 && Bomb_Y_Pos_2 == Ball_Y_Pos_2) ||
                        (Bomb_X_Pos_2 + 10'd32 == Ball_X_Pos_2 && Bomb_Y_Pos_2 == Ball_Y_Pos_2) ||
                        (Bomb_X_Pos_2 == Ball_X_Pos_2 && Bomb_Y_Pos_2 + 10'd32 == Ball_Y_Pos_2) ||
                        (Bomb_X_Pos_2 == Ball_X_Pos_2 && Bomb_Y_Pos_2 == Ball_Y_Pos_2 + 10'd32) ||
                        (Bomb_X_Pos_2 == Ball_X_Pos_2 && Bomb_Y_Pos_2 == Ball_Y_Pos_2)) && explosion_signal_2 && life_count_2 > 0)
                begin
                    life_count_2 <= life_count_2 - 1;
                end
            end
        end

        /************************************************************/
        /************************ Timer Part ************************/
        /************************************************************/

        always_ff @ (posedge frame_clk)
        begin
             if (Reset)
             begin
                minute <= 5;
                second_1 <= 0;
                second_2 <= 0;
                time_counter <= 60;
             end
             else if(r_pressed && is_ending_exist == 1'b1)
             begin
                minute <= 5;
                second_1 <= 0;
                second_2 <= 0;
                time_counter <= 60;
             end
             else if(is_ending_exist == 1'b1 || is_opening == 1'b1)
             begin
                minute <= minute;
                second_1 <= second_1;
                second_2 <= second_2;
                time_counter <= time_counter;
             end
             else if (minute == 0 && second_1 == 0 && second_2 == 0)
             begin
                minute <= 0;
                second_1 <= 0;
                second_2 <= 0;
                time_counter <= 60;
             end
             else
             begin
                 // count second by second
                 if(time_counter == 0 && second_1 == 0 && second_2 == 0)
                    minute <= minute - 1;
                 else
                    minute <= minute;

                 if(time_counter == 0 && second_2 == 0 && second_1 != 0)
                    second_1 <= second_1 - 1;
                 else if(time_counter == 0 && second_2 == 0 && second_1 == 0)
                    second_1 <= 5;
                 else
                    second_1 <= second_1;

                 if(time_counter == 0 && second_2 != 0)
                    second_2 <= second_2 - 1;
                 else if(time_counter == 0 && second_2 == 0)
                    second_2 <= 9;
                 else
                    second_2 <= second_2;

                 if(time_counter > 0)
                    time_counter <= time_counter - 1;
                 else
                    time_counter <= 60;
             end
        end

        /**************************************************************/
        /************************ Drawing Part ************************/
        /**************************************************************/


        numRAM numOCM(.read_address(num_address), .Clk, .data_Out(num_color_Idx));
        headRAM headOCM(.read_address(head_address), .Clk, .data_Out(head_color_Idx));


        int DistX_1, DistY_1, DistX_2, DistY_2, DistX_3, DistY_3, DistX_4, DistY_4, DistX_5, DistY_5, DistX_6, DistY_6, X_Size, Y_Size;
        assign DistX_1 = DrawX - Num_X_Pos_1;
        assign DistY_1 = DrawY - Num_Y_Pos_1;
        assign DistX_2 = DrawX - Num_X_Pos_2;
        assign DistY_2 = DrawY - Num_Y_Pos_2;
        assign DistX_3 = DrawX - Num_X_Pos_3;
        assign DistY_3 = DrawY - Num_Y_Pos_3;
        assign DistX_4 = DrawX - Num_X_Pos_4;
        assign DistY_4 = DrawY - Num_Y_Pos_4;
        assign DistX_5 = DrawX - Num_X_Pos_5;
        assign DistY_5 = DrawY - Num_Y_Pos_5;
        assign DistX_6 = DrawX - Num_X_Pos_6;
        assign DistY_6 = DrawY - Num_Y_Pos_6;
        assign X_Size = Num_X_Size;
        assign Y_Size = Num_Y_Size;
        int Head_DistX_1, Head_DistY_1, Head_DistX_2, Head_DistY_2, _Head_X_Size, _Head_Y_Size;
        assign Head_DistX_1 = DrawX - Head_X_Pos_1;
        assign Head_DistY_1 = DrawY - Head_Y_Pos_1;
        assign Head_DistX_2 = DrawX - Head_X_Pos_2;
        assign Head_DistY_2 = DrawY - Head_Y_Pos_2;
        assign _Head_X_Size = Head_X_Size;
        assign _Head_Y_Size = Head_Y_Size;
        always_comb begin
             is_num = 1'b0;
             is_head = 1'b0;
             num_address = 0;
             head_address = 0;
             if (DistX_1 < X_Size && DistX_1 > 0 && DistY_1 < Y_Size && DistY_1 > 0)
             begin
                   is_num = 1'b1;
                    num_address = 448 * (minute + 1) + (DrawX - Num_X_Pos_1) + (DrawY - Num_Y_Pos_1)*X_Size;
             end
             else if (DistX_2 < X_Size && DistX_2 > 0 && DistY_2 < Y_Size && DistY_2 > 0)
             begin
                   is_num = 1'b1;
                    num_address = (DrawX - Num_X_Pos_2) + (DrawY - Num_Y_Pos_2)*X_Size;
             end
             else if (DistX_3 < X_Size && DistX_3 > 0 && DistY_3 < Y_Size && DistY_3 > 0)
             begin
                   is_num = 1'b1;
                    num_address = 448 * (second_1 + 1) + (DrawX - Num_X_Pos_3) + (DrawY - Num_Y_Pos_3)*X_Size;
             end
             else if (DistX_4 < X_Size && DistX_4 > 0 && DistY_4 < Y_Size && DistY_4 > 0)
             begin
                   is_num = 1'b1;
                    num_address = 448 * (second_2 + 1) + (DrawX - Num_X_Pos_4) + (DrawY - Num_Y_Pos_4)*X_Size;
             end
             else if (DistX_5 < X_Size && DistX_5 > 0 && DistY_5 < Y_Size && DistY_5 > 0)
             begin
                   is_num = 1'b1;
                    num_address = 448 * (life_count_1 + 1) + (DrawX - Num_X_Pos_5) + (DrawY - Num_Y_Pos_5)*X_Size;
             end
             else if (DistX_6 < X_Size && DistX_6 > 0 && DistY_6 < Y_Size && DistY_6 > 0)
             begin
                   is_num = 1'b1;
                    num_address = 448 * (life_count_2 + 1) + (DrawX - Num_X_Pos_6) + (DrawY - Num_Y_Pos_6)*X_Size;
             end

             if (Head_DistX_1 < _Head_X_Size && Head_DistX_1 > 0 && Head_DistY_1 < _Head_Y_Size && Head_DistY_1 > 0)
             begin
                   is_head = 1'b1;
                    head_address = 784 + (DrawX - Head_X_Pos_1) + (DrawY - Head_Y_Pos_1)*_Head_X_Size;
             end
             else if (Head_DistX_2 < _Head_X_Size && Head_DistX_2 > 0 && Head_DistY_2 < _Head_Y_Size && Head_DistY_2 > 0)
             begin
                   is_head = 1'b1;
                    head_address = (DrawX - Head_X_Pos_2) + (DrawY - Head_Y_Pos_2)*_Head_X_Size;
             end
        end


        always_comb begin
            status_color_Idx = 0;
            if(is_num)
                status_color_Idx = num_color_Idx;
            else if(is_head)
                status_color_Idx = head_color_Idx;
        end

        assign is_status = is_num || is_head;


endmodule
