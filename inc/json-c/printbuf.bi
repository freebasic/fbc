'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: printbuf.h,v 1.4 2006/01/26 02:16:28 mclark Exp $
''
''   Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
''   Michael Clark <michael@metaparadigm.com>
''
''   This library is free software; you can redistribute it and/or modify
''   it under the terms of the MIT license. See COPYING for details.
''
''
''   Copyright (c) 2008-2009 Yahoo! Inc.  All rights reserved.
''   The copyrights to the contents of this file are licensed under the MIT License
''   (http://www.opensource.org/licenses/mit-license.php)
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define _printbuf_h_

type printbuf_
	buf as zstring ptr
	bpos as long
	size as long
end type

declare function printbuf_new() as printbuf ptr
declare function printbuf_memappend(byval p as printbuf ptr, byval buf as const zstring ptr, byval size as long) as long
#macro printbuf_memappend_fast(p, bufptr, bufsize)
	if (p->size - p->bpos) > bufsize then
		memcpy(p->buf + p->bpos, (bufptr), bufsize)
		p->bpos += bufsize
		p->buf[p->bpos] = asc(!"\0")
	else
		printbuf_memappend(p, (bufptr), bufsize)
	end if
#endmacro
#define printbuf_length(p) (p)->bpos
declare function printbuf_memset(byval pb as printbuf ptr, byval offset as long, byval charvalue as long, byval len as long) as long
declare function sprintbuf(byval p as printbuf ptr, byval msg as const zstring ptr, ...) as long
declare sub printbuf_reset(byval p as printbuf ptr)
declare sub printbuf_free(byval p as printbuf ptr)

end extern
