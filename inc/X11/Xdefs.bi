'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright (c) 1999  The XFree86 Project Inc.
''
''   All Rights Reserved.
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
''   Except as contained in this notice, the name of The XFree86 Project
''   Inc. shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization from The XFree86 Project Inc..
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     typedef pointer => pointer_

extern "C"

#define _XDEFS_H
#define _XTYPEDEF_POINTER
type pointer_ as any ptr
type ClientPtr as _Client ptr
#define _XTYPEDEF_CLIENTPTR
#define _XTYPEDEF_FONTPTR
type FontPtr as _Font ptr
type FSID as culong
type AccContext as FSID
type OSTimePtr as timeval ptr ptr
type BlockHandlerProcPtr as sub(byval as any ptr, byval as OSTimePtr, byval as any ptr)

end extern
