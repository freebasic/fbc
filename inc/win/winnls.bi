#pragma once

#include once "winapifamily.bi"
#include once "apiset.bi"

extern "Windows"

#define _WINNLS_
#define _DATETIMEAPI_H_

declare function GetTimeFormatEx(byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lpTime as const SYSTEMTIME ptr, byval lpFormat as LPCWSTR, byval lpTimeStr as LPWSTR, byval cchTime as long) as long
declare function GetDateFormatEx(byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lpDate as const SYSTEMTIME ptr, byval lpFormat as LPCWSTR, byval lpDateStr as LPWSTR, byval cchDate as long, byval lpCalendar as LPCWSTR) as long
declare function GetDateFormatA(byval Locale as LCID, byval dwFlags as DWORD, byval lpDate as const SYSTEMTIME ptr, byval lpFormat as LPCSTR, byval lpDateStr as LPSTR, byval cchDate as long) as long
declare function GetDateFormatW(byval Locale as LCID, byval dwFlags as DWORD, byval lpDate as const SYSTEMTIME ptr, byval lpFormat as LPCWSTR, byval lpDateStr as LPWSTR, byval cchDate as long) as long
declare function GetTimeFormatA(byval Locale as LCID, byval dwFlags as DWORD, byval lpTime as const SYSTEMTIME ptr, byval lpFormat as LPCSTR, byval lpTimeStr as LPSTR, byval cchTime as long) as long
declare function GetTimeFormatW(byval Locale as LCID, byval dwFlags as DWORD, byval lpTime as const SYSTEMTIME ptr, byval lpFormat as LPCWSTR, byval lpTimeStr as LPWSTR, byval cchTime as long) as long

#ifdef UNICODE
	#define GetDateFormat GetDateFormatW
	#define GetTimeFormat GetTimeFormatW
#else
	#define GetDateFormat GetDateFormatA
	#define GetTimeFormat GetTimeFormatA
#endif

