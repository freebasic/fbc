/* cls (console, no gfx) function for Windows */

#include "fb.h"

/*:::::*/
void fb_ConsoleClearViewRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2 )
{
    WORD    attr = (WORD) fb_ConsoleGetColorAttEx( hConsole );
    int     width = x2 - x1 + 1, lines = y2 - y1 + 1;

    if( width==0 || lines==0 )
        return;

    DBG_ASSERT(width > 0);
    DBG_ASSERT(lines > 0);

    while (lines--) {
        DWORD written;
        COORD coord = { x1, y1 + lines };
        FillConsoleOutputAttribute( hConsole, attr, width, coord, &written);
        FillConsoleOutputCharacter( hConsole, ' ', width, coord, &written );
    }

    fb_ConsoleLocateRawEx( hConsole, y1, x1, -1 );
}
