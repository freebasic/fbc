/* print functions */

#include "fb.h"

#define FB_PRINT_BUFFER_SIZE 2048

static void fb_hPrintPadWstrEx
	(
		FB_FILE *handle,
		int mask,
		int current_x,
		int new_x
	)
{
#ifdef FB_NATIVE_TAB
    FB_PRINTWSTR_EX( handle, _LC("\t"), 1, mask );

#else
    FB_WCHAR tab_char_buffer[FB_TAB_WIDTH+1];

    if (new_x <= current_x)
    {
        FB_PRINTWSTR_EX( handle,
        				 FB_NEWLINE_WSTR,
        				 sizeof( FB_NEWLINE_WSTR ) / sizeof( FB_WCHAR ) - 1,
        				 mask );
    }
    else
    {
        size_t i, count = new_x - current_x;

        for( i = 0; i < count; i++ )
        	tab_char_buffer[i] = _LC(' ');

        /* the terminating NUL shouldn't be required but it makes
         * debugging easier */
        tab_char_buffer[count] = 0;

        FB_PRINTWSTR_EX( handle, tab_char_buffer, count, mask );
    }
#endif
}

/*:::::*/
void fb_PrintPadWstrEx
	(
		FB_FILE *handle,
		int mask
	)
{
#ifdef FB_NATIVE_TAB
    FB_PRINTWSTR_EX( handle, _LC("\t"), 1, mask );

#else
    FB_FILE *tmp_handle;
   	int old_x;
    int new_x;

    fb_DevScrnInit_WriteWstr( );

    tmp_handle = FB_HANDLE_DEREF(handle);

    old_x = tmp_handle->line_length + 1;
    new_x = old_x + FB_TAB_WIDTH - 1;
    new_x /= FB_TAB_WIDTH;
    new_x *= FB_TAB_WIDTH;
    new_x += 1;
    if (tmp_handle->width!=0)
    {
        unsigned dev_width = tmp_handle->width;
        if (new_x > (int)(dev_width - FB_TAB_WIDTH))
        {
            new_x = 1;
        }
    }
    fb_hPrintPadWstrEx( handle, mask, old_x, new_x );
#endif
}

/*:::::*/
FBCALL void fb_PrintPadWstr
	(
		int fnum,
		int mask
	)
{
    fb_PrintPadWstrEx( FB_FILE_TO_HANDLE(fnum), mask );
}
