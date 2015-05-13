/* dir() */

#include "fb.h"

FBCALL FBSTRING *fb_DirNext( int *attrib )
{
	static FBSTRING fname = { 0, 0, 0 };
	return fb_Dir( &fname, 0, attrib );
}
