.MODEL SMALL
.STACK 100H
.DATA 
    
    A   DB  ?
    
    D1  DB  ?
    D2  DB  ?
    D3  DB  ?
    
    MSG1    DB  'Enter a number: $'
    MSG2    DB  10,13,'The series: $'


.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG1    
    INT 21H
    
    MOV CL, 0               ; initialize BH as 0 for previous digit
    MOV BL, 10D                 ; store 10 in BL to multiply and make number

INPUT:

    MOV AH, 1
    INT 21H
    
    CMP AL, 13D             ; check if ENTER is pressed (input is carriage-return or 13D)
    JE NEXT

NUMBER:
                            
    SUB AL, 30H             ; make the number decimal range
    MOV BH, AL                  ; store AL in CL
    MOV AL, CL              ; get the previous digit in AL
    
    MUL BL                  ; multiply with 10 to make it tenth (or doshok)
    ADD AL, BH                  ; add doshok and ekok to combine number
    MOV CL, AL              ; store number in BH as previous number
    
    JMP INPUT               ; take input as long as ENTER is not pressed
    
NEXT:

    MOV AH, 9               ; print the message
    LEA DX, MSG2    
    INT 21H 
    
    MOV A, CL               ; store the number in A
    MOV CL, 0                   ; initialize CL as 0


CALCULATE:
                            
    MOV AL, CL              ; load the value of CL in AL
    
    MOV DL, 100D            ; to divide the number with 100 & extracting the 1st digit
    
    MOV AH, 0
    DIV DL                  ; divide the number with 100
    MOV D1, AL                  ; store the 1st digit from AL to D1
    
    MOV DL, 10D             ; to divide the number with 10 & extract the 2nd digit
   
    MOV AL, AH              ; load the rest of the number from AH to AL
    MOV AH, 0
    DIV DL                  ; divide the number with 10    
    MOV D2, AL                  ; store he 2nd digit from AL to D2
    
    MOV D3, AH              ; store the 3rd digit from AH to D3
    
    MOV AH, 2               ; call output function
    
    MOV DL, D1              ; load the 1st digit in DL
    ADD DL, 30H                 ; make DL a number
    INT 21H                 ; print the 1st digit
    
    MOV DL, D2              
    ADD DL, 30H             ; do the same thing for 2nd digit
    INT 21H
    
    MOV DL, D3              
    ADD DL, 30H             ; do the same thing for 3rd digit
    INT 21H
    
    MOV DL, 20H             ; print a space
    INT 21H
    
    INC CL                  ; increment CL to print the next number
    CMP CL, A                   ; stop looping if CL == A
    JNE CALCULATE
    
EXIT:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    
    