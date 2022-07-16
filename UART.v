module UART (
input  wire CLK,
input  wire RST,
input  wire [7:0] A,
input  wire Data_Valid,
input  wire Parity_Type,
input  wire Parity_Enable,
output wire Busy,
output wire S_Data
);

//wire Declaration
wire Serializer_Enable_U;
wire [1:0] Mux_Selection_U;
wire FSM_Sequencer_U;
wire Data_U;
wire Parity_U;

//module instantiation
Serializer U1 (
.CLK(CLK),
.RST(RST),
.A(A),
.Serializer_Enable_S(Serializer_Enable_U),
.FSM_Sequencer(FSM_Sequencer_U),
.OUT_S(Data_U)
);

FSM U2 (
.Parity_Enable(Parity_Enable),
.Parity_Type(Parity_Type),
.Data_Valid(Data_Valid),
.Sequencer(FSM_Sequencer_U),
.CLK(CLK),
.RST(RST),
.Serializer_Enable(Serializer_Enable_U),
.Mux_Selection(Mux_Selection_U),
.Busy(Busy)
);

MUX U3 (
.Stop(1'b1),
.Start(1'b0),
.Data(Data_U),
.Parity(Parity_U),
.Sel(Mux_Selection_U),
.OUT_M(S_Data)
);

Parity U4(
.A(A),
.Parity_Enable_P(Parity_Enable),
.Parity_Type_P(Parity_Type),
.OUT_P(Parity_U)
);

endmodule