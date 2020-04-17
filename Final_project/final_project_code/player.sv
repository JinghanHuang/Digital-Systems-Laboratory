//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  player ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
                input [9:0]   DrawX, DrawY,       // Current pixel coordinates
                input logic  player_number, w_pressed, s_pressed, a_pressed, d_pressed,
                input logic white_win, black_win, tie, is_ending_exist, r_pressed,
                input logic [3:0] can_pass,
                input logic speed_up,
                output logic  is_ball,             // Whether current pixel belongs to ball or background
                output logic [5:0] player_color_Idx,
                output logic [9:0] Ball_X_Pos, Ball_Y_Pos
              );

    parameter [9:0] Ball_X_Center = 10'd0;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd32;  // Center position on the Y axis
    parameter [9:0] Ball_X_Center_2 = 10'd608;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center_2 = 10'd32;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd32;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step = 10'd32;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step = 10'd32;      // Step size on the Y axis
    parameter [9:0] Ball_X_Size = 10'd32;        // Ball size
    parameter [9:0] Ball_Y_Size = 10'd32;        // Ball size

    logic [9:0] Ball_X_Motion, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    logic [18:0] player_address;

    byte direction, direction_in;
    byte walking_counter, walking_counter_in;
    logic is_walking;
    logic [9:0] prev_Ball_X_Pos, prev_Ball_Y_Pos;
    logic [9:0] prev_Ball_X_Pos_in, prev_Ball_Y_Pos_in;

    /***************************************************************/
    /************************ Speed UP Part ************************/
    /***************************************************************/
    // count the time of speed-up state
    int speed_counter;
    always_ff @ (posedge frame_clk)
    begin
        if (Reset)
            speed_counter <= 0;
        else
        begin
            if(speed_up)
                speed_counter <= 600;
            else if(speed_counter > 0)
                speed_counter <= speed_counter - 1;
            else
                speed_counter <= speed_counter;
        end
    end

    // to know if the current state is in speed-up
    logic is_speed_up;
    always_comb
    begin
        is_speed_up = 1'b0;
        if(speed_counter > 0)
            is_speed_up = 1'b1;
    end

    // change walking time based on speed-up state
    byte walking_time, half_walking_time;
    always_comb begin
       half_walking_time = walking_time/2;
       walking_time = 20;
       if(is_speed_up)
           walking_time = 10;
    end

    /*********************************************************************/
    /************************ Postion Update Part ************************/
    /*********************************************************************/
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
            if(player_number == 1'b1)
            begin
                Ball_X_Pos <= Ball_X_Center_2;
                Ball_Y_Pos <= Ball_Y_Center_2;
            end
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= 10'd0;
            direction <= 1;
            prev_Ball_X_Pos <= Ball_X_Center;
            prev_Ball_Y_Pos <= Ball_Y_Center;
        end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
            direction <= direction_in;
            prev_Ball_X_Pos <= prev_Ball_X_Pos_in;
            prev_Ball_Y_Pos <= prev_Ball_Y_Pos_in;
        end
    end

    always_ff @ (posedge frame_clk)
    begin
        if (Reset)
          begin
                walking_counter <= 0;
                Ball_X_Pos_in <= Ball_X_Center;
                Ball_Y_Pos_in <= Ball_Y_Center;
                if(player_number == 1'b1)
                begin
                    Ball_X_Pos_in <= Ball_X_Center_2;
                    Ball_Y_Pos_in <= Ball_Y_Center_2;
                end
          end
          else if(r_pressed && is_ending_exist == 1'b1)
          begin
                walking_counter <= 0;
                Ball_X_Pos_in <= Ball_X_Center;
                Ball_Y_Pos_in <= Ball_Y_Center;
                if(player_number == 1'b1)
                begin
                    Ball_X_Pos_in <= Ball_X_Center_2;
                    Ball_Y_Pos_in <= Ball_Y_Center_2;
                end
          end
        else
          begin
                if(walking_counter > 0)
                begin
                    walking_counter <= walking_counter - 1;
                    Ball_X_Pos_in = Ball_X_Pos;
                    Ball_Y_Pos_in = Ball_Y_Pos;
                end
                else
                begin
                    walking_counter <= walking_counter_in;
                    Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
                    Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
                end
          end
    end

    /*************************************************************/
    /************************ Moving Part ************************/
    /*************************************************************/

    logic moving_flag, moving_w_flag, moving_s_flag, moving_a_flag, moving_d_flag;
    assign moving_flag = w_pressed || s_pressed || a_pressed || d_pressed;
    logic only_w, only_s, only_a, only_d;
    assign only_w = w_pressed && !s_pressed && !a_pressed && !d_pressed;
    assign only_s = !w_pressed && s_pressed && !a_pressed && !d_pressed;
    assign only_a = !w_pressed && !s_pressed && a_pressed && !d_pressed;
    assign only_d = !w_pressed && !s_pressed && !a_pressed && d_pressed;

    // The priority of keycodes is based on the order of pressing
    always_ff @ (posedge Clk)
    begin
        if (Reset)
          begin
                moving_w_flag <= 1'b0;
                moving_s_flag <= 1'b0;
                moving_a_flag <= 1'b0;
                moving_d_flag <= 1'b0;
          end
        else
          begin
                if(!moving_flag || is_ending_exist)
                begin
                    moving_w_flag <= 1'b0;
                    moving_s_flag <= 1'b0;
                    moving_a_flag <= 1'b0;
                    moving_d_flag <= 1'b0;
                end
                else if(only_w)
                begin
                    moving_w_flag <= 1'b1;
                    moving_s_flag <= 1'b0;
                    moving_a_flag <= 1'b0;
                    moving_d_flag <= 1'b0;
                end
                else if(only_s)
                begin
                    moving_w_flag <= 1'b0;
                    moving_s_flag <= 1'b1;
                    moving_a_flag <= 1'b0;
                    moving_d_flag <= 1'b0;
                end
                else if(only_a)
                begin
                    moving_w_flag <= 1'b0;
                    moving_s_flag <= 1'b0;
                    moving_a_flag <= 1'b1;
                    moving_d_flag <= 1'b0;
                end
                else if(only_d)
                begin
                    moving_w_flag <= 1'b0;
                    moving_s_flag <= 1'b0;
                    moving_a_flag <= 1'b0;
                    moving_d_flag <= 1'b1;
                end
                else
                begin
                    moving_w_flag <= moving_w_flag;
                    moving_s_flag <= moving_s_flag;
                    moving_a_flag <= moving_a_flag;
                    moving_d_flag <= moving_d_flag;
                end
          end
    end

    // Use command from keyboard to change player state
    always_comb
    begin
          direction_in = direction;
          Ball_X_Motion_in = 10'd0;
          Ball_Y_Motion_in = 10'd0;
          walking_counter_in = walking_counter;
          prev_Ball_X_Pos_in = prev_Ball_X_Pos;
          prev_Ball_Y_Pos_in = prev_Ball_Y_Pos;

          if(moving_w_flag)
          begin
                if(Ball_Y_Pos >= Ball_Y_Min + Ball_Y_Size && can_pass[0] && !is_walking)
                begin
                    Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
                    Ball_X_Motion_in = 0;
                    walking_counter_in = walking_time;
                    prev_Ball_X_Pos_in = Ball_X_Pos;
                    prev_Ball_Y_Pos_in = Ball_Y_Pos;
                end
                if(!is_walking)
                begin
                    direction_in = 0;
                end
            end
            else if(moving_s_flag)
            begin
                if((Ball_Y_Pos + Ball_Y_Size <= Ball_Y_Max) && can_pass[1] && !is_walking)
                begin
                    Ball_Y_Motion_in = Ball_Y_Step;
                    Ball_X_Motion_in = 0;
                    walking_counter_in = walking_time;
                    prev_Ball_X_Pos_in = Ball_X_Pos;
                    prev_Ball_Y_Pos_in = Ball_Y_Pos;
                end
                if(!is_walking)
                begin
                    direction_in = 1;
                end
            end
            else if(moving_a_flag)
            begin
                if(Ball_X_Pos >= Ball_X_Min + Ball_X_Size && can_pass[2] && !is_walking)
                begin
                    Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
                    Ball_Y_Motion_in = 0;
                    walking_counter_in = walking_time;
                    prev_Ball_X_Pos_in = Ball_X_Pos;
                    prev_Ball_Y_Pos_in = Ball_Y_Pos;
                end
                if(!is_walking)
                begin
                    direction_in = 2;
                end
            end
            else if(moving_d_flag)
            begin
                if(Ball_X_Pos + Ball_X_Size <= Ball_X_Max && can_pass[3] && !is_walking)
                begin
                    Ball_X_Motion_in = Ball_X_Step;
                    Ball_Y_Motion_in = 0;
                    walking_counter_in = walking_time;
                    prev_Ball_X_Pos_in = Ball_X_Pos;
                    prev_Ball_Y_Pos_in = Ball_Y_Pos;
                end
                if(!is_walking)
                begin
                    direction_in = 3;
                end
            end

            if(walking_counter > 0)
                is_walking = 1'b1;
            else
                is_walking = 1'b0;
     end

     /*********************************************************************/
     /************************ Player Drawing Part ************************/
     /*********************************************************************/

    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, X_Size, Y_Size;

     always_comb begin
        X_Size = Ball_X_Size;
        Y_Size = Ball_Y_Size;
        DistX = DrawX - Ball_X_Pos;
        DistY = DrawY - Ball_Y_Pos;

        if(walking_counter > half_walking_time)
        begin
            case(direction)
                0: DistY = DrawY - (prev_Ball_Y_Pos - 10'd11);
                1: DistY = DrawY - (prev_Ball_Y_Pos + 10'd11);
                2: DistX = DrawX - (prev_Ball_X_Pos - 10'd11);
                3: DistX = DrawX - (prev_Ball_X_Pos + 10'd11);
                default:;
            endcase
        end
        else if(walking_counter > 0 && walking_counter <= half_walking_time)
        begin
            case(direction)
                0: DistY = DrawY - (prev_Ball_Y_Pos - 10'd22);
                1: DistY = DrawY - (prev_Ball_Y_Pos + 10'd22);
                2: DistX = DrawX - (prev_Ball_X_Pos - 10'd22);
                3: DistX = DrawX - (prev_Ball_X_Pos + 10'd22);
                default:;
            endcase
        end
     end

    always_comb begin
        if ( DistX < X_Size && DistX > 0 && DistY < Y_Size && DistY > 0)
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end

     byte end_counter, end_counter_in;
     logic end_start;

     always_ff @ (posedge frame_clk)
     begin
          if (Reset)
          begin
                end_counter <= 0;
                end_start <= 1'b0;
          end
          else
          begin
                end_start <= end_start;
                if(is_ending_exist && end_start != 1'b1)
                begin
                    end_counter <= 80;
                    end_start <= 1'b1;
                end
                else if(end_counter > 0)
                begin
                    end_counter <= end_counter - 1;
                end
                else
                begin
                    end_counter <= end_counter;
                end
          end
     end


     // Player animation based on direction and walking state
     always_comb
     begin
        player_address  = 0;

        if(is_ending_exist)
        begin
            player_address = (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;

            if((player_number == 1'b1 && white_win == 1'b1) || (player_number == 1'b0 && black_win == 1'b1))
            begin
                player_address = 1024 * 15 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                if(end_counter > 60)
                    player_address = 1024 * 12 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                else if(end_counter > 40 && end_counter <= 60)
                    player_address = 1024 * 13 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                else if(end_counter > 20 && end_counter <= 40)
                    player_address = 1024 * 14 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
            end

        end
        else
        begin
            if(walking_counter > half_walking_time)
                begin
                    case(direction)
                        0: player_address = 1024 * 4 + (DrawX - prev_Ball_X_Pos) + (DrawY - (prev_Ball_Y_Pos - 10'd11))*X_Size;
                        1: player_address = 1024 * 6 + (DrawX - prev_Ball_X_Pos) + (DrawY - (prev_Ball_Y_Pos + 10'd11))*X_Size;
                        2: player_address = 1024 * 8 + (DrawX - (prev_Ball_X_Pos - 10'd11)) + (DrawY - prev_Ball_Y_Pos)*X_Size;
                        3: player_address = 1024 * 10 + (DrawX - (prev_Ball_X_Pos + 10'd11)) + (DrawY - prev_Ball_Y_Pos)*X_Size;
                        default:;
                    endcase
                end
                else if(walking_counter > 0 && walking_counter <= half_walking_time)
                begin
                    case(direction)
                        0: player_address = 1024 * 5 + (DrawX - prev_Ball_X_Pos) + (DrawY - (prev_Ball_Y_Pos - 10'd22))*X_Size;
                        1: player_address = 1024 * 7 + (DrawX - prev_Ball_X_Pos) + (DrawY - (prev_Ball_Y_Pos + 10'd22))*X_Size;
                        2: player_address = 1024 * 9 + (DrawX - (prev_Ball_X_Pos - 10'd22)) + (DrawY - prev_Ball_Y_Pos)*X_Size;
                        3: player_address = 1024 * 11 + (DrawX - (prev_Ball_X_Pos + 10'd22)) + (DrawY - prev_Ball_Y_Pos)*X_Size;
                        default:;
                    endcase
                end
                else
                begin
                    case (direction)
                        0: player_address = (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                        1: player_address = 1024 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                        2: player_address = 1024 * 2 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                        3: player_address = 1024 * 3 + (DrawX - Ball_X_Pos) + (DrawY - Ball_Y_Pos)*X_Size;
                        default:;
                    endcase
                end
        end
     end

     playerRAM playerOCM(.read_address(player_address), .Clk, .data_Out(player_color_Idx));

endmodule
