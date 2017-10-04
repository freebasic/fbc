'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
	declare function GetDateFormat alias "GetDateFormatW"(byval Locale as LCID, byval dwFlags as DWORD, byval lpDate as const SYSTEMTIME ptr, byval lpFormat as LPCWSTR, byval lpDateStr as LPWSTR, byval cchDate as long) as long
	declare function GetTimeFormat alias "GetTimeFormatW"(byval Locale as LCID, byval dwFlags as DWORD, byval lpTime as const SYSTEMTIME ptr, byval lpFormat as LPCWSTR, byval lpTimeStr as LPWSTR, byval cchTime as long) as long
#else
	declare function GetDateFormat alias "GetDateFormatA"(byval Locale as LCID, byval dwFlags as DWORD, byval lpDate as const SYSTEMTIME ptr, byval lpFormat as LPCSTR, byval lpDateStr as LPSTR, byval cchDate as long) as long
	declare function GetTimeFormat alias "GetTimeFormatA"(byval Locale as LCID, byval dwFlags as DWORD, byval lpTime as const SYSTEMTIME ptr, byval lpFormat as LPCSTR, byval lpTimeStr as LPSTR, byval cchTime as long) as long
#endif

const MAX_LEADBYTES = 12
const MAX_DEFAULTCHAR = 2
const HIGH_SURROGATE_START = &hd800
const HIGH_SURROGATE_END = &hdbff
const LOW_SURROGATE_START = &hdc00
const LOW_SURROGATE_END = &hdfff
const MB_PRECOMPOSED = &h00000001
const MB_COMPOSITE = &h00000002
const MB_USEGLYPHCHARS = &h00000004
const MB_ERR_INVALID_CHARS = &h00000008
const WC_DISCARDNS = &h00000010
const WC_SEPCHARS = &h00000020
const WC_DEFAULTCHAR = &h00000040

#if _WIN32_WINNT >= &h0600
	const WC_ERR_INVALID_CHARS = &h00000080
#endif

const WC_COMPOSITECHECK = &h00000200
const WC_NO_BEST_FIT_CHARS = &h00000400
const CT_CTYPE1 = &h00000001
const CT_CTYPE2 = &h00000002
const CT_CTYPE3 = &h00000004
const C1_UPPER = &h0001
const C1_LOWER = &h0002
const C1_DIGIT = &h0004
const C1_SPACE = &h0008
const C1_PUNCT = &h0010
const C1_CNTRL = &h0020
const C1_BLANK = &h0040
const C1_XDIGIT = &h0080
const C1_ALPHA = &h0100
const C1_DEFINED = &h0200
const C2_LEFTTORIGHT = &h0001
const C2_RIGHTTOLEFT = &h0002
const C2_EUROPENUMBER = &h0003
const C2_EUROPESEPARATOR = &h0004
const C2_EUROPETERMINATOR = &h0005
const C2_ARABICNUMBER = &h0006
const C2_COMMONSEPARATOR = &h0007
const C2_BLOCKSEPARATOR = &h0008
const C2_SEGMENTSEPARATOR = &h0009
const C2_WHITESPACE = &h000a
const C2_OTHERNEUTRAL = &h000b
const C2_NOTAPPLICABLE = &h0000
const C3_NONSPACING = &h0001
const C3_DIACRITIC = &h0002
const C3_VOWELMARK = &h0004
const C3_SYMBOL = &h0008
const C3_KATAKANA = &h0010
const C3_HIRAGANA = &h0020
const C3_HALFWIDTH = &h0040
const C3_FULLWIDTH = &h0080
const C3_IDEOGRAPH = &h0100
const C3_KASHIDA = &h0200
const C3_LEXICAL = &h0400
const C3_HIGHSURROGATE = &h0800
const C3_LOWSURROGATE = &h1000
const C3_ALPHA = &h8000
const C3_NOTAPPLICABLE = &h0000
const NORM_IGNORECASE = &h00000001
const NORM_IGNORENONSPACE = &h00000002
const NORM_IGNORESYMBOLS = &h00000004
const LINGUISTIC_IGNORECASE = &h00000010
const LINGUISTIC_IGNOREDIACRITIC = &h00000020
const NORM_IGNOREKANATYPE = &h00010000
const NORM_IGNOREWIDTH = &h00020000
const NORM_LINGUISTIC_CASING = &h08000000
const MAP_FOLDCZONE = &h00000010
const MAP_PRECOMPOSED = &h00000020
const MAP_COMPOSITE = &h00000040
const MAP_FOLDDIGITS = &h00000080
const MAP_EXPAND_LIGATURES = &h00002000
const LCMAP_LOWERCASE = &h00000100
const LCMAP_UPPERCASE = &h00000200

#if _WIN32_WINNT >= &h0601
	const LCMAP_TITLECASE = &h00000300
#endif

const LCMAP_SORTKEY = &h00000400
const LCMAP_BYTEREV = &h00000800
const LCMAP_HIRAGANA = &h00100000
const LCMAP_KATAKANA = &h00200000
const LCMAP_HALFWIDTH = &h00400000
const LCMAP_FULLWIDTH = &h00800000
const LCMAP_LINGUISTIC_CASING = &h01000000
const LCMAP_SIMPLIFIED_CHINESE = &h02000000
const LCMAP_TRADITIONAL_CHINESE = &h04000000

#if _WIN32_WINNT = &h0602
	const LCMAP_SORTHANDLE = &h20000000
	const LCMAP_HASH = &h00040000
#endif

const FIND_STARTSWITH = &h00100000
const FIND_ENDSWITH = &h00200000
const FIND_FROMSTART = &h00400000
const FIND_FROMEND = &h00800000
const LGRPID_INSTALLED = &h00000001
const LGRPID_SUPPORTED = &h00000002
const LCID_INSTALLED = &h00000001
const LCID_SUPPORTED = &h00000002
const LCID_ALTERNATE_SORTS = &h00000004

#if _WIN32_WINNT >= &h0600
	const LOCALE_ALL = 0
	const LOCALE_WINDOWS = &h00000001
	const LOCALE_SUPPLEMENTAL = &h00000002
	const LOCALE_ALTERNATE_SORTS = &h00000004
	const LOCALE_REPLACEMENT = &h00000008
#endif

#if _WIN32_WINNT >= &h0601
	const LOCALE_NEUTRALDATA = &h00000010
	const LOCALE_SPECIFICDATA = &h00000020
#endif

const CP_INSTALLED = &h00000001
const CP_SUPPORTED = &h00000002
const SORT_STRINGSORT = &h00001000

#if _WIN32_WINNT >= &h0601
	const SORT_DIGITSASNUMBERS = &h00000008
#endif

