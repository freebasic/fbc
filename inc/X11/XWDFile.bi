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
