/'* \file
 * \brief User API
 * IUP - A Portable User Interface Toolkit
 * Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
 * http://www.tecgraf.puc-rio.br/iup  mailto:iup@tecgraf.puc-rio.br
 *
 * See Copyright Notice at the end of this file
 '/
#ifndef __iup_bi__
#define __iup_bi__

#include "IUP3/iupkey.bi"
#include "IUP3/iupdef.bi"

#inclib "iup"
#if defined(__FB_WIN32__)
#inclib "gdi32"
#inclib "user32"
#inclib "comdlg32"
#inclib "comctl32"
#inclib "ole32"
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

#define IUP_NAME "IUP - Portable User Interface"
#define IUP_COPYRIGHT "Copyright (C) 1994-2011 Tecgraf, PUC-Rio."
#define IUP_DESCRIPTION "Portable toolkit for building graphical user interfaces."
#define IUP_VERSION "3.5"
#define IUP_VERSION_NUMBER 305000
#define IUP_VERSION_DATE "2011/04/26"

type Ihandle as Ihandle_
type Icallback as function cdecl(byval as Ihandle ptr) as integer

extern "C"

/'***********************************************************************/
/*                        Main API                                      */
/***********************************************************************'/

declare function IupOpen  (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as integer
declare sub IupClose  ()
declare sub IupImageLibOpen  ()

declare function IupMainLoop  () as integer
declare function IupLoopStep  () as integer
declare function IupLoopStepWait  () as integer
declare function IupMainLoopLevel  () as integer
declare sub IupFlush  ()
declare sub IupExitLoop  ()

declare function IupRecordInput  (byval filename as zstring ptr, byval mode as integer) as integer
declare function IupPlayInput  (byval filename as zstring ptr) as integer

declare sub IupUpdate  (byval ih as Ihandle ptr)
declare sub IupUpdateChildren  (byval ih as Ihandle ptr)
declare sub IupRedraw  (byval ih as Ihandle ptr, byval children as integer)
declare sub IupRefresh  (byval ih as Ihandle ptr)
declare sub IupRefreshChildren  (byval ih as Ihandle ptr)

declare function IupMapFont  (byval iupfont as zstring ptr) as zstring ptr
declare function IupUnMapFont  (byval driverfont as zstring ptr) as zstring ptr
declare function IupHelp  (byval url as zstring ptr) as integer
declare function IupLoad  (byval filename as zstring ptr) as zstring ptr
declare function IupLoadBuffer  (byval buffer as zstring ptr) as zstring ptr

declare function IupVersion  () as zstring ptr
declare function IupVersionDate  () as zstring ptr
declare function IupVersionNumber  () as integer
declare sub IupSetLanguage  (byval lng as zstring ptr)
declare function IupGetLanguage  () as zstring ptr

declare sub IupDestroy  (byval ih as Ihandle ptr)
declare sub IupDetach  (byval child as Ihandle ptr)
declare function IupAppend  (byval ih as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupInsert  (byval ih as Ihandle ptr, byval ref_child as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupGetChild  (byval ih as Ihandle ptr, byval pos as integer) as Ihandle ptr
declare function IupGetChildPos  (byval ih as Ihandle ptr, byval child as Ihandle ptr) as integer
declare function IupGetChildCount  (byval ih as Ihandle ptr) as integer
declare function IupGetNextChild  (byval ih as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupGetBrother  (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetParent  (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetDialog  (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetDialogChild  (byval ih as Ihandle ptr, byval name as zstring ptr) as Ihandle ptr
declare function IupReparent  (byval ih as Ihandle ptr, byval new_parent as Ihandle ptr, byval ref_child as Ihandle ptr) as integer

declare function IupPopup  (byval ih as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupShow  (byval ih as Ihandle ptr) as integer
declare function IupShowXY  (byval ih as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupHide  (byval ih as Ihandle ptr) as integer
declare function IupMap  (byval ih as Ihandle ptr) as integer
declare sub IupUnmap  (byval ih as Ihandle ptr)

declare sub IupSetAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval value as zstring ptr)
declare sub IupStoreAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval value as zstring ptr)
declare function IupSetAttributes  (byval ih as Ihandle ptr, byval str as zstring ptr) as Ihandle ptr
declare function IupGetAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr) as zstring ptr
declare function IupGetAttributes  (byval ih as Ihandle ptr) as zstring ptr
declare function IupGetInt  (byval ih as Ihandle ptr, byval name as zstring ptr) as integer
declare function IupGetInt2  (byval ih as Ihandle ptr, byval name as zstring ptr) as integer
declare function IupGetIntInt  (byval ih as Ihandle ptr, byval name as zstring ptr, byval i1 as integer ptr, byval i2 as integer ptr) as integer
declare function IupGetFloat  (byval ih as Ihandle ptr, byval name as zstring ptr) as single
declare sub IupSetfAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval format as zstring ptr, ...)
declare sub IupResetAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr)
declare function IupGetAllAttributes  (byval ih as Ihandle ptr, byval names as byte ptr ptr, byval n as integer) as integer
declare function IupSetAtt  (byval handle_name as zstring ptr, byval ih as Ihandle ptr, byval name as zstring ptr, ...) as Ihandle ptr

declare sub IupSetAttributeId  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare sub IupStoreAttributeId  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare function IupGetAttributeId  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as zstring ptr
declare function IupGetFloatId  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as single
declare function IupGetIntId  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as integer
declare sub IupSetfAttributeId  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval format as zstring ptr, ...)

declare sub IupSetAttributeId2  (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare sub IupStoreAttributeId2  (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare function IupGetAttributeId2  (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as zstring ptr
declare function IupGetIntId2  (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as integer
declare function IupGetFloatId2  (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as single
declare sub IupSetfAttributeId2  (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval format as zstring ptr, ...)

declare sub IupSetGlobal  (byval name as zstring ptr, byval value as zstring ptr)
declare sub IupStoreGlobal  (byval name as zstring ptr, byval value as zstring ptr)
declare function IupGetGlobal  (byval name as zstring ptr) as zstring ptr

declare function IupSetFocus  (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetFocus  () as Ihandle ptr
declare function IupPreviousField  (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupNextField  (byval ih as Ihandle ptr) as Ihandle ptr

declare function IupGetCallback  (byval ih as Ihandle ptr, byval name as zstring ptr) as Icallback
declare function IupSetCallback  (byval ih as Ihandle ptr, byval name as zstring ptr, byval func as Icallback) as Icallback
declare function IupSetCallbacks  (byval ih as Ihandle ptr, byval name as zstring ptr, byval func as Icallback, ...) as Ihandle ptr

declare function IupGetFunction  (byval name as zstring ptr) as Icallback
declare function IupSetFunction  (byval name as zstring ptr, byval func as Icallback) as Icallback
declare function IupGetActionName  () as zstring ptr

declare function IupGetHandle  (byval name as zstring ptr) as Ihandle ptr
declare function IupSetHandle  (byval name as zstring ptr, byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetAllNames  (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetAllDialogs  (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetName  (byval ih as Ihandle ptr) as zstring ptr

declare sub IupSetAttributeHandle  (byval ih as Ihandle ptr, byval name as zstring ptr, byval ih_named as Ihandle ptr)
declare function IupGetAttributeHandle  (byval ih as Ihandle ptr, byval name as zstring ptr) as Ihandle ptr

declare function IupGetClassName  (byval ih as Ihandle ptr) as zstring ptr
declare function IupGetClassType  (byval ih as Ihandle ptr) as zstring ptr
declare function IupGetAllClasses  (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetClassAttributes  (byval classname as zstring ptr, byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetClassCallbacks  (byval classname as zstring ptr, byval names as byte ptr ptr, byval n as integer) as integer
declare sub IupSaveClassAttributes  (byval ih as Ihandle ptr)
declare sub IupCopyClassAttributes  (byval src_ih as Ihandle ptr, byval dst_ih as Ihandle ptr)
declare sub IupSetClassDefaultAttribute  (byval classname as zstring ptr, byval name as zstring ptr, byval value as zstring ptr)
declare function IupClassMatch  (byval ih as Ihandle ptr, byval classname as zstring ptr) as integer

declare function IupCreate  (byval classname as zstring ptr) as Ihandle ptr
declare function IupCreatev  (byval classname as zstring ptr, byval params as any ptr ptr) as Ihandle ptr
declare function IupCreatep  (byval classname as zstring ptr, byval first as any ptr, ...) as Ihandle ptr

/'***********************************************************************/
/*                        Elements                                      */
/***********************************************************************'/

declare function IupFill  () as Ihandle ptr
declare function IupRadio  (byval child as Ihandle ptr) as Ihandle ptr
declare function IupVbox  (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupVboxv  (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupZbox  (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupZboxv  (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupHbox  (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupHboxv  (byval children as Ihandle ptr ptr) as Ihandle ptr

declare function IupNormalizer  (byval ih_first as Ihandle ptr, ...) as Ihandle ptr
declare function IupNormalizerv  (byval ih_list as Ihandle ptr ptr) as Ihandle ptr

declare function IupCbox  (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupCboxv  (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupSbox  (byval child as Ihandle ptr) as Ihandle ptr
declare function IupSplit  (byval child1 as Ihandle ptr, byval child2 as Ihandle ptr) as Ihandle ptr

declare function IupFrame  (byval child as Ihandle ptr) as Ihandle ptr

declare function IupImage  (byval width as integer, byval height as integer, byval pixmap as ubyte ptr) as Ihandle ptr
declare function IupImageRGB  (byval width as integer, byval height as integer, byval pixmap as ubyte ptr) as Ihandle ptr
declare function IupImageRGBA  (byval width as integer, byval height as integer, byval pixmap as ubyte ptr) as Ihandle ptr

declare function IupItem  (byval title as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupSubmenu  (byval title as zstring ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupSeparator  () as Ihandle ptr
declare function IupMenu  (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupMenuv  (byval children as Ihandle ptr ptr) as Ihandle ptr

declare function IupButton  (byval title as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupCanvas  (byval action as zstring ptr) as Ihandle ptr
declare function IupDialog  (byval child as Ihandle ptr) as Ihandle ptr
declare function IupUser  () as Ihandle ptr
declare function IupLabel  (byval title as zstring ptr) as Ihandle ptr
declare function IupList  (byval action as zstring ptr) as Ihandle ptr
declare function IupText  (byval action as zstring ptr) as Ihandle ptr
declare function IupMultiLine  (byval action as zstring ptr) as Ihandle ptr
declare function IupToggle  (byval title as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupTimer  () as Ihandle ptr
declare function IupClipboard  () as Ihandle ptr
declare function IupProgressBar  () as Ihandle ptr
declare function IupVal  (byval type as zstring ptr) as Ihandle ptr
declare function IupTabs  (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupTabsv  (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupTree  () as Ihandle ptr

'/* Deprecated controls use SPIN attribute of IupText */
declare function IupSpin  () as Ihandle ptr
declare function IupSpinbox  (byval child as Ihandle ptr) as Ihandle ptr

