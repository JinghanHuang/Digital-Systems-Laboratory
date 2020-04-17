module  cursor ( input  Clk,                // 50 MHz clock
                        Reset,              // Active-high reset signal
                        frame_clk,          // The clock indicating a new frame (~60Hz)
                 input [9:0]   DrawX, DrawY,       // Current pixel coordinates
                 input logic [9:0] cursorX, cursorY,
                 input logic leftButton, middleButton, rightButton, enter_pressed, r_pressed, is_ending_exist,
                 output logic  is_cursor, is_startbutton, is_opening,
                 output logic [1:0] cursor_color_Idx,
                 output logic [3:0] startbutton_color_Idx
              );
    parameter [9:0] Unit_Size = 10'd16;
    parameter [9:0] Start_X_Pos = 10'd576;
    parameter [9:0] Start_Y_Pos = 10'd448;
    parameter [9:0] Start_X_Size = 10'd64;
    parameter [9:0] Start_Y_Size = 10'd32;

    initial
    begin
        is_opening = 1'b1;
    end

    /**************************************************************/
    /************************ Click Part ************************/
    /**************************************************************/

    // if the mouse is in the range of button, the button will change color
    logic start_on, start_pressed;
    always_comb begin
        start_on = 1'b0;
        start_pressed = 1'b0;

        if (cursorX > Start_X_Pos && cursorY > Start_Y_Pos)
            start_on = 1'b1;

        if(start_on && leftButton)
            start_pressed = 1'b1;
    end

    always_ff @ (posedge Clk)
    begin
        if (Reset)
            begin
            is_opening <= 1'b1;
            end
        else if(r_pressed && is_ending_exist == 1'b1)
            begin
                is_opening <= 1'b1;
            end
        else
        begin
            if(enter_pressed || start_pressed)
            begin
                is_opening <= 1'b0;
            end
            else
            begin
                is_opening <= is_opening;
            end
        end
    end


    /**************************************************************/
    /************************ Drawing Part ************************/
    /**************************************************************/
    logic [18:0] cursor_address, startbutton_address;
    int DistX, DistY, Size, X_Size, Y_Size;
    always_comb begin
        Size = Unit_Size;
        X_Size = Start_X_Size;
        Y_Size = Start_Y_Size;
        DistX = DrawX - cursorX;
        DistY = DrawY - cursorY;
    end

    always_comb begin
        is_cursor = 1'b0;
        is_startbutton = 1'b0;

        if (DistX < Size && DistX > 0 && DistY < Size && DistY > 0)
            is_cursor = 1'b1;

        if (DrawX > Start_X_Pos && DrawY > Start_Y_Pos)
            is_startbutton = 1'b1;
    end

    always_comb
    begin
        cursor_address = (DrawX - cursorX) + (DrawY - cursorY)*Size;
        startbutton_address = (DrawX - Start_X_Pos) + (DrawY - Start_Y_Pos)*X_Size;

        if(start_on == 1'b1)
            startbutton_address = 32*64 + (DrawX - Start_X_Pos) + (DrawY - Start_Y_Pos)*X_Size;
    end

    cursorRAM cursorOCM(.read_address(cursor_address), .Clk, .data_Out(cursor_color_Idx));
    startRAM startOCM(.read_address(startbutton_address), .Clk, .data_Out(startbutton_color_Idx));


endmodule
