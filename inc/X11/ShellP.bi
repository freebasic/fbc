'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1994, 1998  The Open Group
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
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Shell.bi"

extern "C"

#define _XtShellPrivate_h

type ShellClassPart
	extension as XtPointer
end type

type ShellClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as clong
	record_size as Cardinal
	root_geometry_manager as XtGeometryHandler
end type

type ShellClassExtension as ShellClassExtensionRec ptr
const XtShellExtensionVersion = cast(clong, 1)
#define XtInheritRootGeometryManager cast(XtGeometryHandler, _XtInherit)

type _ShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
end type

type ShellClassRec as _ShellClassRec
extern shellClassRec as ShellClassRec

type ShellPart
	geometry as zstring ptr
	create_popup_child_proc as XtCreatePopupChildProc
	grab_kind as XtGrabKind
	spring_loaded as XBoolean
	popped_up as XBoolean
	allow_shell_resize as XBoolean
	client_specified as XBoolean
	save_under as XBoolean
	override_redirect as XBoolean
	popup_callback as XtCallbackList
	popdown_callback as XtCallbackList
	visual as Visual ptr
end type

const _XtShellPositionValid = cast(XBoolean, 1 shl 0)
const _XtShellNotReparented = cast(XBoolean, 1 shl 1)
const _XtShellPPositionOK = cast(XBoolean, 1 shl 2)
const _XtShellGeometryParsed = cast(XBoolean, 1 shl 3)

type ShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
end type

type ShellWidget as ShellRec ptr

type OverrideShellClassPart
	extension as XtPointer
end type

type _OverrideShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	override_shell_class as OverrideShellClassPart
end type

type OverrideShellClassRec as _OverrideShellClassRec
extern overrideShellClassRec as OverrideShellClassRec

type OverrideShellPart
	frabjous as long
end type

type OverrideShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	override as OverrideShellPart
end type

type OverrideShellWidget as OverrideShellRec ptr

type WMShellClassPart
	extension as XtPointer
end type

type _WMShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
end type

type WMShellClassRec as _WMShellClassRec
extern wmShellClassRec as WMShellClassRec

type WMShellPart__OldXSizeHints_min_aspect
	x as long
	y as long
end type

type _OldXSizeHints
	flags as clong
	x as long
	y as long
	width as long
	height as long
	min_width as long
	min_height as long
	max_width as long
	max_height as long
	width_inc as long
	height_inc as long
	min_aspect as WMShellPart__OldXSizeHints_min_aspect
	max_aspect as WMShellPart__OldXSizeHints_min_aspect
end type

type WMShellPart
	title as zstring ptr
	wm_timeout as long
	wait_for_wm as XBoolean
	transient as XBoolean
	urgency as XBoolean
	client_leader as Widget
	window_role as String_
	size_hints as _OldXSizeHints
	wm_hints as XWMHints
	base_width as long
	base_height as long
	win_gravity as long
	title_encoding as XAtom
end type

type WMShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
end type

type WMShellWidget as WMShellRec ptr

end extern

#include once "X11/VendorP.bi"

extern "C"

type TransientShellClassPart
	extension as XtPointer
end type

type _TransientShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
	vendor_shell_class as VendorShellClassPart
	transient_shell_class as TransientShellClassPart
end type

type TransientShellClassRec as _TransientShellClassRec
extern transientShellClassRec as TransientShellClassRec

type TransientShellPart
	transient_for as Widget
end type

type TransientShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
	vendor as VendorShellPart
	transient as TransientShellPart
end type

type TransientShellWidget as TransientShellRec ptr

type TopLevelShellClassPart
	extension as XtPointer
end type

type _TopLevelShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
	vendor_shell_class as VendorShellClassPart
	top_level_shell_class as TopLevelShellClassPart
end type

type TopLevelShellClassRec as _TopLevelShellClassRec
extern topLevelShellClassRec as TopLevelShellClassRec

type TopLevelShellPart
	icon_name as zstring ptr
	iconic as XBoolean
	icon_name_encoding as XAtom
end type

type TopLevelShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
	vendor as VendorShellPart
	topLevel as TopLevelShellPart
end type

type TopLevelShellWidget as TopLevelShellRec ptr

type ApplicationShellClassPart
	extension as XtPointer
end type

type _ApplicationShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
	vendor_shell_class as VendorShellClassPart
	top_level_shell_class as TopLevelShellClassPart
	application_shell_class as ApplicationShellClassPart
end type

type ApplicationShellClassRec as _ApplicationShellClassRec
extern applicationShellClassRec as ApplicationShellClassRec

type ApplicationShellPart
	class as zstring ptr
	xrm_class as XrmClass
	argc as long
	argv as zstring ptr ptr
end type

type ApplicationShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
	vendor as VendorShellPart
	topLevel as TopLevelShellPart
	application as ApplicationShellPart
end type

type ApplicationShellWidget as ApplicationShellRec ptr

type SessionShellClassPart
	extension as XtPointer
end type

type _SessionShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
	vendor_shell_class as VendorShellClassPart
	top_level_shell_class as TopLevelShellClassPart
	application_shell_class as ApplicationShellClassPart
	session_shell_class as SessionShellClassPart
end type

type SessionShellClassRec as _SessionShellClassRec
extern sessionShellClassRec as SessionShellClassRec
type XtSaveYourself as _XtSaveYourselfRec ptr

type SessionShellPart
	connection as SmcConn
	session_id as String_
	restart_command as String_ ptr
	clone_command as String_ ptr
	discard_command as String_ ptr
	resign_command as String_ ptr
	shutdown_command as String_ ptr
	environment as String_ ptr
	current_dir as String_
	program_path as String_
	restart_style as ubyte
	checkpoint_state as ubyte
	join_session as XBoolean
	save_callbacks as XtCallbackList
	interact_callbacks as XtCallbackList
	cancel_callbacks as XtCallbackList
	save_complete_callbacks as XtCallbackList
	die_callbacks as XtCallbackList
	error_callbacks as XtCallbackList
	save as XtSaveYourself
	input_id as XtInputId
	ses20 as XtPointer
	ses19 as XtPointer
	ses18 as XtPointer
	ses17 as XtPointer
	ses16 as XtPointer
	ses15 as XtPointer
	ses14 as XtPointer
	ses13 as XtPointer
	ses12 as XtPointer
	ses11 as XtPointer
	ses10 as XtPointer
	ses9 as XtPointer
	ses8 as XtPointer
	ses7 as XtPointer
	ses6 as XtPointer
	ses5 as XtPointer
	ses4 as XtPointer
	ses3 as XtPointer
	ses2 as XtPointer
	ses1 as XtPointer
end type

type SessionShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
	vendor as VendorShellPart
	topLevel as TopLevelShellPart
	application as ApplicationShellPart
	session as SessionShellPart
end type

type SessionShellWidget as SessionShellRec ptr

end extern
