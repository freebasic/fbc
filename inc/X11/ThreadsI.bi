#pragma once

#include once "X11/XlibConf.bi"

extern "C"

#define _XtThreadsI_h
type LockPtr as _LockRec ptr
type ThreadAppProc as sub(byval as XtAppContext)
type ThreadAppYieldLockProc as sub(byval as XtAppContext, byval as zstring ptr, byval as zstring ptr, byval as long ptr)
type ThreadAppRestoreLockProc as sub(byval as XtAppContext, byval as long, byval as zstring ptr)

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
