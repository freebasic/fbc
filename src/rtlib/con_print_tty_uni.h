/* print text data - using TTY (teletype) interpretation */

#ifndef OUTPUT_BUFFER_SIZE
#define OUTPUT_BUFFER_SIZE 1024
#endif

void FB_CONPRINTTTY
	(
		fb_ConHooks *handle,
        const FB_TCHAR *pachText,
        size_t TextLength,
        int is_text_mode
	)
{
    static const FB_TCHAR achTabSpaces[8] = { 32, 32, 32, 32, 32, 32, 32, 32 };
    FB_TCHAR OutputBuffer[OUTPUT_BUFFER_SIZE];
    size_t OutputBufferLength = 0, OutputBufferChars = 0;
    fb_Rect *pBorder = &handle->Border;
    fb_Coord *pCoord = &handle->Coord;

    fb_Coord dwCurrentCoord;
    size_t IndexText;
    int fGotNewCoordinate = FALSE;
    int BorderWidth = pBorder->Right - pBorder->Left + 1;

    /* Do nothing (and prevent division by zero below) if width == 0.
       (can happen with tiny gfxlib2 screens at least) */
    if( BorderWidth == 0 ) {
        return;
    }

    memcpy( &dwCurrentCoord, pCoord, sizeof( fb_Coord ) );

    fb_Coord dwMoveCoord = { 0, 0 };
    for( IndexText=0; IndexText!=TextLength; ++IndexText )
    {
        const FB_TCHAR *pachOutputData = pachText;
        size_t OutputDataLength = 0, OutputDataChars = 0;
        int fDoFlush = FALSE;
        int fSetNewCoord = FALSE;
        FB_TCHAR ch = FB_TCHAR_GET( pachOutputData );

        switch ( ch )
        {
        case _TC('\a'):
            /* ALARM */
            fb_Beep();
            break;

        case _TC('\b'):
            /* BACKSPACE */
            fSetNewCoord = TRUE;
            if( dwCurrentCoord.X > pBorder->Left ) {
                dwMoveCoord.X = -1;
            } else {
                dwMoveCoord.X = 0;
            }
            dwMoveCoord.Y = 0;
            break;

        case _TC('\n'):
            /* LINE FEED / NEW LINE */
            fSetNewCoord = TRUE;
            if( is_text_mode ) {
                dwMoveCoord.X = pBorder->Left - dwCurrentCoord.X;
                dwMoveCoord.Y = 1;
            } else {
                dwMoveCoord.X = 0;
                dwMoveCoord.Y = 1;
            }
            break;

        case _TC('\r'):
            /* CARRIAGE RETURN */
            fSetNewCoord = TRUE;
            dwMoveCoord.X = pBorder->Left - dwCurrentCoord.X;
            dwMoveCoord.Y = 0;
            break;

        case _TC('\t'):
            /* TAB */
            pachOutputData = achTabSpaces;
            OutputDataLength =
                OutputDataChars =
                	((dwCurrentCoord.X - pBorder->Left + 8) & ~7) -
                	(dwCurrentCoord.X - pBorder->Left);
            break;

        default:
            OutputDataLength = FB_TCHAR_GET_CHAR_SIZE( pachOutputData );
            OutputDataChars = 1;
            break;
        }

        if( OutputDataLength + OutputBufferLength > OUTPUT_BUFFER_SIZE ) {
            fDoFlush = TRUE;
        } else if( fSetNewCoord ) {
            fDoFlush = TRUE;
        }

        if( fDoFlush ) {
            fDoFlush = FALSE;
            if( OutputBufferLength!=0 ) {
                FB_CONPRINTRAW( handle,
                                OutputBuffer,
                                OutputBufferChars );
                OutputBufferLength = OutputBufferChars = 0;
                fGotNewCoordinate = FALSE;
            }
        }

        if( fSetNewCoord ) {
            fSetNewCoord = FALSE;
            pCoord->X += dwMoveCoord.X;
            pCoord->Y += dwMoveCoord.Y;
            memcpy( &dwCurrentCoord, pCoord, sizeof( fb_Coord ) );
            fGotNewCoordinate = TRUE;
        }

        if( OutputDataLength!=0 ) {
            dwCurrentCoord.X += OutputDataChars;
            if( dwCurrentCoord.X > pBorder->Right ) {
                int NormalX = dwCurrentCoord.X - pBorder->Left;
                dwCurrentCoord.X = (NormalX % BorderWidth) + pBorder->Left;
                dwCurrentCoord.Y += NormalX / BorderWidth;
            }
            while( OutputDataLength-- ) {
                OutputBuffer[OutputBufferLength++] = *pachOutputData++;
            }
            OutputBufferChars += OutputDataChars;
        }

        FB_TCHAR_ADVANCE( pachText, 1 );
    }

    if( OutputBufferLength!=0 )
    {
        FB_CONPRINTRAW( handle, OutputBuffer, OutputBufferChars );
    }
    else if( fGotNewCoordinate )
    {
        fb_hConCheckScroll( handle );
    }
}
