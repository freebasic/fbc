/* console width() function */

#include "../fb.h"

int fb_ConsoleWidth( int cols, int rows )
{
	return (25 << 16) | 80;
}
