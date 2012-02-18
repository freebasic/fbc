/* get i18n data */

#include "fb.h"
#include "fb_private_intl.h"

#if defined( HOST_DOS )
const char *fb_DrvIntlGet( eFbIntlIndex Index )
{
	static DOS_COUNTRY_INFO_GENERAL Info;
	if( !fb_hIntlGetInfo( &Info ) )
		return NULL;

	switch( Index ) {
	case eFIL_DateDivider:
		return Info.date_sep;
	case eFIL_TimeDivider:
		return Info.time_sep;
	case eFIL_NumDecimalPoint:
		return Info.decimal_sep;
	case eFIL_NumThousandsSeparator:
		return Info.thousands_sep;
	}

	return NULL;
}

#elif defined( HOST_UNIX )
const char *fb_DrvIntlGet( eFbIntlIndex Index )
{
	switch( Index ) {
	case eFIL_DateDivider:
		return "/";
	case eFIL_TimeDivider:
		return ":";
	case eFIL_NumDecimalPoint:
		return nl_langinfo( RADIXCHAR );
	case eFIL_NumThousandsSeparator:
		return nl_langinfo( THOUSEP );
	}
	return NULL;
}

#elif defined( HOST_WIN32 )
const char *fb_DrvIntlGet( eFbIntlIndex Index )
{
	static char buf[128];
	LCTYPE lctype;

	switch( Index ) {
	case eFIL_DateDivider: lctype = LOCALE_SDATE; break;
	case eFIL_TimeDivider: lctype = LOCALE_STIME; break;
	case eFIL_NumDecimalPoint: lctype = LOCALE_SDECIMAL; break;
	case eFIL_NumThousandsSeparator: lctype = LOCALE_STHOUSAND; break;
	default:
		return NULL;
	}

	return fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, lctype,
	                          buf, sizeof(buf) - 1 ) ? buf : NULL;
}

#else
const char *fb_DrvIntlGet( eFbIntlIndex Index )
{
	/* No I18N information available */
	return NULL;
}

#endif