#define MAX_LEADBYTES 12
#define MAX_DEFAULTCHAR 2
#define HIGH_SURROGATE_START &hd800
#define HIGH_SURROGATE_END &hdbff
#define LOW_SURROGATE_START &hdc00
#define LOW_SURROGATE_END &hdfff
#define MB_PRECOMPOSED &h00000001
#define MB_COMPOSITE &h00000002
#define MB_USEGLYPHCHARS &h00000004
#define MB_ERR_INVALID_CHARS &h00000008
#define WC_DISCARDNS &h00000010
#define WC_SEPCHARS &h00000020
#define WC_DEFAULTCHAR &h00000040
#define WC_COMPOSITECHECK &h00000200
#define WC_NO_BEST_FIT_CHARS &h00000400
#define CT_CTYPE1 &h00000001
#define CT_CTYPE2 &h00000002
#define CT_CTYPE3 &h00000004
#define C1_UPPER &h0001
#define C1_LOWER &h0002
#define C1_DIGIT &h0004
#define C1_SPACE &h0008
#define C1_PUNCT &h0010
#define C1_CNTRL &h0020
#define C1_BLANK &h0040
#define C1_XDIGIT &h0080
#define C1_ALPHA &h0100
#define C1_DEFINED &h0200
#define C2_LEFTTORIGHT &h0001
#define C2_RIGHTTOLEFT &h0002
#define C2_EUROPENUMBER &h0003
#define C2_EUROPESEPARATOR &h0004
#define C2_EUROPETERMINATOR &h0005
#define C2_ARABICNUMBER &h0006
#define C2_COMMONSEPARATOR &h0007
#define C2_BLOCKSEPARATOR &h0008
#define C2_SEGMENTSEPARATOR &h0009
#define C2_WHITESPACE &h000a
#define C2_OTHERNEUTRAL &h000b
#define C2_NOTAPPLICABLE &h0000
#define C3_NONSPACING &h0001
#define C3_DIACRITIC &h0002
#define C3_VOWELMARK &h0004
#define C3_SYMBOL &h0008
#define C3_KATAKANA &h0010
#define C3_HIRAGANA &h0020
#define C3_HALFWIDTH &h0040
#define C3_FULLWIDTH &h0080
#define C3_IDEOGRAPH &h0100
#define C3_KASHIDA &h0200
#define C3_LEXICAL &h0400
#define C3_HIGHSURROGATE &h0800
#define C3_LOWSURROGATE &h1000
#define C3_ALPHA &h8000
#define C3_NOTAPPLICABLE &h0000
#define NORM_IGNORECASE &h00000001
#define NORM_IGNORENONSPACE &h00000002
#define NORM_IGNORESYMBOLS &h00000004
#define LINGUISTIC_IGNORECASE &h00000010
#define LINGUISTIC_IGNOREDIACRITIC &h00000020
#define NORM_IGNOREKANATYPE &h00010000
#define NORM_IGNOREWIDTH &h00020000
#define NORM_LINGUISTIC_CASING &h08000000
#define MAP_FOLDCZONE &h00000010
#define MAP_PRECOMPOSED &h00000020
#define MAP_COMPOSITE &h00000040
#define MAP_FOLDDIGITS &h00000080
#define MAP_EXPAND_LIGATURES &h00002000
#define LCMAP_LOWERCASE &h00000100
#define LCMAP_UPPERCASE &h00000200
#define LCMAP_SORTKEY &h00000400
#define LCMAP_BYTEREV &h00000800
#define LCMAP_HIRAGANA &h00100000
#define LCMAP_KATAKANA &h00200000
#define LCMAP_HALFWIDTH &h00400000
#define LCMAP_FULLWIDTH &h00800000
#define LCMAP_LINGUISTIC_CASING &h01000000
#define LCMAP_SIMPLIFIED_CHINESE &h02000000
#define LCMAP_TRADITIONAL_CHINESE &h04000000
#define FIND_STARTSWITH &h00100000
#define FIND_ENDSWITH &h00200000
#define FIND_FROMSTART &h00400000
#define FIND_FROMEND &h00800000
#define LGRPID_INSTALLED &h00000001
#define LGRPID_SUPPORTED &h00000002
#define LCID_INSTALLED &h00000001
#define LCID_SUPPORTED &h00000002
#define LCID_ALTERNATE_SORTS &h00000004
#define CP_INSTALLED &h00000001
#define CP_SUPPORTED &h00000002
#define SORT_STRINGSORT &h00001000
#define CSTR_LESS_THAN 1
#define CSTR_EQUAL 2
#define CSTR_GREATER_THAN 3
#define CP_ACP 0
#define CP_OEMCP 1
#define CP_MACCP 2
#define CP_THREAD_ACP 3
#define CP_SYMBOL 42
#define CP_UTF7 65000
#define CP_UTF8 65001
#define CTRY_DEFAULT 0
#define CTRY_ALBANIA 355
#define CTRY_ALGERIA 213
#define CTRY_ARGENTINA 54
#define CTRY_ARMENIA 374
#define CTRY_AUSTRALIA 61
#define CTRY_AUSTRIA 43
#define CTRY_AZERBAIJAN 994
#define CTRY_BAHRAIN 973
#define CTRY_BELARUS 375
#define CTRY_BELGIUM 32
#define CTRY_BELIZE 501
#define CTRY_BOLIVIA 591
#define CTRY_BRAZIL 55
#define CTRY_BRUNEI_DARUSSALAM 673
#define CTRY_BULGARIA 359
#define CTRY_CANADA 2
#define CTRY_CARIBBEAN 1
#define CTRY_CHILE 56
#define CTRY_COLOMBIA 57
#define CTRY_COSTA_RICA 506
#define CTRY_CROATIA 385
#define CTRY_CZECH 420
#define CTRY_DENMARK 45
#define CTRY_DOMINICAN_REPUBLIC 1
#define CTRY_ECUADOR 593
#define CTRY_EGYPT 20
#define CTRY_EL_SALVADOR 503
#define CTRY_ESTONIA 372
#define CTRY_FAEROE_ISLANDS 298
#define CTRY_FINLAND 358
#define CTRY_FRANCE 33
#define CTRY_GEORGIA 995
#define CTRY_GERMANY 49
#define CTRY_GREECE 30
#define CTRY_GUATEMALA 502
#define CTRY_HONDURAS 504
#define CTRY_HONG_KONG 852
#define CTRY_HUNGARY 36
#define CTRY_ICELAND 354
#define CTRY_INDIA 91
#define CTRY_INDONESIA 62
#define CTRY_IRAN 981
#define CTRY_IRAQ 964
#define CTRY_IRELAND 353
#define CTRY_ISRAEL 972
#define CTRY_ITALY 39
#define CTRY_JAMAICA 1
#define CTRY_JAPAN 81
#define CTRY_JORDAN 962
#define CTRY_KAZAKSTAN 7
#define CTRY_KENYA 254
#define CTRY_KUWAIT 965
#define CTRY_KYRGYZSTAN 996
#define CTRY_LATVIA 371
#define CTRY_LEBANON 961
#define CTRY_LIBYA 218
#define CTRY_LIECHTENSTEIN 41
#define CTRY_LITHUANIA 370
#define CTRY_LUXEMBOURG 352
#define CTRY_MACAU 853
#define CTRY_MACEDONIA 389
#define CTRY_MALAYSIA 60
#define CTRY_MALDIVES 960
#define CTRY_MEXICO 52
#define CTRY_MONACO 33
#define CTRY_MONGOLIA 976
#define CTRY_MOROCCO 212
#define CTRY_NETHERLANDS 31
#define CTRY_NEW_ZEALAND 64
#define CTRY_NICARAGUA 505
#define CTRY_NORWAY 47
#define CTRY_OMAN 968
#define CTRY_PAKISTAN 92
#define CTRY_PANAMA 507
#define CTRY_PARAGUAY 595
#define CTRY_PERU 51
#define CTRY_PHILIPPINES 63
#define CTRY_POLAND 48
#define CTRY_PORTUGAL 351
#define CTRY_PRCHINA 86
#define CTRY_PUERTO_RICO 1
#define CTRY_QATAR 974
#define CTRY_ROMANIA 40
#define CTRY_RUSSIA 7
#define CTRY_SAUDI_ARABIA 966
#define CTRY_SERBIA 381
#define CTRY_SINGAPORE 65
#define CTRY_SLOVAK 421
#define CTRY_SLOVENIA 386
#define CTRY_SOUTH_AFRICA 27
#define CTRY_SOUTH_KOREA 82
#define CTRY_SPAIN 34
#define CTRY_SWEDEN 46
#define CTRY_SWITZERLAND 41
#define CTRY_SYRIA 963
#define CTRY_TAIWAN 886
#define CTRY_TATARSTAN 7
#define CTRY_THAILAND 66
#define CTRY_TRINIDAD_Y_TOBAGO 1
#define CTRY_TUNISIA 216
#define CTRY_TURKEY 90
#define CTRY_UAE 971
#define CTRY_UKRAINE 380
#define CTRY_UNITED_KINGDOM 44
#define CTRY_UNITED_STATES 1
#define CTRY_URUGUAY 598
#define CTRY_UZBEKISTAN 7
#define CTRY_VENEZUELA 58
#define CTRY_VIET_NAM 84
#define CTRY_YEMEN 967
#define CTRY_ZIMBABWE 263
#define LOCALE_SLOCALIZEDDISPLAYNAME &h00000002
#define LOCALE_RETURN_NUMBER &h20000000
#define LOCALE_USE_CP_ACP &h40000000
#define LOCALE_NOUSEROVERRIDE &h80000000
#define LOCALE_SENGLISHLANGUAGENAME &h00001001
#define LOCALE_SNATIVELANGUAGENAME &h00000004
#define LOCALE_SLOCALIZEDCOUNTRYNAME &h00000006
#define LOCALE_SENGLISHCOUNTRYNAME &h00001002
#define LOCALE_SNATIVECOUNTRYNAME &h00000008
#define LOCALE_SLANGUAGE &h00000002
#define LOCALE_SENGLANGUAGE &h00001001
#define LOCALE_SNATIVELANGNAME &h00000004
#define LOCALE_SCOUNTRY &h00000006
#define LOCALE_SENGCOUNTRY &h00001002
#define LOCALE_SNATIVECTRYNAME &h00000008
#define LOCALE_ILANGUAGE &h00000001
#define LOCALE_SABBREVLANGNAME &h00000003
#define LOCALE_ICOUNTRY &h00000005
#define LOCALE_SABBREVCTRYNAME &h00000007
#define LOCALE_IGEOID &h0000005b
#define LOCALE_IDEFAULTLANGUAGE &h00000009
#define LOCALE_IDEFAULTCOUNTRY &h0000000a
#define LOCALE_IDEFAULTCODEPAGE &h0000000b
#define LOCALE_IDEFAULTANSICODEPAGE &h00001004
#define LOCALE_IDEFAULTMACCODEPAGE &h00001011
#define LOCALE_SLIST &h0000000c
#define LOCALE_IMEASURE &h0000000d
#define LOCALE_SDECIMAL &h0000000e
#define LOCALE_STHOUSAND &h0000000f
#define LOCALE_SGROUPING &h00000010
#define LOCALE_IDIGITS &h00000011
#define LOCALE_ILZERO &h00000012
#define LOCALE_INEGNUMBER &h00001010
#define LOCALE_SNATIVEDIGITS &h00000013
#define LOCALE_SCURRENCY &h00000014
#define LOCALE_SINTLSYMBOL &h00000015
#define LOCALE_SMONDECIMALSEP &h00000016
#define LOCALE_SMONTHOUSANDSEP &h00000017
#define LOCALE_SMONGROUPING &h00000018
#define LOCALE_ICURRDIGITS &h00000019
#define LOCALE_IINTLCURRDIGITS &h0000001a
#define LOCALE_ICURRENCY &h0000001b
#define LOCALE_INEGCURR &h0000001c
#define LOCALE_SDATE &h0000001d
#define LOCALE_STIME &h0000001e
#define LOCALE_SSHORTDATE &h0000001f
#define LOCALE_SLONGDATE &h00000020
#define LOCALE_STIMEFORMAT &h00001003
#define LOCALE_IDATE &h00000021
#define LOCALE_ILDATE &h00000022
#define LOCALE_ITIME &h00000023
#define LOCALE_ITIMEMARKPOSN &h00001005
#define LOCALE_ICENTURY &h00000024
#define LOCALE_ITLZERO &h00000025
#define LOCALE_IDAYLZERO &h00000026
#define LOCALE_IMONLZERO &h00000027
#define LOCALE_S1159 &h00000028
#define LOCALE_S2359 &h00000029
#define LOCALE_ICALENDARTYPE &h00001009
#define LOCALE_IOPTIONALCALENDAR &h0000100b
#define LOCALE_IFIRSTDAYOFWEEK &h0000100c
#define LOCALE_IFIRSTWEEKOFYEAR &h0000100d
#define LOCALE_SDAYNAME1 &h0000002a
#define LOCALE_SDAYNAME2 &h0000002b
#define LOCALE_SDAYNAME3 &h0000002c
#define LOCALE_SDAYNAME4 &h0000002d
#define LOCALE_SDAYNAME5 &h0000002e
#define LOCALE_SDAYNAME6 &h0000002f
#define LOCALE_SDAYNAME7 &h00000030
#define LOCALE_SABBREVDAYNAME1 &h00000031
#define LOCALE_SABBREVDAYNAME2 &h00000032
#define LOCALE_SABBREVDAYNAME3 &h00000033
#define LOCALE_SABBREVDAYNAME4 &h00000034
#define LOCALE_SABBREVDAYNAME5 &h00000035
#define LOCALE_SABBREVDAYNAME6 &h00000036
#define LOCALE_SABBREVDAYNAME7 &h00000037
#define LOCALE_SMONTHNAME1 &h00000038
#define LOCALE_SMONTHNAME2 &h00000039
#define LOCALE_SMONTHNAME3 &h0000003a
#define LOCALE_SMONTHNAME4 &h0000003b
#define LOCALE_SMONTHNAME5 &h0000003c
#define LOCALE_SMONTHNAME6 &h0000003d
#define LOCALE_SMONTHNAME7 &h0000003e
#define LOCALE_SMONTHNAME8 &h0000003f
#define LOCALE_SMONTHNAME9 &h00000040
#define LOCALE_SMONTHNAME10 &h00000041
#define LOCALE_SMONTHNAME11 &h00000042
#define LOCALE_SMONTHNAME12 &h00000043
#define LOCALE_SMONTHNAME13 &h0000100e
#define LOCALE_SABBREVMONTHNAME1 &h00000044
#define LOCALE_SABBREVMONTHNAME2 &h00000045
#define LOCALE_SABBREVMONTHNAME3 &h00000046
#define LOCALE_SABBREVMONTHNAME4 &h00000047
#define LOCALE_SABBREVMONTHNAME5 &h00000048
#define LOCALE_SABBREVMONTHNAME6 &h00000049
#define LOCALE_SABBREVMONTHNAME7 &h0000004a
#define LOCALE_SABBREVMONTHNAME8 &h0000004b
#define LOCALE_SABBREVMONTHNAME9 &h0000004c
#define LOCALE_SABBREVMONTHNAME10 &h0000004d
#define LOCALE_SABBREVMONTHNAME11 &h0000004e
#define LOCALE_SABBREVMONTHNAME12 &h0000004f
#define LOCALE_SABBREVMONTHNAME13 &h0000100f
#define LOCALE_SPOSITIVESIGN &h00000050
#define LOCALE_SNEGATIVESIGN &h00000051
#define LOCALE_IPOSSIGNPOSN &h00000052
#define LOCALE_INEGSIGNPOSN &h00000053
#define LOCALE_IPOSSYMPRECEDES &h00000054
#define LOCALE_IPOSSEPBYSPACE &h00000055
#define LOCALE_INEGSYMPRECEDES &h00000056
#define LOCALE_INEGSEPBYSPACE &h00000057
#define LOCALE_FONTSIGNATURE &h00000058
#define LOCALE_SISO639LANGNAME &h00000059
#define LOCALE_SISO3166CTRYNAME &h0000005a
#define LOCALE_IDEFAULTEBCDICCODEPAGE &h00001012
#define LOCALE_IPAPERSIZE &h0000100a
#define LOCALE_SENGCURRNAME &h00001007
#define LOCALE_SNATIVECURRNAME &h00001008
#define LOCALE_SYEARMONTH &h00001006
#define LOCALE_SSORTNAME &h00001013
#define LOCALE_IDIGITSUBSTITUTION &h00001014
#define TIME_NOMINUTESORSECONDS &h00000001
#define TIME_NOSECONDS &h00000002
#define TIME_NOTIMEMARKER &h00000004
#define TIME_FORCE24HOURFORMAT &h00000008
#define DATE_SHORTDATE &h00000001
#define DATE_LONGDATE &h00000002
#define DATE_USE_ALT_CALENDAR &h00000004
#define DATE_YEARMONTH &h00000008
#define DATE_LTRREADING &h00000010
#define DATE_RTLREADING &h00000020
#define CAL_NOUSEROVERRIDE LOCALE_NOUSEROVERRIDE
#define CAL_USE_CP_ACP LOCALE_USE_CP_ACP
#define CAL_RETURN_NUMBER LOCALE_RETURN_NUMBER
#define CAL_ICALINTVALUE &h00000001
#define CAL_SCALNAME &h00000002
#define CAL_IYEAROFFSETRANGE &h00000003
#define CAL_SERASTRING &h00000004
#define CAL_SSHORTDATE &h00000005
#define CAL_SLONGDATE &h00000006
#define CAL_SDAYNAME1 &h00000007
#define CAL_SDAYNAME2 &h00000008
#define CAL_SDAYNAME3 &h00000009
#define CAL_SDAYNAME4 &h0000000a
#define CAL_SDAYNAME5 &h0000000b
#define CAL_SDAYNAME6 &h0000000c
#define CAL_SDAYNAME7 &h0000000d
#define CAL_SABBREVDAYNAME1 &h0000000e
#define CAL_SABBREVDAYNAME2 &h0000000f
#define CAL_SABBREVDAYNAME3 &h00000010
#define CAL_SABBREVDAYNAME4 &h00000011
#define CAL_SABBREVDAYNAME5 &h00000012
#define CAL_SABBREVDAYNAME6 &h00000013
#define CAL_SABBREVDAYNAME7 &h00000014
#define CAL_SMONTHNAME1 &h00000015
#define CAL_SMONTHNAME2 &h00000016
#define CAL_SMONTHNAME3 &h00000017
#define CAL_SMONTHNAME4 &h00000018
#define CAL_SMONTHNAME5 &h00000019
#define CAL_SMONTHNAME6 &h0000001a
#define CAL_SMONTHNAME7 &h0000001b
#define CAL_SMONTHNAME8 &h0000001c
#define CAL_SMONTHNAME9 &h0000001d
#define CAL_SMONTHNAME10 &h0000001e
#define CAL_SMONTHNAME11 &h0000001f
#define CAL_SMONTHNAME12 &h00000020
#define CAL_SMONTHNAME13 &h00000021
#define CAL_SABBREVMONTHNAME1 &h00000022
#define CAL_SABBREVMONTHNAME2 &h00000023
#define CAL_SABBREVMONTHNAME3 &h00000024
#define CAL_SABBREVMONTHNAME4 &h00000025
#define CAL_SABBREVMONTHNAME5 &h00000026
#define CAL_SABBREVMONTHNAME6 &h00000027
#define CAL_SABBREVMONTHNAME7 &h00000028
#define CAL_SABBREVMONTHNAME8 &h00000029
#define CAL_SABBREVMONTHNAME9 &h0000002a
#define CAL_SABBREVMONTHNAME10 &h0000002b
#define CAL_SABBREVMONTHNAME11 &h0000002c
#define CAL_SABBREVMONTHNAME12 &h0000002d
#define CAL_SABBREVMONTHNAME13 &h0000002e
#define CAL_SYEARMONTH &h0000002f
#define CAL_ITWODIGITYEARMAX &h00000030
#define ENUM_ALL_CALENDARS &hffffffff
#define CAL_GREGORIAN 1
#define CAL_GREGORIAN_US 2
#define CAL_JAPAN 3
#define CAL_TAIWAN 4
#define CAL_KOREA 5
#define CAL_HIJRI 6
#define CAL_THAI 7
#define CAL_HEBREW 8
#define CAL_GREGORIAN_ME_FRENCH 9
#define CAL_GREGORIAN_ARABIC 10
#define CAL_GREGORIAN_XLIT_ENGLISH 11
#define CAL_GREGORIAN_XLIT_FRENCH 12
#define CAL_UMALQURA 23
#define LGRPID_WESTERN_EUROPE &h0001
#define LGRPID_CENTRAL_EUROPE &h0002
#define LGRPID_BALTIC &h0003
#define LGRPID_GREEK &h0004
#define LGRPID_CYRILLIC &h0005
#define LGRPID_TURKIC &h0006
#define LGRPID_TURKISH &h0006
#define LGRPID_JAPANESE &h0007
#define LGRPID_KOREAN &h0008
#define LGRPID_TRADITIONAL_CHINESE &h0009
#define LGRPID_SIMPLIFIED_CHINESE &h000a
#define LGRPID_THAI &h000b
#define LGRPID_HEBREW &h000c
#define LGRPID_ARABIC &h000d
#define LGRPID_VIETNAMESE &h000e
#define LGRPID_INDIC &h000f
#define LGRPID_GEORGIAN &h0010
#define LGRPID_ARMENIAN &h0011

