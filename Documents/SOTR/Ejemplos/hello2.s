.text
message:
 .ascii "Hello, World!\12\0"
 .align 4
.globl _hw               
_hw:
 movl $4, %eax           
 movl $1, %ebx           
 movl $message, %ecx     
 movl $15, %edx          
 int $0x80               
 movl $1, %eax           
 movl $0, %ebx           
 int $0x80        
