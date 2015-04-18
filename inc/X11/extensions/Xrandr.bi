'' FreeBASIC binding for libXrandr-1.4.2
''
'' based on the C header files:
''    Copyright © 2000 Compaq Computer Corporation, Inc.
''    Copyright © 2002 Hewlett-Packard Company, Inc.
''    Copyright © 2006 Intel Corporation
''    Copyright © 2008 Red Hat, Inc.
''
''    Permission to use, copy, modify, distribute, and sell this software and its
''    documentation for any purpose is hereby granted without fee, provided that
''    the above copyright notice appear in all copies and that both that copyright
''    notice and this permission notice appear in supporting documentation, and
''    that the name of the copyright holders not be used in advertising or
''    publicity pertaining to distribution of the software without specific,
''    written prior permission.  The copyright holders make no representations
''    about the suitability of this software for any purpose.  It is provided "as
''    is" without express or implied warranty.
''
''    THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''    INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''    EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''    CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''    DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
''    OF THIS SOFTWARE.
''
''    Author:  Jim Gettys, HP Labs, Hewlett-Packard, Inc.
''   	    Keith Packard, Intel Corporation
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/randr.bi"
#include once "X11/extensions/Xrender.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XRANDR_H_
type RROutput as XID
type RRCrtc as XID
type RRMode as XID
type RRProvider as XID

type XRRScreenSize
	width as long
	height as long
	mwidth as long
	mheight as long
end type

type XRRScreenChangeNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	root as Window
	timestamp as Time
	config_timestamp as Time
	size_index as SizeID
	subpixel_order as SubpixelOrder
	rotation as Rotation
	width as long
	height as long
	mwidth as long
	mheight as long
end type

type XRRNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
end type

type XRROutputChangeNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	output as RROutput
	crtc as RRCrtc
	mode as RRMode
	rotation as Rotation
	connection as Connection
	subpixel_order as SubpixelOrder
end type

type XRRCrtcChangeNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	crtc as RRCrtc
	mode as RRMode
	rotation as Rotation
	x as long
	y as long
	width as ulong
	height as ulong
end type

type XRROutputPropertyNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	output as RROutput
	property as XAtom
	timestamp as Time
	state as long
end type

type XRRProviderChangeNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	provider as RRProvider
	timestamp as Time
	current_role as ulong
end type

type XRRProviderPropertyNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	provider as RRProvider
	property as XAtom
	timestamp as Time
	state as long
end type

type XRRResourceChangeNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	subtype as long
	timestamp as Time
end type

type XRRScreenConfiguration as _XRRScreenConfiguration
declare function XRRQueryExtension(byval dpy as Display ptr, byval event_base_return as long ptr, byval error_base_return as long ptr) as long
declare function XRRQueryVersion(byval dpy as Display ptr, byval major_version_return as long ptr, byval minor_version_return as long ptr) as long
declare function XRRGetScreenInfo(byval dpy as Display ptr, byval window as Window) as XRRScreenConfiguration ptr
declare sub XRRFreeScreenConfigInfo(byval config as XRRScreenConfiguration ptr)
declare function XRRSetScreenConfig(byval dpy as Display ptr, byval config as XRRScreenConfiguration ptr, byval draw as Drawable, byval size_index as long, byval rotation as Rotation, byval timestamp as Time) as long
declare function XRRSetScreenConfigAndRate(byval dpy as Display ptr, byval config as XRRScreenConfiguration ptr, byval draw as Drawable, byval size_index as long, byval rotation as Rotation, byval rate as short, byval timestamp as Time) as long
declare function XRRConfigRotations(byval config as XRRScreenConfiguration ptr, byval current_rotation as Rotation ptr) as Rotation
declare function XRRConfigTimes(byval config as XRRScreenConfiguration ptr, byval config_timestamp as Time ptr) as Time
declare function XRRConfigSizes(byval config as XRRScreenConfiguration ptr, byval nsizes as long ptr) as XRRScreenSize ptr
declare function XRRConfigRates(byval config as XRRScreenConfiguration ptr, byval sizeID as long, byval nrates as long ptr) as short ptr
declare function XRRConfigCurrentConfiguration(byval config as XRRScreenConfiguration ptr, byval rotation as Rotation ptr) as SizeID
declare function XRRConfigCurrentRate(byval config as XRRScreenConfiguration ptr) as short
declare function XRRRootToScreen(byval dpy as Display ptr, byval root as Window) as long
declare sub XRRSelectInput(byval dpy as Display ptr, byval window as Window, byval mask as long)
declare function XRRRotations(byval dpy as Display ptr, byval screen as long, byval current_rotation as Rotation ptr) as Rotation
declare function XRRSizes(byval dpy as Display ptr, byval screen as long, byval nsizes as long ptr) as XRRScreenSize ptr
declare function XRRRates(byval dpy as Display ptr, byval screen as long, byval sizeID as long, byval nrates as long ptr) as short ptr
declare function XRRTimes(byval dpy as Display ptr, byval screen as long, byval config_timestamp as Time ptr) as Time
declare function XRRGetScreenSizeRange(byval dpy as Display ptr, byval window as Window, byval minWidth as long ptr, byval minHeight as long ptr, byval maxWidth as long ptr, byval maxHeight as long ptr) as long
declare sub XRRSetScreenSize(byval dpy as Display ptr, byval window as Window, byval width as long, byval height as long, byval mmWidth as long, byval mmHeight as long)
type XRRModeFlags as culong

