/* parse a string date */

#include "fb.h"
#include <ctype.h>

/*:::::*/
static int fb_hIsMonth( const char *text, size_t text_len, const char **end_text, int short_name, int localized )
{
    const char *txt_end = text;
    int month;
    for( month=1; month!=13; ++month ) {
        FBSTRING *sMonthName = fb_IntlGetMonthName( month, short_name, !localized );
        DBG_ASSERT( sMonthName!=NULL );
        {
            size_t month_len = FB_STRSIZE( sMonthName );
            size_t len = ((text_len < month_len) ? text_len : month_len );
            int is_same = FB_MEMCMP( text, sMonthName->data, len ) == 0;
            fb_hStrDelTemp( sMonthName );
            if( is_same ) {
                if( text_len > len ) {
                    if( !isalpha( FB_CHAR_TO_INT(text[len]) ) ) {
                        txt_end = text + len;
                        break;
                    }
                } else {
                    txt_end = text + len;
                    break;
                }
            }
        }
    }
    if( month!=13 ) {
        if( short_name ) {
            /* There might follow a dot directly after the
             * abbreviated month name */
            if( *txt_end=='.' )
                ++txt_end;
        }
    } else {
        month = 0;
    }
    if( end_text!=NULL )
        *end_text = txt_end;
    return month;
}

/*:::::*/
static int fb_hFindMonth( const char *text, size_t text_len, const char **end_text )
{
    int short_name;
    for( short_name=0; short_name!=2; ++short_name ) {
        int localized = 2;
        while( localized-- ) {
            int month = fb_hIsMonth( text, text_len, end_text, short_name, localized );
            if( month!=0 ) {
                return month;
            }
        }
    }
    return 0;
}

/*:::::*/
static int fb_hDateOrder( int *pOrderDay, int *pOrderMonth, int *pOrderYear )
{
    int order_month = 0, order_day = 1, order_year = 2, order_index = 0;
    int tmp, got_sep;
    char short_format[90];

    tmp = fb_IntlGetDateFormat( short_format, sizeof(short_format), FALSE );
    if( !tmp ) {
        return FALSE;
    }

    got_sep = TRUE;
    for( tmp=0; short_format[tmp]; ++tmp ) {
        int ch = FB_CHAR_TO_INT( short_format[tmp] );
        if( islower(ch) )
            ch = toupper( ch );
        switch ( ch ) {
        case 'D':
            order_day = order_index;
            got_sep = FALSE;
            break;
        case 'M':
            order_month = order_index;
            got_sep = FALSE;
            break;
        case 'Y':
            order_year = order_index;
            got_sep = FALSE;
            break;
        default:
            if( !got_sep ) {
                ++order_index;
            }
            got_sep = TRUE;
            break;
        }
    }

    if( order_day==order_month || order_day==order_year || order_month==order_year )
        return FALSE;
    if( order_day > 2 || order_month > 2 || order_year > 2 )
        return FALSE;

    if( pOrderDay )
        *pOrderDay = order_day;
    if( pOrderMonth )
        *pOrderMonth = order_month;
    if( pOrderYear )
        *pOrderYear = order_year;

    return TRUE;
}

/*:::::*/
static __inline__
int InlineSelect( int index, int num1, int num2, int num3 )
{
    if( index==0 )
        return num1;
    if( index==1 )
        return num2;
    if( index==2 )
        return num3;
    return 0;
}

