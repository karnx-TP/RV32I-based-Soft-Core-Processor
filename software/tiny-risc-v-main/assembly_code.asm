main:
	lui x1,1
	addi x1,x1,8
	lui x2,255
	addi x2,x2,171
	lui x3,524288
	slti x4,x3,40
	sltiu x4,x3,40
	xori x5,x3,4095
	ori x6,x3,4095
	andi x7,x3,4095
	slli x8,x2,12
	srai x8,x8,4
	srli x8,x8,4
	add x9,x1,x2
	sub x9,x1,x2
	sll x9,x1,x2
	slt x10,x3,x2
	sltu x11,x6,x1
	srl x11,x6,x1
	sra x11,x6,x1
	and x12,x3,x6
	or x12,x3,x6
	xor x12,x3,x6

	sw x2,3(x4)
	sh x2,6,(x4)
	sb x2,10(x4)

	lb x16,3(x4)
	lh x16,3(x4)
	lw x16,3(x4)

	lbu x16,3(x4)
	lhu x16,3(x4)

	jal x17,10
	lui x23,1048575

	addi x0,x0,0 
	addi x0,x0,0 
	addi x0,x0,0 

	jalr x18,32(x17)

	addi x0,x0,0 
	addi x0,x0,0 
	addi x0,x0,0 
	addi x0,x0,0 

	beq x18,x19,4
	beq x20,x19,4

	addi x0,x0,0 

	bne x17,x18,4

	addi x0,x0,0 

	blt x9,x10,4
	blt x11,x10,4
	addi x0,x0,0 
	bltu x11,x10,4
	bltu x10,x11,4
	addi x0,x0,0 
	bltu x30,x31,4
	addi x0,x0,0 

	bge x10,x9,4
	bge x10,x11,4
	addi x0,x0,0 
	bgeu x10,x11,4
	bgeu x11,x10,4
	
	addi x0,x0,0 

	auipc x31,1

	addi x20,x0,75
	sb x20,1026(x0)
	lw x21,1027(x0)
	lw x21,1026(x0)

	addi x20,x0,97
	sb x20,1026(x0)
	lw x21,1027(x0)
	lw x21,1026(x0)

	addi x20,x0,114
	sb x20,1026(x0)
	lw x21,1027(x0)
	lw x21,1026(x0)

	addi x20,x0,109
	sb x20,1026(x0)
	lw x21,1027(x0)
	lw x21,1026(x0)

	addi x22,x0,254
	addi x23,x0,202
	sb x22,1028(x0)
	sb x23,1029(x0)
	addi x0,x0,0 
	addi x0,x0,0 
	lb x24,1030(x0)

	addi x0,x0,1

	addi x25,x0,123
	sw x25,12(x0)
	lw x26,12(x0)
	addi x27,x26,5

	jal x17,0

	addi x0,x0,0 
	addi x0,x0,0 
	addi x0,x0,0 


