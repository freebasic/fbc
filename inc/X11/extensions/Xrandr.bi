''
''
'' Xrandr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xrandr_bi__
#define __Xrandr_bi__

type RRCrtc as XID
type RRMode as XID

type XRRScreenSize
	width as integer
	height as integer
	mwidth as integer
	mheight as integer
end type

type XRRScreenChangeNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	root as Window
	timestamp as Time
	config_timestamp as Time
	size_index as SizeID
	subpixel_order as SubpixelOrder
	rotation as Rotation
	width as integer
	height as integer
	mwidth as integer
	mheight as integer
end type

type XRRNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	subtype as integer
end type

type XRROutputChangeNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	subtype as integer
	output as RROutput
	crtc as RRCrtc
	mode as RRMode
	rotation as Rotation
	connection as Connection
	subpixel_order as SubpixelOrder
end type

type XRRCrtcChangeNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	subtype as integer
	crtc as RRCrtc
	mode as RRMode
	rotation as Rotation
	x as integer
	y as integer
	width as uinteger
	height as uinteger
end type

type XRROutputPropertyNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	subtype as integer
	output as RROutput
	property as Atom
	timestamp as Time
	state as integer
end type

type XRRScreenConfiguration as _XRRScreenConfiguration

declare function XRRQueryExtension cdecl alias "XRRQueryExtension" (byval dpy as Display ptr, byval event_base_return as integer ptr, byval error_base_return as integer ptr) as Bool
declare function XRRQueryVersion cdecl alias "XRRQueryVersion" (byval dpy as Display ptr, byval major_version_return as integer ptr, byval minor_version_return as integer ptr) as Status
declare function XRRGetScreenInfo cdecl alias "XRRGetScreenInfo" (byval dpy as Display ptr, byval window as Window) as XRRScreenConfiguration ptr
declare sub XRRFreeScreenConfigInfo cdecl alias "XRRFreeScreenConfigInfo" (byval config as XRRScreenConfiguration ptr)
declare function XRRSetScreenConfig cdecl alias "XRRSetScreenConfig" (byval dpy as Display ptr, byval config as XRRScreenConfiguration ptr, byval draw as Drawable, byval size_index as integer, byval rotation as Rotation, byval timestamp as Time) as Status
declare function XRRSetScreenConfigAndRate cdecl alias "XRRSetScreenConfigAndRate" (byval dpy as Display ptr, byval config as XRRScreenConfiguration ptr, byval draw as Drawable, byval size_index as integer, byval rotation as Rotation, byval rate as short, byval timestamp as Time) as Status
declare function XRRConfigRotations cdecl alias "XRRConfigRotations" (byval config as XRRScreenConfiguration ptr, byval current_rotation as Rotation ptr) as Rotation
declare function XRRConfigTimes cdecl alias "XRRConfigTimes" (byval config as XRRScreenConfiguration ptr, byval config_timestamp as Time ptr) as Time
declare function XRRConfigSizes cdecl alias "XRRConfigSizes" (byval config as XRRScreenConfiguration ptr, byval nsizes as integer ptr) as XRRScreenSize ptr
declare function XRRConfigRates cdecl alias "XRRConfigRates" (byval config as XRRScreenConfiguration ptr, byval sizeID as integer, byval nrates as integer ptr) as short ptr
declare function XRRConfigCurrentConfiguration cdecl alias "XRRConfigCurrentConfiguration" (byval config as XRRScreenConfiguration ptr, byval rotation as Rotation ptr) as SizeID
declare function XRRConfigCurrentRate cdecl alias "XRRConfigCurrentRate" (byval config as XRRScreenConfiguration ptr) as short
declare function XRRRootToScreen cdecl alias "XRRRootToScreen" (byval dpy as Display ptr, byval root as Window) as integer
declare sub XRRSelectInput cdecl alias "XRRSelectInput" (byval dpy as Display ptr, byval window as Window, byval mask as integer)
declare function XRRRotations cdecl alias "XRRRotations" (byval dpy as Display ptr, byval screen as integer, byval current_rotation as Rotation ptr) as Rotation
declare function XRRSizes cdecl alias "XRRSizes" (byval dpy as Display ptr, byval screen as integer, byval nsizes as integer ptr) as XRRScreenSize ptr
declare function XRRRates cdecl alias "XRRRates" (byval dpy as Display ptr, byval screen as integer, byval sizeID as integer, byval nrates as integer ptr) as short ptr
declare function XRRTimes cdecl alias "XRRTimes" (byval dpy as Display ptr, byval screen as integer, byval config_timestamp as Time ptr) as Time
declare function XRRGetScreenSizeRange cdecl alias "XRRGetScreenSizeRange" (byval dpy as Display ptr, byval window as Window, byval minWidth as integer ptr, byval minHeight as integer ptr, byval maxWidth as integer ptr, byval maxHeight as integer ptr) as Status
declare sub XRRSetScreenSize cdecl alias "XRRSetScreenSize" (byval dpy as Display ptr, byval window as Window, byval width as integer, byval height as integer, byval mmWidth as integer, byval mmHeight as integer)

