''
''
'' dshow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dshow_bi__
#define __win_dshow_bi__

#include once "windows.bi"
#include once "win/olectl.bi"
#include once "win/ddraw.bi"
#include once "win/mmsystem.bi"
#include once "win/strmif.bi"
#include once "win/amvideo.bi"
#include once "win/amaudio.bi"
#include once "win/control.bi"
#include once "win/evcode.bi"
#include once "win/uuids.bi"
#include once "win/errors.bi"
#include once "win/edevdefs.bi"
#include once "win/audevcod.bi"
#include once "win/dvdevcod.bi"

#ifndef OATRUE
#define OATRUE (-1)
#define OAFALSE (0)
#endif

#ifndef InterlockedExchangePointer
#define InterlockedExchangePointer(Target, Value) cast( PVOID, InterlockedExchange( cast( PLONG, Target ), cast( LONG, Value ) ) )
#endif 

#endif
