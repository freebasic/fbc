/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * io_printer.c -- printer access for Windows
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include <ctype.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_con.h"
#include "fb_rterr.h"

typedef BOOL (WINAPI *FnGetDefaultPrinter)(LPTSTR pszBuffer, LPDWORD pcchBuffer);

struct _W32_PRINTER_INFO;

typedef void (*FnEmuPrint)(struct _W32_PRINTER_INFO *pInfo,
                           const char *pachText,
                           size_t uiLength );

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

/* Entry for the list of available printers */
typedef struct _DEV_PRINTER_DEVICE {
    FB_LISTELEM     elem;
    char           *device;
    char           *printer_name;
} DEV_PRINTER_DEVICE;

/* Information about a single printer emulation mode */
typedef struct _DEV_PRINTER_EMU_MODE {
    const char     *pszId;
    FnEmuPrint      pfnPrint;
} DEV_PRINTER_EMU_MODE;

static
void EmuBuild_LOGFONT( LOGFONT *lf,
                       W32_PRINTER_INFO *pInfo,
                       unsigned uiCPI );
static
    void EmuUpdateInfo( W32_PRINTER_INFO *pInfo );
static
    void EmuPrint_RAW( W32_PRINTER_INFO *pInfo, const char *pachText, size_t uiLength );
static
    void EmuPrint_TTY( W32_PRINTER_INFO *pInfo, const char *pachText, size_t uiLength );
#if 0
static
    void EmuPrint_ESC_P2( W32_PRINTER_INFO *pInfo, const char *pachText, size_t uiLength );
#endif

/* List of all known printer emulation modes */
static const DEV_PRINTER_EMU_MODE aEmulationModes[] = {
    { "RAW", EmuPrint_RAW }
    , { "TTY", EmuPrint_TTY }
#if 0
    , { "ESC/P2", EmuPrint_ESC_P2 }
#endif
};

/** Initialize the list of device info nodes.
 */
static void
fb_hListDevInit      ( FB_LIST *list )
{
    fb_hListDynInit( list );
}

/** Allocate a new device info node.
 *
 * @return pointer to the new node
 */
static DEV_PRINTER_DEVICE *
fb_hListDevElemAlloc ( FB_LIST *list, const char *device, const char *printer_name )
{
    DEV_PRINTER_DEVICE *node = (DEV_PRINTER_DEVICE*) calloc( 1, sizeof(DEV_PRINTER_DEVICE) );
    node->device = strdup(device);
    node->printer_name = strdup(printer_name);
    fb_hListDynElemAdd( list, &node->elem );
    return node;
}

/** Remove the device info node and release its memory.
 */
static void
fb_hListDevElemFree  ( FB_LIST *list, DEV_PRINTER_DEVICE *node )
{
    fb_hListDynElemRemove( list, &node->elem );
    free(node->device);
    free(node->printer_name);
    free(node);
}

/** Clear the list of device info nodes.
 */
static void
fb_hListDevClear     ( FB_LIST *list )
{
    while( list->head != NULL ) {
        fb_hListDevElemFree( list, (DEV_PRINTER_DEVICE*) list->head );
    }
}

/** Find the node containing the requested device.
 */
static DEV_PRINTER_DEVICE*
fb_hListDevFindDevice( FB_LIST *list, const char *pszDevice )
{
    DEV_PRINTER_DEVICE* node = (DEV_PRINTER_DEVICE*) list->head;
    for( ;
         node!=NULL;
         node = (DEV_PRINTER_DEVICE*) node->elem.next )
    {
        if( strcasecmp( pszDevice, node->device )==0 )
            return node;
    }
    return NULL;
}

/** Find the node containing the requested printer name.
 */
static DEV_PRINTER_DEVICE*
fb_hListDevFindName  ( FB_LIST *list, const char *pszPrinterName )
{
    DEV_PRINTER_DEVICE* node = (DEV_PRINTER_DEVICE*) list->head;
    for( ;
         node!=NULL;
         node = (DEV_PRINTER_DEVICE*) node->elem.next )
    {
        if( strcasecmp( pszPrinterName, node->printer_name )==0 )
            return node;
    }
    return NULL;
}

