/* parse a string containing a date and/or time */

#include "fb.h"
#include <ctype.h>

/*:::::*/
FBCALL int fb_DateTimeParse( FBSTRING *s,
                             int *pDay, int *pMonth, int *pYear,
                             int *pHour, int *pMinute, int *pSecond,
                             int want_date, int want_time)
{
	
    const char *text;
    int result = FALSE;
    size_t length, text_len;

    text = s->data;
    text_len = FB_STRSIZE( s );

	if( text == NULL ) {
		return result;
	}

    if( fb_hDateParse( text, text_len, pDay, pMonth, pYear, &length ) ) {
        text += length;
        text_len -= length;

        /* skip WS */
        while( isspace( *text ) )
            ++text, --text_len;
        /* skip optional comma */
        if( *text==',' )
            ++text, --text_len;

        if( fb_hTimeParse( text, text_len, pHour, pMinute, pSecond, &length ) ) {
            text += length;
            text_len -= length;
            result = TRUE;
        } else if( !want_time ) {
            result = TRUE;
        }
    } else if( fb_hTimeParse( text, text_len, pHour, pMinute, pSecond, &length ) ) {
        text += length;
        text_len -= length;

        /* skip WS */
        while( isspace( *text ) )
            ++text, --text_len;
        /* skip optional comma */
        if( *text==',' )
            ++text, --text_len;

        if( fb_hDateParse( text, text_len, pDay, pMonth, pYear, &length ) ) {
            text += length;
            text_len -= length;
            result = TRUE;
        } else if( !want_date ) {
            result = TRUE;
        }
    }

    if( result ) {
        /* the rest of the text must consist of white spaces */
        while( *text ) {
            if( !isspace( *text++ ) ) {
                result = FALSE;
                break;
            }
        }
    }

    return result;
}

/*:::::*/
FBCALL int fb_DateParse( FBSTRING *s, int *pDay, int *pMonth, int *pYear )
{
    return fb_DateTimeParse( s,
                             pDay, pMonth, pYear,
                             NULL, NULL, NULL,
                             TRUE, FALSE );
}

/*:::::*/
FBCALL int fb_TimeParse( FBSTRING *s, int *pHour, int *pMinute, int *pSecond )
{
    return fb_DateTimeParse( s,
                             NULL, NULL, NULL,
                             pHour, pMinute, pSecond,
                             FALSE, TRUE );
}
