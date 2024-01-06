/* get i18n data */

#include "../fb.h"
#ifndef DISABLE_LANGINFO
#include <langinfo.h>
#endif

const char *fb_DrvIntlGet( eFbIntlIndex Index )
{
	switch( Index ) {
	case eFIL_DateDivider:
		return "/";
	case eFIL_TimeDivider:
		return ":";
#ifdef DISABLE_LANGINFO
	case eFIL_NumDecimalPoint:
		return ".";
	case eFIL_NumThousandsSeparator:
		return ",";
#else
	case eFIL_NumDecimalPoint:
		return nl_langinfo( RADIXCHAR );
	case eFIL_NumThousandsSeparator:
		return nl_langinfo( THOUSEP );
#endif
	}
	return NULL;
}
