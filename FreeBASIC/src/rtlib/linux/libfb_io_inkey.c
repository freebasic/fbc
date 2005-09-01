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
	struct NODE *next, *child;
} NODE;

typedef struct KEY_DATA
{
	unsigned char *cap;
	int code;
} KEY_DATA;

static const KEY_DATA key_data[] = {
	{ "ku", KEY_UP }, { "kd", KEY_DOWN }, { "kl", KEY_LEFT }, { "kr", KEY_RIGHT }, { "kI", KEY_INS },
	{ "kD", KEY_DEL }, { "kh", KEY_HOME }, { "@7", KEY_END }, { "kP", KEY_PAGE_UP }, { "kN", KEY_PAGE_DOWN },
	{ "k1", KEY_F1 }, { "k2", KEY_F2 }, { "k3", KEY_F3 }, { "k4", KEY_F4 }, { "k5", KEY_F5 },
	{ "k6", KEY_F6 }, { "k7", KEY_F7 }, { "k8", KEY_F8 }, { "k9", KEY_F9 }, { "k;", KEY_F10 },
	{ "kT", KEY_TAB }, { "kb", KEY_BACKSPACE }, { NULL, 0 }
};


static int key_buffer[MAX_BUFFER_LEN], key_head = 0, key_tail = 0;
static NODE *root_node = NULL;


/*:::::*/
static void add_key(NODE **node, unsigned char *key, short code)
{
	NODE *n;
	
	for (n = *node; n; n = n->next) {
		if (n->key == *key) {
			add_key(&n->child, key + 1, code);
			return;
		}
	}
	n = malloc(sizeof(NODE));
	n->child = NULL;
	n->next = *node;
	n->key = *key;
	n->code = 0;
	*node = n;
	
	if (*(key + 1))
		add_key(&n->child, key + 1, code);
	else
		n->code = code;
}


/*:::::*/
static void init_keys()
{
	KEY_DATA *data;
	char *key;
	
	for (data = (KEY_DATA *)key_data; data->cap; data++) {
		key = tgetstr(data->cap, NULL);
		if (key)
			add_key(&root_node, key + 1, data->code);
	}
	add_key(&root_node, "[M", KEY_MOUSE);
}


/*:::::*/
static int get_input()
{
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
		if (!root_node)
			init_keys();
		node = root_node;
		while (node) {
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
				k = fb_con.keyboard_getch();
				if (k == -1)
					return -1;
				node = node->child;
				continue;
			}
			node = node->next;
		}
		while(fb_con.keyboard_getch() >= 0)
			;
		return -1;
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

	fb_hResize();
	
	if ((ch = fb_hGetCh(TRUE)) >= 0) {
		chars = 1;
		if (ch & 0x100) {
			chars = 2;
			ch &= 0xFF;
        }

        res = fb_hStrAllocTemp( NULL, chars );
        DBG_ASSERT( res!=NULL );

		if( chars > 1 )
			res->data[0] = FB_EXT_CHAR;		/* note: can't use '\0' here as in qb */

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

	fb_hResize();
	
	while ((k = fb_hGetCh(TRUE)) < 0)
		;

	return k & 0xFF;
}


/*:::::*/
int fb_ConsoleKeyHit( void )
{
	if (!fb_con.inited)
		return feof(stdin) ? FALSE : TRUE;

	fb_hResize();
	
	return (fb_hGetCh(FALSE) < 0) ? 0 : 1;
}

