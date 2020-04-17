module  keycode_handler (
               input [31:0] keycode,
               output logic  w_pressed, s_pressed, a_pressed, d_pressed,
                             up_pressed, down_pressed, left_pressed, right_pressed,
                             enter_pressed, space_pressed, zero_pressed, r_pressed, backspace_pressed
              );

    always_comb
    begin
        w_pressed = (keycode[31:24] == 8'h1A) || (keycode[23:16] == 8'h1A) || (keycode[15:8] == 8'h1A) || (keycode[7:0] == 8'h1A);
        s_pressed = (keycode[31:24] == 8'h16) || (keycode[23:16] == 8'h16) || (keycode[15:8] == 8'h16) || (keycode[7:0] == 8'h16);
        a_pressed = (keycode[31:24] == 8'h04) || (keycode[23:16] == 8'h04) || (keycode[15:8] == 8'h04) || (keycode[7:0] == 8'h04);
        d_pressed = (keycode[31:24] == 8'h07) || (keycode[23:16] == 8'h07) || (keycode[15:8] == 8'h07) || (keycode[7:0] == 8'h07);

        up_pressed = (keycode[31:24] == 8'h52) || (keycode[23:16] == 8'h52) || (keycode[15:8] == 8'h52) || (keycode[7:0] == 8'h52);
        down_pressed = (keycode[31:24] == 8'h51) || (keycode[23:16] == 8'h51) || (keycode[15:8] == 8'h51) || (keycode[7:0] == 8'h51);
        left_pressed = (keycode[31:24] == 8'h50) || (keycode[23:16] == 8'h50) || (keycode[15:8] == 8'h50) || (keycode[7:0] == 8'h50);
        right_pressed = (keycode[31:24] == 8'h4F) || (keycode[23:16] == 8'h4F) || (keycode[15:8] == 8'h4F) || (keycode[7:0] == 8'h4F);

        enter_pressed = (keycode[31:24] == 8'h28) || (keycode[23:16] == 8'h28) || (keycode[15:8] == 8'h28) || (keycode[7:0] == 8'h28);
        space_pressed = (keycode[31:24] == 8'h2C) || (keycode[23:16] == 8'h2C) || (keycode[15:8] == 8'h2C) || (keycode[7:0] == 8'h2C);
        zero_pressed = (keycode[31:24] == 8'h62) || (keycode[23:16] == 8'h62) || (keycode[15:8] == 8'h62) || (keycode[7:0] == 8'h62);

        r_pressed = (keycode[31:24] == 8'h15) || (keycode[23:16] == 8'h15) || (keycode[15:8] == 8'h15) || (keycode[7:0] == 8'h15);
        backspace_pressed = (keycode[31:24] == 8'h2A) || (keycode[23:16] == 8'h2A) || (keycode[15:8] == 8'h2A) || (keycode[7:0] == 8'h2A);
    end
endmodule