type LGRPID as DWORD
type LCTYPE as DWORD
type CALTYPE as DWORD
type CALID as DWORD

type _cpinfo
	MaxCharSize as UINT
	DefaultChar(0 to 1) as UBYTE
	LeadByte(0 to 11) as UBYTE
end type

type CPINFO as _cpinfo
type LPCPINFO as _cpinfo ptr

type _cpinfoexA
	MaxCharSize as UINT
	DefaultChar(0 to 1) as UBYTE
	LeadByte(0 to 11) as UBYTE
	UnicodeDefaultChar as wchar_t
	CodePage as UINT
	CodePageName as zstring * 260
end type

type CPINFOEXA as _cpinfoexA
type LPCPINFOEXA as _cpinfoexA ptr

type _cpinfoexW
	MaxCharSize as UINT
	DefaultChar(0 to 1) as UBYTE
	LeadByte(0 to 11) as UBYTE
	UnicodeDefaultChar as wchar_t
	CodePage as UINT
	CodePageName as wstring * 260
end type

type CPINFOEXW as _cpinfoexW
type LPCPINFOEXW as _cpinfoexW ptr

#ifdef UNICODE
	type CPINFOEX as CPINFOEXW
	type LPCPINFOEX as LPCPINFOEXW
#else
	type CPINFOEX as CPINFOEXA
	type LPCPINFOEX as LPCPINFOEXA
