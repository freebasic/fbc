/* Internationalization driver for AmigaOS/AROS/MorphOS */
#include "../fb.h"
#include <string.h>

#if defined(HOST_AMIGAOS)
#include <proto/exec.h>
#include <proto/locale.h>
#include <libraries/locale.h>
extern struct ExecBase *SysBase;
struct LocaleBase *LocaleBase;
static struct Locale *locale;

static void ensure_locale(void) {
    if (!LocaleBase) {
        LocaleBase = OpenLibrary("locale.library", 38);
        if (LocaleBase) locale = OpenLocale(NULL);
    }
}
#endif

const char *fb_DrvIntlGet(eFbIntlIndex index) {
#if defined(HOST_AMIGAOS)
    ensure_locale();
    if (locale) {
        switch (index) {
            case eFIL_NumDecimalPoint:
                return (locale->loc_DecimalPoint && locale->loc_DecimalPoint[0])
                    ? locale->loc_DecimalPoint : ".";
            case eFIL_DateDivider:
                return "/";
            case eFIL_TimeDivider:
                return ":";
            case eFIL_NumThousandsSeparator:
                return ",";
        }
    }
#endif
    switch (index) {
        case eFIL_NumDecimalPoint: return ".";
        case eFIL_DateDivider: return "/";
        case eFIL_TimeDivider: return ":";
        case eFIL_NumThousandsSeparator: return ",";
    }
    return NULL;
}

int fb_DrvIntlGetDateFormat(char *buffer, size_t len) {
    if (len == 0) return 0;
#if defined(HOST_AMIGAOS)
    ensure_locale();
    if (locale && locale->loc_DateFormat) {
        strncpy(buffer, locale->loc_DateFormat, len - 1);
        buffer[len - 1] = '\0';
        return 1;
    }
#endif
    strncpy(buffer, "dd/mm/yyyy", len - 1);
    buffer[len - 1] = '\0';
    return 1;
}

int fb_DrvIntlGetTimeFormat(char *buffer, size_t len) {
    if (len == 0) return 0;
#if defined(HOST_AMIGAOS)
    ensure_locale();
    if (locale && locale->loc_TimeFormat) {
        strncpy(buffer, locale->loc_TimeFormat, len - 1);
        buffer[len - 1] = '\0';
        return 1;
    }
#endif
    strncpy(buffer, "hh:mm:ss", len - 1);
    buffer[len - 1] = '\0';
    return 1;
}

FBSTRING *fb_DrvIntlGetMonthName(int month, int short_names) {
    static const char *months[] = {
        "January","February","March","April","May","June",
        "July","August","September","October","November","December"
    };
    static const char *abbr[] = {
        "Jan","Feb","Mar","Apr","May","Jun",
        "Jul","Aug","Sep","Oct","Nov","Dec"
    };
    const char *name = NULL;

    if (month < 1 || month > 12) return NULL;

#if defined(HOST_AMIGAOS)
    ensure_locale();
    if (locale) {
        name = GetLocaleStr(locale, short_names ? (ABMON_1 + month - 1) : (MON_1 + month - 1));
    }
#endif
    if (!name || !name[0])
        name = short_names ? abbr[month - 1] : months[month - 1];

    size_t name_len = strlen(name);
    FBSTRING *result = fb_hStrAllocTemp(NULL, name_len);
    if (result)
        FB_MEMCPY(result->data, name, name_len);
    return result;
}

FBSTRING *fb_DrvIntlGetWeekdayName(int weekday, int short_names) {
    static const char *days[] = {
        "Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"
    };
    static const char *abbr[] = {
        "Sun","Mon","Tue","Wed","Thu","Fri","Sat"
    };
    const char *name = NULL;

    if (weekday < 1 || weekday > 7) return NULL;

#if defined(HOST_AMIGAOS)
    ensure_locale();
    if (locale) {
        name = GetLocaleStr(locale, short_names ? (ABDAY_1 + weekday - 1) : (DAY_1 + weekday - 1));
    }
#endif
    if (!name || !name[0])
        name = short_names ? abbr[weekday - 1] : days[weekday - 1];

    size_t name_len = strlen(name);
    FBSTRING *result = fb_hStrAllocTemp(NULL, name_len);
    if (result)
        FB_MEMCPY(result->data, name, name_len);
    return result;
}

void fb_hIntlExit(void) {
#if defined(HOST_AMIGAOS)
    if (locale) { CloseLocale(locale); locale = NULL; }
    if (LocaleBase) { CloseLibrary(LocaleBase); LocaleBase = NULL; }
#endif
}
