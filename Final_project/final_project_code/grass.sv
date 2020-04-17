module  grass ( input         Clk,                // 50 MHz clock
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               output logic  is_grass,             // Whether current pixel belongs to ball or background
               output logic [1:0] grass_color_Idx
              );

    parameter [9:0] Grass_Size = 10'd32;

    logic [18:0] grass_address;

    // Draw the grass as default
    always_comb begin
         if (DrawY > 10'd32)
              is_grass = 1'b1;
         else
              is_grass = 1'b0;
    end

    int Size;
    assign Size = Grass_Size;

    always_comb
    begin
        grass_address = (DrawX) % Size + ((DrawY - 10'd3)% Size) * Size;
    end

    grassRAM grassOCM(.read_address(grass_address), .Clk, .data_Out(grass_color_Idx));


endmodule
