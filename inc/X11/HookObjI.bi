'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''
''   Copyright 1994, 1998  The Open Group
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define _XtHookObjI_h
type HookObject as _HookObjRec ptr
type HookObjectClass as _HookObjClassRec ptr
extern hookObjectClass as WidgetClass

type _HookObjPart
	createhook_callbacks as XtCallbackList
	changehook_callbacks as XtCallbackList
	confighook_callbacks as XtCallbackList
	geometryhook_callbacks as XtCallbackList
	destroyhook_callbacks as XtCallbackList
	shells as WidgetList
	num_shells as Cardinal
	max_shells as Cardinal
	screen as Screen ptr
end type

type HookObjPart as _HookObjPart

type _HookObjRec
	object as ObjectPart
	hooks as HookObjPart
end type

type HookObjRec as _HookObjRec

type _HookObjClassPart
	unused as long
end type

type HookObjClassPart as _HookObjClassPart

type _HookObjClassRec
	object_class as ObjectClassPart
	hook_class as HookObjClassPart
end type

type HookObjClassRec as _HookObjClassRec
extern hookObjClassRec as HookObjClassRec

end extern