#endif

type _numberfmtA
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPSTR
	lpThousandSep as LPSTR
	NegativeOrder as UINT
end type

type NUMBERFMTA as _numberfmtA
type LPNUMBERFMTA as _numberfmtA ptr

type _numberfmtW
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPWSTR
	lpThousandSep as LPWSTR
	NegativeOrder as UINT
end type

type NUMBERFMTW as _numberfmtW
type LPNUMBERFMTW as _numberfmtW ptr

#ifdef UNICODE
	type NUMBERFMT as NUMBERFMTW
	type LPNUMBERFMT as LPNUMBERFMTW
#else
	type NUMBERFMT as NUMBERFMTA
	type LPNUMBERFMT as LPNUMBERFMTA
#endif

type _currencyfmtA
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPSTR
	lpThousandSep as LPSTR
	NegativeOrder as UINT
	PositiveOrder as UINT
	lpCurrencySymbol as LPSTR
end type

type CURRENCYFMTA as _currencyfmtA
type LPCURRENCYFMTA as _currencyfmtA ptr

type _currencyfmtW
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPWSTR
	lpThousandSep as LPWSTR
	NegativeOrder as UINT
	PositiveOrder as UINT
	lpCurrencySymbol as LPWSTR
end type

type CURRENCYFMTW as _currencyfmtW
type LPCURRENCYFMTW as _currencyfmtW ptr

