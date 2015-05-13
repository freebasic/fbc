/* ports I/O functions */

#include "../fb.h"
#include "fb_private_console.h"

int fb_hIn( unsigned short port )
{
	unsigned char value;
	__asm__ volatile ("inb %1, %0" : "=a" (value) : "d" (port));
	return (int)value;
}

int fb_hOut( unsigned short port, unsigned char value )
{
	__asm__ volatile ("outb %0, %1" : : "a" (value), "d" (port));
	return FB_RTERROR_OK;
}
