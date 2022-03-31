### --------------------------------------------------------------------
### mydc.s
###
### Desk Calculator (dc)
### --------------------------------------------------------------------

	.equ   ARRAYSIZE, 20
	.equ   EOF, -1
	
.section ".rodata"

scanfFormat:
	.asciz "%s"
printFormat:
        .asciz "%d\n"
Empty:
        .asciz "dc: stack empty"

### --------------------------------------------------------------------

        .section ".data"

### --------------------------------------------------------------------

        .section ".bss"
buffer:
        .skip  ARRAYSIZE

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
	je	quit

        ## check whether digit is
	movl	$0, %ebx
	movzbl	(buffer), %eax
	pushl	%eax
	call	isdigit
	cmpl	$0, %eax
	je	checkpoint
	addl	$4, %esp

	## push and jump back to input
	movl	$buffer, %eax
	pushl	%eax
	call	atoi
	addl	$4, %esp
	pushl	%eax
	jmp	input

checkpoint:
	addl	$4, %esp

	## check if digit is negative
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'_', %eax
	je	minus

	## prirnt operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'p', %eax
	je	print

	## quit operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'q', %eax
	je	quit

	## plus operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'+', %eax
	je	sum

	## subtract operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'-', %eax
	je	subtract

	## multiplication operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'*', %eax
	je	multiplication

	## division operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'/', %eax
	je	division
/*
        ## abssum operator
        movl    $0, %ebx
        movzx   buffer(,%ebx,), %eax
        cmpl    $'|', %eax
        je      abssum
*/
	## print all operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'f', %eax
	je	fullprint

	## clear operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'c', %eax
	je	clear

	## duplicate operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'d', %eax
	je	duplicate

	## reverse operator
	movl	$0, %ebx
	movzx	buffer(,%ebx,), %eax
	cmpl	$'r', %eax
	je	reverse

	## if input is not the digit or operator, jump back to input
	jmp	input

minus:
	movb	$'-', (buffer)
	movl	$buffer, %eax
	pushl	%eax
	call	atoi
	addl	$0x4, %esp
	pushl	%eax
	jmp	input

print:
	## check empty
	cmpl	%ebp, %esp
	je	empty

	pushl	$printFormat
	call	printf
	addl	$4, %esp
	jmp	input

sum:
	## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je	empty

	movl	%esp, %eax
	popl	%eax	## save two values
	popl	%ebx	## save two values
	addl	%ebx, %eax
	pushl	%eax
	jmp	input

subtract:
	## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je	empty

	movl	%esp, %ebx
	popl	%ebx	## save two values
	popl	%eax	## save two values
	subl	%ebx, %eax
	pushl	%eax
	jmp	input

multiplication:
	## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je	empty

	movl	%esp, %eax
	popl	%eax	## save two values
	popl	%ebx	## save two values
	imull	%ebx, %eax
	pushl	%eax
	jmp	input

division:
	## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je	empty

	movl	%esp, %ebx
	popl	%ebx	## save two values
	popl	%eax	## save two values
	cdq
	idivl	%ebx
	pushl	%eax
	jmp	input
/*
abssum:
        ## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je	empty

        movl    %esp, %ebx
	popl	%ebx	## save two values
	popl	%ecx	## save two values
        cmpl    %ebx, %ecx
        je      equal

        movl    $0, %esi
        movl    $0, %edi
        cmpl    %ebx, %ecx
        js      abssum2   ## %ebx is bigger than %ecx
        jmp     abssum3   ## %ecx is bigger than %ebx

equal:
        movl    %ebx, %eax
        cmpl    $0, %eax
        js      minus2
        pushl   %eax
        jmp     input

minus2:
        negl    %eax
        pushl   %eax
        jmp     input

minus3:
        negl    %esi
        incl    %ebx
        jmp     abssum2

minus4:
        negl    %edi
        incl    %ecx
        jmp     abssum3

minuscheck:
        cmpl    $0, %esi
        js      minus2
        pushl   %esi
        jmp     input

minuscheck2:
        cmpl    $0, %edi
        js      minus3
        pushl   %edi
        jmp     input

abssum2:
        ## check the loop is end
        cmpl    %ebx, %ecx
        jns     minuscheck

        cmpl    $0, %ecx
        je      minus2

        addl    %ecx, %esi
        incl    %ecx
        jmp     abssum2

abssum3:
        ## check the loop is end
        cmpl    %ecx, %ebx
        jns     minuscheck

        cmpl    $0, %ebx
        je      minus3

        addl    %ebx, %edi
        incl    %ebx
        jmp     abssum3
*/
fullprint:  ## check the stack and jump to fullprint2
	## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %ebx
	jmp	fullprint2

fullprint2: ## print all values and jump to input
	pushl	(%ebx)	## insert the value one by one
	pushl	$printFormat
	call	printf
	addl	$8, %esp	## pop out the extra value
	addl	$4, %ebx
	cmpl	%ebp, %ebx
	je	input
	jmp	fullprint2

clear:
	cmpl	%ebp, %esp
	je	input
	jmp	clear2

clear2:
        ## clear step by step
	addl	$4, %esp
	jmp	clear

duplicate:
	## check empty
	cmpl	%ebp, %esp
	je	empty

	movl	%esp, %ebx
	pushl	(%ebx)
	jmp	input

reverse:
	## check empty
	cmpl	%esp, %ebp
	je 	empty
	movl	%esp, %eax
	addl	$4, %eax
	cmpl	%eax, %ebp
	je	empty

	movl	%esp, %eax
	popl	%esi
	popl	%edi
	pushl	%esi
	pushl	%edi
	jmp	input

empty:  ## check empty
	pushl	$Empty
	call	printf
	addl	$4, %esp
	jmp	input

quit:	
	## return 0
	movl    $0, %eax
	movl    %ebp, %esp
	popl    %ebp
	ret