#ifdef UNICODE
	type CURRENCYFMT as CURRENCYFMTW
	type LPCURRENCYFMT as LPCURRENCYFMTW
#else
	type CURRENCYFMT as CURRENCYFMTA
	type LPCURRENCYFMT as LPCURRENCYFMTA
#endif

type SYSNLS_FUNCTION as long
enum
	COMPARE_STRING = &h1
end enum

type NLS_FUNCTION as DWORD

type _nlsversioninfo
	dwNLSVersionInfoSize as DWORD
	dwNLSVersion as DWORD
	dwDefinedVersion as DWORD
end type

type NLSVERSIONINFO as _nlsversioninfo
type LPNLSVERSIONINFO as _nlsversioninfo ptr

type _nlsversioninfoex
	dwNLSVersionInfoSize as DWORD
	dwNLSVersion as DWORD
	dwDefinedVersion as DWORD
	dwEffectiveId as DWORD
	guidCustomVersion as GUID
end type

type NLSVERSIONINFOEX as _nlsversioninfoex
type LPNLSVERSIONINFOEX as _nlsversioninfoex ptr
type GEOID as LONG
type GEOTYPE as DWORD
type GEOCLASS as DWORD

#define GEOID_NOT_AVAILABLE (-1)

type SYSGEOTYPE as long
enum
	GEO_NATION = &h0001
	GEO_LATITUDE = &h0002
	GEO_LONGITUDE = &h0003
	GEO_ISO2 = &h0004
	GEO_ISO3 = &h0005
	GEO_RFC1766 = &h0006
	GEO_LCID = &h0007
	GEO_FRIENDLYNAME = &h0008
	GEO_OFFICIALNAME = &h0009
	GEO_TIMEZONES = &h000a
	GEO_OFFICIALLANGUAGES = &h000b
	GEO_ISO_UN_NUMBER = &h000c
	GEO_PARENT = &h000d
end enum

type SYSGEOCLASS as long
enum
	GEOCLASS_NATION = 16
	GEOCLASS_REGION = 14
	GEOCLASS_ALL = 0
end enum

type LANGUAGEGROUP_ENUMPROCA as function(byval as LGRPID, byval as LPSTR, byval as LPSTR, byval as DWORD, byval as LONG_PTR) as WINBOOL
type LANGGROUPLOCALE_ENUMPROCA as function(byval as LGRPID, byval as LCID, byval as LPSTR, byval as LONG_PTR) as WINBOOL
type UILANGUAGE_ENUMPROCA as function(byval as LPSTR, byval as LONG_PTR) as WINBOOL
type CODEPAGE_ENUMPROCA as function(byval as LPSTR) as WINBOOL
type DATEFMT_ENUMPROCA as function(byval as LPSTR) as WINBOOL
type DATEFMT_ENUMPROCEXA as function(byval as LPSTR, byval as CALID) as WINBOOL
type TIMEFMT_ENUMPROCA as function(byval as LPSTR) as WINBOOL
type CALINFO_ENUMPROCA as function(byval as LPSTR) as WINBOOL
type CALINFO_ENUMPROCEXA as function(byval as LPSTR, byval as CALID) as WINBOOL
type LOCALE_ENUMPROCA as function(byval as LPSTR) as WINBOOL
type LOCALE_ENUMPROCW as function(byval as LPWSTR) as WINBOOL
type LANGUAGEGROUP_ENUMPROCW as function(byval as LGRPID, byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as LONG_PTR) as WINBOOL
type LANGGROUPLOCALE_ENUMPROCW as function(byval as LGRPID, byval as LCID, byval as LPWSTR, byval as LONG_PTR) as WINBOOL
type UILANGUAGE_ENUMPROCW as function(byval as LPWSTR, byval as LONG_PTR) as WINBOOL
type CODEPAGE_ENUMPROCW as function(byval as LPWSTR) as WINBOOL
type DATEFMT_ENUMPROCW as function(byval as LPWSTR) as WINBOOL
type DATEFMT_ENUMPROCEXW as function(byval as LPWSTR, byval as CALID) as WINBOOL
type TIMEFMT_ENUMPROCW as function(byval as LPWSTR) as WINBOOL
type CALINFO_ENUMPROCW as function(byval as LPWSTR) as WINBOOL
type CALINFO_ENUMPROCEXW as function(byval as LPWSTR, byval as CALID) as WINBOOL
type GEO_ENUMPROC as function(byval as GEOID) as WINBOOL

