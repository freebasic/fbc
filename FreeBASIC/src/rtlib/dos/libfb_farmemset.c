/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

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

