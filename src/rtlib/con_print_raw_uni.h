/* print raw data - no interpretation is done */

void FB_CONPRINTRAW
	(
		fb_ConHooks *handle,
        const FB_TCHAR *pachText,
        size_t textLength
	)
{
    fb_Rect *pBorder = &handle->Border;
    fb_Coord *pCoord = &handle->Coord;

    while( textLength!=0 )
    {
        size_t remainingWidth = pBorder->Right - pCoord->X + 1;
        size_t copySize = (textLength > remainingWidth) ? remainingWidth : textLength;

        fb_hConCheckScroll( handle );

        if( handle->FB_CON_HOOK_TWRITE( handle,
                                        (const char *) pachText,
                                        copySize )!=TRUE )
            break;

        textLength -= copySize;
        FB_TCHAR_ADVANCE( pachText, copySize );
        pCoord->X += copySize;

        if( pCoord->X==(pBorder->Right + 1) ) {
            pCoord->X = pBorder->Left;
            pCoord->Y += 1;
        }
    }
}
