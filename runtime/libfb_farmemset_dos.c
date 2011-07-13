/*
 * farmemset.c -- farptr memset routines for DOS
 *
 * chng: jul/2005 written [DrV]
 *
 */

#include "fb.h"

/*:::::*/
void fb_hFarMemSet(unsigned short selector, unsigned long dest, unsigned char char_to_set, size_t bytes)
{
	unsigned long addr = dest;
	int i;
	
	_farsetsel(selector);
	
	for (i = 0; i < bytes; i++, addr++) {
		_farnspokeb(addr, char_to_set);
	}
}

/*:::::*/
void fb_hFarMemSetW(unsigned short selector, unsigned long dest, unsigned short word_to_set, size_t words)
{
	unsigned long addr = dest;
	int i;
	
	_farsetsel(selector);
	
	for (i = 0; i < words; i++, addr += 2) {
		_farnspokew(addr, word_to_set);
	}	
}