'/* IupImage utility */
declare function IupSaveImageAsText  (byval ih as Ihandle ptr, byval file_name as zstring ptr, byval format as zstring ptr, byval name as zstring ptr) as integer

'/* IupText utilities */
declare sub IupTextConvertLinColToPos  (byval ih as Ihandle ptr, byval lin as integer, byval col as integer, byval pos as integer ptr)
declare sub IupTextConvertPosToLinCol  (byval ih as Ihandle ptr, byval pos as integer, byval lin as integer ptr, byval col as integer ptr)

'/* IupText, IupList and IupTree utility */
declare function IupConvertXYToPos  (byval ih as Ihandle ptr, byval x as integer, byval y as integer) as integer

'/* IupTree utilities */
declare function IupTreeSetUserId  (byval ih as Ihandle ptr, byval id as integer, byval userid as any ptr) as integer
declare function IupTreeGetUserId  (byval ih as Ihandle ptr, byval id as integer) as any ptr
declare function IupTreeGetId  (byval ih as Ihandle ptr, byval userid as any ptr) as integer

'/* Deprecated IupTree utilities, use Iup*AttributeId functions */
declare sub IupTreeSetAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare sub IupTreeStoreAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare function IupTreeGetAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as zstring ptr
declare function IupTreeGetInt  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as integer
declare function IupTreeGetFloat  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as single
declare sub IupTreeSetfAttribute  (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval format as zstring ptr, ...)
declare sub IupTreeSetAttributeHandle  (byval ih as Ihandle ptr, byval a as zstring ptr, byval id as integer, byval ih_named as Ihandle ptr)

