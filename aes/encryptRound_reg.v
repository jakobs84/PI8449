module encryptRound(clk, reset, in,key,out);
input clk;
input reset;
input [127:0] in;
output [127:0] out;
input [127:0] key;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;
wire [127:0] afterMixColumns;
wire [127:0] afterAddroundKey;

reg [127:0] out;
wire [127:0] out_internal;

subBytes s(in,afterSubBytes);
shiftRows r(afterSubBytes,afterShiftRows);
mixColumns m(afterShiftRows,afterMixColumns);
addRoundKey b(afterMixColumns,out_internal,key);
		
//--------------------------------------------
always @(posedge clk or posedge reset)
    if (reset == 1'b1)
        out <= 127'b0;
    else
        out <= out_internal;
//-------

endmodule