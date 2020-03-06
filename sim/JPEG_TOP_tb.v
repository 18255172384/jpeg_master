`timescale 1ns/1ns
module JPEG_TOP_tb;

	parameter[15:0] 	PIC_WIDTH = 16'd32;
	parameter[15:0] 	PIC_HEIGHT = 16'd24;
	parameter[5:0]    PIC_ENC_OUT_WIDTH = 6'd24;
	parameter[5:0]    PIC_PIX_WIDTH = 6'd24;
	
	reg 							   clk;
	reg 							   rst_n;
	reg								pic_blk_go_i;
	reg								pic_frame_i;
	reg signed[7:0]						pic_data_in_i;
	wire[PIC_ENC_OUT_WIDTH-1:0]		pic_encode_seq_o;
	wire							pic_encode_valid_o;
	
	reg signed[8:0] 						pic_data_in[PIC_HEIGHT-1:0][PIC_WIDTH-1:0];
	reg signed[7:0] 						pict_in[7:0][7:0];

	reg [15:0] i,j,p,q;
	reg [3:0] k,l,m,n; 
	integer     fp;
	
	integer		sv_fp;
	integer		times;

reg[7:0] peg_header[327:0]; 
	always@(posedge clk)
		begin
			peg_header[0] <= 8'hFF;   peg_header[1] <= 8'hD8;   peg_header[2] <= 8'hFF;   peg_header[3] <= 8'hE0;   peg_header[4] <= 8'h00;   peg_header[5] <= 8'h10;   peg_header[6] <= 8'h4A;   peg_header[7] <= 8'h46;   peg_header[8] <= 8'h49;   peg_header[9] <= 8'h46;   peg_header[10] <= 8'h00;  peg_header[11] <= 8'h01;  peg_header[12] <= 8'h01;  peg_header[13] <= 8'h00;  peg_header[14] <= 8'h00;  peg_header[15] <= 8'h01; 
			peg_header[16] <= 8'h00;  peg_header[17] <= 8'h01;  peg_header[18] <= 8'h00;  peg_header[19] <= 8'h00;  peg_header[20] <= 8'hFF;  peg_header[21] <= 8'hDB;  peg_header[22] <= 8'h00;  peg_header[23] <= 8'h43;  peg_header[24] <= 8'h00;  peg_header[25] <= 8'h10;  peg_header[26] <= 8'h0B;  peg_header[27] <= 8'h0C;  peg_header[28] <= 8'h0E;  peg_header[29] <= 8'h0C;  peg_header[30] <= 8'h0A;  peg_header[31] <= 8'h10; 
			peg_header[32] <= 8'h0E;  peg_header[33] <= 8'h0D;  peg_header[34] <= 8'h0E;  peg_header[35] <= 8'h12;  peg_header[36] <= 8'h11;  peg_header[37] <= 8'h10;  peg_header[38] <= 8'h13;  peg_header[39] <= 8'h18;  peg_header[40] <= 8'h28;  peg_header[41] <= 8'h1A;  peg_header[42] <= 8'h18;  peg_header[43] <= 8'h16;  peg_header[44] <= 8'h16;  peg_header[45] <= 8'h18;  peg_header[46] <= 8'h31;  peg_header[47] <= 8'h23; 
			peg_header[48] <= 8'h25;  peg_header[49] <= 8'h1D;  peg_header[50] <= 8'h28;  peg_header[51] <= 8'h3A;  peg_header[52] <= 8'h33;  peg_header[53] <= 8'h3D;  peg_header[54] <= 8'h3C;  peg_header[55] <= 8'h39;  peg_header[56] <= 8'h33;  peg_header[57] <= 8'h38;  peg_header[58] <= 8'h37;  peg_header[59] <= 8'h40;  peg_header[60] <= 8'h48;  peg_header[61] <= 8'h5C;  peg_header[62] <= 8'h4E;  peg_header[63] <= 8'h40; 
			peg_header[64] <= 8'h44;  peg_header[65] <= 8'h57;  peg_header[66] <= 8'h45;  peg_header[67] <= 8'h37;  peg_header[68] <= 8'h38;  peg_header[69] <= 8'h50;  peg_header[70] <= 8'h6D;  peg_header[71] <= 8'h51;  peg_header[72] <= 8'h57;  peg_header[73] <= 8'h5F;  peg_header[74] <= 8'h62;  peg_header[75] <= 8'h67;  peg_header[76] <= 8'h68;  peg_header[77] <= 8'h67;  peg_header[78] <= 8'h3E;  peg_header[79] <= 8'h4D; 
			peg_header[80] <= 8'h71;  peg_header[81] <= 8'h79;  peg_header[82] <= 8'h70;  peg_header[83] <= 8'h64;  peg_header[84] <= 8'h78; peg_header[85] <= 8'h5C; peg_header[86] <= 8'h65; peg_header[87] <= 8'h67; peg_header[88] <= 8'h63; peg_header[89] <= 8'hFF; peg_header[90] <= 8'hC0; peg_header[91] <= 8'h00; peg_header[92] <= 8'h0B; peg_header[93] <= 8'h08; peg_header[94] <= PIC_HEIGHT[15:8]; peg_header[95] <= PIC_HEIGHT[7:0]; 
			peg_header[96] <= PIC_WIDTH[15:8];peg_header[97] <= PIC_WIDTH[7:0]; peg_header[98] <= 8'h01; peg_header[99] <= 8'h01; peg_header[100] <= 8'h11; peg_header[101] <= 8'h00; peg_header[102] <= 8'hFF; peg_header[103] <= 8'hC4; peg_header[104] <= 8'h00; peg_header[105] <= 8'h1F; peg_header[106] <= 8'h00; peg_header[107] <= 8'h00; peg_header[108] <= 8'h01; peg_header[109] <= 8'h05; peg_header[110] <= 8'h01; peg_header[111] <= 8'h01; 
			peg_header[112] <= 8'h01; peg_header[113] <= 8'h01; peg_header[114] <= 8'h01; peg_header[115] <= 8'h01; peg_header[116] <= 8'h00; peg_header[117] <= 8'h00; peg_header[118] <= 8'h00; peg_header[119] <= 8'h00; peg_header[120] <= 8'h00; peg_header[121] <= 8'h00; peg_header[122] <= 8'h00; peg_header[123] <= 8'h00; peg_header[124] <= 8'h01; peg_header[125] <= 8'h02; peg_header[126] <= 8'h03; peg_header[127] <= 8'h04; 
			peg_header[128] <= 8'h05; peg_header[129] <= 8'h06; peg_header[130] <= 8'h07; peg_header[131] <= 8'h08; peg_header[132] <= 8'h09; peg_header[133] <= 8'h0A; peg_header[134] <= 8'h0B; peg_header[135] <= 8'hFF; peg_header[136] <= 8'hC4; peg_header[137] <= 8'h00; peg_header[138] <= 8'hB5; peg_header[139] <= 8'h10; peg_header[140] <= 8'h00; peg_header[141] <= 8'h02; peg_header[142] <= 8'h01; peg_header[143] <= 8'h03; 
			peg_header[144] <= 8'h03; peg_header[145] <= 8'h02; peg_header[146] <= 8'h04; peg_header[147] <= 8'h03; peg_header[148] <= 8'h05; peg_header[149] <= 8'h05; peg_header[150] <= 8'h04; peg_header[151] <= 8'h04; peg_header[152] <= 8'h00; peg_header[153] <= 8'h00; peg_header[154] <= 8'h01; peg_header[155] <= 8'h7D; peg_header[156] <= 8'h01; peg_header[157] <= 8'h02; peg_header[158] <= 8'h03; peg_header[159] <= 8'h00; 
			peg_header[160] <= 8'h04; peg_header[161] <= 8'h11; peg_header[162] <= 8'h05; peg_header[163] <= 8'h12; peg_header[164] <= 8'h21; peg_header[165] <= 8'h31; peg_header[166] <= 8'h41; peg_header[167] <= 8'h06; peg_header[168] <= 8'h13; peg_header[169] <= 8'h51; peg_header[170] <= 8'h61; peg_header[171] <= 8'h07; peg_header[172] <= 8'h22; peg_header[173] <= 8'h71; peg_header[174] <= 8'h14; peg_header[175] <= 8'h32; 
			peg_header[176] <= 8'h81; peg_header[177] <= 8'h91; peg_header[178] <= 8'hA1; peg_header[179] <= 8'h08; peg_header[180] <= 8'h23; peg_header[181] <= 8'h42; peg_header[182] <= 8'hB1; peg_header[183] <= 8'hC1; peg_header[184] <= 8'h15; peg_header[185] <= 8'h52; peg_header[186] <= 8'hD1; peg_header[187] <= 8'hF0; peg_header[188] <= 8'h24; peg_header[189] <= 8'h33; peg_header[190] <= 8'h62; peg_header[191] <= 8'h72; 
			peg_header[192] <= 8'h82; peg_header[193] <= 8'h09; peg_header[194] <= 8'h0A; peg_header[195] <= 8'h16; peg_header[196] <= 8'h17; peg_header[197] <= 8'h18; peg_header[198] <= 8'h19; peg_header[199] <= 8'h1A; peg_header[200] <= 8'h25; peg_header[201] <= 8'h26; peg_header[202] <= 8'h27; peg_header[203] <= 8'h28; peg_header[204] <= 8'h29; peg_header[205] <= 8'h2A; peg_header[206] <= 8'h34; peg_header[207] <= 8'h35; 
			peg_header[208] <= 8'h36; peg_header[209] <= 8'h37; peg_header[210] <= 8'h38; peg_header[211] <= 8'h39; peg_header[212] <= 8'h3A; peg_header[213] <= 8'h43; peg_header[214] <= 8'h44; peg_header[215] <= 8'h45; peg_header[216] <= 8'h46; peg_header[217] <= 8'h47; peg_header[218] <= 8'h48; peg_header[219] <= 8'h49; peg_header[220] <= 8'h4A; peg_header[221] <= 8'h53; peg_header[222] <= 8'h54; peg_header[223] <= 8'h55;
			peg_header[224] <= 8'h56; peg_header[225] <= 8'h57; peg_header[226] <= 8'h58; peg_header[227] <= 8'h59; peg_header[228] <= 8'h5A; peg_header[229] <= 8'h63; peg_header[230] <= 8'h84; peg_header[231] <= 8'h85; peg_header[232] <= 8'h86; peg_header[233] <= 8'h87; peg_header[234] <= 8'h88; peg_header[235] <= 8'h89; peg_header[236] <= 8'h8A; peg_header[237] <= 8'h92; peg_header[238] <= 8'h93; peg_header[239] <= 8'h94; 
			peg_header[240] <= 8'h76; peg_header[241] <= 8'h77; peg_header[242] <= 8'h78; peg_header[243] <= 8'h79; peg_header[244] <= 8'h7A; peg_header[245] <= 8'h83; peg_header[246] <= 8'h84; peg_header[247] <= 8'h85; peg_header[248] <= 8'h86; peg_header[249] <= 8'h87; peg_header[250] <= 8'h88; peg_header[260] <= 8'h89; peg_header[261] <= 8'h8A; peg_header[262] <= 8'h92; peg_header[263] <= 8'h93;peg_header[264] <=  8'h94; 
			peg_header[256] <= 8'h95; peg_header[257] <= 8'h96; peg_header[258] <= 8'h97; peg_header[259] <= 8'h98; peg_header[260] <= 8'h99; peg_header[261] <= 8'h9A; peg_header[262] <= 8'hA2; peg_header[263] <= 8'hA3; peg_header[264] <= 8'hA4; peg_header[265] <= 8'hA5; peg_header[266] <= 8'hA6; peg_header[267] <= 8'hA7; peg_header[268] <= 8'hA8; peg_header[269] <= 8'hA9; peg_header[270] <= 8'hAA; peg_header[271] <= 8'hB2; 
			peg_header[272] <= 8'hB3; peg_header[273] <= 8'hB4; peg_header[274] <= 8'hB5; peg_header[275] <= 8'hB6; peg_header[276] <= 8'hB7; peg_header[277] <= 8'hB8; peg_header[278] <= 8'hB9; peg_header[279] <= 8'hBA; peg_header[280] <= 8'hC2; peg_header[281] <= 8'hC3; peg_header[282] <= 8'hC4; peg_header[283] <= 8'hC5; peg_header[284] <= 8'hC6; peg_header[285] <= 8'hC7; peg_header[286] <= 8'hC8; peg_header[287] <= 8'hC9; 
			peg_header[288] <= 8'hCA; peg_header[289] <= 8'hD2; peg_header[290] <= 8'hD3; peg_header[291] <= 8'hD4; peg_header[292] <= 8'hD5; peg_header[293] <= 8'hD6; peg_header[294] <= 8'hD7; peg_header[295] <= 8'hD8; peg_header[296] <= 8'hD9; peg_header[297] <= 8'hDA; peg_header[298] <= 8'hE1; peg_header[299] <= 8'hE2; peg_header[300] <= 8'hE3; peg_header[301] <= 8'hE4; peg_header[302] <= 8'hE5; peg_header[303] <= 8'hE6; 
			peg_header[304] <= 8'hE7; peg_header[305] <= 8'hE8; peg_header[306] <= 8'hE9; peg_header[307] <= 8'hEA; peg_header[308] <= 8'hF1; peg_header[309] <= 8'hF2; peg_header[310] <= 8'hF3; peg_header[311] <= 8'hF4; peg_header[312] <= 8'hF5; peg_header[313] <= 8'hF6; peg_header[314] <= 8'hF7; peg_header[315] <= 8'hF8; peg_header[316] <= 8'hF9; peg_header[317] <= 8'hFA; peg_header[318] <= 8'hFF; peg_header[319] <= 8'hDA;
			peg_header[320] <= 8'h00; peg_header[321] <= 8'h08; peg_header[322] <= 8'h01; peg_header[323] <= 8'h01; peg_header[324] <= 8'h00; peg_header[325] <= 8'h00; peg_header[326] <= 8'h3F; peg_header[327] <= 8'h00;
		end
		
	JPEG_TOP#(
		.PIC_PIX_WIDTH (24), 
		.PIC_ENC_OUT_WIDTH(24)
	)JPEG_TOP(
		.clk	(clk),
		.rst_n	(rst_n),
		.pic_frame_i (pic_frame_i),
		.pic_blk_go_i	(pic_blk_go_i),
		.pic_data_in_i	(pic_data_in_i),
		.pic_encode_seq_o (pic_encode_seq_o),
		.pic_encode_valid_o (pic_encode_valid_o)
	);
	
	
	
	reg[31:0]		pic_cnt;	
	always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
		pic_cnt <= 'd0;
		sv_fp = $fopen("E:/quartus/jpeg_gillian_two_branch/prj/24x32.jpg","wb");
		for(i = 0;i < 328;i = i + 1)begin
			$fwrite(sv_fp,"%c",peg_header[i]);
		end
	end else if(pic_encode_valid_o)begin
		$display("%h",pic_encode_seq_o);
		$fwrite(sv_fp,"%c",pic_encode_seq_o[23:16]);
		$fwrite(sv_fp,"%c",pic_encode_seq_o[15:8]);
		$fwrite(sv_fp,"%c",pic_encode_seq_o[7:0]);
		pic_cnt <= pic_cnt + 1'b1;
	end	 
	
	initial begin
		rst_n = 0;
		clk = 0;
		pic_blk_go_i = 0;
		times = 0;
		
		fp = $fopen("E:/quartus/jpeg_gillian_two_branch/c/transfer_format/24x32.data","rb");
		if(fp == 0)begin
			$display("open file error %d! ",fp);
			$finish;
		end else begin
			$display("open file success!");
			
		end 

		#500;
		@(posedge clk)
		rst_n = 1;
		#5000;
		@(posedge clk)
		
		for(i = 0;i < PIC_HEIGHT;i=i+1)begin
			for(j = 0;j < PIC_WIDTH;j=j+1)begin
				pic_data_in[i][j] = $fgetc(fp);
			end
		end 
		
		$fclose(fp);

		for(p = 0;p < PIC_HEIGHT;p = p + 8)begin
			for(q = 0;q < PIC_WIDTH;q= q + 8)begin
				
				for(k = 0;k < 8;k=k+1)begin
					for(l = 0;l < 8;l=l+1)begin
						pict_in[k][l] = pic_data_in[p + k][q + l] - 'd128;
					end
				end
				
				for(n = 0; n < 8;n=n+1)begin
					for(m = 0; m < 8;m=m+1)begin
						times = times + 1;
						@(posedge clk)
						pic_data_in_i <= pict_in[n][m];
					if(m==0 && n == 0)begin
						pic_blk_go_i = 1;
					end else begin
						pic_blk_go_i = 0;
					end

					if(m == 0 && n== 0 && p == 0 && q == 0)
						pic_frame_i = 1;
					else
						pic_frame_i = 0;
				end
				
				
			end
		end  
		
		
	end	
	
		repeat(500)@(posedge clk); 
		
		#10000;
		$fwrite(sv_fp,"%s",16'hFFD9);
		$display("pic_proc %d",times);
		//$finish;
		$fclose(sv_fp);
//		$stop; 
		$stop;

end   

initial clk = 1;
always#10 clk = ~clk;

	
endmodule
