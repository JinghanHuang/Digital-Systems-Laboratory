//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
             // VGA Interface
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
             // mouse interface
             inout               PS2_CLK, PS2_DAT,
             // audio Interface
             input               AUD_BCLK, AUD_ADCDAT, AUD_DACLRCK, AUD_ADCLRCK,
             output logic        AUD_XCK, AUD_DACDAT, I2C_SDAT, I2C_SCLK,
             // SRAM Interface
             inout wire [15:0] SRAM_DQ,
             output logic SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N,
             output logic [19:0] SRAM_ADDR
                    );

    logic Reset_h, Clk;
    logic [31:0] keycode;

    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end


    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;

    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),
                            .OTG_ADDR(OTG_ADDR),
                            .OTG_RD_N(OTG_RD_N),
                            .OTG_WR_N(OTG_WR_N),
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );

     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     nios_system nios_system(
                             .clk_clk(Clk),
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR),
                             .sdram_wire_ba(DRAM_BA),
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),
                             .sdram_wire_cs_n(DRAM_CS_N),
                             .sdram_wire_dq(DRAM_DQ),
                             .sdram_wire_dqm(DRAM_DQM),
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N),
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );

    // mouse interface
    logic leftButton, middleButton, rightButton;
    logic [9:0] cursorX, cursorY;
    Mouse_interface Mouse_interface_ins(.*);


    // audio vhd interface (provided)
    logic INIT, INIT_FINISH, adc_full, data_over;
    logic [31:0] ADCDATA;
    logic [15:0] bgm_data;
    logic [18:0] music_addr;
    audio_interface audio_interface_ins(
                                        .LDATA(bgm_data), .RDATA(bgm_data),
                                        .clk(Clk), .Reset(Reset_h),
                                        .INIT(1'b1),
                                        .INIT_FINISH(INIT_FINISH),
                                        .adc_full(adc_full),
                                        .data_over(data_over),
                                        .AUD_MCLK(AUD_XCK),
                                        .AUD_BCLK(AUD_BCLK),
                                        .AUD_ADCDAT(AUD_ADCDAT),
                                        .AUD_DACDAT(AUD_DACDAT),
                                        .AUD_DACLRCK(AUD_DACLRCK), .AUD_ADCLRCK(AUD_ADCLRCK),
                                        .I2C_SDAT(I2C_SDAT),
                                        .I2C_SCLK(I2C_SCLK),
                                        .ADCDATA(ADCDATA)
    );


    // audio control interface
    logic game_over, load_startpage;
    assign load_startpage = 1'b1;
    assign game_over = 1'b0;

    logic is_bomb_place, is_bomb_place_2;
    logic put_pulse, explode_pulse;
    logic state_status, music_select;
    logic explosion_start_signal, explosion_start_signal_2;
    assign put_pulse = is_bomb_place || is_bomb_place_2;
    assign explode_pulse = explosion_start_signal || explosion_start_signal_2;

    audio_control audio_control_ins(.*,
                                        .Reset(Reset_h)
    );

    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    VGA_controller vga_controller_instance(.*, .Reset(Reset_h));

    // color mapper interface
    logic [9:0] DrawX, DrawY;
    logic is_ball_1, is_ball_2, is_opening, is_back, is_bomb, is_explosion, is_status, is_grass, is_room, is_tree, is_cursor, is_startbutton, is_shoe;
    logic [5:0] player_color_Idx_1, player_color_Idx_2;
    logic [4:0] back_color_Idx, bomb_color_Idx;
    logic [3:0] startbutton_color_Idx, shoe_color_Idx, tree_color_Idx, room_color_Idx, end_color_Idx;
    logic [2:0] status_color_Idx, explosion_color_Idx;
    logic [1:0] cursor_color_Idx, grass_color_Idx;
    color_mapper color_instance(.*);

    // player interface
    logic [9:0] Ball_X_Pos, Ball_Y_Pos;
    logic [9:0] Ball_X_Pos_2, Ball_Y_Pos_2;
    logic speed_up_1, speed_up_2;
    player player_instance(.*, .speed_up(speed_up_1), .player_number(1'b0), .can_pass(can_pass[3:0]), .player_color_Idx(player_color_Idx_1), .is_ball(is_ball_1), .Reset(Reset_h), .frame_clk(~VGA_VS));
    player player_instance_2(.*, .speed_up(speed_up_2), .player_number(1'b1), .can_pass(can_pass[7:4]), .w_pressed(up_pressed), .s_pressed(down_pressed), .a_pressed(left_pressed), .d_pressed(right_pressed),
                              .Ball_X_Pos(Ball_X_Pos_2), .Ball_Y_Pos(Ball_Y_Pos_2), .is_ball(is_ball_2), .player_color_Idx(player_color_Idx_2),
                              .Reset(Reset_h), .frame_clk(~VGA_VS));

    // status interface
    status status_instance(.*, .Reset(Reset_h), .frame_clk(~VGA_VS));

    // back ground interface
    logic [7:0] can_pass;
    logic explosion_signal, explosion_signal_2;
    logic [9:0] Bomb_X_Pos, Bomb_Y_Pos;
    logic [9:0] Bomb_X_Pos_2, Bomb_Y_Pos_2;
    back_ground back_ground_instance(.*, .Reset(Reset_h), .frame_clk(~VGA_VS));

    // cursor interface
    cursor cursor_ins(.*, .Reset(Reset_h), .frame_clk(~VGA_VS));

    // ending interface
    logic is_ending;
    logic is_ending_exist, white_win, black_win, tie;
    ending ending_ins(.*, .Reset(Reset_h), .frame_clk(~VGA_VS));

    // keycode handler interface
    logic  w_pressed, s_pressed, a_pressed, d_pressed,
           up_pressed, down_pressed, left_pressed, right_pressed,
           enter_pressed, space_pressed, zero_pressed, r_pressed, backspace_pressed;
    keycode_handler keycode_handler_instance(.*);

    // SRAM interface
    logic [15:0] Color_Idx;
    SRAM SRAM_ins(.*);

    // Display keycode on hex display
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
    HexDriver hex_inst_2 (keycode[11:8], HEX2);
    HexDriver hex_inst_3 (keycode[15:12], HEX3);
    HexDriver hex_inst_4 (keycode[19:16], HEX4);
    HexDriver hex_inst_5 (keycode[23:20], HEX5);
    HexDriver hex_inst_6 (keycode[27:24], HEX6);
    HexDriver hex_inst_7 (keycode[31:28], HEX7);

endmodule
