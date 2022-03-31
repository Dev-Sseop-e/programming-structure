	.file	"decomment.c"
	.section	.rodata
.LC0:
	.string	"/%c"
	.align 8
.LC1:
	.string	"Error: line %d: unterminated comment\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movb	$0, -13(%rbp)
	movl	$1, -12(%rbp)
	movl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L49:
	call	getchar
	movb	%al, -13(%rbp)
	cmpl	$7, -4(%rbp)
	ja	.L2
	movl	-4(%rbp), %eax
	movq	.L4(,%rax,8), %rax
	jmp	*%rax
	.section	.rodata
	.align 8
	.align 4
.L4:
	.quad	.L3
	.quad	.L5
	.quad	.L6
	.quad	.L7
	.quad	.L8
	.quad	.L9
	.quad	.L10
	.quad	.L11
	.text
.L3:
	cmpb	$10, -13(%rbp)
	jne	.L12
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$0, -4(%rbp)
	jmp	.L2
.L12:
	cmpb	$32, -13(%rbp)
	jne	.L14
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$0, -4(%rbp)
	jmp	.L2
.L14:
	cmpb	$47, -13(%rbp)
	jne	.L15
	movl	$1, -4(%rbp)
	jmp	.L2
.L15:
	cmpb	$34, -13(%rbp)
	jne	.L16
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$4, -4(%rbp)
	jmp	.L2
.L16:
	cmpb	$39, -13(%rbp)
	jne	.L17
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$5, -4(%rbp)
	jmp	.L2
.L17:
	cmpb	$-1, -13(%rbp)
	jne	.L18
	movl	$0, %eax
	jmp	.L19
.L18:
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	cmpb	$47, -13(%rbp)
	jne	.L20
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$1, -4(%rbp)
	jmp	.L2
.L20:
	cmpb	$42, -13(%rbp)
	jne	.L22
	movl	-12(%rbp), %eax
	movl	%eax, -8(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, %rsi
	movl	$32, %edi
	call	fputc
	movl	$2, -4(%rbp)
	jmp	.L2
.L22:
	cmpb	$-1, -13(%rbp)
	jne	.L23
	movl	$0, %eax
	jmp	.L19
.L23:
	cmpb	$10, -13(%rbp)
	jne	.L24
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %edx
	movq	stdout(%rip), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$0, -4(%rbp)
	jmp	.L2
.L24:
	movsbl	-13(%rbp), %edx
	movq	stdout(%rip), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$0, -4(%rbp)
	jmp	.L2
.L6:
	cmpb	$10, -13(%rbp)
	jne	.L25
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$2, -4(%rbp)
	jmp	.L2
.L25:
	cmpb	$42, -13(%rbp)
	jne	.L27
	movl	$3, -4(%rbp)
	jmp	.L2
.L27:
	cmpb	$-1, -13(%rbp)
	jne	.L28
	movq	stderr(%rip), %rax
	movl	-8(%rbp), %edx
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L19
.L28:
	movl	$2, -4(%rbp)
	jmp	.L2
.L7:
	cmpb	$10, -13(%rbp)
	jne	.L29
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$2, -4(%rbp)
	jmp	.L2
.L29:
	cmpb	$42, -13(%rbp)
	jne	.L31
	movl	$3, -4(%rbp)
	jmp	.L2
.L31:
	cmpb	$47, -13(%rbp)
	jne	.L32
	movl	$0, -4(%rbp)
	jmp	.L2
.L32:
	cmpb	$-1, -13(%rbp)
	jne	.L33
	movq	stderr(%rip), %rax
	movl	-8(%rbp), %edx
	movl	$.LC1, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L19
.L33:
	movl	$2, -4(%rbp)
	jmp	.L2
.L8:
	cmpb	$34, -13(%rbp)
	jne	.L34
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$0, -4(%rbp)
	jmp	.L2
.L34:
	cmpb	$92, -13(%rbp)
	jne	.L36
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$6, -4(%rbp)
	jmp	.L2
.L36:
	cmpb	$10, -13(%rbp)
	jne	.L37
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$4, -4(%rbp)
	jmp	.L2
.L37:
	cmpb	$-1, -13(%rbp)
	jne	.L38
	movl	$0, %eax
	jmp	.L19
.L38:
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$4, -4(%rbp)
	jmp	.L2
.L9:
	cmpb	$39, -13(%rbp)
	jne	.L39
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$0, -4(%rbp)
	jmp	.L2
.L39:
	cmpb	$92, -13(%rbp)
	jne	.L41
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$7, -4(%rbp)
	jmp	.L2
.L41:
	cmpb	$10, -13(%rbp)
	jne	.L42
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$5, -4(%rbp)
	jmp	.L2
.L42:
	cmpb	$-1, -13(%rbp)
	jne	.L43
	movl	$0, %eax
	jmp	.L19
.L43:
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$5, -4(%rbp)
	jmp	.L2
.L10:
	cmpb	$10, -13(%rbp)
	jne	.L44
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$4, -4(%rbp)
	jmp	.L2
.L44:
	cmpb	$-1, -13(%rbp)
	jne	.L46
	movl	$0, %eax
	jmp	.L19
.L46:
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$4, -4(%rbp)
	jmp	.L2
.L11:
	cmpb	$10, -13(%rbp)
	jne	.L47
	addl	$1, -12(%rbp)
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$5, -4(%rbp)
	jmp	.L2
.L47:
	cmpb	$-1, -13(%rbp)
	jne	.L48
	movl	$0, %eax
	jmp	.L19
.L48:
	movsbl	-13(%rbp), %eax
	movq	stdout(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	movl	$5, -4(%rbp)
.L2:
	cmpb	$-1, -13(%rbp)
	jne	.L49
	movl	$0, %eax
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
