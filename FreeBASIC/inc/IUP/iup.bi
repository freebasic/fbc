''
''
'' iup -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iup_bi__
#define __iup_bi__

#inclib "iup"

#include once "IUP/iupkey.bi"
#include once "IUP/iupdef.bi"

#define IUP_COPYRIGHT "Copyright (C) 1994-2005 Tecgraf/PUC-Rio and PETROBRAS S/A"
#define IUP_RELEASE_VERSION "2.3.0"
#define IUP_RELEASE_DATE "2005/03/16"
#define IUP_RELEASE_NUMBER 203000

type Ihandle as any
type Icallback as function cdecl(byval as Ihandle ptr, ...) as integer

declare function IupGetFile cdecl alias "IupGetFile" (byval arq as zstring ptr) as integer
declare sub IupMessage cdecl alias "IupMessage" (byval title as zstring ptr, byval msg as zstring ptr)
declare sub IupMessagef cdecl alias "IupMessagef" (byval title as zstring ptr, byval format as zstring ptr, ...)
declare function IupAlarm cdecl alias "IupAlarm" (byval title as zstring ptr, byval msg as zstring ptr, byval b1 as zstring ptr, byval b2 as zstring ptr, byval b3 as zstring ptr) as integer
declare function IupScanf cdecl alias "IupScanf" (byval format as zstring ptr, ...) as integer
declare function IupListDialog cdecl alias "IupListDialog" (byval type as integer, byval title as zstring ptr, byval size as integer, byval lst as byte ptr ptr, byval op as integer, byval col as integer, byval line as integer, byval marks as integer ptr) as integer
declare function IupGetText cdecl alias "IupGetText" (byval title as zstring ptr, byval text as zstring ptr) as integer
declare function IupMapFont cdecl alias "IupMapFont" (byval iupfont as zstring ptr) as zstring ptr
declare function IupUnMapFont cdecl alias "IupUnMapFont" (byval driverfont as zstring ptr) as zstring ptr
declare function IupMainLoop cdecl alias "IupMainLoop" () as integer
declare function IupLoopStep cdecl alias "IupLoopStep" () as integer
declare function IupOpen cdecl alias "IupOpen" () as integer
declare sub IupClose cdecl alias "IupClose" ()
declare sub IupFlush cdecl alias "IupFlush" ()
declare function IupHelp cdecl alias "IupHelp" (byval url as zstring ptr) as integer
declare function IupVersion cdecl alias "IupVersion" () as zstring ptr
declare function IupVersionDate cdecl alias "IupVersionDate" () as zstring ptr
declare function IupVersionNumber cdecl alias "IupVersionNumber" () as integer
declare sub IupDetach cdecl alias "IupDetach" (byval n as Ihandle ptr)
declare function IupAppend cdecl alias "IupAppend" (byval box as Ihandle ptr, byval exp as Ihandle ptr) as Ihandle ptr
declare function IupGetNextChild cdecl alias "IupGetNextChild" (byval parent as Ihandle ptr, byval next as Ihandle ptr) as Ihandle ptr
declare function IupGetBrother cdecl alias "IupGetBrother" (byval brother as Ihandle ptr) as Ihandle ptr
declare function IupGetParent cdecl alias "IupGetParent" (byval child as Ihandle ptr) as Ihandle ptr
declare sub IupDestroy cdecl alias "IupDestroy" (byval n as Ihandle ptr)
declare function IupPopup cdecl alias "IupPopup" (byval n as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupShow cdecl alias "IupShow" (byval n as Ihandle ptr) as integer
declare function IupShowXY cdecl alias "IupShowXY" (byval n as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupHide cdecl alias "IupHide" (byval n as Ihandle ptr) as integer
declare function IupMap cdecl alias "IupMap" (byval n as Ihandle ptr) as integer
declare function IupSetFocus cdecl alias "IupSetFocus" (byval n as Ihandle ptr) as Ihandle ptr
declare function IupGetFocus cdecl alias "IupGetFocus" () as Ihandle ptr
declare sub IupSetLanguage cdecl alias "IupSetLanguage" (byval lng as zstring ptr)
declare function IupGetLanguage cdecl alias "IupGetLanguage" () as zstring ptr
declare function IupLoad cdecl alias "IupLoad" (byval fn as zstring ptr) as zstring ptr
declare sub IupSetAttribute cdecl alias "IupSetAttribute" (byval n as Ihandle ptr, byval a as zstring ptr, byval v as zstring ptr)
declare sub IupStoreAttribute cdecl alias "IupStoreAttribute" (byval n as Ihandle ptr, byval a as zstring ptr, byval v as zstring ptr)
declare function IupSetAttributes cdecl alias "IupSetAttributes" (byval n as Ihandle ptr, byval e as zstring ptr) as Ihandle ptr
declare function IupGetAttribute cdecl alias "IupGetAttribute" (byval n as Ihandle ptr, byval a as zstring ptr) as zstring ptr
declare function IupGetAttributes cdecl alias "IupGetAttributes" (byval n as Ihandle ptr) as zstring ptr
declare function IupGetInt cdecl alias "IupGetInt" (byval n as Ihandle ptr, byval a as zstring ptr) as integer
declare function IupGetInt2 cdecl alias "IupGetInt2" (byval n as Ihandle ptr, byval a as zstring ptr) as integer
declare function IupGetFloat cdecl alias "IupGetFloat" (byval n as Ihandle ptr, byval a as zstring ptr) as single
declare sub IupSetfAttribute cdecl alias "IupSetfAttribute" (byval n as Ihandle ptr, byval a as zstring ptr, byval f as zstring ptr, ...)
declare sub IupSetGlobal cdecl alias "IupSetGlobal" (byval key as zstring ptr, byval value as zstring ptr)
declare sub IupStoreGlobal cdecl alias "IupStoreGlobal" (byval key as zstring ptr, byval value as zstring ptr)
declare function IupGetGlobal cdecl alias "IupGetGlobal" (byval key as zstring ptr) as zstring ptr
declare function IupPreviousField cdecl alias "IupPreviousField" (byval h as Ihandle ptr) as Ihandle ptr
declare function IupNextField cdecl alias "IupNextField" (byval h as Ihandle ptr) as Ihandle ptr
declare function IupGetFunction cdecl alias "IupGetFunction" (byval n as zstring ptr) as Icallback
declare function IupSetFunction cdecl alias "IupSetFunction" (byval n as zstring ptr, byval fa as Icallback) as Icallback
declare function IupGetActionName cdecl alias "IupGetActionName" () as zstring ptr
declare function IupGetDialog cdecl alias "IupGetDialog" (byval n as Ihandle ptr) as Ihandle ptr
declare function IupGetHandle cdecl alias "IupGetHandle" (byval name as zstring ptr) as Ihandle ptr
declare function IupSetHandle cdecl alias "IupSetHandle" (byval name as zstring ptr, byval exp as Ihandle ptr) as Ihandle ptr
declare function IupGetAllNames cdecl alias "IupGetAllNames" (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetAllDialogs cdecl alias "IupGetAllDialogs" (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetName cdecl alias "IupGetName" (byval n as Ihandle ptr) as zstring ptr
declare function IupGetType cdecl alias "IupGetType" (byval n as Ihandle ptr) as zstring ptr
declare function IupCreate cdecl alias "IupCreate" (byval class_name as zstring ptr) as Ihandle ptr
declare function IupCreatev cdecl alias "IupCreatev" (byval name as zstring ptr, byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupCreatep cdecl alias "IupCreatep" (byval name as zstring ptr, byval first as Ihandle ptr, ...) as Ihandle ptr
declare function IupVbox cdecl alias "IupVbox" (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupZbox cdecl alias "IupZbox" (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupHbox cdecl alias "IupHbox" (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupFill cdecl alias "IupFill" () as Ihandle ptr
declare function IupRadio cdecl alias "IupRadio" (byval exp as Ihandle ptr) as Ihandle ptr
declare function IupFrame cdecl alias "IupFrame" (byval exp as Ihandle ptr) as Ihandle ptr
declare function IupColor cdecl alias "IupColor" (byval r as uinteger, byval g as uinteger, byval b as uinteger) as Ihandle ptr
declare function IupImage cdecl alias "IupImage" (byval width as uinteger, byval height as uinteger, byval pixmap as zstring ptr) as Ihandle ptr
declare function IupButton cdecl alias "IupButton" (byval label as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupCanvas cdecl alias "IupCanvas" (byval repaint as zstring ptr) as Ihandle ptr
declare function IupDialog cdecl alias "IupDialog" (byval exp as Ihandle ptr) as Ihandle ptr
declare function IupUser cdecl alias "IupUser" () as Ihandle ptr
declare function IupItem cdecl alias "IupItem" (byval label as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupSubmenu cdecl alias "IupSubmenu" (byval label as zstring ptr, byval exp as Ihandle ptr) as Ihandle ptr
declare function IupSeparator cdecl alias "IupSeparator" () as Ihandle ptr
declare function IupLabel cdecl alias "IupLabel" (byval label as zstring ptr) as Ihandle ptr
declare function IupList cdecl alias "IupList" (byval action as zstring ptr) as Ihandle ptr
declare function IupMenu cdecl alias "IupMenu" (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupText cdecl alias "IupText" (byval action as zstring ptr) as Ihandle ptr
declare function IupMultiLine cdecl alias "IupMultiLine" (byval action as zstring ptr) as Ihandle ptr
declare function IupToggle cdecl alias "IupToggle" (byval label as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupFileDlg cdecl alias "IupFileDlg" () as Ihandle ptr
declare function IupTimer cdecl alias "IupTimer" () as Ihandle ptr

#define IUP_ERROR 1
#define IUP_NOERROR 0
#define IUP_IGNORE -1
#define IUP_DEFAULT -2
#define IUP_CLOSE -3
#define IUP_CONTINUE -4
#define IUP_CENTER -1
#define IUP_LEFT -2
#define IUP_RIGHT -3
#define IUP_ANYWHERE -4
#define IUP_MOUSEPOS -5
#define IUP_TOP -2
#define IUP_BOTTOM -3
#define IUP_SBUP 1
#define IUP_SBDN 2
#define IUP_SBPGUP 3
#define IUP_SBPGDN 4
#define IUP_SBPOSV 5
#define IUP_SBPGLEFT 6
#define IUP_SBPGRIGHT 7
#define IUP_SBLEFT 8
#define IUP_SBRIGHT 9
#define IUP_SBPOSH 10
#define IUP_SBDRAGH 11
#define IUP_SBDRAGV 12
#define IUP_SHOW 0
#define IUP_RESTORE 1
#define IUP_MINIMIZE 2
#define IUP_BUTTON1 asc("1")
#define IUP_BUTTON2 asc("2")
#define IUP_BUTTON3 asc("3")

#endif
