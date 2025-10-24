//2to1 multiplexer
module mult2to1 (
    input signed data1,
    input signed data2,
    input SELECT,
    output reg signed OUTPUT
);
    always @(data1, data2, SELECT)
    begin
        case (SELECT)
            1'b0 : OUTPUT = data1;
            1'b1 : OUTPUT = data2;
        endcase
    end
endmodule
//3to1 multiplexer
module mult3to1 (
    input signed data1,//logcal
    input signed data2,//arithmatic 
    input signed data3,//rotate
    input [1:0]SELECT,
    output reg signed OUTPUT
);
   always @(data1, data2, data3, SELECT)
    begin
        case (SELECT)
            2'b00 : OUTPUT = data1;//logical
            2'b01 : OUTPUT = data2;//arithmatic
            2'b10 : OUTPUT = data3;//rotate
        endcase
    end

endmodule

module LEFTSHIFT(
    input signed [7:0]DATA1,
    input signed [7:0]DATA2,
    output reg signed [7:0]RESULT

);

    wire [7:0] INTERMEDIATE [2:0];  

    //layer 1
    mult2to1 m00(DATA1[0],1'b0,DATA2[0],INTERMEDIATE[0][0]);
    mult2to1 m01(DATA1[1],DATA1[0],DATA2[0],INTERMEDIATE[0][1]);
    mult2to1 m02(DATA1[2],DATA1[1],DATA2[0],INTERMEDIATE[0][2]);
    mult2to1 m03(DATA1[3],DATA1[2],DATA2[0],INTERMEDIATE[0][3]);
    mult2to1 m04(DATA1[4],DATA1[3],DATA2[0],INTERMEDIATE[0][4]);
    mult2to1 m05(DATA1[5],DATA1[4],DATA2[0],INTERMEDIATE[0][5]);
    mult2to1 m06(DATA1[6],DATA1[5],DATA2[0],INTERMEDIATE[0][6]);
    mult2to1 m07(DATA1[7],DATA1[6],DATA2[0],INTERMEDIATE[0][7]);
    

    //layer 2
    mult2to1 m10(INTERMEDIATE[0][0],1'b0,DATA2[1],INTERMEDIATE[1][0]);
    mult2to1 m11(INTERMEDIATE[0][1],1'b0,DATA2[1],INTERMEDIATE[1][1]);
    mult2to1 m12(INTERMEDIATE[0][2],INTERMEDIATE[0][0],DATA2[1],INTERMEDIATE[1][2]);
    mult2to1 m13(INTERMEDIATE[0][3],INTERMEDIATE[0][1],DATA2[1],INTERMEDIATE[1][3]);
    mult2to1 m14(INTERMEDIATE[0][4],INTERMEDIATE[0][2],DATA2[1],INTERMEDIATE[1][4]);
    mult2to1 m15(INTERMEDIATE[0][5],INTERMEDIATE[0][3],DATA2[1],INTERMEDIATE[1][5]);
    mult2to1 m16(INTERMEDIATE[0][6],INTERMEDIATE[0][4],DATA2[1],INTERMEDIATE[1][6]);
    mult2to1 m17(INTERMEDIATE[0][7],INTERMEDIATE[0][5],DATA2[1],INTERMEDIATE[1][7]);

    //layer 3
    mult2to1 m20(INTERMEDIATE[1][0],1'b0,DATA2[2],INTERMEDIATE[2][0]);
    mult2to1 m21(INTERMEDIATE[1][1],1'b0,DATA2[2],INTERMEDIATE[2][1]);
    mult2to1 m22(INTERMEDIATE[1][2],1'b0,DATA2[2],INTERMEDIATE[2][2]);
    mult2to1 m23(INTERMEDIATE[1][3],1'b0,DATA2[2],INTERMEDIATE[2][3]);
    mult2to1 m24(INTERMEDIATE[1][4],INTERMEDIATE[1][0],DATA2[2],INTERMEDIATE[2][4]);
    mult2to1 m25(INTERMEDIATE[1][5],INTERMEDIATE[1][1],DATA2[2],INTERMEDIATE[2][5]);
    mult2to1 m26(INTERMEDIATE[1][6],INTERMEDIATE[1][2],DATA2[2],INTERMEDIATE[2][6]);
    mult2to1 m27(INTERMEDIATE[1][7],INTERMEDIATE[1][3],DATA2[2],INTERMEDIATE[2][7]);

    always @(INTERMEDIATE[2]) begin
        #2 RESULT = (DATA2[3:0]==4'd8) ? 8'b0:INTERMEDIATE[2];
    end
endmodule
//Functional unit to perform Right Shift operations
// Right logical, arithmetic shift , rotate
// data2  [7:6] --> 00  logical       
//              --> 01  arithmetic
//              --> 10  rotate
// data1 is the value to be shifted(this can be due to the assembler instruction)

module RIGHTSHIFT(
    input signed [7:0]DATA1,
    input signed [7:0]DATA2,
    output reg signed [7:0]RESULT
);

    wire [7:0] INTERMEDIATE [2:0];//for layers bits
    wire M07,M16,M17,M23,M24,M25,M26;//for logical,arthmetic,rotate

    //layer 1
    mult2to1 m00(DATA1[0],DATA1[1],DATA2[0],INTERMEDIATE[0][0]);
    mult2to1 m01(DATA1[1],DATA1[2],DATA2[0],INTERMEDIATE[0][1]);
    mult2to1 m02(DATA1[2],DATA1[3],DATA2[0],INTERMEDIATE[0][2]);
    mult2to1 m03(DATA1[3],DATA1[4],DATA2[0],INTERMEDIATE[0][3]);
    mult2to1 m04(DATA1[4],DATA1[5],DATA2[0],INTERMEDIATE[0][4]);
    mult2to1 m05(DATA1[5],DATA1[6],DATA2[0],INTERMEDIATE[0][5]);
    mult2to1 m06(DATA1[6],DATA1[7],DATA2[0],INTERMEDIATE[0][6]);
    mult2to1 m07(DATA1[7],M07,DATA2[0],INTERMEDIATE[0][7]);
    mult3to1 select07(1'b0,DATA1[7],DATA1[0],DATA2[7:6],M07);

    //layer 2
    mult2to1 m10(INTERMEDIATE[0][0],INTERMEDIATE[0][2],DATA2[1],INTERMEDIATE[1][0]);
    mult2to1 m11(INTERMEDIATE[0][1],INTERMEDIATE[0][3],DATA2[1],INTERMEDIATE[1][1]);
    mult2to1 m12(INTERMEDIATE[0][2],INTERMEDIATE[0][4],DATA2[1],INTERMEDIATE[1][2]);
    mult2to1 m13(INTERMEDIATE[0][3],INTERMEDIATE[0][5],DATA2[1],INTERMEDIATE[1][3]);
    mult2to1 m14(INTERMEDIATE[0][4],INTERMEDIATE[0][6],DATA2[1],INTERMEDIATE[1][4]);
    mult2to1 m15(INTERMEDIATE[0][5],INTERMEDIATE[0][7],DATA2[1],INTERMEDIATE[1][5]);
    mult2to1 m16(INTERMEDIATE[0][6],M16,DATA2[1],INTERMEDIATE[1][6]);
    mult3to1 select16(1'b0,INTERMEDIATE[0][6],INTERMEDIATE[0][0],DATA2[7:6],M16);
    mult2to1 m17(INTERMEDIATE[0][7],M17,DATA2[1],INTERMEDIATE[1][7]);
    mult3to1 select17(1'b0,INTERMEDIATE[0][7],INTERMEDIATE[0][1],DATA2[7:6],M17);

    //layer 3
    mult2to1 m20(INTERMEDIATE[1][0],INTERMEDIATE[1][4],DATA2[2],INTERMEDIATE[2][0]);
    mult2to1 m21(INTERMEDIATE[1][1],INTERMEDIATE[1][5],DATA2[2],INTERMEDIATE[2][1]);
    mult2to1 m22(INTERMEDIATE[1][2],INTERMEDIATE[1][6],DATA2[2],INTERMEDIATE[2][2]);
    mult2to1 m23(INTERMEDIATE[1][3],INTERMEDIATE[1][7],DATA2[2],INTERMEDIATE[2][3]);
    mult2to1 m24(INTERMEDIATE[1][4],M24,DATA2[2],INTERMEDIATE[2][4]);
    mult3to1 select24(1'b0,INTERMEDIATE[1][4],INTERMEDIATE[1][0],DATA2[7:6],M24);//SELECT INPUT
    mult2to1 m25(INTERMEDIATE[1][5],M25,DATA2[2],INTERMEDIATE[2][5]);
    mult3to1 select25(1'b0,INTERMEDIATE[1][5],INTERMEDIATE[1][1],DATA2[7:6],M25);//SELECT INPUT
    mult2to1 m26(INTERMEDIATE[1][6],M26,DATA2[2],INTERMEDIATE[2][6]);
    mult3to1 select26(1'b0,INTERMEDIATE[1][6],INTERMEDIATE[1][2],DATA2[7:6],M26);//SELECT INPUT
    mult2to1 m27(INTERMEDIATE[1][7],M27,DATA2[2],INTERMEDIATE[2][7]);
    mult3to1 select27(1'b0,INTERMEDIATE[1][5],INTERMEDIATE[1][3],DATA2[7:6],M27);//SELECT INPUT

    always @(INTERMEDIATE[2]) begin
        if(DATA2[7:6]==2'b00)begin
            #2 RESULT=(DATA2[3:0]==4'd8)?8'b0:INTERMEDIATE[2];
        end
        else if(DATA2[7:6]==2'b01)begin 
            #2 RESULT =(DATA2[3:0]==4'd8)?{8{DATA1[7]}}:INTERMEDIATE[2];
        end
        else if(DATA2[7:6]==2'b10)begin
            #2 RESULT = INTERMEDIATE[2];
        end                                                                                                                                         
    end
endmodule