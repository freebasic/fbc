#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xfuncproto.bi"
#include once "crt/stdio.bi"

extern "C"

#define _XMU_DRAWING_H_
declare sub XmuDrawRoundedRectangle(byval dpy as Display ptr, byval draw as Drawable, byval gc as GC, byval x as long, byval y as long, byval w as long, byval h as long, byval ew as long, byval eh as long)
declare sub XmuFillRoundedRectangle(byval dpy as Display ptr, byval draw as Drawable, byval gc as GC, byval x as long, byval y as long, byval w as long, byval h as long, byval ew as long, byval eh as long)
declare sub XmuDrawLogo(byval dpy as Display ptr, byval drawable as Drawable, byval gcFore as GC, byval gcBack as GC, byval x as long, byval y as long, byval width as ulong, byval height as ulong)
declare function XmuCreatePixmapFromBitmap(byval dpy as Display ptr, byval d as Drawable, byval bitmap as Pixmap, byval width as ulong, byval height as ulong, byval depth as ulong, byval fore as culong, byval back as culong) as Pixmap
declare function XmuCreateStippledPixmap(byval screen as Screen ptr, byval fore as Pixel, byval back as Pixel, byval depth as ulong) as Pixmap
declare sub XmuReleaseStippledPixmap(byval screen as Screen ptr, byval pixmap as Pixmap)
declare function XmuLocateBitmapFile(byval screen as Screen ptr, byval name as const zstring ptr, byval srcname_return as zstring ptr, byval srcnamelen as long, byval width_return as long ptr, byval height_return as long ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as Pixmap
declare function XmuLocatePixmapFile(byval screen as Screen ptr, byval name as const zstring ptr, byval fore as culong, byval back as culong, byval depth as ulong, byval srcname_return as zstring ptr, byval srcnamelen as long, byval width_return as long ptr, byval height_return as long ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as Pixmap
declare function XmuReadBitmapData(byval fstream as FILE ptr, byval width_return as ulong ptr, byval height_return as ulong ptr, byval datap_return as ubyte ptr ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as long
declare function XmuReadBitmapDataFromFile(byval filename as const zstring ptr, byval width_return as ulong ptr, byval height_return as ulong ptr, byval datap_return as ubyte ptr ptr, byval xhot_return as long ptr, byval yhot_return as long ptr) as long

end extern
