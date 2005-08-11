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
    } __attribute__((aligned(1)));

    typedef struct _DOS_COUNTRY_INFO_GENERAL DOS_COUNTRY_INFO_GENERAL;

    int fb_hIntlGetInfo( DOS_COUNTRY_INFO_GENERAL *pInfo );

#ifdef __cplusplus
}
#endif

#endif
