''
''
'' winnls -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winnls_bi__
#define __win_winnls_bi__

#define MAX_LEADBYTES 12
#define MAX_DEFAULTCHAR 2
#define LOCALE_NOUSEROVERRIDE &h80000000
#define LOCALE_USE_CP_ACP &h40000000
#define LOCALE_RETURN_NUMBER &h20000000
#define LOCALE_ILANGUAGE 1
#define LOCALE_SLANGUAGE 2
#define LOCALE_SENGLANGUAGE &h1001
#define LOCALE_SABBREVLANGNAME 3
#define LOCALE_SNATIVELANGNAME 4
#define LOCALE_ICOUNTRY 5
#define LOCALE_SCOUNTRY 6
#define LOCALE_SENGCOUNTRY &h1002
#define LOCALE_SABBREVCTRYNAME 7
#define LOCALE_SNATIVECTRYNAME 8
#define LOCALE_IDEFAULTLANGUAGE 9
#define LOCALE_IDEFAULTCOUNTRY 10
#define LOCALE_IDEFAULTCODEPAGE 11
#define LOCALE_IDEFAULTANSICODEPAGE &h1004
#define LOCALE_SLIST 12
#define LOCALE_IMEASURE 13
#define LOCALE_SDECIMAL 14
#define LOCALE_STHOUSAND 15
#define LOCALE_SGROUPING 16
#define LOCALE_IDIGITS 17
#define LOCALE_ILZERO 18
#define LOCALE_INEGNUMBER &h1010
#define LOCALE_SNATIVEDIGITS 19
#define LOCALE_SCURRENCY 20
#define LOCALE_SINTLSYMBOL 21
#define LOCALE_SMONDECIMALSEP 22
#define LOCALE_SMONTHOUSANDSEP 23
#define LOCALE_SMONGROUPING 24
#define LOCALE_ICURRDIGITS 25
#define LOCALE_IINTLCURRDIGITS 26
#define LOCALE_ICURRENCY 27
#define LOCALE_INEGCURR 28
#define LOCALE_SDATE 29
#define LOCALE_STIME 30
#define LOCALE_SSHORTDATE 31
#define LOCALE_SLONGDATE 32
#define LOCALE_STIMEFORMAT &h1003
#define LOCALE_IDATE 33
#define LOCALE_ILDATE 34
#define LOCALE_ITIME 35
#define LOCALE_ITIMEMARKPOSN &h1005
#define LOCALE_ICENTURY 36
#define LOCALE_ITLZERO 37
#define LOCALE_IDAYLZERO 38
#define LOCALE_IMONLZERO 39
#define LOCALE_S1159 40
#define LOCALE_S2359 41
#define LOCALE_ICALENDARTYPE &h1009
#define LOCALE_IOPTIONALCALENDAR &h100B
#define LOCALE_IFIRSTDAYOFWEEK &h100C
#define LOCALE_IFIRSTWEEKOFYEAR &h100D
#define LOCALE_SDAYNAME1 42
#define LOCALE_SDAYNAME2 43
#define LOCALE_SDAYNAME3 44
#define LOCALE_SDAYNAME4 45
#define LOCALE_SDAYNAME5 46
#define LOCALE_SDAYNAME6 47
#define LOCALE_SDAYNAME7 48
#define LOCALE_SABBREVDAYNAME1 49
#define LOCALE_SABBREVDAYNAME2 50
#define LOCALE_SABBREVDAYNAME3 51
#define LOCALE_SABBREVDAYNAME4 52
#define LOCALE_SABBREVDAYNAME5 53
#define LOCALE_SABBREVDAYNAME6 54
#define LOCALE_SABBREVDAYNAME7 55
#define LOCALE_SMONTHNAME1 56
#define LOCALE_SMONTHNAME2 57
#define LOCALE_SMONTHNAME3 58
#define LOCALE_SMONTHNAME4 59
#define LOCALE_SMONTHNAME5 60
#define LOCALE_SMONTHNAME6 61
#define LOCALE_SMONTHNAME7 62
#define LOCALE_SMONTHNAME8 63
#define LOCALE_SMONTHNAME9 64
#define LOCALE_SMONTHNAME10 65
#define LOCALE_SMONTHNAME11 66
#define LOCALE_SMONTHNAME12 67
#define LOCALE_SMONTHNAME13 &h100E
#define LOCALE_SABBREVMONTHNAME1 68
#define LOCALE_SABBREVMONTHNAME2 69
#define LOCALE_SABBREVMONTHNAME3 70
#define LOCALE_SABBREVMONTHNAME4 71
#define LOCALE_SABBREVMONTHNAME5 72
#define LOCALE_SABBREVMONTHNAME6 73
#define LOCALE_SABBREVMONTHNAME7 74
#define LOCALE_SABBREVMONTHNAME8 75
#define LOCALE_SABBREVMONTHNAME9 76
#define LOCALE_SABBREVMONTHNAME10 77
#define LOCALE_SABBREVMONTHNAME11 78
#define LOCALE_SABBREVMONTHNAME12 79
#define LOCALE_SABBREVMONTHNAME13 &h100F
#define LOCALE_SPOSITIVESIGN 80
#define LOCALE_SNEGATIVESIGN 81
#define LOCALE_IPOSSIGNPOSN 82
#define LOCALE_INEGSIGNPOSN 83
#define LOCALE_IPOSSYMPRECEDES 84
#define LOCALE_IPOSSEPBYSPACE 85
#define LOCALE_INEGSYMPRECEDES 86
#define LOCALE_INEGSEPBYSPACE 87
#define LOCALE_FONTSIGNATURE 88
#define LOCALE_SISO639LANGNAME 89
#define LOCALE_SISO3166CTRYNAME 90
#define LOCALE_SYSTEM_DEFAULT &h800
#define LOCALE_USER_DEFAULT &h400
#define NORM_IGNORECASE 1
#define NORM_IGNOREKANATYPE 65536
#define NORM_IGNORENONSPACE 2
#define NORM_IGNORESYMBOLS 4
#define NORM_IGNOREWIDTH 131072
#define SORT_STRINGSORT 4096
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
#define ENUM_ALL_CALENDARS (-1)
#define DATE_SHORTDATE 1
#define DATE_LONGDATE 2
#define DATE_USE_ALT_CALENDAR 4
#define CP_INSTALLED 1
#define CP_SUPPORTED 2
#define LCID_INSTALLED 1
#define LCID_SUPPORTED 2
#define LCID_ALTERNATE_SORTS 4
#define MAP_FOLDCZONE 16
#define MAP_FOLDDIGITS 128
#define MAP_PRECOMPOSED 32
#define MAP_COMPOSITE 64
#define CP_ACP 0
#define CP_OEMCP 1
#define CP_MACCP 2
#define CP_THREAD_ACP 3
#define CP_SYMBOL 42
#define CP_UTF7 65000
#define CP_UTF8 65001
#define CT_CTYPE1 1
#define CT_CTYPE2 2
#define CT_CTYPE3 4
#define C1_UPPER 1
#define C1_LOWER 2
#define C1_DIGIT 4
#define C1_SPACE 8
#define C1_PUNCT 16
#define C1_CNTRL 32
#define C1_BLANK 64
#define C1_XDIGIT 128
#define C1_ALPHA 256
#define C2_LEFTTORIGHT 1
#define C2_RIGHTTOLEFT 2
#define C2_EUROPENUMBER 3
#define C2_EUROPESEPARATOR 4
#define C2_EUROPETERMINATOR 5
#define C2_ARABICNUMBER 6
#define C2_COMMONSEPARATOR 7
#define C2_BLOCKSEPARATOR 8
#define C2_SEGMENTSEPARATOR 9
#define C2_WHITESPACE 10
#define C2_OTHERNEUTRAL 11
#define C2_NOTAPPLICABLE 0
#define C3_NONSPACING 1
#define C3_DIACRITIC 2
#define C3_VOWELMARK 4
#define C3_SYMBOL 8
#define C3_KATAKANA 16
#define C3_HIRAGANA 32
#define C3_HALFWIDTH 64
#define C3_FULLWIDTH 128
#define C3_IDEOGRAPH 256
#define C3_KASHIDA 512
#define C3_LEXICAL 1024
#define C3_ALPHA 32768
#define C3_NOTAPPLICABLE 0
#define TIME_NOMINUTESORSECONDS 1
#define TIME_NOSECONDS 2
#define TIME_NOTIMEMARKER 4
#define TIME_FORCE24HOURFORMAT 8
#define MB_PRECOMPOSED 1
#define MB_COMPOSITE 2
#define MB_ERR_INVALID_CHARS 8
#define MB_USEGLYPHCHARS 4
#define WC_COMPOSITECHECK 512
#define WC_DISCARDNS 16
#define WC_SEPCHARS 32
#define WC_DEFAULTCHAR 64
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
#define CAL_ICALINTVALUE 1
#define CAL_SCALNAME 2
#define CAL_IYEAROFFSETRANGE 3
#define CAL_SERASTRING 4
#define CAL_SSHORTDATE 5
#define CAL_SLONGDATE 6
#define CAL_SDAYNAME1 7
#define CAL_SDAYNAME2 8
#define CAL_SDAYNAME3 9
#define CAL_SDAYNAME4 10
#define CAL_SDAYNAME5 11
#define CAL_SDAYNAME6 12
#define CAL_SDAYNAME7 13
#define CAL_SABBREVDAYNAME1 14
#define CAL_SABBREVDAYNAME2 15
#define CAL_SABBREVDAYNAME3 16
#define CAL_SABBREVDAYNAME4 17
#define CAL_SABBREVDAYNAME5 18
#define CAL_SABBREVDAYNAME6 19
#define CAL_SABBREVDAYNAME7 20
#define CAL_SMONTHNAME1 21
#define CAL_SMONTHNAME2 22
#define CAL_SMONTHNAME3 23
#define CAL_SMONTHNAME4 24
#define CAL_SMONTHNAME5 25
#define CAL_SMONTHNAME6 26
#define CAL_SMONTHNAME7 27
#define CAL_SMONTHNAME8 28
#define CAL_SMONTHNAME9 29
#define CAL_SMONTHNAME10 30
#define CAL_SMONTHNAME11 31
#define CAL_SMONTHNAME12 32
#define CAL_SMONTHNAME13 33
#define CAL_SABBREVMONTHNAME1 34
#define CAL_SABBREVMONTHNAME2 35
#define CAL_SABBREVMONTHNAME3 36
#define CAL_SABBREVMONTHNAME4 37
#define CAL_SABBREVMONTHNAME5 38
#define CAL_SABBREVMONTHNAME6 39
#define CAL_SABBREVMONTHNAME7 40
#define CAL_SABBREVMONTHNAME8 41
#define CAL_SABBREVMONTHNAME9 42
#define CAL_SABBREVMONTHNAME10 43
#define CAL_SABBREVMONTHNAME11 44
#define CAL_SABBREVMONTHNAME12 45
#define CAL_SABBREVMONTHNAME13 46
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
#define CSTR_LESS_THAN 1
#define CSTR_EQUAL 2
#define CSTR_GREATER_THAN 3
#define LGRPID_INSTALLED 1
#define LGRPID_SUPPORTED 2
#define LGRPID_WESTERN_EUROPE 1
#define LGRPID_CENTRAL_EUROPE 2
#define LGRPID_BALTIC 3
#define LGRPID_GREEK 4
#define LGRPID_CYRILLIC 5
#define LGRPID_TURKISH 6
#define LGRPID_JAPANESE 7
#define LGRPID_KOREAN 8
#define LGRPID_TRADITIONAL_CHINESE 9
#define LGRPID_SIMPLIFIED_CHINESE 10
#define LGRPID_THAI 11
#define LGRPID_HEBREW 12
#define LGRPID_ARABIC 13
#define LGRPID_VIETNAMESE 14
#define LGRPID_INDIC 15
#define LGRPID_GEORGIAN 16
#define LGRPID_ARMENIAN 17

