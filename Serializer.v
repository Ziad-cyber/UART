module Serializer (
input  wire CLK,
input  wire RST,
input  wire A0,
input  wire A1,
input  wire A2,
input  wire A3,
input  wire A4,
input  wire A5,
input  wire A6,
input  wire A7,
input  wire Serializer_Enable_S,
input  wire Send_Data_S,
output reg  FSM_Sequencer,
output reg  OUT_S
);

reg [7:0] Serializer_S;
reg [3:0] Counter_reg;

always @ (posedge CLK or negedge RST)
    begin
        if (!RST)
            Serializer_S <= 8'b0;
        else if (Serializer_Enable_S)
            Serializer_S <= {A7,A6,A5,A4,A3,A2,A1,A0};
    end

always @ (posedge CLK or negedge RST)
    begin
        if (!RST)
            begin
                OUT_S <= 1'b0;
                Counter_reg <= 4'b0;
                FSM_Sequencer <=1'b0;
            end
        else if (Send_Data_S==1'b1 && Counter_reg <4'd7)
            begin
                OUT_S <= Serializer_S[0];
                Serializer_S <=  Serializer_S >>1;
                FSM_Sequencer <=1'b1;
                Counter_reg <= Counter_reg + 1'b1;
            end
        else if (Send_Data_S==1'b1 && Counter_reg ==4'd7)
            begin
                OUT_S <= Serializer_S[0];
                Serializer_S <=  Serializer_S >>1;
                FSM_Sequencer <=1'b0;
            end
        else 
            begin
                OUT_S <= 1'b0;
                Counter_reg <= 4'b0;
                FSM_Sequencer <=1'b0;
            end
    end

endmodule