module reg_tb;
    
    reg [7:0] WRITEDATA;
    reg [2:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [7:0] REGOUT1, REGOUT2;
    integer i;    
    reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);
       
    initial
    begin
        CLK = 1'b1;
        
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("reg_.vcd");
		$dumpvars(0, reg_tb);
        for(i=0;i<8;i=i+1)
            $dumpvars(1,reg_tb.myregfile.regArr[i]);
        
        
        // assign values with time to input signals to see output 
        RESET = 1'b0;
        WRITEENABLE = 1'b0;                     
        
        #4
        RESET = 1'b1;
        READREG1 = 3'd0;
        READREG2 = 3'd4;
        
        #6
        RESET = 1'b0;
        
        #2
        WRITEREG = 3'd2;
        WRITEDATA = 8'd95;
        WRITEENABLE = 1'b1;
        
        #7
        WRITEENABLE = 1'b0;
        
        #1
        READREG1 = 3'd2;
        
        #7
        WRITEREG = 3'd1;
        WRITEDATA = 8'd28;
        WRITEENABLE = 1'b1;
        READREG1 = 3'd1;
        
        #8
        WRITEENABLE = 1'b0;
        
        #8
        WRITEREG = 3'd4;
        WRITEDATA = 8'd6;
        WRITEENABLE = 1'b1;
        
        #8
        WRITEDATA = 8'd15;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #6
        WRITEREG = -3'd1;
        WRITEDATA = 8'd50;
        WRITEENABLE = 1'b1;
        
        #5
        WRITEENABLE = 1'b0;
        
        #10
        $finish;
    end
    
    // clock signal generation
    always
        #4 CLK = ~CLK;
        

endmodule

module reg_file(input [7:0] IN,
                output reg[7:0] OUT1,OUT2,
                input [2:0] INADDR,OUT1ADD,OUT2ADD, //select which register to move by chosing the required add
                input WRITEEN,CLK,RESET);
    reg [7:0] regArr[7:0];
    integer k; //to loop through registers

    always @(*)begin //reading and asynchronously loading values
        OUT1 <= #2 regArr[OUT1ADD];
        OUT2 <= #2 regArr[OUT2ADD];
    end

    always @(posedge CLK) begin
        if (WRITEEN) begin
            regArr[INADDR] <=#1 IN;
        end
        if(RESET) begin
            for (k =0 ; k<8 ;k =k+1 ) 
            begin
                regArr[k] <= #1 8'h00;
            end
        end
        
    end

endmodule