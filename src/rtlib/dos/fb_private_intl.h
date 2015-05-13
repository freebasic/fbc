/* Locale information not provided by DOS but that are useful too */
typedef struct _FB_LOCALE_INFOS {
	int country_code;
	const char *apszNamesMonthLong[12];
	const char *apszNamesMonthShort[12];
	const char *apszNamesWeekdayLong[7];
	const char *apszNamesWeekdayShort[7];
} FB_LOCALE_INFOS;

/* Array of locale information. The last entry contains a country_code of -1. */
extern const FB_LOCALE_INFOS __fb_locale_infos[];
extern const size_t          __fb_locale_info_count;

struct _DOS_COUNTRY_INFO_GENERAL {
	unsigned char   info_id;
	unsigned short  size_data;
	unsigned short  country_id;
	unsigned short  code_page;
	unsigned short  date_format;
	char            curr_symbol_string[5];
	char            thousands_sep[2];
	char            decimal_sep[2];
	char            date_sep[2];
	char            time_sep[2];
	unsigned char   currency_format;
	unsigned char   curr_frac_digits;
	unsigned char   time_format;
	unsigned long   far_ptr_case_map_routine;
	char            data_list_sep[2];
	char            reserved[10];
} FBPACKED;

typedef struct _DOS_COUNTRY_INFO_GENERAL DOS_COUNTRY_INFO_GENERAL;

int fb_hIntlGetInfo( DOS_COUNTRY_INFO_GENERAL *pInfo );