type _XRRModeInfo
	id as RRMode
	width as ulong
	height as ulong
	dotClock as culong
	hSyncStart as ulong
	hSyncEnd as ulong
	hTotal as ulong
	hSkew as ulong
	vSyncStart as ulong
	vSyncEnd as ulong
	vTotal as ulong
	name as zstring ptr
	nameLength as ulong
	modeFlags as XRRModeFlags
end type

type XRRModeInfo as _XRRModeInfo

type _XRRScreenResources
	timestamp as Time
	configTimestamp as Time
	ncrtc as long
	crtcs as RRCrtc ptr
	noutput as long
	outputs as RROutput ptr
	nmode as long
	modes as XRRModeInfo ptr
end type

type XRRScreenResources as _XRRScreenResources
declare function XRRGetScreenResources(byval dpy as Display ptr, byval window as Window) as XRRScreenResources ptr
declare sub XRRFreeScreenResources(byval resources as XRRScreenResources ptr)

type _XRROutputInfo
	timestamp as Time
	crtc as RRCrtc
	name as zstring ptr
	nameLen as long
	mm_width as culong
	mm_height as culong
	connection as Connection
	subpixel_order as SubpixelOrder
	ncrtc as long
	crtcs as RRCrtc ptr
	nclone as long
	clones as RROutput ptr
	nmode as long
	npreferred as long
	modes as RRMode ptr
end type

type XRROutputInfo as _XRROutputInfo
declare function XRRGetOutputInfo(byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval output as RROutput) as XRROutputInfo ptr
declare sub XRRFreeOutputInfo(byval outputInfo as XRROutputInfo ptr)
declare function XRRListOutputProperties(byval dpy as Display ptr, byval output as RROutput, byval nprop as long ptr) as XAtom ptr

type XRRPropertyInfo
	pending as long
	range as long
	immutable as long
	num_values as long
	values as clong ptr
end type

declare function XRRQueryOutputProperty(byval dpy as Display ptr, byval output as RROutput, byval property as XAtom) as XRRPropertyInfo ptr
declare sub XRRConfigureOutputProperty(byval dpy as Display ptr, byval output as RROutput, byval property as XAtom, byval pending as long, byval range as long, byval num_values as long, byval values as clong ptr)
declare sub XRRChangeOutputProperty(byval dpy as Display ptr, byval output as RROutput, byval property as XAtom, byval type as XAtom, byval format as long, byval mode as long, byval data as const ubyte ptr, byval nelements as long)
declare sub XRRDeleteOutputProperty(byval dpy as Display ptr, byval output as RROutput, byval property as XAtom)
declare function XRRGetOutputProperty(byval dpy as Display ptr, byval output as RROutput, byval property as XAtom, byval offset as clong, byval length as clong, byval _delete as long, byval pending as long, byval req_type as XAtom, byval actual_type as XAtom ptr, byval actual_format as long ptr, byval nitems as culong ptr, byval bytes_after as culong ptr, byval prop as ubyte ptr ptr) as long
declare function XRRAllocModeInfo(byval name as const zstring ptr, byval nameLength as long) as XRRModeInfo ptr
declare function XRRCreateMode(byval dpy as Display ptr, byval window as Window, byval modeInfo as XRRModeInfo ptr) as RRMode
declare sub XRRDestroyMode(byval dpy as Display ptr, byval mode as RRMode)
declare sub XRRAddOutputMode(byval dpy as Display ptr, byval output as RROutput, byval mode as RRMode)
declare sub XRRDeleteOutputMode(byval dpy as Display ptr, byval output as RROutput, byval mode as RRMode)
declare sub XRRFreeModeInfo(byval modeInfo as XRRModeInfo ptr)

type _XRRCrtcInfo
	timestamp as Time
	x as long
	y as long
	width as ulong
	height as ulong
	mode as RRMode
	rotation as Rotation
	noutput as long
	outputs as RROutput ptr
	rotations as Rotation
	npossible as long
	possible as RROutput ptr
end type

type XRRCrtcInfo as _XRRCrtcInfo
declare function XRRGetCrtcInfo(byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc) as XRRCrtcInfo ptr
declare sub XRRFreeCrtcInfo(byval crtcInfo as XRRCrtcInfo ptr)
declare function XRRSetCrtcConfig(byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc, byval timestamp as Time, byval x as long, byval y as long, byval mode as RRMode, byval rotation as Rotation, byval outputs as RROutput ptr, byval noutputs as long) as long
declare function XRRGetCrtcGammaSize(byval dpy as Display ptr, byval crtc as RRCrtc) as long

