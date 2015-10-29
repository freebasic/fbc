/* graphical mode wstring text output */

#include "fb_gfx.h"

void fb_GfxPrintBufferWstrEx(const FB_WCHAR *buffer, size_t len, int mask)
{
	/* Unicode gfx font support is out of the scope of gfxlib, convert to ascii */
	
	char temp[len + 1];

	if( len > 0 )
		fb_wstr_ConvToA( temp, len, buffer );
	else
		*temp = '\0';

	fb_GfxPrintBufferEx( temp, len, mask );
}

void fb_GfxPrintBufferWstr(const FB_WCHAR *buffer, int mask)
{
	fb_GfxPrintBufferWstrEx( buffer, fb_wstr_Len(buffer), mask);
}
