.MODEL SMALL
.STACK 100H
.DATA
    
    MSG1    DB  'Enter a number: $'
    MSG2    DB  10,13,'The number is PRIME...!!!$'
    MSG3    DB  10,13,'The number is NOT PRIME...!!!$'


.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG1    
    INT 21H
    
    MOV BH, 0               ; initialize BH as 0 for previous digit
    MOV BL, 10D                 ; store 10 in BL to multiply and make number

INPUT:

    MOV AH, 1
    INT 21H
    
    CMP AL, 13D             ; check if ENTER is pressed (input is carriage-return or 13D)
    JE CHECK

NUMBER:
                            
    SUB AL, 30H             ; make the number decimal range
    MOV CL, AL                  ; store AL in CL
    MOV AL, BH              ; get the previous digit in AL
    
    MUL BL                  ; multiply with 10 to make it tenth (or doshok)
    ADD AL, CL                  ; add doshok and ekok to combine number
    MOV BH, AL              ; store number in BH as previous number
    
    JMP INPUT               ; take input as long as ENTER is not pressed
    
CHECK:
    
    CMP BH, 1               ; if the number is 1 or 0
    JLE NOT_PRIME               ; it is not prime
    
    MOV CL, 2               ; CL=2 for dividing the number by 2
    
    MOV AX, 0               ; clear AX register
    
    MOV AL, BH              ; store the number in accumulator
    DIV CL                      ; divide the number by 2
    
    MOV CL, AL              ; initialize CL as half of number i.e. CL=n/2
    
ISPRIME:
                            
    CMP CL, 1               ; if CL becomes less than 2, meaning we've checked with all other numbers
    JE PRIME                    ; number is prime
    
    MOV AX, 0               ; clear AX register
    
    MOV AL, BH              ; store the number in accumulator again
    DIV CL                      ; divide the number by CL
    
    DEC CL                  ; decrement counter
    CMP AH, 0                   ; if remainder is 0, then number is divisible by other numbers
    JE NOT_PRIME                    ; then, this is not prime
    JMP ISPRIME
                            ; else, again try to divide the number
PRIME:  
  
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    JMP EXIT
    
NOT_PRIME:
    
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    
EXIT:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    
    