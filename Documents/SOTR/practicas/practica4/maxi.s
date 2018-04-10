.section .data
data_items1:
.long 21,3,67,34,226,75,5,34,44,33,22,11,66,0
data_items2:
.long 3,43,34,225,35,25,5,24,44,33,21,11,26,0
data_items3:
.long 3,67,4,227,15,95,85,74,64,83,72,41,36,0

.section .text
.globl _start

_start:
movl $0,%edi

start_loop1:
movl $data_items1,%esi
pushl %esi
call maximo
addl $4,%esp
pushl %eax
movl $data_items2,%esi
pushl %esi
call maximo
addl $4,%esp
popl %ebx
cmpl %eax,%ebx
jle start_loop2
movl %ebx,%eax

start_loop2:
addl $4,%esp
pushl %eax
movl $data_items3,%esi
pushl %esi
call maximo
addl $4,%esp
popl %ebx
cmpl %ebx,%eax
jle loop_exit
movl %eax,%ebx
je loop_exit

loop_exit:
#movl (%esi,%edi,4),%ebx
movl $1,%eax
int $0x80

.type maximo, @function
maximo:
pushl %ebp
movl %esp,%ebp
subl $4,%esp
movl 8(%ebp),%esi
movl %esi, -4(%ebp)
movl $0,%edi
movl (%esi,%edi,4),%eax
movl %eax,%ebx
movl %ebx, -4(%ebp)

maximo_start_loop:
cmpl $0,%eax
je end_maximo
inc %edi
movl (%esi,%edi,4),%eax
movl %ebx,-4(%ebp)
cmpl %ebx,%eax
jle maximo_start_loop
movl %eax,%ebx
jmp maximo_start_loop

end_maximo:
movl -4(%ebp),%eax
movl %ebp,%esp
popl %ebp
ret



