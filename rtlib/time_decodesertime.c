/* functions to decode a serial time number */

#include "fb.h"

/*:::::*/
FBCALL void fb_hTimeDecodeSerial ( double serial,
                                   int *pHour, int *pMinute, int *pSecond,
                                   int use_qb_hack )
{
    int hour, minute, second;
    double dblFixValue = fb_FIXDouble( serial );

    serial -= dblFixValue;
    if( fb_hSign( serial ) == -1 ) {
        if( use_qb_hack ) {
            /* Test for both 0.0 and -0.0 because FPUs may handle this as
             * different values ... */
            if( dblFixValue==0.0 || dblFixValue==-0.0 ) {
                /* QB quirk ! */
                serial = -serial;
            } else {
                serial += 1.0l;
            }
        } else {
            serial += 1.0l;
        }
    }

    /* The inaccuracies of the IEEE floating point data types ... */
    serial += 0.000000001l;

    serial *= 24.0l;
    hour = (int) serial;
    serial -= hour;
    serial *= 60.0l;
    minute = (int) serial;
    serial -= minute;
    serial *= 60.0l;
    second = (int) serial;

    if( pHour )
        *pHour = hour;
    if( pMinute )
        *pMinute = minute;
    if( pSecond )
        *pSecond = second;
}

FBCALL int fb_Hour( double serial )
{
    int hour;
    fb_hTimeDecodeSerial( serial, &hour, NULL, NULL, TRUE );
    return hour;
}

FBCALL int fb_Minute( double serial )
{
    int minute;
    fb_hTimeDecodeSerial( serial, NULL, &minute, NULL, TRUE );
    return minute;
}

FBCALL int fb_Second( double serial )
{
    int second;
    fb_hTimeDecodeSerial( serial, NULL, NULL, &second, TRUE );
    return second;
}
