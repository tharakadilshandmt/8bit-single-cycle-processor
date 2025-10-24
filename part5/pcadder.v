module pcadder (
    output reg [31:0] PC,
    input CLK,
    input RESET ,
    input signed [7:0] RD_OFFSET,
    input BRANCHMUXSELECT,BRANCHNOTMUXSELECT,JUMP,ZERO

);
    wire BRANCH,IFEQUAL,IFNOTEQUAL;
    reg [31:0] PCPLUS4;
    wire[31:0] BRANCHADDRESS;
    wire signed [31:0] SHIFTLEFTADDRESS;
    wire[31:0] NEXTPC;
    reg signed [31:0]  SIGNEXTNDVALUE;

       always @(RD_OFFSET) begin
        if(RD_OFFSET[7]==1'b0)begin //if the jump value is posititve(forward) value  convert it into plus value
            SIGNEXTNDVALUE<=  {24'b000000000000000000000000,RD_OFFSET};
        end
        else if(RD_OFFSET[7]==1'b1)begin//if the jump is negative(ackward) value convert it into minus value
            SIGNEXTNDVALUE<={24'b111111111111111111111111,RD_OFFSET};
        end

    end
    always @(PC) begin
        #1 PCPLUS4 <=PC+4;////////////////////////////////////further study
    end
     
    assign #2 SHIFTLEFTADDRESS=(PCPLUS4)+(SIGNEXTNDVALUE<<2);
    and(IFNOTEQUAL,BRANCHNOTMUXSELECT,~ZERO);
    and(IFEQUAL,BRANCHMUXSELECT,ZERO);
    or(BRANCH,IFEQUAL,IFNOTEQUAL);
    
    assign BRANCHADDRESS=BRANCH?SHIFTLEFTADDRESS:PCPLUS4;
    assign NEXTPC=JUMP?SHIFTLEFTADDRESS:BRANCHADDRESS;


     always @(posedge CLK ) begin
        
        if(RESET)begin
            PC<= #1 0;//if reset is high assgn pc to zero
            //tempPC<=#1 0;
        end
        else begin
            // PC<=#1 tempPC;//EVERY TIME THAT RESET IS NOT HIGH INCREMENT PC AT THE POSEAGE OF CLK
           PC<= #1 NEXTPC;
        end
           
    end


endmodule