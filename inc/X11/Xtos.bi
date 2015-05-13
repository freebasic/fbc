#pragma once

#include once "crt/long.bi"
#include once "X11/Xalloca.bi"

#define _Xtos_h
#define ALLOCATE_LOCAL_FALLBACK(_size) XtMalloc(cast(culong, (_size)))
#define DEALLOCATE_LOCAL_FALLBACK(_ptr) XtFree(cast(XtPointer, (_ptr)))
