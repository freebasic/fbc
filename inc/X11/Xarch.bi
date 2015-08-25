'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   Copyright 1997 Metro Link Incorporated
''
''                             All Rights Reserved
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the names of the above listed copyright holder(s)
''   not be used in advertising or publicity pertaining to distribution of
''   the software without specific, written prior permission.  The above listed
''   copyright holder(s) make(s) no representations about the suitability of
''   this software for any purpose.  It is provided "as is" without express or
''   implied warranty.
''
''   THE ABOVE LISTED COPYRIGHT HOLDER(S) DISCLAIM(S) ALL WARRANTIES WITH REGARD
''   TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
''   AND FITNESS, IN NO EVENT SHALL THE ABOVE LISTED COPYRIGHT HOLDER(S) BE
''   LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY
''   DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER
''   IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING
''   OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _XARCH_H_
const LITTLE_ENDIAN = 1234
const BIG_ENDIAN = 4321
#define X_BYTE_ORDER BYTE_ORDER
const X_BIG_ENDIAN = BIG_ENDIAN
const X_LITTLE_ENDIAN = LITTLE_ENDIAN
