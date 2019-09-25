/* COMx device */

#include "fb.h"
#include "dev_com_private.h"

static int fb_DevComClose( FB_FILE *handle )
{
    int res;
    DEV_COM_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_COM_INFO*) handle->opaque;
    res = fb_SerialClose( handle, pInfo->hSerial );
    if( res==FB_RTERROR_OK ) {
        free(pInfo->pszDevice);
        free(pInfo);
    }

    FB_UNLOCK();

	return res;
}

static int fb_DevComWrite( FB_FILE *handle, const void* value, size_t valuelen )
{
    int res;
    DEV_COM_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_COM_INFO*) handle->opaque;
    res = fb_SerialWrite( handle, pInfo->hSerial, value, valuelen );

    FB_UNLOCK();

	return res;
}

static int fb_DevComWriteWstr( FB_FILE *handle, const FB_WCHAR* value, size_t valuelen )
{
	return fb_DevComWrite( handle, (void*)value, valuelen * sizeof( FB_WCHAR ) );
}

static int fb_DevComRead( FB_FILE *handle, void* value, size_t *pValuelen )
{
    int res;
    DEV_COM_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_COM_INFO*) handle->opaque;
    res = fb_SerialRead( handle, pInfo->hSerial, value, pValuelen );

    FB_UNLOCK();

	return res;
}

static int fb_DevComReadWstr( FB_FILE *handle, FB_WCHAR *value, size_t *pValuelen )
{
	size_t len = *pValuelen * sizeof( FB_WCHAR );
	return fb_DevComRead( handle, (void *)value, &len );
}

static int fb_DevComTell( FB_FILE *handle, fb_off_t *pOffset )
{
    int res;
    DEV_COM_INFO *pInfo;

    DBG_ASSERT( pOffset!=NULL );

    FB_LOCK();

    pInfo = (DEV_COM_INFO*) handle->opaque;
    res = fb_SerialGetRemaining( handle, pInfo->hSerial, pOffset );

    FB_UNLOCK();

	return res;
}

static int fb_DevComEof( FB_FILE *handle )
{
    int res;
    fb_off_t offset;
    DEV_COM_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_COM_INFO*) handle->opaque;
    res = fb_SerialGetRemaining( handle, pInfo->hSerial, &offset );
    if( res!=FB_RTERROR_OK ) {
        res = FB_TRUE;
    } else {
        res = offset==0;
    }

    FB_UNLOCK();

	return res;
}

static FB_FILE_HOOKS hooks_dev_com = {
    fb_DevComEof,
    fb_DevComClose,
    NULL,
    fb_DevComTell,
    fb_DevComRead,
    fb_DevComReadWstr,
    fb_DevComWrite,
    fb_DevComWriteWstr,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
};

