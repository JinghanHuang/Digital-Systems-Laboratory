module ending ( input   Clk,                // 50 MHz clock
                        Reset,              // Active-high reset signal
                        frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input logic r_pressed,
               input logic is_ending_exist, white_win, black_win, tie,
               output logic  is_ending,
               output logic [3:0] end_color_Idx
              );

    logic [18:0] end_address;

    parameter [9:0] End_X_Pos = 10'd256;
    parameter [9:0] End_Y_Pos = 10'd240;
    parameter [9:0] End_X_Size = 10'd128;
    parameter [9:0] End_Y_Size = 10'd32;

    int end_counter, end_counter_in;
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
                    end_counter <= 64;
                    end_start <= 1'b1;
                end
                else if(end_counter > 0)
                    end_counter <= end_counter - 1;
                else
                    end_counter <= end_counter;
          end
    end

    /**************************************************************/
    /************************ Drawing Part ************************/
    /**************************************************************/

    int DistX, DistY, X_Size, Y_Size;
    always_comb begin
        X_Size = End_X_Size;
        Y_Size = End_Y_Size ;
        DistX = DrawX - End_X_Pos;
        DistY = DrawY - (End_Y_Pos + end_counter);
    end

    // Ending Animation
    always_comb begin
        is_ending = 1'b0;
        if (is_ending_exist && DistX < X_Size && DistX > 0 && DistY < Y_Size && DistY > 0)
            is_ending = 1'b1;

        end_address = 0;

        if(white_win == 1'b1)
        begin
            end_address = (DrawX - End_X_Pos) + (DrawY - (End_Y_Pos + end_counter))*X_Size;
        end
        else if(black_win == 1'b1)
        begin
            end_address = 32*128 + (DrawX - End_X_Pos) + (DrawY - (End_Y_Pos + end_counter))*X_Size;
        end
        else if(tie == 1'b1)
        begin
            end_address = 32*128*2 + (DrawX - End_X_Pos) + (DrawY - (End_Y_Pos + end_counter))*X_Size;
        end

    end

    endRAM endOCM(.read_address(end_address), .Clk, .data_Out(end_color_Idx));

endmodule
