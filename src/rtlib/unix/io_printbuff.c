/* low-level print to console function */

#include "../fb.h"
#include "fb_private_console.h"

#define CTRL_ALWAYS 0x0800D101
#define ENTER_UTF8  "\e%G"
#define EXIT_UTF8   "\e%@"

void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
	size_t avail, avail_len;
	const unsigned char *cbuffer = (const unsigned char *) buffer;
	unsigned int c;

	if (!__fb_con.inited) {
		fwrite(buffer, len, 1, stdout);
		fflush(stdout);
		return;
	}

	BG_LOCK( );
	fb_hRecheckConsoleSize( TRUE );
	BG_UNLOCK( );

	/* ToDo: handle scrolling for internal characters/attributes buffer? */
	avail = (__fb_con.w * __fb_con.h) - (((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1);
	avail_len = len;
	if (avail < avail_len)
		avail_len = avail;
	memcpy(__fb_con.char_buffer + ((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1, buffer, avail_len);
	memset(__fb_con.attr_buffer + ((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1, __fb_con.fg_color | (__fb_con.bg_color << 4), avail_len);

	for (; len; len--, cbuffer++) {
		c = *cbuffer;
		if( c == 0 ) 
			c = 32;

		if (c < 32) {
			if ((CTRL_ALWAYS >> c) & 0x1) {
				/* This character can't be printed, we must use unicode
				 * Enter UTF-8 and start constructing 0xF000 code
				 */
				fputs( ENTER_UTF8 "\xEF\x80", stdout );
				/* Set the last 6 bits */
				fputc( c | 0x80, stdout );
				/* Escape UTF-8 */
				fputs( EXIT_UTF8, stdout );
			} else
				fputc( c, stdout );
		} else
			fputc( c, stdout );

		__fb_con.cur_x++;
		if ((c == 10) || (__fb_con.cur_x >= __fb_con.w)) {
			__fb_con.cur_x = 1;
			__fb_con.cur_y++;
			if (__fb_con.cur_y > __fb_con.h)
				__fb_con.cur_y = __fb_con.h;
		}
	}

	fflush( stdout );
}

void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
	return fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}
