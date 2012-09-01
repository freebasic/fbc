/* console INKEY() function */

#include "../fb.h"
#include "fb_private_console.h"
#include <termcap.h>

#define KEY_BUFFER_LEN 256

#define KEY_MOUSE		0x200

typedef struct NODE
{
	char key;
	short code;
	struct NODE *next, *child;
} NODE;

typedef struct KEY_DATA
{
	char *cap;
	int code;
} KEY_DATA;

static const KEY_DATA key_data[] = {
	{ "ku", KEY_UP }, { "kd", KEY_DOWN }, { "kl", KEY_LEFT }, { "kr", KEY_RIGHT }, { "kI", KEY_INS },
	{ "kD", KEY_DEL }, { "kh", KEY_HOME }, { "@7", KEY_END }, { "kP", KEY_PAGE_UP }, { "kN", KEY_PAGE_DOWN },
	{ "k1", KEY_F1 }, { "k2", KEY_F2 }, { "k3", KEY_F3 }, { "k4", KEY_F4 }, { "k5", KEY_F5 },
	{ "k6", KEY_F6 }, { "k7", KEY_F7 }, { "k8", KEY_F8 }, { "k9", KEY_F9 }, { "k;", KEY_F10 },
	{ "kT", KEY_TAB }, { "kb", KEY_BACKSPACE }, { NULL, 0 }
};

static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;
static NODE *root_node = NULL;

static void add_key(NODE **node, char *key, short code)
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

static void init_keys()
{
	KEY_DATA *data;
	char *key;

	for (data = (KEY_DATA *)key_data; data->cap; data++) {
		key = tgetstr(data->cap, NULL);
		if (key) {
			add_key(&root_node, key + 1, data->code); }
	}
	add_key(&root_node, "[M", KEY_MOUSE);
}

static int get_input()
{
	NODE *node;
	int k, cb, cx, cy;

	k = __fb_con.keyboard_getch();
	if (k == 0x7F)
		k = 8;
	else if (k == '\n')
		k = '\r';
	else if (k == '\e') {
		k = __fb_con.keyboard_getch();
		if (k == EOF)
			return 27;
		if (!root_node)
			init_keys();
		node = root_node;
		while (node) {
			if (k == node->key) {
				if (node->code) {
					if (node->code == KEY_MOUSE) {
						cb = __fb_con.keyboard_getch();
						cx = __fb_con.keyboard_getch();
						cy = __fb_con.keyboard_getch();
						if (__fb_con.mouse_update)
							__fb_con.mouse_update(cb, cx, cy);
						return -1;
					}
					return node->code;
				}
				k = __fb_con.keyboard_getch();
				if (k == -1)
					return -1;
				node = node->child;
				continue;
			}
			node = node->next;
		}
		while(__fb_con.keyboard_getch() >= 0)
			;
		return -1;
	}

	return k;
}

int fb_hGetCh(int remove)
{
	int k;

	k = get_input();
	if (k >= 0) {
		key_buffer[key_tail] = k;
		if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
			key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
		key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
	}
	if (key_head != key_tail) {
		k = key_buffer[key_head];
		if (remove)
			key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}
	return k;
}

FBSTRING *fb_ConsoleInkey( void )
{
	FBSTRING *res;
	int ch;

	if (!__fb_con.inited)
		return &__fb_ctx.null_desc;

	if ((ch = fb_hGetCh(TRUE)) >= 0) {
		res = fb_hMakeInkeyStr( ch );
	} else {
		res = &__fb_ctx.null_desc;
	}

	return res;
}

int fb_ConsoleGetkey( void )
{
	int key;

	if (!__fb_con.inited)
		return fgetc(stdin);

	while ((key = fb_hGetCh(TRUE)) < 0)
		fb_Sleep( -1 );

	return key;
}

int fb_ConsoleKeyHit( void )
{
	if (!__fb_con.inited)
		return feof(stdin) ? FALSE : TRUE;
	
	return (fb_hGetCh(FALSE) < 0) ? 0 : 1;
}
