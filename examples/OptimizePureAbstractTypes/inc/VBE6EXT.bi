'=============================================Type library===========================================
' Name       : VBIDE
' Description: Microsoft Visual Basic for Applications Extensibility 5.3
' Path       : C:\Program Files (x86)\Common Files\Microsoft Shared\VBA\VBA6\VBE6EXT.OLB
'====================================================================================================

#pragma Once
#Include Once "FBCom.bi"
#Include Once "MSO.bi"  'C:\Program Files (x86)\Common Files\Microsoft Shared\Office16\MSO.DLL

Namespace VBIDE

	'Class identifier (CLSID)
	Const CLSID_Windows = "{0002E185-0000-0000-C000-000000000046}"
	Const CLSID_LinkedWindows = "{0002E187-0000-0000-C000-000000000046}"
	Const CLSID_ReferencesEvents = "{0002E119-0000-0000-C000-000000000046}"
	Const CLSID_CommandBarEvents = "{0002E132-0000-0000-C000-000000000046}"
	Const CLSID_ProjectTemplate = "{32CDF9E0-1602-11CE-BFDC-08002B2B8CDA}"
	Const CLSID_VBProject = "{0002E169-0000-0000-C000-000000000046}"
	Const CLSID_VBProjects = "{0002E101-0000-0000-C000-000000000046}"
	Const CLSID_Components = "{BE39F3D6-1B13-11D0-887F-00A0C90F2744}"
	Const CLSID_VBComponents = "{BE39F3D7-1B13-11D0-887F-00A0C90F2744}"
	Const CLSID_Component = "{BE39F3D8-1B13-11D0-887F-00A0C90F2744}"
	Const CLSID_VBComponent = "{BE39F3DA-1B13-11D0-887F-00A0C90F2744}"
	Const CLSID_Properties = "{0002E18B-0000-0000-C000-000000000046}"
	Const CLSID_Addins = "{DA936B63-AC8B-11D1-B6E5-00A0C90F2744}"
	Const CLSID_CodeModule = "{0002E170-0000-0000-C000-000000000046}"
	Const CLSID_CodePanes = "{0002E174-0000-0000-C000-000000000046}"
	Const CLSID_CodePane = "{0002E178-0000-0000-C000-000000000046}"
	Const CLSID_References = "{0002E17C-0000-0000-C000-000000000046}"

	' Interface identifier (IID)
	Const IID_Application = "{0002E158-0000-0000-C000-000000000046}"
	Const IID_VBE = "{0002E166-0000-0000-C000-000000000046}"
	Const IID_Window = "{0002E16B-0000-0000-C000-000000000046}"
	Const IID__Windows_old = "{0002E16A-0000-0000-C000-000000000046}"
	Const IID__Windows = "{F57B7ED0-D8AB-11D1-85DF-00C04F98F42C}"
	Const IID__LinkedWindows = "{0002E16C-0000-0000-C000-000000000046}"
	Const IID_Events = "{0002E167-0000-0000-C000-000000000046}"
	Const IID__dispVBProjectsEvents = "{0002E103-0000-0000-C000-000000000046}"
	Const IID__dispVBComponentsEvents = "{0002E116-0000-0000-C000-000000000046}"
	Const IID__dispReferencesEvents = "{0002E118-0000-0000-C000-000000000046}"
	Const IID__dispCommandBarControlEvents = "{0002E131-0000-0000-C000-000000000046}"
	Const IID__ProjectTemplate = "{0002E159-0000-0000-C000-000000000046}"
	Const IID__VBProject_Old = "{0002E160-0000-0000-C000-000000000046}"
	Const IID__VBProject = "{EEE00915-E393-11D1-BB03-00C04FB6C4A6}"
	Const IID__VBProjects_Old = "{0002E165-0000-0000-C000-000000000046}"
	Const IID__VBProjects = "{EEE00919-E393-11D1-BB03-00C04FB6C4A6}"
	Const IID_SelectedComponents = "{BE39F3D4-1B13-11D0-887F-00A0C90F2744}"
	Const IID__Components = "{0002E161-0000-0000-C000-000000000046}"
	Const IID__VBComponents_Old = "{0002E162-0000-0000-C000-000000000046}"
	Const IID__VBComponents = "{EEE0091C-E393-11D1-BB03-00C04FB6C4A6}"
	Const IID__Component = "{0002E163-0000-0000-C000-000000000046}"
	Const IID__VBComponent_Old = "{0002E164-0000-0000-C000-000000000046}"
	Const IID__VBComponent = "{EEE00921-E393-11D1-BB03-00C04FB6C4A6}"
	Const IID_Property = "{0002E18C-0000-0000-C000-000000000046}"
	Const IID__Properties = "{0002E188-0000-0000-C000-000000000046}"
	Const IID__AddIns = "{DA936B62-AC8B-11D1-B6E5-00A0C90F2744}"
	Const IID_AddIn = "{DA936B64-AC8B-11D1-B6E5-00A0C90F2744}"
	Const IID__CodeModule = "{0002E16E-0000-0000-C000-000000000046}"
	Const IID__CodePanes = "{0002E172-0000-0000-C000-000000000046}"
	Const IID__CodePane = "{0002E176-0000-0000-C000-000000000046}"
	Const IID__References = "{0002E17A-0000-0000-C000-000000000046}"
	Const IID_Reference = "{0002E17E-0000-0000-C000-000000000046}"
	Const IID__dispReferences_Events = "{CDDE3804-2064-11CF-867F-00AA005FF34A}"
	

	Enum vbextFileTypes
		vbextFileTypeForm = 0
		vbextFileTypeModule = 1
		vbextFileTypeClass = 2
		vbextFileTypeProject = 3
		vbextFileTypeExe = 4
		vbextFileTypeFrx = 5
		vbextFileTypeRes = 6
		vbextFileTypeUserControl = 7
		vbextFileTypePropertyPage = 8
		vbextFileTypeDocObject = 9
		vbextFileTypeBinary = 10
		vbextFileTypeGroupProject = 11
		vbextFileTypeDesigners = 12
	End Enum

	Enum vbext_WindowType
		vbext_wt_CodeWindow = 0
		vbext_wt_Designer = 1
		vbext_wt_Browser = 2
		vbext_wt_Watch = 3
		vbext_wt_Locals = 4
		vbext_wt_Immediate = 5
		vbext_wt_ProjectWindow = 6
		vbext_wt_PropertyWindow = 7
		vbext_wt_Find = 8
		vbext_wt_FindReplace = 9
		vbext_wt_Toolbox = 10
		vbext_wt_LinkedWindowFrame = 11
		vbext_wt_MainWindow = 12
		vbext_wt_ToolWindow = 15
	End Enum

	Enum vbext_WindowState
		vbext_ws_Normal = 0
		vbext_ws_Minimize = 1
		vbext_ws_Maximize = 2
	End Enum

	Enum vbext_ProjectType
		vbext_pt_HostProject = 100
		vbext_pt_StandAlone = 101
	End Enum

	Enum vbext_ProjectProtection
		vbext_pp_none = 0
		vbext_pp_locked = 1
	End Enum

	Enum vbext_VBAMode
		vbext_vm_Run = 0
		vbext_vm_Break = 1
		vbext_vm_Design = 2
	End Enum

	Enum vbext_ComponentType
		vbext_ct_StdModule = 1
		vbext_ct_ClassModule = 2
		vbext_ct_MSForm = 3
		vbext_ct_ActiveXDesigner = 11
		vbext_ct_Document = 100
	End Enum

	Enum vbext_ProcKind
		vbext_pk_Proc = 0
		vbext_pk_Let = 1
		vbext_pk_Set = 2
		vbext_pk_Get = 3
	End Enum

	Enum vbext_CodePaneview
		vbext_cv_ProcedureView = 0
		vbext_cv_FullModuleView = 1
	End Enum

	Enum vbext_RefKind
		vbext_rk_TypeLib = 0
		vbext_rk_Project = 1
	End Enum

	' Interface pre declaration.
	Type _VBProjectsEvents As _VBProjectsEvents_
	Type _VBComponentsEvents As _VBComponentsEvents_
	Type _ReferencesEvents As _ReferencesEvents_
	Type _CommandBarControlEvents As _CommandBarControlEvents_

	' Default interface pre declaration for component classes.
	Type Windows As _Windows
	Type LinkedWindows As _LinkedWindows
	Type ReferencesEvents As _ReferencesEvents
	Type CommandBarEvents As _CommandBarControlEvents
	Type ProjectTemplate As _ProjectTemplate
	Type VBProject As _VBProject
	Type VBProjects As _VBProjects
	Type Components As _Components
	Type VBComponents As _VBComponents
	Type Component As _Component
	Type VBComponent As _VBComponent
	Type Properties As _Properties
	Type Addins As _AddIns
	Type CodeModule As _CodeModule
	Type CodePanes As _CodePanes
	Type CodePane As _CodePane
	Type References As _References

	' Dual interface pre declaration.
	Type Application As Application_
	Type VBE As VBE_
	Type Window As Window_
	Type _Windows_old As _Windows_old_
	Type _Windows As _Windows__
	Type _LinkedWindows As _LinkedWindows_
	Type Events As Events_
	Type _dispVBProjectsEvents As _dispVBProjectsEvents_
	Type _dispVBComponentsEvents As _dispVBComponentsEvents_
	Type _dispReferencesEvents As _dispReferencesEvents_
	Type _dispCommandBarControlEvents As _dispCommandBarControlEvents_
	Type _ProjectTemplate As _ProjectTemplate_
	Type _VBProject_Old As _VBProject_Old_
	Type _VBProject As _VBProject_
	Type _VBProjects_Old As _VBProjects_Old_
	Type _VBProjects As _VBProjects_
	Type SelectedComponents As SelectedComponents_
	Type _Components As _Components_
	Type _VBComponents_Old As _VBComponents_Old_
	Type _VBComponents As _VBComponents_
	Type _Component As _Component_
	Type _VBComponent_Old As _VBComponent_Old_
	Type _VBComponent As _VBComponent_
	Type Property_t As Property_t_
	Type _Properties As _Properties_
	Type _AddIns As _AddIns_
	Type AddIn As AddIn_
	Type _CodeModule As _CodeModule_
	Type _CodePanes As _CodePanes_
	Type _CodePane As _CodePane_
	Type _References As _References_
	Type Reference As Reference_
	Type _dispReferences_Events As _dispReferences_Events_

	Type _VBProjectsEvents_ Extends CAIUnknown
	End Type '_VBProjectsEvents_

	Type _VBComponentsEvents_ Extends CAIUnknown
	End Type '_VBComponentsEvents_

	Type _ReferencesEvents_ Extends CAIUnknown
	End Type '_ReferencesEvents_

	Type _CommandBarControlEvents_ Extends CAIUnknown
	End Type '_CommandBarControlEvents_

	Type Application_ Extends CAIDispatch
		Declare Abstract Function Get_Version (Byval lpbstrReturn As BSTR Ptr) As HRESULT
	End Type 'Application_

	Type VBE_ Extends Application
		Declare Abstract Function Get_VBProjects (Byval lppptReturn As VBProjects Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CommandBars (Byval ppcbs As Office.CommandBars Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CodePanes (Byval ppCodePanes As CodePanes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Windows (Byval ppwnsVBWindows As Windows Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Events (Byval ppevtEvents As Events Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ActiveVBProject (Byval lppptReturn As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Set_ActiveVBProject (Byval lppptReturn As VBProject Ptr) As HRESULT
		Declare Abstract Function Get_SelectedVBComponent (Byval lppscReturn As VBComponent Ptr Ptr) As HRESULT
		Declare Abstract Function Get_MainWindow (Byval ppwin As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ActiveWindow (Byval ppwinActive As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ActiveCodePane (Byval ppCodePane As CodePane Ptr Ptr) As HRESULT
		Declare Abstract Function Set_ActiveCodePane (Byval ppCodePane As CodePane Ptr) As HRESULT
		Declare Abstract Function Get_Addins (Byval lpppAddIns As Addins Ptr Ptr) As HRESULT
	End Type 'VBE_

	Type Window_ Extends CAIDispatch
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Collection (Byval lppaReturn As Windows Ptr Ptr) As HRESULT
		Declare Abstract Function Close () As HRESULT
		Declare Abstract Function Get_Caption (Byval pbstrTitle As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval pfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval pfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Left (Byval plLeft As Long Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval plLeft As Long) As HRESULT
		Declare Abstract Function Get_Top (Byval plTop As Long Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval plTop As Long) As HRESULT
		Declare Abstract Function Get_Width (Byval plWidth As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval plWidth As Long) As HRESULT
		Declare Abstract Function Get_Height (Byval plHeight As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval plHeight As Long) As HRESULT
		Declare Abstract Function Get_WindowState (Byval plWindowState As vbext_WindowState Ptr) As HRESULT
		Declare Abstract Function Let_WindowState (Byval plWindowState As vbext_WindowState) As HRESULT
		Declare Abstract Function SetFocus () As HRESULT
		Declare Abstract Function Get_Type (Byval pKind As vbext_WindowType Ptr) As HRESULT
		Declare Abstract Function SetKind (Byval eKind As vbext_WindowType) As HRESULT
		Declare Abstract Function Get_LinkedWindows (Byval ppwnsCollection As LinkedWindows Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LinkedWindowFrame (Byval ppwinFrame As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Detach () As HRESULT
		Declare Abstract Function Attach (Byval lWindowHandle As Long) As HRESULT
		Declare Abstract Function Get_HWnd (Byval plWindowHandle As Long Ptr) As HRESULT
	End Type 'Window_

	Type _Windows_old_ Extends CAIDispatch
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppptReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lppcReturn As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
	End Type '_Windows_old_

	Type _Windows__ Extends _Windows_old
		Declare Abstract Function CreateToolWindow (Byval AddInInst As AddIn Ptr, Byval ProgId As BSTR, Byval Caption As BSTR, Byval GuidPosition As BSTR, Byval DocObj As IDispatch Ptr Ptr, Byval lppcReturn As Window Ptr Ptr) As HRESULT
	End Type '_Windows__

	Type _LinkedWindows_ Extends CAIDispatch
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppptReturn As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lppcReturn As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Remove (Byval Window As Window Ptr) As HRESULT
		Declare Abstract Function Add (Byval Window As Window Ptr) As HRESULT
	End Type '_LinkedWindows_

	Type Events_ Extends CAIDispatch
		Declare Abstract Function Get_ReferencesEvents (Byval VBProject As VBProject Ptr, Byval prceNew As ReferencesEvents Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CommandBarEvents (Byval CommandBarControl As IDispatch Ptr, Byval prceNew As CommandBarEvents Ptr Ptr) As HRESULT
	End Type 'Events_

	Type _dispVBProjectsEvents_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract Function ItemAdded (Byval VBProject As VBProject Ptr) As HRESULT
		' Declare Abstract Function ItemRemoved (Byval VBProject As VBProject Ptr) As HRESULT
		' Declare Abstract Function ItemRenamed (Byval VBProject As VBProject Ptr, Byval OldName As BSTR) As HRESULT
		' Declare Abstract Function ItemActivated (Byval VBProject As VBProject Ptr) As HRESULT
	End Type '_dispVBProjectsEvents_

	Type _dispVBComponentsEvents_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract Function ItemAdded (Byval VBComponent As VBComponent Ptr) As HRESULT
		' Declare Abstract Function ItemRemoved (Byval VBComponent As VBComponent Ptr) As HRESULT
		' Declare Abstract Function ItemRenamed (Byval VBComponent As VBComponent Ptr, Byval OldName As BSTR) As HRESULT
		' Declare Abstract Function ItemSelected (Byval VBComponent As VBComponent Ptr) As HRESULT
		' Declare Abstract Function ItemActivated (Byval VBComponent As VBComponent Ptr) As HRESULT
		' Declare Abstract Function ItemReloaded (Byval VBComponent As VBComponent Ptr) As HRESULT
	End Type '_dispVBComponentsEvents_

	Type _dispReferencesEvents_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract Function ItemAdded (Byval Reference As Reference Ptr) As HRESULT
		' Declare Abstract Function ItemRemoved (Byval Reference As Reference Ptr) As HRESULT
	End Type '_dispReferencesEvents_

	Type _dispCommandBarControlEvents_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract Function Click (Byval CommandBarControl As IDispatch Ptr, Byval handled As VARIANT_BOOL Ptr, Byval CancelDefault As VARIANT_BOOL Ptr) As HRESULT
	End Type '_dispCommandBarControlEvents_

	Type _ProjectTemplate_ Extends CAIDispatch
		Declare Abstract Function Get_Application (Byval lppaReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppaReturn As Application Ptr Ptr) As HRESULT
	End Type '_ProjectTemplate_

	Type _VBProject_Old_ Extends _ProjectTemplate
		Declare Abstract Function Get_HelpFile (Byval lpbstrHelpFile As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_HelpFile (Byval lpbstrHelpFile As BSTR) As HRESULT
		Declare Abstract Function Get_HelpContextID (Byval lpdwContextID As Long Ptr) As HRESULT
		Declare Abstract Function Let_HelpContextID (Byval lpdwContextID As Long) As HRESULT
		Declare Abstract Function Get_Description (Byval lpbstrDescription As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Description (Byval lpbstrDescription As BSTR) As HRESULT
		Declare Abstract Function Get_Mode (Byval lpVbaMode As vbext_VBAMode Ptr) As HRESULT
		Declare Abstract Function Get_References (Byval lppReferences As References Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval lpbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval lpbstrName As BSTR) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Collection (Byval lppaReturn As VBProjects Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Protection (Byval lpProtection As vbext_ProjectProtection Ptr) As HRESULT
		Declare Abstract Function Get_Saved (Byval lpfReturn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_VBComponents (Byval lppcReturn As VBComponents Ptr Ptr) As HRESULT
	End Type '_VBProject_Old_

	Type _VBProject_ Extends _VBProject_Old
		Declare Abstract Function SaveAs (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function MakeCompiledFile () As HRESULT
		Declare Abstract Function Get_Type (Byval lpkind As vbext_ProjectType Ptr) As HRESULT
		Declare Abstract Function Get_FileName (Byval lpbstrReturn As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_BuildFileName (Byval lpbstrBldFName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_BuildFileName (Byval lpbstrBldFName As BSTR) As HRESULT
	End Type '_VBProject_

	Type _VBProjects_Old_ Extends CAIDispatch
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lppcReturn As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
	End Type '_VBProjects_Old_

	Type _VBProjects_ Extends _VBProjects_Old
		Declare Abstract Function Add (Byval Type_v As vbext_ProjectType, Byval lppcReturn As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Remove (Byval lpc As VBProject Ptr) As HRESULT
		Declare Abstract Function Open (Byval bstrPath As BSTR, Byval lpc As VBProject Ptr Ptr) As HRESULT
	End Type '_VBProjects_

	Type SelectedComponents_ Extends CAIDispatch
		Declare Abstract Function Item (Byval index As Long, Byval lppcReturn As Component Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval lppaReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppptReturn As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
	End Type 'SelectedComponents_

	Type _Components_ Extends CAIDispatch
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lppcReturn As Component Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval lppaReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppptReturn As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Remove (Byval Component As Component Ptr) As HRESULT
		Declare Abstract Function Add (Byval ComponentType As vbext_ComponentType, Byval lppComponent As Component Ptr Ptr) As HRESULT
		Declare Abstract Function Import_ (Byval FileName As BSTR, Byval lppComponent As Component Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
	End Type '_Components_

	Type _VBComponents_Old_ Extends CAIDispatch
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lppcReturn As VBComponent Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppptReturn As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Remove (Byval VBComponent As VBComponent Ptr) As HRESULT
		Declare Abstract Function Add (Byval ComponentType As vbext_ComponentType, Byval lppComponent As VBComponent Ptr Ptr) As HRESULT
		Declare Abstract Function Import_ (Byval FileName As BSTR, Byval lppComponent As VBComponent Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
	End Type '_VBComponents_Old_

	Type _VBComponents_ Extends _VBComponents_Old
		Declare Abstract Function AddCustom (Byval ProgId As BSTR, Byval lppComponent As VBComponent Ptr Ptr) As HRESULT
		Declare Abstract Function AddMTDesigner (Byval index As Long, Byval lppComponent As VBComponent Ptr Ptr) As HRESULT
	End Type '_VBComponents_

	Type _Component_ Extends CAIDispatch
		Declare Abstract Function Get_Application (Byval lppaReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppcReturn As Components Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IsDirty (Byval lpfReturn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_IsDirty (Byval lpfReturn As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrReturn As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval pbstrReturn As BSTR) As HRESULT
	End Type '_Component_

	Type _VBComponent_Old_ Extends CAIDispatch
		Declare Abstract Function Get_Saved (Byval lpfReturn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrReturn As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval pbstrReturn As BSTR) As HRESULT
		Declare Abstract Function Get_Designer (Byval ppDispatch As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CodeModule (Byval ppVbaModule As CodeModule Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval pKind As vbext_ComponentType Ptr) As HRESULT
		Declare Abstract Function Export_ (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Collection (Byval lppcReturn As VBComponents Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasOpenDesigner (Byval lpfReturn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Properties (Byval lpppReturn As Properties Ptr Ptr) As HRESULT
		Declare Abstract Function DesignerWindow (Byval lppcReturn As Window Ptr Ptr) As HRESULT
		Declare Abstract Function Activate () As HRESULT
	End Type '_VBComponent_Old_

	Type _VBComponent_ Extends _VBComponent_Old
		Declare Abstract Function Get_DesignerID (Byval pbstrReturn As BSTR Ptr) As HRESULT
	End Type '_VBComponent_

	Type Property_t_ Extends CAIDispatch
		Declare Abstract Function Get_Value (Byval lppvReturn As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Value (Byval lppvReturn As Variant Ptr) As HRESULT
		Declare Abstract Function Get_IndexedValue (Byval Index1 As Variant Ptr, Byval Index2 As Variant Ptr, Byval Index3 As Variant Ptr, Byval Index4 As Variant Ptr, Byval lppvReturn As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_IndexedValue (Byval Index1 As Variant Ptr, Byval Index2 As Variant Ptr, Byval Index3 As Variant Ptr, Byval Index4 As Variant Ptr, Byval lppvReturn As Variant Ptr) As HRESULT
		Declare Abstract Function Get_NumIndices (Byval lpiRetVal As Short Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval lpaReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lpppReturn As Properties Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval lpbstrReturn As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lpaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Collection (Byval lpppReturn As Properties Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Object (Byval lppunk As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Set_Object (Byval lppunk As IUnknown Ptr) As HRESULT
	End Type 'Property_t_

	Type _Properties_ Extends CAIDispatch
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lplppReturn As Property_t Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval lppaReturn As Application Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppidReturn As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
	End Type '_Properties_

	Type _AddIns_ Extends CAIDispatch
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval lppaddin As AddIn Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppVBA As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval lppVBA As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lplReturn As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval lppiuReturn As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Update () As HRESULT
	End Type '_AddIns_

	Type AddIn_ Extends CAIDispatch
		Declare Abstract Function Get_Description (Byval lpbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Description (Byval lpbstr As BSTR) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppVBE As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Collection (Byval lppaddins As Addins Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ProgId (Byval lpbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Guid (Byval lpbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Connect (Byval lpfConnect As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Connect (Byval lpfConnect As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Object (Byval lppdisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Object (Byval lppdisp As IDispatch Ptr) As HRESULT
	End Type 'AddIn_

	Type _CodeModule_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval retval As VBComponent Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval retval As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval pbstrName As BSTR) As HRESULT
		Declare Abstract Function AddFromString (Byval String_v As BSTR) As HRESULT
		Declare Abstract Function AddFromFile (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Get_Lines (Byval StartLine As Long, Byval Count As Long, Byval String_v As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CountOfLines (Byval CountOfLines As Long Ptr) As HRESULT
		Declare Abstract Function InsertLines (Byval Line As Long, Byval String_v As BSTR) As HRESULT
		Declare Abstract Function DeleteLines (Byval StartLine As Long, Byval Count As Long) As HRESULT
		Declare Abstract Function ReplaceLine (Byval Line As Long, Byval String_v As BSTR) As HRESULT
		Declare Abstract Function Get_ProcStartLine (Byval ProcName As BSTR, Byval ProcKind As vbext_ProcKind, Byval ProcStartLine As Long Ptr) As HRESULT
		Declare Abstract Function Get_ProcCountLines (Byval ProcName As BSTR, Byval ProcKind As vbext_ProcKind, Byval ProcCountLines As Long Ptr) As HRESULT
		Declare Abstract Function Get_ProcBodyLine (Byval ProcName As BSTR, Byval ProcKind As vbext_ProcKind, Byval ProcBodyLine As Long Ptr) As HRESULT
		Declare Abstract Function Get_ProcOfLine (Byval Line As Long, Byval ProcKind As vbext_ProcKind Ptr, Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CountOfDeclarationLines (Byval pDeclCountOfLines As Long Ptr) As HRESULT
		Declare Abstract Function CreateEventProc (Byval EventName As BSTR, Byval ObjectName As BSTR, Byval Line As Long Ptr) As HRESULT
		Declare Abstract Function Find (Byval Target As BSTR, Byval StartLine As Long Ptr, Byval StartColumn As Long Ptr, Byval EndLine As Long Ptr, Byval EndColumn As Long Ptr, Byval WholeWord As VARIANT_BOOL, Byval MatchCase As VARIANT_BOOL, Byval PatternSearch As VARIANT_BOOL, Byval pfFound As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_CodePane (Byval CodePane As CodePane Ptr Ptr) As HRESULT
	End Type '_CodeModule_

	Type _CodePanes_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval retval As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval retval As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval CodePane As CodePane Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval ppenum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Current (Byval CodePane As CodePane Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Current (Byval CodePane As CodePane Ptr) As HRESULT
	End Type '_CodePanes_

	Type _CodePane_ Extends CAIDispatch
		Declare Abstract Function Get_Collection (Byval retval As CodePanes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval retval As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Window (Byval retval As Window Ptr Ptr) As HRESULT
		Declare Abstract Function GetSelection (Byval StartLine As Long Ptr, Byval StartColumn As Long Ptr, Byval EndLine As Long Ptr, Byval EndColumn As Long Ptr) As HRESULT
		Declare Abstract Function SetSelection (Byval StartLine As Long, Byval StartColumn As Long, Byval EndLine As Long, Byval EndColumn As Long) As HRESULT
		Declare Abstract Function Get_TopLine (Byval TopLine As Long Ptr) As HRESULT
		Declare Abstract Function Let_TopLine (Byval TopLine As Long) As HRESULT
		Declare Abstract Function Get_CountOfVisibleLines (Byval CountOfVisibleLines As Long Ptr) As HRESULT
		Declare Abstract Function Get_CodeModule (Byval CodeModule As CodeModule Ptr Ptr) As HRESULT
		Declare Abstract Function Show () As HRESULT
		Declare Abstract Function Get_CodePaneView (Byval pCodePaneview As vbext_CodePaneview Ptr) As HRESULT
	End Type '_CodePane_

	Type _References_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval retval As VBProject Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval retval As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval index As Variant Ptr, Byval Reference As Reference Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval ppenum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function AddFromGuid (Byval Guid As BSTR, Byval Major As Long, Byval Minor As Long, Byval Reference As Reference Ptr Ptr) As HRESULT
		Declare Abstract Function AddFromFile (Byval FileName As BSTR, Byval Reference As Reference Ptr Ptr) As HRESULT
		Declare Abstract Function Remove (Byval Reference As Reference Ptr) As HRESULT
	End Type '_References_

	Type Reference_ Extends CAIDispatch
		Declare Abstract Function Get_Collection (Byval retval As References Ptr Ptr) As HRESULT
		Declare Abstract Function Get_VBE (Byval lppaReturn As VBE Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Guid (Byval pbstrGuid As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Major (Byval pMajor As Long Ptr) As HRESULT
		Declare Abstract Function Get_Minor (Byval pMinor As Long Ptr) As HRESULT
		Declare Abstract Function Get_FullPath (Byval pbstrLocation As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_BuiltIn (Byval pfIsDefault As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_IsBroken (Byval pfIsBroken As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval pKind As vbext_RefKind Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval pbstrName As BSTR Ptr) As HRESULT
	End Type 'Reference_

	Type _dispReferences_Events_ Extends CAIDispatch ' Dispinterface only supports post binding!
		' Declare Abstract Function ItemAdded (Byval Reference As Reference Ptr) As HRESULT
		' Declare Abstract Function ItemRemoved (Byval Reference As Reference Ptr) As HRESULT
	End Type '_dispReferences_Events_

End Namespace