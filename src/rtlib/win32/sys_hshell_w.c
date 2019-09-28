/* SHELL command (wide string) */

#include "../fb.h"

int fb_hShell_W( FB_WCHAR *program )
{
	return _wsystem( program );
}
