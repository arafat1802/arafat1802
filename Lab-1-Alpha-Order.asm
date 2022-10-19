.MODEL SMALL
.STACK 100H
.DATA
    
    MSG1    DB  10,13,'Enter the first letter: $'
    MSG2    DB  10,13,'Enter the second letter: $'
    MSG3    DB  10,13,'Sequence: $'

.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
                         
    MOV AH, 2            ; print '?'
    MOV DL, '?'
    INT 21H
    
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    MOV AH, 1            ; input first character
    INT 21H
    
    MOV BL, AL           ; store first character in BL
    
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    
    MOV AH, 1            ; input second character
    INT 21H
    
    MOV CL, AL           ; store second character in CL
    
    CMP BL, CL           ; if 1st character is greater than 2nd character
    JG SWAP                 ; then swap them
    JMP PRINT
    
SWAP:

    XCHG BL, CL          ; swap 1st character with 2nd character
    
PRINT:
    
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    
    MOV AH, 2
    MOV DL, BL
    INT 21H
    
    MOV DL, CL
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    
    
    