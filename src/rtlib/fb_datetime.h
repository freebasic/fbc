FBCALL double       fb_Timer            ( void );
FBCALL FBSTRING    *fb_Time             ( void );
FBCALL int          fb_SetTime          ( FBSTRING *time );
FBCALL FBSTRING    *fb_Date             ( void );
FBCALL int          fb_SetDate          ( FBSTRING *date );

       int          fb_hSetTime         ( int h, int m, int s );
       int          fb_hSetDate         ( int y, int m, int d );


/**************************************************************************************************
 * VB-compatible functions
 **************************************************************************************************/

typedef enum _eFbIntlIndex {
	eFIL_DateDivider,
    eFIL_TimeDivider,
    eFIL_NumDecimalPoint,
	eFIL_NumThousandsSeparator
} eFbIntlIndex;

#define FB_WEEK_FIRST_SYSTEM            0
#define FB_WEEK_FIRST_JAN_1             1
#define FB_WEEK_FIRST_FOUR_DAYS         2
#define FB_WEEK_FIRST_FULL_WEEK         3
#define FB_WEEK_FIRST_DEFAULT           FB_WEEK_FIRST_JAN_1

#define FB_WEEK_DAY_SYSTEM              0
#define FB_WEEK_DAY_SUNDAY              1
#define FB_WEEK_DAY_MONDAY              2
#define FB_WEEK_DAY_TUESDAY             3
#define FB_WEEK_DAY_WEDNESDAY           4
#define FB_WEEK_DAY_THURSDAY            5
#define FB_WEEK_DAY_FRIDAY              6
#define FB_WEEK_DAY_SATURDAY            7
#define FB_WEEK_DAY_DEFAULT             FB_WEEK_DAY_SUNDAY

#define FB_TIME_INTERVAL_INVALID        0
#define FB_TIME_INTERVAL_YEAR           1
#define FB_TIME_INTERVAL_QUARTER        2
#define FB_TIME_INTERVAL_MONTH          3
#define FB_TIME_INTERVAL_DAY_OF_YEAR    4
#define FB_TIME_INTERVAL_DAY            5
#define FB_TIME_INTERVAL_WEEKDAY        6
#define FB_TIME_INTERVAL_WEEK_OF_YEAR   7
#define FB_TIME_INTERVAL_HOUR           8
#define FB_TIME_INTERVAL_MINUTE         9
#define FB_TIME_INTERVAL_SECOND         10

#define fb_hTimeDaysInYear( year ) \
    (365 + fb_hTimeLeap( year ))

FBCALL int          fb_IsDate           ( FBSTRING *s );
FBCALL int          fb_DateValue        ( FBSTRING *s );
FBCALL int          fb_DateSerial       ( int year, int month, int day );
FBCALL int          fb_Year             ( double serial );
FBCALL int          fb_Month            ( double serial );
FBCALL int          fb_Day              ( double serial );
FBCALL int          fb_Weekday          ( double serial, int first_day_of_week );

FBCALL double       fb_TimeValue        ( FBSTRING *s );
FBCALL double       fb_TimeSerial       ( int hour, int minute, int second );
FBCALL int          fb_Hour             ( double serial );
FBCALL int          fb_Minute           ( double serial );
FBCALL int          fb_Second           ( double serial );

FBCALL double       fb_Now              ( void );

FBCALL FBSTRING *   fb_MonthName        ( int month, int abbreviation );
FBCALL FBSTRING *   fb_WeekdayName      ( int weekday, int abbreviation,
                                          int first_day_of_week );

FBCALL double       fb_DateAdd          ( FBSTRING *interval,
                                          double interval_value_arg,
                                          double serial );
FBCALL int          fb_DatePart         ( FBSTRING *interval, double serial,
                                          int first_day_of_week,
                                          int first_day_of_year );
FBCALL long long    fb_DateDiff         ( FBSTRING *interval,
                                          double serial1, double serial2,
                                          int first_day_of_week,
                                          int first_day_of_year );

       int          fb_hDateParse       ( const char *text, size_t text_len,
                                          int *pDay, int *pMonth, int *pYear,
                                          size_t *pLength );
FBCALL int          fb_DateParse        ( FBSTRING *s,
                                          int *pDay, int *pMonth, int *pYear );
FBCALL void         fb_hDateDecodeSerial( double serial,
                                          int *pYear, int *pMonth, int *pDay );

       int          fb_hTimeParse       ( const char *text, size_t text_len,
                                          int *pHour, int *pMinute, int *pSecond,
                                          size_t *pLength );
FBCALL int          fb_TimeParse        ( FBSTRING *s,
                                          int *pHour, int *pMinute, int *pSecond );
FBCALL void         fb_hTimeDecodeSerial( double serial,
                                          int *pHour, int *pMinute, int *pSecond,
                                          int use_qb_hack );

FBCALL int          fb_DateTimeParse    ( FBSTRING *s,
                                          int *pDay, int *pMonth, int *pYear,
                                          int *pHour, int *pMinute, int *pSecond,
                                          int want_date, int want_time );

FBCALL void         fb_I18nSet          ( int on_off );
FBCALL int          fb_I18nGet          ( void );

       int          fb_hTimeLeap        ( int year );
       int          fb_hGetDayOfYear    ( double serial );
       int          fb_hGetDayOfYearEx  ( int year, int month, int day );
       int          fb_hGetWeekOfYear   ( int ref_year, double serial, int first_day_of_year, int first_day_of_week );
       int          fb_hGetWeeksOfYear  ( int ref_year, int first_day_of_year, int first_day_of_week );
       int          fb_hTimeDaysInMonth ( int month, int year );
       void         fb_hNormalizeDate   ( int *pDay, int *pMonth, int *pYear );
       int          fb_hTimeGetIntervalType ( FBSTRING *interval );

       const char * fb_IntlGet          ( eFbIntlIndex index, int disallow_localized );
       int          fb_IntlGetDateFormat( char *buffer, size_t len, int disallow_localized );
       int          fb_IntlGetTimeFormat( char *buffer, size_t len, int disallow_localized );
       FBSTRING   * fb_IntlGetMonthName ( int month, int short_name, int disallow_localized );
       FBSTRING   * fb_IntlGetWeekdayName( int weekday, int short_names, int disallow_localized );

       const char * fb_DrvIntlGet       ( eFbIntlIndex index );
       int          fb_DrvIntlGetDateFormat ( char *buffer, size_t len );
       int          fb_DrvIntlGetTimeFormat ( char *buffer, size_t len );
       FBSTRING   * fb_DrvIntlGetMonthName  ( int month, int short_name );
       FBSTRING   * fb_DrvIntlGetWeekdayName( int weekday, int short_names );
