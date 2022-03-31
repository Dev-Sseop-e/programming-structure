	.file	"wc209.c"
	.section	.rodata
.LC0:
	.string	"%d %d %d\n"
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
	subq	$32, %rsp
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L44:
	call	getchar@PLT
	movl	%eax, -24(%rbp)
	cmpl	$5, -4(%rbp)
	ja	.L2
	movl	-4(%rbp), %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L4(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax, %rdx
	leaq	.L4(%rip), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L4:
	.long	.L3-.L4
	.long	.L5-.L4
	.long	.L6-.L4
	.long	.L7-.L4
	.long	.L8-.L4
	.long	.L9-.L4
	.text
.L3:
	cmpl	$10, -24(%rbp)
	jne	.L10
	addl	$1, -16(%rbp)
	addl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L11
.L10:
	cmpl	$32, -24(%rbp)
	jne	.L12
	addl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L11
.L12:
	cmpl	$47, -24(%rbp)
	jne	.L13
	movl	$2, -4(%rbp)
	jmp	.L11
.L13:
	cmpl	$-1, -24(%rbp)
	jne	.L14
	movq	stdout(%rip), %rax
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %ecx
	movl	-16(%rbp), %edx
	movl	%esi, %r8d
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$0, %eax
	jmp	.L15
.L14:
	addl	$1, -12(%rbp)
	addl	$1, -8(%rbp)
	movl	$1, -4(%rbp)
.L11:
	cmpl	$1, -8(%rbp)
	je	.L16
	cmpl	$0, -8(%rbp)
	jne	.L2
.L16:
	addl	$1, -16(%rbp)
	jmp	.L2
.L5:
	cmpl	$10, -24(%rbp)
	jne	.L18
	addl	$1, -16(%rbp)
	addl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L18:
	cmpl	$32, -24(%rbp)
	jne	.L20
	addl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L20:
	cmpl	$47, -24(%rbp)
	jne	.L21
	movl	$3, -4(%rbp)
	jmp	.L2
.L21:
	cmpl	$-1, -24(%rbp)
	jne	.L22
	movq	stdout(%rip), %rax
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %ecx
	movl	-16(%rbp), %edx
	movl	%esi, %r8d
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$0, %eax
	jmp	.L15
.L22:
	addl	$1, -8(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L2
.L6:
	cmpl	$47, -24(%rbp)
	jne	.L23
	addl	$1, -8(%rbp)
	movl	$2, -4(%rbp)
	jmp	.L2
.L23:
	cmpl	$10, -24(%rbp)
	jne	.L25
	addl	$2, -8(%rbp)
	addl	$1, -12(%rbp)
	addl	$1, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L25:
	cmpl	$32, -24(%rbp)
	jne	.L26
	addl	$2, -8(%rbp)
	addl	$1, -12(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L26:
	cmpl	$42, -24(%rbp)
	jne	.L27
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	$4, -4(%rbp)
	jmp	.L2
.L27:
	cmpl	$-1, -24(%rbp)
	jne	.L28
	addl	$1, -8(%rbp)
	movq	stdout(%rip), %rax
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %ecx
	movl	-16(%rbp), %edx
	movl	%esi, %r8d
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$0, %eax
	jmp	.L15
.L28:
	addl	$2, -8(%rbp)
	addl	$1, -12(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L2
.L7:
	cmpl	$47, -24(%rbp)
	jne	.L29
	addl	$1, -8(%rbp)
	movl	$3, -4(%rbp)
	jmp	.L2
.L29:
	cmpl	$10, -24(%rbp)
	jne	.L31
	addl	$2, -8(%rbp)
	addl	$1, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L31:
	cmpl	$32, -24(%rbp)
	jne	.L32
	addl	$2, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L32:
	cmpl	$42, -24(%rbp)
	jne	.L33
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	$4, -4(%rbp)
	jmp	.L2
.L33:
	cmpl	$-1, -24(%rbp)
	jne	.L34
	addl	$1, -8(%rbp)
	movq	stdout(%rip), %rax
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %ecx
	movl	-16(%rbp), %edx
	movl	%esi, %r8d
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$0, %eax
	jmp	.L15
.L34:
	addl	$2, -8(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L2
.L8:
	cmpl	$10, -24(%rbp)
	jne	.L35
	addl	$1, -8(%rbp)
	addl	$1, -16(%rbp)
	movl	$4, -4(%rbp)
	jmp	.L2
.L35:
	cmpl	$42, -24(%rbp)
	jne	.L37
	movl	$5, -4(%rbp)
	jmp	.L2
.L37:
	cmpl	$-1, -24(%rbp)
	jne	.L38
	movq	stderr(%rip), %rax
	movl	-20(%rbp), %edx
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L15
.L38:
	movl	$4, -4(%rbp)
	jmp	.L2
.L9:
	cmpl	$10, -24(%rbp)
	jne	.L39
	addl	$1, -8(%rbp)
	addl	$1, -16(%rbp)
	movl	$4, -4(%rbp)
	jmp	.L45
.L39:
	cmpl	$47, -24(%rbp)
	jne	.L41
	addl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L45
.L41:
	cmpl	$42, -24(%rbp)
	jne	.L42
	movl	$5, -4(%rbp)
	jmp	.L45
.L42:
	cmpl	$-1, -24(%rbp)
	jne	.L43
	movq	stderr(%rip), %rax
	movl	-20(%rbp), %edx
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L15
.L43:
	movl	$4, -4(%rbp)
.L45:
	nop
.L2:
	cmpl	$-1, -24(%rbp)
	jne	.L44
	movl	$0, %eax
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.5.0-1ubuntu2) 5.4.1 20171010"
	.section	.note.GNU-stack,"",@progbits