type LCTYPE as DWORD
type CALTYPE as DWORD
type CALID as DWORD
type LGRPID as DWORD
type GEOID as DWORD
type GEOTYPE as DWORD
type GEOCLASS as DWORD
type CALINFO_ENUMPROCA as function (byval as LPSTR) as BOOL
type CALINFO_ENUMPROCW as function (byval as LPWSTR) as BOOL
type CALINFO_ENUMPROCEXA as function (byval as LPSTR, byval as CALID) as BOOL
type CALINFO_ENUMPROCEXW as function (byval as LPWSTR, byval as CALID) as BOOL
type LANGUAGEGROUP_ENUMPROCA as function (byval as LGRPID, byval as LPSTR, byval as LPSTR, byval as DWORD, byval as LONG_PTR) as BOOL
type LANGUAGEGROUP_ENUMPROCW as function (byval as LGRPID, byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as LONG_PTR) as BOOL
type LANGGROUPLOCALE_ENUMPROCA as function (byval as LGRPID, byval as LCID, byval as LPSTR, byval as LONG_PTR) as BOOL
type LANGGROUPLOCALE_ENUMPROCW as function (byval as LGRPID, byval as LCID, byval as LPWSTR, byval as LONG_PTR) as BOOL
type UILANGUAGE_ENUMPROCW as function (byval as LPWSTR, byval as LONG_PTR) as BOOL
type UILANGUAGE_ENUMPROCA as function (byval as LPSTR, byval as LONG_PTR) as BOOL
type LOCALE_ENUMPROCA as function (byval as LPSTR) as BOOL
type LOCALE_ENUMPROCW as function (byval as LPWSTR) as BOOL
type CODEPAGE_ENUMPROCA as function (byval as LPSTR) as BOOL
type CODEPAGE_ENUMPROCW as function (byval as LPWSTR) as BOOL
type DATEFMT_ENUMPROCA as function (byval as LPSTR) as BOOL
type DATEFMT_ENUMPROCW as function (byval as LPWSTR) as BOOL
type DATEFMT_ENUMPROCEXA as function (byval as LPSTR, byval as CALID) as BOOL
type DATEFMT_ENUMPROCEXW as function (byval as LPWSTR, byval as CALID) as BOOL
type TIMEFMT_ENUMPROCA as function (byval as LPSTR) as BOOL
type TIMEFMT_ENUMPROCW as function (byval as LPWSTR) as BOOL
type GEO_ENUMPROC as function(byval as GEOID) as BOOL

