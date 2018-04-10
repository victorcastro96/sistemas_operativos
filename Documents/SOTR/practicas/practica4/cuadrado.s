#Escribir una funcion llamada cuadrado la cual debe recibir un argumento de 
#entrada y returnar el cuadrado del argumento

.section .data
.section .text
.globl _start

_start:
pushl $10        #argumento de entrada
call square     #Llamada a la funcion
addl $8, %esp   #move the stack pointer back
movl %eax,%ebx

movl $1,%eax
int $0x80

.type square,@function
square:
pushl %ebp      #Guarda el ultimo apuntador a la base
movl %esp,%ebp  #hace stack pointer en la base del apuntador
subl $4,%esp
movl 8(%ebp),%ebx
movl %ebx, -4(%ebp)
movl $2,%ecx

square_loop_start:
cmpl $1,%ecx
je end_square
movl -4(%ebp),%eax
imull %ebx,%eax
movl %eax,-4(%ebp)
decl %ecx
jmp square_loop_start

end_square:
movl -4(%ebp),%eax
movl %ebp,%esp
popl %ebp
ret