const CSTR_LESS_THAN = 1
const CSTR_EQUAL = 2
const CSTR_GREATER_THAN = 3
const CP_ACP = 0
const CP_OEMCP = 1
const CP_MACCP = 2
const CP_THREAD_ACP = 3
const CP_SYMBOL = 42
const CP_UTF7 = 65000
const CP_UTF8 = 65001
const CTRY_DEFAULT = 0
const CTRY_ALBANIA = 355
const CTRY_ALGERIA = 213
const CTRY_ARGENTINA = 54
const CTRY_ARMENIA = 374
const CTRY_AUSTRALIA = 61
const CTRY_AUSTRIA = 43
const CTRY_AZERBAIJAN = 994
const CTRY_BAHRAIN = 973
const CTRY_BELARUS = 375
const CTRY_BELGIUM = 32
const CTRY_BELIZE = 501
const CTRY_BOLIVIA = 591
const CTRY_BRAZIL = 55
const CTRY_BRUNEI_DARUSSALAM = 673
const CTRY_BULGARIA = 359
const CTRY_CANADA = 2
const CTRY_CARIBBEAN = 1
const CTRY_CHILE = 56
const CTRY_COLOMBIA = 57
const CTRY_COSTA_RICA = 506
const CTRY_CROATIA = 385
const CTRY_CZECH = 420
const CTRY_DENMARK = 45
const CTRY_DOMINICAN_REPUBLIC = 1
const CTRY_ECUADOR = 593
const CTRY_EGYPT = 20
const CTRY_EL_SALVADOR = 503
const CTRY_ESTONIA = 372
const CTRY_FAEROE_ISLANDS = 298
const CTRY_FINLAND = 358
const CTRY_FRANCE = 33
const CTRY_GEORGIA = 995
const CTRY_GERMANY = 49
const CTRY_GREECE = 30
const CTRY_GUATEMALA = 502
const CTRY_HONDURAS = 504
const CTRY_HONG_KONG = 852
const CTRY_HUNGARY = 36
const CTRY_ICELAND = 354
const CTRY_INDIA = 91
const CTRY_INDONESIA = 62
const CTRY_IRAN = 981
const CTRY_IRAQ = 964
const CTRY_IRELAND = 353
const CTRY_ISRAEL = 972
const CTRY_ITALY = 39
const CTRY_JAMAICA = 1
const CTRY_JAPAN = 81
const CTRY_JORDAN = 962
const CTRY_KAZAKSTAN = 7
const CTRY_KENYA = 254
const CTRY_KUWAIT = 965
const CTRY_KYRGYZSTAN = 996
const CTRY_LATVIA = 371
const CTRY_LEBANON = 961
const CTRY_LIBYA = 218
const CTRY_LIECHTENSTEIN = 41
const CTRY_LITHUANIA = 370
const CTRY_LUXEMBOURG = 352
const CTRY_MACAU = 853
const CTRY_MACEDONIA = 389
const CTRY_MALAYSIA = 60
const CTRY_MALDIVES = 960
const CTRY_MEXICO = 52
const CTRY_MONACO = 33
const CTRY_MONGOLIA = 976
const CTRY_MOROCCO = 212
const CTRY_NETHERLANDS = 31
const CTRY_NEW_ZEALAND = 64
const CTRY_NICARAGUA = 505
const CTRY_NORWAY = 47
const CTRY_OMAN = 968
const CTRY_PAKISTAN = 92
const CTRY_PANAMA = 507
const CTRY_PARAGUAY = 595
const CTRY_PERU = 51
const CTRY_PHILIPPINES = 63
const CTRY_POLAND = 48
const CTRY_PORTUGAL = 351
const CTRY_PRCHINA = 86
const CTRY_PUERTO_RICO = 1
const CTRY_QATAR = 974
const CTRY_ROMANIA = 40
const CTRY_RUSSIA = 7
const CTRY_SAUDI_ARABIA = 966
const CTRY_SERBIA = 381
const CTRY_SINGAPORE = 65
const CTRY_SLOVAK = 421
const CTRY_SLOVENIA = 386
const CTRY_SOUTH_AFRICA = 27
const CTRY_SOUTH_KOREA = 82
const CTRY_SPAIN = 34
const CTRY_SWEDEN = 46
const CTRY_SWITZERLAND = 41
const CTRY_SYRIA = 963
const CTRY_TAIWAN = 886
const CTRY_TATARSTAN = 7
const CTRY_THAILAND = 66
const CTRY_TRINIDAD_Y_TOBAGO = 1
const CTRY_TUNISIA = 216
const CTRY_TURKEY = 90
const CTRY_UAE = 971
const CTRY_UKRAINE = 380
const CTRY_UNITED_KINGDOM = 44
const CTRY_UNITED_STATES = 1
const CTRY_URUGUAY = 598
const CTRY_UZBEKISTAN = 7
const CTRY_VENEZUELA = 58
const CTRY_VIET_NAM = 84
const CTRY_YEMEN = 967
const CTRY_ZIMBABWE = 263
const LOCALE_SLOCALIZEDDISPLAYNAME = &h00000002

#if _WIN32_WINNT >= &h0601
	const LOCALE_ALLOW_NEUTRAL_NAMES = &h08000000
	const LOCALE_RETURN_GENITIVE_NAMES = &h10000000
#endif

const LOCALE_RETURN_NUMBER = &h20000000
const LOCALE_USE_CP_ACP = &h40000000
const LOCALE_NOUSEROVERRIDE = &h80000000

#if _WIN32_WINNT >= &h0601
	const LOCALE_SENGLISHDISPLAYNAME = &h00000072
	const LOCALE_SNATIVEDISPLAYNAME = &h00000073
#endif

#if _WIN32_WINNT >= &h0600
	const LOCALE_SLOCALIZEDLANGUAGENAME = &h0000006f
#endif

const LOCALE_SENGLISHLANGUAGENAME = &h00001001
const LOCALE_SNATIVELANGUAGENAME = &h00000004
const LOCALE_SLOCALIZEDCOUNTRYNAME = &h00000006
const LOCALE_SENGLISHCOUNTRYNAME = &h00001002
const LOCALE_SNATIVECOUNTRYNAME = &h00000008
const LOCALE_SLANGUAGE = &h00000002

#if _WIN32_WINNT >= &h0600
	const LOCALE_SLANGDISPLAYNAME = &h0000006f
#endif

