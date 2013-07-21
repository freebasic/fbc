/* console line input function */

#include "../fb.h"
#include "fb_private_console.h"

char *fb_ConsoleReadStr( char *buffer, ssize_t len )
{
	int k, x, y, cols;
	ssize_t pos = 0;
	char ch[2] = { 0, '\0' };

	if (!__fb_con.inited)
		return fgets(buffer, len, stdin);

	fb_ConsoleGetSize(&cols, NULL);

	do {
		while( ((k = fb_hGetCh(TRUE)) == -1) || (k > 0xFF) )
			fb_Delay( 10 );

		fb_ConsoleGetXY(&x, &y);

		if (k == 8) {
			if (pos > 0) {
				x--;
				if (x <= 0) {
					x = cols;
					y--;
					if (y <= 0)
						x = y = 1;
				}
				fb_hTermOut(SEQ_LOCATE, x-1, y-1);
				fb_hTermOut(SEQ_DEL_CHAR, 0, 0);
				pos--;
			}
		} else if (k != '\t') {
			if (pos < len - 1) {
				buffer[pos++] = ch[0] = k;
				fb_ConsolePrintBuffer(ch, 0);
				if (x == cols)
					fputc( '\n', stdout );
			}
		}
	} while (k != '\r');

	fputc( '\n', stdout );
	buffer[pos] = '\0';

	return buffer;
}
