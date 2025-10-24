module half_adder(
    input  DATA1,DATA2,
    output  sum,carry
);
    assign sum = DATA1 ^ DATA2; //xor
    assign carry = DATA1 & DATA2;//and
endmodule

module full_adder(
    input  A,B,CIN,
    output sum ,cout
);
    wire  sum1,c1,c2; 
    wire [7:0] AB,AXORB,CAXORB,ABC;
    half_adder HA1(
        .DATA1(A),
        .DATA2(B),
        .sum(sum1),
        .carry(c1)
    );
    half_adder HA2(
        .DATA1(sum1),
        .DATA2(CIN),
        .sum(sum),
        .carry(c2)
    );
    // half_adder HA1(A,B,sum1,c1); //using half adders
    // half_adder HA2(sum1,CIN,sum,c2);
    assign cout = c1 | c2;
    
    // orFunct OR1(c1,c2 , cout);
    // AB = A & B;
    // AXORB = A ^ B;
    // CAXORB = CIN ^ AXORB;
    // sum = AXORB ^ CIN;        
endmodule

module multiplier(
    input signed [7:0] A,B, //A -MULTIPLICAND, B - MULTIPLIER
    output signed [7:0] RESULT
);
    wire [7:0] S0,S1,S2,S3,S4,S5,S6,S7; //SUMS
    wire [7:0] C0,C1,C2,C3,C4,C5,C6,C7; //CARRIES
    wire [7:0] TEMPRESULT; //TEMPORARY RESULT

    assign TEMPRESULT[0] = A[0] & B[0];

    half_adder HA1(A[1]&B[0],A[0]&B[1],TEMPRESULT[1],C0[0]);
    full_adder FA1(A[2]&B[0],A[1]&B[1],C0[0],S0[0],C1[0]); 
    full_adder FA2(A[3]&B[0],A[2]&B[1],C1[0],S1[0],C2[0]);
    full_adder FA3(A[4]&B[0],A[3]&B[1],C2[0],S2[0],C3[0]);
    full_adder FA4(A[5]&B[0],A[4]&B[1],C3[0],S3[0],C4[0]);
    full_adder FA5(A[6]&B[0],A[5]&B[1],C4[0],S4[0],C5[0]);
    full_adder FA6(A[7]&B[0],A[6]&B[1],C5[0],S5[0],C6[0]);

    half_adder FA7(S0[0],A[0]&B[2],TEMPRESULT[2],C0[1]);
    full_adder FA8(S1[0],A[1]&B[2],C0[1],S0[1],C1[1]);
    full_adder FA9(S2[0],A[2]&B[2],C1[1],S1[1],C2[1]);
    full_adder FA10(S3[0],A[3]&B[2],C2[1],S2[1],C3[1]);
    full_adder FA11(S4[0],A[4]&B[2],C3[1],S3[1],C4[1]);
    full_adder FA12(S5[0],A[5]&B[2],C4[1],S4[1],C5[1]);
   // full_adder FA13(S6[0],A[6]&B[2],C5[1],S5[1],C6[1]);
    // full_adder FA14(S7[0],A[7]&B[2],C7[1],S6[1],C7[2]);


    half_adder FA15(S0[1],A[0]&B[3],TEMPRESULT[3],C0[2]);
    full_adder FA16(S1[1],A[1]&B[3],C0[2],S0[2],C1[2]);
    full_adder FA17(S2[1],A[2]&B[3],C1[2],S1[2],C2[2]);
    full_adder FA18(S3[1],A[3]&B[3],C2[2],S2[2],C3[2]);
    full_adder FA19(S4[1],A[4]&B[3],C3[2],S3[2],C4[2]);
    // full_adder FA20(S5[1],A[5]&B[3],C5[2],S4[2],C5[2]);
    // full_adder FA21(S6[1],A[6]&B[3],C6[2],S5[2],C7[2]);

    half_adder FA22(S0[2],A[0]&B[4],TEMPRESULT[4],C0[3]);
    full_adder FA23(S1[2],A[1]&B[4],C0[3],S0[3],C1[3]);
    full_adder FA24(S2[2],A[2]&B[4],C1[3],S1[3],C2[3]);
    full_adder FA25(S3[2],A[3]&B[4],C2[3],S2[3],C3[3]);
    // full_adder FA26(S4[2],A[4]&B[4],C4[3],S3[3],C4[3]);
    // full_adder FA27(S5[2],A[5]&B[4],C5[3],S4[3],C5[3]);

    half_adder FA28(S0[3],A[0]&B[5],TEMPRESULT[5],C0[4]);
    full_adder FA29(S1[3],A[1]&B[5],C0[4],S0[4],C1[4]);
    full_adder FA30(S2[3],A[2]&B[5],C1[4],S1[4],C2[4]);
    // full_adder FA31(S3[3],A[3]&B[5],C3[4],S2[4],C3[4]);

    half_adder FA32(S0[4],A[0]&B[6],TEMPRESULT[6],C0[5]);
    full_adder FA33(S1[4],A[1]&B[6],C0[5],S0[5],C1[5]);
    // full_adder FA34(S2[4],A[2]&B[6],C2[5],S1[5],C2[5]);

    half_adder FA35(S0[5],A[0]&B[7],TEMPRESULT[7],C0[6]);
    // full_adder FA36(S1[5],A[1]&B[7],C1[6],S0[6],C1[6]);
    
    assign #2 RESULT = TEMPRESULT;//DELAYED ASSIGNMENT
endmodule