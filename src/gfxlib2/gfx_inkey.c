/* inkey$ handling */

#include "fb_gfx.h"

#define KEY_BUFFER_LEN		16

static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;
static int key_buffer_changed = FALSE;

int fb_hGfxInputBufferChanged( void )
{
	int res;

	FB_GRAPHICS_LOCK( );
	DRIVER_LOCK();

    res = key_buffer_changed;
    key_buffer_changed = FALSE;

	DRIVER_UNLOCK();
	FB_GRAPHICS_UNLOCK( );

	return res;
}

/* Only called from gfx drivers; caller is expected to hold DRIVER_LOCK() */
void fb_hPostKey(int key)
{
	key_buffer[key_tail] = key;
	if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
    key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
    key_buffer_changed = TRUE;
}

#ifdef HOST_DOS
void fb_hPostKey_End(void)
{ /* this function is here to get the length of the fb_hPostKey function so
     the DOS gfxlib driver can lock it into physical memory for use in an
     interrupt handler */ }
#endif

static int get_key(void)
{
	int key = 0;

	DRIVER_LOCK();

	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}

    /* Reset the status for "key buffer changed" when a key
     * was removed from the input queue. */
    fb_hGfxInputBufferChanged();

	DRIVER_UNLOCK();

	return key;
}

/* Doing synchronization manually here because getkey() is blocking */
int fb_GfxGetkey(void)
{
	int key = 0;

	/* Poll until next key press */
	while( 1 ) {
		FB_GRAPHICS_LOCK( );

		/* Abort if gfx screen was closed */
		if (!__fb_gfx) {
			FB_GRAPHICS_UNLOCK( );
			break;
		}

		key = get_key( );

		FB_GRAPHICS_UNLOCK( );

		if( key != 0 ) {
			break;
		}

		fb_Sleep(20);
	}

	return key;
}

/* Caller is expected to hold FB_LOCK() */
int fb_GfxKeyHit(void)
{
	int res;

	FB_GRAPHICS_LOCK( );
	DRIVER_LOCK();

	res = (key_head != key_tail? 1: 0);

	DRIVER_UNLOCK();
	FB_GRAPHICS_UNLOCK( );

	return res;
}

/* Caller is expected to hold FB_LOCK() */
FBSTRING *fb_GfxInkey(void)
{
	FBSTRING *res;
	int ch;

	FB_GRAPHICS_LOCK( );

	if (__fb_gfx && (ch = get_key())) {
		res = fb_hMakeInkeyStr( ch );
	} else {
		res = &__fb_ctx.null_desc;
	}

	FB_GRAPHICS_UNLOCK( );

	return res;
}

int fb_GfxIsRedir(int is_input)
{
	return FB_FALSE;
}
