module  SRAM (  input  Clk,                // 50 MHz clock
                input [9:0]   DrawX, DrawY,       // Current pixel coordinates
                input logic is_opening, state_status, music_select,
                output logic [15:0] Color_Idx, bgm_data,
                output logic [18:0] music_addr,
                inout wire [15:0] SRAM_DQ,
                output logic SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N,
                output logic [19:0] SRAM_ADDR
              );
    logic [15:0] Data_from_SRAM, Data_to_CPU;
    logic [15:0] Data_to_SRAM;

    assign Color_Idx = Data_to_CPU;

	 // choose SRAM address
    always_comb
    begin
      bgm_data = 0;
      if(is_opening)
      begin
          if(DrawX[0] == 0)
             SRAM_ADDR = (DrawX + (DrawY)*640) / 2;
          else
             SRAM_ADDR = (DrawX-1 + (DrawY)*640) / 2;
      end
      else if (state_status == 0)
      begin
           SRAM_ADDR = music_addr + 320 * 240 * 2;
           bgm_data = Data_to_CPU;
      end
      else if (state_status == 1 && music_select == 0)
      begin
           SRAM_ADDR = music_addr + 320 * 240 * 2 + 305760;
           bgm_data = Data_to_CPU;
      end
      else
      begin
           SRAM_ADDR = music_addr + 320 * 240 * 2 + 16817 + 305760;
           bgm_data = Data_to_CPU;
      end
    end

    // Our SRAM and I/O controller
    Mem2IO memory_subsystem(
		  .*, .CE(SRAM_CE_N), .UB(SRAM_UB_N), .LB(SRAM_LB_N), .OE(SRAM_OE_N), .WE(SRAM_WE_N),
        .Reset(Reset_h),
        .Data_from_CPU(16'h0), .Data_to_CPU(Data_to_CPU),
        .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
    );

    // The tri-state buffer serves as the interface between Mem2IO and SRAM
    tristate #(.N(16)) tr0(
      .Clk(Clk), .tristate_output_enable(~SRAM_WE_N), .Data_write(Data_to_SRAM), .Data_read(Data_from_SRAM), .Data(SRAM_DQ)
    );

    assign SRAM_CE_N = 1'b0;
    assign SRAM_UB_N = 1'b0;
    assign SRAM_LB_N = 1'b0;
    assign SRAM_OE_N = 1'b0;
    assign SRAM_WE_N = 1'b1;

endmodule
