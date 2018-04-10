#PURPOSE:
#programa simple que sale y devuelve un codigo de estado al kernel de linux

#INPUT:
#none
#OUTPUT: devuelve un c[odigo de estado. esto puede ser visto

#VARIABLE
#%EAX MANTIENE AL SISTEMA LLAMANDO NUMEROS
#%ebx mantienen devolviendo el estado

.section .data
.section .text
.globl _start
_start:
movl $1,%eax		#este es el comando del kernel de linux
movl $0,%ebx		#este es el numero del estado
int $0x80		#esto despertara al kernel para correr
