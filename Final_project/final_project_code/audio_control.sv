module audio_control (
                    input logic Clk, Reset,
                    input logic INIT_FINISH, data_over, load_startpage,
                    input logic is_opening, put_pulse, explode_pulse, is_ending_exist, r_pressed,
                    output logic INIT, music_select, state_status,
                    output logic [18:0] music_addr
                );


logic [18:0] Addr, Addr_in, putAddr, putAddr_in, explodeAddr, explodeAddr_in, music_addr_in;
logic [18:0] count_in, count;

// State Definition
enum logic [3:0] {
            IDLE, MUSIC_OFF, WAIT_FOR_INIT, PLAY_MUSIC, PRE_PUT_BOMB, PUT_BOMB, PRE_EXPLODE, EXPLODE, GAMEEND
                        } curr_state, next_state;

always_ff @ (posedge Clk)
begin
      if (Reset)
      begin
            curr_state <= IDLE;
            Addr <= 19'd0;
            putAddr <= 19'd0;
            explodeAddr <= 19'd0;
            music_addr <= 19'd0;
            count <= 19'd0;
      end
      else
      begin
            curr_state <= next_state;
            Addr <= Addr_in;
            putAddr <= putAddr_in;
            explodeAddr <= explodeAddr_in;
         music_addr <= music_addr_in;
            count <= count_in;
      end
end

always_comb
  begin
    // if not changed in current state, these are the default values
    INIT = 1'b0;
    music_select = 1'b0;
    state_status = 1'b0;
    Addr_in = Addr;
    putAddr_in = putAddr;
    explodeAddr_in = explodeAddr;
    count_in = count;
    music_addr_in = putAddr;
    next_state  = curr_state;    //required because I haven't enumerated all possibilities below

    unique case(curr_state)
        IDLE:
            begin
                if (!is_opening)
                    next_state = MUSIC_OFF;
            end
        MUSIC_OFF:
            begin
                next_state = WAIT_FOR_INIT;
            end
        WAIT_FOR_INIT:
            begin
                if (INIT_FINISH)
                   next_state = PLAY_MUSIC;
            end
        PLAY_MUSIC:
            begin
                if (put_pulse)
                    next_state = PRE_PUT_BOMB;
                if (explode_pulse)
                    next_state = PRE_EXPLODE;

                if (is_ending_exist)
                    next_state = GAMEEND;
            end
        PRE_PUT_BOMB:
            next_state = PUT_BOMB;
        PUT_BOMB:
            begin
                if (put_pulse)
                    next_state = PRE_PUT_BOMB;
                if (putAddr_in == 1'b0)
                    next_state = PLAY_MUSIC;
            end
        PRE_EXPLODE:
            next_state = EXPLODE;
        EXPLODE:
            begin
                if (explode_pulse)
                    next_state = PRE_EXPLODE;
                if (explodeAddr_in == 1'b0)
                    next_state = PLAY_MUSIC;
            end
        GAMEEND:
            begin
                if (r_pressed)
                    next_state = IDLE;
            end
        default: ;

    endcase


    case(curr_state)
        MUSIC_OFF:
            begin
                INIT = 1'b1;
                Addr_in = 19'd0;
            end
        WAIT_FOR_INIT:
            begin
                Addr_in = 19'd0;
            end
        PLAY_MUSIC:
            begin
               music_select = 1'b0;
                state_status = 1'b0;

                if ((count < 19'd10) && data_over)
                    count_in = count + 19'd1;
                else if (count < 19'd10)
                    count_in = count;
                else
                    count_in = 19'd0;

                if ((Addr < 19'd303000) && data_over && (count == 19'd9)) //end address
                begin
                    Addr_in = Addr + 19'd1;
                    music_addr_in = Addr + 19'd1;
                end
                else if (Addr < 19'd303000)
                begin
                    Addr_in = Addr;
                    music_addr_in = Addr;
                end
                else
                begin
                    Addr_in = 19'd0;
                    music_addr_in = 19'd0;
                end
            end
        PRE_PUT_BOMB:
            putAddr_in = 1'b1;
        PUT_BOMB:
            begin
               state_status = 1'b1;
               music_select = 1'b0;
                if ((count < 19'd10) && data_over)
                    count_in = count + 19'd1;
                else if (count < 19'd10)
                    count_in = count;
                else
                    count_in = 19'd0;

                if ((putAddr < 19'd16700) && data_over && (count == 19'd9)) //end address
                begin
                    putAddr_in = putAddr + 19'd1;
                    music_addr_in = putAddr + 19'd1;
                end
                else if (putAddr < 19'd16700)
                begin
                    putAddr_in = putAddr;
                    music_addr_in = putAddr;
                end
                else
                begin
                    putAddr_in = 19'd0;
                    music_addr_in = 19'd0;
                end
            end
        PRE_EXPLODE:
            explodeAddr_in = 1'b1;
        EXPLODE:
            begin
               state_status = 1'b1;
               music_select = 1'b1;
                if ((count < 19'd10) && data_over)
                    count_in = count + 19'd1;
                else if (count < 19'd10)
                    count_in = count;
                else
                    count_in = 19'd0;

                if ((explodeAddr < 19'd46500) && data_over && (count == 19'd9)) //end address
                begin
                    explodeAddr_in = explodeAddr + 19'd1;
                    music_addr_in = explodeAddr + 19'd1;
                end
                else if (explodeAddr < 19'd46500)
                begin
                    explodeAddr_in = explodeAddr;
                    music_addr_in = explodeAddr;
                end
                else
                begin
                    explodeAddr_in = 19'd0;
                    music_addr_in = 19'd0;
                end
            end
        default: ;
    endcase
  end

endmodule
