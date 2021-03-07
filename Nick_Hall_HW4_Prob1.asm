; Vigenere cipher

; Calling convention for the procedure defined here
;    Callee - saved registers : EBX, ESI, EDI, EBP
;    Caller - saved(scratch) registers: EAX, ECX, EDX

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode : DWORD
Encrypt PROTO, msgBuffer : PTR BYTE, key : PTR BYTE
Decrypt PROTO, msgBuffer : PTR BYTE, key : PTR BYTE

include irvine32.inc

.data
prompt_msg BYTE "Enter message to be encrypted: ", 0
prompt_key BYTE "Enter key: ", 0
outMsg_plain BYTE "Plaintext message: ", 0
outMsg_key BYTE "Key: ", 0
outMsg_encrypt BYTE "Encrypted message: ", 0
outMsg_decrypt BYTE "Decrypted message: ", 0

.code
main PROC
LOCAL key[10]:BYTE, msgBuffer[30] : BYTE

; Get a plaintext message to be encrypted from a user
; The message must consist only of uppercase alphabet letters
mov edx, OFFSET prompt_msg
call WriteString; (irvine32.lib) Writes a null - terminated string to the console windows; pass the string's offfset in EDX
lea edx, msgBuffer; pointer to msgBuffer for ReadString()
mov ecx, SIZEOF msgBuffer; size of msgBuffer for ReadString()
call ReadString; (irvine32.lib) Reads a string from the keyboard until she presses Enter.Append a null byte at the end of the string

; Get a key from a user
; The key must consist only of uppercase alphabet letters
mov edx, OFFSET prompt_key
call WriteString
lea edx, key
mov ecx, SIZEOF key
call ReadString

call Crlf

; Display the received plaintext message and key on the console window
mov edx, OFFSET outMsg_plain
call WriteString
lea edx, msgBuffer
call WriteString
call Crlf

mov edx, OFFSET outMsg_key
call WriteString
lea edx, key; pointer to the key buffer
call WriteString
call Crlf


; Encrypt the message and write the encrypted message to the console window
     lea edi, msgBuffer
     lea esi, key
	INVOKE Encrypt, edi, esi

     mov edx, OFFSET outMsg_encrypt
     call WriteString
     mov edx, edi
     call WriteString
     call Crlf

; Decrypt the message and write the decrypted message to the console window
     lea edi, msgBuffer
     lea esi, key
	INVOKE Decrypt, edi, esi

	mov edx, OFFSET outMsg_decrypt
	call WriteString
	mov edx, edi
	call WriteString
	call Crlf

	INVOKE ExitProcess, 0
main ENDP


;-----------------------------------------------
Encrypt PROC USES esi edi ebx, 
	msgBuffer:PTR BYTE,	; pointer to the message (plaintext) to be encrypted
	key:PTR BYTE		; pointer to key
; 
; Overwrite msgBuffer with encrypted message
; ---------------------------------------------- -

; Write your code here
mov edx, msgBuffer 
call StrLength
mov ecx, eax 
mov esi, key
mov ebx, msgBuffer 
L1:
     mov al, [esi]
     cmp al, 0
     je RESIZE
     sub al, 65
     add BYTE PTR[ebx], al
     cmp BYTE PTR[ebx], 90
     jbe NEXT
     sub BYTE PTR [ebx], 26
NEXT:
     inc ebx
     inc esi
     loop L1
     jmp DONE
RESIZE:
     mov esi, key
     jmp L1
DONE:
ret
Encrypt ENDP

;-----------------------------------------------
Decrypt PROC USES esi edi ebx, 
	msgBuffer:PTR BYTE,	; pointer to the message (ciphertext) to be decrypted
	key:PTR BYTE		; pointer to key
; 
; Overwrite msgBuffer with decrypted message
; ---------------------------------------------- -

; Write your code here
mov edx, msgBuffer
call StrLength
mov ecx, eax 
mov esi, key
mov ebx, msgBuffer
L1:
     mov al, [esi]
     cmp al, 0
     je RESIZE
     sub al, 65
     sub BYTE PTR[ebx], al
     cmp BYTE PTR[ebx], 90
     jae NEXT
     add BYTE PTR[ebx], 26
NEXT:
     inc ebx
     inc esi
     loop L1
     jmp DONE
RESIZE:
     mov esi, key
     jmp L1
DONE:
ret
Decrypt ENDP

END main