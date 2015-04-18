'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''
''   Copyright 1985, 1986, 1998  The Open Group
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xmd.bi"

#define XWDFILE_H
const XWD_FILE_VERSION = 7
const sz_XWDheader = 100
const sz_XWDColor = 12
type xwdval as CARD32

type _xwd_file_header
	header_size as CARD32
	file_version as CARD32
	pixmap_format as CARD32
	pixmap_depth as CARD32
	pixmap_width as CARD32
	pixmap_height as CARD32
	xoffset as CARD32
	byte_order as CARD32
	bitmap_unit as CARD32
	bitmap_bit_order as CARD32
	bitmap_pad as CARD32
	bits_per_pixel as CARD32
	bytes_per_line as CARD32
	visual_class as CARD32
	red_mask as CARD32
	green_mask as CARD32
	blue_mask as CARD32
	bits_per_rgb as CARD32
	colormap_entries as CARD32
	ncolors as CARD32
	window_width as CARD32
	window_height as CARD32
	window_x as CARD32
	window_y as CARD32
	window_bdrwidth as CARD32
end type

type XWDFileHeader as _xwd_file_header

type XWDColor
	pixel as CARD32
	red as CARD16
	green as CARD16
	blue as CARD16
	flags as CARD8
	pad as CARD8
end type
