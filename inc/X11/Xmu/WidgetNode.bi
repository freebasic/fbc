'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1990, 1998  The Open Group
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

#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XmuWidgetNode_h

type _XmuWidgetNode
	label as zstring ptr
	widget_class_ptr as WidgetClass ptr
	superclass as _XmuWidgetNode ptr
	children as _XmuWidgetNode ptr
	siblings as _XmuWidgetNode ptr
	lowered_label as zstring ptr
	lowered_classname as zstring ptr
	have_resources as long
	resources as XtResourceList
	resourcewn as _XmuWidgetNode ptr ptr
	nresources as Cardinal
	constraints as XtResourceList
	constraintwn as _XmuWidgetNode ptr ptr
	nconstraints as Cardinal
	data as XtPointer
end type

type XmuWidgetNode as _XmuWidgetNode
#define XmuWnClass(wn) (wn)->widget_class_ptr[0]
#define XmuWnClassname(wn) XmuWnClass(wn)->core_class.class_name
#define XmuWnSuperclass(wn) XmuWnClass(wn)->core_class.superclass

declare sub XmuWnInitializeNodes(byval nodearray as XmuWidgetNode ptr, byval nnodes as long)
declare sub XmuWnFetchResources(byval node as XmuWidgetNode ptr, byval toplevel as Widget, byval topnode as XmuWidgetNode ptr)
declare function XmuWnCountOwnedResources(byval node as XmuWidgetNode ptr, byval ownernode as XmuWidgetNode ptr, byval constraints as long) as long
declare function XmuWnNameToNode(byval nodelist as XmuWidgetNode ptr, byval nnodes as long, byval name as const zstring ptr) as XmuWidgetNode ptr

end extern