/*:::::*/
int fb_hDateParse( const char *text, size_t text_len,
                   int *pDay, int *pMonth, int *pYear,
                   size_t *pLength )
{
    size_t length = 0, len = text_len;
    const char *text_start = text;
    int result = FALSE;
    int year = 1899, month = 12, day = 30;
    int order_year, order_month, order_day;
    const char *end_month;

    if( !fb_hDateOrder( &order_day, &order_month, &order_year ) ) {
        /* switch to US date format */
        order_month = 0;
        order_day = 1;
        order_year = 2;
    }

    /* skip white spaces */
    while ( isspace( *text ) )
        ++text;
    len = text_len - (text - text_start);

    month = fb_hFindMonth( text, len, &end_month );
    if( month != 0 ) {
        /* The string has the form: (MMMM|MMM) (d|dd)"," (yy|yyyy)  */
        char *endptr;
        text = end_month;
        day = strtol( text, &endptr, 10 );
        if( day>0 ) {

            /* skip white spaces */
            text = endptr;
            while ( isspace( *text ) )
                ++text;

            if( *text==',' ) {
                size_t year_size;
                year = strtol( ++text, &endptr, 10 );
                year_size = endptr - text;
                if( year_size > 0 ) {
                    if( year_size==2 )
                        year += 1900;

                    result = day <= fb_hTimeDaysInMonth( month, year );
                    text = endptr;
                }
            }
        }
    } else {
        /* The string can be in the short or long format.
         *
         * The short format can be
         * [0-9]{1,2}(/|\-|\.)[0-9]{1,2}\1[0-9]{1,4}
         *                              ^^ reference to first divider
         *
         * The long format can have the form:
         * (d|dd) (MMMM|MM)"," (yy|yyyy)
         */
        size_t day_size;
        char *endptr;
        int valid_divider;
        day = strtol( text, &endptr, 10 );
        day_size = endptr - text;
        if( day_size ) {
            size_t month_size = 0;
            char chDivider;
            int is_short_form;

            /* skip white spaces */
            text = endptr;
            while ( isspace( *text ) )
                ++text;

            /* read month and additional dividers */
            chDivider = *text;
            valid_divider = chDivider=='-' || chDivider=='/' || chDivider=='.';
            if( chDivider=='.' ) {
                ++text;
                /* skip white spaces */
                while ( isspace( *text ) )
                    ++text;
                len = text_len - (text - text_start);
                month = fb_hFindMonth( text, len, &end_month );
                /* We found a dot but a month name ... so this date
                 * is in LONG format. */
                is_short_form = month==0;
            } else if( valid_divider ) {
                ++text;
                is_short_form = TRUE;
            } else {
                is_short_form = FALSE;
            }
            if( is_short_form ) {
                /* short date */
                /* skip white spaces */
                while ( isspace( *text ) )
                    ++text;
                month = strtol( text, &endptr, 10 );
                month_size = endptr - text;
                if( month_size ) {
                    text = endptr;
                    /* skip white spaces */
                    while ( isspace( *text ) )
                        ++text;
                    if( *text==chDivider ) {
                        ++text;
                        result = TRUE;
                    }
                }
            } else {
                /* long date */
                len = text_len - (text - text_start);
                month = fb_hFindMonth( text, len, &end_month );
                if( month != 0 ) {
                    text = end_month;
                    /* skip white spaces */
                    while ( isspace( *text ) )
                        ++text;
                    /* this comma is optional */
                    if( *text==',' ) {
                        ++text;
                    }
                    result = TRUE;
                }
            }
            /* read year */
            if( result ) {
                size_t year_size;
                /* skip white spaces */
                while ( isspace( *text ) )
                    ++text;
                year = strtol( text, &endptr, 10 );
                year_size = endptr - text;
                if( year_size > 0 ) {
                    /* adjust short form according to the date format */
                    if( is_short_form ) {
                        int tmp_day = InlineSelect( order_day, day, month, year );
                        int tmp_month = InlineSelect( order_month, day, month, year );
                        int tmp_year = InlineSelect( order_year, day, month, year );
                        year_size = InlineSelect( order_year, day_size, month_size, year_size );
                        day = tmp_day;
                        month = tmp_month;
                        year = tmp_year;
                        if( day < 1 || month < 1 || month > 12 )
                            result = FALSE;
                    }

                    if( result ) {
                        if( year_size==2 )
                            year += 1900;
                        result = day <= fb_hTimeDaysInMonth( month, year );
                    }
                    text = endptr;
                } else {
                    result = FALSE;
                }
            }
        }
    }

    if( result ) {
        /* Update used length */
        length = text - text_start;
    }

    if( result ) {
        if( pDay )
            *pDay = day;
        if( pMonth )
            *pMonth = month;
        if( pYear )
            *pYear = year;
        if( pLength )
            *pLength = length;
    }

    return result;
}