const LOCALE_SENGLANGUAGE = &h00001001
const LOCALE_SNATIVELANGNAME = &h00000004
const LOCALE_SCOUNTRY = &h00000006
const LOCALE_SENGCOUNTRY = &h00001002
const LOCALE_SNATIVECTRYNAME = &h00000008
const LOCALE_ILANGUAGE = &h00000001
const LOCALE_SABBREVLANGNAME = &h00000003
const LOCALE_ICOUNTRY = &h00000005
const LOCALE_SABBREVCTRYNAME = &h00000007
const LOCALE_IGEOID = &h0000005b
const LOCALE_IDEFAULTLANGUAGE = &h00000009
const LOCALE_IDEFAULTCOUNTRY = &h0000000a
const LOCALE_IDEFAULTCODEPAGE = &h0000000b
const LOCALE_IDEFAULTANSICODEPAGE = &h00001004
const LOCALE_IDEFAULTMACCODEPAGE = &h00001011
const LOCALE_SLIST = &h0000000c
const LOCALE_IMEASURE = &h0000000d
const LOCALE_SDECIMAL = &h0000000e
const LOCALE_STHOUSAND = &h0000000f
const LOCALE_SGROUPING = &h00000010
const LOCALE_IDIGITS = &h00000011
const LOCALE_ILZERO = &h00000012
const LOCALE_INEGNUMBER = &h00001010
const LOCALE_SNATIVEDIGITS = &h00000013
const LOCALE_SCURRENCY = &h00000014
const LOCALE_SINTLSYMBOL = &h00000015
const LOCALE_SMONDECIMALSEP = &h00000016
const LOCALE_SMONTHOUSANDSEP = &h00000017
const LOCALE_SMONGROUPING = &h00000018
const LOCALE_ICURRDIGITS = &h00000019
const LOCALE_IINTLCURRDIGITS = &h0000001a
const LOCALE_ICURRENCY = &h0000001b
const LOCALE_INEGCURR = &h0000001c
const LOCALE_SDATE = &h0000001d
const LOCALE_STIME = &h0000001e
const LOCALE_SSHORTDATE = &h0000001f
const LOCALE_SLONGDATE = &h00000020
const LOCALE_STIMEFORMAT = &h00001003
const LOCALE_IDATE = &h00000021
const LOCALE_ILDATE = &h00000022
const LOCALE_ITIME = &h00000023
const LOCALE_ITIMEMARKPOSN = &h00001005
const LOCALE_ICENTURY = &h00000024
const LOCALE_ITLZERO = &h00000025
const LOCALE_IDAYLZERO = &h00000026
const LOCALE_IMONLZERO = &h00000027
const LOCALE_S1159 = &h00000028
const LOCALE_S2359 = &h00000029
const LOCALE_ICALENDARTYPE = &h00001009
const LOCALE_IOPTIONALCALENDAR = &h0000100b
const LOCALE_IFIRSTDAYOFWEEK = &h0000100c
const LOCALE_IFIRSTWEEKOFYEAR = &h0000100d
const LOCALE_SDAYNAME1 = &h0000002a
const LOCALE_SDAYNAME2 = &h0000002b
const LOCALE_SDAYNAME3 = &h0000002c
const LOCALE_SDAYNAME4 = &h0000002d
const LOCALE_SDAYNAME5 = &h0000002e
const LOCALE_SDAYNAME6 = &h0000002f
const LOCALE_SDAYNAME7 = &h00000030
const LOCALE_SABBREVDAYNAME1 = &h00000031
const LOCALE_SABBREVDAYNAME2 = &h00000032
const LOCALE_SABBREVDAYNAME3 = &h00000033
const LOCALE_SABBREVDAYNAME4 = &h00000034
const LOCALE_SABBREVDAYNAME5 = &h00000035
const LOCALE_SABBREVDAYNAME6 = &h00000036
const LOCALE_SABBREVDAYNAME7 = &h00000037
const LOCALE_SMONTHNAME1 = &h00000038
const LOCALE_SMONTHNAME2 = &h00000039
const LOCALE_SMONTHNAME3 = &h0000003a
const LOCALE_SMONTHNAME4 = &h0000003b
const LOCALE_SMONTHNAME5 = &h0000003c
const LOCALE_SMONTHNAME6 = &h0000003d
const LOCALE_SMONTHNAME7 = &h0000003e
const LOCALE_SMONTHNAME8 = &h0000003f
const LOCALE_SMONTHNAME9 = &h00000040
const LOCALE_SMONTHNAME10 = &h00000041
const LOCALE_SMONTHNAME11 = &h00000042
const LOCALE_SMONTHNAME12 = &h00000043
const LOCALE_SMONTHNAME13 = &h0000100e
const LOCALE_SABBREVMONTHNAME1 = &h00000044
const LOCALE_SABBREVMONTHNAME2 = &h00000045
const LOCALE_SABBREVMONTHNAME3 = &h00000046
const LOCALE_SABBREVMONTHNAME4 = &h00000047
const LOCALE_SABBREVMONTHNAME5 = &h00000048
const LOCALE_SABBREVMONTHNAME6 = &h00000049
const LOCALE_SABBREVMONTHNAME7 = &h0000004a
const LOCALE_SABBREVMONTHNAME8 = &h0000004b
const LOCALE_SABBREVMONTHNAME9 = &h0000004c
const LOCALE_SABBREVMONTHNAME10 = &h0000004d
const LOCALE_SABBREVMONTHNAME11 = &h0000004e
const LOCALE_SABBREVMONTHNAME12 = &h0000004f
const LOCALE_SABBREVMONTHNAME13 = &h0000100f
const LOCALE_SPOSITIVESIGN = &h00000050
const LOCALE_SNEGATIVESIGN = &h00000051
const LOCALE_IPOSSIGNPOSN = &h00000052
const LOCALE_INEGSIGNPOSN = &h00000053
const LOCALE_IPOSSYMPRECEDES = &h00000054
const LOCALE_IPOSSEPBYSPACE = &h00000055
const LOCALE_INEGSYMPRECEDES = &h00000056
const LOCALE_INEGSEPBYSPACE = &h00000057
const LOCALE_FONTSIGNATURE = &h00000058
const LOCALE_SISO639LANGNAME = &h00000059
const LOCALE_SISO3166CTRYNAME = &h0000005a
const LOCALE_IDEFAULTEBCDICCODEPAGE = &h00001012
const LOCALE_IPAPERSIZE = &h0000100a
const LOCALE_SENGCURRNAME = &h00001007
const LOCALE_SNATIVECURRNAME = &h00001008
const LOCALE_SYEARMONTH = &h00001006
const LOCALE_SSORTNAME = &h00001013
const LOCALE_IDIGITSUBSTITUTION = &h00001014

#if _WIN32_WINNT >= &h0600
	const LOCALE_SNAME = &h0000005c
	const LOCALE_SDURATION = &h0000005d
	const LOCALE_SKEYBOARDSTOINSTALL = &h0000005e
	const LOCALE_SSHORTESTDAYNAME1 = &h00000060
	const LOCALE_SSHORTESTDAYNAME2 = &h00000061
	const LOCALE_SSHORTESTDAYNAME3 = &h00000062
	const LOCALE_SSHORTESTDAYNAME4 = &h00000063
	const LOCALE_SSHORTESTDAYNAME5 = &h00000064
	const LOCALE_SSHORTESTDAYNAME6 = &h00000065
	const LOCALE_SSHORTESTDAYNAME7 = &h00000066
	const LOCALE_SISO639LANGNAME2 = &h00000067
	const LOCALE_SISO3166CTRYNAME2 = &h00000068
	const LOCALE_SNAN = &h00000069
	const LOCALE_SPOSINFINITY = &h0000006a
	const LOCALE_SNEGINFINITY = &h0000006b
	const LOCALE_SSCRIPTS = &h0000006c
	const LOCALE_SPARENT = &h0000006d
	const LOCALE_SCONSOLEFALLBACKNAME = &h0000006e
