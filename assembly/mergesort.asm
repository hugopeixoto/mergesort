;
; nasm -felf mergesort.asm -o mergesort.o
; gcc -o mergesort mergesort.o
;
BITS 32

	global	main
	extern	printf

	section .text
main:
	mov edi, sorted
	mov esi, array
	mov ecx, 10
	rep movsd

	push 10
	push 0
	push sorted
	call mergesort
	add esp, 12

	push sorted
	push 10
	call print
	add esp, 8
	ret

; 20	max
; 16	med
; 12	min
; 8	array
merge:
	push ebp
	mov ebp, esp
	push eax
	push ecx
	push edx
	push edi
	push esi

	;mov edi, temp
	;mov eax, 0
	;mov ecx, 10
	;rep stosw

	mov ecx, [ebp+20]
	sub ecx, [ebp+12]

	shl DWORD[ebp+12], 2
	shl DWORD[ebp+16], 2
	shl DWORD[ebp+20], 2

	mov edx, temp		; dest
	mov edi, [ebp+8]	; middle source
	add edi, [ebp+16]	;

	; messing with the stack. vamos somar aos 3 idxs o addr base

	mov esi, [ebp+8]
	add [ebp+12], esi
	add [ebp+16], esi
	add [ebp+20], esi
	mov esi, [ebp+12]

.next:
	; source != med
	cmp esi, [ebp+16]
	jnz .second
	; middle != max
	cmp edi, [ebp+20]
	jnz .first
	; sao os dois iguais. fim
	jmp .end

	; quatro condicoes manhosas... medo.
	; vao ser usadas totil de labels
.first:
	cmp esi, [ebp+16]
	jnz .second

	;vamos meter o edi no edx.
	mov eax, [edi]
	mov [edx], eax
	add edx, 4
	add edi, 4
	jmp .next

.second:
	cmp edi, [ebp+20]
	jnz .third

	;vamos meter o esi no edx
	mov eax, [esi]
	mov [edx], eax
	add edx, 4
	add esi, 4
	jmp .next

.third:
	mov eax, [esi]
	cmp eax, [edi]
	jnl .forth

	; meter o esi no edx
	mov [edx], eax
	add edx, 4
	add esi, 4
	jmp .next

.forth:
	mov eax, [edi]
	mov [edx], eax
	add edi, 4
	add edx, 4
	jmp .next
.end:

	;push temp
	;push 10
	;call print
	;add esp, 8

	mov esi, temp
	mov edi, [ebp+12]
	rep movsd

	;push DWORD[ebp+8]
	;push 10
	;call print
	;add esp, 8

	;push endl
	;call printf
	;add esp, 4

	pop esi
	pop edi
	pop edx
	pop ecx
	pop eax
	mov esp, ebp
	pop ebp
	ret

mergesort:
	push ebp
	mov ebp, esp
	push eax

	mov eax, DWORD[ebp+16]	; max
	sub eax, [ebp+12]	; min
	cmp eax, 2
	JL .end
		push edx
		push ebx
			xor edx, edx
			mov ebx, 2
			div ebx
		pop ebx
		pop edx
		add eax, [ebp+12]	; med

		; siga recursivar.
		push eax		; max
		push DWORD[ebp+12]	; min
		push DWORD[ebp+8]	; array
		call mergesort
		add esp, 12

		push DWORD[ebp+16]	; max
		push eax		; min
		push DWORD[ebp+8]	; array
		call mergesort
		add esp, 12

		push DWORD[ebp+16]	; max
		push eax		; med
		push DWORD[ebp+12]	; min
		push DWORD[ebp+8]	; array
		call merge
		add esp, 16
.end:
	pop eax
	mov esp, ebp
	pop ebp
	ret


print:
	push ebp	; Prologue
	mov ebp, esp
	push ecx
	push edx

	mov edx, [ebp+12]
	mov ecx, [ebp+8]

.args:
		push ecx
		push edx
		push DWORD[edx]
		push format
		call printf
		add esp, 8
		pop edx
		pop ecx
		add edx, 4
	LOOP .args

	push endl
	call printf
	add esp, 4

	pop edx		;
	pop ecx		;
	mov esp, ebp	;
	pop ebp		; Epilogue
	ret		;

format:
	db	' %2d', 0
endl:
	db	10, 0

array:
	dd	10, 9, 8, 4, 5, 6, 7, 3, 2, 1


	section .bss
sorted:
	resd	10
temp:
	resd	10

