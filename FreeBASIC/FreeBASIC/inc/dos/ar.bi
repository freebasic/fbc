' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
' converted by DrV for FreeBASIC 07-Feb-2005
#ifndef _AR_H_
#define _AR_H_

#ifdef __FB_OPTION_ESCAPE__
#define ARMAG "!<arch>\n"
#define ARFMAG "`\n"
#else
#define ARMAG "!<arch>" + chr( 10 )
#define ARFMAG "`" + chr( 10 )
#endif
#define SARMAG 8

type ar_hdr
	ar_name(15) as byte
	ar_date(11) as byte
	ar_uid(5) as byte
	ar_gid(5) as byte
	ar_mode(7) as byte
	ar_size(9) as byte
	ar_fmag(1) as byte
end type

#endif
