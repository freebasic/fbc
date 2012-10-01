#include "../fb.h"
#include <windows.h>

FBCALL void fb_Delay( int msecs )
{
	Sleep( msecs );
}
