	.file	"mymemsetnt.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"MYMEMSETNT IN USE!\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	__init_mymemsetnt
	.type	__init_mymemsetnt, @function
__init_mymemsetnt:
.LFB3:
	.cfi_startproc
	movq	stderr@GOTPCREL(%rip), %rax
	leaq	.LC0(%rip), %rsi
	movq	(%rax), %rdi
	xorl	%eax, %eax
	jmp	fprintf@PLT
	.cfi_endproc
.LFE3:
	.size	__init_mymemsetnt, .-__init_mymemsetnt
	.section	.init_array,"aw"
	.align 8
	.quad	__init_mymemsetnt
	.text
	.p2align 4,,15
	.globl	mymemsetnt
	.type	mymemsetnt, @function
mymemsetnt:
.LFB4:
	.cfi_startproc
	cmpq	$15, %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rax
	movq	%rdi, %rcx
	jbe	.L3
	leaq	-16(%rsp), %r10
	movq	%rsp, %r11
	movl	%esi, %r9d
	subq	%r10, %r11
	movq	%r11, %rdi
	shrq	$4, %rdi
	movq	%rdi, %rbx
	salq	$4, %rbx
	testq	%rbx, %rbx
	je	.L20
	cmpq	$15, %r11
	jbe	.L20
	movd	%esi, %xmm0
	xorl	%ecx, %ecx
	punpcklbw	%xmm0, %xmm0
	punpcklwd	%xmm0, %xmm0
	pshufd	$0, %xmm0, %xmm0
	.p2align 4,,10
	.p2align 3
.L5:
	movq	%rcx, %r8
	addq	$1, %rcx
	salq	$4, %r8
	cmpq	%rcx, %rdi
	movntdq	%xmm0, (%r10,%r8)
	ja	.L5
	cmpq	%rbx, %r11
	leaq	(%r10,%rbx), %rcx
	je	.L6
	.p2align 4,,10
	.p2align 3
.L25:
	movb	%r9b, (%rcx)
	addq	$1, %rcx
	cmpq	%rsp, %rcx
	jb	.L25
.L6:
	testb	$15, %al
	je	.L21
	movq	%rax, %rcx
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L9:
	testq	%rdx, %rdx
	je	.L34
.L12:
	movb	%r9b, (%rcx)
	addq	$1, %rcx
	subq	$1, %rdx
	testb	$15, %cl
	jne	.L9
	movq	%rcx, %rdi
.L8:
	cmpq	$127, %rdx
	jbe	.L11
	leaq	-128(%rdx), %r9
	movdqa	-16(%rsp), %xmm0
	movq	%rdi, %rcx
	shrq	$7, %r9
	movq	%r9, %r8
	salq	$7, %r8
	leaq	128(%rdi,%r8), %r8
	.p2align 4,,10
	.p2align 3
.L14:
	movntdq	%xmm0, (%rcx)
	movntdq	%xmm0, 16(%rcx)
	movntdq	%xmm0, 32(%rcx)
	movntdq	%xmm0, 48(%rcx)
	movntdq	%xmm0, 64(%rcx)
	movntdq	%xmm0, 80(%rcx)
	movntdq	%xmm0, 96(%rcx)
	movntdq	%xmm0, 112(%rcx)
	subq	$-128, %rcx
	cmpq	%r8, %rcx
	jne	.L14
	leaq	1(%r9), %rcx
	andl	$127, %edx
	salq	$7, %rcx
	addq	%rcx, %rdi
.L11:
	cmpq	$63, %rdx
	jbe	.L15
	movdqa	-16(%rsp), %xmm0
	andl	$63, %edx
	movntdq	%xmm0, (%rdi)
	movntdq	%xmm0, 16(%rdi)
	movntdq	%xmm0, 32(%rdi)
	movntdq	%xmm0, 48(%rdi)
	addq	$64, %rdi
.L15:
	cmpq	$31, %rdx
	jbe	.L16
	movdqa	-16(%rsp), %xmm0
	andl	$31, %edx
	movntdq	%xmm0, (%rdi)
	movntdq	%xmm0, 16(%rdi)
	addq	$32, %rdi
.L16:
	cmpq	$15, %rdx
	jbe	.L22
	movdqa	-16(%rsp), %xmm0
	leaq	16(%rdi), %rcx
	andl	$15, %edx
	movntdq	%xmm0, (%rdi)
.L3:
	testq	%rdx, %rdx
	je	.L17
	movq	%rcx, %r9
	.p2align 4,,10
	.p2align 3
.L18:
	movb	%sil, (%rcx)
	addq	$1, %rcx
	movq	%rcx, %r8
	subq	%r9, %r8
	cmpq	%r8, %rdx
	ja	.L18
.L17:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L34:
	.cfi_restore_state
	movq	%rcx, %rdi
.L22:
	sfence
	movq	%rdi, %rcx
	jmp	.L3
.L21:
	movq	%rax, %rdi
	.p2align 4,,2
	jmp	.L8
.L20:
	movq	%r10, %rcx
	jmp	.L25
	.cfi_endproc
.LFE4:
	.size	mymemsetnt, .-mymemsetnt
	.globl	memsetnt
	.set	memsetnt,mymemsetnt
	.ident	"GCC: (Debian 4.7.1-7) 4.7.1"
	.section	.note.GNU-stack,"",@progbits
