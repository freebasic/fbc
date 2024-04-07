'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1989, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''
''   Copyright (c) 1997 by Silicon Graphics Computer Systems, Inc.
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Silicon Graphics not be
''   used in advertising or publicity pertaining to distribution
''   of the software without specific prior written permission.
''   Silicon Graphics makes no representation about the suitability
''   of this software for any purpose. It is provided "as is"
''   without any express or implied warranty.
''   SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
''   AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
''   GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL
''   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
''   OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
''   THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''
''   Copyright 1992 Network Computing Devices
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of NCD. not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  NCD. makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''   NCD. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL NCD.
''   BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
''   OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
''   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''
''   Copyright (c) 1994, 1995  Hewlett-Packard Company
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL HEWLETT-PACKARD COMPANY BE LIABLE FOR ANY CLAIM,
''   DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
''   OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
''   THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of the Hewlett-Packard
''   Company shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization from the Hewlett-Packard Company.
''
''
''   Copyright (c) 1996 Digital Equipment Corporation, Maynard, Massachusetts.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   DIGITAL EQUIPMENT CORPORATION BE LIABLE FOR ANY CLAIM, DAMAGES, INCLUDING, 
''   BUT NOT LIMITED TO CONSEQUENTIAL OR INCIDENTAL DAMAGES, OR OTHER LIABILITY, 
''   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
''   IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Digital Equipment Corporation 
''   shall not be used in advertising or otherwise to promote the sale, use or other
''   dealings in this Software without prior written authorization from Digital 
''   Equipment Corporation.
''
''
''   Copyright 1988, 1989, 1990, 1994 Network Computing Devices, Inc.
''
''   Permission to use, copy, modify, distribute, and sell this software and
''   its documentation for any purpose is hereby granted without fee, provided
''   that the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name Network Computing Devices, Inc. not be
''   used in advertising or publicity pertaining to distribution of this 
''   software without specific, written prior permission.
''
''   THIS SOFTWARE IS PROVIDED `AS-IS'.  NETWORK COMPUTING DEVICES, INC.,
''   DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING WITHOUT
''   LIMITATION ALL IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
''   PARTICULAR PURPOSE, OR NONINFRINGEMENT.  IN NO EVENT SHALL NETWORK
''   COMPUTING DEVICES, INC., BE LIABLE FOR ANY DAMAGES WHATSOEVER, INCLUDING
''   SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, INCLUDING LOSS OF USE,
''   DATA, OR PROFITS, EVEN IF ADVISED OF THE POSSIBILITY THEREOF, AND
''   REGARDLESS OF WHETHER IN AN ACTION IN CONTRACT, TORT OR NEGLIGENCE,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''
''   Copyright 1991,1993 by Digital Equipment Corporation, Maynard, Massachusetts,
''   and Olivetti Research Limited, Cambridge, England.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its 
''   documentation for any purpose and without fee is hereby granted, 
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in 
''   supporting documentation, and that the names of Digital or Olivetti
''   not be used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.  
''
''   DIGITAL AND OLIVETTI DISCLAIM ALL WARRANTIES WITH REGARD TO THIS
''   SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
''   FITNESS, IN NO EVENT SHALL THEY BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
''   USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
''   OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
''   PERFORMANCE OF THIS SOFTWARE.
''
''
''   Copyright 1986, 1987, 1988 by Hewlett-Packard Corporation
''
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Hewlett-Packard not be used in
''   advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   Hewlett-Packard makes no representations about the 
''   suitability of this software for any purpose.  It is provided 
''   "as is" without express or implied warranty.
''
''   This software is not subject to any license of the American
''   Telephone and Telegraph Company or of the Regents of the
''   University of California.
''
''
''   Copyright © 2007-2008 Peter Hutterer
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   FreeBASIC development team

#pragma once

#include once "X11/extensions/shapeproto.bi"

#define _SHAPESTR_H_
