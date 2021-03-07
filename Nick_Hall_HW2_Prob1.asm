; HW2 Programming Assignment

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
VarA DWORD 8
VarB DWORD 6
VarC DWORD 4
VarD DWORD 2
sum  DWORD 0

.code
main PROC
     mov eax,VarA
     add eax,VarB
     mov ebx,VarC
     add ebx,VarD
     sub eax,ebx
     mov sum,eax 

     INVOKE ExitProcess,0
main ENDP
END main 