type XRRModeFlags as uinteger

type _XRRModeInfo
	id as RRMode
	width as uinteger
	height as uinteger
	dotClock as uinteger
	hSyncStart as uinteger
	hSyncEnd as uinteger
	hTotal as uinteger
	hSkew as uinteger
	vSyncStart as uinteger
	vSyncEnd as uinteger
	vTotal as uinteger
	name as zstring ptr
	nameLength as uinteger
	modeFlags as XRRModeFlags
end type

type XRRModeInfo as _XRRModeInfo

type _XRRScreenResources
	timestamp as Time
	configTimestamp as Time
	ncrtc as integer
	crtcs as RRCrtc ptr
	noutput as integer
	outputs as RROutput ptr
	nmode as integer
	modes as XRRModeInfo ptr
end type

type XRRScreenResources as _XRRScreenResources

declare function XRRGetScreenResources cdecl alias "XRRGetScreenResources" (byval dpy as Display ptr, byval window as Window) as XRRScreenResources ptr
declare sub XRRFreeScreenResources cdecl alias "XRRFreeScreenResources" (byval resources as XRRScreenResources ptr)

type _XRROutputInfo
	timestamp as Time
	crtc as RRCrtc
	name as zstring ptr
	nameLen as integer
	mm_width as uinteger
	mm_height as uinteger
	connection as Connection
	subpixel_order as SubpixelOrder
	ncrtc as integer
	crtcs as RRCrtc ptr
	nclone as integer
	clones as RROutput ptr
	nmode as integer
	npreferred as integer
	modes as RRMode ptr
end type

type XRROutputInfo as _XRROutputInfo

declare function XRRGetOutputInfo cdecl alias "XRRGetOutputInfo" (byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval output as RROutput) as XRROutputInfo ptr
declare sub XRRFreeOutputInfo cdecl alias "XRRFreeOutputInfo" (byval outputInfo as XRROutputInfo ptr)
declare function XRRListOutputProperties cdecl alias "XRRListOutputProperties" (byval dpy as Display ptr, byval output as RROutput, byval nprop as integer ptr) as Atom ptr

type XRRPropertyInfo
	pending as Bool
	range as Bool
	immutable as Bool
	num_values as integer
	values as integer ptr
end type

declare function XRRQueryOutputProperty cdecl alias "XRRQueryOutputProperty" (byval dpy as Display ptr, byval output as RROutput, byval property as Atom) as XRRPropertyInfo ptr
declare sub XRRConfigureOutputProperty cdecl alias "XRRConfigureOutputProperty" (byval dpy as Display ptr, byval output as RROutput, byval property as Atom, byval pending as Bool, byval range as Bool, byval num_values as integer, byval values as integer ptr)
declare sub XRRDeleteOutputProperty cdecl alias "XRRDeleteOutputProperty" (byval dpy as Display ptr, byval output as RROutput, byval property as Atom)
declare function XRRGetOutputProperty cdecl alias "XRRGetOutputProperty" (byval dpy as Display ptr, byval output as RROutput, byval property as Atom, byval offset as integer, byval length as integer, byval _delete as Bool, byval pending as Bool, byval req_type as Atom, byval actual_type as Atom ptr, byval actual_format as integer ptr, byval nitems as uinteger ptr, byval bytes_after as uinteger ptr, byval prop as ubyte ptr ptr) as integer
declare function XRRAllocModeInfo cdecl alias "XRRAllocModeInfo" (byval name as zstring ptr, byval nameLength as integer) as XRRModeInfo ptr
declare function XRRCreateMode cdecl alias "XRRCreateMode" (byval dpy as Display ptr, byval window as Window, byval modeInfo as XRRModeInfo ptr) as RRMode
declare sub XRRDestroyMode cdecl alias "XRRDestroyMode" (byval dpy as Display ptr, byval mode as RRMode)
declare sub XRRAddOutputMode cdecl alias "XRRAddOutputMode" (byval dpy as Display ptr, byval output as RROutput, byval mode as RRMode)
declare sub XRRDeleteOutputMode cdecl alias "XRRDeleteOutputMode" (byval dpy as Display ptr, byval output as RROutput, byval mode as RRMode)
declare sub XRRFreeModeInfo cdecl alias "XRRFreeModeInfo" (byval modeInfo as XRRModeInfo ptr)

