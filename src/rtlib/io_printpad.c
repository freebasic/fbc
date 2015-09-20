/* print functions */

#include "fb.h"

#define FB_PRINT_BUFFER_SIZE 2048

static void fb_hPrintPadEx ( FB_FILE *handle, int mask, int current_x, int new_x )
{
#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(handle, "\t", 1, mask);

#else
    char tab_char_buffer[FB_TAB_WIDTH+1];
    if (new_x <= current_x) {
        FB_PRINT_EX(handle, FB_NEWLINE, sizeof(FB_NEWLINE)-1, mask);
    } else {
        size_t count = new_x - current_x;
        memset(tab_char_buffer, 32, count);
        /* the terminating NUL shouldn't be required but it makes
         * debugging easier */
        tab_char_buffer[count] = 0;
        FB_PRINT_EX(handle, tab_char_buffer, count, mask);
    }
#endif
}

/*:::::*/
void fb_PrintPadEx ( FB_FILE *handle, int mask )
{
#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(handle, "\t", 1, mask);

#else
    FB_FILE *tmp_handle;
   	int old_x;
    int new_x;

    fb_DevScrnInit_Write( );

    tmp_handle = FB_HANDLE_DEREF(handle);

    old_x = tmp_handle->line_length + 1;
    new_x = old_x + FB_TAB_WIDTH - 1;
    new_x /= FB_TAB_WIDTH;
    new_x *= FB_TAB_WIDTH;
    new_x += 1;
    if (tmp_handle->width!=0) {
        /* If padding moved us beyond EOL, move to beginning of next line */
        if (new_x > (int)tmp_handle->width) {
            new_x = 1;
        }
    }
    fb_hPrintPadEx(handle, mask, old_x, new_x);
#endif
}

/*:::::*/
FBCALL void fb_PrintPad ( int fnum, int mask )
{
    fb_PrintPadEx( FB_FILE_TO_HANDLE(fnum), mask );
}
