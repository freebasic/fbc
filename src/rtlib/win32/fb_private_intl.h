#include <windows.h>

char *fb_hGetLocaleInfo( LCID Locale, LCTYPE LCType, char *pszBuffer, size_t uiSize );
FBSTRING *fb_hIntlConvertString( FBSTRING *source, int source_cp, int dest_cp );
