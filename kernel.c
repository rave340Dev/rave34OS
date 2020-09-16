// #include <stdbool.h>
// #include <stddef.h>
// #include <stdint.h>
#include <terminal.h>
 
#if !defined(__i386__)
#error "This needs to be compiled with a ix86-elf compiler"
#endif
 
void kernel_main(void) 
{
	/* Initialize terminal interface */
	terminal_initialize();
 
	/* Newline support is left as an exercise. */
	terminal_writestring("Hello, kernel World!\t");
}