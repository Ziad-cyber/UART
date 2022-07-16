module Serializer (
input  wire CLK,
input  wire RST,
input  wire [7:0] A,
input  wire Serializer_Enable_S,
output reg  FSM_Sequencer,
output reg  OUT_S
);

reg [7:0] Serializer_S;
reg [2:0] Counter_reg;

always @ (posedge CLK or negedge RST)
    begin
        Serializer_S <= 8'b0;
        OUT_S <= 1'b0;
        Counter_reg <= 3'b0;
        FSM_Sequencer <=1'b0;

        if (!RST)
            begin
                Serializer_S <= 8'b0;
                OUT_S <= 1'b0;
                Counter_reg <= 3'b0;
                FSM_Sequencer <=1'b0;
            end

        else if (Serializer_Enable_S)
            Serializer_S <= A;

        else if ( !Serializer_Enable_S && Counter_reg < 3'd7 )
            begin
                OUT_S <= Serializer_S[0];
                Serializer_S <=  Serializer_S >>1;
                FSM_Sequencer <=1'b1;
                Counter_reg <= Counter_reg + 1'b1;
            end

        else if ( !Serializer_Enable_S && Counter_reg == 3'd7 )
            begin
                OUT_S <= Serializer_S[0];
                Serializer_S <=  Serializer_S >>1;
                FSM_Sequencer <=1'b0;
                Counter_reg <= 3'b0;
            end
    end

endmodule
