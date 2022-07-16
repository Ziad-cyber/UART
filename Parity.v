module Parity (
input wire [7:0] A,
input wire Parity_Enable_P,
input wire Parity_Type_P,
output reg OUT_P
);

always @ (*)
    begin
        //EVEN PARITY
        if ((Parity_Enable_P ==1) && (Parity_Type_P==0))
            OUT_P = (^A);
        //ODD PARITY
        else 
            OUT_P = ~(^A);
    end

endmodule