static PRINTER_INFO_5 *GetDefaultPrinters(size_t *pCount)
{
    DWORD dwNeeded = 0, dwReturned = 0;
    PRINTER_INFO_5 *result = NULL;
    DWORD dwFlags = PRINTER_ENUM_DEFAULT;

    DBG_ASSERT(pCount!=NULL);

    *pCount = 0;

    BOOL fResult = EnumPrinters(dwFlags,
                                NULL,
                                5,
                                NULL,
                                0,
                                &dwNeeded,
                                &dwReturned);

    while (!fResult) {
        if (GetLastError()!=ERROR_INSUFFICIENT_BUFFER)
            break;

        result = (PRINTER_INFO_5*) realloc( result, dwNeeded );
        if( result == NULL )
            break;

        fResult = EnumPrinters(dwFlags,
                               NULL,
                               5,
                               (BYTE*) result,
                               dwNeeded,
                               &dwNeeded,
                               &dwReturned);
    }

    *pCount = (size_t) dwReturned;

    return result;
}

static PRINTER_INFO_2 *GetPrinters(size_t *pCount)
{
    DWORD dwNeeded = 0, dwReturned = 0;
    PRINTER_INFO_2 *result = NULL;
    DWORD dwFlags = PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS;

    DBG_ASSERT(pCount!=NULL);

    *pCount = 0;

    BOOL fResult = EnumPrinters(dwFlags,
                                NULL,
                                2,
                                NULL,
                                0,
                                &dwNeeded,
                                &dwReturned);

    while (!fResult) {
        if (GetLastError()!=ERROR_INSUFFICIENT_BUFFER)
            break;

        result = (PRINTER_INFO_2*) realloc( result, dwNeeded );
        if( result == NULL )
            break;

        fResult = EnumPrinters(dwFlags,
                               NULL,
                               2,
                               (BYTE*) result,
                               dwNeeded,
                               &dwNeeded,
                               &dwReturned);
    }

    *pCount = (size_t) dwReturned;

    return result;
}

static char *GetDefaultPrinterName(void)
{
    char *result = NULL;
    size_t count;
    PRINTER_INFO_5 *printers = GetDefaultPrinters(&count);
    if( count==0 ) {
        HMODULE hMod = LoadLibrary(TEXT("winspool.drv"));
        if (hMod!=NULL) {
#ifdef UNICODE
            LPCTSTR pszPrinterId = TEXT("GetDefaultPrinterW");
#else
            LPCTSTR pszPrinterId = TEXT("GetDefaultPrinterA");
#endif
            FnGetDefaultPrinter pfnGetDefaultPrinter =
                (FnGetDefaultPrinter) GetProcAddress(hMod, pszPrinterId);
            if (pfnGetDefaultPrinter!=NULL) {
                TCHAR *buffer = NULL;
                DWORD dwSize = 0;
                BOOL fResult = pfnGetDefaultPrinter(NULL, &dwSize);
                while (!fResult) {
                    if (GetLastError()!=ERROR_INSUFFICIENT_BUFFER)
                        break;
                    buffer = (TCHAR*) realloc(buffer, dwSize * sizeof(TCHAR));
                    fResult = pfnGetDefaultPrinter(buffer, &dwSize);
                }
                if (dwSize>1) {
                    result = buffer;
                }

            }
            FreeLibrary(hMod);
        }
    } else {
        result = strdup(printers->pPrinterName);
    }
    free(printers);
    return result;
}

static void
fb_hPrinterBuildListLocal( FB_LIST *list )
{
    size_t i, count;
    PRINTER_INFO_2 *printers = GetPrinters(&count);
    for( i=0; i!=count; ++i ) {
        PRINTER_INFO_2 *printer = printers + i;
        if( printer->pServerName==NULL ) {
            /* get the port from local printers only */
            LPTSTR pPortName = printer->pPortName;
            LPTSTR pFoundPos = strchr(pPortName, ',');
            while (pFoundPos) {
                DEV_PRINTER_DEVICE* node;
                *pFoundPos = 0;

                /* We only add printers to the list that are attached to
                 * an LPTx: port */
                if( strncasecmp( pPortName, "LPT", 3 )==0 ) {
                    node = fb_hListDevFindDevice( list, pPortName );
                    if( node==NULL ) {
                        fb_hListDevElemAlloc ( list, pPortName, printer->pPrinterName );
                    }
                }

                pPortName = pFoundPos + 1;
                while( isspace( *pPortName ) )
                    ++pPortName;
                pFoundPos = strchr(pPortName, ',');
            }
            if( strncasecmp( pPortName, "LPT", 3 )==0 ) {
                DEV_PRINTER_DEVICE* node = fb_hListDevFindDevice( list, pPortName );
                if( node==NULL ) {
                    fb_hListDevElemAlloc ( list, pPortName, printer->pPrinterName );
                }
            }
        }
    }
    free(printers);
}

