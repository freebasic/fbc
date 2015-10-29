/* low-level print to console function */

#include "../fb.h"
#include "fb_private_console.h"

#define ENTER_UTF8  "\e%G"
#define EXIT_UTF8   "\e%@"

void fb_ConsolePrintBufferWstrEx( const FB_WCHAR *buffer, size_t chars, int mask )
{
	size_t avail, avail_len;
	char *temp;

	if( !__fb_con.inited )
	{
		/* !!!FIXME!!! is this ok or should it be converted to UTF-8 too? */
		fwrite( buffer, sizeof( FB_WCHAR ), chars, stdout );
		fflush( stdout );
		return;
	}

	temp = alloca( chars * 4 + 1 );

	BG_LOCK( );
	fb_hRecheckConsoleSize( TRUE );
	BG_UNLOCK( );

	/* ToDo: handle scrolling for internal characters/attributes buffer? */
	avail = (__fb_con.w * __fb_con.h) - (((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1);
	avail_len = chars;
	if (avail < avail_len)
		avail_len = avail;

	/* !!!FIXME!!! to support unicode the char_buffer would have to be a wchar_t,
				   slowing down non-unicode printing.. */
	fb_wstr_ConvToA( temp, avail_len, buffer );

	memcpy( __fb_con.char_buffer + ((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1,
	        temp,
	        avail_len );

	memset( __fb_con.attr_buffer + ((__fb_con.cur_y - 1) * __fb_con.w) + __fb_con.cur_x - 1,
	        __fb_con.fg_color | (__fb_con.bg_color << 4),
	        avail_len );

	/* convert wchar_t to UTF-8 */
	ssize_t bytes;

	fb_WCharToUTF( FB_FILE_ENCOD_UTF8, buffer, chars, temp, &bytes );
	/* add null-term */
	temp[bytes] = '\0';

	fputs( ENTER_UTF8, stdout );

	fputs( temp, stdout );

	fputs( EXIT_UTF8, stdout );

	/* update x and y coordinates.. */
	for( ; chars; chars--, buffer++ )
	{
		++__fb_con.cur_x;
		if( (*buffer == _LC('\n')) || (__fb_con.cur_x >= __fb_con.w) )
		{
			__fb_con.cur_x = 1;
			++__fb_con.cur_y;
			if( __fb_con.cur_y > __fb_con.h )
				__fb_con.cur_y = __fb_con.h;
		}
	}

	fflush( stdout );
}

void fb_ConsolePrintBufferWstr( const FB_WCHAR *buffer, int mask )
{
	return fb_ConsolePrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );
}
