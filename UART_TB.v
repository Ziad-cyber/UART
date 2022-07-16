//    This is testbench for UART Module
`timescale 1 ns/100 ps
//TB has neither inputs nor outputs
module UART_TB ();

reg  CLK_TB;
reg  RST_TB;
reg  [7:0] A_TB;
reg  Data_Valid_TB;
reg  Parity_Type_TB;
reg  Parity_Enable_TB;
wire Busy_TB;
wire S_Data_TB;

/////////////// Clk Generator ///////////////
localparam Period = 5;
always #(Period/2) CLK_TB = ~CLK_TB;     // Clk Frequency 200 MHz

/////////////// Initial BLock ///////////////
initial 
    begin
        // Save Waveform
        $dumpfile("UART.vcd") ;       
        $dumpvars; 

        Initialization ();
        Reset ();
        #1
        Data(1'b1,1'b0,8'b11001100);
        #5
        wait (Busy_TB==0)
        Data(1'b1,1'b0,8'b10101010);
    end

/////////////// Reset BLock ///////////////
task Reset;
    begin
        RST_TB=1'b1;
        #2
        RST_TB=1'b0;
        #2
        RST_TB=1'b1;
    end
endtask

/////////////// Initialization BLock ///////////////
task Initialization;
    begin
        CLK_TB=1'b0;
        Data_Valid_TB=1'b0;
    end
endtask

/////////////// Data BLock ///////////////
task Data (
    input reg Parity_Type_T,
    input reg Parity_Enable_T,
    input reg [7:0] A_T
);
    begin
        A_TB = A_T;
        Parity_Type_TB= Parity_Type_T;
        Parity_Enable_TB= Parity_Enable_T;
        Data_Valid_TB = 1'b1;
        #Period
        Data_Valid_TB = 1'b0;
    end
endtask

/////////////// Module instantiation ///////////////
UART U1 (
.CLK (CLK_TB),
.RST (RST_TB),
.A (A_TB),
.Data_Valid (Data_Valid_TB),
.Parity_Type (Parity_Type_TB),
.Parity_Enable (Parity_Enable_TB),
.Busy (Busy_TB),
.S_Data (S_Data_TB)
);

endmodule