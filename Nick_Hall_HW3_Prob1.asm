INCLUDE Irvine32.inc;

.data
myString BYTE "Assembly Language",0


.code
main PROC
     mov esi,OFFSET myString
     mov edi,OFFSET myString + LENGTHOF myString - 2
     mov ecx,SIZEOF myString
L1:
     mov al,BYTE PTR [esi]
     mov bl,BYTE PTR [edi]
     mov BYTE PTR [esi],bl
     mov BYTE PTR [edi],al 
     inc esi
     dec edi
     dec ecx
     loop L1
     mov edx, OFFSET myString 
     call WriteString
     call WaitMsg
     invoke ExitProcess,0
main ENDP
END main 