#endif

#if _WIN32_WINNT >= &h0601
	const LOCALE_IREADINGLAYOUT = &h00000070
	const LOCALE_INEUTRAL = &h00000071
	const LOCALE_INEGATIVEPERCENT = &h00000074
	const LOCALE_IPOSITIVEPERCENT = &h00000075
	const LOCALE_SPERCENT = &h00000076
	const LOCALE_SPERMILLE = &h00000077
	const LOCALE_SMONTHDAY = &h00000078
	const LOCALE_SSHORTTIME = &h00000079
	const LOCALE_SOPENTYPELANGUAGETAG = &h0000007a
	const LOCALE_SSORTLOCALE = &h0000007b
#endif

const TIME_NOMINUTESORSECONDS = &h00000001
const TIME_NOSECONDS = &h00000002
const TIME_NOTIMEMARKER = &h00000004
const TIME_FORCE24HOURFORMAT = &h00000008
const DATE_SHORTDATE = &h00000001
const DATE_LONGDATE = &h00000002
const DATE_USE_ALT_CALENDAR = &h00000004
const DATE_YEARMONTH = &h00000008
const DATE_LTRREADING = &h00000010
const DATE_RTLREADING = &h00000020

#if _WIN32_WINNT >= &h0601
	const DATE_AUTOLAYOUT = &h00000040
#endif

const CAL_NOUSEROVERRIDE = LOCALE_NOUSEROVERRIDE
const CAL_USE_CP_ACP = LOCALE_USE_CP_ACP
const CAL_RETURN_NUMBER = LOCALE_RETURN_NUMBER

#if _WIN32_WINNT >= &h0601
	const CAL_RETURN_GENITIVE_NAMES = LOCALE_RETURN_GENITIVE_NAMES
#endif

const CAL_ICALINTVALUE = &h00000001
const CAL_SCALNAME = &h00000002
const CAL_IYEAROFFSETRANGE = &h00000003
const CAL_SERASTRING = &h00000004
const CAL_SSHORTDATE = &h00000005
const CAL_SLONGDATE = &h00000006
const CAL_SDAYNAME1 = &h00000007
const CAL_SDAYNAME2 = &h00000008
const CAL_SDAYNAME3 = &h00000009
const CAL_SDAYNAME4 = &h0000000a
const CAL_SDAYNAME5 = &h0000000b
const CAL_SDAYNAME6 = &h0000000c
const CAL_SDAYNAME7 = &h0000000d
const CAL_SABBREVDAYNAME1 = &h0000000e
const CAL_SABBREVDAYNAME2 = &h0000000f
const CAL_SABBREVDAYNAME3 = &h00000010
const CAL_SABBREVDAYNAME4 = &h00000011
const CAL_SABBREVDAYNAME5 = &h00000012
const CAL_SABBREVDAYNAME6 = &h00000013
const CAL_SABBREVDAYNAME7 = &h00000014
const CAL_SMONTHNAME1 = &h00000015
const CAL_SMONTHNAME2 = &h00000016
const CAL_SMONTHNAME3 = &h00000017
const CAL_SMONTHNAME4 = &h00000018
const CAL_SMONTHNAME5 = &h00000019
const CAL_SMONTHNAME6 = &h0000001a
const CAL_SMONTHNAME7 = &h0000001b
const CAL_SMONTHNAME8 = &h0000001c
const CAL_SMONTHNAME9 = &h0000001d
const CAL_SMONTHNAME10 = &h0000001e
const CAL_SMONTHNAME11 = &h0000001f
const CAL_SMONTHNAME12 = &h00000020
const CAL_SMONTHNAME13 = &h00000021
const CAL_SABBREVMONTHNAME1 = &h00000022
const CAL_SABBREVMONTHNAME2 = &h00000023
const CAL_SABBREVMONTHNAME3 = &h00000024
const CAL_SABBREVMONTHNAME4 = &h00000025
const CAL_SABBREVMONTHNAME5 = &h00000026
const CAL_SABBREVMONTHNAME6 = &h00000027
const CAL_SABBREVMONTHNAME7 = &h00000028
const CAL_SABBREVMONTHNAME8 = &h00000029
const CAL_SABBREVMONTHNAME9 = &h0000002a
const CAL_SABBREVMONTHNAME10 = &h0000002b
const CAL_SABBREVMONTHNAME11 = &h0000002c
const CAL_SABBREVMONTHNAME12 = &h0000002d
const CAL_SABBREVMONTHNAME13 = &h0000002e
const CAL_SYEARMONTH = &h0000002f
const CAL_ITWODIGITYEARMAX = &h00000030

#if _WIN32_WINNT >= &h0600
	const CAL_SSHORTESTDAYNAME1 = &h00000031
	const CAL_SSHORTESTDAYNAME2 = &h00000032
	const CAL_SSHORTESTDAYNAME3 = &h00000033
	const CAL_SSHORTESTDAYNAME4 = &h00000034
	const CAL_SSHORTESTDAYNAME5 = &h00000035
	const CAL_SSHORTESTDAYNAME6 = &h00000036
	const CAL_SSHORTESTDAYNAME7 = &h00000037
#endif

#if _WIN32_WINNT >= &h0601
	const CAL_SMONTHDAY = &h00000038
	const CAL_SABBREVERASTRING = &h00000039
#endif

const ENUM_ALL_CALENDARS = &hffffffff
const CAL_GREGORIAN = 1
const CAL_GREGORIAN_US = 2
const CAL_JAPAN = 3
const CAL_TAIWAN = 4
const CAL_KOREA = 5
const CAL_HIJRI = 6
const CAL_THAI = 7
const CAL_HEBREW = 8
const CAL_GREGORIAN_ME_FRENCH = 9
const CAL_GREGORIAN_ARABIC = 10
const CAL_GREGORIAN_XLIT_ENGLISH = 11
const CAL_GREGORIAN_XLIT_FRENCH = 12
const CAL_UMALQURA = 23
const LGRPID_WESTERN_EUROPE = &h0001
const LGRPID_CENTRAL_EUROPE = &h0002
const LGRPID_BALTIC = &h0003
const LGRPID_GREEK = &h0004
const LGRPID_CYRILLIC = &h0005
const LGRPID_TURKIC = &h0006
const LGRPID_TURKISH = &h0006
const LGRPID_JAPANESE = &h0007
const LGRPID_KOREAN = &h0008
const LGRPID_TRADITIONAL_CHINESE = &h0009
const LGRPID_SIMPLIFIED_CHINESE = &h000a
const LGRPID_THAI = &h000b
const LGRPID_HEBREW = &h000c
const LGRPID_ARABIC = &h000d
const LGRPID_VIETNAMESE = &h000e
const LGRPID_INDIC = &h000f
const LGRPID_GEORGIAN = &h0010
const LGRPID_ARMENIAN = &h0011

