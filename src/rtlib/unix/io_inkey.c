/* console INKEY() function */

#include "../fb.h"
#include "fb_private_console.h"
#include <termcap.h>

/*#define DEBUG_TGETSTR*/
#ifdef DEBUG_TGETSTR
#include <ctype.h>
#endif

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

/* see also termcap(5) man page */
static const KEY_DATA key_data[] = {
	{ "kb", KEY_BACKSPACE },
	{ "kT", KEY_TAB       },
	{ "k1", KEY_F1        },
	{ "k2", KEY_F2        },
	{ "k3", KEY_F3        },
	{ "k4", KEY_F4        },
	{ "k5", KEY_F5        },
	{ "k6", KEY_F6        },
	{ "k7", KEY_F7        },
	{ "k8", KEY_F8        },
	{ "k9", KEY_F9        },
	{ "k;", KEY_F10       },
	{ "F1", KEY_F11       },
	{ "F2", KEY_F12       },
	{ "kh", KEY_HOME      },
	{ "ku", KEY_UP        },
	{ "kP", KEY_PAGE_UP   },
	{ "kl", KEY_LEFT      },
	{ "kr", KEY_RIGHT     },
	{ "@7", KEY_END       },
	{ "kd", KEY_DOWN      },
	{ "kN", KEY_PAGE_DOWN },
	{ "kI", KEY_INS       },
	{ "kD", KEY_DEL       },
	{ NULL, 0 }
};

static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0, key_buffer_changed = FALSE;
static NODE *root_node = NULL;

static void add_key(NODE **node, char *key, short code)
{
	NODE *n;

	/**
	 * This builds a simple tree that allows fairly easy lookup of the
	 * terminal escape sequences (keys) that were added. For example:
	 *
	 *     after adding these key sequences:
	 *
	 *         [a1, [a2, [b1, [b2
	 *
	 *     the tree looks like:  (| = child, - = sibling)
	 *
	 *         root -> <[>
	 *                  |
	 *                 <b>-----------<a>
	 *                  |             |
	 *                 <2>----<1>    <2>----<1>
	 */

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

static void init_keys(void)
{
	KEY_DATA *data;
	char *key;

	for (data = (KEY_DATA *)key_data; data->cap; data++) {
		/**
		 * Lookup the terminal escape sequences (termcap database
		 * entries) corresponding to the id strings defined in the
		 * key_data table above (only key presses here).
		 *
		 * For example, the id string "kh" corresponds to the HOME key,
		 * and tgetstr("kh", NULL) returns the escape sequence that the
		 * terminal will send when the HOME key was pressed.
		 *
		 * These typically vary from terminal to terminal (for example
		 * TERM=xterm vs. TERM=linux) and perhaps depend on other
		 * factors aswell.
		 */
		key = tgetstr(data->cap, NULL);

#ifdef DEBUG_TGETSTR
		fprintf(stderr, "tgetstr( %s ) =", data->cap);
		if( key ) {
			int i;
			for( i = 0; i < strlen( key ); i++ ) {
				if( isprint( key[i] ) ) {
					fprintf(stderr, " %c", key[i]);
				} else {
					fprintf(stderr, " 0x%2x", key[i]);
				}
			}
		} else {
			fprintf(stderr, " (null)");
		}
		fprintf(stderr, "\n");
#endif

		if (key) {
			add_key(&root_node, key + 1, data->code);
		}
	}
	add_key(&root_node, "[M", KEY_MOUSE);
}

static int get_input(void)
{
	NODE *node;
	int k, cb, cx, cy;

	k = __fb_con.keyboard_getch();
	if (k == '\e') {
		k = __fb_con.keyboard_getch();
		if (k == EOF)
			return 27;

		/* init the tree (on the first received escape sequence) */
		if (!root_node)
			init_keys();

		/* look up the escape sequence in the tree */
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

		/* not found yet, skip rest and ignore */
		while(__fb_con.keyboard_getch() >= 0)
			;

		return -1;
	}

	return k;
}

/* assumes BG_LOCK(), because it can be called from the background thread,
   through fb_hTermQuery() */
void fb_hAddCh( int k )
{
	if (k == 0x7F)
		k = 8;
	else if (k == '\n')
		k = '\r';

	key_buffer[key_tail] = k;
	if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
	key_buffer_changed = TRUE;
}

int fb_hGetCh(int remove)
{
	int k;

	k = get_input();
	if (k >= 0) {
		BG_LOCK();
		fb_hAddCh( k );
		BG_UNLOCK();
	}
	if (key_head != key_tail) {
		k = key_buffer[key_head];
		if (remove)
			key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}

	return k;
}

/* Caller is expected to hold FB_LOCK() */
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

/* Doing synchronization manually here because getkey() is blocking */
int fb_ConsoleGetkey( void )
{
	int key;

	do {
		FB_LOCK( );

		if (!__fb_con.inited) {
			FB_UNLOCK( );
			return fgetc(stdin);
		}

		key = fb_hGetCh( TRUE );

		FB_UNLOCK( );

		if( key >= 0 ) {
			break;
		}

		fb_Sleep( -1 );
	} while( 1 );

	return key;
}

/* Caller is expected to hold FB_LOCK() */
int fb_ConsoleKeyHit( void )
{
	int result;

	if (!__fb_con.inited)
		return feof(stdin) ? FALSE : TRUE;

	fb_hGetCh(FALSE);
	result = key_buffer_changed;
	key_buffer_changed = FALSE;
	return result;
}
