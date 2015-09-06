'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   Copyright (c) 1991, Oracle and/or its affiliates. All rights reserved.
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
''
''   Copyright 1985, 1987, 1988, 1990, 1991, 1993-1996, 1998  The Open Group
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
''   The X Window System is a Trademark of The Open Group.
''
''
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''
''   Copyright 1987 by Apollo Computer Inc., Chelmsford, Massachusetts.
''   Copyright 1989 by Hewlett-Packard Company.
''
''                           All Rights Reserved
''
''   Permission to use, duplicate, change, and distribute this software and
''   its documentation for any purpose and without fee is granted, provided
''   that the above copyright notice appear in such copy and that this
''   copyright notice appear in all supporting documentation, and that the
''   names of Apollo Computer Inc., the Hewlett-Packard Company, or the X
''   Consortium not be used in advertising or publicity pertaining to
''   distribution of the software without written prior permission.
''
''   HEWLETT-PACKARD MAKES NO WARRANTY OF ANY KIND WITH REGARD
''   TO THIS SOFWARE, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
''   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
''   PURPOSE.  Hewlett-Packard shall not be liable for errors
''   contained herein or direct, indirect, special, incidental or
''   consequential damages in connection with the furnishing,
''   performance, or use of this material.
''
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
''   authorization from The XFree86 Project Inc.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

const XATOM_H = 1
const XA_PRIMARY = cast(XAtom, 1)
const XA_SECONDARY = cast(XAtom, 2)
const XA_ARC = cast(XAtom, 3)
const XA_ATOM = cast(XAtom, 4)
const XA_BITMAP = cast(XAtom, 5)
const XA_CARDINAL = cast(XAtom, 6)
const XA_COLORMAP = cast(XAtom, 7)
const XA_CURSOR = cast(XAtom, 8)
const XA_CUT_BUFFER0 = cast(XAtom, 9)
const XA_CUT_BUFFER1 = cast(XAtom, 10)
const XA_CUT_BUFFER2 = cast(XAtom, 11)
const XA_CUT_BUFFER3 = cast(XAtom, 12)
const XA_CUT_BUFFER4 = cast(XAtom, 13)
const XA_CUT_BUFFER5 = cast(XAtom, 14)
const XA_CUT_BUFFER6 = cast(XAtom, 15)
const XA_CUT_BUFFER7 = cast(XAtom, 16)
const XA_DRAWABLE = cast(XAtom, 17)
const XA_FONT = cast(XAtom, 18)
const XA_INTEGER = cast(XAtom, 19)
const XA_PIXMAP = cast(XAtom, 20)
const XA_POINT = cast(XAtom, 21)
const XA_RECTANGLE = cast(XAtom, 22)
const XA_RESOURCE_MANAGER = cast(XAtom, 23)
const XA_RGB_COLOR_MAP = cast(XAtom, 24)
const XA_RGB_BEST_MAP = cast(XAtom, 25)
const XA_RGB_BLUE_MAP = cast(XAtom, 26)
const XA_RGB_DEFAULT_MAP = cast(XAtom, 27)
const XA_RGB_GRAY_MAP = cast(XAtom, 28)
const XA_RGB_GREEN_MAP = cast(XAtom, 29)
const XA_RGB_RED_MAP = cast(XAtom, 30)
const XA_STRING = cast(XAtom, 31)
const XA_VISUALID = cast(XAtom, 32)
const XA_WINDOW = cast(XAtom, 33)
const XA_WM_COMMAND = cast(XAtom, 34)
const XA_WM_HINTS = cast(XAtom, 35)
const XA_WM_CLIENT_MACHINE = cast(XAtom, 36)
const XA_WM_ICON_NAME = cast(XAtom, 37)
const XA_WM_ICON_SIZE = cast(XAtom, 38)
const XA_WM_NAME = cast(XAtom, 39)
const XA_WM_NORMAL_HINTS = cast(XAtom, 40)
const XA_WM_SIZE_HINTS = cast(XAtom, 41)
const XA_WM_ZOOM_HINTS = cast(XAtom, 42)
const XA_MIN_SPACE = cast(XAtom, 43)
const XA_NORM_SPACE = cast(XAtom, 44)
const XA_MAX_SPACE = cast(XAtom, 45)
const XA_END_SPACE = cast(XAtom, 46)
const XA_SUPERSCRIPT_X = cast(XAtom, 47)
const XA_SUPERSCRIPT_Y = cast(XAtom, 48)
const XA_SUBSCRIPT_X = cast(XAtom, 49)
const XA_SUBSCRIPT_Y = cast(XAtom, 50)
const XA_UNDERLINE_POSITION = cast(XAtom, 51)
const XA_UNDERLINE_THICKNESS = cast(XAtom, 52)
const XA_STRIKEOUT_ASCENT = cast(XAtom, 53)
const XA_STRIKEOUT_DESCENT = cast(XAtom, 54)
const XA_ITALIC_ANGLE = cast(XAtom, 55)
const XA_X_HEIGHT = cast(XAtom, 56)
const XA_QUAD_WIDTH = cast(XAtom, 57)
const XA_WEIGHT = cast(XAtom, 58)
const XA_POINT_SIZE = cast(XAtom, 59)
const XA_RESOLUTION = cast(XAtom, 60)
const XA_COPYRIGHT = cast(XAtom, 61)
const XA_NOTICE = cast(XAtom, 62)
const XA_FONT_NAME = cast(XAtom, 63)
const XA_FAMILY_NAME = cast(XAtom, 64)
const XA_FULL_NAME = cast(XAtom, 65)
const XA_CAP_HEIGHT = cast(XAtom, 66)
const XA_WM_CLASS = cast(XAtom, 67)
const XA_WM_TRANSIENT_FOR = cast(XAtom, 68)
const XA_LAST_PREDEFINED = cast(XAtom, 68)
