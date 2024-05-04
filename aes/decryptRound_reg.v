module decryptRound(clk, reset, in,key,out);
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

inverseShiftRows r(in,afterShiftRows);
inverseSubBytes s(afterShiftRows,afterSubBytes);
addRoundKey b(afterSubBytes,afterAddroundKey,key);
inverseMixColumns m(afterAddroundKey,out_internal);

//--------------------------------------------
always @(posedge clk or posedge reset)
    if (reset == 1'b1)
        out <= 127'b0;
    else
        out <= out_internal;
//--------------------------------------------

endmodule