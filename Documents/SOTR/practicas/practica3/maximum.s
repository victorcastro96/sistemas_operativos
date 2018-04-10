.section .data
data_items:
.long 3,67,34,222,45,75,5,34,44,33,22,11,66,0
.section .text
.globl _start
_start:
movl $0,%edi			#mueve cero al interior del indice de registros
movl data_items(,%edi,4),%eax	#carga el primer byte de dato
movl %eax,%ebx			#ya que este es el prime item, %eax es el
				#mas grande
start_loop:
cmpl $0,%eax			#comprueba si hemos llegado al final
je loop_exit			
inc %edi			#carga el siguiente valor
movl data_items(,%edi,4),%eax	
cmpl %ebx,%eax			#compara valores
jle start_loop			#salta al principio del bucle si el nuevo no es
				#mas grande
movl %eax,%ebx			#mueve el valor como el mas grande
jmp start_loop			#salta al inicio del ciclo

loop_exit:
#%ebx es el codigo de estado paara la llamada al sistema de salida
#y ya tiene el numero maximo
movl $1,%eax			#1 es el exit() syscall
int $0x80
