''
''
'' gdktypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdktypes_bi__
#define __gdktypes_bi__

#include once "gtk/glib.bi"
#include once "gtk/pango.bi"
#include once "gtk/glib-object.bi"

#define GDK_CURRENT_TIME 0L
#define GDK_PARENT_RELATIVE 1L

type GdkPoint as _GdkPoint
type GdkRectangle as _GdkRectangle
type GdkSegment as _GdkSegment
type GdkSpan as _GdkSpan
type GdkWChar as guint32
type GdkAtom as _GdkAtom ptr
type GdkNativeWindow as guint32
type GdkColor as _GdkColor
type GdkColormap as _GdkColormap
type GdkCursor as _GdkCursor
type GdkFont as _GdkFont
type GdkGC as _GdkGC
type GdkImage as _GdkImage
type GdkRegion as _GdkRegion
type GdkVisual as _GdkVisual
type GdkDrawable as _GdkDrawable
type GdkBitmap as _GdkDrawable
type GdkPixmap as _GdkDrawable
type GdkWindow as _GdkDrawable
type GdkDisplay as _GdkDisplay
type GdkScreen as _GdkScreen

enum GdkByteOrder
	GDK_LSB_FIRST
	GDK_MSB_FIRST
end enum


enum GdkModifierType
	GDK_SHIFT_MASK = 1 shl 0
	GDK_LOCK_MASK = 1 shl 1
	GDK_CONTROL_MASK = 1 shl 2
	GDK_MOD1_MASK = 1 shl 3
	GDK_MOD2_MASK = 1 shl 4
	GDK_MOD3_MASK = 1 shl 5
	GDK_MOD4_MASK = 1 shl 6
	GDK_MOD5_MASK = 1 shl 7
	GDK_BUTTON1_MASK = 1 shl 8
	GDK_BUTTON2_MASK = 1 shl 9
	GDK_BUTTON3_MASK = 1 shl 10
	GDK_BUTTON4_MASK = 1 shl 11
	GDK_BUTTON5_MASK = 1 shl 12
	GDK_RELEASE_MASK = 1 shl 30
	GDK_MODIFIER_MASK = GDK_RELEASE_MASK or &h1fff
end enum


enum GdkInputCondition
	GDK_INPUT_READ = 1 shl 0
	GDK_INPUT_WRITE = 1 shl 1
	GDK_INPUT_EXCEPTION = 1 shl 2
end enum


enum GdkStatus
	GDK_OK = 0
	GDK_ERROR = -1
	GDK_ERROR_PARAM = -2
	GDK_ERROR_FILE = -3
	GDK_ERROR_MEM = -4
end enum


enum GdkGrabStatus
	GDK_GRAB_SUCCESS = 0
	GDK_GRAB_ALREADY_GRABBED = 1
	GDK_GRAB_INVALID_TIME = 2
	GDK_GRAB_NOT_VIEWABLE = 3
	GDK_GRAB_FROZEN = 4
end enum

type GdkInputFunction as sub cdecl(byval as gpointer, byval as gint, byval as GdkInputCondition)
type GdkDestroyNotify as sub cdecl(byval as gpointer)

type _GdkPoint
	x as gint
	y as gint
end type

type _GdkRectangle
	x as gint
	y as gint
	width as gint
	height as gint
end type

type _GdkSegment
	x1 as gint
	y1 as gint
	x2 as gint
	y2 as gint
end type

type _GdkSpan
	x as gint
	y as gint
	width as gint
end type

#endif
