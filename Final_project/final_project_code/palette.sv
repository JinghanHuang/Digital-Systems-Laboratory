module title_palette (
    input logic [7:0] Color_Idx,
    output logic [7:0] title_Red, title_Green, title_Blue
);
    logic [23:0] RGB;
    assign title_Red = RGB[23:16];
    assign title_Green = RGB[15:8];
    assign title_Blue = RGB[7:0];

    always_comb begin
    unique case (Color_Idx)
        8'd0:
            RGB = 24'h397DDA;
        8'd1:
            RGB = 24'h3A70DD;
        8'd2:
            RGB = 24'h3765A5;
        8'd3:
            RGB = 24'h384D65;
        8'd4:
            RGB = 24'h2B66DA;
        8'd5:
            RGB = 24'h1E64D7;
        8'd6:
            RGB = 24'h2658A5;
        8'd7:
            RGB = 24'h2C6ADA;
        8'd8:
            RGB = 24'h598FE1;
        8'd9:
            RGB = 24'h8EB6E9;
        8'd10:
            RGB = 24'h7CACE4;
        8'd11:
            RGB = 24'h2D6DDA;
        8'd12:
            RGB = 24'h3B83E5;
        8'd13:
            RGB = 24'hB2CDED;
        8'd14:
            RGB = 24'hCBD9F6;
        8'd15:
            RGB = 24'hA5C0EC;
        8'd16:
            RGB = 24'hEEF7FC;
        8'd17:
            RGB = 24'hD8E4F8;
        8'd18:
            RGB = 24'h69A1E4;
        8'd19:
            RGB = 24'hE3F2FB;
        8'd20:
            RGB = 24'hFFFFFF;
        8'd21:
            RGB = 24'hC0D1F4;
        8'd22:
            RGB = 24'hFCFCFC;
        8'd23:
            RGB = 24'hF5FBFD;
        8'd24:
            RGB = 24'h3073D9;
        8'd25:
            RGB = 24'hE7E9ED;
        8'd26:
            RGB = 24'hBEBDBE;
        8'd27:
            RGB = 24'hADB4AE;
        8'd28:
            RGB = 24'h6A5E5D;
        8'd29:
            RGB = 24'h7A7D8D;
        8'd30:
            RGB = 24'hD7DAE1;
        8'd31:
            RGB = 24'h424A4D;
        8'd32:
            RGB = 24'h352E25;
        8'd33:
            RGB = 24'h8E9391;
        8'd34:
            RGB = 24'h180E05;
        8'd35:
            RGB = 24'h231A10;
        8'd36:
            RGB = 24'h474034;
        8'd37:
            RGB = 24'h6C6D7B;
        8'd38:
            RGB = 24'h9AA7A9;
        8'd39:
            RGB = 24'h302112;
        8'd40:
            RGB = 24'h3C2707;
        8'd41:
            RGB = 24'h34383F;
        8'd42:
            RGB = 24'h9B610E;
        8'd43:
            RGB = 24'h5F4016;
        8'd44:
            RGB = 24'h2D1C0A;
        8'd45:
            RGB = 24'hDCA912;
        8'd46:
            RGB = 24'h795213;
        8'd47:
            RGB = 24'h58505E;
        8'd48:
            RGB = 24'hC7CED9;
        8'd49:
            RGB = 24'hFCBD01;
        8'd50:
            RGB = 24'hF5AB04;
        8'd51:
            RGB = 24'h493116;
        8'd52:
            RGB = 24'hFFE001;
        8'd53:
            RGB = 24'h3379DA;
        8'd54:
            RGB = 24'hC1A711;
        8'd55:
            RGB = 24'hFED402;
        8'd56:
            RGB = 24'hD48C10;
        8'd57:
            RGB = 24'hC6711D;
        8'd58:
            RGB = 24'hAE9009;
        8'd59:
            RGB = 24'h968B07;
        8'd60:
            RGB = 24'hE4CB12;
        8'd61:
            RGB = 24'hFFF401;
        8'd62:
            RGB = 24'hFEC901;
        8'd63:
            RGB = 24'hFEB202;
        8'd64:
            RGB = 24'h586A04;
        8'd65:
            RGB = 24'hFFEB01;
        8'd66:
            RGB = 24'hAA0D1C;
        8'd67:
            RGB = 24'hBDC3EE;
        8'd68:
            RGB = 24'hB7C8D8;
        8'd69:
            RGB = 24'hA5BCD4;
        8'd70:
            RGB = 24'h93B4C4;
        8'd71:
            RGB = 24'h9599C8;
        8'd72:
            RGB = 24'h747C05;
        8'd73:
            RGB = 24'h0F1C2D;
        8'd74:
            RGB = 24'hEA4E05;
        8'd75:
            RGB = 24'hCB3E17;
        8'd76:
            RGB = 24'h6C2D29;
        8'd77:
            RGB = 24'h7E84BB;
        8'd78:
            RGB = 24'h696CAA;
        8'd79:
            RGB = 24'h57549D;
        8'd80:
            RGB = 24'h393E8F;
        8'd81:
            RGB = 24'h4B3C6A;
        8'd82:
            RGB = 24'h281403;
        8'd83:
            RGB = 24'hF49B02;
        8'd84:
            RGB = 24'h3472C5;
        8'd85:
            RGB = 24'h733758;
        8'd86:
            RGB = 24'h90333A;
        8'd87:
            RGB = 24'hB51B39;
        8'd88:
            RGB = 24'hD80329;
        8'd89:
            RGB = 24'hBA061F;
        8'd90:
            RGB = 24'h0D2440;
        8'd91:
            RGB = 24'hED6401;
        8'd92:
            RGB = 24'hFD5B17;
        8'd93:
            RGB = 24'h333174;
        8'd94:
            RGB = 24'hF83901;
        8'd95:
            RGB = 24'h775040;
        8'd96:
            RGB = 24'hEF7802;
        8'd97:
            RGB = 24'hFE8103;
        8'd98:
            RGB = 24'h151D82;
        8'd99:
            RGB = 24'h4F71AD;
        8'd100:
            RGB = 24'hD2CBB0;
        8'd101:
            RGB = 24'hAFBA83;
        8'd102:
            RGB = 24'hFFA001;
        8'd103:
            RGB = 24'h1E2380;
        8'd104:
            RGB = 24'h0F1378;
        8'd105:
            RGB = 24'hFD4700;
        8'd106:
            RGB = 24'hFD5202;
        8'd107:
            RGB = 24'hF18A01;
        8'd108:
            RGB = 24'hFF9102;
        8'd109:
            RGB = 24'h1A305C;
        8'd110:
            RGB = 24'h0C1588;
        8'd111:
            RGB = 24'hFFA902;
        8'd112:
            RGB = 24'hB23E4D;
        8'd113:
            RGB = 24'h945848;
        8'd114:
            RGB = 24'hAD6936;
        8'd115:
            RGB = 24'h425A78;
        8'd116:
            RGB = 24'h816D59;
        8'd117:
            RGB = 24'h9EA105;
        8'd118:
            RGB = 24'h0F2B4B;
        8'd119:
            RGB = 24'h13326D;
        8'd120:
            RGB = 24'h224874;
        8'd121:
            RGB = 24'h849EAF;
        8'd122:
            RGB = 24'hF58A1D;
        8'd123:
            RGB = 24'h3C6E92;
        8'd124:
            RGB = 24'hBE8445;
        8'd125:
            RGB = 24'h1E4067;
        8'd126:
            RGB = 24'hD58A3E;
        8'd127:
            RGB = 24'h5986A9;
        8'd128:
            RGB = 24'h987F4C;
        8'd129:
            RGB = 24'h708EAB;
        8'd130:
            RGB = 24'h26507F;
        8'd131:
            RGB = 24'h063B81;
        8'd132:
            RGB = 24'hC2AB38;
        8'd133:
            RGB = 24'hFEF5ED;
        8'd134:
            RGB = 24'hA69B44;
        8'd135:
            RGB = 24'hD8C032;
        8'd136:
            RGB = 24'hFFB815;
        8'd137:
            RGB = 24'h034598;
        8'd138:
            RGB = 24'hFFC418;
        8'd139:
            RGB = 24'hFECF18;
        8'd140:
            RGB = 24'hFEDD21;
        8'd141:
            RGB = 24'h0459AB;
        8'd142:
            RGB = 24'h398AD9;
        8'd143:
            RGB = 24'h2961AF;
        8'd144:
            RGB = 24'h326BB8;
        8'd145:
            RGB = 24'h1D72BD;
        8'd146:
            RGB = 24'h1E4C9D;
        8'd147:
            RGB = 24'h213D57;
        8'd148:
            RGB = 24'h3779D0;
        8'd149:
            RGB = 24'h265592;
        8'd150:
            RGB = 24'h3C90D8;
        8'd151:
            RGB = 24'h287FD4;
        8'd152:
            RGB = 24'h2D5E80;
        8'd153:
            RGB = 24'h3685D8;
        8'd154:
            RGB = 24'h4295BC;
        8'd155:
            RGB = 24'hCE1944;
        8'd156:
            RGB = 24'hF10A47;
        8'd157:
            RGB = 24'hC80427;
        8'd158:
            RGB = 24'hE52754;
        8'd159:
            RGB = 24'hE60233;
        8'd160:
            RGB = 24'hF33E66;
        8'd161:
            RGB = 24'hF66279;
        8'd162:
            RGB = 24'hF0869E;
        8'd163:
            RGB = 24'hC94054;
        8'd164:
            RGB = 24'hF4A6B7;
        8'd165:
            RGB = 24'hFAC2CD;
        8'd166:
            RGB = 24'hFBD4DD;
        8'd167:
            RGB = 24'hDE525E;
        8'd168:
            RGB = 24'hFEAC20;
        8'd169:
            RGB = 24'h336788;
        8'd170:
            RGB = 24'hFE9D22;
        8'd171:
            RGB = 24'hFD672B;
        8'd172:
            RGB = 24'hFE743F;
        8'd173:
            RGB = 24'h3D94D8;
        8'd174:
            RGB = 24'hB7E1F0;
        8'd175:
            RGB = 24'hAEDCED;
        8'd176:
            RGB = 24'h3A8DD8;
        8'd177:
            RGB = 24'h43AAE5;
        8'd178:
            RGB = 24'hCF747B;
        8'd179:
            RGB = 24'hDF8882;
        8'd180:
            RGB = 24'hC05B67;
        8'd181:
            RGB = 24'hD1B698;
        8'd182:
            RGB = 24'hD3EFF9;
        8'd183:
            RGB = 24'hC4E8F4;
        8'd184:
            RGB = 24'h9F8E72;
        8'd185:
            RGB = 24'hE8E3CF;
        8'd186:
            RGB = 24'h3F99D7;
        8'd187:
            RGB = 24'h43A3D7;
        8'd188:
            RGB = 24'h9CD4E8;
        8'd189:
            RGB = 24'h409CD7;
        8'd190:
            RGB = 24'hC5A077;
        8'd191:
            RGB = 24'hDC9A58;
        8'd192:
            RGB = 24'hEBAB65;
        8'd193:
            RGB = 24'hF7BB77;
        8'd194:
            RGB = 24'hE3AC76;
        8'd195:
            RGB = 24'hF9C885;
        8'd196:
            RGB = 24'hFDD798;
        8'd197:
            RGB = 24'hFEB754;
        8'd198:
            RGB = 24'hFEA73E;
        8'd199:
            RGB = 24'hFEDFAD;
        8'd200:
            RGB = 24'hFFEFA1;
        8'd201:
            RGB = 24'h4487A1;
        8'd202:
            RGB = 24'hFFE6B0;
        8'd203:
            RGB = 24'hFFF0B3;
        8'd204:
            RGB = 24'hFFF4C0;
        8'd205:
            RGB = 24'hFFF8D0;
        8'd206:
            RGB = 24'hFFF6B4;
        8'd207:
            RGB = 24'h3D97D7;
        8'd208:
            RGB = 24'hE5DBB4;
        8'd209:
            RGB = 24'hEEBD8B;
        8'd210:
            RGB = 24'hFECD32;
        8'd211:
            RGB = 24'hFDDB57;
        8'd212:
            RGB = 24'hFE8253;
        8'd213:
            RGB = 24'h44A7D9;
        8'd214:
            RGB = 24'h41A0D6;
        8'd215:
            RGB = 24'hFF9F78;
        8'd216:
            RGB = 24'hFF9065;
        8'd217:
            RGB = 24'hF3CA9A;
        8'd218:
            RGB = 24'hFFAE8D;
        8'd219:
            RGB = 24'hFDD7AB;
        8'd220:
            RGB = 24'hFEEC77;
        8'd221:
            RGB = 24'h48B2D6;
        8'd222:
            RGB = 24'h45A9D5;
        8'd223:
            RGB = 24'hFFBFA3;
        8'd224:
            RGB = 24'h54808A;
        8'd225:
            RGB = 24'h49675C;
        8'd226:
            RGB = 24'h4C7078;
        8'd227:
            RGB = 24'h5F8C90;
        8'd228:
            RGB = 24'h4ABDE6;
        8'd229:
            RGB = 24'h50C3D5;
        8'd230:
            RGB = 24'h53A9B4;
        8'd231:
            RGB = 24'h59CDDB;
        8'd232:
            RGB = 24'h79CEDB;
        8'd233:
            RGB = 24'hFFCEB8;
        8'd234:
            RGB = 24'h4CBCD4;
        8'd235:
            RGB = 24'hFEDECA;
        8'd236:
            RGB = 24'h79C2BF;
        8'd237:
            RGB = 24'hFCEF43;
        8'd238:
            RGB = 24'hFCF654;
        8'd239:
            RGB = 24'hD0CF6C;
        8'd240:
            RGB = 24'hFEE8E0;
        8'd241:
            RGB = 24'hFDE835;
        8'd242:
            RGB = 24'h61937F;
        8'd243:
            RGB = 24'h68D8DF;
        8'd244:
            RGB = 24'h354A01;
        8'd245:
            RGB = 24'h61936C;
        8'd246:
            RGB = 24'h73E1E5;
        8'd247:
            RGB = 24'h57D8FE;
        8'd248:
            RGB = 24'h436FED;
        8'd249:
            RGB = 24'h629857;
        8'd250:
            RGB = 24'h679E2F;
        8'd251:
            RGB = 24'h62961E;
        8'd252:
            RGB = 24'h8E9905;
        8'd253:
            RGB = 24'h647404;
        8'd254:
            RGB = 24'h425503;
        8'd255:
            RGB = 24'h828E05;
        default:
            RGB = 24'hFFFFFF;
    endcase
    end