type _XRRCrtcGamma
	size as long
	red as ushort ptr
	green as ushort ptr
	blue as ushort ptr
end type

type XRRCrtcGamma as _XRRCrtcGamma
declare function XRRGetCrtcGamma(byval dpy as Display ptr, byval crtc as RRCrtc) as XRRCrtcGamma ptr
declare function XRRAllocGamma(byval size as long) as XRRCrtcGamma ptr
declare sub XRRSetCrtcGamma(byval dpy as Display ptr, byval crtc as RRCrtc, byval gamma as XRRCrtcGamma ptr)
declare sub XRRFreeGamma(byval gamma as XRRCrtcGamma ptr)
declare function XRRGetScreenResourcesCurrent(byval dpy as Display ptr, byval window as Window) as XRRScreenResources ptr
declare sub XRRSetCrtcTransform(byval dpy as Display ptr, byval crtc as RRCrtc, byval transform as XTransform ptr, byval filter as const zstring ptr, byval params as XFixed ptr, byval nparams as long)

type _XRRCrtcTransformAttributes
	pendingTransform as XTransform
	pendingFilter as zstring ptr
	pendingNparams as long
	pendingParams as XFixed ptr
	currentTransform as XTransform
	currentFilter as zstring ptr
	currentNparams as long
	currentParams as XFixed ptr
end type

type XRRCrtcTransformAttributes as _XRRCrtcTransformAttributes
declare function XRRGetCrtcTransform(byval dpy as Display ptr, byval crtc as RRCrtc, byval attributes as XRRCrtcTransformAttributes ptr ptr) as long
declare function XRRUpdateConfiguration(byval event as XEvent ptr) as long

type _XRRPanning
	timestamp as Time
	left as ulong
	top as ulong
	width as ulong
	height as ulong
	track_left as ulong
	track_top as ulong
	track_width as ulong
	track_height as ulong
	border_left as long
	border_top as long
	border_right as long
	border_bottom as long
end type

type XRRPanning as _XRRPanning
declare function XRRGetPanning(byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc) as XRRPanning ptr
declare sub XRRFreePanning(byval panning as XRRPanning ptr)
declare function XRRSetPanning(byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc, byval panning as XRRPanning ptr) as long
declare sub XRRSetOutputPrimary(byval dpy as Display ptr, byval window as Window, byval output as RROutput)
declare function XRRGetOutputPrimary(byval dpy as Display ptr, byval window as Window) as RROutput

type _XRRProviderResources
	timestamp as Time
	nproviders as long
	providers as RRProvider ptr
end type

type XRRProviderResources as _XRRProviderResources
declare function XRRGetProviderResources(byval dpy as Display ptr, byval window as Window) as XRRProviderResources ptr
declare sub XRRFreeProviderResources(byval resources as XRRProviderResources ptr)

type _XRRProviderInfo
	capabilities as ulong
	ncrtcs as long
	crtcs as RRCrtc ptr
	noutputs as long
	outputs as RROutput ptr
	name as zstring ptr
	nassociatedproviders as long
	associated_providers as RRProvider ptr
	associated_capability as ulong ptr
	nameLen as long
end type

type XRRProviderInfo as _XRRProviderInfo
declare function XRRGetProviderInfo(byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval provider as RRProvider) as XRRProviderInfo ptr
declare sub XRRFreeProviderInfo(byval provider as XRRProviderInfo ptr)
declare function XRRSetProviderOutputSource(byval dpy as Display ptr, byval provider as XID, byval source_provider as XID) as long
declare function XRRSetProviderOffloadSink(byval dpy as Display ptr, byval provider as XID, byval sink_provider as XID) as long
declare function XRRListProviderProperties(byval dpy as Display ptr, byval provider as RRProvider, byval nprop as long ptr) as XAtom ptr
declare function XRRQueryProviderProperty(byval dpy as Display ptr, byval provider as RRProvider, byval property as XAtom) as XRRPropertyInfo ptr
declare sub XRRConfigureProviderProperty(byval dpy as Display ptr, byval provider as RRProvider, byval property as XAtom, byval pending as long, byval range as long, byval num_values as long, byval values as clong ptr)
declare sub XRRChangeProviderProperty(byval dpy as Display ptr, byval provider as RRProvider, byval property as XAtom, byval type as XAtom, byval format as long, byval mode as long, byval data as const ubyte ptr, byval nelements as long)
declare sub XRRDeleteProviderProperty(byval dpy as Display ptr, byval provider as RRProvider, byval property as XAtom)
declare function XRRGetProviderProperty(byval dpy as Display ptr, byval provider as RRProvider, byval property as XAtom, byval offset as clong, byval length as clong, byval _delete as long, byval pending as long, byval req_type as XAtom, byval actual_type as XAtom ptr, byval actual_format as long ptr, byval nitems as culong ptr, byval bytes_after as culong ptr, byval prop as ubyte ptr ptr) as long

end extern
