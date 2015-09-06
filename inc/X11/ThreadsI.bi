'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   **********************************************************
''
''   Copyright (c) 1993, Oracle and/or its affiliates. All rights reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/XlibConf.bi"

extern "C"

#define _XtThreadsI_h
type LockPtr as _LockRec ptr
type ThreadAppProc as sub(byval as XtAppContext)
type ThreadAppYieldLockProc as sub(byval as XtAppContext, byval as XBoolean ptr, byval as XBoolean ptr, byval as long ptr)
type ThreadAppRestoreLockProc as sub(byval as XtAppContext, byval as long, byval as XBoolean ptr)

extern _XtProcessLock as sub()
extern _XtProcessUnlock as sub()
extern _XtInitAppLock as sub(byval as XtAppContext)

#macro INIT_APP_LOCK(app)
	if _XtInitAppLock then
		_XtInitAppLock(app)
	end if
#endmacro
#macro FREE_APP_LOCK(app)
	if app andalso app->free_lock then
		app->free_lock(app)
	end if
#endmacro
#macro LOCK_PROCESS
	if _XtProcessLock then
		_XtProcessLock()
	end if
#endmacro
#macro UNLOCK_PROCESS
	if _XtProcessUnlock then
		_XtProcessUnlock()
	end if
#endmacro
#macro LOCK_APP(app)
	if app andalso app->lock then
		app->lock(app)
	end if
#endmacro
#macro UNLOCK_APP(app)
	if app andalso app->unlock then
		app->unlock(app)
	end if
#endmacro
#macro YIELD_APP_LOCK(app, push, pushed, level)
	if app andalso app->yield_lock then
		app->yield_lock(app,push,pushed,level)
	end if
#endmacro
#macro RESTORE_APP_LOCK(app, level, pushed)
	if app andalso app->restore_lock then
		app->restore_lock(app,level,pushed)
	end if
#endmacro
#macro WIDGET_TO_APPCON(w)
	dim as XtAppContext app = iif(w andalso _XtProcessLock, XtWidgetToApplicationContext(w), NULL)
#endmacro
#macro DPY_TO_APPCON(d)
	dim as XtAppContext app = iif(_XtProcessLock, XtDisplayToApplicationContext(d), NULL)
#endmacro

end extern
