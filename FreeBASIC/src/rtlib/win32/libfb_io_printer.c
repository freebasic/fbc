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
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

typedef struct _W32_PRINTER_INFO {
    HANDLE          hPrinter;
    DWORD           dwJob;
} W32_PRINTER_INFO;

typedef BOOL (WINAPI *FnGetDefaultPrinter)(LPTSTR pszBuffer, LPDWORD pcchBuffer);

static PRINTER_INFO_5 *GetDefaultPrinters(size_t *pCount)
{
    DWORD dwNeeded = 0, dwReturned = 0;
    PRINTER_INFO_5 *result = NULL;
    DWORD dwFlags = PRINTER_ENUM_DEFAULT;

    assert(pCount!=NULL);

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

    assert(pCount!=NULL);

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

static char *GetPrinterForDevice( const char *pszDevice )
{
    char *result = NULL;
    size_t i, count;
    PRINTER_INFO_2 *printers = GetPrinters(&count);
    for( i=0; i!=count; ++i ) {
        int found = FALSE;
        PRINTER_INFO_2 *printer = printers + i;
        LPTSTR pPortName = printer->pPortName;
        LPTSTR pFoundPos = strchr(pPortName, ',');
        while (pFoundPos) {
            *pFoundPos = 0;
            if( strcmp( pszDevice, pPortName ) == 0 ) {
                found = TRUE;
                break;
            }
            pPortName = pFoundPos + 1;
            pFoundPos = strchr(pPortName, ',');
        }
        if( !found && pFoundPos==NULL ) {
            if( strcmp( pszDevice, pPortName ) == 0 ) {
                found = TRUE;
            }
        }
        if( found ) {
            result = strdup( printer->pPrinterName );
            break;
        }
    }
    free(printers);
    return result;
}

int fb_PrinterOpen( int iPort, const char *pszDevice, void **ppvHandle )
{
    int result = fb_ErrorSetNum( FB_RTERROR_OK );
    DOC_INFO_1 DocInfo;
    DWORD dwJob = 0;
    BOOL fResult;
    HANDLE hPrinter = NULL;
    /* Find printer attached to specified device */
    char *printer_name = GetPrinterForDevice( pszDevice );
    if( printer_name == NULL ) {
        printer_name = GetDefaultPrinterName( );
        if( iPort!=1 ) {
            /* When we don't want LPT1, we number all printers that aren't
             * the default printer starting at 2.
             */
            int found = FALSE;
            int iCurrentPort = ((printer_name==NULL) ? 0 : 1);
            size_t i, count;
            PRINTER_INFO_2 *printers = GetPrinters(&count);
            for( i=0; i!=count; ++i ) {
                PRINTER_INFO_2 *printer = printers + i;
                if( printer_name==NULL
                    || strcmp( printer->pPrinterName, printer_name ) != 0 )
                {
                    ++iCurrentPort;
                    if( iCurrentPort==iPort ) {
                        found = TRUE;
                        break;
                    }
                }
            }
            if( found ) {
                if( printer_name )
                    free( printer_name );
                /* "i" still points to a valid printer index */
                printer_name = strdup( printers[i].pPrinterName );
            }
            free(printers);
        }
        if( printer_name == NULL )
            result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    }

    if( result==FB_RTERROR_OK ) {
        fResult = OpenPrinter(printer_name, &hPrinter, NULL);
        if( !fResult ) {
            result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
        }
    }

    if( result==FB_RTERROR_OK ) {
        DocInfo.pDocName = TEXT("FreeBASIC document");
        DocInfo.pOutputFile = NULL;
        DocInfo.pDatatype = TEXT("RAW");

        dwJob = StartDocPrinter( hPrinter, 1, (BYTE*) &DocInfo );
        if( dwJob==0 ) {
            result = fb_ErrorSetNum( FB_RTERROR_FILEIO );
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
        }
    }

    if( result!=FB_RTERROR_OK ) {
        if( dwJob!=0 ) {
            EndDocPrinter( hPrinter );
        }
        if( hPrinter!=NULL ) {
            ClosePrinter( hPrinter );
        }
    }

    free( printer_name );

    return result;
}

int fb_PrinterWrite( void *pvHandle, const void *data, size_t length )
{
    W32_PRINTER_INFO *pInfo = (W32_PRINTER_INFO*) pvHandle;
    DWORD dwWritten;

    if( !WritePrinter( pInfo->hPrinter,
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

int fb_PrinterClose( void *pvHandle )
{
    W32_PRINTER_INFO *pInfo = (W32_PRINTER_INFO*) pvHandle;
    EndDocPrinter( pInfo->hPrinter );
    ClosePrinter( pInfo->hPrinter );
    free(pInfo);
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
