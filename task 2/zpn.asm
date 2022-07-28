DATA SEGMENT PAGE 
    BUFFER DB 5 
        DB 0
        DB 5 DUP(0)
    
    ARR DW 20 DUP(0)
    
    SUM_BELOW_ZEROS  DB 0H
    SUM_ABOVE_ZEROS  DB 0H
    SUM_QEUAL_ZEROS  DB 0H
     
    INPUT      DB 0ah,0dh,'INPUT:  $',0ah,0dh
	NEGTIVE    DB 0ah,0dh,'NEGTIVE_NUM_SUM:  $' 
	POSTIVE    DB 0ah,0dh,'POSTIVE_NUM_SUM:  $'
	ZEROS      DB 0ah,0dh,'ZEROS_NUM_SUM:    $'

    DATA ENDS   
STACK SEGMENT    PAGE 'STACK'
    MEI DB 255H DUP(0) 
    STACK ENDS
CODE SEGMENT  
ASSUME CS:CODE,DS:DATA,SS:STACK,ES:DATA
MAIN PROC FAR  
    
    MOV AX,DATA
	MOV DS,AX
	MOV CX,0
	MOV BX,0 
	MOV SI,0
	MOV SI,OFFSET ARR
	INC SI
	INC SI             

	
CIRCLE:
    CMP CX,20         
    JE SHOW
    MOV AH,09H
    LEA DX, INPUT
    INT 21H
    
    LEA DX,BUFFER
    MOV AH,0AH
    INT 21H
    
    MOV AL,BYTE PTR[BUFFER+2]
    CMP AL,'0'
    JE  ZEROSS
    CMP AL,'-'
    JE  NEGTIVEE
    JMP POSTIVEE



ZEROSS:

    INC SUM_QEUAL_ZEROS 
    MOV AL,BYTE PTR[BUFFER+2] 
    SUB AL,30H
    MOV [SI],AL
    INC SI
    INC SI
    INC CX
    JMP JUDGE_END

POSTIVEE:
    INC SUM_ABOVE_ZEROS 
    MOV AL,BYTE PTR[BUFFER+2]   
    SUB AL,30H
    MOV [SI],AL 
    INC SI
    INC SI
    INC CX
    JMP JUDGE_END
    

NEGTIVEE:
    INC SUM_BELOW_ZEROS
    MOV AL,BYTE PTR[BUFFER+3]  
    SUB AL,40H
    MOV [SI],AL 
    INC SI
    INC SI
    INC CX
    JMP JUDGE_END 
 
 
    
JUDGE_END:
    
    CMP AL,21h
    JE SHOW_SUB_Q
    JMP CIRCLE
SHOW_SUB_Q:
    DEC SUM_ABOVE_ZEROS
    
 
SHOW:  
   MOV AH,09H
   LEA DX,NEGTIVE
   INT 21H
   MOV AL,SUM_BELOW_ZEROS
   CALL UBASC
   CALL PCHAR 
   
   MOV AH,09H
   LEA DX,POSTIVE
   INT 21H
   MOV AL,SUM_ABOVE_ZEROS
   CALL UBASC
   CALL PCHAR     
 
   MOV AH,09H
   LEA DX,ZEROS
   INT 21H
   MOV AL,SUM_QEUAL_ZEROS
   CALL UBASC
   CALL PCHAR
   
   JMP ENDD
ENDD:
    MOV AH,4CH
    INT 21H       
       
       
MAIN ENDP     
UBASC PROC
    AND AL,0FH
    ADD AL,90H 
    DAA
    ADC AL,40H
    DAA	
    RET 
UBASC ENDP 

PCHAR PROC
    MOV AH,02H
    MOV DL,AL
    INT 21H
    RET
PCHAR ENDP 
 
	
CODE	ENDS
	END	MAIN

	
	




   



  




   



  
