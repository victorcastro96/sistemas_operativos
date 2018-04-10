.section .data
data_items1:
.long 20,3,67,34,222,75,5,34,44,33,22,11,66,0
#data_items2:
#.long 3,43,34,22,35,25,5,24,44,33,21,11,26,0
#data_items3:
#.long 3,67,4,221,15,95,85,74,64,83,72,41,36,0
 
.section .text
.globl _start

_start:
movl $0,%edi

start_loop1:
#pushl %edi esto no es necesario porque %edi es un registro
#pushl data_items1(,%edi,4) esto no importa porque podemos obtener el 
#valor directamente en la funcion
call maximo			#llamada a la funcion
addl $8,%esp
pushl %eax
movl %eax,%ebx
movl $1,%eax
int $0x80

.type maximo,@function
maximo:
pushl %ebp			#Guarda el ultimo apuntador a la base
movl %esp,%ebp			#hace stack pointer en la base del apuntador
subl $4,%esp		   	#obtiene el cuarto para almacenamiento local	
#movl 8(%ebp),%ebx		#pone el primer argumento en %ebx (vector)
#movl 12(%ebp),%ecx		#pone el segundo argumento en %ecx (apuntador
				#a vector)
#movl %ebx, -4(%ebp)		#store del resultado actual
#movl %ebx,%eax
movl $0,%edi
movl data_items1(,%edi,4),%eax
movl %eax,%ebx
movl %ebx, -4(%ebp)

maximo_start_loop:
cmpl $0,%eax
je end_maximo
inc %edi
movl data_items1(,%edi,4),%eax
movl %ebx,-4(%ebp)
cmpl %ebx,%eax
jle maximo_start_loop           #salta al principio del bucle si el nuevo no es
                                #mas grande
movl %eax,%ebx                  #mueve el valor como el mas grande
jmp maximo_start_loop                  #salta al inicio del ciclo

end_maximo:
movl -4(%ebp),%eax
movl %ebp,%esp
popl %ebp
ret   
