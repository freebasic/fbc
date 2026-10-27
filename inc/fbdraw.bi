'' fbdraw.bi - drawing state for gfxlib2
''
'' Set the style once, then draw; changing a theme is three calls instead of
'' one per drawing call:
''
''     #include once "fbdraw.bi"
''
''     FBDrawSetLine rgb(200, 0, 0), 3
''     FBDrawSetFill rgb(0, 0, 255), FBDRAW_FILL_SOLID
''     FBDrawSetText rgb(255, 255, 255)
''
''     FBDrawLine   10, 10, 300, 200
''     FBDrawBox    20, 20, 120, 120
''     FBDrawBox   140, 20, 240, 120, FBDRAW_OUTLINE
''     FBDrawCircle 320, 200, 60
''     FBDrawText   40, 40, "hello"
''
'' The state is a plain record, so a caller that builds a different pipeline
'' (or a GPU backend) can translate it instead of re-deriving it: colour,
'' dash pattern, fill mode and text colour are the same things a pipeline
'' describes.
''
'' Copyright (c) 2026 the FreeBASIC contributors
'' Distributed under the same terms as the FreeBASIC runtime library.

#ifndef __FBDRAW_BI__
#define __FBDRAW_BI__

#pragma once

'' Fill modes.  These two are what the software rasteriser can honestly do;
'' a patterned fill would need a Paint that takes a pattern, which gfxlib2
'' does not have.
const FBDRAW_FILL_SOLID = 0
const FBDRAW_FILL_NONE  = 1

'' The outline form of the filled calls; it reads better at the call site.
const FBDRAW_OUTLINE = FBDRAW_FILL_NONE

'' How deep FBDrawPush/FBDrawPop may nest.  A dialog or a library routine
'' takes one level; sixteen is far more than anything needs, and it is a
'' fixed array so pushing costs nothing.
const FBDRAW_MAXDEPTH = 16

type FBDrawStyle
	line_colour as ulong
	line_style  as ulong    '' 0 = solid, otherwise a 16-bit dash pattern
	fill_colour as ulong
	fill_mode   as integer  '' FBDRAW_FILL_SOLID or FBDRAW_FILL_NONE
	text_colour as ulong
end type

'' White line, solid, white fill, white text.
dim shared fbdraw as FBDrawStyle = _
	( rgb(255, 255, 255), 0, rgb(255, 255, 255), FBDRAW_FILL_SOLID, rgb(255, 255, 255) )
dim shared fbdraw_stack(1 to FBDRAW_MAXDEPTH) as FBDrawStyle
dim shared fbdraw_depth as integer = 0

'' ---------------------------------------------------------------- state --

'' Back to the defaults.  Call it at the start of a scene so a routine cannot
'' inherit the previous one's theme.
sub FBDrawReset()
	fbdraw.line_colour = rgb(255, 255, 255)
	fbdraw.line_style  = 0
	fbdraw.fill_colour = rgb(255, 255, 255)
	fbdraw.fill_mode   = FBDRAW_FILL_SOLID
	fbdraw.text_colour = rgb(255, 255, 255)
end sub

'' Save the current state and restore it later.  Any routine that changes the
'' state and returns to a caller should bracket itself with these.
sub FBDrawPush()
	if fbdraw_depth >= FBDRAW_MAXDEPTH then exit sub   '' overflow: keep the current state
	fbdraw_depth += 1
	fbdraw_stack(fbdraw_depth) = fbdraw
end sub

sub FBDrawPop()
	if fbdraw_depth = 0 then exit sub                  '' underflow: do nothing
	fbdraw = fbdraw_stack(fbdraw_depth)
	fbdraw_depth -= 1
end sub

sub FBDrawSetLine(byval colour as ulong, byval style as ulong = 0)
	fbdraw.line_colour = colour
	fbdraw.line_style  = style
end sub

sub FBDrawSetFill(byval colour as ulong, byval mode as integer = FBDRAW_FILL_SOLID)
	fbdraw.fill_colour = colour
	fbdraw.fill_mode   = mode
end sub

sub FBDrawSetText(byval colour as ulong)
	fbdraw.text_colour = colour
end sub

'' ------------------------------------------------------------- geometry --
''
'' Each call takes a mode that defaults to the state, so
''     FBDrawBox 20, 20, 120, 120
'' uses FBDrawSetFill's mode, and
''     FBDrawBox 20, 20, 120, 120, FBDRAW_OUTLINE
'' overrides it for this call without touching the state.

sub FBDrawLine(byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
	'' style 0 is solid, but passing 0 to Line draws nothing, so the solid
	'' case has to leave the argument out entirely
	if fbdraw.line_style = 0 then
		line (x1, y1)-(x2, y2), fbdraw.line_colour
	else
		line (x1, y1)-(x2, y2), fbdraw.line_colour, , fbdraw.line_style
	end if
end sub

sub FBDrawBox(byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval mode as integer = -1)
	dim as integer m = mode
	if m < 0 then m = fbdraw.fill_mode

	if m = FBDRAW_FILL_SOLID then
		line (x1, y1)-(x2, y2), fbdraw.fill_colour, BF
	else
		if fbdraw.line_style = 0 then
			line (x1, y1)-(x2, y2), fbdraw.line_colour, B
		else
			line (x1, y1)-(x2, y2), fbdraw.line_colour, B, fbdraw.line_style
		end if
	end if
end sub

sub FBDrawCircle(byval x as integer, byval y as integer, byval radius as integer, byval mode as integer = -1)
	dim as integer m = mode
	if m < 0 then m = fbdraw.fill_mode

	if m = FBDRAW_FILL_SOLID then
		circle (x, y), radius, fbdraw.fill_colour, , , , F
	else
		circle (x, y), radius, fbdraw.line_colour
	end if
end sub

'' Flood fill in the fill colour, stopping at the line colour.
sub FBDrawPaint(byval x as integer, byval y as integer)
	paint (x, y), fbdraw.fill_colour, fbdraw.line_colour
end sub

sub FBDrawText(byval x as integer, byval y as integer, byval s as string)
	draw string (x, y), s, fbdraw.text_colour
end sub

#endif '' __FBDRAW_BI__
