'' FreeBASIC binding for iup-3.15
''
'' based on the C header files:
''   Copyright (C) 1994-2015 Tecgraf, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "iup"

#ifdef __FB_WIN32__
	#inclib "gdi32"
	#inclib "user32"
	#inclib "comdlg32"
	#inclib "comctl32"
	#inclib "ole32"
	#inclib "advapi32"
	#inclib "shell32"
	#inclib "uuid"
#else
	#inclib "gtk-x11-2.0"
	#inclib "gdk-x11-2.0"
	#inclib "pangox-1.0"
	#inclib "gdk_pixbuf-2.0"
	#inclib "pango-1.0"
	#inclib "gobject-2.0"
	#inclib "gmodule-2.0"
	#inclib "glib-2.0"
#endif

#include once "iupkey.bi"
#include once "iupdef.bi"

extern "C"

#define __IUP_H
#define IUP_NAME "IUP - Portable User Interface"
#define IUP_COPYRIGHT "Copyright (C) 1994-2015 Tecgraf, PUC-Rio."
#define IUP_DESCRIPTION "Multi-platform toolkit for building graphical user interfaces."
#define IUP_VERSION "3.15"
const IUP_VERSION_NUMBER = 315000
#define IUP_VERSION_DATE "2015/07/06"
type Ihandle as Ihandle_
type Icallback as function(byval as Ihandle ptr) as long

