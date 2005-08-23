/*
 *  libfb - FreeBASIC's runtime library
 *    Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef __FBEXT_DOS_H__
#define __FBEXT_DOS_H__

#include "fbext.h"

#ifdef __cplusplus
extern "C" {
#endif

    /** Locale information not provided by DOS but that are useful too.
     */
    typedef struct _FB_LOCALE_INFOS {
        int country_code;
        const char *apszNamesMonthLong[12];
        const char *apszNamesMonthShort[12];
        const char *apszNamesWeekdayLong[7];
        const char *apszNamesWeekdayShort[7];
    } FB_LOCALE_INFOS;

    /** Array of locale informations.
     *
     * The last entry contains a country_code of -1.
     */
    extern const FB_LOCALE_INFOS fb_locale_infos[];
    extern const size_t          fb_locale_info_count;

    struct _DOS_COUNTRY_INFO_GENERAL {
        unsigned char   info_id                   __attribute__((packed));
        unsigned short  size_data                 __attribute__((packed));
        unsigned short  country_id                __attribute__((packed));
        unsigned short  code_page                 __attribute__((packed));
        unsigned short  date_format               __attribute__((packed));
        char            curr_symbol_string[5]     __attribute__((packed));
        char            thousands_sep[2]          __attribute__((packed));
        char            decimal_sep[2]            __attribute__((packed));
        char            date_sep[2]               __attribute__((packed));
        char            time_sep[2]               __attribute__((packed));
        unsigned char   currency_format           __attribute__((packed));
        unsigned char   curr_frac_digits          __attribute__((packed));
        unsigned char   time_format               __attribute__((packed));
        unsigned long   far_ptr_case_map_routine  __attribute__((packed));
        char            data_list_sep[2]          __attribute__((packed));
        char            reserved[10]              __attribute__((packed));
    };

    typedef struct _DOS_COUNTRY_INFO_GENERAL DOS_COUNTRY_INFO_GENERAL;

    int fb_hIntlGetInfo( DOS_COUNTRY_INFO_GENERAL *pInfo );

#ifdef __cplusplus
}
#endif

#endif
