#include "common.h"
#include "descriptor_tables.h"

// Lets us access our ASM functions from our C code.

extern void gdt_flush(u32int);

// Internal function prototypes.

static void init_gdt();

static void gdt_set_gate(s32int,u32int,u32int,u8int,u8int);

static void init_idt();

static void idt_set_gate(u8int,u32int,u16int,u8int);

gdt_entry_t gdt_entries[5];
gdt_ptr_t   gdt_ptr;
idt_entry_t idt_entries[256];
idt_ptr_t   idt_ptr;

void init_descriptor_tables()
{

   // Initialise the global descriptor table.

   init_gdt();
   init_idt();

}


static void init_gdt()

{

   gdt_ptr.limit = (sizeof(gdt_entry_t) * 5) - 1;

   gdt_ptr.base  = (u32int)&gdt_entries;



   gdt_set_gate(0, 0, 0, 0, 0);                // Null segment

   gdt_set_gate(1, 0, 0xFFFFFFFF, 0x9A, 0xCF); // Code segment

   gdt_set_gate(2, 0, 0xFFFFFFFF, 0x92, 0xCF); // Data segment

   gdt_set_gate(3, 0, 0xFFFFFFFF, 0xFA, 0xCF); // User mode code segment

   gdt_set_gate(4, 0, 0xFFFFFFFF, 0xF2, 0xCF); // User mode data segment

   gdt_flush((u32int)&gdt_ptr);

}

static void init_idt()

{

   idt_ptr.limit = sizeof(idt_entry_t) * 256 -1;

   idt_ptr.base  = (u32int)&idt_entries;

   memset(&idt_entries, 0, sizeof(idt_entry_t)*256);

   idt_set_gate( 0, (u32int)isr0 , 0x08, 0x8E);

   idt_set_gate( 1, (u32int)isr1 , 0x08, 0x8E);

   idt_flush((u32int)&idt_ptr);
// Remap the irq table.
  outb(0x20, 0x11);
  outb(0xA0, 0x11);
  outb(0x21, 0x20);
  outb(0xA1, 0x28);
  outb(0x21, 0x04);
  outb(0xA1, 0x02);
  outb(0x21, 0x01);
  outb(0xA1, 0x01);
  outb(0x21, 0x0);
  outb(0xA1, 0x0);
  idt_set_gate(32, (u32int)irq0, 0x08, 0x8E);

}

// Set the value of one GDT entry.

static void gdt_set_gate(s32int num, u32int base, u32int limit, u8int access, u8int gran)

{

   gdt_entries[num].base_low    = (base & 0xFFFF);

   gdt_entries[num].base_middle = (base >> 16) & 0xFF;

   gdt_entries[num].base_high   = (base >> 24) & 0xFF;


   gdt_entries[num].limit_low   = (limit & 0xFFFF);

   gdt_entries[num].granularity = (limit >> 16) & 0x0F;


   gdt_entries[num].granularity |= gran & 0xF0;

   gdt_entries[num].access      = access;

}



static void idt_set_gate(u8int num, u32int base, u16int sel, u8int flags)

{

   idt_entries[num].base_lo = base & 0xFFFF;

   idt_entries[num].base_hi = (base >> 16) & 0xFFFF;



   idt_entries[num].sel     = sel;

   idt_entries[num].always0 = 0;

   // We must uncomment the OR below when we get to using user-mode.

   // It sets the interrupt gate's privilege level to 3.

   idt_entries[num].flags   = flags /* | 0x60 */;

}
