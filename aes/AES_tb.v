module AES_tb();

wire e128;
wire d128;
wire e192;
wire d192;
wire e256;
wire d256;
reg enable;
reg reset;
reg clk;


AES a(clk, reset, enable, e128, d128, e192, d192, e256, d256);



initial begin
	clk = 1'b0;
	forever #5 clk = ~clk;
end



initial begin

	#10;
	reset = 1'b0;
	#10;
	reset = 1'b1;
	#200;
	reset = 1'b0;


	$monitor("Encrypt128 = %b, Decrypt128 = %b, Encrypt192 = %b, Decrypt192 = %b, Encrypt256 = %b, Decrypt256 = %b",
		e128, d128, e192, d192, e256, d256);
		
	// Turning on enable to check that all tests passed
	enable = 1;
	#10;
	
	// Turning off enable to check if the leds turn off
	enable = 0;
	#10;
	
	// Turning on enable to check if the leds turn on again
	enable = 1;
	#10;
end

endmodule
