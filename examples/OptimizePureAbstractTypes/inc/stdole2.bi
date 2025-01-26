'=============================================Type library===========================================
' Name       : stdole
' Description: OLE Automation
' Path       : C:\Windows\SysWOW64\stdole2.tlb
'====================================================================================================

#pragma Once
#Include Once "FBCom.bi"

Namespace stdole

	'Class identifier (CLSID)
	Const CLSID_StdFont = "{0BE35203-8F91-11CE-9DE3-00AA004BB851}"
	Const CLSID_StdPicture = "{0BE35204-8F91-11CE-9DE3-00AA004BB851}"

	'Interface identifier (IID)
	Const IID_Font = "{BEF6E003-A874-101A-8BBA-00AA00300CAB}"
	Const IID_Picture = "{7BF80981-BF32-101A-8BBB-00AA00300CAB}"
	Const IID_FontEvents = "{4EF6100A-AF88-11D0-9846-00C04FC29993}"
	
	Type OLE_COLOR As ULong
	Type OLE_XPOS_PIXELS As Long
	Type OLE_YPOS_PIXELS As Long
	Type OLE_XSIZE_PIXELS As Long
	Type OLE_YSIZE_PIXELS As Long
	Type OLE_XPOS_HIMETRIC As Long
	Type OLE_YPOS_HIMETRIC As Long
	Type OLE_XSIZE_HIMETRIC As Long
	Type OLE_YSIZE_HIMETRIC As Long
	Type OLE_XPOS_CONTAINER As Single
	Type OLE_YPOS_CONTAINER As Single
	Type OLE_XSIZE_CONTAINER As Single
	Type OLE_YSIZE_CONTAINER As Single
	Type OLE_HANDLE As Long
	Type OLE_OPTEXCLUSIVE As VARIANT_BOOL
	Type OLE_CANCELBOOL As VARIANT_BOOL
	Type OLE_ENABLEDEFAULTBOOL As VARIANT_BOOL
	Type FONTNAME As BSTR
	Type FONTSIZE As CY
	Type FONTBOLD As VARIANT_BOOL
	Type FONTITALIC As VARIANT_BOOL
	Type FONTUNDERSCORE As VARIANT_BOOL
	Type FONTSTRIKETHROUGH As VARIANT_BOOL
	Type IFontDisp As Font
	Type IPictureDisp As Picture
	Type IFontEventsDisp As FontEvents

	Enum OLE_TRISTATE
		Unchecked = 0
		Checked = 1
		Gray = 2
	End Enum

	Enum LoadPictureConstants
		Default = 0
		Monochrome = 1
		VgaColor = 2
		Color = 4
	End Enum

	'Module StdFunctions
		'Declare Function LoadPicture Alias "OleLoadPictureFileEx" (Byval filename As Variant Ptr, Byval widthDesired As Long, Byval heightDesired As Long, Byval flags As LoadPictureConstants) As Picture Ptr Ptr
		'Declare Function SavePicture Alias "OleSavePictureFile" (Byval Picture As Picture Ptr, Byval filename As BSTR) As HRESULT

	Type GUID
		Data1 As ULong
		Data2 As UShort
		Data3 As UShort
		Data4(0 To 6) As UByte
	End Type

	Type DISPPARAMS
		rgvarg As Variant Ptr Ptr
		rgdispidNamedArgs As Long Ptr
		cArgs As ULong
		cNamedArgs As ULong
	End Type

	Type EXCEPINFO
		wCode As UShort
		wReserved As UShort
		bstrSource As BSTR
		bstrDescription As BSTR
		bstrHelpFile As BSTR
		dwHelpContext As ULong
		pvReserved As Any Ptr
		pfnDeferredFillIn As Any Ptr
		scode As Long
	End Type

	' Interface pre declaration.
	Type IUnknown As CAIUnknown
	Type IDispatch As CAIDispatch
	Type IEnumVARIANT As IEnumVARIANT_
	Type IFont As IFont_
	Type IPicture As IPicture_

	' Default interface pre declaration for component classes.
	Type StdFont As Font
	Type StdPicture As Picture

	' Dual interface pre declaration.
	Type Font As Font_
	Type Picture As Picture_
	Type FontEvents As FontEvents_

	Type IEnumVARIANT_ Extends CAIUnknown
		Declare Abstract Function Next_ (Byval celt As ULong, Byval rgvar As Variant Ptr Ptr, Byval pceltFetched As ULong Ptr) As HRESULT
		Declare Abstract Function Skip (Byval celt As ULong) As HRESULT
		Declare Abstract Function Reset () As HRESULT
		Declare Abstract Function Clone (Byval ppenum As IEnumVARIANT Ptr Ptr) As HRESULT
	End Type 'IEnumVARIANT_

	Type IFont_ Extends CAIUnknown
		Declare Abstract Function Get_Name (Byval pname As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval pname As BSTR) As HRESULT
		Declare Abstract Function Get_Size (Byval psize As CY Ptr) As HRESULT
		Declare Abstract Function Let_Size (Byval psize As CY) As HRESULT
		Declare Abstract Function Get_Bold (Byval pbold As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Bold (Byval pbold As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Italic (Byval pitalic As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Italic (Byval pitalic As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Underline (Byval punderline As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Underline (Byval punderline As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Strikethrough (Byval pstrikethrough As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Strikethrough (Byval pstrikethrough As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Weight (Byval pweight As Short Ptr) As HRESULT
		Declare Abstract Function Let_Weight (Byval pweight As Short) As HRESULT
		Declare Abstract Function Get_Charset (Byval pcharset As Short Ptr) As HRESULT
		Declare Abstract Function Let_Charset (Byval pcharset As Short) As HRESULT
		Declare Abstract Function Get_hFont (Byval phfont As Long Ptr) As HRESULT
		Declare Abstract Function Clone (Byval ppfont As IFont Ptr Ptr) As HRESULT
		Declare Abstract Function IsEqual (Byval pfontOther As IFont Ptr) As HRESULT
		Declare Abstract Function SetRatio (Byval cyLogical As Long, Byval cyHimetric As Long) As HRESULT
		Declare Abstract Function AddRefHfont (Byval hFont As Long) As HRESULT
		Declare Abstract Function ReleaseHfont (Byval hFont As Long) As HRESULT
	End Type 'IFont_

	Type IPicture_ Extends CAIUnknown
		Declare Abstract Function Get_Handle (Byval phandle As Long Ptr) As HRESULT
		Declare Abstract Function Get_hPal (Byval phpal As Long Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval ptype As Short Ptr) As HRESULT
		Declare Abstract Function Get_Width (Byval pwidth As Long Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pheight As Long Ptr) As HRESULT
		Declare Abstract Function Render (Byval hdc As Long, Byval x As Long, Byval y As Long, Byval cx As Long, Byval cy As Long, Byval xSrc As Long, Byval ySrc As Long, Byval cxSrc As Long, Byval cySrc As Long, Byval prcWBounds As Any Ptr) As HRESULT
		Declare Abstract Function Let_hPal (Byval phpal As Long) As HRESULT
		Declare Abstract Function Get_CurDC (Byval phdcOut As Long Ptr) As HRESULT
		Declare Abstract Function SelectPicture (Byval hdcIn As Long, Byval phdcOut As Long Ptr, Byval phbmpOut As Long Ptr) As HRESULT
		Declare Abstract Function Get_KeepOriginalFormat (Byval pfkeep As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_KeepOriginalFormat (Byval pfkeep As VARIANT_BOOL) As HRESULT
		Declare Abstract Function PictureChanged () As HRESULT
		Declare Abstract Function SaveAsFile (Byval pstm As Any Ptr, Byval fSaveMemCopy As VARIANT_BOOL, Byval pcbSize As Long Ptr) As HRESULT
		Declare Abstract Function Get_Attributes (Byval pdwAttr As Long Ptr) As HRESULT
		Declare Abstract Function SetHdc (Byval hdc As Long) As HRESULT
	End Type 'IPicture_

	Type Font_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract UnKnown Name unknowcal () As BSTR
		' Declare Abstract UnKnown Size unknowcal () As CY
		' Declare Abstract UnKnown Bold unknowcal () As VARIANT_BOOL
		' Declare Abstract UnKnown Italic unknowcal () As VARIANT_BOOL
		' Declare Abstract UnKnown Underline unknowcal () As VARIANT_BOOL
		' Declare Abstract UnKnown Strikethrough unknowcal () As VARIANT_BOOL
		' Declare Abstract UnKnown Weight unknowcal () As Short
		' Declare Abstract UnKnown Charset unknowcal () As Short
	End Type 'Font_

	Type Picture_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract UnKnown Handle unknowcal () As Long
		' Declare Abstract UnKnown hPal unknowcal () As Long
		' Declare Abstract UnKnown Type_ unknowcal () As Short
		' Declare Abstract UnKnown Width unknowcal () As Long
		' Declare Abstract UnKnown Height unknowcal () As Long
		' Declare Abstract Function Render (Byval hdc As Long, Byval x As Long, Byval y As Long, Byval cx As Long, Byval cy As Long, Byval xSrc As Long, Byval ySrc As Long, Byval cxSrc As Long, Byval cySrc As Long, Byval prcWBounds As Any Ptr) As HRESULT
	End Type 'Picture_

	Type FontEvents_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract Function FontChanged (Byval PropertyName As BSTR) As HRESULT
	End Type 'FontEvents_

End Namespace