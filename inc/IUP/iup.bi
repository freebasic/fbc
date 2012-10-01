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

#include once "iupkey.bi"
#include once "iupdef.bi"

#define IUP_COPYRIGHT "Copyright (C) 1994-2005 Tecgraf/PUC-Rio and PETROBRAS S/A"
#define IUP_RELEASE_VERSION "2.3.0"
#define IUP_RELEASE_DATE "2005/03/16"
#define IUP_RELEASE_NUMBER 203000

type Ihandle as any
type Icallback as function cdecl(byval as Ihandle ptr, ...) as integer

extern "c"
declare function IupGetFile (byval arq as zstring ptr) as integer
declare sub IupMessage (byval title as zstring ptr, byval msg as zstring ptr)
declare sub IupMessagef (byval title as zstring ptr, byval format as zstring ptr, ...)
declare function IupAlarm (byval title as zstring ptr, byval msg as zstring ptr, byval b1 as zstring ptr, byval b2 as zstring ptr, byval b3 as zstring ptr) as integer
declare function IupScanf (byval format as zstring ptr, ...) as integer
declare function IupListDialog (byval type as integer, byval title as zstring ptr, byval size as integer, byval lst as byte ptr ptr, byval op as integer, byval col as integer, byval line as integer, byval marks as integer ptr) as integer
declare function IupGetText (byval title as zstring ptr, byval text as zstring ptr) as integer
declare function IupMapFont (byval iupfont as zstring ptr) as zstring ptr
declare function IupUnMapFont (byval driverfont as zstring ptr) as zstring ptr
declare function IupMainLoop () as integer
declare function IupLoopStep () as integer
declare function IupOpen () as integer
declare sub IupClose ()
declare sub IupFlush ()
declare function IupHelp (byval url as zstring ptr) as integer
declare function IupVersion () as zstring ptr
declare function IupVersionDate () as zstring ptr
declare function IupVersionNumber () as integer
declare sub IupDetach (byval n as Ihandle ptr)
declare function IupAppend (byval box as Ihandle ptr, byval exp as Ihandle ptr) as Ihandle ptr
declare function IupGetNextChild (byval parent as Ihandle ptr, byval next as Ihandle ptr) as Ihandle ptr
declare function IupGetBrother (byval brother as Ihandle ptr) as Ihandle ptr
declare function IupGetParent (byval child as Ihandle ptr) as Ihandle ptr
declare sub IupDestroy (byval n as Ihandle ptr)
declare function IupPopup (byval n as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupShow (byval n as Ihandle ptr) as integer
declare function IupShowXY (byval n as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupHide (byval n as Ihandle ptr) as integer
declare function IupMap (byval n as Ihandle ptr) as integer
declare function IupSetFocus (byval n as Ihandle ptr) as Ihandle ptr
declare function IupGetFocus () as Ihandle ptr
declare sub IupSetLanguage (byval lng as zstring ptr)
declare function IupGetLanguage () as zstring ptr
declare function IupLoad (byval fn as zstring ptr) as zstring ptr
declare sub IupSetAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval v as zstring ptr)
declare sub IupStoreAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval v as zstring ptr)
declare function IupSetAttributes (byval n as Ihandle ptr, byval e as zstring ptr) as Ihandle ptr
declare function IupGetAttribute (byval n as Ihandle ptr, byval a as zstring ptr) as zstring ptr
declare function IupGetAttributes (byval n as Ihandle ptr) as zstring ptr
declare function IupGetInt (byval n as Ihandle ptr, byval a as zstring ptr) as integer
declare function IupGetInt2 (byval n as Ihandle ptr, byval a as zstring ptr) as integer
declare function IupGetFloat (byval n as Ihandle ptr, byval a as zstring ptr) as single
declare sub IupSetfAttribute (byval n as Ihandle ptr, byval a as zstring ptr, byval f as zstring ptr, ...)
declare sub IupSetGlobal (byval key as zstring ptr, byval value as zstring ptr)
declare sub IupStoreGlobal (byval key as zstring ptr, byval value as zstring ptr)
declare function IupGetGlobal (byval key as zstring ptr) as zstring ptr
declare function IupPreviousField (byval h as Ihandle ptr) as Ihandle ptr
declare function IupNextField (byval h as Ihandle ptr) as Ihandle ptr
declare function IupGetFunction (byval n as zstring ptr) as Icallback
declare function IupSetFunction (byval n as zstring ptr, byval fa as Icallback) as Icallback
declare function IupGetActionName () as zstring ptr
declare function IupGetDialog (byval n as Ihandle ptr) as Ihandle ptr
declare function IupGetHandle (byval name as zstring ptr) as Ihandle ptr
declare function IupSetHandle (byval name as zstring ptr, byval exp as Ihandle ptr) as Ihandle ptr
declare function IupGetAllNames (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetAllDialogs (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetName (byval n as Ihandle ptr) as zstring ptr
declare function IupGetType (byval n as Ihandle ptr) as zstring ptr
declare function IupCreate (byval class_name as zstring ptr) as Ihandle ptr
declare function IupCreatev (byval name as zstring ptr, byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupCreatep (byval name as zstring ptr, byval first as Ihandle ptr, ...) as Ihandle ptr
declare function IupVbox (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupZbox (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupHbox (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupFill () as Ihandle ptr
declare function IupRadio (byval exp as Ihandle ptr) as Ihandle ptr
declare function IupFrame (byval exp as Ihandle ptr) as Ihandle ptr
declare function IupColor (byval r as uinteger, byval g as uinteger, byval b as uinteger) as Ihandle ptr
declare function IupImage (byval width as uinteger, byval height as uinteger, byval pixmap as zstring ptr) as Ihandle ptr
declare function IupButton (byval label as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupCanvas (byval repaint as zstring ptr) as Ihandle ptr
declare function IupDialog (byval exp as Ihandle ptr) as Ihandle ptr
declare function IupUser () as Ihandle ptr
declare function IupItem (byval label as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupSubmenu (byval label as zstring ptr, byval exp as Ihandle ptr) as Ihandle ptr
declare function IupSeparator () as Ihandle ptr
declare function IupLabel (byval label as zstring ptr) as Ihandle ptr
declare function IupList (byval action as zstring ptr) as Ihandle ptr
declare function IupMenu (byval exp as Ihandle ptr, ...) as Ihandle ptr
declare function IupText (byval action as zstring ptr) as Ihandle ptr
declare function IupMultiLine (byval action as zstring ptr) as Ihandle ptr
declare function IupToggle (byval label as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupFileDlg () as Ihandle ptr
declare function IupTimer () as Ihandle ptr
end extern

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
