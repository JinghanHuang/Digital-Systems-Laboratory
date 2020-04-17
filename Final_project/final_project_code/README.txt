ECE 385 Final Project
Bomberman
Jinghan Huang & Chao Xu
___________________________________________


In sprite_bytes file, there are image data used in On-Chip memory.
In SRAM_DATA file, there are image data and music data used in SRAM.

For .sv files, there are three categories.
Created by us:

audio_control.sv - control audio state
back_ground.sv - handle background sprites and collision
bomb.sv - handle the placement and explosion of bomb
cursor.sv - handle cursor and the function of clicking for mouse
end.sv - handle ending animation based on ending state
grass.sv - handle grass
keycode_handler.sv - handle multiple keycodes at the same time
palette.sv - palette for different item
SRAM.sv - SRAM port
status.sv - handle the status bar

Provided and with many modifications:

Color_Mapper.sv
lab8.sv
player.sv (from ball.sv in lab8)
ram.sv


Provided but with trivial modifications:

hpi_io_intf.sv
HexDriver.sv
tristate.sv
Mem2IO.sv
mouse_interface_IP.sv
VGA_controller.sv


Reference:
Audio
Koushik Roy's code on the blackboard

Mouse
https://drive.google.com/file/d/0Bz9a4yIUApZMRDNQZl9MVkNIVjQ/view











