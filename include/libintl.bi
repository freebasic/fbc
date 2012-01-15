'/* Message catalogs for internationalization.
'   Copyright (C) 1995-2002, 2004, 2005 Free Software Foundation, Inc.
'   This file is part of the GNU C Library.
'   This file is derived from the file libgettext.h in the GNU gettext package.
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
'   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
'   02111-1307 USA.  */
#ifndef __libintl_bi__
#define __libintl_bi__ 1

#inclib "intl"

#include once "crt/locale.bi"

#define __USE_GNU_GETTEXT 1

' Look up MSGID in the current default message catalog for the current
'   LC_MESSAGES locale.  If not found, returns MSGID itself (the default
'   text).
#define gettext(msgid) dgettext (0, msgid)

' Look up MSGID in the DOMAINNAME message catalog for the current
'   LC_MESSAGES locale.
#define dgettext(domainname, msgid) dcgettext (domainname, msgid, LC_MESSAGES)

' Similar to `gettext' but select the plural form corresponding to the
'   number N.
#define ngettext(msgid1, msgid2, n) dngettext (0, msgid1, msgid2, n)

' Similar to `dgettext' but select the plural form corresponding to the
'   number N.
#define dngettext(domainname, msgid1, msgid2, n) dcngettext (domainname, msgid1, msgid2, n, LC_MESSAGES)

extern "C"

' Look up MSGID in the DOMAINNAME message catalog for the current CATEGORY
'   locale.
declare function dcgettext ( byval __domainname as const zstring ptr, _
			byval __msgid as const zstring ptr, byval __category as integer) as zstring ptr

' Similar to `dcgettext' but select the plural form corresponding to the
'   number N.
declare function dcngettext ( byval __domainname as const zstring ptr, byval __msgid1 as const zstring ptr, _
			 byval __msgid2 as const zstring ptr, byval __n as uinteger, _
			 byval __category as integer) as zstring ptr

' Set the current default message catalog to DOMAINNAME.
'   If DOMAINNAME is null, return the current default.
'   If DOMAINNAME is "", reset to the default of "messages".
declare function textdomain ( byval __domainname as const zstring ptr ) as zstring ptr

' Specify that the DOMAINNAME message catalog will be found
'   in DIRNAME rather than in the system locale data base.
declare function bindtextdomain ( byval __domainname as const zstring ptr, _
			     byval __dirname as const zstring ptr ) as zstring ptr

' Specify the character encoding in which the messages from the
'   DOMAINNAME message catalog will be returned.
declare function bind_textdomain_codeset ( byval __domainname as const zstring ptr, _
				      byval __codeset as const zstring ptr) as zstring ptr
end extern

#endif
