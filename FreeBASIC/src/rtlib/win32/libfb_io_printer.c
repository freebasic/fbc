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
#include <ctype.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"
#include "fb_rterr.h"

typedef struct _DEV_PRINTER_DEVICE {
    FB_LISTELEM     elem;
    char           *device;
    char           *printer_name;
} DEV_PRINTER_DEVICE;

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

int fb_PrinterOpen( int iPort, const char *pszDevice, void **ppvHandle )
{
    int result = fb_ErrorSetNum( FB_RTERROR_OK );
    DOC_INFO_1 DocInfo;
    DWORD dwJob = 0;
    BOOL fResult;
    HANDLE hPrinter = NULL;
    char *printer_name = NULL;

    if( iPort==0 ) {
        char *pFoundPos = strchr(pszDevice, ':');
        if( pFoundPos!=NULL ) {
            ++pFoundPos;
#if 0
            while( isspace( *pFoundPos ) )
                ++pFoundPos;
#endif
            if( *pFoundPos!=0 )
                printer_name = strdup( pFoundPos );
        }
    } else {
        FB_LIST dev_printer_devs;
        DEV_PRINTER_DEVICE* node;

        fb_hListDevInit( &dev_printer_devs );
        fb_hPrinterBuildList( &dev_printer_devs );

        /* Find printer attached to specified device */
        node = fb_hListDevFindDevice( &dev_printer_devs, pszDevice );
        if( node!=NULL ) {
            printer_name = node->printer_name;
        }

        fb_hListDevClear( &dev_printer_devs );
    }

    if( printer_name == NULL ) {
        result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    } else {
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

    if( printer_name!=NULL )
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
    EndDocPrinter( pInfo->hPrinter );
    ClosePrinter( pInfo->hPrinter );
    free(pInfo);
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