/'************************************************************************/
/*                      Pre-definided dialogs                           */
/************************************************************************'/

declare function IupFileDlg  () as Ihandle ptr
declare function IupMessageDlg  () as Ihandle ptr
declare function IupColorDlg  () as Ihandle ptr
declare function IupFontDlg  () as Ihandle ptr

declare function IupGetFile  (byval arq as zstring ptr) as integer
declare sub IupMessage  (byval title as zstring ptr, byval msg as zstring ptr)
declare sub IupMessagef  (byval title as zstring ptr, byval format as zstring ptr, ...)
declare function IupAlarm  (byval title as zstring ptr, byval msg as zstring ptr, byval b1 as zstring ptr, byval b2 as zstring ptr, byval b3 as zstring ptr) as integer
declare function IupScanf  (byval format as zstring ptr, ...) as integer
declare function IupListDialog  (byval type as integer, byval title as zstring ptr, byval size as integer, byval list as byte ptr ptr, byval op as integer, byval max_col as integer, byval max_lin as integer, byval marks as integer ptr) as integer
declare function IupGetText  (byval title as zstring ptr, byval text as zstring ptr) as integer
declare function IupGetColor  (byval x as integer, byval y as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr) as integer

type Iparamcb as function cdecl(byval as Ihandle ptr, byval as integer, byval as any ptr) as integer

declare function IupGetParam  (byval title as zstring ptr, byval action as Iparamcb, byval user_data as any ptr, byval format as zstring ptr, ...) as integer
declare function IupGetParamv  (byval title as zstring ptr, byval action as Iparamcb, byval user_data as any ptr, byval format as zstring ptr, byval param_count as integer, byval param_extra as integer, byval param_data as any ptr ptr) as integer
declare function IupLayoutDialog  (byval dialog as Ihandle ptr) as Ihandle ptr
declare function IupElementPropertiesDialog  (byval elem as Ihandle ptr) as Ihandle ptr

/'************************************************************************/
/*                   Common Return Values                               */
/************************************************************************'/
#define IUP_ERROR 1
#define IUP_NOERROR 0
#define IUP_OPENED -1
#define IUP_INVALID -1

/'************************************************************************/
/*                   Callback Return Values                             */
/************************************************************************'/

#define IUP_IGNORE -1
#define IUP_DEFAULT -2
#define IUP_CLOSE -3
#define IUP_CONTINUE -4

/'************************************************************************/
/*           IupPopup and IupShowXY Parameter Values                    */
/************************************************************************'/

#define IUP_CENTER &hFFFF
#define IUP_LEFT &hFFFE
#define IUP_RIGHT &hFFFD
#define IUP_MOUSEPOS &hFFFC
#define IUP_CURRENT &hFFFB
#define IUP_CENTERPARENT &hFFFA
#define IUP_TOP &hFFFE
#define IUP_BOTTOM &hFFFD

/'************************************************************************/
/*               SHOW_CB Callback Values                                */
/************************************************************************'/

enum
    IUP_SHOW
    IUP_RESTORE
    IUP_MINIMIZE
    IUP_MAXIMIZE
    IUP_HIDE
end enum

/'************************************************************************/
/*               SCROLL_CB Callback Values                              */
/************************************************************************'/

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

/'************************************************************************/
/*               Mouse Button Values and Macros                         */
/************************************************************************'/

#define IUP_BUTTON1 asc("1")
#define IUP_BUTTON2 asc("2")
#define IUP_BUTTON3 asc("3")
#define IUP_BUTTON4 asc("4")
#define IUP_BUTTON5 asc("5")

#define iup_isshift(_s)    (_s[0]=asc("S"))
#define iup_iscontrol(_s)  (_s[1]=asc("C"))
#define iup_isbutton1(_s)  (_s[2]=asc("1"))
#define iup_isbutton2(_s)  (_s[3]=asc("2"))
#define iup_isbutton3(_s)  (_s[4]=asc("3"))
#define iup_isdouble(_s)   (_s[5]=asc("D"))
#define iup_isalt(_s)      (_s[6]=asc("A"))
#define iup_issys(_s)      (_s[7]=asc("Y"))
#define iup_isbutton4(_s)  (_s[8]=asc("4"))
#define iup_isbutton5(_s)  (_s[9]=asc("5"))

'/* Old definitions for backward compatibility */
#define isshift     iup_isshift
#define iscontrol   iup_iscontrol
#define isbutton1   iup_isbutton1
#define isbutton2   iup_isbutton2
#define isbutton3   iup_isbutton3
#define isdouble    iup_isdouble
#define isalt       iup_isalt
#define issys       iup_issys
#define isbutton4   iup_isbutton4
#define isbutton5   iup_isbutton5

/'************************************************************************/
/*                      Pre-Defined Masks                               */
/************************************************************************'/

#define IUP_MASK_FLOAT "[+/-]?(/d+/.?/d*|/./d+)"
#define IUP_MASK_UFLOAT "(/d+/.?/d*|/./d+)"
#define IUP_MASK_EFLOAT "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
#define IUP_MASK_INT "[+/-]?/d+"
#define IUP_MASK_UINT "/d+"

'/* Old definitions for backward compatibility */
#define IUPMASK_FLOAT IUP_MASK_FLOAT
#define IUPMASK_UFLOAT IUP_MASK_UFLOAT
#define IUPMASK_EFLOAT IUP_MASK_EFLOAT
#define IUPMASK_INT IUP_MASK_INT
#define IUPMASK_UINT IUP_MASK_UINT

/'************************************************************************/
/*                   Record Input Modes                                 */
/************************************************************************'/
enum
    IUP_RECBINARY
    IUP_RECTEXT
end enum

end extern

#endif

/'******************************************************************************
* Copyright (C) 1994-2011 Tecgraf, PUC-Rio.
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************'/

