/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * io_inkey.c -- inkey$ function for Linux console mode apps
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"

#define MAX_BUFFER_LEN	256

#define KEY_UP			(0x100 | 'H')
#define KEY_DOWN		(0x100 | 'P')
#define KEY_LEFT		(0x100 | 'K')
#define KEY_RIGHT		(0x100 | 'M')
#define KEY_INS			(0x100 | 'R')
#define KEY_DEL			(0x100 | 'S')
#define KEY_HOME		(0x100 | 'G')
#define KEY_END			(0x100 | 'O')
#define KEY_PAGE_UP		(0x100 | 'I')
#define KEY_PAGE_DOWN	(0x100 | 'Q')
#define KEY_F1			(0x100 | ';')
#define KEY_F2			(0x100 | '<')
#define KEY_F3			(0x100 | '=')
#define KEY_F4			(0x100 | '>')
#define KEY_F5			(0x100 | '?')
#define KEY_F6			(0x100 | '@')
#define KEY_F7			(0x100 | 'A')
#define KEY_F8			(0x100 | 'B')
#define KEY_F9			(0x100 | 'C')
#define KEY_F10			(0x100 | 'D')
#define KEY_TAB			'\t'
#define KEY_BACKSPACE	8
#define KEY_MOUSE		0x200


typedef struct NODE
{
	unsigned char key;
	unsigned short code;
	struct NODE *next;
} NODE;

static NODE F1[] = { { '~', KEY_F1, NULL }, { 0 } },
	    F2[] = { { '~', KEY_F2, NULL }, { 0 } },
	    F3[] = { { '~', KEY_F3, NULL }, { 0 } },
	    F4[] = { { '~', KEY_F4, NULL }, { 0 } },
	    F5[] = { { '~', KEY_F5, NULL }, { 0 } },
	    F6[] = { { '~', KEY_F6, NULL }, { 0 } },
	    F7[] = { { '~', KEY_F7, NULL }, { 0 } },
	    F8[] = { { '~', KEY_F8, NULL }, { 0 } },
	    F9[] = { { '~', KEY_F9, NULL }, { 0 } },
	    F10[] = { { '~', KEY_F10, NULL }, { 0 } },
	    Delete[] = { { '~', KEY_DEL, NULL }, { 0 } },
	    Home[] = { { '~', KEY_HOME, NULL }, { 0 } },
	    End[] = { { '~', KEY_END, NULL }, { 0 } },
	    PageUp[] = { { '~', KEY_PAGE_UP, NULL }, { 0 } },
	    PageDown[] = { { '~', KEY_PAGE_DOWN, NULL }, { 0 } },
	    Sub1[] = { { '~', KEY_HOME, NULL }, { '7', 0, F6 }, { '8', 0, F7 }, { '9', 0, F8 }, { 0, 0, F1 },
	    	       { 0, 0, F2 }, { 0, 0, F3 }, { 0, 0, F4 }, { 0, 0, F5 }, { 0 } },
	    Sub2[] = { { '~', KEY_INS, NULL }, { '0', 0, F9 }, { '1', 0, F10 }, { 0 } },
	    SubBrace[] = { { 'A', KEY_F1, NULL }, { 'B', KEY_F2, NULL }, { 'C', KEY_F3, NULL }, { 'D', KEY_F4, NULL },
			   { 'E', KEY_F5, NULL }, { 0 } },
	    Console[] = { { '[', 0, SubBrace }, { 'A', KEY_UP, NULL }, { 'B', KEY_DOWN, NULL }, { 'C', KEY_RIGHT, NULL },
	    		  { 'D', KEY_LEFT, NULL }, { 'M', KEY_MOUSE, NULL }, { '1', 0, Sub1 }, { '2', 0, Sub2 }, { '3', 0, Delete },
	    		  { '4', 0, End }, { '5', 0, PageUp }, { '6', 0, PageDown }, { 0, 0, Home },
	    		  { 0, 0, End }, { 0, KEY_TAB, NULL }, { 0, KEY_BACKSPACE, NULL }, { 0 } },
	    X11[] = { { 'P', KEY_F1, NULL }, { 'Q', KEY_F2, NULL }, { 'R', KEY_F3, NULL }, { 'S', KEY_F4, NULL },
	    	      { 'F', KEY_END, NULL }, { 'H', KEY_HOME, NULL }, { 'A', KEY_UP, NULL }, { 'B', KEY_DOWN, NULL },
	    	      { 'C', KEY_RIGHT, NULL }, { 'D', KEY_LEFT, NULL }, { 0 } },
	    Sequence[] = { { '[', 0, Console }, { 0, 0, X11 }, { 0 } };