#if _WIN32_WINNT >= &h0600
	const MUI_LANGUAGE_ID = &h4
	const MUI_LANGUAGE_NAME = &h8
	const MUI_MERGE_SYSTEM_FALLBACK = &h10
	const MUI_MERGE_USER_FALLBACK = &h20
	const MUI_UI_FALLBACK = MUI_MERGE_SYSTEM_FALLBACK or MUI_MERGE_USER_FALLBACK
	const MUI_THREAD_LANGUAGES = &h40
	const MUI_CONSOLE_FILTER = &h100
	const MUI_COMPLEX_SCRIPT_FILTER = &h200
	const MUI_RESET_FILTERS = &h001
	const MUI_USER_PREFERRED_UI_LANGUAGES = &h10
	const MUI_USE_INSTALLED_LANGUAGES = &h20
	const MUI_USE_SEARCH_ALL_LANGUAGES = &h40
	const MUI_LANG_NEUTRAL_PE_FILE = &h100
	const MUI_NON_LANG_NEUTRAL_FILE = &h200
	const MUI_MACHINE_LANGUAGE_SETTINGS = &h400
	const MUI_FILETYPE_NOT_LANGUAGE_NEUTRAL = &h001
	const MUI_FILETYPE_LANGUAGE_NEUTRAL_MAIN = &h002
	const MUI_FILETYPE_LANGUAGE_NEUTRAL_MUI = &h004
	const MUI_QUERY_TYPE = &h001
	const MUI_QUERY_CHECKSUM = &h002
	const MUI_QUERY_LANGUAGE_NAME = &h004
	const MUI_QUERY_RESOURCE_TYPES = &h008
	const MUI_FILEINFO_VERSION = &h001
	const MUI_FULL_LANGUAGE = &h01
	const MUI_PARTIAL_LANGUAGE = &h02
	const MUI_LIP_LANGUAGE = &h04
	const MUI_LANGUAGE_INSTALLED = &h20
	const MUI_LANGUAGE_LICENSED = &h40
	#define MUI_CALLBACK_ALL_FLAGS MUI_CALLBACK_FLAG_UPGRADED_INSTALLATION
#endif

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
	UnicodeDefaultChar as WCHAR
	CodePage as UINT
	CodePageName as zstring * 260
end type

type CPINFOEXA as _cpinfoexA
type LPCPINFOEXA as _cpinfoexA ptr

type _cpinfoexW
	MaxCharSize as UINT
	DefaultChar(0 to 1) as UBYTE
	LeadByte(0 to 11) as UBYTE
	UnicodeDefaultChar as WCHAR
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

	#if _WIN32_WINNT = &h0602
		dwEffectiveId as DWORD
		guidCustomVersion as GUID
	#endif
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
const GEOID_NOT_AVAILABLE = -1

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

#if _WIN32_WINNT >= &h0600
	type _NORM_FORM as long
	enum
		NormalizationOther = 0
		NormalizationC = &h1
		NormalizationD = &h2
		NormalizationKC = &h5
		NormalizationKD = &h6
	end enum

	type NORM_FORM as _NORM_FORM
	const IDN_ALLOW_UNASSIGNED = &h01
	const IDN_USE_STD3_ASCII_RULES = &h02
	const IDN_EMAIL_ADDRESS = &h04
	const IDN_RAW_PUNYCODE = &h08
	const VS_ALLOW_LATIN = &h0001
	const GSS_ALLOW_INHERITED_COMMON = &h0001
#endif

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
	type LANGUAGEGROUP_ENUMPROC as LANGUAGEGROUP_ENUMPROCW
	type LANGGROUPLOCALE_ENUMPROC as LANGGROUPLOCALE_ENUMPROCW
	type UILANGUAGE_ENUMPROC as UILANGUAGE_ENUMPROCW
	type CODEPAGE_ENUMPROC as CODEPAGE_ENUMPROCW
	type DATEFMT_ENUMPROC as DATEFMT_ENUMPROCW
	type DATEFMT_ENUMPROCEX as DATEFMT_ENUMPROCEXW
	type TIMEFMT_ENUMPROC as TIMEFMT_ENUMPROCW
	type CALINFO_ENUMPROC as CALINFO_ENUMPROCW
	type CALINFO_ENUMPROCEX as CALINFO_ENUMPROCEXW
	type LOCALE_ENUMPROC as LOCALE_ENUMPROCW
#else
	type LANGUAGEGROUP_ENUMPROC as LANGUAGEGROUP_ENUMPROCA
	type LANGGROUPLOCALE_ENUMPROC as LANGGROUPLOCALE_ENUMPROCA
	type UILANGUAGE_ENUMPROC as UILANGUAGE_ENUMPROCA
	type CODEPAGE_ENUMPROC as CODEPAGE_ENUMPROCA
	type DATEFMT_ENUMPROC as DATEFMT_ENUMPROCA
	type DATEFMT_ENUMPROCEX as DATEFMT_ENUMPROCEXA
	type TIMEFMT_ENUMPROC as TIMEFMT_ENUMPROCA
	type CALINFO_ENUMPROC as CALINFO_ENUMPROCA
	type CALINFO_ENUMPROCEX as CALINFO_ENUMPROCEXA
	type LOCALE_ENUMPROC as LOCALE_ENUMPROCA
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
	declare function CompareString alias "CompareStringW"(byval Locale as LCID, byval dwCmpFlags as DWORD, byval lpString1 as PCNZWCH, byval cchCount1 as long, byval lpString2 as PCNZWCH, byval cchCount2 as long) as long
	declare function FoldString alias "FoldStringW"(byval dwMapFlags as DWORD, byval lpSrcStr as LPCWCH, byval cchSrc as long, byval lpDestStr as LPWSTR, byval cchDest as long) as long
#endif

