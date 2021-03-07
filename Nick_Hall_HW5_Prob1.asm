INCLUDE Irvine32.inc;

.data

numX DWORD ?
numY DWORD ?
myString BYTE "GCD of numX and numY is ", 0

.code

main PROC

     mov numX, 12
     mov numY, 8
     mov edx, OFFSET myString
     call WriteString
     call GCD
     call crlf
    
     mov numX, 762
     mov numY, 559
     mov edx, OFFSET myString
     call WriteString
     call GCD
     call crlf
    
     mov numX, 4500
     mov numY, 255
     mov edx, OFFSET myString
     call WriteString
     call GCD
     call crlf
     
     call WaitMsg

     INVOKE ExitProcess, 0
main ENDP



GCD PROC

     mov eax, numX
     cdq
     mov ebx, numY
     div ebx

     L1:
          mov eax, ebx
          mov ebx, edx
          cmp ebx, 0
          je DONE
          mov numX, edx
          cdq
          div ebx
          loop L1

     DONE:

          call WriteDec

ret
GCD ENDP

END main