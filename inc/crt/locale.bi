'   Copyright (C) 2001 Free Software Foundation, Inc.
'   This file is part of the GNU C Library.
'
'   The GNU C Library is free software; you can redistribute it and/or
'   modify it under the terms of the GNU Lesser General Public
'   License as published by the Free Software Foundation; either
'   version 2.1 of the License, or (at your option) any later version.
'
'   The GNU C Library is distributed in the hope that it will be useful,
'   but WITHOUT ANY WARRANTY; without even the implied warranty of
'   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'   Lesser General Public License for more details.
'
'   You should have received a copy of the GNU Lesser General Public
'   License along with the GNU C Library; if not, write to the Free
'   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
'   02111-1301 USA.  */

#ifndef _LOCALE_H
#define _LOCALE_H 1

#include once "crt/bits/locale.bi"

'   These are the possibilities for the first argument to setlocale.
'   The code assumes that the lowest LC_* symbol has the value zero.

#define LC_CTYPE          __LC_CTYPE
#define LC_NUMERIC        __LC_NUMERIC
#define LC_TIME           __LC_TIME
#define LC_COLLATE        __LC_COLLATE
#define LC_MONETARY       __LC_MONETARY
#define LC_MESSAGES       __LC_MESSAGES
#define LC_ALL            __LC_ALL
#define LC_PAPER          __LC_PAPER
#define LC_NAME           __LC_NAME
#define LC_ADDRESS        __LC_ADDRESS
#define LC_TELEPHONE      __LC_TELEPHONE
#define LC_MEASUREMENT    __LC_MEASUREMENT
#define LC_IDENTIFICATION __LC_IDENTIFICATION

'/* Structure giving information about numeric and monetary notation.  */
type lconv
  '/* Numeric (non-monetary) information.  */

  decimal_point as zstring ptr '		/* Decimal point character.  */
  thousands_sep as zstring ptr	'	/* Thousands separator.  */
  '/* Each element is the number of digits in each group;
  '   elements with higher indices are farther left.
  '   An element with value CHAR_MAX means that no further grouping is done.
  '   An element with value 0 means that the previous element is used
  '   for all groups farther left.  */
  grouping as zstring ptr

  '/* Monetary information.  */

  '/* First three chars are a currency symbol from ISO 4217.
  '   Fourth char is the separator.  Fifth char is '\0'.  */
  int_curr_symbol as zstring ptr
  currency_symbol as zstring ptr	'/* Local currency symbol.  */
  mon_decimal_point as zstring ptr	'/* Decimal point character.  */
  mon_thousands_sep as zstring ptr	'/* Thousands separator.  */
  mon_grouping as zstring ptr		'/* Like `grouping' element (above).  */
  positive_sign as zstring ptr		'/* Sign for positive values.  */
  negative_sign as zstring ptr		'/* Sign for negative values.  */
  int_frac_digits as ubyte		'/* Int'l fractional digits.  */
  frac_digits as ubyte		'/* Local fractional digits.  */
  '/* 1 if currency_symbol precedes a positive value, 0 if succeeds.  */
  p_cs_precedes as ubyte
  '/* 1 iff a space separates currency_symbol from a positive value.  */
  p_sep_by_space as ubyte
  '/* 1 if currency_symbol precedes a negative value, 0 if succeeds.  */
  n_cs_precedes as ubyte
  '/* 1 iff a space separates currency_symbol from a negative value.  */
  n_sep_by_space as ubyte
  '/* Positive and negative sign positions:
  '   0 Parentheses surround the quantity and currency_symbol.
  '   1 The sign string precedes the quantity and currency_symbol.
  '   2 The sign string follows the quantity and currency_symbol.
  '   3 The sign string immediately precedes the currency_symbol.
  '   4 The sign string immediately follows the currency_symbol.  */
  p_sign_posn as ubyte
  n_sign_posn as ubyte
  '/* 1 if int_curr_symbol precedes a positive value, 0 if succeeds.  */
  int_p_cs_precedes as ubyte
  '/* 1 iff a space separates int_curr_symbol from a positive value.  */
  int_p_sep_by_space as ubyte
  '/* 1 if int_curr_symbol precedes a negative value, 0 if succeeds.  */
  int_n_cs_precedes as ubyte
  '/* 1 iff a space separates int_curr_symbol from a negative value.  */
  int_n_sep_by_space as ubyte
  '/* Positive and negative sign positions:
  '   0 Parentheses surround the quantity and int_curr_symbol.
  '   1 The sign string precedes the quantity and int_curr_symbol.
  '   2 The sign string follows the quantity and int_curr_symbol.
  '   3 The sign string immediately precedes the int_curr_symbol.
  '   4 The sign string immediately follows the int_curr_symbol.  */
  int_p_sign_posn as ubyte
  int_n_sign_posn as ubyte
end type

extern "C"

'Sets and/or returns the current locale
declare function setlocale (byval __category as long, byval __locale as const zstring ptr) as zstring ptr

'Return the numeric/monetary information for the current locale.
declare function localeconv () as lconv ptr

end extern

#endif '' _LOCALE_H