enum NLS_FUNCTION
	COMPARE_STRING = &h0001
end enum

enum SYSGEOCLASS
	GEOCLASS_NATION = 16
	GEOCLASS_REGION = 14
end enum

enum SYSGEOTYPE
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
	GEO_OFFICIALLANGUAGES = &h000a
end enum

type CPINFO
	MaxCharSize as UINT
	DefaultChar(0 to 2-1) as UBYTE
	LeadByte(0 to 12-1) as UBYTE
end type

type LPCPINFO as CPINFO ptr

#ifndef UNICODE
type CPINFOEXA
	MaxCharSize as UINT
	DefaultChar(0 to 2-1) as UBYTE
	LeadByte(0 to 12-1) as UBYTE
	UnicodeDefaultChar as WCHAR
	CodePage as UINT
	CodePageName as zstring * 260
end type

type LPCPINFOEXA as CPINFOEXA ptr

#else ''UNICODE
type CPINFOEXW
	MaxCharSize as UINT
	DefaultChar(0 to 2-1) as UBYTE
	LeadByte(0 to 12-1) as UBYTE
	UnicodeDefaultChar as WCHAR
	CodePage as UINT
	CodePageName as wstring * 260
end type

type LPCPINFOEXW as CPINFOEXW ptr
#endif ''UNICODE

