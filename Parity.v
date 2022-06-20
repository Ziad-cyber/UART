module Parity (
input wire A0,
input wire A1,
input wire A2,
input wire A3,
input wire A4,
input wire A5,
input wire A6,
input wire A7,
input wire Parity_Enable_P,
input wire Parity_Type_P,
output reg OUT_P
);

always @ (*)
    begin
        //EVEN PARITY
        if ((Parity_Enable_P ==1) && (Parity_Type_P==0))
            OUT_P = (A0 ^ A1 ^ A2 ^ A3 ^ A4 ^ A5 ^ A6 ^ A7);
        //ODD PARITY
        else 
            OUT_P = ~(A0 ^ A1 ^ A2 ^ A3 ^ A4 ^ A5 ^ A6 ^ A7);
    end

endmodule