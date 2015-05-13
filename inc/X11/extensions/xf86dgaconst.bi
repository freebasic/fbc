#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/xf86dga1const.bi"

#define _XF86DGACONST_H_
const X_XDGAQueryVersion = 0
const X_XDGAQueryModes = 12
const X_XDGASetMode = 13
const X_XDGASetViewport = 14
const X_XDGAInstallColormap = 15
const X_XDGASelectInput = 16
const X_XDGAFillRectangle = 17
const X_XDGACopyArea = 18
const X_XDGACopyTransparentArea = 19
const X_XDGAGetViewportStatus = 20
const X_XDGASync = 21
const X_XDGAOpenFramebuffer = 22
const X_XDGACloseFramebuffer = 23
const X_XDGASetClientVersion = 24
const X_XDGAChangePixmapMode = 25
const X_XDGACreateColormap = 26
const XDGAConcurrentAccess = &h00000001
const XDGASolidFillRect = &h00000002
const XDGABlitRect = &h00000004
const XDGABlitTransRect = &h00000008
const XDGAPixmap = &h00000010
const XDGAInterlaced = &h00010000
const XDGADoublescan = &h00020000
const XDGAFlipImmediate = &h00000001
const XDGAFlipRetrace = &h00000002
const XDGANeedRoot = &h00000001
const XF86DGANumberEvents = 7
const XDGAPixmapModeLarge = 0
const XDGAPixmapModeSmall = 1
const XF86DGAClientNotLocal = 0
const XF86DGANoDirectVideoMode = 1
const XF86DGAScreenNotActive = 2
const XF86DGADirectNotActivated = 3
const XF86DGAOperationNotSupported = 4
#define XF86DGANumberErrors (XF86DGAOperationNotSupported + 1)

type XDGAMode
	num as long
	name as zstring ptr
	verticalRefresh as single
	flags as long
	imageWidth as long
	imageHeight as long
	pixmapWidth as long
	pixmapHeight as long
	bytesPerScanline as long
	byteOrder as long
	depth as long
	bitsPerPixel as long
	redMask as culong
	greenMask as culong
	blueMask as culong
	visualClass as short
	viewportWidth as long
	viewportHeight as long
	xViewportStep as long
	yViewportStep as long
	maxViewportX as long
	maxViewportY as long
	viewportFlags as long
	reserved1 as long
	reserved2 as long
end type

type XDGADevice
	mode as XDGAMode
	data as ubyte ptr
	pixmap as Pixmap
end type