int fb_DevComOpen( FB_FILE *handle, const char *filename, size_t filename_len )
{
    DEV_COM_INFO *info;
    char achDev[128];
    const char *pchPos;
    char *pchPosTmp;
    size_t i, port, uiOption;
    int iStopBits = -1;
    int res = FB_RTERROR_OK;

    if (!fb_DevComTestProtocolEx( handle, filename, filename_len, &port ))
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    if( port > 0 )
    {
    	i = sprintf( achDev, "COM%u:", (int)port );
    }
    else
    {
    	i = (strchr( filename, ':' ) - filename);
    	strncpy( achDev, filename, i );
    }
    achDev[i] = 0;

    FB_LOCK();

    if( handle->mode==FB_FILE_MODE_RANDOM ) {
        handle->mode = FB_FILE_MODE_BINARY;
        handle->access = FB_FILE_ACCESS_READWRITE;
    }

    /* Determine the port number and a normalized device name */
    info = (DEV_COM_INFO*) calloc(1, sizeof(DEV_COM_INFO));
    info->iPort = port;
    info->pszDevice = strdup( achDev );

    /* Set defaults */
    info->Options.uiSpeed = 300;
    info->Options.Parity = FB_SERIAL_PARITY_EVEN;
    info->Options.uiDataBits = 7;
    info->Options.DurationCTS = 1000;
    info->Options.DurationDSR = 1000;

    pchPos = strchr( filename, ':' );
    DBG_ASSERT( pchPos!=NULL );
    ++pchPos;

    /* Process all passed options */
    uiOption = 0;
    while( res==FB_RTERROR_OK && *pchPos!=0 ) {
        size_t uiOptionLength;
        const char *pchPosEnd, *pchPosNext;
        char *pszOption;

        /* skip white spaces */
        while( *pchPos==' ' || *pchPos=='\t' )
            ++pchPos;

        if( *pchPos==0 )
            break;

        if( *pchPos==',' ) {
            /* empty option ... ignore */
			++uiOption;
            ++pchPos;
            continue;
        }

        /* Find end of option */
        pchPosNext = strchr( pchPos, ',' );
        if( pchPosNext==NULL ) {
            pchPosNext = filename + filename_len;
            pchPosEnd = pchPosNext - 1;
        } else {
            pchPosEnd = pchPosNext - 1;
            ++pchPosNext;
        }

        /* skip white spaces */
        while( *pchPosEnd==' ' || *pchPosEnd=='\t' )
            --pchPosEnd;
        ++pchPosEnd;

        /* copy option to temporary buffer */
        uiOptionLength = pchPosEnd - pchPos;
        pszOption = malloc( uiOptionLength + 1 );
        memcpy( pszOption, pchPos, uiOptionLength );
        pszOption[uiOptionLength] = 0;

        /* process option */
        switch ( uiOption ) {
        case 0:
            /* baud rate */
            info->Options.uiSpeed = strtoul( pszOption, &pchPosTmp, 10 );
            if( *pchPosTmp!=0 ) {
                res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            }
            break;

        case 1:
            /* parity */
            if( strcasecmp( pszOption, "N" )==0 ) {
                info->Options.Parity = FB_SERIAL_PARITY_NONE;
            } else if( strcasecmp( pszOption, "E" )==0 ) {
                info->Options.Parity = FB_SERIAL_PARITY_EVEN;
            } else if( strcasecmp( pszOption, "PE" )==0 ) {
                /* QB quirk */
                info->Options.CheckParity = TRUE;
                info->Options.Parity = FB_SERIAL_PARITY_EVEN;
            } else if( strcasecmp( pszOption, "O" )==0 ) {
                info->Options.Parity = FB_SERIAL_PARITY_ODD;
            } else if( strcasecmp( pszOption, "S" )==0 ) {
                info->Options.Parity = FB_SERIAL_PARITY_SPACE;
            } else if( strcasecmp( pszOption, "M" )==0 ) {
                info->Options.Parity = FB_SERIAL_PARITY_MARK;
            } else {
                res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            }
            break;

        case 2:
            /* data bits */
            info->Options.uiDataBits = strtoul( pszOption, &pchPosTmp, 10 );
            if( *pchPosTmp!=0 ) {
                res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            }
            break;

        case 3:
            /* stop bits */
            {
                double dblStopBits = strtod( pszOption, &pchPosTmp );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                } else {
                    if( dblStopBits==1.0 ) {
                        iStopBits = FB_SERIAL_STOP_BITS_1;
                    } else if( dblStopBits==1.5 ) {
                        iStopBits = FB_SERIAL_STOP_BITS_1_5;
                    } else if( dblStopBits==2.0 ) {
                        iStopBits = FB_SERIAL_STOP_BITS_2;
                    } else {
                        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                    }
                }
            }
            break;

        default:
            /* extended options */
            if( strncasecmp( pszOption, "CS", 2 )==0 ) {
                info->Options.DurationCTS = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else if( strncasecmp( pszOption, "DS", 2 )==0 ) {
                info->Options.DurationDSR = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else if( strncasecmp( pszOption, "CD", 2 )==0 ) {
                info->Options.DurationCD = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else if( strncasecmp( pszOption, "OP", 2 )==0 ) {
                info->Options.OpenTimeout = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else if( strncasecmp( pszOption, "TB", 2 )==0 ) {
                info->Options.TransmitBuffer = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else if( strncasecmp( pszOption, "RB", 2 )==0 ) {
                info->Options.ReceiveBuffer = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else if( strcasecmp( pszOption, "RS" )==0 ) {
                info->Options.SuppressRTS = TRUE;
            } else if( strcasecmp( pszOption, "LF" )==0 ) {
                /* PB compatible */
                info->Options.AddLF = TRUE;
            } else if( strcasecmp( pszOption, "ASC" )==0 ) {
                info->Options.AddLF = TRUE;
            } else if( strcasecmp( pszOption, "BIN" )==0 ) {
                info->Options.AddLF = FALSE;
            } else if( strcasecmp( pszOption, "PE" )==0 ) {
                info->Options.CheckParity = TRUE;
            } else if( strcasecmp( pszOption, "DT" )==0 ) {
                info->Options.KeepDTREnabled = TRUE;
            } else if( strcasecmp( pszOption, "FE" )==0 ) {
                info->Options.DiscardOnError = TRUE;
            } else if( strcasecmp( pszOption, "ME" )==0 ) {
                info->Options.IgnoreAllErrors = TRUE;
            } else if( strncasecmp( pszOption, "IR", 2 )==0 ) {
                info->Options.IRQNumber = strtoul( pszOption+2, &pchPosTmp, 10 );
                if( *pchPosTmp!=0 ) {
                    res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
                }
            } else {
                res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            }
            break;
        }

        pchPos = pchPosNext;
        free(pszOption);
        ++uiOption;
    }

    /* QB quirk */
    if( iStopBits==-1 ) {
        if( info->Options.uiSpeed <= 110 ) {
            if( info->Options.uiDataBits==5 ) {
                iStopBits = FB_SERIAL_STOP_BITS_1_5;
            } else {
                iStopBits = FB_SERIAL_STOP_BITS_2;
            }
        } else {
            iStopBits = FB_SERIAL_STOP_BITS_1;
        }
    }
    info->Options.StopBits = (FB_SERIAL_STOP_BITS) iStopBits;

    if( res==FB_RTERROR_OK ) {
        handle->width = 0;
        res = fb_SerialOpen( handle, info->iPort, &info->Options, info->pszDevice, &info->hSerial );
    }

    if( res == FB_RTERROR_OK ) {
        handle->hooks = &hooks_dev_com;
        handle->opaque = info;
				handle->type = FB_FILE_TYPE_SERIAL;
    } else {
        if( info->pszDevice )
            free( info->pszDevice );
        free(info);
    }

    FB_UNLOCK();

	return res;
}

int fb_DevSerialSetWidth( const char *pszDevice, int width, int default_width )
{
    int cur = ((default_width==-1) ? 0 : default_width);
    size_t i, port;
    char achDev[128];

    if( !fb_DevComTestProtocolEx( NULL, pszDevice, strlen(pszDevice), &port ) )
        return 0;

    i = sprintf( achDev, "COM%u:", (int)port );
    achDev[i] = 0;

    /* Test all printers. */
    for( i=0;
         i<FB_MAX_FILES;
         ++i )
    {
        FB_FILE *tmp_handle = __fb_ctx.fileTB + i;
        if( tmp_handle->hooks==&hooks_dev_com
            && tmp_handle->redirection_to==NULL )
        {
            DEV_COM_INFO *tmp_info = (DEV_COM_INFO*) tmp_handle->opaque;
            if( strcmp(tmp_info->pszDevice, achDev)==0 ) {
                if( width!=-1 )
                    tmp_handle->width = width;
                cur = tmp_handle->width;
                break;
            }
        }
    }

    return cur;
}