#ifndef UNICODE
type CURRENCYFMTA
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPSTR
	lpThousandSep as LPSTR
	NegativeOrder as UINT
	PositiveOrder as UINT
	lpCurrencySymbol as LPSTR
end type

type LPCURRENCYFMTA as CURRENCYFMTA ptr

#else ''UNICODE
type CURRENCYFMTW
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPWSTR
	lpThousandSep as LPWSTR
	NegativeOrder as UINT
	PositiveOrder as UINT
	lpCurrencySymbol as LPWSTR
end type

type LPCURRENCYFMTW as CURRENCYFMTW ptr
#endif ''UNICODE

#ifndef UNICODE
type NUMBERFMTA
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPSTR
	lpThousandSep as LPSTR
	NegativeOrder as UINT
end type

type LPNUMBERFMTA as NUMBERFMTA ptr

#else ''UNICODE
type NUMBERFMTW
	NumDigits as UINT
	LeadingZero as UINT
	Grouping as UINT
	lpDecimalSep as LPWSTR
	lpThousandSep as LPWSTR
	NegativeOrder as UINT
end type

type LPNUMBERFMTW as NUMBERFMTW ptr
#endif ''UNICODE

type NLSVERSIONINFO
	dwNLSVersionInfoSize as DWORD
	dwNLSVersion as DWORD
	dwDefinedVersion as DWORD
