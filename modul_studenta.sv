module modul_studenta (
    input  logic        rst,
    input  logic        clk,

    output logic        s_axil_awready,
    input  wire         s_axil_awvalid,
    input  wire [20:0]  s_axil_awaddr,
    input  wire [2:0]   s_axil_awprot,
    output logic        s_axil_wready,
    input  wire         s_axil_wvalid,
    input  wire [31:0]  s_axil_wdata,
    input  wire [3:0]   s_axil_wstrb,
    input  wire         s_axil_bready,
    output logic        s_axil_bvalid,
    output logic [1:0]  s_axil_bresp,
    output logic        s_axil_arready,
    input  wire         s_axil_arvalid,
    input  wire [20:0]  s_axil_araddr,
    input  wire [2:0]   s_axil_arprot,
    input  wire         s_axil_rready,
    output logic        s_axil_rvalid,
    output logic [31:0] s_axil_rdata,
    output logic [1:0]  s_axil_rresp,

    output logic [7:0]  LED
);

import registers_pkg::*;

registers_pkg::registers__out_t hwif_out;
registers_pkg::registers__in_t hwif_in;


logic         enable   ;
logic [127:0] i_text   ;
logic [127:0] key      ;
logic [3:0]   round    ;
logic [127:0] o_text   ;
logic [127:0] Rkey     ;
logic         done     ;





//------------------------------------------
//------------- Registers ------------------
//------------------------------------------
registers u_registers (
    .clk                (clk),
    .rst                (rst),

    .s_axil_awready     (s_axil_awready),
    .s_axil_awvalid     (s_axil_awvalid),
    .s_axil_awaddr      (s_axil_awaddr),
    .s_axil_awprot      (s_axil_awprot),

    .s_axil_wready      (s_axil_wready),
    .s_axil_wvalid      (s_axil_wvalid),
    .s_axil_wdata       (s_axil_wdata),
    .s_axil_wstrb       (s_axil_wstrb),

    .s_axil_bready      (s_axil_bready),
    .s_axil_bvalid      (s_axil_bvalid),
    .s_axil_bresp       (s_axil_bresp),

    .s_axil_arready     (s_axil_arready),
    .s_axil_arvalid     (s_axil_arvalid),
    .s_axil_araddr      (s_axil_araddr),
    .s_axil_arprot      (s_axil_arprot),

    .s_axil_rready      (s_axil_rready),
    .s_axil_rvalid      (s_axil_rvalid),
    .s_axil_rdata       (s_axil_rdata),
    .s_axil_rresp       (s_axil_rresp),

    .hwif_out           (hwif_out),
    .hwif_in            (hwif_in)
);


//--------------------------------------------------------------
assign  i_text[31:0]                 =  hwif_out.I_TEXT_0.DATA.value;
assign  i_text[63:32]                =  hwif_out.I_TEXT_1.DATA.value;
assign  i_text[95:64]                =  hwif_out.I_TEXT_2.DATA.value;
assign  i_text[127:96]               =  hwif_out.I_TEXT_3.DATA.value;
//--------------------------------------------------------------
assign  key[31:0]                    =  hwif_out.KEY_0.DATA.value;
assign  key[63:32]                   =  hwif_out.KEY_1.DATA.value;
assign  key[95:64]                   =  hwif_out.KEY_2.DATA.value;
assign  key[127:96]                  =  hwif_out.KEY_3.DATA.value;
//--------------------------------------------------------------
assign  hwif_in.ENCRYPTED_0.DATA.next   = encrypted128[31:0]    ;
assign  hwif_in.ENCRYPTED_1.DATA.next   = encrypted128[63:32]   ;
assign  hwif_in.ENCRYPTED_2.DATA.next   = encrypted128[95:64]   ;
assign  hwif_in.ENCRYPTED_3.DATA.next   = encrypted128[127:96]  ;
//--------------------------------------------------------------
assign  hwif_in.DECRYPTED_0.DATA.next   = decrypted128[31:0]      ;
assign  hwif_in.DECRYPTED_1.DATA.next   = decrypted128[63:32]     ;
assign  hwif_in.DECRYPTED_2.DATA.next   = decrypted128[95:64]     ;
assign  hwif_in.DECRYPTED_3.DATA.next   = decrypted128[127:96]    ;
//--------------------------------------------------------------

logic [127:0] encrypted128;
logic [127:0] decrypted128;



// AES_Encrypt AES_Encrypt_inst (
//     .clk   (clk           )  ,
//     .reset (rst           )  ,
//     .in    (i_text        )  ,
//     .key   (key           )  ,
//     .out   (encrypted128  )  );


AES_Decrypt AES_Decrypt_inst (
    .clk   (clk           )  ,
    .reset (rst           )  ,
    .in    ( i_text ) ,
    // .in    ( encrypted128 ) ,
    .key   ( key          ) ,
    .out   ( decrypted128 ) );



`ifdef FSM_DEBUG

(* noprune *) logic [SIZE-1:0]  DEBUG_state        ;// Seq part of the FSM
(* noprune *) logic [SIZE-1:0]  DEBUG_next_state   ;// combo part of FSM
(* noprune *) logic [7:0]       DEBUG_LEDLogic     ;
(* noprune *) logic             DEBUG_FSM_enable   ;
(* noprune *) logic [31:0]      DEBUG_fsm_counter  ;


always_ff @(posedge clk) begin

    DEBUG_state       <= state       ;
    DEBUG_next_state  <= next_state  ;
    DEBUG_LEDLogic    <= LEDLogic    ;
    DEBUG_FSM_enable  <= FSM_enable  ;
    DEBUG_fsm_counter <= fsm_counter ;
end
`endif






endmodule