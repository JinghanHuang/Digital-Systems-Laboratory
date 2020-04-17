/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM
(
        input [4:0] data_In,
        input [18:0] write_address, read_address,
        input we, Clk,

        output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:399];

initial
begin
     $readmemh("sprite_bytes/tetris_I.txt", mem);
end


always_ff @ (posedge Clk) begin
    if (we)
        mem[write_address] <= data_In;
    data_Out<= mem[read_address];
end



endmodule


module  playerRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:16383];

initial
begin
     $readmemh("sprite_bytes/player.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end


endmodule

module  idleplayerRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [5:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [5:0] mem [0:1535];

initial
begin
     $readmemh("sprite_bytes/idle_player.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end


endmodule


module  bombRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [4:0] mem [0:3071];

initial
begin
     $readmemh("sprite_bytes/bomb.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end


endmodule

module  explosionRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:46079];

initial
begin
     $readmemh("sprite_bytes/ex.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end


endmodule


module  numRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:4927];

initial
begin
     $readmemh("sprite_bytes/num.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end


endmodule


module  headRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:1567];

initial
begin
     $readmemh("sprite_bytes/head.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end


endmodule


module  grassRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:1023];

initial
begin
     $readmemh("sprite_bytes/grass.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule



module  roomRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:1023];

initial
begin
     $readmemh("sprite_bytes/room.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule

module  treeRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:1023];

initial
begin
     $readmemh("sprite_bytes/tree.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule

module  startRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:4095];

initial
begin
     $readmemh("sprite_bytes/start.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule

module  cursorRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:1023];

initial
begin
     $readmemh("sprite_bytes/cursor.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule

module  endRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:12287];

initial
begin
     $readmemh("sprite_bytes/end.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule

module  shoeRAM
(
        input [18:0] read_address,
        input Clk,

        output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:1023];

initial
begin
     $readmemh("sprite_bytes/shoe.txt", mem);
end


always_ff @ (posedge Clk) begin
    data_Out<= mem[read_address];
end
endmodule