#ifdef UNICODE
	#define LANGUAGEGROUP_ENUMPROC LANGUAGEGROUP_ENUMPROCW
	#define LANGGROUPLOCALE_ENUMPROC LANGGROUPLOCALE_ENUMPROCW
	#define UILANGUAGE_ENUMPROC UILANGUAGE_ENUMPROCW
	#define CODEPAGE_ENUMPROC CODEPAGE_ENUMPROCW
	#define DATEFMT_ENUMPROC DATEFMT_ENUMPROCW
	#define DATEFMT_ENUMPROCEX DATEFMT_ENUMPROCEXW
	#define TIMEFMT_ENUMPROC TIMEFMT_ENUMPROCW
	#define CALINFO_ENUMPROC CALINFO_ENUMPROCW
	#define CALINFO_ENUMPROCEX CALINFO_ENUMPROCEXW
	#define LOCALE_ENUMPROC LOCALE_ENUMPROCW
#else
	#define LANGUAGEGROUP_ENUMPROC LANGUAGEGROUP_ENUMPROCA
	#define LANGGROUPLOCALE_ENUMPROC LANGGROUPLOCALE_ENUMPROCA
	#define UILANGUAGE_ENUMPROC UILANGUAGE_ENUMPROCA
	#define CODEPAGE_ENUMPROC CODEPAGE_ENUMPROCA
	#define DATEFMT_ENUMPROC DATEFMT_ENUMPROCA
	#define DATEFMT_ENUMPROCEX DATEFMT_ENUMPROCEXA
	#define TIMEFMT_ENUMPROC TIMEFMT_ENUMPROCA
	#define CALINFO_ENUMPROC CALINFO_ENUMPROCA
	#define CALINFO_ENUMPROCEX CALINFO_ENUMPROCEXA
	#define LOCALE_ENUMPROC LOCALE_ENUMPROCA
#endif

type _FILEMUIINFO
	dwSize as DWORD
	dwVersion as DWORD
	dwFileType as DWORD
	pChecksum(0 to 15) as UBYTE
	pServiceChecksum(0 to 15) as UBYTE
	dwLanguageNameOffset as DWORD
	dwTypeIDMainSize as DWORD
	dwTypeIDMainOffset as DWORD
	dwTypeNameMainOffset as DWORD
	dwTypeIDMUISize as DWORD
	dwTypeIDMUIOffset as DWORD
	dwTypeNameMUIOffset as DWORD
	abBuffer(0 to 7) as UBYTE
end type

type FILEMUIINFO as _FILEMUIINFO
type PFILEMUIINFO as _FILEMUIINFO ptr

#define _APISETSTRING_

declare function CompareStringW(byval Locale as LCID, byval dwCmpFlags as DWORD, byval lpString1 as PCNZWCH, byval cchCount1 as long, byval lpString2 as PCNZWCH, byval cchCount2 as long) as long
declare function FoldStringW(byval dwMapFlags as DWORD, byval lpSrcStr as LPCWCH, byval cchSrc as long, byval lpDestStr as LPWSTR, byval cchDest as long) as long

#ifdef UNICODE
	#define CompareString CompareStringW
	#define FoldString FoldStringW
#endif

