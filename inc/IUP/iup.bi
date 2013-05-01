''* \file
 ' \brief User API
 ' IUP - A Portable User Interface Toolkit
 ' Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
 ' http://www.tecgraf.puc-rio.br/iup  mailto:iup@tecgraf.puc-rio.br
 '
 ' See Copyright Notice at the end of this file
 ''
#ifndef __iup_bi__
#define __iup_bi__

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

#include once "iup/iupkey.bi"
#include once "iup/iupdef.bi"

#define IUP_NAME "IUP - Portable User Interface"
#define IUP_COPYRIGHT "Copyright (C) 1994-2012 Tecgraf, PUC-Rio."
#define IUP_DESCRIPTION "Multi-platform toolkit for building graphical user interfaces."
#define IUP_VERSION "3.7"
#define IUP_VERSION_NUMBER 307000
#define IUP_VERSION_DATE "2012/11/29"

type Ihandle as Ihandle_
type Icallback as function cdecl(byval as Ihandle ptr) as integer

declare function IupOpen cdecl alias "IupOpen" (byval argc as integer ptr, byval argv as byte ptr ptr ptr) as integer
declare sub IupClose cdecl alias "IupClose" ()
declare sub IupImageLibOpen cdecl alias "IupImageLibOpen" ()
declare function IupMainLoop cdecl alias "IupMainLoop" () as integer
declare function IupLoopStep cdecl alias "IupLoopStep" () as integer
declare function IupLoopStepWait cdecl alias "IupLoopStepWait" () as integer
declare function IupMainLoopLevel cdecl alias "IupMainLoopLevel" () as integer
declare sub IupFlush cdecl alias "IupFlush" ()
declare sub IupExitLoop cdecl alias "IupExitLoop" ()
declare function IupRecordInput cdecl alias "IupRecordInput" (byval filename as zstring ptr, byval mode as integer) as integer
declare function IupPlayInput cdecl alias "IupPlayInput" (byval filename as zstring ptr) as integer
declare sub IupUpdate cdecl alias "IupUpdate" (byval ih as Ihandle ptr)
declare sub IupUpdateChildren cdecl alias "IupUpdateChildren" (byval ih as Ihandle ptr)
declare sub IupRedraw cdecl alias "IupRedraw" (byval ih as Ihandle ptr, byval children as integer)
declare sub IupRefresh cdecl alias "IupRefresh" (byval ih as Ihandle ptr)
declare sub IupRefreshChildren cdecl alias "IupRefreshChildren" (byval ih as Ihandle ptr)
declare function IupMapFont cdecl alias "IupMapFont" (byval iupfont as zstring ptr) as zstring ptr
declare function IupUnMapFont cdecl alias "IupUnMapFont" (byval driverfont as zstring ptr) as zstring ptr
declare function IupHelp cdecl alias "IupHelp" (byval url as zstring ptr) as integer
declare function IupLoad cdecl alias "IupLoad" (byval filename as zstring ptr) as zstring ptr
declare function IupLoadBuffer cdecl alias "IupLoadBuffer" (byval buffer as zstring ptr) as zstring ptr
declare function IupVersion cdecl alias "IupVersion" () as zstring ptr
declare function IupVersionDate cdecl alias "IupVersionDate" () as zstring ptr
declare function IupVersionNumber cdecl alias "IupVersionNumber" () as integer
declare sub IupSetLanguage cdecl alias "IupSetLanguage" (byval lng as zstring ptr)
declare function IupGetLanguage cdecl alias "IupGetLanguage" () as zstring ptr
declare sub IupDestroy cdecl alias "IupDestroy" (byval ih as Ihandle ptr)
declare sub IupDetach cdecl alias "IupDetach" (byval child as Ihandle ptr)
declare function IupAppend cdecl alias "IupAppend" (byval ih as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupInsert cdecl alias "IupInsert" (byval ih as Ihandle ptr, byval ref_child as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupGetChild cdecl alias "IupGetChild" (byval ih as Ihandle ptr, byval pos as integer) as Ihandle ptr
declare function IupGetChildPos cdecl alias "IupGetChildPos" (byval ih as Ihandle ptr, byval child as Ihandle ptr) as integer
declare function IupGetChildCount cdecl alias "IupGetChildCount" (byval ih as Ihandle ptr) as integer
declare function IupGetNextChild cdecl alias "IupGetNextChild" (byval ih as Ihandle ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupGetBrother cdecl alias "IupGetBrother" (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetParent cdecl alias "IupGetParent" (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetDialog cdecl alias "IupGetDialog" (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetDialogChild cdecl alias "IupGetDialogChild" (byval ih as Ihandle ptr, byval name as zstring ptr) as Ihandle ptr
declare function IupReparent cdecl alias "IupReparent" (byval ih as Ihandle ptr, byval new_parent as Ihandle ptr, byval ref_child as Ihandle ptr) as integer
declare function IupPopup cdecl alias "IupPopup" (byval ih as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupShow cdecl alias "IupShow" (byval ih as Ihandle ptr) as integer
declare function IupShowXY cdecl alias "IupShowXY" (byval ih as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupHide cdecl alias "IupHide" (byval ih as Ihandle ptr) as integer
declare function IupMap cdecl alias "IupMap" (byval ih as Ihandle ptr) as integer
declare sub IupUnmap cdecl alias "IupUnmap" (byval ih as Ihandle ptr)
declare sub IupSetAttribute cdecl alias "IupSetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval value as zstring ptr)
declare sub IupStoreAttribute cdecl alias "IupStoreAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval value as zstring ptr)
declare function IupSetAttributes cdecl alias "IupSetAttributes" (byval ih as Ihandle ptr, byval str as zstring ptr) as Ihandle ptr
declare function IupGetAttribute cdecl alias "IupGetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr) as zstring ptr
declare function IupGetAttributes cdecl alias "IupGetAttributes" (byval ih as Ihandle ptr) as zstring ptr
declare function IupGetInt cdecl alias "IupGetInt" (byval ih as Ihandle ptr, byval name as zstring ptr) as integer
declare function IupGetInt2 cdecl alias "IupGetInt2" (byval ih as Ihandle ptr, byval name as zstring ptr) as integer
declare function IupGetIntInt cdecl alias "IupGetIntInt" (byval ih as Ihandle ptr, byval name as zstring ptr, byval i1 as integer ptr, byval i2 as integer ptr) as integer
declare function IupGetFloat cdecl alias "IupGetFloat" (byval ih as Ihandle ptr, byval name as zstring ptr) as single
declare sub IupSetfAttribute cdecl alias "IupSetfAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval format as zstring ptr, ...)
declare sub IupResetAttribute cdecl alias "IupResetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr)
declare function IupGetAllAttributes cdecl alias "IupGetAllAttributes" (byval ih as Ihandle ptr, byval names as byte ptr ptr, byval n as integer) as integer
declare function IupSetAtt cdecl alias "IupSetAtt" (byval handle_name as zstring ptr, byval ih as Ihandle ptr, byval name as zstring ptr, ...) as Ihandle ptr
declare sub IupSetAttributeId cdecl alias "IupSetAttributeId" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare sub IupStoreAttributeId cdecl alias "IupStoreAttributeId" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare function IupGetAttributeId cdecl alias "IupGetAttributeId" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as zstring ptr
declare function IupGetFloatId cdecl alias "IupGetFloatId" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as single
declare function IupGetIntId cdecl alias "IupGetIntId" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as integer
declare sub IupSetfAttributeId cdecl alias "IupSetfAttributeId" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval format as zstring ptr, ...)
declare sub IupSetAttributeId2 cdecl alias "IupSetAttributeId2" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare sub IupStoreAttributeId2 cdecl alias "IupStoreAttributeId2" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval value as zstring ptr)
declare function IupGetAttributeId2 cdecl alias "IupGetAttributeId2" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as zstring ptr
declare function IupGetIntId2 cdecl alias "IupGetIntId2" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as integer
declare function IupGetFloatId2 cdecl alias "IupGetFloatId2" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer) as single
declare sub IupSetfAttributeId2 cdecl alias "IupSetfAttributeId2" (byval ih as Ihandle ptr, byval name as zstring ptr, byval lin as integer, byval col as integer, byval format as zstring ptr, ...)
declare sub IupSetGlobal cdecl alias "IupSetGlobal" (byval name as zstring ptr, byval value as zstring ptr)
declare sub IupStoreGlobal cdecl alias "IupStoreGlobal" (byval name as zstring ptr, byval value as zstring ptr)
declare function IupGetGlobal cdecl alias "IupGetGlobal" (byval name as zstring ptr) as zstring ptr
declare function IupSetFocus cdecl alias "IupSetFocus" (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetFocus cdecl alias "IupGetFocus" () as Ihandle ptr
declare function IupPreviousField cdecl alias "IupPreviousField" (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupNextField cdecl alias "IupNextField" (byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetCallback cdecl alias "IupGetCallback" (byval ih as Ihandle ptr, byval name as zstring ptr) as Icallback
declare function IupSetCallback cdecl alias "IupSetCallback" (byval ih as Ihandle ptr, byval name as zstring ptr, byval func as Icallback) as Icallback
declare function IupSetCallbacks cdecl alias "IupSetCallbacks" (byval ih as Ihandle ptr, byval name as zstring ptr, byval func as Icallback, ...) as Ihandle ptr
declare function IupGetFunction cdecl alias "IupGetFunction" (byval name as zstring ptr) as Icallback
declare function IupSetFunction cdecl alias "IupSetFunction" (byval name as zstring ptr, byval func as Icallback) as Icallback
declare function IupGetActionName cdecl alias "IupGetActionName" () as zstring ptr
declare function IupGetHandle cdecl alias "IupGetHandle" (byval name as zstring ptr) as Ihandle ptr
declare function IupSetHandle cdecl alias "IupSetHandle" (byval name as zstring ptr, byval ih as Ihandle ptr) as Ihandle ptr
declare function IupGetAllNames cdecl alias "IupGetAllNames" (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetAllDialogs cdecl alias "IupGetAllDialogs" (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetName cdecl alias "IupGetName" (byval ih as Ihandle ptr) as zstring ptr
declare sub IupSetAttributeHandle cdecl alias "IupSetAttributeHandle" (byval ih as Ihandle ptr, byval name as zstring ptr, byval ih_named as Ihandle ptr)
declare function IupGetAttributeHandle cdecl alias "IupGetAttributeHandle" (byval ih as Ihandle ptr, byval name as zstring ptr) as Ihandle ptr
declare function IupGetClassName cdecl alias "IupGetClassName" (byval ih as Ihandle ptr) as zstring ptr
declare function IupGetClassType cdecl alias "IupGetClassType" (byval ih as Ihandle ptr) as zstring ptr
declare function IupGetAllClasses cdecl alias "IupGetAllClasses" (byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetClassAttributes cdecl alias "IupGetClassAttributes" (byval classname as zstring ptr, byval names as byte ptr ptr, byval n as integer) as integer
declare function IupGetClassCallbacks cdecl alias "IupGetClassCallbacks" (byval classname as zstring ptr, byval names as byte ptr ptr, byval n as integer) as integer
declare sub IupSaveClassAttributes cdecl alias "IupSaveClassAttributes" (byval ih as Ihandle ptr)
declare sub IupCopyClassAttributes cdecl alias "IupCopyClassAttributes" (byval src_ih as Ihandle ptr, byval dst_ih as Ihandle ptr)
declare sub IupSetClassDefaultAttribute cdecl alias "IupSetClassDefaultAttribute" (byval classname as zstring ptr, byval name as zstring ptr, byval value as zstring ptr)
declare function IupClassMatch cdecl alias "IupClassMatch" (byval ih as Ihandle ptr, byval classname as zstring ptr) as integer
declare function IupCreate cdecl alias "IupCreate" (byval classname as zstring ptr) as Ihandle ptr
declare function IupCreatev cdecl alias "IupCreatev" (byval classname as zstring ptr, byval params as any ptr ptr) as Ihandle ptr
declare function IupCreatep cdecl alias "IupCreatep" (byval classname as zstring ptr, byval first as any ptr, ...) as Ihandle ptr
declare function IupFill cdecl alias "IupFill" () as Ihandle ptr
declare function IupRadio cdecl alias "IupRadio" (byval child as Ihandle ptr) as Ihandle ptr
declare function IupVbox cdecl alias "IupVbox" (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupVboxv cdecl alias "IupVboxv" (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupZbox cdecl alias "IupZbox" (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupZboxv cdecl alias "IupZboxv" (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupHbox cdecl alias "IupHbox" (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupHboxv cdecl alias "IupHboxv" (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupNormalizer cdecl alias "IupNormalizer" (byval ih_first as Ihandle ptr, ...) as Ihandle ptr
declare function IupNormalizerv cdecl alias "IupNormalizerv" (byval ih_list as Ihandle ptr ptr) as Ihandle ptr
declare function IupCbox cdecl alias "IupCbox" (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupCboxv cdecl alias "IupCboxv" (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupSbox cdecl alias "IupSbox" (byval child as Ihandle ptr) as Ihandle ptr
declare function IupSplit cdecl alias "IupSplit" (byval child1 as Ihandle ptr, byval child2 as Ihandle ptr) as Ihandle ptr
declare function IupScrollBox cdecl alias "IupScrollBox" (byval child as Ihandle ptr) as Ihandle ptr
declare function IupFrame cdecl alias "IupFrame" (byval child as Ihandle ptr) as Ihandle ptr
declare function IupImage cdecl alias "IupImage" (byval width as integer, byval height as integer, byval pixmap as ubyte ptr) as Ihandle ptr
declare function IupImageRGB cdecl alias "IupImageRGB" (byval width as integer, byval height as integer, byval pixmap as ubyte ptr) as Ihandle ptr
declare function IupImageRGBA cdecl alias "IupImageRGBA" (byval width as integer, byval height as integer, byval pixmap as ubyte ptr) as Ihandle ptr
declare function IupItem cdecl alias "IupItem" (byval title as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupSubmenu cdecl alias "IupSubmenu" (byval title as zstring ptr, byval child as Ihandle ptr) as Ihandle ptr
declare function IupSeparator cdecl alias "IupSeparator" () as Ihandle ptr
declare function IupMenu cdecl alias "IupMenu" (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupMenuv cdecl alias "IupMenuv" (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupButton cdecl alias "IupButton" (byval title as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupCanvas cdecl alias "IupCanvas" (byval action as zstring ptr) as Ihandle ptr
declare function IupDialog cdecl alias "IupDialog" (byval child as Ihandle ptr) as Ihandle ptr
declare function IupUser cdecl alias "IupUser" () as Ihandle ptr
declare function IupLabel cdecl alias "IupLabel" (byval title as zstring ptr) as Ihandle ptr
declare function IupList cdecl alias "IupList" (byval action as zstring ptr) as Ihandle ptr
declare function IupText cdecl alias "IupText" (byval action as zstring ptr) as Ihandle ptr
declare function IupMultiLine cdecl alias "IupMultiLine" (byval action as zstring ptr) as Ihandle ptr
declare function IupToggle cdecl alias "IupToggle" (byval title as zstring ptr, byval action as zstring ptr) as Ihandle ptr
declare function IupTimer cdecl alias "IupTimer" () as Ihandle ptr
declare function IupClipboard cdecl alias "IupClipboard" () as Ihandle ptr
declare function IupProgressBar cdecl alias "IupProgressBar" () as Ihandle ptr
declare function IupVal cdecl alias "IupVal" (byval type as zstring ptr) as Ihandle ptr
declare function IupTabs cdecl alias "IupTabs" (byval child as Ihandle ptr, ...) as Ihandle ptr
declare function IupTabsv cdecl alias "IupTabsv" (byval children as Ihandle ptr ptr) as Ihandle ptr
declare function IupTree cdecl alias "IupTree" () as Ihandle ptr
declare function IupSpin cdecl alias "IupSpin" () as Ihandle ptr
declare function IupSpinbox cdecl alias "IupSpinbox" (byval child as Ihandle ptr) as Ihandle ptr
declare function IupSaveImageAsText cdecl alias "IupSaveImageAsText" (byval ih as Ihandle ptr, byval file_name as zstring ptr, byval format as zstring ptr, byval name as zstring ptr) as integer
declare sub IupTextConvertLinColToPos cdecl alias "IupTextConvertLinColToPos" (byval ih as Ihandle ptr, byval lin as integer, byval col as integer, byval pos as integer ptr)
declare sub IupTextConvertPosToLinCol cdecl alias "IupTextConvertPosToLinCol" (byval ih as Ihandle ptr, byval pos as integer, byval lin as integer ptr, byval col as integer ptr)
declare function IupConvertXYToPos cdecl alias "IupConvertXYToPos" (byval ih as Ihandle ptr, byval x as integer, byval y as integer) as integer
declare function IupTreeSetUserId cdecl alias "IupTreeSetUserId" (byval ih as Ihandle ptr, byval id as integer, byval userid as any ptr) as integer
declare function IupTreeGetUserId cdecl alias "IupTreeGetUserId" (byval ih as Ihandle ptr, byval id as integer) as any ptr
declare function IupTreeGetId cdecl alias "IupTreeGetId" (byval ih as Ihandle ptr, byval userid as any ptr) as integer
declare sub IupTreeSetAttribute cdecl alias "IupTreeSetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare sub IupTreeStoreAttribute cdecl alias "IupTreeStoreAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval value as zstring ptr)
declare function IupTreeGetAttribute cdecl alias "IupTreeGetAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as zstring ptr
declare function IupTreeGetInt cdecl alias "IupTreeGetInt" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as integer
declare function IupTreeGetFloat cdecl alias "IupTreeGetFloat" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer) as single
declare sub IupTreeSetfAttribute cdecl alias "IupTreeSetfAttribute" (byval ih as Ihandle ptr, byval name as zstring ptr, byval id as integer, byval format as zstring ptr, ...)
declare sub IupTreeSetAttributeHandle cdecl alias "IupTreeSetAttributeHandle" (byval ih as Ihandle ptr, byval a as zstring ptr, byval id as integer, byval ih_named as Ihandle ptr)
declare function IupFileDlg cdecl alias "IupFileDlg" () as Ihandle ptr
declare function IupMessageDlg cdecl alias "IupMessageDlg" () as Ihandle ptr
declare function IupColorDlg cdecl alias "IupColorDlg" () as Ihandle ptr
declare function IupFontDlg cdecl alias "IupFontDlg" () as Ihandle ptr
declare function IupGetFile cdecl alias "IupGetFile" (byval arq as zstring ptr) as integer
declare sub IupMessage cdecl alias "IupMessage" (byval title as zstring ptr, byval msg as zstring ptr)
declare sub IupMessagef cdecl alias "IupMessagef" (byval title as zstring ptr, byval format as zstring ptr, ...)
declare function IupAlarm cdecl alias "IupAlarm" (byval title as zstring ptr, byval msg as zstring ptr, byval b1 as zstring ptr, byval b2 as zstring ptr, byval b3 as zstring ptr) as integer
declare function IupScanf cdecl alias "IupScanf" (byval format as zstring ptr, ...) as integer
declare function IupListDialog cdecl alias "IupListDialog" (byval type as integer, byval title as zstring ptr, byval size as integer, byval list as byte ptr ptr, byval op as integer, byval max_col as integer, byval max_lin as integer, byval marks as integer ptr) as integer
declare function IupGetText cdecl alias "IupGetText" (byval title as zstring ptr, byval text as zstring ptr) as integer
declare function IupGetColor cdecl alias "IupGetColor" (byval x as integer, byval y as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr) as integer

type Iparamcb as function cdecl(byval as Ihandle ptr, byval as integer, byval as any ptr) as integer

declare function IupGetParam cdecl alias "IupGetParam" (byval title as zstring ptr, byval action as Iparamcb, byval user_data as any ptr, byval format as zstring ptr, ...) as integer
declare function IupGetParamv cdecl alias "IupGetParamv" (byval title as zstring ptr, byval action as Iparamcb, byval user_data as any ptr, byval format as zstring ptr, byval param_count as integer, byval param_extra as integer, byval param_data as any ptr ptr) as integer
declare function IupLayoutDialog cdecl alias "IupLayoutDialog" (byval dialog as Ihandle ptr) as Ihandle ptr
declare function IupElementPropertiesDialog cdecl alias "IupElementPropertiesDialog" (byval elem as Ihandle ptr) as Ihandle ptr

#define IUP_ERROR 1
#define IUP_NOERROR 0
#define IUP_OPENED -1
#define IUP_INVALID -1
#define IUP_IGNORE -1
#define IUP_DEFAULT -2
#define IUP_CLOSE -3
#define IUP_CONTINUE -4
#define IUP_CENTER &hFFFF
#define IUP_LEFT &hFFFE
#define IUP_RIGHT &hFFFD
#define IUP_MOUSEPOS &hFFFC
#define IUP_CURRENT &hFFFB
#define IUP_CENTERPARENT &hFFFA
#define IUP_TOP &hFFFE
#define IUP_BOTTOM &hFFFD

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
#define IUP_MASK_FLOAT "[+/-]?(/d+/.?/d*|/./d+)"
#define IUP_MASK_UFLOAT "(/d+/.?/d*|/./d+)"
#define IUP_MASK_EFLOAT "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
#define IUP_MASK_INT "[+/-]?/d+"
#define IUP_MASK_UINT "/d+"
#define IUPMASK_FLOAT "[+/-]?(/d+/.?/d*|/./d+)"
#define IUPMASK_UFLOAT "(/d+/.?/d*|/./d+)"
#define IUPMASK_EFLOAT "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
#define IUPMASK_INT "[+/-]?/d+"
#define IUPMASK_UINT "/d+"
#define IUP_GETPARAM_OK -1
#define IUP_GETPARAM_INIT -2
#define IUP_GETPARAM_CANCEL -3
#define IUP_GETPARAM_HELP -4

enum
    IUP_RECBINARY
    IUP_RECTEXT
end enum


'/******************************************************************************
'* Copyright (C) 1994-2012 Tecgraf, PUC-Rio.
'*
'* Permission is hereby granted, free of charge, to any person obtaining
'* a copy of this software and associated documentation files (the
'* "Software"), to deal in the Software without restriction, including
'* without limitation the rights to use, copy, modify, merge, publish,
'* distribute, sublicense, and/or sell copies of the Software, and to
'* permit persons to whom the Software is furnished to do so, subject to
'* the following conditions:
'*
'* The above copyright notice and this permission notice shall be
'* included in all copies or substantial portions of the Software.
'*
'* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
'* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
'* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
'* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
'* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
'* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
'* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'******************************************************************************/


#endif