endmodule


module cursor_palette (
    input logic [1:0] cursor_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(cursor_color_Idx)
            16'd0:
            begin
                Red = 8'hFF;
                Green = 8'hFF;
                Blue = 8'h00;
            end
            16'd1:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd2:
            begin
                Red = 8'hFF;
                Green = 8'hFF;
                Blue = 8'hFF;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module startbutton_palette (
    input logic [3:0] startbutton_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(startbutton_color_Idx)
            16'd0:
            begin
                Red = 8'h27;
                Green = 8'h26;
                Blue = 8'h25;
            end
            16'd1:
            begin
                Red = 8'h27;
                Green = 8'h27;
                Blue = 8'h27;
            end
            16'd2:
            begin
                Red = 8'h61;
                Green = 8'h4D;
                Blue = 8'h37;
            end
            16'd3:
            begin
                Red = 8'hA2;
                Green = 8'h7F;
                Blue = 8'h56;
            end
            16'd4:
            begin
                Red = 8'h23;
                Green = 8'h23;
                Blue = 8'h23;
            end
            16'd5:
            begin
                Red = 8'h21;
                Green = 8'h21;
                Blue = 8'h21;
            end
            16'd6:
            begin
                Red = 8'h30;
                Green = 8'h48;
                Blue = 8'h20;
            end
            16'd7:
            begin
                Red = 8'h3A;
                Green = 8'h33;
                Blue = 8'h2B;
            end
            16'd8:
            begin
                Red = 8'h58;
                Green = 8'h90;
                Blue = 8'h30;
            end
            16'd9:
            begin
                Red = 8'h52;
                Green = 8'h43;
                Blue = 8'h33;
            end
            16'd10:
            begin
                Red = 8'h84;
                Green = 8'h69;
                Blue = 8'h4B;
            end
            16'd11:
            begin
                Red = 8'h94;
                Green = 8'h74;
                Blue = 8'h50;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module status_palette (
    input logic [2:0] status_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(status_color_Idx)
            16'd0:
            begin
                Red = 8'hC0;
                Green = 8'hC0;
                Blue = 8'hC0;
            end
            16'd1:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd2:
            begin
                Red = 8'hF8;
                Green = 8'hF8;
                Blue = 8'hF8;
            end
            16'd3:
            begin
                Red = 8'h9D;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd4:
            begin
                Red = 8'hF5;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd5:
            begin
                Red = 8'hFF;
                Green = 8'h79;
                Blue = 8'h00;
            end
            16'd6:
            begin
                Red = 8'hFF;
                Green = 8'hBF;
                Blue = 8'h00;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module ending_palette (
    input logic [3:0] end_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(end_color_Idx)
            16'd0:
            begin
                Red = 8'hFF;
                Green = 8'hFF;
                Blue = 8'hFF;
            end
            16'd1:
            begin
                Red = 8'hF0;
                Green = 8'hF0;
                Blue = 8'hF0;
            end
            16'd2:
            begin
                Red = 8'h23;
                Green = 8'h23;
                Blue = 8'h23;
            end
            16'd3:
            begin
                Red = 8'h32;
                Green = 8'h32;
                Blue = 8'h32;
            end
            16'd4:
            begin
                Red = 8'h3F;
                Green = 8'h3F;
                Blue = 8'h3F;
            end
            16'd5:
            begin
                Red = 8'h4F;
                Green = 8'h4F;
                Blue = 8'h4F;
            end
            16'd6:
            begin
                Red = 8'h5E;
                Green = 8'h5E;
                Blue = 8'h5E;
            end
            16'd7:
            begin
                Red = 8'h6C;
                Green = 8'h6C;
                Blue = 8'h6C;
            end
            16'd8:
            begin
                Red = 8'h7B;
                Green = 8'h7B;
                Blue = 8'h7B;
            end
            16'd9:
            begin
                Red = 8'h8A;
                Green = 8'h8A;
                Blue = 8'h8A;
            end
            16'd10:
            begin
                Red = 8'h98;
                Green = 8'h98;
                Blue = 8'h98;
            end
            16'd11:
            begin
                Red = 8'hA7;
                Green = 8'hA7;
                Blue = 8'hA7;
            end
            16'd12:
            begin
                Red = 8'hB6;
                Green = 8'hB6;
                Blue = 8'hB6;
            end
            16'd13:
            begin
                Red = 8'hC4;
                Green = 8'hC4;
                Blue = 8'hC4;
            end
            16'd14:
            begin
                Red = 8'hD3;
                Green = 8'hD3;
                Blue = 8'hD3;
            end
            16'd15:
            begin
                Red = 8'hE2;
                Green = 8'hE2;
                Blue = 8'hE2;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module player1_palette (
    input logic [5:0] player_color_Idx_1,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(player_color_Idx_1)
            16'd0:
            begin
                Red = 8'hFF;
                Green = 8'hFF;
                Blue = 8'h00;
            end
            16'd1:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd2:
            begin
                Red = 8'hE8;
                Green = 8'hE8;
                Blue = 8'hE8;
            end
            16'd3:
            begin
                Red = 8'hF8;
                Green = 8'hF8;
                Blue = 8'hF8;
            end
            16'd4:
            begin
                Red = 8'h60;
                Green = 8'h60;
                Blue = 8'h60;
            end
            16'd5:
            begin
                Red = 8'hB0;
                Green = 8'hB0;
                Blue = 8'hB0;
            end
            16'd6:
            begin
                Red = 8'hC0;
                Green = 8'hC0;
                Blue = 8'hC0;
            end
            16'd7:
            begin
                Red = 8'hA0;
                Green = 8'h98;
                Blue = 8'hA0;
            end
            16'd8:
            begin
                Red = 8'hD0;
                Green = 8'h38;
                Blue = 8'h00;
            end
            16'd9:
            begin
                Red = 8'hF8;
                Green = 8'hB8;
                Blue = 8'h90;
            end
            16'd10:
            begin
                Red = 8'hA0;
                Green = 8'h88;
                Blue = 8'h50;
            end
            16'd11:
            begin
                Red = 8'h58;
                Green = 8'hA0;
                Blue = 8'hF8;
            end
            16'd12:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h58;
            end
            16'd13:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'hF8;
            end
            16'd14:
            begin
                Red = 8'hB8;
                Green = 8'h00;
                Blue = 8'h88;
            end
            16'd15:
            begin
                Red = 8'hF8;
                Green = 8'h38;
                Blue = 8'hC0;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module player2_palette (
    input logic [5:0] player_color_Idx_2,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(player_color_Idx_2)
            16'd0:
            begin
                Red = 8'hFF;
                Green = 8'hFF;
                Blue = 8'h00;
            end
            16'd1:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd2:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd3:
            begin
                Red = 8'hF8;
                Green = 8'hF8;
                Blue = 8'hF8;
            end
            16'd4:
            begin
                Red = 8'h60;
                Green = 8'h60;
                Blue = 8'h60;
            end
            16'd5:
            begin
                Red = 8'hB0;
                Green = 8'hB0;
                Blue = 8'hB0;
            end
            16'd6:
            begin
                Red = 8'hC0;
                Green = 8'hC0;
                Blue = 8'hC0;
            end
            16'd7:
            begin
                Red = 8'hA0;
                Green = 8'h98;
                Blue = 8'hA0;
            end
            16'd8:
            begin
                Red = 8'hD0;
                Green = 8'h38;
                Blue = 8'h00;
            end
            16'd9:
            begin
                Red = 8'hF8;
                Green = 8'hB8;
                Blue = 8'h90;
            end
            16'd10:
            begin
                Red = 8'hA0;
                Green = 8'h88;
                Blue = 8'h50;
            end
            16'd11:
            begin
                Red = 8'h58;
                Green = 8'hA0;
                Blue = 8'hF8;
            end
            16'd12:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h58;
            end
            16'd13:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'hF8;
            end
            16'd14:
            begin
                Red = 8'hB8;
                Green = 8'h00;
                Blue = 8'h88;
            end
            16'd15:
            begin
                Red = 8'hF8;
                Green = 8'h38;
                Blue = 8'hC0;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module room_palette (
    input logic [3:0] room_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(room_color_Idx)
            16'd0:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd1:
            begin
                Red = 8'h78;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd2:
            begin
                Red = 8'hA0;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd3:
            begin
                Red = 8'hD8;
                Green = 8'h50;
                Blue = 8'h00;
            end
            16'd4:
            begin
                Red = 8'h70;
                Green = 8'h50;
                Blue = 8'h28;
            end
            16'd5:
            begin
                Red = 8'hF8;
                Green = 8'h70;
                Blue = 8'h00;
            end
            16'd6:
            begin
                Red = 8'hF8;
                Green = 8'h90;
                Blue = 8'h00;
            end
            16'd7:
            begin
                Red = 8'h50;
                Green = 8'h40;
                Blue = 8'h18;
            end
            16'd8:
            begin
                Red = 8'h40;
                Green = 8'h28;
                Blue = 8'h00;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module explosion_palette (
    input logic [2:0] explosion_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(explosion_color_Idx)
            16'd0:
            begin
                Red = 8'hC0;
                Green = 8'hC0;
                Blue = 8'hC0;
            end
            16'd1:
            begin
                Red = 8'hF8;
                Green = 8'hF8;
                Blue = 8'hF8;
            end
            16'd2:
            begin
                Red = 8'h8C;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd3:
            begin
                Red = 8'h9E;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd4:
            begin
                Red = 8'hD1;
                Green = 8'h02;
                Blue = 8'h00;
            end
            16'd5:
            begin
                Red = 8'hFF;
                Green = 8'h48;
                Blue = 8'h00;
            end
            16'd6:
            begin
                Red = 8'hFF;
                Green = 8'hAD;
                Blue = 8'h00;
            end
            16'd7:
            begin
                Red = 8'hF7;
                Green = 8'hFA;
                Blue = 8'h00;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module tree_palette (
    input logic [3:0] tree_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(tree_color_Idx)
            16'd0:
            begin
                Red = 8'h70;
                Green = 8'h50;
                Blue = 8'h28;
            end
            16'd1:
            begin
                Red = 8'h98;
                Green = 8'h70;
                Blue = 8'h40;
            end
            16'd2:
            begin
                Red = 8'h58;
                Green = 8'h40;
                Blue = 8'h18;
            end
            16'd3:
            begin
                Red = 8'hC8;
                Green = 8'hA0;
                Blue = 8'h60;
            end
            16'd4:
            begin
                Red = 8'hD0;
                Green = 8'hB8;
                Blue = 8'h90;
            end
            16'd5:
            begin
                Red = 8'h40;
                Green = 8'h28;
                Blue = 8'h00;
            end
            16'd6:
            begin
                Red = 8'h30;
                Green = 8'h48;
                Blue = 8'h20;
            end
            16'd7:
            begin
                Red = 8'h78;
                Green = 8'hA8;
                Blue = 8'h58;
            end
            16'd8:
            begin
                Red = 8'h58;
                Green = 8'h90;
                Blue = 8'h30;
            end
            16'd9:
            begin
                Red = 8'h30;
                Green = 8'h58;
                Blue = 8'h30;
            end
            16'd10:
            begin
                Red = 8'h30;
                Green = 8'h58;
                Blue = 8'h30;
            end
            16'd11:
            begin
                Red = 8'h30;
                Green = 8'h78;
                Blue = 8'h38;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module shoe_palette (
    input logic [3:0] shoe_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(shoe_color_Idx)
            16'd0:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h10;
            end
            16'd1:
            begin
                Red = 8'hF8;
                Green = 8'hF8;
                Blue = 8'hF8;
            end
            16'd2:
            begin
                Red = 8'hF8;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd3:
            begin
                Red = 8'hF8;
                Green = 8'hA8;
                Blue = 8'h00;
            end
            16'd4:
            begin
                Red = 8'h00;
                Green = 8'hE0;
                Blue = 8'h00;
            end
            16'd5:
            begin
                Red = 8'h28;
                Green = 8'h40;
                Blue = 8'h50;
            end
            16'd6:
            begin
                Red = 8'h38;
                Green = 8'h60;
                Blue = 8'h78;
            end
            16'd7:
            begin
                Red = 8'h00;
                Green = 8'h80;
                Blue = 8'hA8;
            end
            16'd8:
            begin
                Red = 8'h68;
                Green = 8'hA8;
                Blue = 8'hF8;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module bomb_palette (
    input logic [4:0] bomb_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(bomb_color_Idx)
            16'd0:
            begin
                Red = 8'hFE;
                Green = 8'hFF;
                Blue = 8'h00;
            end
            16'd1:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd2:
            begin
                Red = 8'h05;
                Green = 8'h29;
                Blue = 8'h28;
            end
            16'd3:
            begin
                Red = 8'hF8;
                Green = 8'hF8;
                Blue = 8'hF8;
            end
            16'd4:
            begin
                Red = 8'hFF;
                Green = 8'h00;
                Blue = 8'h00;
            end
            16'd5:
            begin
                Red = 8'hFF;
                Green = 8'hA5;
                Blue = 8'h00;
            end
            16'd6:
            begin
                Red = 8'h82;
                Green = 8'hA1;
                Blue = 8'h8F;
            end
            16'd7:
            begin
                Red = 8'h39;
                Green = 8'h59;
                Blue = 8'h58;
            end
            16'd8:
            begin
                Red = 8'h18;
                Green = 8'h39;
                Blue = 8'h38;
            end
            16'd9:
            begin
                Red = 8'h20;
                Green = 8'h40;
                Blue = 8'h52;
            end
            16'd10:
            begin
                Red = 8'h2A;
                Green = 8'h61;
                Blue = 8'h7B;
            end
            16'd11:
            begin
                Red = 8'h7C;
                Green = 8'hD2;
                Blue = 8'hEB;
            end
            16'd12:
            begin
                Red = 8'h45;
                Green = 8'h91;
                Blue = 8'hC5;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule

module grass_palette (
    input logic [1:0] grass_color_Idx,
    output logic [7:0] Red, Green, Blue
);

    always_comb begin
        case(grass_color_Idx)
            16'd0:
            begin
                Red = 8'h78;
                Green = 8'hA8;
                Blue = 8'h58;
            end
            16'd1:
            begin
                Red = 8'h58;
                Green = 8'h90;
                Blue = 8'h30;
            end
            16'd2:
            begin
                Red = 8'h30;
                Green = 8'h78;
                Blue = 8'h38;
            end
            default:
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        endcase
    end
endmodule
