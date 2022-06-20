module MUX (
input wire Stop,
input wire Start,
input wire Data,
input wire Parity,
input wire [1:0] Sel,
output reg OUT_M
);

always @ (*)
    begin
        case (Sel)
            2'b00: OUT_M = Stop;
            2'b01: OUT_M = Start;
            2'b10: OUT_M = Data;
            2'b11: OUT_M = Parity;
            default: OUT_M = Stop;
        endcase
    end 

endmodule