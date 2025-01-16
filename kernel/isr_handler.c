// isr_handler.c

#include "isr_handler.h"
#include "io.h"

// Array of function pointers to handle custom ISRs
isr_t interrupt_handlers[256];

// This gets called from our ASM interrupt handler stub.
void isr_handler(registers_t regs) {
    if (interrupt_handlers[regs.int_no] != 0) {
        isr_t handler = interrupt_handlers[regs.int_no];
        handler(&regs);
    } else {
        // Handle the interrupt in a default way
        // For now, we will just print the interrupt number
        char str[3];
        itoa(regs.int_no, str, 10);
        kprint("Received interrupt: ");
        kprint(str);
        kprint("\n");
    }
}

// This enables registration of callbacks for interrupts or IRQs
void register_interrupt_handler(uint8_t n, isr_t handler) {
    interrupt_handlers[n] = handler;
}