static int key_buffer[MAX_BUFFER_LEN], key_head = 0, key_tail = 0;


/*:::::*/
static int get_input()
{
	static int getch_inited = FALSE;
	NODE *node;
	int k, cb, cx, cy;

	k = fb_con.keyboard_getch();
	if (k == 0x7F)
		k = 8;
	else if (k == '\n')
		k = '\r';
	else if (k == '\e') {
		k = fb_con.keyboard_getch();
		if (k == EOF)
			return 27;
		if (!getch_inited) {
			if (fb_con.inited != INIT_CONSOLE) {
				/* Fixups for X11 compatibility */
				Sub1[4].key = '1';
				Sub1[5].key = '2';
				Sub1[6].key = '3';
				Sub1[7].key = '4';
				Sub1[8].key = '5';
				Console[12].key = '7';
				Console[13].key = '8';
				Console[14].key = 'T';
				Console[15].key = 'K';
				Sequence[1].key = 'O';
			}
			getch_inited = TRUE;
		}
		node = Sequence;
		for (;;) {
			while (node->key) {
				if (k == node->key) {
					if (node->code) {
						if (node->code == KEY_MOUSE) {
							cb = fb_con.keyboard_getch();
							cx = fb_con.keyboard_getch();
							cy = fb_con.keyboard_getch();
							if (fb_con.mouse_update)
								fb_con.mouse_update(cb, cx, cy);
							return -1;
						}
						return node->code;
					}
					node = node->next;
					break;
				}
				node++;
			}
			if (!node->key) {
				fflush(fb_con.f_in);
				return -1;
			}
			k = fb_con.keyboard_getch();
			if (k == -1)
				return -1;
		}
	}
	
	return k;
}


/*:::::*/
int fb_hGetCh(int remove)
{
	int k;
	
	k = get_input();
	if (k >= 0) {
		key_buffer[key_tail] = k;
		if (((key_tail + 1) & (MAX_BUFFER_LEN - 1)) == key_head)
			key_head = (key_head + 1) & (MAX_BUFFER_LEN - 1);
		key_tail = (key_tail + 1) & (MAX_BUFFER_LEN - 1);
	}
	if (key_head != key_tail) {
		k = key_buffer[key_head];
		if (remove)
			key_head = (key_head + 1) & (MAX_BUFFER_LEN - 1);
	}	
	return k;
}


/*:::::*/
FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING *res;
	int ch, chars;

	if (!fb_con.inited)
		return &fb_strNullDesc;

	if ((ch = fb_hGetCh(TRUE)) >= 0) {
		chars = 1;
		if (ch & 0x100) {
			chars = 2;
			ch &= 0xFF;
		}
		res = (FBSTRING *)fb_hStrAllocTmpDesc();

		fb_hStrAllocTemp(res, chars);

		if( chars > 1 )
			res->data[0] = 255;		/* note: can't use '\0' here as in qb */

		res->data[chars-1] = (unsigned char)ch;
		res->data[chars-0] = '\0';
	}
	else
		res = &fb_strNullDesc;

	return res;
}


/*:::::*/
int fb_ConsoleGetkey( void )
{
	int k = 0;
	
	if (!fb_con.inited)
		return fgetc(stdin);

	while ((k = fb_hGetCh(TRUE)) < 0)
		;

	return k & 0xFF;
}


/*:::::*/
int fb_ConsoleKeyHit( void )
{
	if (!fb_con.inited)
		return (feof(fb_con.f_in) ? 0: 1);
	
	return (fb_hGetCh(FALSE) < 0) ? 0 : 1;
}
