loadi 1 0x05
loadi 2 0xF5
loadi 7 0xF0
mult 4 1 2       //
sra 1 7 0x02    //
srl 5 2 0x08    //
sll 3 2 0x08    //
ror 6 2 0x05    //
bne 0xFC 1 2   //
	char *op_loadi = "00000000";
	char *op_add = "00000001";
	char *op_mov = "00000010";
	char *op_sub = "00000011";
	char *op_and = "00000100";
	char *op_or = "00000101";
	char *op_j = "00000110";
	char *op_beq = "00000111";
	char *op_bne = "00001000";
	char *op_mult = "00001001";
	char *op_sll = "00001010";
	char *op_srl = "00001011";
	char *op_sra = "00001100";
	char *op_ror = "00001101";
	char *op_mult = "00001001";