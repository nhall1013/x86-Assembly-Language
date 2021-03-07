INCLUDE Irvine32.inc;

.data
myString BYTE "racecar", 0
reverseString BYTE LENGTHOF myString DUP(0)


.code
main PROC

mov esi, 0
mov ecx, LENGTHOF myString

L1 :
mov al, myString[esi]
mov reverseString[esi], al
inc esi
loop L1

mov esi, OFFSET myString
mov edi, OFFSET myString + LENGTHOF myString - 2
mov ecx, (LENGTHOF myString)/2
L2 : 
     mov al, BYTE PTR[esi]
     mov bl, BYTE PTR[edi]
     mov BYTE PTR[esi], bl
     mov BYTE PTR[edi], al
     inc esi
     dec edi
     loop L2
 
mov esi,0
mov ecx, LENGTHOF myString

L3:
     mov al, mystring[esi]
     mov bl, reverseString[esi]
     cmp al, bl
     jnz NOTPALINDROME
     inc esi
     loop L3

PALINDROME:
     mov eax, 2568652
     jmp STOP

NOTPALINDROME:
     mov eax, 0

STOP:
call WriteInt
INVOKE ExitProcess, 0
main ENDP
END main