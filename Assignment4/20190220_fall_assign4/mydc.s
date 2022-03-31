### --------------------------------------------------------------------
### mydc.s
###
### Desk Calculator (dc)
### --------------------------------------------------------------------

	.equ   ARRAYSIZE, 20
	.equ   EOF, -1
	.equ   RAND_MAX, 1024
	.equ   DIVIDER, 2
.section ".rodata"

scanfFormat:
	.asciz "%s"
printFormat:
	.asciz "%d\n"
Empty:
	.asciz "dc: stack empty\n"
### --------------------------------------------------------------------

        .section ".data"

### --------------------------------------------------------------------

        .section ".bss"
buffer:
        .skip	ARRAYSIZE

### --------------------------------------------------------------------

	.section ".text"

	## -------------------------------------------------------------
	## int main(void)
	## Runs desk calculator program.  Returns 0.
	## -------------------------------------------------------------

	.globl  main
	.type   main, @function

main:

	pushl   %ebp
	movl    %esp, %ebp

input:

	## dc number stack initialized. %esp = %ebp
	
	## scanf("%s", buffer)
	pushl	$buffer
	pushl	$scanfFormat
	call    scanf
	addl    $8, %esp

	## check if user input EOF
	cmpl	$EOF, %eax
	je		quit

	## check whether digit is
	movl	$0, %ebx
	movzbl	(buffer), %eax
	pushl	%eax
	call	isdigit
	cmpl	$0, %eax
	je		checkpoint
	addl	$4, %esp

	## push and jump back to input
	movl	$buffer, %eax
	pushl	%eax
	call	atoi
	addl	$4, %esp
	pushl	%eax
	jmp		input

checkpoint:
	addl	$4, %esp

	## check if digit is negative
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'_', %eax
	je		minus

	## prirnt operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'p', %eax
	je		print

	## quit operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'q', %eax
	je		quit

	## plus operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'+', %eax
	je		sum

	## subtract operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'-', %eax
	je		subtract

	## multiplication operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'*', %eax
	je		multiplication

	## division operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'/', %eax
	je		division

	## remainder operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'%', %eax
	je		remainder

	## power operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'^', %eax
	je		powfunc

	## print all operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'f', %eax
	je		fullprint

	## clear operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'c', %eax
	je		clear

	## duplicate operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'d', %eax
	je		duplicate

	## reverse operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'r', %eax
	je		reverse

	## random operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'x', %eax
	je		random

	## largest prime number operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'y', %eax
	je		primenum

	## if input is not the digit or operator, jump back to input
	jmp		input

minus:
	movb	$'-', (buffer)
	movl	$buffer, %eax
	pushl	%eax
	call	atoi
	addl	$0x4, %esp
	pushl	%eax
	jmp		input

print:
	## check empty
	cmpl	%ebp, %esp
	je		empty

	pushl	$printFormat
	call	printf
	addl	$4, %esp
	jmp		input

sum:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	movl	%esp, %eax
	popl	%eax	## save two values
	popl	%ebx	## save two values
	addl	%ebx, %eax
	pushl	%eax
	jmp		input

subtract:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	movl	%esp, %ebx
	popl	%ebx	## save two values
	popl	%eax	## save two values
	subl	%ebx, %eax
	pushl	%eax
	jmp		input

multiplication:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	movl	%esp, %eax
	popl	%eax	## save two values
	popl	%ebx	## save two values
	imull	%ebx, %eax
	pushl	%eax
	jmp		input

division:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	movl	%esp, %ebx
	popl	%ebx	## save two values
	popl	%eax	## save two values
	cdq
	idivl	%ebx
	pushl	%eax
	jmp		input

remainder:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	movl	%esp, %ebx
	popl	%ebx	## save two values
	popl	%eax	## save two values
	cdq
	idivl	%ebx
	pushl	%edx
	jmp		input

powfunc:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	## pop the value and move to power
	movl	%esp, %eax
	popl	%eax	## save two values
	popl	%ebx	## save two values
	movl	%ebx, %ecx	## ecx is the base of power value
	jmp		power

power:      ## caclulate the power
	cmpl	$1, %eax
	je		insert
	imull	%ecx, %ebx
	decl	%eax	## use the eax to index
	jmp		power

insert:     ## insert the power
	pushl	%ebx
	jmp		input

fullprint:  ## check the stack and jump to fullprint2
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %ebx
	jmp		fullprint2

fullprint2: ## print all values and jump to input
	pushl	(%ebx)	## insert the value one by one
	pushl	$printFormat
	call	printf
	addl	$8, %esp	## pop out the extra value
	addl	$4, %ebx
	cmpl	%ebp, %ebx
	je		input
	jmp		fullprint2

clear:
	cmpl	%ebp, %esp
	je		input
	jmp		clear2

clear2:     ## clear step by step
	addl	$4, %esp
	jmp		clear

duplicate:
	## check empty
	cmpl	%ebp, %esp
	je		empty

	movl	%esp, %ebx
	pushl	(%ebx)
	jmp		input

reverse:
	## check empty
	cmpl	%esp, %ebp
	je 		empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je		empty

	movl	%esp, %eax
	popl	%esi
	popl	%edi
	pushl	%esi
	pushl	%edi
	jmp		input

random:
	movl	%esp, %eax
	pushl	$0
	call	time
	pushl	%eax
	call	srand
	addl	$8, %esp
	pushl	%eax
	call	rand
	addl	$4, %esp
	movl	$RAND_MAX, %esi
	cdq
	idivl	%esi
	pushl	%edx
	jmp		input

primenum:
	## check empty
	cmpl	%esp, %ebp
	je 		empty

	## check whether esp is 1
	cmpl	$1, (%esp)
	jle		input

	jmp input
/*
	movl	$DIVIDER, %edi
	movl	(%esp), %esi
	movl	(%esp), %ebx
	incl	%esi
	pushl	%esi
	pushl	%edi
	jmp		primecal1

primecal1:
	movl	$DIVIDER, %edi
	decl	%esi
	jmp		primecal2

primecal2:
	cmp		(%esi), %edi
	je		gotcha
	movl	$0, %edx
	cdq
	idiv	%edi
	cmp		$0, %edx
	je		primecal1
	jmp		primecal3

primecal3:
	incl	%edi
	jmp		primecal2

gotcha:
	popl	%esi
	jmp		input
*/

empty:  ## check empty
	pushl	$Empty
	call	printf
	addl	$4, %esp
	jmp		input

quit:  ## quit the program
	## return 0
	movl    $0, %eax
	movl    %ebp, %esp
	popl    %ebp
	ret