static int
fb_hPrinterBuildListDefault( FB_LIST *list, int iStartPort )
{
    char Buffer[32];
    size_t iPort = iStartPort - 1;
    char *printer_name = GetDefaultPrinterName( );

    if( printer_name!=NULL ) {
        if( fb_hListDevFindName( list, printer_name )==NULL ) {
            DEV_PRINTER_DEVICE* node;

            do {
                ++iPort;
                sprintf( Buffer, "LPT%d:", iPort );
                node = fb_hListDevFindDevice( list, Buffer );
            } while( node!=NULL );

            fb_hListDevElemAlloc ( list, Buffer, printer_name );
        }
        free( printer_name );
    }

    return iPort + 1;
}

static int
fb_hPrinterBuildListOther( FB_LIST *list, int iStartPort )
{
    char Buffer[32];
    size_t i, count, iPort = iStartPort - 1;
    PRINTER_INFO_2 *printers = GetPrinters(&count);

    for( i=0; i!=count; ++i ) {
        PRINTER_INFO_2 *printer = printers + i;
        if( fb_hListDevFindName( list, printer->pPrinterName )==NULL ) {
            DEV_PRINTER_DEVICE* node;
            do {
                ++iPort;
                sprintf( Buffer, "LPT%d:", iPort );
                node = fb_hListDevFindDevice( list, Buffer );
            } while( node!=NULL );

            fb_hListDevElemAlloc ( list, Buffer, printer->pPrinterName );
        }
    }
    free(printers);

    return iPort + 1;
}

static void
fb_hPrinterBuildList( FB_LIST *list )
{
    fb_hPrinterBuildListLocal( list );

    /* The default printer should be mapped to LPT1: if no other local printer
     * is mapped to LPT1: */
    fb_hPrinterBuildListDefault( list, 1 );

    /* Other printers that aren't local or attached to an LPTx: port
     * are mapped to LPT128: and above. */
    fb_hPrinterBuildListOther( list, 128 );
}

