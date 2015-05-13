/* gfx hook for INPUT support */

#include "fb_gfx.h"

static void move_back(void)
{
	__fb_gfx->cursor_x--;
	if (__fb_gfx->cursor_x < 0) {
		__fb_gfx->cursor_x = __fb_gfx->text_w - 1;
		__fb_gfx->cursor_y--;
	}
}

char *fb_GfxReadStr(char *buffer, ssize_t maxlen)
{
	int key;
	ssize_t len = 0;
	char cursor_normal[2] = { 219, '\0' };
	char cursor_backspace[3] = { 219, ' ', '\0' };
	char space[2] = { ' ', '\0' };
	char character[2] = { 0, '\0' };
	char *cursor = cursor_normal;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return NULL;
	}

	do {
		fb_GfxPrintBuffer(cursor, 0);

		if (cursor == cursor_backspace) {
			move_back();
			cursor = cursor_normal;
		}
		move_back();

		key = fb_Getkey();
		if (key < 0x100) {
			if (key == 8) {
				if (len > 0) {
					cursor = cursor_backspace;
					move_back();
					if (__fb_gfx->cursor_y < 0) {
						__fb_gfx->cursor_y = __fb_gfx->cursor_x = 0;
						cursor = cursor_normal;
					}
					len--;
				}
			}
			else if ((key != 7) && (len < maxlen - 1)) {
				if (key == 13) {
					fb_GfxPrintBuffer(space, 0);
					move_back();
				}
				buffer[len++] = key;
				character[0] = key;
				fb_GfxPrintBuffer(character, 0);
			}
		}
	} while (key != 13);

	buffer[len] = '\0';

	FB_GRAPHICS_UNLOCK( );
	return buffer;
}