declare function GetStringTypeExW(byval Locale as LCID, byval dwInfoType as DWORD, byval lpSrcStr as LPCWCH, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL

#ifdef UNICODE
	#define GetStringTypeEx GetStringTypeExW
#endif

declare function GetStringTypeW(byval dwInfoType as DWORD, byval lpSrcStr as LPCWCH, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL
declare function MultiByteToWideChar(byval CodePage as UINT, byval dwFlags as DWORD, byval lpMultiByteStr as LPCCH, byval cbMultiByte as long, byval lpWideCharStr as LPWSTR, byval cchWideChar as long) as long
declare function WideCharToMultiByte(byval CodePage as UINT, byval dwFlags as DWORD, byval lpWideCharStr as LPCWCH, byval cchWideChar as long, byval lpMultiByteStr as LPSTR, byval cbMultiByte as long, byval lpDefaultChar as LPCCH, byval lpUsedDefaultChar as LPBOOL) as long

#define IS_HIGH_SURROGATE(wch) (((wch) >= HIGH_SURROGATE_START) andalso ((wch) <= HIGH_SURROGATE_END))
#define IS_LOW_SURROGATE(wch) (((wch) >= LOW_SURROGATE_START) andalso ((wch) <= LOW_SURROGATE_END))
#define IS_SURROGATE_PAIR(hs, ls) (IS_HIGH_SURROGATE(hs) andalso IS_LOW_SURROGATE(ls))
#define FILEMUIINFO_GET_CULTURE(pInfo) cast(LPWSTR, iif(pInfo->dwLanguageNameOffset > 0, cast(ULONG_PTR, pInfo) + pInfo->dwLanguageNameOffset, NULL))
#define FILEMUIINFO_GET_MAIN_TYPEIDS(pInfo) cptr(DWORD ptr, iif(pInfo->dwTypeIDMainOffset > 0, cast(ULONG_PTR, pInfo) + pInfo->dwTypeIDMainOffset, NULL))
#define FILEMUIINFO_GET_MAIN_TYPEID(pInfo, iType) iif((iType < pInfo->dwTypeIDMainSize) andalso (pInfo->dwTypeIDMainOffset > 0), *(cptr(DWORD ptr, cast(ULONG_PTR, pInfo) + pInfo->dwTypeIDMainOffset) + iType), 0)
#define FILEMUIINFO_GET_MAIN_TYPENAMES(pInfo) cast(LPWSTR, iif(pInfo->dwTypeNameMainOffset > 0, cast(ULONG_PTR, pInfo) + pInfo->dwTypeNameMainOffset, NULL))
#define FILEMUIINFO_GET_MUI_TYPEIDS(pInfo) cptr(DWORD ptr, iif(pInfo->dwTypeIDMUIOffset > 0, cast(ULONG_PTR, pInfo) + pInfo->dwTypeIDMUIOffset, NULL))
#define FILEMUIINFO_GET_MUI_TYPEID(pInfo, iType) iif((iType < pInfo->dwTypeIDMUISize) andalso (pInfo->dwTypeIDMUIOffset > 0), *(cptr(DWORD ptr, cast(ULONG_PTR, pInfo) + pInfo->dwTypeIDMUIOffset) + iType), 0)
#define FILEMUIINFO_GET_MUI_TYPENAMES(pInfo) cast(LPWSTR, iif(pInfo->dwTypeNameMUIOffset > 0, cast(ULONG_PTR, pInfo) + pInfo->dwTypeNameMUIOffset, NULL))

declare function IsValidCodePage(byval CodePage as UINT) as WINBOOL
declare function GetACP() as UINT
declare function GetOEMCP() as UINT
declare function CompareStringA(byval Locale as LCID, byval dwCmpFlags as DWORD, byval lpString1 as PCNZCH, byval cchCount1 as long, byval lpString2 as PCNZCH, byval cchCount2 as long) as long
declare function LCMapStringW(byval Locale as LCID, byval dwMapFlags as DWORD, byval lpSrcStr as LPCWSTR, byval cchSrc as long, byval lpDestStr as LPWSTR, byval cchDest as long) as long
declare function LCMapStringA(byval Locale as LCID, byval dwMapFlags as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpDestStr as LPSTR, byval cchDest as long) as long
declare function GetLocaleInfoW(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPWSTR, byval cchData as long) as long
declare function GetLocaleInfoA(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPSTR, byval cchData as long) as long
declare function IsDBCSLeadByte(byval TestChar as UBYTE) as WINBOOL
declare function IsDBCSLeadByteEx(byval CodePage as UINT, byval TestChar as UBYTE) as WINBOOL
declare function GetNumberFormatA(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCSTR, byval lpFormat as const NUMBERFMTA ptr, byval lpNumberStr as LPSTR, byval cchNumber as long) as long
declare function GetNumberFormatW(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCWSTR, byval lpFormat as const NUMBERFMTW ptr, byval lpNumberStr as LPWSTR, byval cchNumber as long) as long
declare function GetCurrencyFormatA(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCSTR, byval lpFormat as const CURRENCYFMTA ptr, byval lpCurrencyStr as LPSTR, byval cchCurrency as long) as long
declare function GetCurrencyFormatW(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCWSTR, byval lpFormat as const CURRENCYFMTW ptr, byval lpCurrencyStr as LPWSTR, byval cchCurrency as long) as long
declare function EnumCalendarInfoA(byval lpCalInfoEnumProc as CALINFO_ENUMPROCA, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
declare function EnumCalendarInfoW(byval lpCalInfoEnumProc as CALINFO_ENUMPROCW, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
declare function EnumCalendarInfoExA(byval lpCalInfoEnumProcEx as CALINFO_ENUMPROCEXA, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
declare function EnumCalendarInfoExW(byval lpCalInfoEnumProcEx as CALINFO_ENUMPROCEXW, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
declare function EnumTimeFormatsA(byval lpTimeFmtEnumProc as TIMEFMT_ENUMPROCA, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function EnumTimeFormatsW(byval lpTimeFmtEnumProc as TIMEFMT_ENUMPROCW, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function EnumDateFormatsA(byval lpDateFmtEnumProc as DATEFMT_ENUMPROCA, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function EnumDateFormatsW(byval lpDateFmtEnumProc as DATEFMT_ENUMPROCW, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function EnumDateFormatsExA(byval lpDateFmtEnumProcEx as DATEFMT_ENUMPROCEXA, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function EnumDateFormatsExW(byval lpDateFmtEnumProcEx as DATEFMT_ENUMPROCEXW, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function IsValidLanguageGroup(byval LanguageGroup as LGRPID, byval dwFlags as DWORD) as WINBOOL
declare function GetNLSVersion(byval Function as NLS_FUNCTION, byval Locale as LCID, byval lpVersionInformation as LPNLSVERSIONINFO) as WINBOOL
declare function IsNLSDefinedString(byval Function as NLS_FUNCTION, byval dwFlags as DWORD, byval lpVersionInformation as LPNLSVERSIONINFO, byval lpString as LPCWSTR, byval cchStr as INT_) as WINBOOL
declare function IsValidLocale(byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
declare function SetLocaleInfoA(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPCSTR) as WINBOOL
declare function SetLocaleInfoW(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPCWSTR) as WINBOOL
declare function GetCalendarInfoA(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPSTR, byval cchData as long, byval lpValue as LPDWORD) as long
declare function GetCalendarInfoW(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPWSTR, byval cchData as long, byval lpValue as LPDWORD) as long
declare function SetCalendarInfoA(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPCSTR) as WINBOOL
declare function SetCalendarInfoW(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPCWSTR) as WINBOOL

#ifdef UNICODE
	#define SetLocaleInfo SetLocaleInfoW
	#define GetCalendarInfo GetCalendarInfoW
	#define SetCalendarInfo SetCalendarInfoW
	#define LCMapString LCMapStringW
	#define GetLocaleInfo GetLocaleInfoW
	#define GetNumberFormat GetNumberFormatW
	#define GetCurrencyFormat GetCurrencyFormatW
	#define EnumCalendarInfo EnumCalendarInfoW
	#define EnumCalendarInfoEx EnumCalendarInfoExW
	#define EnumTimeFormats EnumTimeFormatsW
	#define EnumDateFormats EnumDateFormatsW
	#define EnumDateFormatsEx EnumDateFormatsExW
#else
	#define SetLocaleInfo SetLocaleInfoA
	#define GetCalendarInfo GetCalendarInfoA
	#define SetCalendarInfo SetCalendarInfoA
	#define CompareString CompareStringA
	#define LCMapString LCMapStringA
	#define GetLocaleInfo GetLocaleInfoA
	#define GetNumberFormat GetNumberFormatA
	#define GetCurrencyFormat GetCurrencyFormatA
	#define EnumCalendarInfo EnumCalendarInfoA
	#define EnumCalendarInfoEx EnumCalendarInfoExA
	#define EnumTimeFormats EnumTimeFormatsA
	#define EnumDateFormats EnumDateFormatsA
	#define EnumDateFormatsEx EnumDateFormatsExA
#endif

declare function GetGeoInfoA(byval Location as GEOID, byval GeoType as GEOTYPE, byval lpGeoData as LPSTR, byval cchData as long, byval LangId as LANGID) as long
declare function GetGeoInfoW(byval Location as GEOID, byval GeoType as GEOTYPE, byval lpGeoData as LPWSTR, byval cchData as long, byval LangId as LANGID) as long
declare function EnumSystemGeoID(byval GeoClass as GEOCLASS, byval ParentGeoId as GEOID, byval lpGeoEnumProc as GEO_ENUMPROC) as WINBOOL
declare function GetUserGeoID(byval GeoClass as GEOCLASS) as GEOID
declare function GetCPInfo(byval CodePage as UINT, byval lpCPInfo as LPCPINFO) as WINBOOL
declare function GetCPInfoExA(byval CodePage as UINT, byval dwFlags as DWORD, byval lpCPInfoEx as LPCPINFOEXA) as WINBOOL
declare function GetCPInfoExW(byval CodePage as UINT, byval dwFlags as DWORD, byval lpCPInfoEx as LPCPINFOEXW) as WINBOOL

#ifdef UNICODE
	#define GetGeoInfo GetGeoInfoW
	#define GetCPInfoEx GetCPInfoExW
#else
	#define GetGeoInfo GetGeoInfoA
	#define GetCPInfoEx GetCPInfoExA
#endif

declare function SetUserGeoID(byval GeoId as GEOID) as WINBOOL
declare function ConvertDefaultLocale(byval Locale as LCID) as LCID
declare function GetThreadLocale() as LCID
declare function SetThreadLocale(byval Locale as LCID) as WINBOOL
declare function GetSystemDefaultUILanguage() as LANGID
declare function GetUserDefaultUILanguage() as LANGID
declare function GetSystemDefaultLangID() as LANGID
declare function GetUserDefaultLangID() as LANGID
declare function GetSystemDefaultLCID() as LCID
declare function GetUserDefaultLCID() as LCID
declare function SetThreadUILanguage(byval LangId as LANGID) as LANGID
declare function GetStringTypeExA(byval Locale as LCID, byval dwInfoType as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL
declare function GetStringTypeA(byval Locale as LCID, byval dwInfoType as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL
declare function FoldStringA(byval dwMapFlags as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpDestStr as LPSTR, byval cchDest as long) as long
declare function EnumSystemLocalesA(byval lpLocaleEnumProc as LOCALE_ENUMPROCA, byval dwFlags as DWORD) as WINBOOL
declare function EnumSystemLocalesW(byval lpLocaleEnumProc as LOCALE_ENUMPROCW, byval dwFlags as DWORD) as WINBOOL
declare function EnumSystemLanguageGroupsA(byval lpLanguageGroupEnumProc as LANGUAGEGROUP_ENUMPROCA, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
declare function EnumSystemLanguageGroupsW(byval lpLanguageGroupEnumProc as LANGUAGEGROUP_ENUMPROCW, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
declare function EnumLanguageGroupLocalesA(byval lpLangGroupLocaleEnumProc as LANGGROUPLOCALE_ENUMPROCA, byval LanguageGroup as LGRPID, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
declare function EnumLanguageGroupLocalesW(byval lpLangGroupLocaleEnumProc as LANGGROUPLOCALE_ENUMPROCW, byval LanguageGroup as LGRPID, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
declare function EnumUILanguagesA(byval lpUILanguageEnumProc as UILANGUAGE_ENUMPROCA, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
declare function EnumUILanguagesW(byval lpUILanguageEnumProc as UILANGUAGE_ENUMPROCW, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL

#ifdef UNICODE
	#define EnumSystemLocales EnumSystemLocalesW
	#define EnumSystemLanguageGroups EnumSystemLanguageGroupsW
	#define EnumLanguageGroupLocales EnumLanguageGroupLocalesW
	#define EnumUILanguages EnumUILanguagesW
#else
	#define FoldString FoldStringA
	#define GetStringTypeEx GetStringTypeExA
	#define EnumSystemLocales EnumSystemLocalesA
	#define EnumSystemLanguageGroups EnumSystemLanguageGroupsA
	#define EnumLanguageGroupLocales EnumLanguageGroupLocalesA
	#define EnumUILanguages EnumUILanguagesA
#endif

declare function EnumSystemCodePagesA(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCA, byval dwFlags as DWORD) as WINBOOL
declare function EnumSystemCodePagesW(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCW, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	#define EnumSystemCodePages EnumSystemCodePagesW
#else
	#define EnumSystemCodePages EnumSystemCodePagesA
#endif

end extern