end type

type LPNLSVERSIONINFO as NLSVERSIONINFO ptr

declare function ConvertDefaultLocale alias "ConvertDefaultLocale" (byval as LCID) as LCID
declare function EnumSystemGeoID alias "EnumSystemGeoID" (byval as GEOCLASS, byval as GEOID, byval as GEO_ENUMPROC) as BOOL
declare function GetACP alias "GetACP" () as UINT
declare function GetCPInfo alias "GetCPInfo" (byval as UINT, byval as LPCPINFO) as BOOL
declare function GetOEMCP alias "GetOEMCP" () as UINT
declare function GetSystemDefaultLangID alias "GetSystemDefaultLangID" () as LANGID
declare function GetSystemDefaultLCID alias "GetSystemDefaultLCID" () as LCID
declare function GetThreadLocale alias "GetThreadLocale" () as LCID
declare function GetUserDefaultLangID alias "GetUserDefaultLangID" () as LANGID
declare function GetUserDefaultLCID alias "GetUserDefaultLCID" () as LCID
declare function GetUserGeoID alias "GetUserGeoID" (byval as GEOCLASS) as GEOID
declare function IsDBCSLeadByte alias "IsDBCSLeadByte" (byval as UBYTE) as BOOL
declare function IsDBCSLeadByteEx alias "IsDBCSLeadByteEx" (byval as UINT, byval as UBYTE) as BOOL
declare function IsNLSDefinedString alias "IsNLSDefinedString" (byval as NLS_FUNCTION, byval as DWORD, byval as LPNLSVERSIONINFO, byval as LPCWSTR, byval as integer) as BOOL
declare function IsValidCodePage alias "IsValidCodePage" (byval as UINT) as BOOL
declare function IsValidLocale alias "IsValidLocale" (byval as LCID, byval as DWORD) as BOOL
declare function MultiByteToWideChar alias "MultiByteToWideChar" (byval as UINT, byval as DWORD, byval as LPCSTR, byval as integer, byval as LPWSTR, byval as integer) as integer
declare function SetThreadLocale alias "SetThreadLocale" (byval as LCID) as BOOL
declare function SetUserGeoID alias "SetUserGeoID" (byval as GEOID) as BOOL
declare function WideCharToMultiByte alias "WideCharToMultiByte" (byval as UINT, byval as DWORD, byval as LPCWSTR, byval as integer, byval as LPSTR, byval as integer, byval as LPCSTR, byval as LPBOOL) as integer

#ifdef UNICODE
type CPINFOEX as CPINFOEXW
type LPCPINFOEX as LPCPINFOEXW
type CURRENCYFMT as CURRENCYFMTW
type LPCURRENCYFMT as LPCURRENCYFMTW
type NUMBERFMT as NUMBERFMTW
type LPNUMBERFMT as LPNUMBERFMTW