declare function GetStringTypeExW(byval Locale as LCID, byval dwInfoType as DWORD, byval lpSrcStr as LPCWCH, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function CompareStringEx(byval lpLocaleName as LPCWSTR, byval dwCmpFlags as DWORD, byval lpString1 as LPCWCH, byval cchCount1 as long, byval lpString2 as LPCWCH, byval cchCount2 as long, byval lpVersionInformation as LPNLSVERSIONINFO, byval lpReserved as LPVOID, byval lParam as LPARAM) as long
	declare function CompareStringOrdinal(byval lpString1 as LPCWCH, byval cchCount1 as long, byval lpString2 as LPCWCH, byval cchCount2 as long, byval bIgnoreCase as WINBOOL) as long
#endif

#ifdef UNICODE
	declare function GetStringTypeEx alias "GetStringTypeExW"(byval Locale as LCID, byval dwInfoType as DWORD, byval lpSrcStr as LPCWCH, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL
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

#if _WIN32_WINNT >= &h0600
	declare function GetDurationFormat(byval Locale as LCID, byval dwFlags as DWORD, byval lpDuration as const SYSTEMTIME ptr, byval ullDuration as ULONGLONG, byval lpFormat as LPCWSTR, byval lpDurationStr as LPWSTR, byval cchDuration as long) as long
	declare function FindNLSString(byval Locale as LCID, byval dwFindNLSStringFlags as DWORD, byval lpStringSource as LPCWSTR, byval cchSource as long, byval lpStringValue as LPCWSTR, byval cchValue as long, byval pcchFound as LPINT) as long
#endif

#if _WIN32_WINNT >= &h0601
	declare function LoadStringByReference(byval Flags as DWORD, byval Language as PCWSTR, byval SourceString as PCWSTR, byval Buffer as PWSTR, byval cchBuffer as ULONG, byval Directory as PCWSTR, byval pcchBufferOut as PULONG) as WINBOOL
#endif

#ifdef UNICODE
	declare function SetLocaleInfo alias "SetLocaleInfoW"(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPCWSTR) as WINBOOL
	declare function GetCalendarInfo alias "GetCalendarInfoW"(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPWSTR, byval cchData as long, byval lpValue as LPDWORD) as long
	declare function SetCalendarInfo alias "SetCalendarInfoW"(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPCWSTR) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0601)
	declare function SetLocaleInfo alias "SetLocaleInfoA"(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPCSTR) as WINBOOL
	declare function GetCalendarInfo alias "GetCalendarInfoA"(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPSTR, byval cchData as long, byval lpValue as LPDWORD) as long
	declare function SetCalendarInfo alias "SetCalendarInfoA"(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPCSTR) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	const MUI_FORMAT_REG_COMPAT = &h0001
	const MUI_FORMAT_INF_COMPAT = &h0002
	const MUI_VERIFY_FILE_EXISTS = &h0004
	const MUI_SKIP_STRING_CACHE = &h0008
	const MUI_IMMUTABLE_LOOKUP = &h0010
#endif

#ifdef UNICODE
	declare function LCMapString alias "LCMapStringW"(byval Locale as LCID, byval dwMapFlags as DWORD, byval lpSrcStr as LPCWSTR, byval cchSrc as long, byval lpDestStr as LPWSTR, byval cchDest as long) as long
	declare function GetLocaleInfo alias "GetLocaleInfoW"(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPWSTR, byval cchData as long) as long
	declare function GetNumberFormat alias "GetNumberFormatW"(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCWSTR, byval lpFormat as const NUMBERFMTW ptr, byval lpNumberStr as LPWSTR, byval cchNumber as long) as long
	declare function GetCurrencyFormat alias "GetCurrencyFormatW"(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCWSTR, byval lpFormat as const CURRENCYFMTW ptr, byval lpCurrencyStr as LPWSTR, byval cchCurrency as long) as long
	declare function EnumCalendarInfo alias "EnumCalendarInfoW"(byval lpCalInfoEnumProc as CALINFO_ENUMPROCW, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
	declare function EnumCalendarInfoEx alias "EnumCalendarInfoExW"(byval lpCalInfoEnumProcEx as CALINFO_ENUMPROCEXW, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
	declare function EnumTimeFormats alias "EnumTimeFormatsW"(byval lpTimeFmtEnumProc as TIMEFMT_ENUMPROCW, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
	declare function EnumDateFormats alias "EnumDateFormatsW"(byval lpDateFmtEnumProc as DATEFMT_ENUMPROCW, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
	declare function EnumDateFormatsEx alias "EnumDateFormatsExW"(byval lpDateFmtEnumProcEx as DATEFMT_ENUMPROCEXW, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0600)
	declare function SetLocaleInfo alias "SetLocaleInfoA"(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPCSTR) as WINBOOL
	declare function GetCalendarInfo alias "GetCalendarInfoA"(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPSTR, byval cchData as long, byval lpValue as LPDWORD) as long
	declare function SetCalendarInfo alias "SetCalendarInfoA"(byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE, byval lpCalData as LPCSTR) as WINBOOL
#endif

#ifndef UNICODE
	declare function CompareString alias "CompareStringA"(byval Locale as LCID, byval dwCmpFlags as DWORD, byval lpString1 as PCNZCH, byval cchCount1 as long, byval lpString2 as PCNZCH, byval cchCount2 as long) as long
	declare function LCMapString alias "LCMapStringA"(byval Locale as LCID, byval dwMapFlags as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpDestStr as LPSTR, byval cchDest as long) as long
	declare function GetLocaleInfo alias "GetLocaleInfoA"(byval Locale as LCID, byval LCType as LCTYPE, byval lpLCData as LPSTR, byval cchData as long) as long
	declare function GetNumberFormat alias "GetNumberFormatA"(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCSTR, byval lpFormat as const NUMBERFMTA ptr, byval lpNumberStr as LPSTR, byval cchNumber as long) as long
	declare function GetCurrencyFormat alias "GetCurrencyFormatA"(byval Locale as LCID, byval dwFlags as DWORD, byval lpValue as LPCSTR, byval lpFormat as const CURRENCYFMTA ptr, byval lpCurrencyStr as LPSTR, byval cchCurrency as long) as long
	declare function EnumCalendarInfo alias "EnumCalendarInfoA"(byval lpCalInfoEnumProc as CALINFO_ENUMPROCA, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
	declare function EnumCalendarInfoEx alias "EnumCalendarInfoExA"(byval lpCalInfoEnumProcEx as CALINFO_ENUMPROCEXA, byval Locale as LCID, byval Calendar as CALID, byval CalType as CALTYPE) as WINBOOL
	declare function EnumTimeFormats alias "EnumTimeFormatsA"(byval lpTimeFmtEnumProc as TIMEFMT_ENUMPROCA, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
	declare function EnumDateFormats alias "EnumDateFormatsA"(byval lpDateFmtEnumProc as DATEFMT_ENUMPROCA, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
	declare function EnumDateFormatsEx alias "EnumDateFormatsExA"(byval lpDateFmtEnumProcEx as DATEFMT_ENUMPROCEXA, byval Locale as LCID, byval dwFlags as DWORD) as WINBOOL
#endif

declare function GetGeoInfoA(byval Location as GEOID, byval GeoType as GEOTYPE, byval lpGeoData as LPSTR, byval cchData as long, byval LangId as LANGID) as long
declare function GetGeoInfoW(byval Location as GEOID, byval GeoType as GEOTYPE, byval lpGeoData as LPWSTR, byval cchData as long, byval LangId as LANGID) as long
declare function EnumSystemGeoID(byval GeoClass as GEOCLASS, byval ParentGeoId as GEOID, byval lpGeoEnumProc as GEO_ENUMPROC) as WINBOOL
declare function GetUserGeoID(byval GeoClass as GEOCLASS) as GEOID
declare function GetCPInfo(byval CodePage as UINT, byval lpCPInfo as LPCPINFO) as WINBOOL
declare function GetCPInfoExA(byval CodePage as UINT, byval dwFlags as DWORD, byval lpCPInfoEx as LPCPINFOEXA) as WINBOOL
declare function GetCPInfoExW(byval CodePage as UINT, byval dwFlags as DWORD, byval lpCPInfoEx as LPCPINFOEXW) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function LCIDToLocaleName(byval Locale as LCID, byval lpName as LPWSTR, byval cchName as long, byval dwFlags as DWORD) as long
	declare function LocaleNameToLCID(byval lpName as LPCWSTR, byval dwFlags as DWORD) as LCID
#endif

#ifdef UNICODE
	declare function GetGeoInfo alias "GetGeoInfoW"(byval Location as GEOID, byval GeoType as GEOTYPE, byval lpGeoData as LPWSTR, byval cchData as long, byval LangId as LANGID) as long
	declare function GetCPInfoEx alias "GetCPInfoExW"(byval CodePage as UINT, byval dwFlags as DWORD, byval lpCPInfoEx as LPCPINFOEXW) as WINBOOL
#else
	declare function GetGeoInfo alias "GetGeoInfoA"(byval Location as GEOID, byval GeoType as GEOTYPE, byval lpGeoData as LPSTR, byval cchData as long, byval LangId as LANGID) as long
	declare function GetCPInfoEx alias "GetCPInfoExA"(byval CodePage as UINT, byval dwFlags as DWORD, byval lpCPInfoEx as LPCPINFOEXA) as WINBOOL
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

#if _WIN32_WINNT >= &h0600
	declare function GetThreadUILanguage() as LANGID
	declare function GetProcessPreferredUILanguages(byval dwFlags as DWORD, byval pulNumLanguages as PULONG, byval pwszLanguagesBuffer as PZZWSTR, byval pcchLanguagesBuffer as PULONG) as WINBOOL
	declare function SetProcessPreferredUILanguages(byval dwFlags as DWORD, byval pwszLanguagesBuffer as PCZZWSTR, byval pulNumLanguages as PULONG) as WINBOOL
	declare function GetUserPreferredUILanguages(byval dwFlags as DWORD, byval pulNumLanguages as PULONG, byval pwszLanguagesBuffer as PZZWSTR, byval pcchLanguagesBuffer as PULONG) as WINBOOL
	declare function GetSystemPreferredUILanguages(byval dwFlags as DWORD, byval pulNumLanguages as PULONG, byval pwszLanguagesBuffer as PZZWSTR, byval pcchLanguagesBuffer as PULONG) as WINBOOL
	declare function GetThreadPreferredUILanguages(byval dwFlags as DWORD, byval pulNumLanguages as PULONG, byval pwszLanguagesBuffer as PZZWSTR, byval pcchLanguagesBuffer as PULONG) as WINBOOL
	declare function SetThreadPreferredUILanguages(byval dwFlags as DWORD, byval pwszLanguagesBuffer as PCZZWSTR, byval pulNumLanguages as PULONG) as WINBOOL
	declare function GetFileMUIInfo(byval dwFlags as DWORD, byval pcwszFilePath as PCWSTR, byval pFileMUIInfo as PFILEMUIINFO, byval pcbFileMUIInfo as DWORD ptr) as WINBOOL
	declare function GetFileMUIPath(byval dwFlags as DWORD, byval pcwszFilePath as PCWSTR, byval pwszLanguage as PWSTR, byval pcchLanguage as PULONG, byval pwszFileMUIPath as PWSTR, byval pcchFileMUIPath as PULONG, byval pululEnumerator as PULONGLONG) as WINBOOL
	declare function GetUILanguageInfo(byval dwFlags as DWORD, byval pwmszLanguage as PCZZWSTR, byval pwszFallbackLanguages as PZZWSTR, byval pcchFallbackLanguages as PDWORD, byval pAttributes as PDWORD) as WINBOOL
	declare function NotifyUILanguageChange(byval dwFlags as DWORD, byval pcwstrNewLanguage as PCWSTR, byval pcwstrPreviousLanguage as PCWSTR, byval dwReserved as DWORD, byval pdwStatusRtrn as PDWORD) as WINBOOL
#endif

#ifdef UNICODE
	declare function EnumSystemLocales alias "EnumSystemLocalesW"(byval lpLocaleEnumProc as LOCALE_ENUMPROCW, byval dwFlags as DWORD) as WINBOOL
	declare function EnumSystemLanguageGroups alias "EnumSystemLanguageGroupsW"(byval lpLanguageGroupEnumProc as LANGUAGEGROUP_ENUMPROCW, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
	declare function EnumLanguageGroupLocales alias "EnumLanguageGroupLocalesW"(byval lpLangGroupLocaleEnumProc as LANGGROUPLOCALE_ENUMPROCW, byval LanguageGroup as LGRPID, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
	declare function EnumUILanguages alias "EnumUILanguagesW"(byval lpUILanguageEnumProc as UILANGUAGE_ENUMPROCW, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
#else
	declare function FoldString alias "FoldStringA"(byval dwMapFlags as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpDestStr as LPSTR, byval cchDest as long) as long
	declare function GetStringTypeEx alias "GetStringTypeExA"(byval Locale as LCID, byval dwInfoType as DWORD, byval lpSrcStr as LPCSTR, byval cchSrc as long, byval lpCharType as LPWORD) as WINBOOL
	declare function EnumSystemLocales alias "EnumSystemLocalesA"(byval lpLocaleEnumProc as LOCALE_ENUMPROCA, byval dwFlags as DWORD) as WINBOOL
	declare function EnumSystemLanguageGroups alias "EnumSystemLanguageGroupsA"(byval lpLanguageGroupEnumProc as LANGUAGEGROUP_ENUMPROCA, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
	declare function EnumLanguageGroupLocales alias "EnumLanguageGroupLocalesA"(byval lpLangGroupLocaleEnumProc as LANGGROUPLOCALE_ENUMPROCA, byval LanguageGroup as LGRPID, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
	declare function EnumUILanguages alias "EnumUILanguagesA"(byval lpUILanguageEnumProc as UILANGUAGE_ENUMPROCA, byval dwFlags as DWORD, byval lParam as LONG_PTR) as WINBOOL
#endif

declare function EnumSystemCodePagesA(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCA, byval dwFlags as DWORD) as WINBOOL
declare function EnumSystemCodePagesW(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCW, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function EnumSystemCodePages alias "EnumSystemCodePagesW"(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCW, byval dwFlags as DWORD) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function EnumSystemCodePages alias "EnumSystemCodePagesA"(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCA, byval dwFlags as DWORD) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	#define LOCALE_NAME_USER_DEFAULT NULL
	#define LOCALE_NAME_INVARIANT wstr("")
	#define LOCALE_NAME_SYSTEM_DEFAULT wstr("!x-sys-default-locale")

	type CALINFO_ENUMPROCEXEX as function(byval as LPWSTR, byval as CALID, byval as LPWSTR, byval as LPARAM) as WINBOOL
	type DATEFMT_ENUMPROCEXEX as function(byval as LPWSTR, byval as CALID, byval as LPARAM) as WINBOOL
	type TIMEFMT_ENUMPROCEX as function(byval as LPWSTR, byval as LPARAM) as WINBOOL
	type LOCALE_ENUMPROCEX as function(byval as LPWSTR, byval as DWORD, byval as LPARAM) as WINBOOL

	declare function NormalizeString(byval NormForm as NORM_FORM, byval lpSrcString as LPCWSTR, byval cwSrcLength as long, byval lpDstString as LPWSTR, byval cwDstLength as long) as long
	declare function IsNormalizedString(byval NormForm as NORM_FORM, byval lpString as LPCWSTR, byval cwLength as long) as WINBOOL
	declare function IdnToAscii(byval dwFlags as DWORD, byval lpUnicodeCharStr as LPCWSTR, byval cchUnicodeChar as long, byval lpASCIICharStr as LPWSTR, byval cchASCIIChar as long) as long
	declare function IdnToNameprepUnicode(byval dwFlags as DWORD, byval lpUnicodeCharStr as LPCWSTR, byval cchUnicodeChar as long, byval lpNameprepCharStr as LPWSTR, byval cchNameprepChar as long) as long
	declare function IdnToUnicode(byval dwFlags as DWORD, byval lpASCIICharStr as LPCWSTR, byval cchASCIIChar as long, byval lpUnicodeCharStr as LPWSTR, byval cchUnicodeChar as long) as long
	declare function VerifyScripts(byval dwFlags as DWORD, byval lpLocaleScripts as LPCWSTR, byval cchLocaleScripts as long, byval lpTestScripts as LPCWSTR, byval cchTestScripts as long) as WINBOOL
	declare function GetStringScripts(byval dwFlags as DWORD, byval lpString as LPCWSTR, byval cchString as long, byval lpScripts as LPWSTR, byval cchScripts as long) as long
	declare function GetLocaleInfoEx(byval lpLocaleName as LPCWSTR, byval LCType as LCTYPE, byval lpLCData as LPWSTR, byval cchData as long) as long
	declare function GetCalendarInfoEx(byval lpLocaleName as LPCWSTR, byval Calendar as CALID, byval lpReserved as LPCWSTR, byval CalType as CALTYPE, byval lpCalData as LPWSTR, byval cchData as long, byval lpValue as LPDWORD) as long
	declare function GetDurationFormatEx(byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lpDuration as const SYSTEMTIME ptr, byval ullDuration as ULONGLONG, byval lpFormat as LPCWSTR, byval lpDurationStr as LPWSTR, byval cchDuration as long) as long
	declare function GetNumberFormatEx(byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lpValue as LPCWSTR, byval lpFormat as const NUMBERFMTW ptr, byval lpNumberStr as LPWSTR, byval cchNumber as long) as long
	declare function GetCurrencyFormatEx(byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lpValue as LPCWSTR, byval lpFormat as const CURRENCYFMTW ptr, byval lpCurrencyStr as LPWSTR, byval cchCurrency as long) as long
	declare function GetUserDefaultLocaleName(byval lpLocaleName as LPWSTR, byval cchLocaleName as long) as long
	declare function GetSystemDefaultLocaleName(byval lpLocaleName as LPWSTR, byval cchLocaleName as long) as long
	declare function GetNLSVersionEx(byval function as NLS_FUNCTION, byval lpLocaleName as LPCWSTR, byval lpVersionInformation as LPNLSVERSIONINFOEX) as WINBOOL
	declare function FindNLSStringEx(byval lpLocaleName as LPCWSTR, byval dwFindNLSStringFlags as DWORD, byval lpStringSource as LPCWSTR, byval cchSource as long, byval lpStringValue as LPCWSTR, byval cchValue as long, byval pcchFound as LPINT, byval lpVersionInformation as LPNLSVERSIONINFO, byval lpReserved as LPVOID, byval sortHandle as LPARAM) as long
	declare function LCMapStringEx(byval lpLocaleName as LPCWSTR, byval dwMapFlags as DWORD, byval lpSrcStr as LPCWSTR, byval cchSrc as long, byval lpDestStr as LPWSTR, byval cchDest as long, byval lpVersionInformation as LPNLSVERSIONINFO, byval lpReserved as LPVOID, byval sortHandle as LPARAM) as long
	declare function IsValidLocaleName(byval lpLocaleName as LPCWSTR) as WINBOOL
	declare function EnumCalendarInfoExEx(byval pCalInfoEnumProcExEx as CALINFO_ENUMPROCEXEX, byval lpLocaleName as LPCWSTR, byval Calendar as CALID, byval lpReserved as LPCWSTR, byval CalType as CALTYPE, byval lParam as LPARAM) as WINBOOL
	declare function EnumDateFormatsExEx(byval lpDateFmtEnumProcExEx as DATEFMT_ENUMPROCEXEX, byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lParam as LPARAM) as WINBOOL
	declare function EnumTimeFormatsEx(byval lpTimeFmtEnumProcEx as TIMEFMT_ENUMPROCEX, byval lpLocaleName as LPCWSTR, byval dwFlags as DWORD, byval lParam as LPARAM) as WINBOOL
	declare function EnumSystemLocalesEx(byval lpLocaleEnumProcEx as LOCALE_ENUMPROCEX, byval dwFlags as DWORD, byval lParam as LPARAM, byval lpReserved as LPVOID) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	declare function ResolveLocaleName(byval lpNameToResolve as LPCWSTR, byval lpLocaleName as LPWSTR, byval cchLocaleName as long) as long
#endif

#if _WIN32_WINNT = &h0602
	declare function IsValidNLSVersion(byval function as NLS_FUNCTION, byval lpLocaleName as LPCWSTR, byval lpVersionInformation as LPNLSVERSIONINFOEX) as DWORD
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0502)
	declare function EnumSystemCodePages alias "EnumSystemCodePagesA"(byval lpCodePageEnumProc as CODEPAGE_ENUMPROCA, byval dwFlags as DWORD) as WINBOOL
#endif

end extern
