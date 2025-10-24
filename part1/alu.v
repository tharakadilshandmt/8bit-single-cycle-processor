module alu_tb;
    reg [7:0] OP1,OP2;       //8 bit input which will be given to the function
    reg [2:0] SELECT;           //mux to sellect the operation
    wire [7:0] ALU_RES;

    alu test(OP1,OP2,SELECT, ALU_RES ) ;
    initial begin
        OP1 = 8'h10;
        OP2 = 8'h02;
        SELECT = 3'b000;

        #10 OP1 = 8'h15;
        #10 OP2 = 8'h32;
        #10 SELECT = 3'b001;
        #10 OP1 = 8'h12;
        #10 OP2 = 8'h02;
        #10 SELECT = 3'b010;
        #10 OP1 = 8'h1a;
        #10 OP2 = 8'h12;
        #10 SELECT = 3'b011;
    end
    
    initial begin
        $dumpfile("alu_.vcd");
        $dumpvars(0,alu_tb);
        $monitor($time, " OPERAND1 = %b,OPERAND2 =%b,ALUOP =%b , RESULT=%b \n",OP1,OP2,SELECT, ALU_RES);
    end
endmodule



module alu(input [7:0] DATA1,DATA2,       //8 bit input which will be given to the function
            input [2:0] SELECT,            //mux to sellect the operation
            output reg [7:0] RESULT);    //8 bit regeister to store the output
        //reg [7:0] ALU_RES;
        wire [7:0] RESA,RESB,RESC,RESD; // 8 bit wire to store the intermediate steps
        //assign RESULT = ALU_RES;

    //functional declaration and selector using case
        forwarder forward(DATA1,DATA2,RESA);
        adder add(DATA1,DATA2,RESB);
        and_func and_inst(DATA1, DATA2, RESC);
        or_func or_inst(DATA1,DATA2, RESD);

        always @(RESA,RESB,RESC,RESD) begin
            case(SELECT)
            3'b000:
            assign RESULT = RESA;
            3'b001:
            assign RESULT =RESB;
            3'b010:
            assign RESULT =RESC;
            3'b011:
            assign RESULT = RESD;
            default:
            assign RESULT = 8'h00;

            endcase
        
    end
endmodule

module adder(input [7:0] DATA1,
            input [7:0] DATA2,
            output [7:0] RES_ARRAY);
    //assign timedel output array = operation;
    assign #2 RES_ARRAY = DATA1+DATA2;
    endmodule

module and_func(input [7:0] DATA1,
            input [7:0] DATA2,
            output [7:0] RES_ARRAY);
    //assign timedel output array = operation;
    assign #1 RES_ARRAY = DATA1 & DATA2;
    endmodule

module or_func(input [7:0] DATA1,
            input [7:0] DATA2,
            output [7:0] RES_ARRAY);
    //assign timedel output array = operation;
    assign #1 RES_ARRAY = DATA1 | DATA2;
    endmodule

module forwarder(input [7:0] DATA1,
            input [7:0] DATA2,
            output [7:0] RES_ARRAY);
    //assign timedel output array = operation;
    assign #1 RES_ARRAY = DATA2;
    endmodule