#define CALINFO_ENUMPROC CALINFO_ENUMPROCW
#define CALINFO_ENUMPROCEX CALINFO_ENUMPROCEXW
#define LOCALE_ENUMPROC LOCALE_ENUMPROCW
#define CODEPAGE_ENUMPROC CODEPAGE_ENUMPROCW
#define DATEFMT_ENUMPROC DATEFMT_ENUMPROCW
#define DATEFMT_ENUMPROCEX DATEFMT_ENUMPROCEXW
#define TIMEFMT_ENUMPROC TIMEFMT_ENUMPROCW
#define LANGUAGEGROUP_ENUMPROC LANGUAGEGROUP_ENUMPROCW
#define LANGGROUPLOCALE_ENUMPROC LANGGROUPLOCALE_ENUMPROCW
#define UILANGUAGE_ENUMPROC UILANGUAGE_ENUMPROCW

declare function CompareString alias "CompareStringW" (byval as LCID, byval as DWORD, byval as LPCWSTR, byval as integer, byval as LPCWSTR, byval as integer) as integer
declare function EnumCalendarInfo alias "EnumCalendarInfoW" (byval as CALINFO_ENUMPROCW, byval as LCID, byval as CALID, byval as CALTYPE) as BOOL
declare function EnumDateFormats alias "EnumDateFormatsW" (byval as DATEFMT_ENUMPROCW, byval as LCID, byval as DWORD) as BOOL
declare function EnumSystemCodePages alias "EnumSystemCodePagesW" (byval as CODEPAGE_ENUMPROCW, byval as DWORD) as BOOL
declare function EnumSystemLocales alias "EnumSystemLocalesW" (byval as LOCALE_ENUMPROCW, byval as DWORD) as BOOL
declare function EnumTimeFormats alias "EnumTimeFormatsW" (byval as TIMEFMT_ENUMPROCW, byval as LCID, byval as DWORD) as BOOL
declare function FoldString alias "FoldStringW" (byval as DWORD, byval as LPCWSTR, byval as integer, byval as LPWSTR, byval as integer) as integer
declare function GetCPInfoEx alias "GetCPInfoExW" (byval as UINT, byval as DWORD, byval as LPCPINFOEXW) as BOOL
declare function GetCurrencyFormat alias "GetCurrencyFormatW" (byval as LCID, byval as DWORD, byval as LPCWSTR, byval as CURRENCYFMTW ptr, byval as LPWSTR, byval as integer) as integer
declare function GetDateFormat alias "GetDateFormatW" (byval as LCID, byval as DWORD, byval as SYSTEMTIME ptr, byval as LPCWSTR, byval as LPWSTR, byval as integer) as integer
declare function GetLocaleInfo alias "GetLocaleInfoW" (byval as LCID, byval as LCTYPE, byval as LPWSTR, byval as integer) as integer
declare function GetNumberFormat alias "GetNumberFormatW" (byval as LCID, byval as DWORD, byval as LPCWSTR, byval as NUMBERFMTW ptr, byval as LPWSTR, byval as integer) as integer
declare function GetStringType alias "GetStringTypeW" (byval as DWORD, byval as LPCWSTR, byval as integer, byval as LPWORD) as BOOL
declare function GetStringTypeEx alias "GetStringTypeExW" (byval as LCID, byval as DWORD, byval as LPCWSTR, byval as integer, byval as LPWORD) as BOOL
declare function GetTimeFormat alias "GetTimeFormatW" (byval as LCID, byval as DWORD, byval as SYSTEMTIME ptr, byval as LPCWSTR, byval as LPWSTR, byval as integer) as integer
declare function LCMapString alias "LCMapStringW" (byval as LCID, byval as DWORD, byval as LPCWSTR, byval as integer, byval as LPWSTR, byval as integer) as integer
declare function SetLocaleInfo alias "SetLocaleInfoW" (byval as LCID, byval as LCTYPE, byval as LPCWSTR) as BOOL

#else ''UNICODE
type CPINFOEX as CPINFOEXA
type LPCPINFOEX as LPCPINFOEXA
type CURRENCYFMT as CURRENCYFMTA
type LPCURRENCYFMT as LPCURRENCYFMTA
type NUMBERFMT as NUMBERFMTA
type LPNUMBERFMT as LPNUMBERFMTA

