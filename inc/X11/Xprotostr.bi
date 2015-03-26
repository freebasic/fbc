#pragma once

#include once "X11/Xmd.bi"

'' The following symbols have been renamed:
''     typedef xSegment => xSegment_
''     typedef xPoint => xPoint_
''     typedef xRectangle => xRectangle_
''     typedef xArc => xArc_

#define XPROTOSTRUCTS_H

type _xSegment
	x1 as INT16
	y1 as INT16
	x2 as INT16
	y2 as INT16
end type

type xSegment_ as _xSegment

type _xPoint
	x as INT16
	y as INT16
end type

type xPoint_ as _xPoint

type _xRectangle
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
end type

type xRectangle_ as _xRectangle

type _xArc
	x as INT16
	y as INT16
	width as CARD16
	height as CARD16
	angle1 as INT16
	angle2 as INT16
end type

type xArc_ as _xArc