type _XRRCrtcInfo
	timestamp as Time
	x as integer
	y as integer
	width as uinteger
	height as uinteger
	mode as RRMode
	rotation as Rotation
	noutput as integer
	outputs as RROutput ptr
	rotations as Rotation
	npossible as integer
	possible as RROutput ptr
end type

type XRRCrtcInfo as _XRRCrtcInfo

declare function XRRGetCrtcInfo cdecl alias "XRRGetCrtcInfo" (byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc) as XRRCrtcInfo ptr
declare sub XRRFreeCrtcInfo cdecl alias "XRRFreeCrtcInfo" (byval crtcInfo as XRRCrtcInfo ptr)
declare function XRRSetCrtcConfig cdecl alias "XRRSetCrtcConfig" (byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc, byval timestamp as Time, byval x as integer, byval y as integer, byval mode as RRMode, byval rotation as Rotation, byval outputs as RROutput ptr, byval noutputs as integer) as Status
declare function XRRGetCrtcGammaSize cdecl alias "XRRGetCrtcGammaSize" (byval dpy as Display ptr, byval crtc as RRCrtc) as integer

type _XRRCrtcGamma
	size as integer
	red as ushort ptr
	green as ushort ptr
	blue as ushort ptr
end type

type XRRCrtcGamma as _XRRCrtcGamma

declare function XRRGetCrtcGamma cdecl alias "XRRGetCrtcGamma" (byval dpy as Display ptr, byval crtc as RRCrtc) as XRRCrtcGamma ptr
declare function XRRAllocGamma cdecl alias "XRRAllocGamma" (byval size as integer) as XRRCrtcGamma ptr
declare sub XRRSetCrtcGamma cdecl alias "XRRSetCrtcGamma" (byval dpy as Display ptr, byval crtc as RRCrtc, byval gamma as XRRCrtcGamma ptr)
declare sub XRRFreeGamma cdecl alias "XRRFreeGamma" (byval gamma as XRRCrtcGamma ptr)
declare function XRRGetScreenResourcesCurrent cdecl alias "XRRGetScreenResourcesCurrent" (byval dpy as Display ptr, byval window as Window) as XRRScreenResources ptr
declare sub XRRSetCrtcTransform cdecl alias "XRRSetCrtcTransform" (byval dpy as Display ptr, byval crtc as RRCrtc, byval transform as XTransform ptr, byval filter as zstring ptr, byval params as XFixed ptr, byval nparams as integer)

type _XRRCrtcTransformAttributes
	pendingTransform as XTransform
	pendingFilter as zstring ptr
	pendingNparams as integer
	pendingParams as XFixed ptr
	currentTransform as XTransform
	currentFilter as zstring ptr
	currentNparams as integer
	currentParams as XFixed ptr
end type

type XRRCrtcTransformAttributes as _XRRCrtcTransformAttributes

declare function XRRGetCrtcTransform cdecl alias "XRRGetCrtcTransform" (byval dpy as Display ptr, byval crtc as RRCrtc, byval attributes as XRRCrtcTransformAttributes ptr ptr) as Status
declare function XRRUpdateConfiguration cdecl alias "XRRUpdateConfiguration" (byval event as XEvent ptr) as integer

type _XRRPanning
	timestamp as Time
	left as uinteger
	top as uinteger
	width as uinteger
	height as uinteger
	track_left as uinteger
	track_top as uinteger
	track_width as uinteger
	track_height as uinteger
	border_left as integer
	border_top as integer
	border_right as integer
	border_bottom as integer
end type

type XRRPanning as _XRRPanning

declare function XRRGetPanning cdecl alias "XRRGetPanning" (byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc) as XRRPanning ptr
declare sub XRRFreePanning cdecl alias "XRRFreePanning" (byval panning as XRRPanning ptr)
declare function XRRSetPanning cdecl alias "XRRSetPanning" (byval dpy as Display ptr, byval resources as XRRScreenResources ptr, byval crtc as RRCrtc, byval panning as XRRPanning ptr) as Status
declare sub XRRSetOutputPrimary cdecl alias "XRRSetOutputPrimary" (byval dpy as Display ptr, byval window as Window, byval output as RROutput)
declare function XRRGetOutputPrimary cdecl alias "XRRGetOutputPrimary" (byval dpy as Display ptr, byval window as Window) as RROutput

#endif