int fb_PrinterOpen( int iPort, const char *pszDeviceRaw, void **ppvHandle )
{
    int result = fb_ErrorSetNum( FB_RTERROR_OK );
    size_t uiDeviceNameLengthRaw = strlen( pszDeviceRaw );
    size_t uiDeviceNameLength = ((uiDeviceNameLengthRaw < 20) ? 20 : uiDeviceNameLengthRaw);
    const DEV_PRINTER_EMU_MODE *pFoundEmu = NULL;
    DWORD dwJob = 0;
    BOOL fResult;
    HANDLE hPrinter = NULL;
    char *printer_name = NULL;
    char *pszTempBuffer = alloca( (uiDeviceNameLength+1) * 3 + 2 );
    char *pszEmulation = pszTempBuffer + uiDeviceNameLength + 2;
    char *pszDocName = pszTempBuffer + (uiDeviceNameLength+1) * 2 + 1;
    const char *pszDevice = NULL;
    HDC hDc = NULL;

    *pszEmulation = 0;

    /* Parse all options passed after the LPT: or LPT:PrinterName */
    {
        const char *pszDevInfo, *pszDevInfoStart, *pszDevNameStart;

        if( iPort!=0 ) {
            pszDevNameStart = pszDeviceRaw;
            pszDevInfoStart = strchr(pszDeviceRaw, ':');
            if( pszDevInfoStart==NULL )
                return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            ++pszDevInfoStart;
        } else {
            pszDevNameStart = strchr(pszDeviceRaw, ':') + 1;
            pszDevInfoStart = strchr(pszDeviceRaw, ',');
            if( pszDevInfoStart!=NULL )
                ++pszDevInfoStart;
        }

        pszDevInfo = pszDevInfoStart;
        if( pszDevInfo!=NULL )
            while( isspace( *pszDevInfo ) )
                ++pszDevInfo;

        while( pszDevInfo!=NULL ) {
            const char *pszInfoEnd = strchr( pszDevInfo, ',' );
            const char *pszInfoValue = strchr( pszDevInfo, '=' );
            const char *pszInfoKeyEnd;
            char *pszTempKey, *pszTempValue;
            size_t uiTempKeyLen, uiTempValueLen;

            /* Sanitize the found positions */
            if( pszInfoEnd==NULL )
                pszInfoEnd = pszDevInfo + strlen( pszDevInfo );
            if( pszInfoValue!=NULL && pszInfoValue>pszInfoEnd )
                pszInfoValue = NULL;

            /* Sanitize all remaining variables required for splitting into
             * KEY and VALUE. */
            if( pszInfoValue!=NULL ) {
                pszInfoKeyEnd = pszInfoValue;
                ++pszInfoValue;
                uiTempValueLen = pszInfoEnd - pszInfoValue;
            } else {
                pszInfoKeyEnd = pszInfoEnd;
                uiTempValueLen = 0;
            }
            uiTempKeyLen = pszInfoKeyEnd - pszDevInfo;

            /* Strip all those annoying white spaces from key and value */
            while( uiTempKeyLen!=0 && isspace( pszDevInfo[uiTempKeyLen-1] ) )
                --uiTempKeyLen;
            while( uiTempValueLen!=0 && isspace( *pszInfoValue ) ) {
                --uiTempValueLen;
                ++pszInfoValue;
            }
            while( uiTempValueLen!=0 && isspace( pszInfoValue[uiTempValueLen-1] ) )
                --uiTempValueLen;

            /* Copy KEY and VALUE into temporary buffer */
            pszTempKey = pszTempBuffer;
            pszTempValue = pszTempBuffer + uiTempKeyLen + 1;
            memcpy( pszTempKey, pszDevInfo, uiTempKeyLen );
            memcpy( pszTempValue, pszInfoValue, uiTempValueLen );
            pszTempKey[uiTempKeyLen] = 0;
            pszTempValue[uiTempValueLen] = 0;

            /* Process option */
            if( uiTempKeyLen!=0 || uiTempValueLen!=0 ) {
                if( strcasecmp( pszTempKey, "EMU" )==0 ) {
                    if( uiTempValueLen==0 ) {
                        strcpy( pszEmulation, "TTY" );
                    } else {
                        memcpy( pszEmulation, pszTempValue, uiTempValueLen + 1 );
                    }
                } else if( strcasecmp( pszTempKey, "TITLE" )==0 ) {
                    memcpy( pszDocName, pszTempValue, uiTempValueLen + 1 );
                } else {
                    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            }

            pszDevInfo = (( *pszInfoEnd==0 ) ? NULL : (pszInfoEnd+1) );
            if( pszDevInfo!=NULL )
                while( isspace( *pszDevInfo ) )
                    ++pszDevInfo;
        }

        /* Make a copy of the device name without all those options */
        uiDeviceNameLength =
            (pszDevInfoStart - pszDeviceRaw) - ((iPort!=0) ? 0 : 1);
        pszDevice = pszTempBuffer;
        memcpy( pszTempBuffer, pszDeviceRaw, uiDeviceNameLength );
        pszTempBuffer[uiDeviceNameLength] = 0;
    }

    /* Allow only valid emulation modes */
    if( *pszEmulation!=0 ) {
        size_t i;
        for( i=0;
             i!=sizeof(aEmulationModes)/sizeof(aEmulationModes[0]);
             ++i )
        {
            const DEV_PRINTER_EMU_MODE *pEmu = aEmulationModes + i;
            if( strcasecmp( pszEmulation, pEmu->pszId )==0 ) {
                pFoundEmu = pEmu;
                break;
            }
        }
        if( !pFoundEmu )
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    } else {
        pszEmulation = NULL;
    }

    if( iPort==0 ) {
        /* LPT:PrinterName */
        char *pFoundPos = strchr(pszDevice, ':');
        if( pFoundPos!=NULL ) {
            ++pFoundPos;
            if( *pFoundPos!=0 )
                printer_name = strdup( pFoundPos );
        }
    } else {
        /* LPTx: */
        FB_LIST dev_printer_devs;
        DEV_PRINTER_DEVICE* node;

        fb_hListDevInit( &dev_printer_devs );
        fb_hPrinterBuildList( &dev_printer_devs );

        /* Find printer attached to specified device */
        node = fb_hListDevFindDevice( &dev_printer_devs, pszDevice );
        if( node!=NULL ) {
            printer_name = strdup( node->printer_name );
        }

        fb_hListDevClear( &dev_printer_devs );
    }

    if( printer_name == NULL ) {
        result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    } else {
        if( pszEmulation!=NULL ) {
            /* When EMULATION is used, we have to use the DC instead of
             * the PRINTER directly */
            hDc = CreateDCA( "WINSPOOL",
                             printer_name,
                             NULL,
                             NULL );
            fResult = hDc!=NULL;
        } else {
            /* User PRINTER directly */
            fResult = OpenPrinter(printer_name, &hPrinter, NULL);
        }
        if( !fResult ) {
            result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
    }

    if( *pszDocName==0 ) {
        strcpy( pszDocName, "FreeBASIC document" );
    }

    if( result==FB_RTERROR_OK ) {
        if( pszEmulation!=NULL ) {
            int iJob;
            DOCINFO docInfo;
            memset( &docInfo, 0, sizeof(DOCINFO) );
            docInfo.cbSize = sizeof(DOCINFO);
            docInfo.lpszDocName = pszDocName;
            iJob = StartDoc( hDc, &docInfo );
            if( iJob <= 0 ) {
                result = fb_ErrorSetNum( FB_RTERROR_FILEIO );
            } else {
                dwJob = (DWORD) iJob;
            }
        } else {
            DOC_INFO_1 DocInfo;
            DocInfo.pDocName = pszDocName;
            DocInfo.pOutputFile = NULL;
            DocInfo.pDatatype = TEXT("RAW");

            dwJob = StartDocPrinter( hPrinter, 1, (BYTE*) &DocInfo );
            if( dwJob==0 ) {
                result = fb_ErrorSetNum( FB_RTERROR_FILEIO );
            }
        }
    }

    if( result==FB_RTERROR_OK ) {
        W32_PRINTER_INFO *pInfo = calloc( 1, sizeof(W32_PRINTER_INFO) );
        if( pInfo==NULL ) {
            result = fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
        } else {
            *ppvHandle = pInfo;
            pInfo->hPrinter = hPrinter;
            pInfo->dwJob = dwJob;
            pInfo->hDc = hDc;
            if( hDc!=NULL ) {
                LOGFONT lf;

                pInfo->Emu.dwFullSizeX = GetDeviceCaps( hDc, PHYSICALWIDTH );
                pInfo->Emu.dwFullSizeY = GetDeviceCaps( hDc, PHYSICALHEIGHT );
                pInfo->Emu.dwSizeX = GetDeviceCaps( hDc, HORZRES );
                pInfo->Emu.dwSizeY = GetDeviceCaps( hDc, VERTRES );
                pInfo->Emu.dwOffsetX = GetDeviceCaps( hDc, PHYSICALOFFSETX );
                pInfo->Emu.dwOffsetY = GetDeviceCaps( hDc, PHYSICALOFFSETY );
                pInfo->Emu.dwDPI_X = GetDeviceCaps( hDc, LOGPIXELSX );
                pInfo->Emu.dwDPI_Y = GetDeviceCaps( hDc, LOGPIXELSY );
#if 0
                pInfo->Emu.dwCurrentX = pInfo->Emu.dwOffsetX;
                pInfo->Emu.dwCurrentY = pInfo->Emu.dwOffsetY;
#else
                pInfo->Emu.dwCurrentX = 0;
                pInfo->Emu.dwCurrentY = 0;
#endif
                pInfo->Emu.clFore = RGB(0,0,0);
                pInfo->Emu.clBack = RGB(255,255,255);

                /* Start in 12 CPI monospace mode */
                EmuBuild_LOGFONT( &lf, pInfo, 12 );

                /* Should never fail - except when some default fonts were
                 * removed by hand (which is very unlikely) */
                pInfo->Emu.hFont = CreateFontIndirect( &lf );
                assert( pInfo->Emu.hFont!=NULL );

                /* Register PRINT function */
                pInfo->Emu.pfnPrint = pFoundEmu->pfnPrint;

                /* Should not be necessary because this is the default */
                SetTextAlign( hDc, TA_TOP | TA_LEFT | TA_NOUPDATECP );

                EmuUpdateInfo( pInfo );
            }
        }
    }

    if( result!=FB_RTERROR_OK ) {
        if( dwJob!=0 ) {
            if( pszEmulation!=NULL ) {
                EndDoc( hDc );
            } else {
                EndDocPrinter( hPrinter );
            }
        }
        if( hPrinter!=NULL ) {
            ClosePrinter( hPrinter );
        }
        if( hDc!=NULL ) {
            DeleteDC( hDc );
        }
    }

    if( printer_name!=NULL )
        free( printer_name );

    return result;
}

static
void EmuBuild_LOGFONT( LOGFONT *lf,
                       W32_PRINTER_INFO *pInfo,
                       unsigned uiCPI )
{
    memset( lf, 0, sizeof( LOGFONT ) );
    lf->lfHeight = pInfo->Emu.dwDPI_Y*10/72;         /* default height */
    lf->lfWeight = FW_NORMAL;
    lf->lfCharSet = OEM_CHARSET;
    lf->lfOutPrecision = OUT_DEFAULT_PRECIS;
    lf->lfClipPrecision = CLIP_DEFAULT_PRECIS;
    lf->lfQuality = DRAFT_QUALITY;
    if( uiCPI!=0 ) {
        lf->lfWidth = pInfo->Emu.dwDPI_X/uiCPI;
        lf->lfPitchAndFamily = FIXED_PITCH | FF_MODERN;
        strcpy( lf->lfFaceName, "System" );
    } else {
        lf->lfWidth = 0;
        lf->lfPitchAndFamily = VARIABLE_PITCH | FF_SWISS;
        strcpy( lf->lfFaceName, "MS Sans Serif" );
    }
}

static void EmuUpdateInfo( W32_PRINTER_INFO *pInfo )
{
    TEXTMETRIC tm;

    SelectObject( pInfo->hDc, pInfo->Emu.hFont );

    GetTextMetrics( pInfo->hDc, &tm );
    pInfo->Emu.dwFontSizeX = tm.tmMaxCharWidth;
    pInfo->Emu.dwFontSizeY = tm.tmHeight;
}

static void EmuPageStart( W32_PRINTER_INFO *pInfo )
{
    if( pInfo->Emu.iPageStarted )
        return;

    StartPage( pInfo->hDc );
    pInfo->Emu.iPageStarted = TRUE;

    EmuUpdateInfo( pInfo );

    SetTextColor( pInfo->hDc, pInfo->Emu.clFore );
    SetBkColor( pInfo->hDc, pInfo->Emu.clBack );
}

static void EmuPrint_RAW( W32_PRINTER_INFO *pInfo,
                          const char *pachText,
                          size_t uiLength )
{
    while( uiLength-- ) {
        char ch = *pachText++;

        EmuPageStart( pInfo );

        TextOut( pInfo->hDc,
                 pInfo->Emu.dwCurrentX, pInfo->Emu.dwCurrentY,
                 &ch, 1 );

        pInfo->Emu.dwCurrentX += pInfo->Emu.dwFontSizeX;

        if( pInfo->Emu.dwCurrentX>=pInfo->Emu.dwSizeX ) {
            pInfo->Emu.dwCurrentX = 0;
            pInfo->Emu.dwCurrentY += pInfo->Emu.dwFontSizeY;
            if( pInfo->Emu.dwCurrentY>=pInfo->Emu.dwSizeY ) {
                pInfo->Emu.dwCurrentY = 0;
                EndPage( pInfo->hDc );
                pInfo->Emu.iPageStarted = FALSE;
            }
        }
    }
}

static
void fb_hHookConPrinterScroll(struct _fb_ConHooks *handle,
                              int x1,
                              int y1,
                              int x2,
                              int y2,
                              int rows)
{
    W32_PRINTER_INFO *pInfo = handle->Opaque;
    size_t page_rows = (pInfo->Emu.dwSizeY + pInfo->Emu.dwFontSizeY - 1)
        / pInfo->Emu.dwFontSizeY;
    if( !pInfo->Emu.iPageStarted ) {
        StartPage( pInfo->hDc );
    }
    EndPage( pInfo->hDc );
    while( rows >= page_rows ) {
        StartPage( pInfo->hDc );
        EndPage( pInfo->hDc );
        rows -= page_rows;
    }
    pInfo->Emu.iPageStarted = FALSE;
    handle->Coord.Y = 0;
}

static
int  fb_hHookConPrinterWrite (struct _fb_ConHooks *handle,
                              const void *buffer,
                              size_t length )
{
    W32_PRINTER_INFO *pInfo = handle->Opaque;
    pInfo->Emu.dwCurrentX = handle->Coord.X * pInfo->Emu.dwFontSizeX;
    pInfo->Emu.dwCurrentY = handle->Coord.Y * pInfo->Emu.dwFontSizeY;
    EmuPrint_RAW( pInfo, buffer, length );
    return TRUE;
}

static void EmuPrint_TTY( W32_PRINTER_INFO *pInfo,
                          const char *pachText,
                          size_t uiLength )
{
    fb_ConHooks hooks;

    hooks.Opaque        = pInfo;
    hooks.Scroll        = fb_hHookConPrinterScroll;
    hooks.Write         = fb_hHookConPrinterWrite ;
    hooks.Border.Left   = 0;
    hooks.Border.Top    = 0;
    hooks.Border.Right  =
        ( pInfo->Emu.dwSizeX - pInfo->Emu.dwFontSizeX + 1 ) / pInfo->Emu.dwFontSizeX;
    hooks.Border.Bottom = 
        ( pInfo->Emu.dwSizeY - pInfo->Emu.dwFontSizeX + 1 ) / pInfo->Emu.dwFontSizeY;

    hooks.Coord.X = pInfo->Emu.dwCurrentX / pInfo->Emu.dwFontSizeX;
    hooks.Coord.Y = pInfo->Emu.dwCurrentY / pInfo->Emu.dwFontSizeY;

    fb_ConPrintTTY( &hooks,
                    pachText,
                    uiLength,
                    TRUE );

    if( hooks.Coord.X != hooks.Border.Left
        || hooks.Coord.Y != (hooks.Border.Bottom+1) )
    {
        fb_hConCheckScroll( &hooks );
    }

    pInfo->Emu.dwCurrentX = hooks.Coord.X * pInfo->Emu.dwFontSizeX;
    pInfo->Emu.dwCurrentY = hooks.Coord.Y * pInfo->Emu.dwFontSizeY;
}

#if 0
static void EmuPrint_ESC_P2( W32_PRINTER_INFO *pInfo,
                             const char *pachText,
                             size_t uiLength )
{
}
#endif

int fb_PrinterWrite( void *pvHandle, const void *data, size_t length )
{
    W32_PRINTER_INFO *pInfo = (W32_PRINTER_INFO*) pvHandle;
    DWORD dwWritten;

    if( !pInfo->hPrinter ) {
        pInfo->Emu.pfnPrint( pInfo, data, length );

    } else if( !WritePrinter( pInfo->hPrinter,
                              (LPVOID) data,
                       length,
                       &dwWritten ) )
    {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );

    } else if ( dwWritten != length ) {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );

    }

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_PrinterWriteWstr( void *pvHandle, const FB_WCHAR *data, size_t length )
{
    W32_PRINTER_INFO *pInfo = (W32_PRINTER_INFO*) pvHandle;
    DWORD dwWritten;

    if( !WritePrinter( pInfo->hPrinter,
                       (LPVOID) data,
                       length * sizeof( FB_WCHAR ),
                       &dwWritten ) )
    {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );

    } else if ( dwWritten != length ) {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );

    }

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_PrinterClose( void *pvHandle )
{
    W32_PRINTER_INFO *pInfo = (W32_PRINTER_INFO*) pvHandle;

    if( pInfo->hDc!=NULL ) {
        if( pInfo->Emu.iPageStarted )
            EndPage( pInfo->hDc );
        EndDoc( pInfo->hDc );
        DeleteDC( pInfo->hDc );
    } else {
        EndDocPrinter( pInfo->hPrinter );
        ClosePrinter( pInfo->hPrinter );
    }

    free(pInfo);
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