#define CALINFO_ENUMPROC CALINFO_ENUMPROCA
#define CALINFO_ENUMPROCEX CALINFO_ENUMPROCEXA
#define LOCALE_ENUMPROC LOCALE_ENUMPROCA
#define CODEPAGE_ENUMPROC CODEPAGE_ENUMPROCA
#define DATEFMT_ENUMPROC DATEFMT_ENUMPROCA
#define DATEFMT_ENUMPROCEX DATEFMT_ENUMPROCEXA
#define TIMEFMT_ENUMPROC TIMEFMT_ENUMPROCA
#define LANGUAGEGROUP_ENUMPROC LANGUAGEGROUP_ENUMPROCA
#define LANGGROUPLOCALE_ENUMPROC LANGGROUPLOCALE_ENUMPROCA
#define UILANGUAGE_ENUMPROC UILANGUAGE_ENUMPROCA

declare function CompareString alias "CompareStringA" (byval as LCID, byval as DWORD, byval as LPCSTR, byval as integer, byval as LPCSTR, byval as integer) as integer
declare function EnumCalendarInfo alias "EnumCalendarInfoA" (byval as CALINFO_ENUMPROCA, byval as LCID, byval as CALID, byval as CALTYPE) as BOOL
declare function EnumDateFormats alias "EnumDateFormatsA" (byval as DATEFMT_ENUMPROCA, byval as LCID, byval as DWORD) as BOOL
declare function EnumSystemCodePages alias "EnumSystemCodePagesA" (byval as CODEPAGE_ENUMPROCA, byval as DWORD) as BOOL
declare function EnumSystemLocales alias "EnumSystemLocalesA" (byval as LOCALE_ENUMPROCA, byval as DWORD) as BOOL
declare function EnumTimeFormats alias "EnumTimeFormatsA" (byval as TIMEFMT_ENUMPROCA, byval as LCID, byval as DWORD) as BOOL
declare function FoldString alias "FoldStringA" (byval as DWORD, byval as LPCSTR, byval as integer, byval as LPSTR, byval as integer) as integer
declare function GetCPInfoEx alias "GetCPInfoExA" (byval as UINT, byval as DWORD, byval as LPCPINFOEXA) as BOOL
declare function GetCurrencyFormat alias "GetCurrencyFormatA" (byval as LCID, byval as DWORD, byval as LPCSTR, byval as CURRENCYFMTA ptr, byval as LPSTR, byval as integer) as integer
declare function GetDateFormat alias "GetDateFormatA" (byval as LCID, byval as DWORD, byval as SYSTEMTIME ptr, byval as LPCSTR, byval as LPSTR, byval as integer) as integer
declare function GetLocaleInfo alias "GetLocaleInfoA" (byval as LCID, byval as LCTYPE, byval as LPSTR, byval as integer) as integer
declare function GetNumberFormat alias "GetNumberFormatA" (byval as LCID, byval as DWORD, byval as LPCSTR, byval as NUMBERFMTA ptr, byval as LPSTR, byval as integer) as integer
declare function GetStringType alias "GetStringTypeA" (byval as LCID, byval as DWORD, byval as LPCSTR, byval as integer, byval as LPWORD) as BOOL
declare function GetStringTypeEx alias "GetStringTypeExA" (byval as LCID, byval as DWORD, byval as LPCSTR, byval as integer, byval as LPWORD) as BOOL
declare function GetTimeFormat alias "GetTimeFormatA" (byval as LCID, byval as DWORD, byval as SYSTEMTIME ptr, byval as LPCSTR, byval as LPSTR, byval as integer) as integer
declare function LCMapString alias "LCMapStringA" (byval as LCID, byval as DWORD, byval as LPCSTR, byval as integer, byval as LPSTR, byval as integer) as integer
declare function SetLocaleInfo alias "SetLocaleInfoA" (byval as LCID, byval as LCTYPE, byval as LPCSTR) as BOOL
#endif ''UNICODE

#endif
