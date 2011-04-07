''
''
'' gdkcursor -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkcursor_bi__
#define __gdkcursor_bi__

#include once "gdktypes.bi"
#include once "gtk/gdk-pixbuf.bi"

#define GDK_TYPE_CURSOR (gdk_cursor_get_type ())

enum GdkCursorType
	GDK_X_CURSOR = 0
	GDK_ARROW = 2
	GDK_BASED_ARROW_DOWN = 4
	GDK_BASED_ARROW_UP = 6
	GDK_BOAT = 8
	GDK_BOGOSITY = 10
	GDK_BOTTOM_LEFT_CORNER = 12
	GDK_BOTTOM_RIGHT_CORNER = 14
	GDK_BOTTOM_SIDE = 16
	GDK_BOTTOM_TEE = 18
	GDK_BOX_SPIRAL = 20
	GDK_CENTER_PTR = 22
	GDK_CIRCLE = 24
	GDK_CLOCK = 26
	GDK_COFFEE_MUG = 28
	GDK_CROSS = 30
	GDK_CROSS_REVERSE = 32
	GDK_CROSSHAIR = 34
	GDK_DIAMOND_CROSS = 36
	GDK_DOT = 38
	GDK_DOTBOX = 40
	GDK_DOUBLE_ARROW = 42
	GDK_DRAFT_LARGE = 44
	GDK_DRAFT_SMALL = 46
	GDK_DRAPED_BOX = 48
	GDK_EXCHANGE = 50
	GDK_FLEUR = 52
	GDK_GOBBLER = 54
	GDK_GUMBY = 56
	GDK_HAND1 = 58
	GDK_HAND2 = 60
	GDK_HEART = 62
	GDK_ICON = 64
	GDK_IRON_CROSS = 66
	GDK_LEFT_PTR = 68
	GDK_LEFT_SIDE = 70
	GDK_LEFT_TEE = 72
	GDK_LEFTBUTTON = 74
	GDK_LL_ANGLE = 76
	GDK_LR_ANGLE = 78
	GDK_MAN = 80
	GDK_MIDDLEBUTTON = 82
	GDK_MOUSE = 84
	GDK_PENCIL = 86
	GDK_PIRATE = 88
	GDK_PLUS = 90
	GDK_QUESTION_ARROW = 92
	GDK_RIGHT_PTR = 94
	GDK_RIGHT_SIDE = 96
	GDK_RIGHT_TEE = 98
	GDK_RIGHTBUTTON = 100
	GDK_RTL_LOGO = 102
	GDK_SAILBOAT = 104
	GDK_SB_DOWN_ARROW = 106
	GDK_SB_H_DOUBLE_ARROW = 108
	GDK_SB_LEFT_ARROW = 110
	GDK_SB_RIGHT_ARROW = 112
	GDK_SB_UP_ARROW = 114
	GDK_SB_V_DOUBLE_ARROW = 116
	GDK_SHUTTLE = 118
	GDK_SIZING = 120
	GDK_SPIDER = 122
	GDK_SPRAYCAN = 124
	GDK_STAR = 126
	GDK_TARGET = 128
	GDK_TCROSS = 130
	GDK_TOP_LEFT_ARROW = 132
	GDK_TOP_LEFT_CORNER = 134
	GDK_TOP_RIGHT_CORNER = 136
	GDK_TOP_SIDE = 138
	GDK_TOP_TEE = 140
	GDK_TREK = 142
	GDK_UL_ANGLE = 144
	GDK_UMBRELLA = 146
	GDK_UR_ANGLE = 148
	GDK_WATCH = 150
	GDK_XTERM = 152
	GDK_LAST_CURSOR
	GDK_CURSOR_IS_PIXMAP = -1
end enum


type _GdkCursor
	type as GdkCursorType
	ref_count as guint
end type

declare function gdk_cursor_get_type () as GType
declare function gdk_cursor_new_for_display (byval display as GdkDisplay ptr, byval cursor_type as GdkCursorType) as GdkCursor ptr
declare function gdk_cursor_new (byval cursor_type as GdkCursorType) as GdkCursor ptr
declare function gdk_cursor_new_from_pixmap (byval source as GdkPixmap ptr, byval mask as GdkPixmap ptr, byval fg as GdkColor ptr, byval bg as GdkColor ptr, byval x as gint, byval y as gint) as GdkCursor ptr
declare function gdk_cursor_new_from_pixbuf (byval display as GdkDisplay ptr, byval pixbuf as GdkPixbuf ptr, byval x as gint, byval y as gint) as GdkCursor ptr
declare function gdk_cursor_get_display (byval cursor as GdkCursor ptr) as GdkDisplay ptr
declare function gdk_cursor_ref (byval cursor as GdkCursor ptr) as GdkCursor ptr
declare sub gdk_cursor_unref (byval cursor as GdkCursor ptr)

#define gdk_cursor_destroy gdk_cursor_unref

#endif