declare function IupOpen(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as long
declare sub IupClose()
declare sub IupImageLibOpen()
declare function IupMainLoop() as long
declare function IupLoopStep() as long
declare function IupLoopStepWait() as long
declare function IupMainLoopLevel() as long
declare sub IupFlush()
declare sub IupExitLoop()
declare function IupRecordInput(byval filename as const zstring ptr, byval mode as long) as long
declare function IupPlayInput(byval filename as const zstring ptr) as long
declare sub IupUpdate(byval ih as Ihandle ptr)
declare sub IupUpdateChildren(byval ih as Ihandle ptr)
declare sub IupRedraw(byval ih as Ihandle ptr, byval children as long)
declare sub IupRefresh(byval ih as Ihandle ptr)
declare sub IupRefreshChildren(byval ih as Ihandle ptr)
declare function IupHelp(byval url as const zstring ptr) as long
declare function IupLoad(byval filename as const zstring ptr) as zstring ptr
declare function IupLoadBuffer(byval buffer as const zstring ptr) as zstring ptr
declare function IupVersion() as zstring ptr
declare function IupVersionDate() as zstring ptr
declare function IupVersionNumber() as long
declare sub IupSetLanguage(byval lng as const zstring ptr)
declare function IupGetLanguage() as zstring ptr
declare sub IupSetLanguageString(byval name as const zstring ptr, byval str as const zstring ptr)
declare sub IupStoreLanguageString(byval name as const zstring ptr, byval str as const zstring ptr)
declare function IupGetLanguageString(byval name as const zstring ptr) as zstring ptr
declare sub IupSetLanguagePack(byval ih as Ihandle ptr)
declare sub IupDestroy(byval ih as Ihandle ptr)
declare sub IupDetach(byval child as Ihandle ptr)
declare function IupAppend(byval ih as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupInsert(byval ih as Ihandle ptr, byval ref_child as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupGetChild(byval ih as Ihandle ptr, byval pos as long) as Ihandle ptr
declare function IupGetChildPos(byval ih as Ihandle ptr, byval child as Ihandle ptr) as long
declare function IupGetChildCount(byval ih as Ihandle ptr) as long
declare function IupGetNextChild(byval ih as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupGetBrother(byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetParent(byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetDialog(byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetDialogChild(byval ih as Ihandle ptr, byval name as const zstring ptr) as Ihandle ptr
declare function IupReparent(byval ih as Ihandle ptr, byval new_parent as Ihandle ptr, byval ref_child as Ihandle ptr) as long
declare function IupPopup(byval ih as Ihandle ptr, byval x as long, byval y as long) as long
declare function IupShow(byval ih as Ihandle ptr) as long
declare function IupShowXY(byval ih as Ihandle ptr, byval x as long, byval y as long) as long
declare function IupHide(byval ih as Ihandle ptr) as long
declare function IupMap(byval ih as Ihandle ptr) as long
declare sub IupUnmap(byval ih as Ihandle ptr)
declare sub IupResetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr)
declare function IupGetAllAttributes(byval ih as Ihandle ptr, byval names as zstring ptr ptr, byval n as long) as long
declare function IupSetAtt(byval handle_name as const zstring ptr, byval ih as Ihandle ptr, byval name as const zstring ptr, ...) as Ihandle ptr
declare function IupSetAttributes(byval ih as Ihandle ptr, byval str as const zstring ptr) as Ihandle ptr
declare function IupGetAttributes(byval ih as Ihandle ptr) as zstring ptr
declare sub IupSetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare sub IupSetStrAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare sub IupSetStrf(byval ih as Ihandle ptr, byval name as const zstring ptr, byval format as const zstring ptr, ...)
declare sub IupSetInt(byval ih as Ihandle ptr, byval name as const zstring ptr, byval value as long)
declare sub IupSetFloat(byval ih as Ihandle ptr, byval name as const zstring ptr, byval value as single)
declare sub IupSetDouble(byval ih as Ihandle ptr, byval name as const zstring ptr, byval value as double)
declare sub IupSetRGB(byval ih as Ihandle ptr, byval name as const zstring ptr, byval r as ubyte, byval g as ubyte, byval b as ubyte)
declare function IupGetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr) as zstring ptr
declare function IupGetInt(byval ih as Ihandle ptr, byval name as const zstring ptr) as long
declare function IupGetInt2(byval ih as Ihandle ptr, byval name as const zstring ptr) as long
declare function IupGetIntInt(byval ih as Ihandle ptr, byval name as const zstring ptr, byval i1 as long ptr, byval i2 as long ptr) as long
declare function IupGetFloat(byval ih as Ihandle ptr, byval name as const zstring ptr) as single
declare function IupGetDouble(byval ih as Ihandle ptr, byval name as const zstring ptr) as double
declare sub IupGetRGB(byval ih as Ihandle ptr, byval name as const zstring ptr, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr)
declare sub IupSetAttributeId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as const zstring ptr)
declare sub IupSetStrAttributeId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as const zstring ptr)
declare sub IupSetStrfId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval format as const zstring ptr, ...)
declare sub IupSetIntId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as long)
declare sub IupSetFloatId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as single)
declare sub IupSetDoubleId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as double)
declare sub IupSetRGBId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval r as ubyte, byval g as ubyte, byval b as ubyte)
declare function IupGetAttributeId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as zstring ptr
declare function IupGetIntId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as long
declare function IupGetFloatId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as single
declare function IupGetDoubleId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as double
declare sub IupGetRGBId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr)
declare sub IupSetAttributeId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare sub IupSetStrAttributeId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare sub IupSetStrfId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval format as const zstring ptr, ...)
declare sub IupSetIntId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as long)
declare sub IupSetFloatId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as single)
declare sub IupSetDoubleId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as double)
declare sub IupSetRGBId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval r as ubyte, byval g as ubyte, byval b as ubyte)
declare function IupGetAttributeId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as zstring ptr
declare function IupGetIntId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as long
declare function IupGetFloatId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as single
declare function IupGetDoubleId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long) as double
declare sub IupGetRGBId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr)
declare sub IupSetGlobal(byval name as const zstring ptr, byval value as const zstring ptr)
declare sub IupSetStrGlobal(byval name as const zstring ptr, byval value as const zstring ptr)
declare function IupGetGlobal(byval name as const zstring ptr) as zstring ptr
declare function IupSetFocus(byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetFocus() as Ihandle ptr
declare function IupPreviousField(byval ih as Ihandle ptr) as Ihandle ptr
declare function IupNextField(byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetCallback(byval ih as Ihandle ptr, byval name as const zstring ptr) as Icallback
declare function IupSetCallback(byval ih as Ihandle ptr, byval name as const zstring ptr, byval func as Icallback) as Icallback
declare function IupSetCallbacks(byval ih as Ihandle ptr, byval name as const zstring ptr, byval func as Icallback, ...) as Ihandle ptr
declare function IupGetFunction(byval name as const zstring ptr) as Icallback
declare function IupSetFunction(byval name as const zstring ptr, byval func as Icallback) as Icallback
declare function IupGetHandle(byval name as const zstring ptr) as Ihandle ptr
declare function IupSetHandle(byval name as const zstring ptr, byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetAllNames(byval names as zstring ptr ptr, byval n as long) as long
declare function IupGetAllDialogs(byval names as zstring ptr ptr, byval n as long) as long
declare function IupGetName(byval ih as Ihandle ptr) as zstring ptr
declare sub IupSetAttributeHandle(byval ih as Ihandle ptr, byval name as const zstring ptr, byval ih_named as Ihandle ptr)
declare function IupGetAttributeHandle(byval ih as Ihandle ptr, byval name as const zstring ptr) as Ihandle ptr
declare function IupGetClassName(byval ih as Ihandle ptr) as zstring ptr
declare function IupGetClassType(byval ih as Ihandle ptr) as zstring ptr
declare function IupGetAllClasses(byval names as zstring ptr ptr, byval n as long) as long
declare function IupGetClassAttributes(byval classname as const zstring ptr, byval names as zstring ptr ptr, byval n as long) as long
declare function IupGetClassCallbacks(byval classname as const zstring ptr, byval names as zstring ptr ptr, byval n as long) as long
declare sub IupSaveClassAttributes(byval ih as Ihandle ptr)
declare sub IupCopyClassAttributes(byval src_ih as Ihandle ptr, byval dst_ih as Ihandle ptr)
declare sub IupSetClassDefaultAttribute(byval classname as const zstring ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare function IupClassMatch(byval ih as Ihandle ptr, byval classname as const zstring ptr) as long
declare function IupCreate(byval classname as const zstring ptr) as Ihandle ptr
declare function IupCreatev(byval classname as const zstring ptr, byval params as any ptr ptr) as Ihandle ptr
declare function IupCreatep(byval classname as const zstring ptr, byval first as any ptr, ...) as Ihandle ptr
declare function IupFill() as Ihandle ptr
declare function IupRadio(byval child as Ihandle ptr) as Ihandle ptr
declare function IupVbox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupVboxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupZbox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupZboxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupHbox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupHboxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupNormalizer(byval ih_first as Ihandle ptr, ...) as Ihandle ptr
declare function IupNormalizerv(byval ih_list as Ihandle ptr ptr) as Ihandle ptr
declare function IupCbox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupCboxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupSbox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupSplit(byval child1 as Ihandle ptr, byval child2 as Ihandle ptr) as Ihandle ptr
declare function IupScrollBox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupGridBox(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupGridBoxv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupExpander(byval child as Ihandle ptr) as Ihandle ptr
declare function IupDetachBox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupBackgroundBox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupFrame(byval child as Ihandle ptr) as Ihandle ptr
declare function IupImage(byval width as long, byval height as long, byval pixmap as const ubyte ptr) as Ihandle ptr
declare function IupImageRGB(byval width as long, byval height as long, byval pixmap as const ubyte ptr) as Ihandle ptr
declare function IupImageRGBA(byval width as long, byval height as long, byval pixmap as const ubyte ptr) as Ihandle ptr
declare function IupItem(byval title as const zstring ptr, byval action as const zstring ptr) as Ihandle ptr
declare function IupSubmenu(byval title as const zstring ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupSeparator() as Ihandle ptr
declare function IupMenu(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupMenuv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupButton(byval title as const zstring ptr, byval action as const zstring ptr) as Ihandle ptr
declare function IupCanvas(byval action as const zstring ptr) as Ihandle ptr
declare function IupDialog(byval child as Ihandle ptr) as Ihandle ptr
declare function IupUser() as Ihandle ptr
declare function IupLabel(byval title as const zstring ptr) as Ihandle ptr
declare function IupList(byval action as const zstring ptr) as Ihandle ptr
declare function IupText(byval action as const zstring ptr) as Ihandle ptr
declare function IupMultiLine(byval action as const zstring ptr) as Ihandle ptr
declare function IupToggle(byval title as const zstring ptr, byval action as const zstring ptr) as Ihandle ptr
declare function IupTimer() as Ihandle ptr
declare function IupClipboard() as Ihandle ptr
declare function IupProgressBar() as Ihandle ptr
declare function IupVal(byval type as const zstring ptr) as Ihandle ptr
declare function IupTabs(byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupTabsv(byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupTree() as Ihandle ptr
declare function IupLink(byval url as const zstring ptr, byval title as const zstring ptr) as Ihandle ptr
declare function IupFlatButton(byval title as const zstring ptr) as Ihandle ptr
declare function IupSpin() as Ihandle ptr
declare function IupSpinbox(byval child as Ihandle ptr) as Ihandle ptr
declare function IupSaveImageAsText(byval ih as Ihandle ptr, byval file_name as const zstring ptr, byval format as const zstring ptr, byval name as const zstring ptr) as long
declare sub IupTextConvertLinColToPos(byval ih as Ihandle ptr, byval lin as long, byval col as long, byval pos as long ptr)
declare sub IupTextConvertPosToLinCol(byval ih as Ihandle ptr, byval pos as long, byval lin as long ptr, byval col as long ptr)
declare function IupConvertXYToPos(byval ih as Ihandle ptr, byval x as long, byval y as long) as long
declare sub IupStoreGlobal(byval name as const zstring ptr, byval value as const zstring ptr)
declare sub IupStoreAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval value as const zstring ptr)
declare sub IupSetfAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval format as const zstring ptr, ...)
declare sub IupStoreAttributeId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as const zstring ptr)
declare sub IupSetfAttributeId(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval f as const zstring ptr, ...)
declare sub IupStoreAttributeId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval value as const zstring ptr)
declare sub IupSetfAttributeId2(byval ih as Ihandle ptr, byval name as const zstring ptr, byval lin as long, byval col as long, byval format as const zstring ptr, ...)
declare function IupTreeSetUserId(byval ih as Ihandle ptr, byval id as long, byval userid as any ptr) as long
declare function IupTreeGetUserId(byval ih as Ihandle ptr, byval id as long) as any ptr
declare function IupTreeGetId(byval ih as Ihandle ptr, byval userid as any ptr) as long
declare sub IupTreeSetAttributeHandle(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval ih_named as Ihandle ptr)
declare sub IupTreeSetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as const zstring ptr)
declare sub IupTreeStoreAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval value as const zstring ptr)
declare function IupTreeGetAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as zstring ptr
declare function IupTreeGetInt(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as long
declare function IupTreeGetFloat(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long) as single
declare sub IupTreeSetfAttribute(byval ih as Ihandle ptr, byval name as const zstring ptr, byval id as long, byval format as const zstring ptr, ...)
declare function IupGetActionName() as const zstring ptr
declare function IupMapFont(byval iupfont as const zstring ptr) as zstring ptr
declare function IupUnMapFont(byval driverfont as const zstring ptr) as zstring ptr
declare function IupFileDlg() as Ihandle ptr
declare function IupMessageDlg() as Ihandle ptr
declare function IupColorDlg() as Ihandle ptr
declare function IupFontDlg() as Ihandle ptr
declare function IupProgressDlg() as Ihandle ptr
declare function IupGetFile(byval arq as zstring ptr) as long
declare sub IupMessage(byval title as const zstring ptr, byval msg as const zstring ptr)
declare sub IupMessagef(byval title as const zstring ptr, byval format as const zstring ptr, ...)
declare function IupAlarm(byval title as const zstring ptr, byval msg as const zstring ptr, byval b1 as const zstring ptr, byval b2 as const zstring ptr, byval b3 as const zstring ptr) as long
declare function IupScanf(byval format as const zstring ptr, ...) as long
declare function IupListDialog(byval type as long, byval title as const zstring ptr, byval size as long, byval list as const zstring ptr ptr, byval op as long, byval max_col as long, byval max_lin as long, byval marks as long ptr) as long
declare function IupGetText(byval title as const zstring ptr, byval text as zstring ptr) as long
declare function IupGetColor(byval x as long, byval y as long, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr) as long
type Iparamcb as function(byval dialog as Ihandle ptr, byval param_index as long, byval user_data as any ptr) as long
declare function IupGetParam(byval title as const zstring ptr, byval action as Iparamcb, byval user_data as any ptr, byval format as const zstring ptr, ...) as long
declare function IupGetParamv(byval title as const zstring ptr, byval action as Iparamcb, byval user_data as any ptr, byval format as const zstring ptr, byval param_count as long, byval param_extra as long, byval param_data as any ptr ptr) as long
declare function IupParamf(byval format as const zstring ptr) as Ihandle ptr
declare function IupParamBox(byval parent as Ihandle ptr, byval params as Ihandle ptr ptr, byval count as long) as Ihandle ptr
declare function IupLayoutDialog(byval dialog as Ihandle ptr) as Ihandle ptr
declare function IupElementPropertiesDialog(byval elem as Ihandle ptr) as Ihandle ptr

const IUP_ERROR = 1
const IUP_NOERROR = 0
const IUP_OPENED = -1
const IUP_INVALID = -1
const IUP_INVALID_ID = -10
const IUP_IGNORE = -1
const IUP_DEFAULT = -2
const IUP_CLOSE = -3
const IUP_CONTINUE = -4
const IUP_CENTER = &hFFFF
const IUP_LEFT = &hFFFE
const IUP_RIGHT = &hFFFD
const IUP_MOUSEPOS = &hFFFC
const IUP_CURRENT = &hFFFB
const IUP_CENTERPARENT = &hFFFA
const IUP_TOP = IUP_LEFT
const IUP_BOTTOM = IUP_RIGHT

enum
	IUP_SHOW
	IUP_RESTORE
	IUP_MINIMIZE
	IUP_MAXIMIZE
	IUP_HIDE
end enum

enum
	IUP_SBUP
	IUP_SBDN
	IUP_SBPGUP
	IUP_SBPGDN
	IUP_SBPOSV
	IUP_SBDRAGV
	IUP_SBLEFT
	IUP_SBRIGHT
	IUP_SBPGLEFT
	IUP_SBPGRIGHT
	IUP_SBPOSH
	IUP_SBDRAGH
end enum

#define IUP_BUTTON1 asc("1")
#define IUP_BUTTON2 asc("2")
#define IUP_BUTTON3 asc("3")
#define IUP_BUTTON4 asc("4")
#define IUP_BUTTON5 asc("5")
#define iup_isshift(_s) (_s[0] = asc("S"))
#define iup_iscontrol(_s) (_s[1] = asc("C"))
#define iup_isbutton1(_s) (_s[2] = asc("1"))
#define iup_isbutton2(_s) (_s[3] = asc("2"))
#define iup_isbutton3(_s) (_s[4] = asc("3"))
#define iup_isdouble(_s) (_s[5] = asc("D"))
#define iup_isalt(_s) (_s[6] = asc("A"))
#define iup_issys(_s) (_s[7] = asc("Y"))
#define iup_isbutton4(_s) (_s[8] = asc("4"))
#define iup_isbutton5(_s) (_s[9] = asc("5"))
#define isshift iup_isshift
#define iscontrol iup_iscontrol
#define isbutton1 iup_isbutton1
#define isbutton2 iup_isbutton2
#define isbutton3 iup_isbutton3
#define isdouble iup_isdouble
#define isalt iup_isalt
#define issys iup_issys
#define isbutton4 iup_isbutton4
#define isbutton5 iup_isbutton5
#define IUP_MASK_FLOAT "[+/-]?(/d+/.?/d*|/./d+)"
#define IUP_MASK_UFLOAT "(/d+/.?/d*|/./d+)"
#define IUP_MASK_EFLOAT "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
#define IUP_MASK_FLOATCOMMA "[+/-]?(/d+/,?/d*|/,/d+)"
#define IUP_MASK_UFLOATCOMMA "(/d+/,?/d*|/,/d+)"
#define IUP_MASK_INT "[+/-]?/d+"
#define IUP_MASK_UINT "/d+"
#define IUPMASK_FLOAT IUP_MASK_FLOAT
#define IUPMASK_UFLOAT IUP_MASK_UFLOAT
#define IUPMASK_EFLOAT IUP_MASK_EFLOAT
#define IUPMASK_INT IUP_MASK_INT
#define IUPMASK_UINT IUP_MASK_UINT
const IUP_GETPARAM_BUTTON1 = -1
const IUP_GETPARAM_INIT = -2
const IUP_GETPARAM_BUTTON2 = -3
const IUP_GETPARAM_BUTTON3 = -4
const IUP_GETPARAM_CLOSE = -5
const IUP_GETPARAM_OK = IUP_GETPARAM_BUTTON1
const IUP_GETPARAM_CANCEL = IUP_GETPARAM_BUTTON2
const IUP_GETPARAM_HELP = IUP_GETPARAM_BUTTON3

enum
	IUP_RECBINARY
	IUP_RECTEXT
end enum

end extern
