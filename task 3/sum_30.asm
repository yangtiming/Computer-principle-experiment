DATA SEGMENT PAGE 
    BUFFER DB 200
        DB 0
        DB 200 DUP(0)
    
    SUM DW 0H
    SUM_AVERAGE DW 0H    
        
    INPUT              DB 0ah,0dh,'INPUT:  $',0ah,0dh
	SUM_SHOW           DB 0ah,0dh,'SUM        :  $',0ah,0dh 
	SUM_AVERAGE_SHOW   DB 0ah,0dh,'SUM_AVERAGE:  $' 
	MYNAME             DB 0ah,0dh,'YANGTIMING_201883016$'
    total DW 30
    DATA ENDS   
STACK SEGMENT
    MEI DB 256H DUP(0) 
    STACK ENDS
CODE SEGMENT  
ASSUME CS:CODE,DS:DATA,SS:STACK,ES:DATA
MAIN PROC FAR  
    
    MOV AX,DATA
	MOV DS,AX  
	
	MOV CX,0H
	MOV BL,0H
	MOV SI,2H
 
    MOV AH,09H
    LEA DX, INPUT
    INT 21H
    
    LEA DX,BUFFER
    MOV AH,0AH
    INT 21H
 
	
CIRCLE: 
    MOV AX,0 
    
    CMP CX,total        
    JE AVERAGE
          
    MOV AL,BYTE PTR[BUFFER+SI] 
    CMP AL,20H
    JE  NEXT_ONE
    MOV AL,BYTE PTR[BUFFER+SI+1] 
    CMP AL,20H
    JE  NEXT_SINGLE 
    MOV AL,BYTE PTR[BUFFER+SI+2] 
    CMP AL,20H
    JE  NEXT_DOUBLE
    JMP NEXT_TRIBOULE  
    
NEXT_SINGLE:
    MOV AL,BYTE PTR[BUFFER+SI] 
    SUB AL,30H
    ADD SUM,AX 
    INC SI
    INC CX  
    JMP CIRCLE 
    
NEXT_TRIBOULE:
    MOV AX,0  
    MOV DX,0
    MOV AL,BYTE PTR[BUFFER+SI]
    SUB AL,30H 
    MOV BL,100
    MUL BL 
    ADD SUM,AX 
       
    MOV BX,0 
    MOV AL,BYTE PTR[BUFFER+SI+1]
    SUB AL,30H 
    MOV BL,10
    MUL BL
    MOV BX,0     
    
    MOV BL,BYTE PTR[BUFFER+SI+2]
    SUB BL,30H 
    
    ADD AX,BX 
    ADD SUM,AX
    INC SI
    INC SI 
    INC SI
    INC CX
    JMP CIRCLE  

NEXT_DOUBLE:
    MOV AX,0
    MOV AL,BYTE PTR[BUFFER+SI]
    SUB AL,30H 
    MOV BL,10
    MUL BL
    MOV BX,0
    MOV BL,BYTE PTR[BUFFER+SI+1]
    SUB BL,30H 
    ADD AX,BX 
    ADD SUM,AX
    INC SI
    INC SI 
    INC CX
    JMP CIRCLE
    
    
    
NEXT_ONE:
    INC SI   
    JMP CIRCLE



AVERAGE: 
   MOV AX,0
   MOV AX,SUM 
   MOV BX,total
   DIV BX 
   MOV SUM_AVERAGE,AX 


   MOV AX,0   
   MOV AH,09H
   LEA DX,SUM_SHOW 
   INT 21H  
   MOV AX,SUM
   CALL HTOD
  
  
   MOV AX,0   
   MOV AH,09H
   LEA DX,SUM_AVERAGE_SHOW 
   INT 21H  
   MOV AX,SUM_AVERAGE
   CALL HTOD  
   MOV AH,09H
   LEA DX,MYNAME 
   INT 21H
   JMP ENDD
    
ENDD:
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP

HTOD PROC
    PUSH    AX
    PUSH    CX
    PUSH    DX
    PUSH    BX
 
    XOR    CX,CX
    MOV    BX,10
S:
    XOR    DX,DX
    DIV    BX
    INC    CX
    PUSH    DX
    CMP    AX,0
    JNE    S
S1:
    POP    DX
    ADD    DL,30H
    MOV    AH,2
    INT    21H
    LOOP    S1

 
    POP    BX
    POP    DX
    POP    CX
    POP    AX
    RET
HTOD ENDP
       
CODE	ENDS
	END	MAIN
END MAIN
	
	




   



  




   



  
