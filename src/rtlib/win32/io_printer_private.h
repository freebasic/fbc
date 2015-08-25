#include <windows.h>
#include <winspool.h>

struct _W32_PRINTER_INFO;

typedef void (*FnEmuPrint)(struct _W32_PRINTER_INFO *pInfo, const void *pText, size_t uiLength, int isunicode);

/* Win32-specific printer information */
typedef struct _W32_PRINTER_INFO {
    HANDLE          hPrinter;
    DWORD           dwJob;
    HDC             hDc;
    struct {
        DWORD       dwFullSizeX;
        DWORD       dwFullSizeY;
        DWORD       dwSizeX;
        DWORD       dwSizeY;
        DWORD       dwOffsetX;
        DWORD       dwOffsetY;
        DWORD       dwDPI_X;
        DWORD       dwDPI_Y;

        DWORD       dwCurrentX;
        DWORD       dwCurrentY;
        HFONT       hFont;
        COLORREF    clFore, clBack;
        DWORD       dwFontSizeX;
        DWORD       dwFontSizeY;
        int         iPageStarted;

        FnEmuPrint  pfnPrint;
    } Emu;
} W32_PRINTER_INFO;
