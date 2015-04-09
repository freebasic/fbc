'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#include once "windows.bi"
#include once "windowsx.bi"
#include once "olectl.bi"
#include once "ddraw.bi"
#include once "mmsystem.bi"
#include once "strsafe.bi"
#include once "strmif.bi"
#include once "amvideo.bi"
#include once "control.bi"
#include once "evcode.bi"
#include once "uuids.bi"
#include once "errors.bi"
#include once "audevcod.bi"

#define __DSHOW_INCLUDED__
#define AM_NOVTABLE
#define NO_SHLWAPI_STRFCNS
#define NUMELMS(array) (sizeof((array)) / sizeof((array)[0]))
const OATRUE = -1
const OAFALSE = 0
