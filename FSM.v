module FSM (
input  wire         CLK,
input  wire         RST,
input  wire         Parity_Enable,
input  wire         Parity_Type,
input  wire         Data_Valid,
input  wire         Sequencer,
output reg          Serializer_Enable,
output reg  [1:0]   Mux_Selection,
output reg          Busy
);

localparam IDLE         = 3'b000;
localparam Data_Process = 3'b001;
localparam Start        = 3'b010;
localparam Data         = 3'b011;
localparam Parity       = 3'b100;
localparam END          = 3'b101;

reg [2:0] State , Next_State ;

always @ (posedge CLK or negedge RST)
    begin
        if (!RST)
            State <= IDLE;
        else 
            State <= Next_State;
    end
always @ (*)
    begin
        case (State)
            IDLE:           begin
                                if (Data_Valid==1'b1)
                                    Next_State = Data_Process;
                                else 
                                    Next_State = IDLE;
                            end
            Data_Process:   begin   
                                Next_State = Start;
                            end
            Start:          begin
                                Next_State = Data;
                            end 
            Data:           begin 
                                if (Sequencer ==1'b1)   
                                    Next_State = Data;
                                else if (Sequencer ==1'b0 && Parity_Enable==1'b1  )
                                    Next_State = Parity;
                                else 
                                    Next_State = END;  
                            end   
            Parity:     begin
                                Next_State = END;
                            end
            END:            begin
                                Next_State = IDLE;
                            end
            default:        begin   
                                Next_State = IDLE;
                            end
        endcase
    end
always @ (*)
    begin
        case (State)
            IDLE:           begin
                                Serializer_Enable = 1'b0;
                                Mux_Selection = 2'b00;
                                Busy = 1'b0;
                            end
            Data_Process:   begin   
                                Serializer_Enable = 1'b1;
                                Mux_Selection = 2'b00;
                                Busy = 1'b0;
                            end
            Start:          begin
                                Serializer_Enable = 1'b0;
                                Mux_Selection = 2'b01;
                                Busy = 1'b1;
                            end 
            Data:           begin 
                                Serializer_Enable = 1'b0;
                                Mux_Selection = 2'b10;
                                Busy = 1'b1;
                            end   
            Parity:     begin
                                Serializer_Enable = 1'b0;
                                Mux_Selection = 2'b11;
                                Busy = 1'b1;
                            end
            END:            begin
                                Serializer_Enable = 1'b0;
                                Mux_Selection = 2'b00;
                                Busy = 1'b1;
                            end
            default:        begin   
                                Serializer_Enable = 1'b0;
                                Mux_Selection = 2'b00;
                                Busy = 1'b0;
                            end
        endcase
    end
endmodule 