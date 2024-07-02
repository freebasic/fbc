'=============================================Type library===========================================
' Name       : Office
' Description: Microsoft Office 16.0 Object Library
' Path       : C:\Program Files (x86)\Common Files\Microsoft Shared\Office16\MSO.DLL
'====================================================================================================

#pragma Once
#Include Once "FBCom.bi"
#Include Once "stdole2.bi"  'C:\Windows\SysWOW64\stdole2.tlb

Namespace Office

	'Class identifier (CLSID)
	Const CLSID_CommandBars = "{55F88893-7708-11D1-ACEB-006008961DA5}"
	Const CLSID_CommandBarComboBox = "{55F88897-7708-11D1-ACEB-006008961DA5}"
	Const CLSID_CommandBarButton = "{55F88891-7708-11D1-ACEB-006008961DA5}"
	Const CLSID_MsoEnvelope = "{0006F01A-0000-0000-C000-000000000046}"
	Const CLSID_CustomXMLSchemaCollection = "{000CDB0D-0000-0000-C000-000000000046}"
	Const CLSID_CustomXMLPart = "{000CDB08-0000-0000-C000-000000000046}"
	Const CLSID_CustomXMLParts = "{000CDB0C-0000-0000-C000-000000000046}"
	Const CLSID_CustomTaskPane = "{C5771BE5-A188-466B-AB31-00A6A32B1B1C}"

	'Interface identifier (IID)
	Const IID_IAccessible = "{618736E0-3C3D-11CF-810C-00AA00389B71}"
	Const IID__IMsoDispObj = "{000C0300-0000-0000-C000-000000000046}"
	Const IID__IMsoOleAccDispObj = "{000C0301-0000-0000-C000-000000000046}"
	Const IID__CommandBars = "{000C0302-0000-0000-C000-000000000046}"
	Const IID_CommandBar = "{000C0304-0000-0000-C000-000000000046}"
	Const IID_CommandBarControls = "{000C0306-0000-0000-C000-000000000046}"
	Const IID_CommandBarControl = "{000C0308-0000-0000-C000-000000000046}"
	Const IID__CommandBarButton = "{000C030E-0000-0000-C000-000000000046}"
	Const IID_CommandBarPopup = "{000C030A-0000-0000-C000-000000000046}"
	Const IID__CommandBarComboBox = "{000C030C-0000-0000-C000-000000000046}"
	Const IID__CommandBarActiveX = "{000C030D-0000-0000-C000-000000000046}"
	Const IID_Adjustments = "{000C0310-0000-0000-C000-000000000046}"
	Const IID_CalloutFormat = "{000C0311-0000-0000-C000-000000000046}"
	Const IID_ColorFormat = "{000C0312-0000-0000-C000-000000000046}"
	Const IID_ConnectorFormat = "{000C0313-0000-0000-C000-000000000046}"
	Const IID_FillFormat = "{000C0314-0000-0000-C000-000000000046}"
	Const IID_FreeformBuilder = "{000C0315-0000-0000-C000-000000000046}"
	Const IID_GroupShapes = "{000C0316-0000-0000-C000-000000000046}"
	Const IID_LineFormat = "{000C0317-0000-0000-C000-000000000046}"
	Const IID_ShapeNode = "{000C0318-0000-0000-C000-000000000046}"
	Const IID_ShapeNodes = "{000C0319-0000-0000-C000-000000000046}"
	Const IID_PictureFormat = "{000C031A-0000-0000-C000-000000000046}"
	Const IID_ShadowFormat = "{000C031B-0000-0000-C000-000000000046}"
	Const IID_Script = "{000C0341-0000-0000-C000-000000000046}"
	Const IID_Scripts = "{000C0340-0000-0000-C000-000000000046}"
	Const IID_Shape = "{000C031C-0000-0000-C000-000000000046}"
	Const IID_ShapeRange = "{000C031D-0000-0000-C000-000000000046}"
	Const IID_Shapes = "{000C031E-0000-0000-C000-000000000046}"
	Const IID_TextEffectFormat = "{000C031F-0000-0000-C000-000000000046}"
	Const IID_TextFrame = "{000C0320-0000-0000-C000-000000000046}"
	Const IID_ThreeDFormat = "{000C0321-0000-0000-C000-000000000046}"
	Const IID_IMsoDispCagNotifySink = "{000C0359-0000-0000-C000-000000000046}"
	Const IID_Balloon = "{000C0324-0000-0000-C000-000000000046}"
	Const IID_BalloonCheckboxes = "{000C0326-0000-0000-C000-000000000046}"
	Const IID_BalloonCheckbox = "{000C0328-0000-0000-C000-000000000046}"
	Const IID_BalloonLabels = "{000C032E-0000-0000-C000-000000000046}"
	Const IID_BalloonLabel = "{000C0330-0000-0000-C000-000000000046}"
	Const IID_AnswerWizardFiles = "{000C0361-0000-0000-C000-000000000046}"
	Const IID_AnswerWizard = "{000C0360-0000-0000-C000-000000000046}"
	Const IID_Assistant = "{000C0322-0000-0000-C000-000000000046}"
	Const IID_IFoundFiles = "{000C0338-0000-0000-C000-000000000046}"
	Const IID_IFind = "{000C0337-0000-0000-C000-000000000046}"
	Const IID_FoundFiles = "{000C0331-0000-0000-C000-000000000046}"
	Const IID_PropertyTest = "{000C0333-0000-0000-C000-000000000046}"
	Const IID_PropertyTests = "{000C0334-0000-0000-C000-000000000046}"
	Const IID_FileSearch = "{000C0332-0000-0000-C000-000000000046}"
	Const IID_COMAddIn = "{000C033A-0000-0000-C000-000000000046}"
	Const IID_COMAddIns = "{000C0339-0000-0000-C000-000000000046}"
	Const IID_LanguageSettings = "{000C0353-0000-0000-C000-000000000046}"
	Const IID_ICommandBarsEvents = "{55F88892-7708-11D1-ACEB-006008961DA5}"
	Const IID__CommandBarsEvents = "{000C0352-0000-0000-C000-000000000046}"
	Const IID_ICommandBarComboBoxEvents = "{55F88896-7708-11D1-ACEB-006008961DA5}"
	Const IID__CommandBarComboBoxEvents = "{000C0354-0000-0000-C000-000000000046}"
	Const IID_ICommandBarButtonEvents = "{55F88890-7708-11D1-ACEB-006008961DA5}"
	Const IID__CommandBarButtonEvents = "{000C0351-0000-0000-C000-000000000046}"
	Const IID_WebPageFont = "{000C0913-0000-0000-C000-000000000046}"
	Const IID_WebPageFonts = "{000C0914-0000-0000-C000-000000000046}"
	Const IID_HTMLProjectItem = "{000C0358-0000-0000-C000-000000000046}"
	Const IID_HTMLProjectItems = "{000C0357-0000-0000-C000-000000000046}"
	Const IID_HTMLProject = "{000C0356-0000-0000-C000-000000000046}"
	Const IID_MsoDebugOptions = "{000C035A-0000-0000-C000-000000000046}"
	Const IID_FileDialogSelectedItems = "{000C0363-0000-0000-C000-000000000046}"
	Const IID_FileDialogFilter = "{000C0364-0000-0000-C000-000000000046}"
	Const IID_FileDialogFilters = "{000C0365-0000-0000-C000-000000000046}"
	Const IID_FileDialog = "{000C0362-0000-0000-C000-000000000046}"
	Const IID_SignatureSet = "{000C0410-0000-0000-C000-000000000046}"
	Const IID_Signature = "{000C0411-0000-0000-C000-000000000046}"
	Const IID_IMsoEnvelopeVB = "{000672AC-0000-0000-C000-000000000046}"
	Const IID_IMsoEnvelopeVBEvents = "{000672AD-0000-0000-C000-000000000046}"
	Const IID_FileTypes = "{000C036C-0000-0000-C000-000000000046}"
	Const IID_SearchFolders = "{000C036A-0000-0000-C000-000000000046}"
	Const IID_ScopeFolders = "{000C0369-0000-0000-C000-000000000046}"
	Const IID_ScopeFolder = "{000C0368-0000-0000-C000-000000000046}"
	Const IID_SearchScope = "{000C0367-0000-0000-C000-000000000046}"
	Const IID_SearchScopes = "{000C0366-0000-0000-C000-000000000046}"
	Const IID_IMsoDiagram = "{000C036D-0000-0000-C000-000000000046}"
	Const IID_DiagramNodes = "{000C036E-0000-0000-C000-000000000046}"
	Const IID_DiagramNodeChildren = "{000C036F-0000-0000-C000-000000000046}"
	Const IID_DiagramNode = "{000C0370-0000-0000-C000-000000000046}"
	Const IID_CanvasShapes = "{000C0371-0000-0000-C000-000000000046}"
	Const IID_OfficeDataSourceObject = "{000C1530-0000-0000-C000-000000000046}"
	Const IID_ODSOColumn = "{000C1531-0000-0000-C000-000000000046}"
	Const IID_ODSOColumns = "{000C1532-0000-0000-C000-000000000046}"
	Const IID_ODSOFilter = "{000C1533-0000-0000-C000-000000000046}"
	Const IID_ODSOFilters = "{000C1534-0000-0000-C000-000000000046}"
	Const IID_NewFile = "{000C0936-0000-0000-C000-000000000046}"
	Const IID_WebComponent = "{000CD100-0000-0000-C000-000000000046}"
	Const IID_WebComponentWindowExternal = "{000CD101-0000-0000-C000-000000000046}"
	Const IID_WebComponentFormat = "{000CD102-0000-0000-C000-000000000046}"
	Const IID_ILicWizExternal = "{4CAC6328-B9B0-11D3-8D59-0050048384E3}"
	Const IID_ILicValidator = "{919AA22C-B9AD-11D3-8D59-0050048384E3}"
	Const IID_ILicAgent = "{00194002-D9C3-11D3-8D59-0050048384E3}"
	Const IID_IMsoEServicesDialog = "{000C0372-0000-0000-C000-000000000046}"
	Const IID_WebComponentProperties = "{000C0373-0000-0000-C000-000000000046}"
	Const IID_SmartDocument = "{000C0377-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceMember = "{000C0381-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceMembers = "{000C0382-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceTask = "{000C0379-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceTasks = "{000C037A-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceFile = "{000C037B-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceFiles = "{000C037C-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceFolder = "{000C037D-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceFolders = "{000C037E-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceLink = "{000C037F-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspaceLinks = "{000C0380-0000-0000-C000-000000000046}"
	Const IID_SharedWorkspace = "{000C0385-0000-0000-C000-000000000046}"
	Const IID_Sync = "{000C0386-0000-0000-C000-000000000046}"
	Const IID_DocumentLibraryVersion = "{000C0387-0000-0000-C000-000000000046}"
	Const IID_DocumentLibraryVersions = "{000C0388-0000-0000-C000-000000000046}"
	Const IID_UserPermission = "{000C0375-0000-0000-C000-000000000046}"
	Const IID_Permission = "{000C0376-0000-0000-C000-000000000046}"
	Const IID_MsoDebugOptions_UTRunResult = "{000C038C-0000-0000-C000-000000000046}"
	Const IID_MsoDebugOptions_UT = "{000C038B-0000-0000-C000-000000000046}"
	Const IID_MsoDebugOptions_UTs = "{000C038A-0000-0000-C000-000000000046}"
	Const IID_MsoDebugOptions_UTManager = "{000C0389-0000-0000-C000-000000000046}"
	Const IID_MetaProperty = "{000C038F-0000-0000-C000-000000000046}"
	Const IID_MetaProperties = "{000C038E-0000-0000-C000-000000000046}"
	Const IID_PolicyItem = "{000C0391-0000-0000-C000-000000000046}"
	Const IID_ServerPolicy = "{000C0390-0000-0000-C000-000000000046}"
	Const IID_DocumentInspector = "{000C0393-0000-0000-C000-000000000046}"
	Const IID_DocumentInspectors = "{000C0392-0000-0000-C000-000000000046}"
	Const IID_WorkflowTask = "{000CD900-0000-0000-C000-000000000046}"
	Const IID_WorkflowTasks = "{000CD901-0000-0000-C000-000000000046}"
	Const IID_WorkflowTemplate = "{000CD902-0000-0000-C000-000000000046}"
	Const IID_WorkflowTemplates = "{000CD903-0000-0000-C000-000000000046}"
	Const IID_SignatureSetup = "{000CD6A1-0000-0000-C000-000000000046}"
	Const IID_SignatureInfo = "{000CD6A2-0000-0000-C000-000000000046}"
	Const IID_SignatureProvider = "{000CD6A3-0000-0000-C000-000000000046}"
	Const IID_CustomXMLPrefixMapping = "{000CDB10-0000-0000-C000-000000000046}"
	Const IID_CustomXMLPrefixMappings = "{000CDB00-0000-0000-C000-000000000046}"
	Const IID_CustomXMLSchema = "{000CDB01-0000-0000-C000-000000000046}"
	Const IID__CustomXMLSchemaCollection = "{000CDB02-0000-0000-C000-000000000046}"
	Const IID_CustomXMLNodes = "{000CDB03-0000-0000-C000-000000000046}"
	Const IID_CustomXMLNode = "{000CDB04-0000-0000-C000-000000000046}"
	Const IID_CustomXMLValidationError = "{000CDB0E-0000-0000-C000-000000000046}"
	Const IID_CustomXMLValidationErrors = "{000CDB0F-0000-0000-C000-000000000046}"
	Const IID__CustomXMLPart = "{000CDB05-0000-0000-C000-000000000046}"
	Const IID_ICustomXMLPartEvents = "{000CDB06-0000-0000-C000-000000000046}"
	Const IID__CustomXMLPartEvents = "{000CDB07-0000-0000-C000-000000000046}"
	Const IID__CustomXMLParts = "{000CDB09-0000-0000-C000-000000000046}"
	Const IID_ICustomXMLPartsEvents = "{000CDB0A-0000-0000-C000-000000000046}"
	Const IID__CustomXMLPartsEvents = "{000CDB0B-0000-0000-C000-000000000046}"
	Const IID_GradientStop = "{000C03BF-0000-0000-C000-000000000046}"
	Const IID_GradientStops = "{000C03C0-0000-0000-C000-000000000046}"
	Const IID_SoftEdgeFormat = "{000C03BC-0000-0000-C000-000000000046}"
	Const IID_GlowFormat = "{000C03BD-0000-0000-C000-000000000046}"
	Const IID_ReflectionFormat = "{000C03BE-0000-0000-C000-000000000046}"
	Const IID_ParagraphFormat2 = "{000C0399-0000-0000-C000-000000000046}"
	Const IID_Font2 = "{000C039A-0000-0000-C000-000000000046}"
	Const IID_TextColumn2 = "{000C03B2-0000-0000-C000-000000000046}"
	Const IID_TextRange2 = "{000C0397-0000-0000-C000-000000000046}"
	Const IID_TextFrame2 = "{000C0398-0000-0000-C000-000000000046}"
	Const IID_ThemeColor = "{000C03A1-0000-0000-C000-000000000046}"
	Const IID_ThemeColorScheme = "{000C03A2-0000-0000-C000-000000000046}"
	Const IID_ThemeFont = "{000C03A3-0000-0000-C000-000000000046}"
	Const IID_ThemeFonts = "{000C03A4-0000-0000-C000-000000000046}"
	Const IID_ThemeFontScheme = "{000C03A5-0000-0000-C000-000000000046}"
	Const IID_ThemeEffectScheme = "{000C03A6-0000-0000-C000-000000000046}"
	Const IID_OfficeTheme = "{000C03A0-0000-0000-C000-000000000046}"
	Const IID__CustomTaskPane = "{000C033B-0000-0000-C000-000000000046}"
	Const IID_CustomTaskPaneEvents = "{8A64A872-FC6B-4D4A-926E-3A3689562C1C}"
	Const IID__CustomTaskPaneEvents = "{000C033C-0000-0000-C000-000000000046}"
	Const IID_ICTPFactory = "{000C033D-0000-0000-C000-000000000046}"
	Const IID_ICustomTaskPaneConsumer = "{000C033E-0000-0000-C000-000000000046}"
	Const IID_IRibbonUI = "{000C03A7-0000-0000-C000-000000000046}"
	Const IID_IRibbonControl = "{000C0395-0000-0000-C000-000000000046}"
	Const IID_IRibbonExtensibility = "{000C0396-0000-0000-C000-000000000046}"
	Const IID_IAssistance = "{4291224C-DEFE-485B-8E69-6CF8AA85CB76}"
	Const IID_IMsoChartData = "{000C172F-0000-0000-C000-000000000046}"
	Const IID_IMsoChart = "{000C1709-0000-0000-C000-000000000046}"
	Const IID_IMsoCorners = "{000C1714-0000-0000-C000-000000000046}"
	Const IID_IMsoLegend = "{000C1710-0000-0000-C000-000000000046}"
	Const IID_IMsoBorder = "{000C1717-0000-0000-C000-000000000046}"
	Const IID_IMsoWalls = "{000C1715-0000-0000-C000-000000000046}"
	Const IID_IMsoFloor = "{000C1716-0000-0000-C000-000000000046}"
	Const IID_IMsoPlotArea = "{000C1724-0000-0000-C000-000000000046}"
	Const IID_IMsoChartArea = "{000C1728-0000-0000-C000-000000000046}"
	Const IID_IMsoSeriesLines = "{000C1729-0000-0000-C000-000000000046}"
	Const IID_IMsoLeaderLines = "{000C1723-0000-0000-C000-000000000046}"
	Const IID_GridLines = "{000C1725-0000-0000-C000-000000000046}"
	Const IID_IMsoUpBars = "{000C172A-0000-0000-C000-000000000046}"
	Const IID_IMsoDownBars = "{000C172D-0000-0000-C000-000000000046}"
	Const IID_IMsoInterior = "{000C171B-0000-0000-C000-000000000046}"
	Const IID_ChartFillFormat = "{000C171C-0000-0000-C000-000000000046}"
	Const IID_ChartFont = "{000C1718-0000-0000-C000-000000000046}"
	Const IID_Axes = "{000C1712-0000-0000-C000-000000000046}"
	Const IID_IMsoAxis = "{000C1713-0000-0000-C000-000000000046}"
	Const IID_IMsoDataTable = "{000C1711-0000-0000-C000-000000000046}"
	Const IID_IMsoChartTitle = "{000C170F-0000-0000-C000-000000000046}"
	Const IID_IMsoAxisTitle = "{ABFA087C-F703-4D53-946E-37FF82B2C994}"
	Const IID_IMsoDisplayUnitLabel = "{6EA00553-9439-4D5A-B1E6-DC15A54DA8B2}"
	Const IID_IMsoTickLabels = "{000C1726-0000-0000-C000-000000000046}"
	Const IID_IMsoHyperlinks = "{A98639A1-CB0C-4A5C-A511-96547F752ACD}"
	Const IID_IMsoDropLines = "{000C172C-0000-0000-C000-000000000046}"
	Const IID_IMsoHiLoLines = "{000C172E-0000-0000-C000-000000000046}"
	Const IID_IMsoChartGroup = "{000C1727-0000-0000-C000-000000000046}"
	Const IID_ChartGroups = "{000C172B-0000-0000-C000-000000000046}"
	Const IID_IMsoCharacters = "{000C1731-0000-0000-C000-000000000046}"
	Const IID_IMsoChartFormat = "{000C1730-0000-0000-C000-000000000046}"
	Const IID_BulletFormat2 = "{000C03B9-0000-0000-C000-000000000046}"
	Const IID_TabStops2 = "{000C03BA-0000-0000-C000-000000000046}"
	Const IID_TabStop2 = "{000C03BB-0000-0000-C000-000000000046}"
	Const IID_Ruler2 = "{000C03C1-0000-0000-C000-000000000046}"
	Const IID_RulerLevels2 = "{000C03C2-0000-0000-C000-000000000046}"
	Const IID_RulerLevel2 = "{000C03C3-0000-0000-C000-000000000046}"
	Const IID_EncryptionProvider = "{000CD809-0000-0000-C000-000000000046}"
	Const IID_IBlogExtensibility = "{000C03C4-0000-0000-C000-000000000046}"
	Const IID_IBlogPictureExtensibility = "{000C03C5-0000-0000-C000-000000000046}"
	Const IID_SmartArt = "{000C03C6-0000-0000-C000-000000000046}"
	Const IID_SmartArtNodes = "{000C03C7-0000-0000-C000-000000000046}"
	Const IID_SmartArtNode = "{000C03C8-0000-0000-C000-000000000046}"
	Const IID_SmartArtLayouts = "{000C03C9-0000-0000-C000-000000000046}"
	Const IID_SmartArtLayout = "{000C03CA-0000-0000-C000-000000000046}"
	Const IID_SmartArtQuickStyles = "{000C03CB-0000-0000-C000-000000000046}"
	Const IID_SmartArtQuickStyle = "{000C03CC-0000-0000-C000-000000000046}"
	Const IID_SmartArtColors = "{000C03CD-0000-0000-C000-000000000046}"
	Const IID_SmartArtColor = "{000C03CE-0000-0000-C000-000000000046}"
	Const IID_PickerField = "{000C03E0-0000-0000-C000-000000000046}"
	Const IID_PickerFields = "{000C03E1-0000-0000-C000-000000000046}"
	Const IID_PickerProperty = "{000C03E2-0000-0000-C000-000000000046}"
	Const IID_PickerProperties = "{000C03E3-0000-0000-C000-000000000046}"
	Const IID_PickerResult = "{000C03E4-0000-0000-C000-000000000046}"
	Const IID_PickerResults = "{000C03E5-0000-0000-C000-000000000046}"
	Const IID_PickerDialog = "{000C03E6-0000-0000-C000-000000000046}"
	Const IID_IMsoContactCard = "{000C03F0-0000-0000-C000-000000000046}"
	Const IID_EffectParameter = "{000C03CF-0000-0000-C000-000000000046}"
	Const IID_EffectParameters = "{000C03D0-0000-0000-C000-000000000046}"
	Const IID_PictureEffect = "{000C03D1-0000-0000-C000-000000000046}"
	Const IID_PictureEffects = "{000C03D2-0000-0000-C000-000000000046}"
	Const IID_Crop = "{000C03D3-0000-0000-C000-000000000046}"
	Const IID_ContactCard = "{000C03F1-0000-0000-C000-000000000046}"
	
	Type MsoRGBType As Long

	Enum MsoLineDashStyle
		msoLineDashStyleMixed = -2
		msoLineSolid = 1
		msoLineSquareDot = 2
		msoLineRoundDot = 3
		msoLineDash = 4
		msoLineDashDot = 5
		msoLineDashDotDot = 6
		msoLineLongDash = 7
		msoLineLongDashDot = 8
		msoLineLongDashDotDot = 9
		msoLineSysDash = 10
		msoLineSysDot = 11
		msoLineSysDashDot = 12
	End Enum

	Enum MsoLineStyle
		msoLineStyleMixed = -2
		msoLineSingle = 1
		msoLineThinThin = 2
		msoLineThinThick = 3
		msoLineThickThin = 4
		msoLineThickBetweenThin = 5
	End Enum

	Enum MsoArrowheadStyle
		msoArrowheadStyleMixed = -2
		msoArrowheadNone = 1
		msoArrowheadTriangle = 2
		msoArrowheadOpen = 3
		msoArrowheadStealth = 4
		msoArrowheadDiamond = 5
		msoArrowheadOval = 6
	End Enum

	Enum MsoArrowheadWidth
		msoArrowheadWidthMixed = -2
		msoArrowheadNarrow = 1
		msoArrowheadWidthMedium = 2
		msoArrowheadWide = 3
	End Enum

	Enum MsoArrowheadLength
		msoArrowheadLengthMixed = -2
		msoArrowheadShort = 1
		msoArrowheadLengthMedium = 2
		msoArrowheadLong = 3
	End Enum

	Enum MsoFillType
		msoFillMixed = -2
		msoFillSolid = 1
		msoFillPatterned = 2
		msoFillGradient = 3
		msoFillTextured = 4
		msoFillBackground = 5
		msoFillPicture = 6
	End Enum

	Enum MsoGradientStyle
		msoGradientMixed = -2
		msoGradientHorizontal = 1
		msoGradientVertical = 2
		msoGradientDiagonalUp = 3
		msoGradientDiagonalDown = 4
		msoGradientFromCorner = 5
		msoGradientFromTitle = 6
		msoGradientFromCenter = 7
	End Enum

	Enum MsoGradientColorType
		msoGradientColorMixed = -2
		msoGradientOneColor = 1
		msoGradientTwoColors = 2
		msoGradientPresetColors = 3
		msoGradientMultiColor = 4
	End Enum

	Enum MsoTextureType
		msoTextureTypeMixed = -2
		msoTexturePreset = 1
		msoTextureUserDefined = 2
	End Enum

	Enum MsoPresetTexture
		msoPresetTextureMixed = -2
		msoTexturePapyrus = 1
		msoTextureCanvas = 2
		msoTextureDenim = 3
		msoTextureWovenMat = 4
		msoTextureWaterDroplets = 5
		msoTexturePaperBag = 6
		msoTextureFishFossil = 7
		msoTextureSand = 8
		msoTextureGreenMarble = 9
		msoTextureWhiteMarble = 10
		msoTextureBrownMarble = 11
		msoTextureGranite = 12
		msoTextureNewsprint = 13
		msoTextureRecycledPaper = 14
		msoTextureParchment = 15
		msoTextureStationery = 16
		msoTextureBlueTissuePaper = 17
		msoTexturePinkTissuePaper = 18
		msoTexturePurpleMesh = 19
		msoTextureBouquet = 20
		msoTextureCork = 21
		msoTextureWalnut = 22
		msoTextureOak = 23
		msoTextureMediumWood = 24
	End Enum

	Enum MsoPatternType
		msoPatternMixed = -2
		msoPattern5Percent = 1
		msoPattern10Percent = 2
		msoPattern20Percent = 3
		msoPattern25Percent = 4
		msoPattern30Percent = 5
		msoPattern40Percent = 6
		msoPattern50Percent = 7
		msoPattern60Percent = 8
		msoPattern70Percent = 9
		msoPattern75Percent = 10
		msoPattern80Percent = 11
		msoPattern90Percent = 12
		msoPatternDarkHorizontal = 13
		msoPatternDarkVertical = 14
		msoPatternDarkDownwardDiagonal = 15
		msoPatternDarkUpwardDiagonal = 16
		msoPatternSmallCheckerBoard = 17
		msoPatternTrellis = 18
		msoPatternLightHorizontal = 19
		msoPatternLightVertical = 20
		msoPatternLightDownwardDiagonal = 21
		msoPatternLightUpwardDiagonal = 22
		msoPatternSmallGrid = 23
		msoPatternDottedDiamond = 24
		msoPatternWideDownwardDiagonal = 25
		msoPatternWideUpwardDiagonal = 26
		msoPatternDashedUpwardDiagonal = 27
		msoPatternDashedDownwardDiagonal = 28
		msoPatternNarrowVertical = 29
		msoPatternNarrowHorizontal = 30
		msoPatternDashedVertical = 31
		msoPatternDashedHorizontal = 32
		msoPatternLargeConfetti = 33
		msoPatternLargeGrid = 34
		msoPatternHorizontalBrick = 35
		msoPatternLargeCheckerBoard = 36
		msoPatternSmallConfetti = 37
		msoPatternZigZag = 38
		msoPatternSolidDiamond = 39
		msoPatternDiagonalBrick = 40
		msoPatternOutlinedDiamond = 41
		msoPatternPlaid = 42
		msoPatternSphere = 43
		msoPatternWeave = 44
		msoPatternDottedGrid = 45
		msoPatternDivot = 46
		msoPatternShingle = 47
		msoPatternWave = 48
		msoPatternHorizontal = 49
		msoPatternVertical = 50
		msoPatternCross = 51
		msoPatternDownwardDiagonal = 52
		msoPatternUpwardDiagonal = 53
		msoPatternDiagonalCross = 54
	End Enum

	Enum MsoPresetGradientType
		msoPresetGradientMixed = -2
		msoGradientEarlySunset = 1
		msoGradientLateSunset = 2
		msoGradientNightfall = 3
		msoGradientDaybreak = 4
		msoGradientHorizon = 5
		msoGradientDesert = 6
		msoGradientOcean = 7
		msoGradientCalmWater = 8
		msoGradientFire = 9
		msoGradientFog = 10
		msoGradientMoss = 11
		msoGradientPeacock = 12
		msoGradientWheat = 13
		msoGradientParchment = 14
		msoGradientMahogany = 15
		msoGradientRainbow = 16
		msoGradientRainbowII = 17
		msoGradientGold = 18
		msoGradientGoldII = 19
		msoGradientBrass = 20
		msoGradientChrome = 21
		msoGradientChromeII = 22
		msoGradientSilver = 23
		msoGradientSapphire = 24
	End Enum

	Enum MsoShadowType
		msoShadowMixed = -2
		msoShadow1 = 1
		msoShadow2 = 2
		msoShadow3 = 3
		msoShadow4 = 4
		msoShadow5 = 5
		msoShadow6 = 6
		msoShadow7 = 7
		msoShadow8 = 8
		msoShadow9 = 9
		msoShadow10 = 10
		msoShadow11 = 11
		msoShadow12 = 12
		msoShadow13 = 13
		msoShadow14 = 14
		msoShadow15 = 15
		msoShadow16 = 16
		msoShadow17 = 17
		msoShadow18 = 18
		msoShadow19 = 19
		msoShadow20 = 20
		msoShadow21 = 21
		msoShadow22 = 22
		msoShadow23 = 23
		msoShadow24 = 24
		msoShadow25 = 25
		msoShadow26 = 26
		msoShadow27 = 27
		msoShadow28 = 28
		msoShadow29 = 29
		msoShadow30 = 30
		msoShadow31 = 31
		msoShadow32 = 32
		msoShadow33 = 33
		msoShadow34 = 34
		msoShadow35 = 35
		msoShadow36 = 36
		msoShadow37 = 37
		msoShadow38 = 38
		msoShadow39 = 39
		msoShadow40 = 40
		msoShadow41 = 41
		msoShadow42 = 42
		msoShadow43 = 43
	End Enum

	Enum MsoPresetTextEffect
		msoTextEffectMixed = -2
		msoTextEffect1 = 0
		msoTextEffect2 = 1
		msoTextEffect3 = 2
		msoTextEffect4 = 3
		msoTextEffect5 = 4
		msoTextEffect6 = 5
		msoTextEffect7 = 6
		msoTextEffect8 = 7
		msoTextEffect9 = 8
		msoTextEffect10 = 9
		msoTextEffect11 = 10
		msoTextEffect12 = 11
		msoTextEffect13 = 12
		msoTextEffect14 = 13
		msoTextEffect15 = 14
		msoTextEffect16 = 15
		msoTextEffect17 = 16
		msoTextEffect18 = 17
		msoTextEffect19 = 18
		msoTextEffect20 = 19
		msoTextEffect21 = 20
		msoTextEffect22 = 21
		msoTextEffect23 = 22
		msoTextEffect24 = 23
		msoTextEffect25 = 24
		msoTextEffect26 = 25
		msoTextEffect27 = 26
		msoTextEffect28 = 27
		msoTextEffect29 = 28
		msoTextEffect30 = 29
		msoTextEffect31 = 30
		msoTextEffect32 = 31
		msoTextEffect33 = 32
		msoTextEffect34 = 33
		msoTextEffect35 = 34
		msoTextEffect36 = 35
		msoTextEffect37 = 36
		msoTextEffect38 = 37
		msoTextEffect39 = 38
		msoTextEffect40 = 39
		msoTextEffect41 = 40
		msoTextEffect42 = 41
		msoTextEffect43 = 42
		msoTextEffect44 = 43
		msoTextEffect45 = 44
		msoTextEffect46 = 45
		msoTextEffect47 = 46
		msoTextEffect48 = 47
		msoTextEffect49 = 48
		msoTextEffect50 = 49
	End Enum

	Enum MsoPresetTextEffectShape
		msoTextEffectShapeMixed = -2
		msoTextEffectShapePlainText = 1
		msoTextEffectShapeStop = 2
		msoTextEffectShapeTriangleUp = 3
		msoTextEffectShapeTriangleDown = 4
		msoTextEffectShapeChevronUp = 5
		msoTextEffectShapeChevronDown = 6
		msoTextEffectShapeRingInside = 7
		msoTextEffectShapeRingOutside = 8
		msoTextEffectShapeArchUpCurve = 9
		msoTextEffectShapeArchDownCurve = 10
		msoTextEffectShapeCircleCurve = 11
		msoTextEffectShapeButtonCurve = 12
		msoTextEffectShapeArchUpPour = 13
		msoTextEffectShapeArchDownPour = 14
		msoTextEffectShapeCirclePour = 15
		msoTextEffectShapeButtonPour = 16
		msoTextEffectShapeCurveUp = 17
		msoTextEffectShapeCurveDown = 18
		msoTextEffectShapeCanUp = 19
		msoTextEffectShapeCanDown = 20
		msoTextEffectShapeWave1 = 21
		msoTextEffectShapeWave2 = 22
		msoTextEffectShapeDoubleWave1 = 23
		msoTextEffectShapeDoubleWave2 = 24
		msoTextEffectShapeInflate = 25
		msoTextEffectShapeDeflate = 26
		msoTextEffectShapeInflateBottom = 27
		msoTextEffectShapeDeflateBottom = 28
		msoTextEffectShapeInflateTop = 29
		msoTextEffectShapeDeflateTop = 30
		msoTextEffectShapeDeflateInflate = 31
		msoTextEffectShapeDeflateInflateDeflate = 32
		msoTextEffectShapeFadeRight = 33
		msoTextEffectShapeFadeLeft = 34
		msoTextEffectShapeFadeUp = 35
		msoTextEffectShapeFadeDown = 36
		msoTextEffectShapeSlantUp = 37
		msoTextEffectShapeSlantDown = 38
		msoTextEffectShapeCascadeUp = 39
		msoTextEffectShapeCascadeDown = 40
	End Enum

	Enum MsoTextEffectAlignment
		msoTextEffectAlignmentMixed = -2
		msoTextEffectAlignmentLeft = 1
		msoTextEffectAlignmentCentered = 2
		msoTextEffectAlignmentRight = 3
		msoTextEffectAlignmentLetterJustify = 4
		msoTextEffectAlignmentWordJustify = 5
		msoTextEffectAlignmentStretchJustify = 6
	End Enum

	Enum MsoPresetLightingDirection
		msoPresetLightingDirectionMixed = -2
		msoLightingTopLeft = 1
		msoLightingTop = 2
		msoLightingTopRight = 3
		msoLightingLeft = 4
		msoLightingNone = 5
		msoLightingRight = 6
		msoLightingBottomLeft = 7
		msoLightingBottom = 8
		msoLightingBottomRight = 9
	End Enum

	Enum MsoPresetLightingSoftness
		msoPresetLightingSoftnessMixed = -2
		msoLightingDim = 1
		msoLightingNormal = 2
		msoLightingBright = 3
	End Enum

	Enum MsoPresetMaterial
		msoPresetMaterialMixed = -2
		msoMaterialMatte = 1
		msoMaterialPlastic = 2
		msoMaterialMetal = 3
		msoMaterialWireFrame = 4
		msoMaterialMatte2 = 5
		msoMaterialPlastic2 = 6
		msoMaterialMetal2 = 7
		msoMaterialWarmMatte = 8
		msoMaterialTranslucentPowder = 9
		msoMaterialPowder = 10
		msoMaterialDarkEdge = 11
		msoMaterialSoftEdge = 12
		msoMaterialClear = 13
		msoMaterialFlat = 14
		msoMaterialSoftMetal = 15
	End Enum

	Enum MsoPresetExtrusionDirection
		msoPresetExtrusionDirectionMixed = -2
		msoExtrusionBottomRight = 1
		msoExtrusionBottom = 2
		msoExtrusionBottomLeft = 3
		msoExtrusionRight = 4
		msoExtrusionNone = 5
		msoExtrusionLeft = 6
		msoExtrusionTopRight = 7
		msoExtrusionTop = 8
		msoExtrusionTopLeft = 9
	End Enum

	Enum MsoPresetThreeDFormat
		msoPresetThreeDFormatMixed = -2
		msoThreeD1 = 1
		msoThreeD2 = 2
		msoThreeD3 = 3
		msoThreeD4 = 4
		msoThreeD5 = 5
		msoThreeD6 = 6
		msoThreeD7 = 7
		msoThreeD8 = 8
		msoThreeD9 = 9
		msoThreeD10 = 10
		msoThreeD11 = 11
		msoThreeD12 = 12
		msoThreeD13 = 13
		msoThreeD14 = 14
		msoThreeD15 = 15
		msoThreeD16 = 16
		msoThreeD17 = 17
		msoThreeD18 = 18
		msoThreeD19 = 19
		msoThreeD20 = 20
	End Enum

	Enum MsoExtrusionColorType
		msoExtrusionColorTypeMixed = -2
		msoExtrusionColorAutomatic = 1
		msoExtrusionColorCustom = 2
	End Enum

	Enum MsoAlignCmd
		msoAlignLefts = 0
		msoAlignCenters = 1
		msoAlignRights = 2
		msoAlignTops = 3
		msoAlignMiddles = 4
		msoAlignBottoms = 5
	End Enum

	Enum MsoDistributeCmd
		msoDistributeHorizontally = 0
		msoDistributeVertically = 1
	End Enum

	Enum MsoConnectorType
		msoConnectorTypeMixed = -2
		msoConnectorStraight = 1
		msoConnectorElbow = 2
		msoConnectorCurve = 3
	End Enum

	Enum MsoHorizontalAnchor
		msoHorizontalAnchorMixed = -2
		msoAnchorNone = 1
		msoAnchorCenter = 2
	End Enum

	Enum MsoVerticalAnchor
		msoVerticalAnchorMixed = -2
		msoAnchorTop = 1
		msoAnchorTopBaseline = 2
		msoAnchorMiddle = 3
		msoAnchorBottom = 4
		msoAnchorBottomBaseLine = 5
	End Enum

	Enum MsoOrientation
		msoOrientationMixed = -2
		msoOrientationHorizontal = 1
		msoOrientationVertical = 2
	End Enum

	Enum MsoZOrderCmd
		msoBringToFront = 0
		msoSendToBack = 1
		msoBringForward = 2
		msoSendBackward = 3
		msoBringInFrontOfText = 4
		msoSendBehindText = 5
	End Enum

	Enum MsoSegmentType
		msoSegmentLine = 0
		msoSegmentCurve = 1
	End Enum

	Enum MsoEditingType
		msoEditingAuto = 0
		msoEditingCorner = 1
		msoEditingSmooth = 2
		msoEditingSymmetric = 3
	End Enum

	Enum MsoAutoShapeType
		msoShapeMixed = -2
		msoShapeRectangle = 1
		msoShapeParallelogram = 2
		msoShapeTrapezoid = 3
		msoShapeDiamond = 4
		msoShapeRoundedRectangle = 5
		msoShapeOctagon = 6
		msoShapeIsoscelesTriangle = 7
		msoShapeRightTriangle = 8
		msoShapeOval = 9
		msoShapeHexagon = 10
		msoShapeCross = 11
		msoShapeRegularPentagon = 12
		msoShapeCan = 13
		msoShapeCube = 14
		msoShapeBevel = 15
		msoShapeFoldedCorner = 16
		msoShapeSmileyFace = 17
		msoShapeDonut = 18
		msoShapeNoSymbol = 19
		msoShapeBlockArc = 20
		msoShapeHeart = 21
		msoShapeLightningBolt = 22
		msoShapeSun = 23
		msoShapeMoon = 24
		msoShapeArc = 25
		msoShapeDoubleBracket = 26
		msoShapeDoubleBrace = 27
		msoShapePlaque = 28
		msoShapeLeftBracket = 29
		msoShapeRightBracket = 30
		msoShapeLeftBrace = 31
		msoShapeRightBrace = 32
		msoShapeRightArrow = 33
		msoShapeLeftArrow = 34
		msoShapeUpArrow = 35
		msoShapeDownArrow = 36
		msoShapeLeftRightArrow = 37
		msoShapeUpDownArrow = 38
		msoShapeQuadArrow = 39
		msoShapeLeftRightUpArrow = 40
		msoShapeBentArrow = 41
		msoShapeUTurnArrow = 42
		msoShapeLeftUpArrow = 43
		msoShapeBentUpArrow = 44
		msoShapeCurvedRightArrow = 45
		msoShapeCurvedLeftArrow = 46
		msoShapeCurvedUpArrow = 47
		msoShapeCurvedDownArrow = 48
		msoShapeStripedRightArrow = 49
		msoShapeNotchedRightArrow = 50
		msoShapePentagon = 51
		msoShapeChevron = 52
		msoShapeRightArrowCallout = 53
		msoShapeLeftArrowCallout = 54
		msoShapeUpArrowCallout = 55
		msoShapeDownArrowCallout = 56
		msoShapeLeftRightArrowCallout = 57
		msoShapeUpDownArrowCallout = 58
		msoShapeQuadArrowCallout = 59
		msoShapeCircularArrow = 60
		msoShapeFlowchartProcess = 61
		msoShapeFlowchartAlternateProcess = 62
		msoShapeFlowchartDecision = 63
		msoShapeFlowchartData = 64
		msoShapeFlowchartPredefinedProcess = 65
		msoShapeFlowchartInternalStorage = 66
		msoShapeFlowchartDocument = 67
		msoShapeFlowchartMultidocument = 68
		msoShapeFlowchartTerminator = 69
		msoShapeFlowchartPreparation = 70
		msoShapeFlowchartManualInput = 71
		msoShapeFlowchartManualOperation = 72
		msoShapeFlowchartConnector = 73
		msoShapeFlowchartOffpageConnector = 74
		msoShapeFlowchartCard = 75
		msoShapeFlowchartPunchedTape = 76
		msoShapeFlowchartSummingJunction = 77
		msoShapeFlowchartOr = 78
		msoShapeFlowchartCollate = 79
		msoShapeFlowchartSort = 80
		msoShapeFlowchartExtract = 81
		msoShapeFlowchartMerge = 82
		msoShapeFlowchartStoredData = 83
		msoShapeFlowchartDelay = 84
		msoShapeFlowchartSequentialAccessStorage = 85
		msoShapeFlowchartMagneticDisk = 86
		msoShapeFlowchartDirectAccessStorage = 87
		msoShapeFlowchartDisplay = 88
		msoShapeExplosion1 = 89
		msoShapeExplosion2 = 90
		msoShape4pointStar = 91
		msoShape5pointStar = 92
		msoShape8pointStar = 93
		msoShape16pointStar = 94
		msoShape24pointStar = 95
		msoShape32pointStar = 96
		msoShapeUpRibbon = 97
		msoShapeDownRibbon = 98
		msoShapeCurvedUpRibbon = 99
		msoShapeCurvedDownRibbon = 100
		msoShapeVerticalScroll = 101
		msoShapeHorizontalScroll = 102
		msoShapeWave = 103
		msoShapeDoubleWave = 104
		msoShapeRectangularCallout = 105
		msoShapeRoundedRectangularCallout = 106
		msoShapeOvalCallout = 107
		msoShapeCloudCallout = 108
		msoShapeLineCallout1 = 109
		msoShapeLineCallout2 = 110
		msoShapeLineCallout3 = 111
		msoShapeLineCallout4 = 112
		msoShapeLineCallout1AccentBar = 113
		msoShapeLineCallout2AccentBar = 114
		msoShapeLineCallout3AccentBar = 115
		msoShapeLineCallout4AccentBar = 116
		msoShapeLineCallout1NoBorder = 117
		msoShapeLineCallout2NoBorder = 118
		msoShapeLineCallout3NoBorder = 119
		msoShapeLineCallout4NoBorder = 120
		msoShapeLineCallout1BorderandAccentBar = 121
		msoShapeLineCallout2BorderandAccentBar = 122
		msoShapeLineCallout3BorderandAccentBar = 123
		msoShapeLineCallout4BorderandAccentBar = 124
		msoShapeActionButtonCustom = 125
		msoShapeActionButtonHome = 126
		msoShapeActionButtonHelp = 127
		msoShapeActionButtonInformation = 128
		msoShapeActionButtonBackorPrevious = 129
		msoShapeActionButtonForwardorNext = 130
		msoShapeActionButtonBeginning = 131
		msoShapeActionButtonEnd = 132
		msoShapeActionButtonReturn = 133
		msoShapeActionButtonDocument = 134
		msoShapeActionButtonSound = 135
		msoShapeActionButtonMovie = 136
		msoShapeBalloon = 137
		msoShapeNotPrimitive = 138
		msoShapeFlowchartOfflineStorage = 139
		msoShapeLeftRightRibbon = 140
		msoShapeDiagonalStripe = 141
		msoShapePie = 142
		msoShapeNonIsoscelesTrapezoid = 143
		msoShapeDecagon = 144
		msoShapeHeptagon = 145
		msoShapeDodecagon = 146
		msoShape6pointStar = 147
		msoShape7pointStar = 148
		msoShape10pointStar = 149
		msoShape12pointStar = 150
		msoShapeRound1Rectangle = 151
		msoShapeRound2SameRectangle = 152
		msoShapeRound2DiagRectangle = 153
		msoShapeSnipRoundRectangle = 154
		msoShapeSnip1Rectangle = 155
		msoShapeSnip2SameRectangle = 156
		msoShapeSnip2DiagRectangle = 157
		msoShapeFrame = 158
		msoShapeHalfFrame = 159
		msoShapeTear = 160
		msoShapeChord = 161
		msoShapeCorner = 162
		msoShapeMathPlus = 163
		msoShapeMathMinus = 164
		msoShapeMathMultiply = 165
		msoShapeMathDivide = 166
		msoShapeMathEqual = 167
		msoShapeMathNotEqual = 168
		msoShapeCornerTabs = 169
		msoShapeSquareTabs = 170
		msoShapePlaqueTabs = 171
		msoShapeGear6 = 172
		msoShapeGear9 = 173
		msoShapeFunnel = 174
		msoShapePieWedge = 175
		msoShapeLeftCircularArrow = 176
		msoShapeLeftRightCircularArrow = 177
		msoShapeSwooshArrow = 178
		msoShapeCloud = 179
		msoShapeChartX = 180
		msoShapeChartStar = 181
		msoShapeChartPlus = 182
		msoShapeLineInverse = 183
	End Enum

	Enum MsoShapeType
		msoShapeTypeMixed = -2
		msoAutoShape = 1
		msoCallout = 2
		msoChart = 3
		msoComment = 4
		msoFreeform = 5
		msoGroup = 6
		msoEmbeddedOLEObject = 7
		msoFormControl = 8
		msoLine = 9
		msoLinkedOLEObject = 10
		msoLinkedPicture = 11
		msoOLEControlObject = 12
		msoPicture = 13
		msoPlaceholder = 14
		msoTextEffect = 15
		msoMedia = 16
		msoTextBox = 17
		msoScriptAnchor = 18
		msoTable = 19
		msoCanvas = 20
		msoDiagram = 21
		msoInk = 22
		msoInkComment = 23
		msoSmartArt = 24
		msoSlicer = 25
		msoWebVideo = 26
		msoContentApp = 27
	End Enum

	Enum MsoFlipCmd
		msoFlipHorizontal = 0
		msoFlipVertical = 1
	End Enum

	Enum MsoTriState
		msoTrue = -1
		msoFalse = 0
		msoCTrue = 1
		msoTriStateToggle = -3
		msoTriStateMixed = -2
	End Enum

	Enum MsoColorType
		msoColorTypeMixed = -2
		msoColorTypeRGB = 1
		msoColorTypeScheme = 2
		msoColorTypeCMYK = 3
		msoColorTypeCMS = 4
		msoColorTypeInk = 5
	End Enum

	Enum MsoPictureColorType
		msoPictureMixed = -2
		msoPictureAutomatic = 1
		msoPictureGrayscale = 2
		msoPictureBlackAndWhite = 3
		msoPictureWatermark = 4
	End Enum

	Enum MsoCalloutAngleType
		msoCalloutAngleMixed = -2
		msoCalloutAngleAutomatic = 1
		msoCalloutAngle30 = 2
		msoCalloutAngle45 = 3
		msoCalloutAngle60 = 4
		msoCalloutAngle90 = 5
	End Enum

	Enum MsoCalloutDropType
		msoCalloutDropMixed = -2
		msoCalloutDropCustom = 1
		msoCalloutDropTop = 2
		msoCalloutDropCenter = 3
		msoCalloutDropBottom = 4
	End Enum

	Enum MsoCalloutType
		msoCalloutMixed = -2
		msoCalloutOne = 1
		msoCalloutTwo = 2
		msoCalloutThree = 3
		msoCalloutFour = 4
	End Enum

	Enum MsoBlackWhiteMode
		msoBlackWhiteMixed = -2
		msoBlackWhiteAutomatic = 1
		msoBlackWhiteGrayScale = 2
		msoBlackWhiteLightGrayScale = 3
		msoBlackWhiteInverseGrayScale = 4
		msoBlackWhiteGrayOutline = 5
		msoBlackWhiteBlackTextAndLine = 6
		msoBlackWhiteHighContrast = 7
		msoBlackWhiteBlack = 8
		msoBlackWhiteWhite = 9
		msoBlackWhiteDontShow = 10
	End Enum

	Enum MsoMixedType
		msoIntegerMixed = 32768
		msoSingleMixed = -2147483648
	End Enum

	Enum MsoTextOrientation
		msoTextOrientationMixed = -2
		msoTextOrientationHorizontal = 1
		msoTextOrientationUpward = 2
		msoTextOrientationDownward = 3
		msoTextOrientationVerticalFarEast = 4
		msoTextOrientationVertical = 5
		msoTextOrientationHorizontalRotatedFarEast = 6
	End Enum

	Enum MsoScaleFrom
		msoScaleFromTopLeft = 0
		msoScaleFromMiddle = 1
		msoScaleFromBottomRight = 2
	End Enum

	Enum MsoBarPosition
		msoBarLeft = 0
		msoBarTop = 1
		msoBarRight = 2
		msoBarBottom = 3
		msoBarFloating = 4
		msoBarPopup = 5
		msoBarMenuBar = 6
	End Enum

	Enum MsoBarProtection
		msoBarNoProtection = 0
		msoBarNoCustomize = 1
		msoBarNoResize = 2
		msoBarNoMove = 4
		msoBarNoChangeVisible = 8
		msoBarNoChangeDock = 16
		msoBarNoVerticalDock = 32
		msoBarNoHorizontalDock = 64
	End Enum

	Enum MsoBarType
		msoBarTypeNormal = 0
		msoBarTypeMenuBar = 1
		msoBarTypePopup = 2
	End Enum

	Enum MsoControlType
		msoControlCustom = 0
		msoControlButton = 1
		msoControlEdit = 2
		msoControlDropdown = 3
		msoControlComboBox = 4
		msoControlButtonDropdown = 5
		msoControlSplitDropdown = 6
		msoControlOCXDropdown = 7
		msoControlGenericDropdown = 8
		msoControlGraphicDropdown = 9
		msoControlPopup = 10
		msoControlGraphicPopup = 11
		msoControlButtonPopup = 12
		msoControlSplitButtonPopup = 13
		msoControlSplitButtonMRUPopup = 14
		msoControlLabel = 15
		msoControlExpandingGrid = 16
		msoControlSplitExpandingGrid = 17
		msoControlGrid = 18
		msoControlGauge = 19
		msoControlGraphicCombo = 20
		msoControlPane = 21
		msoControlActiveX = 22
		msoControlSpinner = 23
		msoControlLabelEx = 24
		msoControlWorkPane = 25
		msoControlAutoCompleteCombo = 26
	End Enum

	Enum MsoButtonState
		msoButtonUp = 0
		msoButtonDown = -1
		msoButtonMixed = 2
	End Enum

	Enum MsoControlOLEUsage
		msoControlOLEUsageNeither = 0
		msoControlOLEUsageServer = 1
		msoControlOLEUsageClient = 2
		msoControlOLEUsageBoth = 3
	End Enum

	Enum MsoButtonStyleHidden
		msoButtonWrapText = 4
		msoButtonTextBelow = 8
	End Enum

	Enum MsoButtonStyle
		msoButtonAutomatic = 0
		msoButtonIcon = 1
		msoButtonCaption = 2
		msoButtonIconAndCaption = 3
		msoButtonIconAndWrapCaption = 7
		msoButtonIconAndCaptionBelow = 11
		msoButtonWrapCaption = 14
		msoButtonIconAndWrapCaptionBelow = 15
	End Enum

	Enum MsoComboStyle
		msoComboNormal = 0
		msoComboLabel = 1
	End Enum

	Enum MsoOLEMenuGroup
		msoOLEMenuGroupNone = -1
		msoOLEMenuGroupFile = 0
		msoOLEMenuGroupEdit = 1
		msoOLEMenuGroupContainer = 2
		msoOLEMenuGroupObject = 3
		msoOLEMenuGroupWindow = 4
		msoOLEMenuGroupHelp = 5
	End Enum

	Enum MsoMenuAnimation
		msoMenuAnimationNone = 0
		msoMenuAnimationRandom = 1
		msoMenuAnimationUnfold = 2
		msoMenuAnimationSlide = 3
	End Enum

	Enum MsoBarRow
		msoBarRowFirst = 0
		msoBarRowLast = -1
	End Enum

	Enum MsoCommandBarButtonHyperlinkType
		msoCommandBarButtonHyperlinkNone = 0
		msoCommandBarButtonHyperlinkOpen = 1
		msoCommandBarButtonHyperlinkInsertPicture = 2
	End Enum

	Enum MsoHyperlinkType
		msoHyperlinkRange = 0
		msoHyperlinkShape = 1
		msoHyperlinkInlineShape = 2
	End Enum

	Enum MsoExtraInfoMethod
		msoMethodGet = 0
		msoMethodPost = 1
	End Enum

	Enum MsoAnimationType
		msoAnimationIdle = 1
		msoAnimationGreeting = 2
		msoAnimationGoodbye = 3
		msoAnimationBeginSpeaking = 4
		msoAnimationRestPose = 5
		msoAnimationCharacterSuccessMajor = 6
		msoAnimationGetAttentionMajor = 11
		msoAnimationGetAttentionMinor = 12
		msoAnimationSearching = 13
		msoAnimationPrinting = 18
		msoAnimationGestureRight = 19
		msoAnimationWritingNotingSomething = 22
		msoAnimationWorkingAtSomething = 23
		msoAnimationThinking = 24
		msoAnimationSendingMail = 25
		msoAnimationListensToComputer = 26
		msoAnimationDisappear = 31
		msoAnimationAppear = 32
		msoAnimationGetArtsy = 100
		msoAnimationGetTechy = 101
		msoAnimationGetWizardy = 102
		msoAnimationCheckingSomething = 103
		msoAnimationLookDown = 104
		msoAnimationLookDownLeft = 105
		msoAnimationLookDownRight = 106
		msoAnimationLookLeft = 107
		msoAnimationLookRight = 108
		msoAnimationLookUp = 109
		msoAnimationLookUpLeft = 110
		msoAnimationLookUpRight = 111
		msoAnimationSaving = 112
		msoAnimationGestureDown = 113
		msoAnimationGestureLeft = 114
		msoAnimationGestureUp = 115
		msoAnimationEmptyTrash = 116
	End Enum

	Enum MsoButtonSetType
		msoButtonSetNone = 0
		msoButtonSetOK = 1
		msoButtonSetCancel = 2
		msoButtonSetOkCancel = 3
		msoButtonSetYesNo = 4
		msoButtonSetYesNoCancel = 5
		msoButtonSetBackClose = 6
		msoButtonSetNextClose = 7
		msoButtonSetBackNextClose = 8
		msoButtonSetRetryCancel = 9
		msoButtonSetAbortRetryIgnore = 10
		msoButtonSetSearchClose = 11
		msoButtonSetBackNextSnooze = 12
		msoButtonSetTipsOptionsClose = 13
		msoButtonSetYesAllNoCancel = 14
	End Enum

	Enum MsoIconType
		msoIconNone = 0
		msoIconAlert = 2
		msoIconTip = 3
		msoIconAlertInfo = 4
		msoIconAlertWarning = 5
		msoIconAlertQuery = 6
		msoIconAlertCritical = 7
	End Enum

	Enum MsoBalloonType
		msoBalloonTypeButtons = 0
		msoBalloonTypeBullets = 1
		msoBalloonTypeNumbers = 2
	End Enum

	Enum MsoModeType
		msoModeModal = 0
		msoModeAutoDown = 1
		msoModeModeless = 2
	End Enum

	Enum MsoBalloonErrorType
		msoBalloonErrorNone = 0
		msoBalloonErrorOther = 1
		msoBalloonErrorTooBig = 2
		msoBalloonErrorOutOfMemory = 3
		msoBalloonErrorBadPictureRef = 4
		msoBalloonErrorBadReference = 5
		msoBalloonErrorButtonlessModal = 6
		msoBalloonErrorButtonModeless = 7
		msoBalloonErrorBadCharacter = 8
		msoBalloonErrorCOMFailure = 9
		msoBalloonErrorCharNotTopmostForModal = 10
		msoBalloonErrorTooManyControls = 11
	End Enum

	Enum MsoWizardActType
		msoWizardActInactive = 0
		msoWizardActActive = 1
		msoWizardActSuspend = 2
		msoWizardActResume = 3
	End Enum

	Enum MsoWizardMsgType
		msoWizardMsgLocalStateOn = 1
		msoWizardMsgLocalStateOff = 2
		msoWizardMsgShowHelp = 3
		msoWizardMsgSuspending = 4
		msoWizardMsgResuming = 5
	End Enum

	Enum MsoBalloonButtonType
		msoBalloonButtonYesToAll = -15
		msoBalloonButtonOptions = -14
		msoBalloonButtonTips = -13
		msoBalloonButtonClose = -12
		msoBalloonButtonSnooze = -11
		msoBalloonButtonSearch = -10
		msoBalloonButtonIgnore = -9
		msoBalloonButtonAbort = -8
		msoBalloonButtonRetry = -7
		msoBalloonButtonNext = -6
		msoBalloonButtonBack = -5
		msoBalloonButtonNo = -4
		msoBalloonButtonYes = -3
		msoBalloonButtonCancel = -2
		msoBalloonButtonOK = -1
		msoBalloonButtonNull = 0
	End Enum

	Enum DocProperties
		offPropertyTypeNumber = 1
		offPropertyTypeBoolean = 2
		offPropertyTypeDate = 3
		offPropertyTypeString = 4
		offPropertyTypeFloat = 5
	End Enum

	Enum MsoDocProperties
		msoPropertyTypeNumber = 1
		msoPropertyTypeBoolean = 2
		msoPropertyTypeDate = 3
		msoPropertyTypeString = 4
		msoPropertyTypeFloat = 5
	End Enum

	Enum MsoAppLanguageID
		msoLanguageIDInstall = 1
		msoLanguageIDUI = 2
		msoLanguageIDHelp = 3
		msoLanguageIDExeMode = 4
		msoLanguageIDUIPrevious = 5
	End Enum

	Enum MsoFarEastLineBreakLanguageID
		MsoFarEastLineBreakLanguageJapanese = 1041
		MsoFarEastLineBreakLanguageKorean = 1042
		MsoFarEastLineBreakLanguageSimplifiedChinese = 2052
		MsoFarEastLineBreakLanguageTraditionalChinese = 1028
	End Enum

	Enum MsoFeatureInstall
		msoFeatureInstallNone = 0
		msoFeatureInstallOnDemand = 1
		msoFeatureInstallOnDemandWithUI = 2
	End Enum

	Enum MsoScriptLanguage
		msoScriptLanguageJava = 1
		msoScriptLanguageVisualBasic = 2
		msoScriptLanguageASP = 3
		msoScriptLanguageOther = 4
	End Enum

	Enum MsoScriptLocation
		msoScriptLocationInHead = 1
		msoScriptLocationInBody = 2
	End Enum

	Enum MsoFileFindOptions
		msoOptionsNew = 1
		msoOptionsAdd = 2
		msoOptionsWithin = 3
	End Enum

	Enum MsoFileFindView
		msoViewFileInfo = 1
		msoViewPreview = 2
		msoViewSummaryInfo = 3
	End Enum

	Enum MsoFileFindSortBy
		msoFileFindSortbyAuthor = 1
		msoFileFindSortbyDateCreated = 2
		msoFileFindSortbyLastSavedBy = 3
		msoFileFindSortbyDateSaved = 4
		msoFileFindSortbyFileName = 5
		msoFileFindSortbySize = 6
		msoFileFindSortbyTitle = 7
	End Enum

	Enum MsoFileFindListBy
		msoListbyName = 1
		msoListbyTitle = 2
	End Enum

	Enum MsoLastModified
		msoLastModifiedYesterday = 1
		msoLastModifiedToday = 2
		msoLastModifiedLastWeek = 3
		msoLastModifiedThisWeek = 4
		msoLastModifiedLastMonth = 5
		msoLastModifiedThisMonth = 6
		msoLastModifiedAnyTime = 7
	End Enum

	Enum MsoSortBy
		msoSortByFileName = 1
		msoSortBySize = 2
		msoSortByFileType = 3
		msoSortByLastModified = 4
		msoSortByNone = 5
	End Enum

	Enum MsoSortOrder
		msoSortOrderAscending = 1
		msoSortOrderDescending = 2
	End Enum

	Enum MsoConnector
		msoConnectorAnd = 1
		msoConnectorOr = 2
	End Enum

	Enum MsoCondition
		msoConditionFileTypeAllFiles = 1
		msoConditionFileTypeOfficeFiles = 2
		msoConditionFileTypeWordDocuments = 3
		msoConditionFileTypeExcelWorkbooks = 4
		msoConditionFileTypePowerPointPresentations = 5
		msoConditionFileTypeBinders = 6
		msoConditionFileTypeDatabases = 7
		msoConditionFileTypeTemplates = 8
		msoConditionIncludes = 9
		msoConditionIncludesPhrase = 10
		msoConditionBeginsWith = 11
		msoConditionEndsWith = 12
		msoConditionIncludesNearEachOther = 13
		msoConditionIsExactly = 14
		msoConditionIsNot = 15
		msoConditionYesterday = 16
		msoConditionToday = 17
		msoConditionTomorrow = 18
		msoConditionLastWeek = 19
		msoConditionThisWeek = 20
		msoConditionNextWeek = 21
		msoConditionLastMonth = 22
		msoConditionThisMonth = 23
		msoConditionNextMonth = 24
		msoConditionAnytime = 25
		msoConditionAnytimeBetween = 26
		msoConditionOn = 27
		msoConditionOnOrAfter = 28
		msoConditionOnOrBefore = 29
		msoConditionInTheNext = 30
		msoConditionInTheLast = 31
		msoConditionEquals = 32
		msoConditionDoesNotEqual = 33
		msoConditionAnyNumberBetween = 34
		msoConditionAtMost = 35
		msoConditionAtLeast = 36
		msoConditionMoreThan = 37
		msoConditionLessThan = 38
		msoConditionIsYes = 39
		msoConditionIsNo = 40
		msoConditionIncludesFormsOf = 41
		msoConditionFreeText = 42
		msoConditionFileTypeOutlookItems = 43
		msoConditionFileTypeMailItem = 44
		msoConditionFileTypeCalendarItem = 45
		msoConditionFileTypeContactItem = 46
		msoConditionFileTypeNoteItem = 47
		msoConditionFileTypeJournalItem = 48
		msoConditionFileTypeTaskItem = 49
		msoConditionFileTypePhotoDrawFiles = 50
		msoConditionFileTypeDataConnectionFiles = 51
		msoConditionFileTypePublisherFiles = 52
		msoConditionFileTypeProjectFiles = 53
		msoConditionFileTypeDocumentImagingFiles = 54
		msoConditionFileTypeVisioFiles = 55
		msoConditionFileTypeDesignerFiles = 56
		msoConditionFileTypeWebPages = 57
		msoConditionEqualsLow = 58
		msoConditionEqualsNormal = 59
		msoConditionEqualsHigh = 60
		msoConditionNotEqualToLow = 61
		msoConditionNotEqualToNormal = 62
		msoConditionNotEqualToHigh = 63
		msoConditionEqualsNotStarted = 64
		msoConditionEqualsInProgress = 65
		msoConditionEqualsCompleted = 66
		msoConditionEqualsWaitingForSomeoneElse = 67
		msoConditionEqualsDeferred = 68
		msoConditionNotEqualToNotStarted = 69
		msoConditionNotEqualToInProgress = 70
		msoConditionNotEqualToCompleted = 71
		msoConditionNotEqualToWaitingForSomeoneElse = 72
		msoConditionNotEqualToDeferred = 73
	End Enum

	Enum MsoFileType
		msoFileTypeAllFiles = 1
		msoFileTypeOfficeFiles = 2
		msoFileTypeWordDocuments = 3
		msoFileTypeExcelWorkbooks = 4
		msoFileTypePowerPointPresentations = 5
		msoFileTypeBinders = 6
		msoFileTypeDatabases = 7
		msoFileTypeTemplates = 8
		msoFileTypeOutlookItems = 9
		msoFileTypeMailItem = 10
		msoFileTypeCalendarItem = 11
		msoFileTypeContactItem = 12
		msoFileTypeNoteItem = 13
		msoFileTypeJournalItem = 14
		msoFileTypeTaskItem = 15
		msoFileTypePhotoDrawFiles = 16
		msoFileTypeDataConnectionFiles = 17
		msoFileTypePublisherFiles = 18
		msoFileTypeProjectFiles = 19
		msoFileTypeDocumentImagingFiles = 20
		msoFileTypeVisioFiles = 21
		msoFileTypeDesignerFiles = 22
		msoFileTypeWebPages = 23
	End Enum

	Enum MsoLanguageID
		msoLanguageIDMixed = -2
		msoLanguageIDNone = 0
		msoLanguageIDNoProofing = 1024
		msoLanguageIDAfrikaans = 1078
		msoLanguageIDAlbanian = 1052
		msoLanguageIDAmharic = 1118
		msoLanguageIDArabicAlgeria = 5121
		msoLanguageIDArabicBahrain = 15361
		msoLanguageIDArabicEgypt = 3073
		msoLanguageIDArabicIraq = 2049
		msoLanguageIDArabicJordan = 11265
		msoLanguageIDArabicKuwait = 13313
		msoLanguageIDArabicLebanon = 12289
		msoLanguageIDArabicLibya = 4097
		msoLanguageIDArabicMorocco = 6145
		msoLanguageIDArabicOman = 8193
		msoLanguageIDArabicQatar = 16385
		msoLanguageIDArabic = 1025
		msoLanguageIDArabicSyria = 10241
		msoLanguageIDArabicTunisia = 7169
		msoLanguageIDArabicUAE = 14337
		msoLanguageIDArabicYemen = 9217
		msoLanguageIDArmenian = 1067
		msoLanguageIDAssamese = 1101
		msoLanguageIDAzeriCyrillic = 2092
		msoLanguageIDAzeriLatin = 1068
		msoLanguageIDBasque = 1069
		msoLanguageIDByelorussian = 1059
		msoLanguageIDBengali = 1093
		msoLanguageIDBosnian = 4122
		msoLanguageIDBosnianBosniaHerzegovinaCyrillic = 8218
		msoLanguageIDBosnianBosniaHerzegovinaLatin = 5146
		msoLanguageIDBulgarian = 1026
		msoLanguageIDBurmese = 1109
		msoLanguageIDCatalan = 1027
		msoLanguageIDChineseHongKongSAR = 3076
		msoLanguageIDChineseMacaoSAR = 5124
		msoLanguageIDSimplifiedChinese = 2052
		msoLanguageIDChineseSingapore = 4100
		msoLanguageIDTraditionalChinese = 1028
		msoLanguageIDCherokee = 1116
		msoLanguageIDCroatian = 1050
		msoLanguageIDCzech = 1029
		msoLanguageIDDanish = 1030
		msoLanguageIDDivehi = 1125
		msoLanguageIDBelgianDutch = 2067
		msoLanguageIDDutch = 1043
		msoLanguageIDDzongkhaBhutan = 2129
		msoLanguageIDEdo = 1126
		msoLanguageIDEnglishAUS = 3081
		msoLanguageIDEnglishBelize = 10249
		msoLanguageIDEnglishCanadian = 4105
		msoLanguageIDEnglishCaribbean = 9225
		msoLanguageIDEnglishIndonesia = 14345
		msoLanguageIDEnglishIreland = 6153
		msoLanguageIDEnglishJamaica = 8201
		msoLanguageIDEnglishNewZealand = 5129
		msoLanguageIDEnglishPhilippines = 13321
		msoLanguageIDEnglishSouthAfrica = 7177
		msoLanguageIDEnglishTrinidadTobago = 11273
		msoLanguageIDEnglishUK = 2057
		msoLanguageIDEnglishUS = 1033
		msoLanguageIDEnglishZimbabwe = 12297
		msoLanguageIDEstonian = 1061
		msoLanguageIDFaeroese = 1080
		msoLanguageIDFarsi = 1065
		msoLanguageIDFilipino = 1124
		msoLanguageIDFinnish = 1035
		msoLanguageIDBelgianFrench = 2060
		msoLanguageIDFrenchCameroon = 11276
		msoLanguageIDFrenchCanadian = 3084
		msoLanguageIDFrenchCotedIvoire = 12300
		msoLanguageIDFrench = 1036
		msoLanguageIDFrenchHaiti = 15372
		msoLanguageIDFrenchLuxembourg = 5132
		msoLanguageIDFrenchMali = 13324
		msoLanguageIDFrenchMonaco = 6156
		msoLanguageIDFrenchMorocco = 14348
		msoLanguageIDFrenchReunion = 8204
		msoLanguageIDFrenchSenegal = 10252
		msoLanguageIDSwissFrench = 4108
		msoLanguageIDFrenchWestIndies = 7180
		msoLanguageIDFrenchZaire = 9228
		msoLanguageIDFrenchCongoDRC = 9228
		msoLanguageIDFrisianNetherlands = 1122
		msoLanguageIDFulfulde = 1127
		msoLanguageIDGaelicIreland = 2108
		msoLanguageIDGaelicScotland = 1084
		msoLanguageIDGalician = 1110
		msoLanguageIDGeorgian = 1079
		msoLanguageIDGermanAustria = 3079
		msoLanguageIDGerman = 1031
		msoLanguageIDGermanLiechtenstein = 5127
		msoLanguageIDGermanLuxembourg = 4103
		msoLanguageIDSwissGerman = 2055
		msoLanguageIDGreek = 1032
		msoLanguageIDGuarani = 1140
		msoLanguageIDGujarati = 1095
		msoLanguageIDHausa = 1128
		msoLanguageIDHawaiian = 1141
		msoLanguageIDHebrew = 1037
		msoLanguageIDHindi = 1081
		msoLanguageIDHungarian = 1038
		msoLanguageIDIbibio = 1129
		msoLanguageIDIcelandic = 1039
		msoLanguageIDIgbo = 1136
		msoLanguageIDIndonesian = 1057
		msoLanguageIDInuktitut = 1117
		msoLanguageIDItalian = 1040
		msoLanguageIDSwissItalian = 2064
		msoLanguageIDJapanese = 1041
		msoLanguageIDKannada = 1099
		msoLanguageIDKanuri = 1137
		msoLanguageIDKashmiri = 1120
		msoLanguageIDKashmiriDevanagari = 2144
		msoLanguageIDKazakh = 1087
		msoLanguageIDKhmer = 1107
		msoLanguageIDKirghiz = 1088
		msoLanguageIDKonkani = 1111
		msoLanguageIDKorean = 1042
		msoLanguageIDKyrgyz = 1088
		msoLanguageIDLatin = 1142
		msoLanguageIDLao = 1108
		msoLanguageIDLatvian = 1062
		msoLanguageIDLithuanian = 1063
		msoLanguageIDMacedonian = 1071
		msoLanguageIDMacedonianFYROM = 1071
		msoLanguageIDMalaysian = 1086
		msoLanguageIDMalayBruneiDarussalam = 2110
		msoLanguageIDMalayalam = 1100
		msoLanguageIDMaltese = 1082
		msoLanguageIDManipuri = 1112
		msoLanguageIDMaori = 1153
		msoLanguageIDMarathi = 1102
		msoLanguageIDMongolian = 1104
		msoLanguageIDNepali = 1121
		msoLanguageIDNorwegianBokmol = 1044
		msoLanguageIDNorwegianNynorsk = 2068
		msoLanguageIDOriya = 1096
		msoLanguageIDOromo = 1138
		msoLanguageIDPashto = 1123
		msoLanguageIDPolish = 1045
		msoLanguageIDBrazilianPortuguese = 1046
		msoLanguageIDPortuguese = 2070
		msoLanguageIDPunjabi = 1094
		msoLanguageIDQuechuaBolivia = 1131
		msoLanguageIDQuechuaEcuador = 2155
		msoLanguageIDQuechuaPeru = 3179
		msoLanguageIDRhaetoRomanic = 1047
		msoLanguageIDRomanianMoldova = 2072
		msoLanguageIDRomanian = 1048
		msoLanguageIDRussianMoldova = 2073
		msoLanguageIDRussian = 1049
		msoLanguageIDSamiLappish = 1083
		msoLanguageIDSanskrit = 1103
		msoLanguageIDSepedi = 1132
		msoLanguageIDSerbianBosniaHerzegovinaCyrillic = 7194
		msoLanguageIDSerbianBosniaHerzegovinaLatin = 6170
		msoLanguageIDSerbianCyrillic = 3098
		msoLanguageIDSerbianLatin = 2074
		msoLanguageIDSesotho = 1072
		msoLanguageIDSindhi = 1113
		msoLanguageIDSindhiPakistan = 2137
		msoLanguageIDSinhalese = 1115
		msoLanguageIDSlovak = 1051
		msoLanguageIDSlovenian = 1060
		msoLanguageIDSomali = 1143
		msoLanguageIDSorbian = 1070
		msoLanguageIDSpanishArgentina = 11274
		msoLanguageIDSpanishBolivia = 16394
		msoLanguageIDSpanishChile = 13322
		msoLanguageIDSpanishColombia = 9226
		msoLanguageIDSpanishCostaRica = 5130
		msoLanguageIDSpanishDominicanRepublic = 7178
		msoLanguageIDSpanishEcuador = 12298
		msoLanguageIDSpanishElSalvador = 17418
		msoLanguageIDSpanishGuatemala = 4106
		msoLanguageIDSpanishHonduras = 18442
		msoLanguageIDMexicanSpanish = 2058
		msoLanguageIDSpanishNicaragua = 19466
		msoLanguageIDSpanishPanama = 6154
		msoLanguageIDSpanishParaguay = 15370
		msoLanguageIDSpanishPeru = 10250
		msoLanguageIDSpanishPuertoRico = 20490
		msoLanguageIDSpanishModernSort = 3082
		msoLanguageIDSpanish = 1034
		msoLanguageIDSpanishUruguay = 14346
		msoLanguageIDSpanishVenezuela = 8202
		msoLanguageIDSutu = 1072
		msoLanguageIDSwahili = 1089
		msoLanguageIDSwedishFinland = 2077
		msoLanguageIDSwedish = 1053
		msoLanguageIDSyriac = 1114
		msoLanguageIDTajik = 1064
		msoLanguageIDTamil = 1097
		msoLanguageIDTamazight = 1119
		msoLanguageIDTamazightLatin = 2143
		msoLanguageIDTatar = 1092
		msoLanguageIDTelugu = 1098
		msoLanguageIDThai = 1054
		msoLanguageIDTibetan = 1105
		msoLanguageIDTigrignaEthiopic = 1139
		msoLanguageIDTigrignaEritrea = 2163
		msoLanguageIDTsonga = 1073
		msoLanguageIDTswana = 1074
		msoLanguageIDTurkish = 1055
		msoLanguageIDTurkmen = 1090
		msoLanguageIDUkrainian = 1058
		msoLanguageIDUrdu = 1056
		msoLanguageIDUzbekCyrillic = 2115
		msoLanguageIDUzbekLatin = 1091
		msoLanguageIDVenda = 1075
		msoLanguageIDVietnamese = 1066
		msoLanguageIDWelsh = 1106
		msoLanguageIDXhosa = 1076
		msoLanguageIDYi = 1144
		msoLanguageIDYiddish = 1085
		msoLanguageIDYoruba = 1130
		msoLanguageIDZulu = 1077
	End Enum

	Enum MsoScreenSize
		msoScreenSize544x376 = 0
		msoScreenSize640x480 = 1
		msoScreenSize720x512 = 2
		msoScreenSize800x600 = 3
		msoScreenSize1024x768 = 4
		msoScreenSize1152x882 = 5
		msoScreenSize1152x900 = 6
		msoScreenSize1280x1024 = 7
		msoScreenSize1600x1200 = 8
		msoScreenSize1800x1440 = 9
		msoScreenSize1920x1200 = 10
	End Enum

	Enum MsoCharacterSet
		msoCharacterSetArabic = 1
		msoCharacterSetCyrillic = 2
		msoCharacterSetEnglishWesternEuropeanOtherLatinScript = 3
		msoCharacterSetGreek = 4
		msoCharacterSetHebrew = 5
		msoCharacterSetJapanese = 6
		msoCharacterSetKorean = 7
		msoCharacterSetMultilingualUnicode = 8
		msoCharacterSetSimplifiedChinese = 9
		msoCharacterSetThai = 10
		msoCharacterSetTraditionalChinese = 11
		msoCharacterSetVietnamese = 12
	End Enum

	Enum MsoEncoding
		msoEncodingThai = 874
		msoEncodingJapaneseShiftJIS = 932
		msoEncodingSimplifiedChineseGBK = 936
		msoEncodingKorean = 949
		msoEncodingTraditionalChineseBig5 = 950
		msoEncodingUnicodeLittleEndian = 1200
		msoEncodingUnicodeBigEndian = 1201
		msoEncodingCentralEuropean = 1250
		msoEncodingCyrillic = 1251
		msoEncodingWestern = 1252
		msoEncodingGreek = 1253
		msoEncodingTurkish = 1254
		msoEncodingHebrew = 1255
		msoEncodingArabic = 1256
		msoEncodingBaltic = 1257
		msoEncodingVietnamese = 1258
		msoEncodingAutoDetect = 50001
		msoEncodingJapaneseAutoDetect = 50932
		msoEncodingSimplifiedChineseAutoDetect = 50936
		msoEncodingKoreanAutoDetect = 50949
		msoEncodingTraditionalChineseAutoDetect = 50950
		msoEncodingCyrillicAutoDetect = 51251
		msoEncodingGreekAutoDetect = 51253
		msoEncodingArabicAutoDetect = 51256
		msoEncodingISO88591Latin1 = 28591
		msoEncodingISO88592CentralEurope = 28592
		msoEncodingISO88593Latin3 = 28593
		msoEncodingISO88594Baltic = 28594
		msoEncodingISO88595Cyrillic = 28595
		msoEncodingISO88596Arabic = 28596
		msoEncodingISO88597Greek = 28597
		msoEncodingISO88598Hebrew = 28598
		msoEncodingISO88599Turkish = 28599
		msoEncodingISO885915Latin9 = 28605
		msoEncodingISO88598HebrewLogical = 38598
		msoEncodingISO2022JPNoHalfwidthKatakana = 50220
		msoEncodingISO2022JPJISX02021984 = 50221
		msoEncodingISO2022JPJISX02011989 = 50222
		msoEncodingISO2022KR = 50225
		msoEncodingISO2022CNTraditionalChinese = 50227
		msoEncodingISO2022CNSimplifiedChinese = 50229
		msoEncodingMacRoman = 10000
		msoEncodingMacJapanese = 10001
		msoEncodingMacTraditionalChineseBig5 = 10002
		msoEncodingMacKorean = 10003
		msoEncodingMacArabic = 10004
		msoEncodingMacHebrew = 10005
		msoEncodingMacGreek1 = 10006
		msoEncodingMacCyrillic = 10007
		msoEncodingMacSimplifiedChineseGB2312 = 10008
		msoEncodingMacRomania = 10010
		msoEncodingMacUkraine = 10017
		msoEncodingMacLatin2 = 10029
		msoEncodingMacIcelandic = 10079
		msoEncodingMacTurkish = 10081
		msoEncodingMacCroatia = 10082
		msoEncodingEBCDICUSCanada = 37
		msoEncodingEBCDICInternational = 500
		msoEncodingEBCDICMultilingualROECELatin2 = 870
		msoEncodingEBCDICGreekModern = 875
		msoEncodingEBCDICTurkishLatin5 = 1026
		msoEncodingEBCDICGermany = 20273
		msoEncodingEBCDICDenmarkNorway = 20277
		msoEncodingEBCDICFinlandSweden = 20278
		msoEncodingEBCDICItaly = 20280
		msoEncodingEBCDICLatinAmericaSpain = 20284
		msoEncodingEBCDICUnitedKingdom = 20285
		msoEncodingEBCDICJapaneseKatakanaExtended = 20290
		msoEncodingEBCDICFrance = 20297
		msoEncodingEBCDICArabic = 20420
		msoEncodingEBCDICGreek = 20423
		msoEncodingEBCDICHebrew = 20424
		msoEncodingEBCDICKoreanExtended = 20833
		msoEncodingEBCDICThai = 20838
		msoEncodingEBCDICIcelandic = 20871
		msoEncodingEBCDICTurkish = 20905
		msoEncodingEBCDICRussian = 20880
		msoEncodingEBCDICSerbianBulgarian = 21025
		msoEncodingEBCDICJapaneseKatakanaExtendedAndJapanese = 50930
		msoEncodingEBCDICUSCanadaAndJapanese = 50931
		msoEncodingEBCDICKoreanExtendedAndKorean = 50933
		msoEncodingEBCDICSimplifiedChineseExtendedAndSimplifiedChinese = 50935
		msoEncodingEBCDICUSCanadaAndTraditionalChinese = 50937
		msoEncodingEBCDICJapaneseLatinExtendedAndJapanese = 50939
		msoEncodingOEMUnitedStates = 437
		msoEncodingOEMGreek437G = 737
		msoEncodingOEMBaltic = 775
		msoEncodingOEMMultilingualLatinI = 850
		msoEncodingOEMMultilingualLatinII = 852
		msoEncodingOEMCyrillic = 855
		msoEncodingOEMTurkish = 857
		msoEncodingOEMPortuguese = 860
		msoEncodingOEMIcelandic = 861
		msoEncodingOEMHebrew = 862
		msoEncodingOEMCanadianFrench = 863
		msoEncodingOEMArabic = 864
		msoEncodingOEMNordic = 865
		msoEncodingOEMCyrillicII = 866
		msoEncodingOEMModernGreek = 869
		msoEncodingEUCJapanese = 51932
		msoEncodingEUCChineseSimplifiedChinese = 51936
		msoEncodingEUCKorean = 51949
		msoEncodingEUCTaiwaneseTraditionalChinese = 51950
		msoEncodingISCIIDevanagari = 57002
		msoEncodingISCIIBengali = 57003
		msoEncodingISCIITamil = 57004
		msoEncodingISCIITelugu = 57005
		msoEncodingISCIIAssamese = 57006
		msoEncodingISCIIOriya = 57007
		msoEncodingISCIIKannada = 57008
		msoEncodingISCIIMalayalam = 57009
		msoEncodingISCIIGujarati = 57010
		msoEncodingISCIIPunjabi = 57011
		msoEncodingArabicASMO = 708
		msoEncodingArabicTransparentASMO = 720
		msoEncodingKoreanJohab = 1361
		msoEncodingTaiwanCNS = 20000
		msoEncodingTaiwanTCA = 20001
		msoEncodingTaiwanEten = 20002
		msoEncodingTaiwanIBM5550 = 20003
		msoEncodingTaiwanTeleText = 20004
		msoEncodingTaiwanWang = 20005
		msoEncodingIA5IRV = 20105
		msoEncodingIA5German = 20106
		msoEncodingIA5Swedish = 20107
		msoEncodingIA5Norwegian = 20108
		msoEncodingUSASCII = 20127
		msoEncodingT61 = 20261
		msoEncodingISO6937NonSpacingAccent = 20269
		msoEncodingKOI8R = 20866
		msoEncodingExtAlphaLowercase = 21027
		msoEncodingKOI8U = 21866
		msoEncodingEuropa3 = 29001
		msoEncodingHZGBSimplifiedChinese = 52936
		msoEncodingSimplifiedChineseGB18030 = 54936
		msoEncodingUTF7 = 65000
		msoEncodingUTF8 = 65001
	End Enum

	Enum MsoHTMLProjectOpen
		msoHTMLProjectOpenSourceView = 1
		msoHTMLProjectOpenTextView = 2
	End Enum

	Enum MsoHTMLProjectState
		msoHTMLProjectStateDocumentLocked = 1
		msoHTMLProjectStateProjectLocked = 2
		msoHTMLProjectStateDocumentProjectUnlocked = 3
	End Enum

	Enum MsoFileDialogType
		msoFileDialogOpen = 1
		msoFileDialogSaveAs = 2
		msoFileDialogFilePicker = 3
		msoFileDialogFolderPicker = 4
	End Enum

	Enum MsoFileDialogView
		msoFileDialogViewList = 1
		msoFileDialogViewDetails = 2
		msoFileDialogViewProperties = 3
		msoFileDialogViewPreview = 4
		msoFileDialogViewThumbnail = 5
		msoFileDialogViewLargeIcons = 6
		msoFileDialogViewSmallIcons = 7
		msoFileDialogViewWebView = 8
		msoFileDialogViewTiles = 9
	End Enum

	Enum MsoAutomationSecurity
		msoAutomationSecurityLow = 1
		msoAutomationSecurityByUI = 2
		msoAutomationSecurityForceDisable = 3
	End Enum

	Enum MailFormat
		mfPlainText = 1
		mfHTML = 2
		mfRTF = 3
	End Enum

	Enum MsoAlertButtonType
		msoAlertButtonOK = 0
		msoAlertButtonOKCancel = 1
		msoAlertButtonAbortRetryIgnore = 2
		msoAlertButtonYesNoCancel = 3
		msoAlertButtonYesNo = 4
		msoAlertButtonRetryCancel = 5
		msoAlertButtonYesAllNoCancel = 6
	End Enum

	Enum MsoAlertIconType
		msoAlertIconNoIcon = 0
		msoAlertIconCritical = 1
		msoAlertIconQuery = 2
		msoAlertIconWarning = 3
		msoAlertIconInfo = 4
	End Enum

	Enum MsoAlertDefaultType
		msoAlertDefaultFirst = 0
		msoAlertDefaultSecond = 1
		msoAlertDefaultThird = 2
		msoAlertDefaultFourth = 3
		msoAlertDefaultFifth = 4
	End Enum

	Enum MsoAlertCancelType
		msoAlertCancelDefault = -1
		msoAlertCancelFirst = 0
		msoAlertCancelSecond = 1
		msoAlertCancelThird = 2
		msoAlertCancelFourth = 3
		msoAlertCancelFifth = 4
	End Enum

	Enum MsoSearchIn
		msoSearchInMyComputer = 0
		msoSearchInOutlook = 1
		msoSearchInMyNetworkPlaces = 2
		msoSearchInCustom = 3
	End Enum

	Enum MsoTargetBrowser
		msoTargetBrowserV3 = 0
		msoTargetBrowserV4 = 1
		msoTargetBrowserIE4 = 2
		msoTargetBrowserIE5 = 3
		msoTargetBrowserIE6 = 4
	End Enum

	Enum MsoOrgChartOrientation
		msoOrgChartOrientationMixed = -2
		msoOrgChartOrientationVertical = 1
	End Enum

	Enum MsoOrgChartLayoutType
		msoOrgChartLayoutMixed = -2
		msoOrgChartLayoutStandard = 1
		msoOrgChartLayoutBothHanging = 2
		msoOrgChartLayoutLeftHanging = 3
		msoOrgChartLayoutRightHanging = 4
		msoOrgChartLayoutDefault = 5
	End Enum

	Enum MsoRelativeNodePosition
		msoBeforeNode = 1
		msoAfterNode = 2
		msoBeforeFirstSibling = 3
		msoAfterLastSibling = 4
	End Enum

	Enum MsoDiagramType
		msoDiagramMixed = -2
		msoDiagramOrgChart = 1
		msoDiagramCycle = 2
		msoDiagramRadial = 3
		msoDiagramPyramid = 4
		msoDiagramVenn = 5
		msoDiagramTarget = 6
	End Enum

	Enum MsoDiagramNodeType
		msoDiagramNode = 1
		msoDiagramAssistant = 2
	End Enum

	Enum MsoMoveRow
		msoMoveRowFirst = -4
		msoMoveRowPrev = -3
		msoMoveRowNext = -2
		msoMoveRowNbr = -1
	End Enum

	Enum MsoFilterComparison
		msoFilterComparisonEqual = 0
		msoFilterComparisonNotEqual = 1
		msoFilterComparisonLessThan = 2
		msoFilterComparisonGreaterThan = 3
		msoFilterComparisonLessThanEqual = 4
		msoFilterComparisonGreaterThanEqual = 5
		msoFilterComparisonIsBlank = 6
		msoFilterComparisonIsNotBlank = 7
		msoFilterComparisonContains = 8
		msoFilterComparisonNotContains = 9
	End Enum

	Enum MsoFilterConjunction
		msoFilterConjunctionAnd = 0
		msoFilterConjunctionOr = 1
	End Enum

	Enum MsoFileNewSection
		msoOpenDocument = 0
		msoNew = 1
		msoNewfromExistingFile = 2
		msoNewfromTemplate = 3
		msoBottomSection = 4
	End Enum

	Enum MsoFileNewAction
		msoEditFile = 0
		msoCreateNewFile = 1
		msoOpenFile = 2
	End Enum

	Enum MsoLanguageIDHidden
		msoLanguageIDChineseHongKong = 3076
		msoLanguageIDChineseMacao = 5124
		msoLanguageIDEnglishTrinidad = 11273
	End Enum

	Enum MsoSharedWorkspaceTaskStatus
		msoSharedWorkspaceTaskStatusNotStarted = 1
		msoSharedWorkspaceTaskStatusInProgress = 2
		msoSharedWorkspaceTaskStatusCompleted = 3
		msoSharedWorkspaceTaskStatusDeferred = 4
		msoSharedWorkspaceTaskStatusWaiting = 5
	End Enum

	Enum MsoSharedWorkspaceTaskPriority
		msoSharedWorkspaceTaskPriorityHigh = 1
		msoSharedWorkspaceTaskPriorityNormal = 2
		msoSharedWorkspaceTaskPriorityLow = 3
	End Enum

	Enum MsoSyncVersionType
		msoSyncVersionLastViewed = 0
		msoSyncVersionServer = 1
	End Enum

	Enum MsoSyncConflictResolutionType
		msoSyncConflictClientWins = 0
		msoSyncConflictServerWins = 1
		msoSyncConflictMerge = 2
	End Enum

	Enum MsoSyncCompareType
		msoSyncCompareAndMerge = 0
		msoSyncCompareSideBySide = 1
	End Enum

	Enum MsoSyncAvailableType
		msoSyncAvailableNone = 0
		msoSyncAvailableOffline = 1
		msoSyncAvailableAnywhere = 2
	End Enum

	Enum MsoSyncEventType
		msoSyncEventDownloadInitiated = 0
		msoSyncEventDownloadSucceeded = 1
		msoSyncEventDownloadFailed = 2
		msoSyncEventUploadInitiated = 3
		msoSyncEventUploadSucceeded = 4
		msoSyncEventUploadFailed = 5
		msoSyncEventDownloadNoChange = 6
		msoSyncEventOffline = 7
	End Enum

	Enum MsoSyncErrorType
		msoSyncErrorNone = 0
		msoSyncErrorUnauthorizedUser = 1
		msoSyncErrorCouldNotConnect = 2
		msoSyncErrorOutOfSpace = 3
		msoSyncErrorFileNotFound = 4
		msoSyncErrorFileTooLarge = 5
		msoSyncErrorFileInUse = 6
		msoSyncErrorVirusUpload = 7
		msoSyncErrorVirusDownload = 8
		msoSyncErrorUnknownUpload = 9
		msoSyncErrorUnknownDownload = 10
		msoSyncErrorCouldNotOpen = 11
		msoSyncErrorCouldNotUpdate = 12
		msoSyncErrorCouldNotCompare = 13
		msoSyncErrorCouldNotResolve = 14
		msoSyncErrorNoNetwork = 15
		msoSyncErrorUnknown = 16
	End Enum

	Enum MsoSyncStatusType
		msoSyncStatusNoSharedWorkspace = 0
		msoSyncStatusNotRoaming = 0
		msoSyncStatusLatest = 1
		msoSyncStatusNewerAvailable = 2
		msoSyncStatusLocalChanges = 3
		msoSyncStatusConflict = 4
		msoSyncStatusSuspended = 5
		msoSyncStatusError = 6
	End Enum

	Enum MsoPermission
		msoPermissionView = 1
		msoPermissionRead = 1
		msoPermissionEdit = 2
		msoPermissionSave = 4
		msoPermissionExtract = 8
		msoPermissionChange = 15
		msoPermissionPrint = 16
		msoPermissionObjModel = 32
		msoPermissionFullControl = 64
		msoPermissionAllCommon = 127
	End Enum

	Enum MsoMetaPropertyType
		msoMetaPropertyTypeUnknown = 0
		msoMetaPropertyTypeBoolean = 1
		msoMetaPropertyTypeChoice = 2
		msoMetaPropertyTypeCalculated = 3
		msoMetaPropertyTypeComputed = 4
		msoMetaPropertyTypeCurrency = 5
		msoMetaPropertyTypeDateTime = 6
		msoMetaPropertyTypeFillInChoice = 7
		msoMetaPropertyTypeGuid = 8
		msoMetaPropertyTypeInteger = 9
		msoMetaPropertyTypeLookup = 10
		msoMetaPropertyTypeMultiChoiceLookup = 11
		msoMetaPropertyTypeMultiChoice = 12
		msoMetaPropertyTypeMultiChoiceFillIn = 13
		msoMetaPropertyTypeNote = 14
		msoMetaPropertyTypeNumber = 15
		msoMetaPropertyTypeText = 16
		msoMetaPropertyTypeUrl = 17
		msoMetaPropertyTypeUser = 18
		msoMetaPropertyTypeUserMulti = 19
		msoMetaPropertyTypeBusinessData = 20
		msoMetaPropertyTypeBusinessDataSecondary = 21
		msoMetaPropertyTypeMax = 22
	End Enum

	Enum MsoSignatureSubset
		msoSignatureSubsetSignaturesAllSigs = 0
		msoSignatureSubsetSignaturesNonVisible = 1
		msoSignatureSubsetSignatureLines = 2
		msoSignatureSubsetSignatureLinesSigned = 3
		msoSignatureSubsetSignatureLinesUnsigned = 4
		msoSignatureSubsetAll = 5
	End Enum

	Enum MsoDocInspectorStatus
		msoDocInspectorStatusDocOk = 0
		msoDocInspectorStatusIssueFound = 1
		msoDocInspectorStatusError = 2
	End Enum

	Enum SignatureDetail
		sigdetLocalSigningTime = 0
		sigdetApplicationName = 1
		sigdetApplicationVersion = 2
		sigdetOfficeVersion = 3
		sigdetWindowsVersion = 4
		sigdetNumberOfMonitors = 5
		sigdetHorizResolution = 6
		sigdetVertResolution = 7
		sigdetColorDepth = 8
		sigdetSignedData = 9
		sigdetDocPreviewImg = 10
		sigdetIPFormHash = 11
		sigdetIPCurrentView = 12
		sigdetSignatureType = 13
		sigdetHashAlgorithm = 14
		sigdetShouldShowViewWarning = 15
		sigdetDelSuggSigner = 16
		sigdetDelSuggSignerSet = 17
		sigdetDelSuggSignerLine2 = 18
		sigdetDelSuggSignerLine2Set = 19
		sigdetDelSuggSignerEmail = 20
		sigdetDelSuggSignerEmailSet = 21
	End Enum

	Enum CertificateDetail
		certdetAvailable = 0
		certdetSubject = 1
		certdetIssuer = 2
		certdetExpirationDate = 3
		certdetThumbprint = 4
	End Enum

	Enum ContentVerificationResults
		contverresError = 0
		contverresVerifying = 1
		contverresUnverified = 2
		contverresValid = 3
		contverresModified = 4
	End Enum

	Enum CertificateVerificationResults
		certverresError = 0
		certverresVerifying = 1
		certverresUnverified = 2
		certverresValid = 3
		certverresInvalid = 4
		certverresExpired = 5
		certverresRevoked = 6
		certverresUntrusted = 7
	End Enum

	Enum SignatureLineImage
		siglnimgSoftwareRequired = 0
		siglnimgUnsigned = 1
		siglnimgSignedValid = 2
		siglnimgSignedInvalid = 3
		siglnimgSigned = 4
	End Enum

	Enum SignatureProviderDetail
		sigprovdetUrl = 0
		sigprovdetHashAlgorithm = 1
		sigprovdetUIOnly = 2
		sigprovdetUseOfficeUI = 3
		sigprovdetUseOfficeStampUI = 4
	End Enum

	Enum SignatureType
		sigtypeUnknown = 0
		sigtypeNonVisible = 1
		sigtypeSignatureLine = 2
		sigtypeMax = 3
	End Enum

	Enum MsoCustomXMLNodeType
		msoCustomXMLNodeElement = 1
		msoCustomXMLNodeAttribute = 2
		msoCustomXMLNodeText = 3
		msoCustomXMLNodeCData = 4
		msoCustomXMLNodeProcessingInstruction = 7
		msoCustomXMLNodeComment = 8
		msoCustomXMLNodeDocument = 9
	End Enum

	Enum MsoCustomXMLValidationErrorType
		msoCustomXMLValidationErrorSchemaGenerated = 0
		msoCustomXMLValidationErrorAutomaticallyCleared = 1
		msoCustomXMLValidationErrorManual = 2
	End Enum

	Enum MsoTextureAlignment
		msoTextureAlignmentMixed = -2
		msoTextureTopLeft = 0
		msoTextureTop = 1
		msoTextureTopRight = 2
		msoTextureLeft = 3
		msoTextureCenter = 4
		msoTextureRight = 5
		msoTextureBottomLeft = 6
		msoTextureBottom = 7
		msoTextureBottomRight = 8
	End Enum

	Enum MsoSoftEdgeType
		msoSoftEdgeTypeMixed = -2
		msoSoftEdgeTypeNone = 0
		msoSoftEdgeType1 = 1
		msoSoftEdgeType2 = 2
		msoSoftEdgeType3 = 3
		msoSoftEdgeType4 = 4
		msoSoftEdgeType5 = 5
		msoSoftEdgeType6 = 6
	End Enum

	Enum MsoReflectionType
		msoReflectionTypeMixed = -2
		msoReflectionTypeNone = 0
		msoReflectionType1 = 1
		msoReflectionType2 = 2
		msoReflectionType3 = 3
		msoReflectionType4 = 4
		msoReflectionType5 = 5
		msoReflectionType6 = 6
		msoReflectionType7 = 7
		msoReflectionType8 = 8
		msoReflectionType9 = 9
	End Enum

	Enum MsoPresetCamera
		msoPresetCameraMixed = -2
		msoCameraLegacyObliqueTopLeft = 1
		msoCameraLegacyObliqueTop = 2
		msoCameraLegacyObliqueTopRight = 3
		msoCameraLegacyObliqueLeft = 4
		msoCameraLegacyObliqueFront = 5
		msoCameraLegacyObliqueRight = 6
		msoCameraLegacyObliqueBottomLeft = 7
		msoCameraLegacyObliqueBottom = 8
		msoCameraLegacyObliqueBottomRight = 9
		msoCameraLegacyPerspectiveTopLeft = 10
		msoCameraLegacyPerspectiveTop = 11
		msoCameraLegacyPerspectiveTopRight = 12
		msoCameraLegacyPerspectiveLeft = 13
		msoCameraLegacyPerspectiveFront = 14
		msoCameraLegacyPerspectiveRight = 15
		msoCameraLegacyPerspectiveBottomLeft = 16
		msoCameraLegacyPerspectiveBottom = 17
		msoCameraLegacyPerspectiveBottomRight = 18
		msoCameraOrthographicFront = 19
		msoCameraIsometricTopUp = 20
		msoCameraIsometricTopDown = 21
		msoCameraIsometricBottomUp = 22
		msoCameraIsometricBottomDown = 23
		msoCameraIsometricLeftUp = 24
		msoCameraIsometricLeftDown = 25
		msoCameraIsometricRightUp = 26
		msoCameraIsometricRightDown = 27
		msoCameraIsometricOffAxis1Left = 28
		msoCameraIsometricOffAxis1Right = 29
		msoCameraIsometricOffAxis1Top = 30
		msoCameraIsometricOffAxis2Left = 31
		msoCameraIsometricOffAxis2Right = 32
		msoCameraIsometricOffAxis2Top = 33
		msoCameraIsometricOffAxis3Left = 34
		msoCameraIsometricOffAxis3Right = 35
		msoCameraIsometricOffAxis3Bottom = 36
		msoCameraIsometricOffAxis4Left = 37
		msoCameraIsometricOffAxis4Right = 38
		msoCameraIsometricOffAxis4Bottom = 39
		msoCameraObliqueTopLeft = 40
		msoCameraObliqueTop = 41
		msoCameraObliqueTopRight = 42
		msoCameraObliqueLeft = 43
		msoCameraObliqueRight = 44
		msoCameraObliqueBottomLeft = 45
		msoCameraObliqueBottom = 46
		msoCameraObliqueBottomRight = 47
		msoCameraPerspectiveFront = 48
		msoCameraPerspectiveLeft = 49
		msoCameraPerspectiveRight = 50
		msoCameraPerspectiveAbove = 51
		msoCameraPerspectiveBelow = 52
		msoCameraPerspectiveAboveLeftFacing = 53
		msoCameraPerspectiveAboveRightFacing = 54
		msoCameraPerspectiveContrastingLeftFacing = 55
		msoCameraPerspectiveContrastingRightFacing = 56
		msoCameraPerspectiveHeroicLeftFacing = 57
		msoCameraPerspectiveHeroicRightFacing = 58
		msoCameraPerspectiveHeroicExtremeLeftFacing = 59
		msoCameraPerspectiveHeroicExtremeRightFacing = 60
		msoCameraPerspectiveRelaxed = 61
		msoCameraPerspectiveRelaxedModerately = 62
	End Enum

	Enum MsoBevelType
		msoBevelTypeMixed = -2
		msoBevelNone = 1
		msoBevelRelaxedInset = 2
		msoBevelCircle = 3
		msoBevelSlope = 4
		msoBevelCross = 5
		msoBevelAngle = 6
		msoBevelSoftRound = 7
		msoBevelConvex = 8
		msoBevelCoolSlant = 9
		msoBevelDivot = 10
		msoBevelRiblet = 11
		msoBevelHardEdge = 12
		msoBevelArtDeco = 13
	End Enum

	Enum MsoLightRigType
		msoLightRigMixed = -2
		msoLightRigLegacyFlat1 = 1
		msoLightRigLegacyFlat2 = 2
		msoLightRigLegacyFlat3 = 3
		msoLightRigLegacyFlat4 = 4
		msoLightRigLegacyNormal1 = 5
		msoLightRigLegacyNormal2 = 6
		msoLightRigLegacyNormal3 = 7
		msoLightRigLegacyNormal4 = 8
		msoLightRigLegacyHarsh1 = 9
		msoLightRigLegacyHarsh2 = 10
		msoLightRigLegacyHarsh3 = 11
		msoLightRigLegacyHarsh4 = 12
		msoLightRigThreePoint = 13
		msoLightRigBalanced = 14
		msoLightRigSoft = 15
		msoLightRigHarsh = 16
		msoLightRigFlood = 17
		msoLightRigContrasting = 18
		msoLightRigMorning = 19
		msoLightRigSunrise = 20
		msoLightRigSunset = 21
		msoLightRigChilly = 22
		msoLightRigFreezing = 23
		msoLightRigFlat = 24
		msoLightRigTwoPoint = 25
		msoLightRigGlow = 26
		msoLightRigBrightRoom = 27
	End Enum

	Enum MsoParagraphAlignment
		msoAlignMixed = -2
		msoAlignLeft = 1
		msoAlignCenter = 2
		msoAlignRight = 3
		msoAlignJustify = 4
		msoAlignDistribute = 5
		msoAlignThaiDistribute = 6
		msoAlignJustifyLow = 7
	End Enum

	Enum MsoTextStrike
		msoStrikeMixed = -2
		msoNoStrike = 0
		msoSingleStrike = 1
		msoDoubleStrike = 2
	End Enum

	Enum MsoTextCaps
		msoCapsMixed = -2
		msoNoCaps = 0
		msoSmallCaps = 1
		msoAllCaps = 2
	End Enum

	Enum MsoTextUnderlineType
		msoUnderlineMixed = -2
		msoNoUnderline = 0
		msoUnderlineWords = 1
		msoUnderlineSingleLine = 2
		msoUnderlineDoubleLine = 3
		msoUnderlineHeavyLine = 4
		msoUnderlineDottedLine = 5
		msoUnderlineDottedHeavyLine = 6
		msoUnderlineDashLine = 7
		msoUnderlineDashHeavyLine = 8
		msoUnderlineDashLongLine = 9
		msoUnderlineDashLongHeavyLine = 10
		msoUnderlineDotDashLine = 11
		msoUnderlineDotDashHeavyLine = 12
		msoUnderlineDotDotDashLine = 13
		msoUnderlineDotDotDashHeavyLine = 14
		msoUnderlineWavyLine = 15
		msoUnderlineWavyHeavyLine = 16
		msoUnderlineWavyDoubleLine = 17
	End Enum

	Enum MsoTextTabAlign
		msoTabAlignMixed = -2
		msoTabAlignLeft = 0
		msoTabAlignCenter = 1
		msoTabAlignRight = 2
		msoTabAlignDecimal = 3
	End Enum

	Enum MsoTextCharWrap
		msoCharWrapMixed = -2
		msoNoCharWrap = 0
		msoStandardCharWrap = 1
		msoStrictCharWrap = 2
		msoCustomCharWrap = 3
	End Enum

	Enum MsoTextFontAlign
		msoFontAlignMixed = -2
		msoFontAlignAuto = 0
		msoFontAlignTop = 1
		msoFontAlignCenter = 2
		msoFontAlignBaseline = 3
		msoFontAlignBottom = 4
	End Enum

	Enum MsoAutoSize
		msoAutoSizeMixed = -2
		msoAutoSizeNone = 0
		msoAutoSizeShapeToFitText = 1
		msoAutoSizeTextToFitShape = 2
	End Enum

	Enum MsoPathFormat
		msoPathTypeMixed = -2
		msoPathTypeNone = 0
		msoPathType1 = 1
		msoPathType2 = 2
		msoPathType3 = 3
		msoPathType4 = 4
	End Enum

	Enum MsoWarpFormat
		msoWarpFormatMixed = -2
		msoWarpFormat1 = 0
		msoWarpFormat2 = 1
		msoWarpFormat3 = 2
		msoWarpFormat4 = 3
		msoWarpFormat5 = 4
		msoWarpFormat6 = 5
		msoWarpFormat7 = 6
		msoWarpFormat8 = 7
		msoWarpFormat9 = 8
		msoWarpFormat10 = 9
		msoWarpFormat11 = 10
		msoWarpFormat12 = 11
		msoWarpFormat13 = 12
		msoWarpFormat14 = 13
		msoWarpFormat15 = 14
		msoWarpFormat16 = 15
		msoWarpFormat17 = 16
		msoWarpFormat18 = 17
		msoWarpFormat19 = 18
		msoWarpFormat20 = 19
		msoWarpFormat21 = 20
		msoWarpFormat22 = 21
		msoWarpFormat23 = 22
		msoWarpFormat24 = 23
		msoWarpFormat25 = 24
		msoWarpFormat26 = 25
		msoWarpFormat27 = 26
		msoWarpFormat28 = 27
		msoWarpFormat29 = 28
		msoWarpFormat30 = 29
		msoWarpFormat31 = 30
		msoWarpFormat32 = 31
		msoWarpFormat33 = 32
		msoWarpFormat34 = 33
		msoWarpFormat35 = 34
		msoWarpFormat36 = 35
		msoWarpFormat37 = 36
	End Enum

	Enum MsoTextChangeCase
		msoCaseSentence = 1
		msoCaseLower = 2
		msoCaseUpper = 3
		msoCaseTitle = 4
		msoCaseToggle = 5
	End Enum

	Enum MsoDateTimeFormat
		msoDateTimeFormatMixed = -2
		msoDateTimeMdyy = 1
		msoDateTimeddddMMMMddyyyy = 2
		msoDateTimedMMMMyyyy = 3
		msoDateTimeMMMMdyyyy = 4
		msoDateTimedMMMyy = 5
		msoDateTimeMMMMyy = 6
		msoDateTimeMMyy = 7
		msoDateTimeMMddyyHmm = 8
		msoDateTimeMMddyyhmmAMPM = 9
		msoDateTimeHmm = 10
		msoDateTimeHmmss = 11
		msoDateTimehmmAMPM = 12
		msoDateTimehmmssAMPM = 13
		msoDateTimeFigureOut = 14
	End Enum

	Enum MsoThemeColorSchemeIndex
		msoThemeDark1 = 1
		msoThemeLight1 = 2
		msoThemeDark2 = 3
		msoThemeLight2 = 4
		msoThemeAccent1 = 5
		msoThemeAccent2 = 6
		msoThemeAccent3 = 7
		msoThemeAccent4 = 8
		msoThemeAccent5 = 9
		msoThemeAccent6 = 10
		msoThemeHyperlink = 11
		msoThemeFollowedHyperlink = 12
	End Enum

	Enum MsoThemeColorIndex
		msoThemeColorMixed = -2
		msoNotThemeColor = 0
		msoThemeColorDark1 = 1
		msoThemeColorLight1 = 2
		msoThemeColorDark2 = 3
		msoThemeColorLight2 = 4
		msoThemeColorAccent1 = 5
		msoThemeColorAccent2 = 6
		msoThemeColorAccent3 = 7
		msoThemeColorAccent4 = 8
		msoThemeColorAccent5 = 9
		msoThemeColorAccent6 = 10
		msoThemeColorHyperlink = 11
		msoThemeColorFollowedHyperlink = 12
		msoThemeColorText1 = 13
		msoThemeColorBackground1 = 14
		msoThemeColorText2 = 15
		msoThemeColorBackground2 = 16
	End Enum

	Enum MsoFontLanguageIndex
		msoThemeLatin = 1
		msoThemeComplexScript = 2
		msoThemeEastAsian = 3
	End Enum

	Enum MsoShapeStyleIndex
		msoShapeStyleMixed = -2
		msoShapeStyleNotAPreset = 0
		msoShapeStylePreset1 = 1
		msoShapeStylePreset2 = 2
		msoShapeStylePreset3 = 3
		msoShapeStylePreset4 = 4
		msoShapeStylePreset5 = 5
		msoShapeStylePreset6 = 6
		msoShapeStylePreset7 = 7
		msoShapeStylePreset8 = 8
		msoShapeStylePreset9 = 9
		msoShapeStylePreset10 = 10
		msoShapeStylePreset11 = 11
		msoShapeStylePreset12 = 12
		msoShapeStylePreset13 = 13
		msoShapeStylePreset14 = 14
		msoShapeStylePreset15 = 15
		msoShapeStylePreset16 = 16
		msoShapeStylePreset17 = 17
		msoShapeStylePreset18 = 18
		msoShapeStylePreset19 = 19
		msoShapeStylePreset20 = 20
		msoShapeStylePreset21 = 21
		msoShapeStylePreset22 = 22
		msoShapeStylePreset23 = 23
		msoShapeStylePreset24 = 24
		msoShapeStylePreset25 = 25
		msoShapeStylePreset26 = 26
		msoShapeStylePreset27 = 27
		msoShapeStylePreset28 = 28
		msoShapeStylePreset29 = 29
		msoShapeStylePreset30 = 30
		msoShapeStylePreset31 = 31
		msoShapeStylePreset32 = 32
		msoShapeStylePreset33 = 33
		msoShapeStylePreset34 = 34
		msoShapeStylePreset35 = 35
		msoShapeStylePreset36 = 36
		msoShapeStylePreset37 = 37
		msoShapeStylePreset38 = 38
		msoShapeStylePreset39 = 39
		msoShapeStylePreset40 = 40
		msoShapeStylePreset41 = 41
		msoShapeStylePreset42 = 42
		msoShapeStylePreset43 = 43
		msoShapeStylePreset44 = 44
		msoShapeStylePreset45 = 45
		msoShapeStylePreset46 = 46
		msoShapeStylePreset47 = 47
		msoShapeStylePreset48 = 48
		msoShapeStylePreset49 = 49
		msoShapeStylePreset50 = 50
		msoShapeStylePreset51 = 51
		msoShapeStylePreset52 = 52
		msoShapeStylePreset53 = 53
		msoShapeStylePreset54 = 54
		msoShapeStylePreset55 = 55
		msoShapeStylePreset56 = 56
		msoShapeStylePreset57 = 57
		msoShapeStylePreset58 = 58
		msoShapeStylePreset59 = 59
		msoShapeStylePreset60 = 60
		msoShapeStylePreset61 = 61
		msoShapeStylePreset62 = 62
		msoShapeStylePreset63 = 63
		msoShapeStylePreset64 = 64
		msoShapeStylePreset65 = 65
		msoShapeStylePreset66 = 66
		msoShapeStylePreset67 = 67
		msoShapeStylePreset68 = 68
		msoShapeStylePreset69 = 69
		msoShapeStylePreset70 = 70
		msoShapeStylePreset71 = 71
		msoShapeStylePreset72 = 72
		msoShapeStylePreset73 = 73
		msoShapeStylePreset74 = 74
		msoShapeStylePreset75 = 75
		msoShapeStylePreset76 = 76
		msoShapeStylePreset77 = 77
		msoLineStylePreset1 = 10001
		msoLineStylePreset2 = 10002
		msoLineStylePreset3 = 10003
		msoLineStylePreset4 = 10004
		msoLineStylePreset5 = 10005
		msoLineStylePreset6 = 10006
		msoLineStylePreset7 = 10007
		msoLineStylePreset8 = 10008
		msoLineStylePreset9 = 10009
		msoLineStylePreset10 = 10010
		msoLineStylePreset11 = 10011
		msoLineStylePreset12 = 10012
		msoLineStylePreset13 = 10013
		msoLineStylePreset14 = 10014
		msoLineStylePreset15 = 10015
		msoLineStylePreset16 = 10016
		msoLineStylePreset17 = 10017
		msoLineStylePreset18 = 10018
		msoLineStylePreset19 = 10019
		msoLineStylePreset20 = 10020
		msoLineStylePreset21 = 10021
		msoLineStylePreset22 = 10022
		msoLineStylePreset23 = 10023
		msoLineStylePreset24 = 10024
		msoLineStylePreset25 = 10025
		msoLineStylePreset26 = 10026
		msoLineStylePreset27 = 10027
		msoLineStylePreset28 = 10028
		msoLineStylePreset29 = 10029
		msoLineStylePreset30 = 10030
		msoLineStylePreset31 = 10031
		msoLineStylePreset32 = 10032
		msoLineStylePreset33 = 10033
		msoLineStylePreset34 = 10034
		msoLineStylePreset35 = 10035
		msoLineStylePreset36 = 10036
		msoLineStylePreset37 = 10037
		msoLineStylePreset38 = 10038
		msoLineStylePreset39 = 10039
		msoLineStylePreset40 = 10040
		msoLineStylePreset41 = 10041
		msoLineStylePreset42 = 10042
	End Enum

	Enum MsoBackgroundStyleIndex
		msoBackgroundStyleMixed = -2
		msoBackgroundStyleNotAPreset = 0
		msoBackgroundStylePreset1 = 1
		msoBackgroundStylePreset2 = 2
		msoBackgroundStylePreset3 = 3
		msoBackgroundStylePreset4 = 4
		msoBackgroundStylePreset5 = 5
		msoBackgroundStylePreset6 = 6
		msoBackgroundStylePreset7 = 7
		msoBackgroundStylePreset8 = 8
		msoBackgroundStylePreset9 = 9
		msoBackgroundStylePreset10 = 10
		msoBackgroundStylePreset11 = 11
		msoBackgroundStylePreset12 = 12
	End Enum

	Enum MsoCTPDockPosition
		msoCTPDockPositionLeft = 0
		msoCTPDockPositionTop = 1
		msoCTPDockPositionRight = 2
		msoCTPDockPositionBottom = 3
		msoCTPDockPositionFloating = 4
	End Enum

	Enum MsoCTPDockPositionRestrict
		msoCTPDockPositionRestrictNone = 0
		msoCTPDockPositionRestrictNoChange = 1
		msoCTPDockPositionRestrictNoHorizontal = 2
		msoCTPDockPositionRestrictNoVertical = 3
	End Enum

	Enum RibbonControlSize
		RibbonControlSizeRegular = 0
		RibbonControlSizeLarge = 1
	End Enum

	Enum MsoShadowStyle
		msoShadowStyleMixed = -2
		msoShadowStyleInnerShadow = 1
		msoShadowStyleOuterShadow = 2
	End Enum

	Enum MsoTextDirection
		msoTextDirectionMixed = -2
		msoTextDirectionLeftToRight = 1
		msoTextDirectionRightToLeft = 2
	End Enum

	Enum XlChartType
		xlColumnClustered = 51
		xlColumnStacked = 52
		xlColumnStacked100 = 53
		xl3DColumnClustered = 54
		xl3DColumnStacked = 55
		xl3DColumnStacked100 = 56
		xlBarClustered = 57
		xlBarStacked = 58
		xlBarStacked100 = 59
		xl3DBarClustered = 60
		xl3DBarStacked = 61
		xl3DBarStacked100 = 62
		xlLineStacked = 63
		xlLineStacked100 = 64
		xlLineMarkers = 65
		xlLineMarkersStacked = 66
		xlLineMarkersStacked100 = 67
		xlPieOfPie = 68
		xlPieExploded = 69
		xl3DPieExploded = 70
		xlBarOfPie = 71
		xlXYScatterSmooth = 72
		xlXYScatterSmoothNoMarkers = 73
		xlXYScatterLines = 74
		xlXYScatterLinesNoMarkers = 75
		xlAreaStacked = 76
		xlAreaStacked100 = 77
		xl3DAreaStacked = 78
		xl3DAreaStacked100 = 79
		xlDoughnutExploded = 80
		xlRadarMarkers = 81
		xlRadarFilled = 82
		xlSurface = 83
		xlSurfaceWireframe = 84
		xlSurfaceTopView = 85
		xlSurfaceTopViewWireframe = 86
		xlBubble = 15
		xlBubble3DEffect = 87
		xlStockHLC = 88
		xlStockOHLC = 89
		xlStockVHLC = 90
		xlStockVOHLC = 91
		xlCylinderColClustered = 92
		xlCylinderColStacked = 93
		xlCylinderColStacked100 = 94
		xlCylinderBarClustered = 95
		xlCylinderBarStacked = 96
		xlCylinderBarStacked100 = 97
		xlCylinderCol = 98
		xlConeColClustered = 99
		xlConeColStacked = 100
		xlConeColStacked100 = 101
		xlConeBarClustered = 102
		xlConeBarStacked = 103
		xlConeBarStacked100 = 104
		xlConeCol = 105
		xlPyramidColClustered = 106
		xlPyramidColStacked = 107
		xlPyramidColStacked100 = 108
		xlPyramidBarClustered = 109
		xlPyramidBarStacked = 110
		xlPyramidBarStacked100 = 111
		xlPyramidCol = 112
		xl3DColumn = -4100
		xlLine = 4
		xl3DLine = -4101
		xl3DPie = -4102
		xlPie = 5
		xlXYScatter = -4169
		xl3DArea = -4098
		xlArea = 1
		xlDoughnut = -4120
		xlRadar = -4151
		xlCombo = -4152
		xlComboColumnClusteredLine = 113
		xlComboColumnClusteredLineSecondaryAxis = 114
		xlComboAreaStackedColumnClustered = 115
		xlOtherCombinations = 116
		xlSuggestedChart = -2
		xlTreemap = 117
		xlHistogram = 118
		xlWaterfall = 119
		xlSunburst = 120
		xlBoxwhisker = 121
		xlPareto = 122
	End Enum

	Enum XlChartSplitType
		xlSplitByPosition = 1
		xlSplitByPercentValue = 3
		xlSplitByCustomSplit = 4
		xlSplitByValue = 2
	End Enum

	Enum XlSizeRepresents
		xlSizeIsWidth = 2
		xlSizeIsArea = 1
	End Enum

	Enum XlAxisGroup
		xlPrimary = 1
		xlSecondary = 2
	End Enum

	Enum XlConstants
		xlAutomatic = -4105
		xlCombination = -4111
		xlCustom = -4114
		xlBar = 2
		xlColumn = 3
		xl3DBar = -4099
		xl3DSurface = -4103
		xlDefaultAutoFormat = -1
		xlNone = -4142
		xlAbove = 0
		xlBelow = 1
		xlBoth = 1
		xlBottom = -4107
		xlCenter = -4108
		xlChecker = 9
		xlCircle = 8
		xlCorner = 2
		xlCrissCross = 16
		xlCross = 4
		xlDiamond = 2
		xlDistributed = -4117
		xlFill = 5
		xlFixedValue = 1
		xlGeneral = 1
		xlGray16 = 17
		xlGray25 = -4124
		xlGray50 = -4125
		xlGray75 = -4126
		xlGray8 = 18
		xlGrid = 15
		xlHigh = -4127
		xlInside = 2
		xlJustify = -4130
		xlLeft = -4131
		xlLightDown = 13
		xlLightHorizontal = 11
		xlLightUp = 14
		xlLightVertical = 12
		xlLow = -4134
		xlMaximum = 2
		xlMinimum = 4
		xlMinusValues = 3
		xlNextToAxis = 4
		xlOpaque = 3
		xlOutside = 3
		xlPercent = 2
		xlPlus = 9
		xlPlusValues = 2
		xlRight = -4152
		xlScale = 3
		xlSemiGray75 = 10
		xlShowLabel = 4
		xlShowLabelAndPercent = 5
		xlShowPercent = 3
		xlShowValue = 2
		xlSingle = 2
		xlSolid = 1
		xlSquare = 1
		xlStar = 5
		xlStError = 4
		xlTop = -4160
		xlTransparent = 2
		xlTriangle = 3
	End Enum

	Enum XlReadingOrder
		xlContext = -5002
		xlLTR = -5003
		xlRTL = -5004
	End Enum

	Enum XlBorderWeight
		xlHairline = 1
		xlMedium = -4138
		xlThick = 4
		xlThin = 2
	End Enum

	Enum XlLegendPosition
		xlLegendPositionBottom = -4107
		xlLegendPositionCorner = 2
		xlLegendPositionLeft = -4131
		xlLegendPositionRight = -4152
		xlLegendPositionTop = -4160
		xlLegendPositionCustom = -4161
	End Enum

	Enum XlUnderlineStyle
		xlUnderlineStyleDouble = -4119
		xlUnderlineStyleDoubleAccounting = 5
		xlUnderlineStyleNone = -4142
		xlUnderlineStyleSingle = 2
		xlUnderlineStyleSingleAccounting = 4
	End Enum

	Enum XlColorIndex
		xlColorIndexAutomatic = -4105
		xlColorIndexNone = -4142
	End Enum

	Enum XlMarkerStyle
		xlMarkerStyleAutomatic = -4105
		xlMarkerStyleCircle = 8
		xlMarkerStyleDash = -4115
		xlMarkerStyleDiamond = 2
		xlMarkerStyleDot = -4118
		xlMarkerStyleNone = -4142
		xlMarkerStylePicture = -4147
		xlMarkerStylePlus = 9
		xlMarkerStyleSquare = 1
		xlMarkerStyleStar = 5
		xlMarkerStyleTriangle = 3
		xlMarkerStyleX = -4168
	End Enum

	Enum XlRowCol
		xlColumns = 2
		xlRows = 1
	End Enum

	Enum XlDataLabelsType
		xlDataLabelsShowNone = -4142
		xlDataLabelsShowValue = 2
		xlDataLabelsShowPercent = 3
		xlDataLabelsShowLabel = 4
		xlDataLabelsShowLabelAndPercent = 5
		xlDataLabelsShowBubbleSizes = 6
	End Enum

	Enum XlErrorBarInclude
		xlErrorBarIncludeBoth = 1
		xlErrorBarIncludeMinusValues = 3
		xlErrorBarIncludeNone = -4142
		xlErrorBarIncludePlusValues = 2
	End Enum

	Enum XlErrorBarType
		xlErrorBarTypeCustom = -4114
		xlErrorBarTypeFixedValue = 1
		xlErrorBarTypePercent = 2
		xlErrorBarTypeStDev = -4155
		xlErrorBarTypeStError = 4
	End Enum

	Enum XlErrorBarDirection
		xlChartX = -4168
		xlChartY = 1
	End Enum

	Enum XlChartPictureType
		xlStackScale = 3
		xlStack = 2
		xlStretch = 1
	End Enum

	Enum XlChartItem
		xlDataLabel = 0
		xlChartArea = 2
		xlSeries = 3
		xlChartTitle = 4
		xlWalls = 5
		xlCorners = 6
		xlDataTable = 7
		xlTrendline = 8
		xlErrorBars = 9
		xlXErrorBars = 10
		xlYErrorBars = 11
		xlLegendEntry = 12
		xlLegendKey = 13
		xlShape = 14
		xlMajorGridlines = 15
		xlMinorGridlines = 16
		xlAxisTitle = 17
		xlUpBars = 18
		xlPlotArea = 19
		xlDownBars = 20
		xlAxis = 21
		xlSeriesLines = 22
		xlFloor = 23
		xlLegend = 24
		xlHiLoLines = 25
		xlDropLines = 26
		xlRadarAxisLabels = 27
		xlNothing = 28
		xlLeaderLines = 29
		xlDisplayUnitLabel = 30
		xlPivotChartFieldButton = 31
		xlPivotChartDropZone = 32
		xlPivotChartExpandEntireFieldButton = 33
		xlPivotChartCollapseEntireFieldButton = 34
	End Enum

	Enum XlBarShape
		xlBox = 0
		xlPyramidToPoint = 1
		xlPyramidToMax = 2
		xlCylinder = 3
		xlConeToPoint = 4
		xlConeToMax = 5
	End Enum

	Enum XlEndStyleCap
		xlCap = 1
		xlNoCap = 2
	End Enum

	Enum XlTrendlineType
		xlExponential = 5
		xlLinear = -4132
		xlLogarithmic = -4133
		xlMovingAvg = 6
		xlPolynomial = 3
		xlPower = 4
	End Enum

	Enum XlAxisType
		xlCategory = 1
		xlSeriesAxis = 3
		xlValue = 2
	End Enum

	Enum XlAxisCrosses
		xlAxisCrossesAutomatic = -4105
		xlAxisCrossesCustom = -4114
		xlAxisCrossesMaximum = 2
		xlAxisCrossesMinimum = 4
	End Enum

	Enum XlTickMark
		xlTickMarkCross = 4
		xlTickMarkInside = 2
		xlTickMarkNone = -4142
		xlTickMarkOutside = 3
	End Enum

	Enum XlScaleType
		xlScaleLinear = -4132
		xlScaleLogarithmic = -4133
	End Enum

	Enum XlTickLabelPosition
		xlTickLabelPositionHigh = -4127
		xlTickLabelPositionLow = -4134
		xlTickLabelPositionNextToAxis = 4
		xlTickLabelPositionNone = -4142
	End Enum

	Enum XlTimeUnit
		xlDays = 0
		xlMonths = 1
		xlYears = 2
	End Enum

	Enum XlCategoryType
		xlCategoryScale = 2
		xlTimeScale = 3
		xlAutomaticScale = -4105
	End Enum

	Enum XlDisplayUnit
		xlHundreds = -2
		xlThousands = -3
		xlTenThousands = -4
		xlHundredThousands = -5
		xlMillions = -6
		xlTenMillions = -7
		xlHundredMillions = -8
		xlThousandMillions = -9
		xlMillionMillions = -10
		xlDisplayUnitCustom = -4114
		xlDisplayUnitNone = -4142
	End Enum

	Enum XlChartOrientation
		xlDownward = -4170
		xlHorizontal = -4128
		xlUpward = -4171
		xlVertical = -4166
	End Enum

	Enum XlTickLabelOrientation
		xlTickLabelOrientationAutomatic = -4105
		xlTickLabelOrientationDownward = -4170
		xlTickLabelOrientationHorizontal = -4128
		xlTickLabelOrientationUpward = -4171
		xlTickLabelOrientationVertical = -4166
	End Enum

	Enum XlDisplayBlanksAs
		xlInterpolated = 3
		xlNotPlotted = 1
		xlZero = 2
	End Enum

	Enum XlDataLabelPosition
		xlLabelPositionCenter = -4108
		xlLabelPositionAbove = 0
		xlLabelPositionBelow = 1
		xlLabelPositionLeft = -4131
		xlLabelPositionRight = -4152
		xlLabelPositionOutsideEnd = 2
		xlLabelPositionInsideEnd = 3
		xlLabelPositionInsideBase = 4
		xlLabelPositionBestFit = 5
		xlLabelPositionMixed = 6
		xlLabelPositionCustom = 7
	End Enum

	Enum XlPivotFieldOrientation
		xlColumnField = 2
		xlDataField = 4
		xlHidden = 0
		xlPageField = 3
		xlRowField = 1
	End Enum

	Enum XlHAlign
		xlHAlignCenter = -4108
		xlHAlignCenterAcrossSelection = 7
		xlHAlignDistributed = -4117
		xlHAlignFill = 5
		xlHAlignGeneral = 1
		xlHAlignJustify = -4130
		xlHAlignLeft = -4131
		xlHAlignRight = -4152
	End Enum

	Enum XlVAlign
		xlVAlignBottom = -4107
		xlVAlignCenter = -4108
		xlVAlignDistributed = -4117
		xlVAlignJustify = -4130
		xlVAlignTop = -4160
	End Enum

	Enum XlChartElementPosition
		xlChartElementPositionAutomatic = -4105
		xlChartElementPositionCustom = -4114
	End Enum

	Enum MsoChartElementType
		msoElementChartTitleNone = 0
		msoElementChartTitleCenteredOverlay = 1
		msoElementChartTitleAboveChart = 2
		msoElementLegendNone = 100
		msoElementLegendRight = 101
		msoElementLegendTop = 102
		msoElementLegendLeft = 103
		msoElementLegendBottom = 104
		msoElementLegendRightOverlay = 105
		msoElementLegendLeftOverlay = 106
		msoElementDataLabelNone = 200
		msoElementDataLabelShow = 201
		msoElementDataLabelCenter = 202
		msoElementDataLabelInsideEnd = 203
		msoElementDataLabelInsideBase = 204
		msoElementDataLabelOutSideEnd = 205
		msoElementDataLabelLeft = 206
		msoElementDataLabelRight = 207
		msoElementDataLabelTop = 208
		msoElementDataLabelBottom = 209
		msoElementDataLabelBestFit = 210
		msoElementDataLabelCallout = 211
		msoElementPrimaryCategoryAxisTitleNone = 300
		msoElementPrimaryCategoryAxisTitleAdjacentToAxis = 301
		msoElementPrimaryCategoryAxisTitleBelowAxis = 302
		msoElementPrimaryCategoryAxisTitleRotated = 303
		msoElementPrimaryCategoryAxisTitleVertical = 304
		msoElementPrimaryCategoryAxisTitleHorizontal = 305
		msoElementPrimaryValueAxisTitleNone = 306
		msoElementPrimaryValueAxisTitleAdjacentToAxis = 306
		msoElementPrimaryValueAxisTitleBelowAxis = 308
		msoElementPrimaryValueAxisTitleRotated = 309
		msoElementPrimaryValueAxisTitleVertical = 310
		msoElementPrimaryValueAxisTitleHorizontal = 311
		msoElementSecondaryCategoryAxisTitleNone = 312
		msoElementSecondaryCategoryAxisTitleAdjacentToAxis = 313
		msoElementSecondaryCategoryAxisTitleBelowAxis = 314
		msoElementSecondaryCategoryAxisTitleRotated = 315
		msoElementSecondaryCategoryAxisTitleVertical = 316
		msoElementSecondaryCategoryAxisTitleHorizontal = 317
		msoElementSecondaryValueAxisTitleNone = 318
		msoElementSecondaryValueAxisTitleAdjacentToAxis = 319
		msoElementSecondaryValueAxisTitleBelowAxis = 320
		msoElementSecondaryValueAxisTitleRotated = 321
		msoElementSecondaryValueAxisTitleVertical = 322
		msoElementSecondaryValueAxisTitleHorizontal = 323
		msoElementSeriesAxisTitleNone = 324
		msoElementSeriesAxisTitleRotated = 325
		msoElementSeriesAxisTitleVertical = 326
		msoElementSeriesAxisTitleHorizontal = 327
		msoElementPrimaryValueGridLinesNone = 328
		msoElementPrimaryValueGridLinesMinor = 329
		msoElementPrimaryValueGridLinesMajor = 330
		msoElementPrimaryValueGridLinesMinorMajor = 331
		msoElementPrimaryCategoryGridLinesNone = 332
		msoElementPrimaryCategoryGridLinesMinor = 333
		msoElementPrimaryCategoryGridLinesMajor = 334
		msoElementPrimaryCategoryGridLinesMinorMajor = 335
		msoElementSecondaryValueGridLinesNone = 336
		msoElementSecondaryValueGridLinesMinor = 337
		msoElementSecondaryValueGridLinesMajor = 338
		msoElementSecondaryValueGridLinesMinorMajor = 339
		msoElementSecondaryCategoryGridLinesNone = 340
		msoElementSecondaryCategoryGridLinesMinor = 341
		msoElementSecondaryCategoryGridLinesMajor = 342
		msoElementSecondaryCategoryGridLinesMinorMajor = 343
		msoElementSeriesAxisGridLinesNone = 344
		msoElementSeriesAxisGridLinesMinor = 345
		msoElementSeriesAxisGridLinesMajor = 346
		msoElementSeriesAxisGridLinesMinorMajor = 347
		msoElementPrimaryCategoryAxisNone = 348
		msoElementPrimaryCategoryAxisShow = 349
		msoElementPrimaryCategoryAxisWithoutLabels = 350
		msoElementPrimaryCategoryAxisReverse = 351
		msoElementPrimaryValueAxisNone = 352
		msoElementPrimaryValueAxisShow = 353
		msoElementPrimaryValueAxisThousands = 354
		msoElementPrimaryValueAxisMillions = 355
		msoElementPrimaryValueAxisBillions = 356
		msoElementPrimaryValueAxisLogScale = 357
		msoElementSecondaryCategoryAxisNone = 358
		msoElementSecondaryCategoryAxisShow = 359
		msoElementSecondaryCategoryAxisWithoutLabels = 360
		msoElementSecondaryCategoryAxisReverse = 361
		msoElementSecondaryValueAxisNone = 362
		msoElementSecondaryValueAxisShow = 363
		msoElementSecondaryValueAxisThousands = 364
		msoElementSecondaryValueAxisMillions = 365
		msoElementSecondaryValueAxisBillions = 366
		msoElementSecondaryValueAxisLogScale = 367
		msoElementSeriesAxisNone = 368
		msoElementSeriesAxisShow = 369
		msoElementSeriesAxisWithoutLabeling = 370
		msoElementSeriesAxisReverse = 371
		msoElementPrimaryCategoryAxisThousands = 372
		msoElementPrimaryCategoryAxisMillions = 373
		msoElementPrimaryCategoryAxisBillions = 374
		msoElementPrimaryCategoryAxisLogScale = 375
		msoElementSecondaryCategoryAxisThousands = 376
		msoElementSecondaryCategoryAxisMillions = 377
		msoElementSecondaryCategoryAxisBillions = 378
		msoElementSecondaryCategoryAxisLogScale = 379
		msoElementDataTableNone = 500
		msoElementDataTableShow = 501
		msoElementDataTableWithLegendKeys = 502
		msoElementTrendlineNone = 600
		msoElementTrendlineAddLinear = 601
		msoElementTrendlineAddExponential = 602
		msoElementTrendlineAddLinearForecast = 603
		msoElementTrendlineAddTwoPeriodMovingAverage = 604
		msoElementErrorBarNone = 700
		msoElementErrorBarStandardError = 701
		msoElementErrorBarPercentage = 702
		msoElementErrorBarStandardDeviation = 703
		msoElementLineNone = 800
		msoElementLineDropLine = 801
		msoElementLineHiLoLine = 802
		msoElementLineSeriesLine = 803
		msoElementLineDropHiLoLine = 804
		msoElementUpDownBarsNone = 900
		msoElementUpDownBarsShow = 901
		msoElementPlotAreaNone = 1000
		msoElementPlotAreaShow = 1001
		msoElementChartWallNone = 1100
		msoElementChartWallShow = 1101
		msoElementChartFloorNone = 1200
		msoElementChartFloorShow = 1201
	End Enum

	Enum MsoBulletType
		msoBulletMixed = -2
		msoBulletNone = 0
		msoBulletUnnumbered = 1
		msoBulletNumbered = 2
		msoBulletPicture = 3
	End Enum

	Enum MsoNumberedBulletStyle
		msoBulletStyleMixed = -2
		msoBulletAlphaLCPeriod = 0
		msoBulletAlphaUCPeriod = 1
		msoBulletArabicParenRight = 2
		msoBulletArabicPeriod = 3
		msoBulletRomanLCParenBoth = 4
		msoBulletRomanLCParenRight = 5
		msoBulletRomanLCPeriod = 6
		msoBulletRomanUCPeriod = 7
		msoBulletAlphaLCParenBoth = 8
		msoBulletAlphaLCParenRight = 9
		msoBulletAlphaUCParenBoth = 10
		msoBulletAlphaUCParenRight = 11
		msoBulletArabicParenBoth = 12
		msoBulletArabicPlain = 13
		msoBulletRomanUCParenBoth = 14
		msoBulletRomanUCParenRight = 15
		msoBulletSimpChinPlain = 16
		msoBulletSimpChinPeriod = 17
		msoBulletCircleNumDBPlain = 18
		msoBulletCircleNumWDWhitePlain = 19
		msoBulletCircleNumWDBlackPlain = 20
		msoBulletTradChinPlain = 21
		msoBulletTradChinPeriod = 22
		msoBulletArabicAlphaDash = 23
		msoBulletArabicAbjadDash = 24
		msoBulletHebrewAlphaDash = 25
		msoBulletKanjiKoreanPlain = 26
		msoBulletKanjiKoreanPeriod = 27
		msoBulletArabicDBPlain = 28
		msoBulletArabicDBPeriod = 29
		msoBulletThaiAlphaPeriod = 30
		msoBulletThaiAlphaParenRight = 31
		msoBulletThaiAlphaParenBoth = 32
		msoBulletThaiNumPeriod = 33
		msoBulletThaiNumParenRight = 34
		msoBulletThaiNumParenBoth = 35
		msoBulletHindiAlphaPeriod = 36
		msoBulletHindiNumPeriod = 37
		msoBulletKanjiSimpChinDBPeriod = 38
		msoBulletHindiNumParenRight = 39
		msoBulletHindiAlpha1Period = 40
	End Enum

	Enum MsoTabStopType
		msoTabStopMixed = -2
		msoTabStopLeft = 1
		msoTabStopCenter = 2
		msoTabStopRight = 3
		msoTabStopDecimal = 4
	End Enum

	Enum MsoBaselineAlignment
		msoBaselineAlignMixed = -2
		msoBaselineAlignBaseline = 1
		msoBaselineAlignTop = 2
		msoBaselineAlignCenter = 3
		msoBaselineAlignFarEast50 = 4
		msoBaselineAlignAuto = 5
	End Enum

	Enum EncryptionProviderDetail
		encprovdetUrl = 0
		encprovdetAlgorithm = 1
		encprovdetBlockCipher = 2
		encprovdetCipherBlockSize = 3
		encprovdetCipherMode = 4
	End Enum

	Enum EncryptionCipherMode
		cipherModeECB = 0
		cipherModeCBC = 1
	End Enum

	Enum MsoClipboardFormat
		msoClipboardFormatMixed = -2
		msoClipboardFormatNative = 1
		msoClipboardFormatHTML = 2
		msoClipboardFormatRTF = 3
		msoClipboardFormatPlainText = 4
	End Enum

	Enum MsoBlogCategorySupport
		msoBlogNoCategories = 0
		msoBlogOneCategory = 1
		msoBlogMultipleCategories = 2
	End Enum

	Enum MsoBlogImageType
		msoblogImageTypeJPEG = 1
		msoblogImageTypeGIF = 2
		msoblogImageTypePNG = 3
	End Enum

	Enum XlPieSliceLocation
		xlHorizontalCoordinate = 1
		xlVerticalCoordinate = 2
	End Enum

	Enum XlPieSliceIndex
		xlOuterCounterClockwisePoint = 1
		xlOuterCenterPoint = 2
		xlOuterClockwisePoint = 3
		xlMidClockwiseRadiusPoint = 4
		xlCenterPoint = 5
		xlMidCounterClockwiseRadiusPoint = 6
		xlInnerClockwisePoint = 7
		xlInnerCenterPoint = 8
		xlInnerCounterClockwisePoint = 9
	End Enum

	Enum MsoSmartArtNodePosition
		msoSmartArtNodeDefault = 1
		msoSmartArtNodeAfter = 2
		msoSmartArtNodeBefore = 3
		msoSmartArtNodeAbove = 4
		msoSmartArtNodeBelow = 5
	End Enum

	Enum MsoSmartArtNodeType
		msoSmartArtNodeTypeDefault = 1
		msoSmartArtNodeTypeAssistant = 2
	End Enum

	Enum MsoPickerField
		msoPickerFieldUnknown = 0
		msoPickerFieldDateTime = 1
		msoPickerFieldNumber = 2
		msoPickerFieldText = 3
		msoPickerFieldUser = 4
		msoPickerFieldMax = 5
	End Enum

	Enum MsoContactCardAddressType
		msoContactCardAddressTypeUnknown = 0
		msoContactCardAddressTypeOutlook = 1
		msoContactCardAddressTypeSMTP = 2
		msoContactCardAddressTypeIM = 3
	End Enum

	Enum MsoContactCardType
		msoContactCardTypeEnterpriseContact = 0
		msoContactCardTypePersonalContact = 1
		msoContactCardTypeUnknownContact = 2
		msoContactCardTypeEnterpriseGroup = 3
		msoContactCardTypePersonalDistributionList = 4
	End Enum

	Enum MsoPictureEffectType
		msoEffectNone = 0
		msoEffectBackgroundRemoval = 1
		msoEffectBlur = 2
		msoEffectBrightnessContrast = 3
		msoEffectCement = 4
		msoEffectCrisscrossEtching = 5
		msoEffectChalkSketch = 6
		msoEffectColorTemperature = 7
		msoEffectCutout = 8
		msoEffectFilmGrain = 9
		msoEffectGlass = 10
		msoEffectGlowDiffused = 11
		msoEffectGlowEdges = 12
		msoEffectLightScreen = 13
		msoEffectLineDrawing = 14
		msoEffectMarker = 15
		msoEffectMosiaicBubbles = 16
		msoEffectPaintBrush = 17
		msoEffectPaintStrokes = 18
		msoEffectPastelsSmooth = 19
		msoEffectPencilGrayscale = 20
		msoEffectPencilSketch = 21
		msoEffectPhotocopy = 22
		msoEffectPlasticWrap = 23
		msoEffectSaturation = 24
		msoEffectSharpenSoften = 25
		msoEffectTexturizer = 26
		msoEffectWatercolorSponge = 27
	End Enum

	Enum MsoIodGroup
		msoIodGroupPIAs = 0
		msoIodGroupVSTOR35Mgd = 1
		msoIodGroupVSTOR40Mgd = 2
	End Enum

	Enum BackstageGroupStyle
		BackstageGroupStyleNormal = 0
		BackstageGroupStyleWarning = 1
		BackstageGroupStyleError = 2
	End Enum

	Enum MsoFileValidationMode
		msoFileValidationDefault = 0
		msoFileValidationSkip = 1
	End Enum

	Enum MsoContactCardStyle
		msoContactCardHover = 0
		msoContactCardFull = 1
	End Enum

	Enum MsoMergeCmd
		msoMergeUnion = 1
		msoMergeCombine = 2
		msoMergeIntersect = 3
		msoMergeSubtract = 4
		msoMergeFragment = 5
	End Enum

	Enum MsoLineCapStyle
		msoLineCapMixed = -2
		msoLineCapSquare = 1
		msoLineCapRound = 2
		msoLineCapFlat = 3
	End Enum

	Enum MsoLineJoinStyle
		msoLineJoinMixed = -2
		msoLineJoinRound = 1
		msoLineJoinBevel = 2
		msoLineJoinMiter = 3
	End Enum

	Enum MsoLineFillType
		msoLineFillMixed = -2
		msoLineFillNone = 0
		msoLineFillSolid = 1
		msoLineFillPatterned = 2
		msoLineFillGradient = 3
		msoLineFillTextured = 4
		msoLineFillBackground = 5
		msoLineFillPicture = 6
	End Enum

	Enum MsoChartFieldType
		msoChartFieldBubbleSize = 1
		msoChartFieldCategoryName = 2
		msoChartFieldPercentage = 3
		msoChartFieldSeriesName = 4
		msoChartFieldValue = 5
		msoChartFieldFormula = 6
		msoChartFieldRange = 7
	End Enum

	Enum MsoBroadcastState
		NoBroadcast = 0
		BroadcastStarted = 1
		BroadcastPaused = 2
	End Enum

	Enum MsoBroadcastCapabilities
		BroadcastCapFileSizeLimited = 1
		BroadcastCapSupportsMeetingNotes = 2
		BroadcastCapSupportsUpdateDoc = 4
	End Enum

	Enum MsoPictureCompress
		msoPictureCompressDocDefault = -1
		msoPictureCompressFalse = 0
		msoPictureCompressTrue = 1
	End Enum

	Enum XlCategoryLabelLevel
		xlCategoryLabelLevelNone = -3
		xlCategoryLabelLevelCustom = -2
		xlCategoryLabelLevelAll = -1
	End Enum

	Enum XlSeriesNameLevel
		xlSeriesNameLevelNone = -3
		xlSeriesNameLevelCustom = -2
		xlSeriesNameLevelAll = -1
	End Enum

	Enum XlParentDataLabelOptions
		xlParentDataLabelOptionsNone = 0
		xlParentDataLabelOptionsBanner = 1
		xlParentDataLabelOptionsOverlapping = 2
	End Enum

	Enum XlBinsType
		xlBinsTypeAutomatic = 0
		xlBinsTypeCategorical = 1
		xlBinsTypeManual = 2
		xlBinsTypeBinSize = 3
		xlBinsTypeBinCount = 4
	End Enum

	' Interface pre declaration.
	Type DocumentProperty As DocumentProperty_
	Type DocumentProperties As DocumentProperties_
	Type IDocumentInspector As IDocumentInspector_
	Type LegendEntries As LegendEntries_
	Type ChartColorFormat As ChartColorFormat_
	Type LegendEntry As LegendEntry_
	Type IMsoLegendKey As IMsoLegendKey_
	Type SeriesCollection As SeriesCollection_
	Type IMsoSeries As IMsoSeries_
	Type IMsoErrorBars As IMsoErrorBars_
	Type IMsoTrendline As IMsoTrendline_
	Type Trendlines As Trendlines_
	Type IMsoDataLabels As IMsoDataLabels_
	Type IMsoDataLabel As IMsoDataLabel_
	Type Points As Points_
	Type ChartPoint As ChartPoint_
	Type IConverterPreferences As IConverterPreferences_
	Type IConverterApplicationPreferences As IConverterApplicationPreferences_
	Type IConverterUICallback As IConverterUICallback_
	Type IConverter As IConverter_
	Type FullSeriesCollection As FullSeriesCollection_
	Type IMsoCategory As IMsoCategory_
	Type CategoryCollection As CategoryCollection_

	' Default interface pre declaration for component classes.
	Type CommandBars As _CommandBars
	Type CommandBarComboBox As _CommandBarComboBox
	Type CommandBarButton As _CommandBarButton
	Type MsoEnvelope As IMsoEnvelopeVB
	Type CustomXMLSchemaCollection As _CustomXMLSchemaCollection
	Type CustomXMLPart As _CustomXMLPart
	Type CustomXMLParts As _CustomXMLParts
	Type CustomTaskPane As _CustomTaskPane

	' Dual interface pre declaration.
	Type IAccessible As IAccessible_
	Type _IMsoDispObj As _IMsoDispObj_
	Type _IMsoOleAccDispObj As _IMsoOleAccDispObj_
	Type _CommandBars As _CommandBars_
	Type CommandBar As CommandBar_
	Type CommandBarControls As CommandBarControls_
	Type CommandBarControl As CommandBarControl_
	Type _CommandBarButton As _CommandBarButton_
	Type CommandBarPopup As CommandBarPopup_
	Type _CommandBarComboBox As _CommandBarComboBox_
	Type _CommandBarActiveX As _CommandBarActiveX_
	Type Adjustments As Adjustments_
	Type CalloutFormat As CalloutFormat_
	Type ColorFormat As ColorFormat_
	Type ConnectorFormat As ConnectorFormat_
	Type FillFormat As FillFormat_
	Type FreeformBuilder As FreeformBuilder_
	Type GroupShapes As GroupShapes_
	Type LineFormat As LineFormat_
	Type ShapeNode As ShapeNode_
	Type ShapeNodes As ShapeNodes_
	Type PictureFormat As PictureFormat_
	Type ShadowFormat As ShadowFormat_
	Type Script As Script_
	Type Scripts As Scripts_
	Type Shape As Shape_
	Type ShapeRange As ShapeRange_
	Type Shapes As Shapes_
	Type TextEffectFormat As TextEffectFormat_
	Type TextFrame As TextFrame_
	Type ThreeDFormat As ThreeDFormat_
	Type IMsoDispCagNotifySink As IMsoDispCagNotifySink_
	Type Balloon As Balloon_
	Type BalloonCheckboxes As BalloonCheckboxes_
	Type BalloonCheckbox As BalloonCheckbox_
	Type BalloonLabels As BalloonLabels_
	Type BalloonLabel As BalloonLabel_
	Type AnswerWizardFiles As AnswerWizardFiles_
	Type AnswerWizard As AnswerWizard_
	Type Assistant As Assistant_
	Type IFoundFiles As IFoundFiles_
	Type IFind As IFind_
	Type FoundFiles As FoundFiles_
	Type PropertyTest As PropertyTest_
	Type PropertyTests As PropertyTests_
	Type FileSearch As FileSearch_
	Type COMAddIn As COMAddIn_
	Type COMAddIns As COMAddIns_
	Type LanguageSettings As LanguageSettings_
	Type ICommandBarsEvents As ICommandBarsEvents_
	Type _CommandBarsEvents As _CommandBarsEvents_
	Type ICommandBarComboBoxEvents As ICommandBarComboBoxEvents_
	Type _CommandBarComboBoxEvents As _CommandBarComboBoxEvents_
	Type ICommandBarButtonEvents As ICommandBarButtonEvents_
	Type _CommandBarButtonEvents As _CommandBarButtonEvents_
	Type WebPageFont As WebPageFont_
	Type WebPageFonts As WebPageFonts_
	Type HTMLProjectItem As HTMLProjectItem_
	Type HTMLProjectItems As HTMLProjectItems_
	Type HTMLProject As HTMLProject_
	Type MsoDebugOptions As MsoDebugOptions_
	Type FileDialogSelectedItems As FileDialogSelectedItems_
	Type FileDialogFilter As FileDialogFilter_
	Type FileDialogFilters As FileDialogFilters_
	Type FileDialog As FileDialog_
	Type SignatureSet As SignatureSet_
	Type Signature As Signature_
	Type IMsoEnvelopeVB As IMsoEnvelopeVB_
	Type IMsoEnvelopeVBEvents As IMsoEnvelopeVBEvents_
	Type FileTypes As FileTypes_
	Type SearchFolders As SearchFolders_
	Type ScopeFolders As ScopeFolders_
	Type ScopeFolder As ScopeFolder_
	Type SearchScope As SearchScope_
	Type SearchScopes As SearchScopes_
	Type IMsoDiagram As IMsoDiagram_
	Type DiagramNodes As DiagramNodes_
	Type DiagramNodeChildren As DiagramNodeChildren_
	Type DiagramNode As DiagramNode_
	Type CanvasShapes As CanvasShapes_
	Type OfficeDataSourceObject As OfficeDataSourceObject_
	Type ODSOColumn As ODSOColumn_
	Type ODSOColumns As ODSOColumns_
	Type ODSOFilter As ODSOFilter_
	Type ODSOFilters As ODSOFilters_
	Type NewFile As NewFile_
	Type WebComponent As WebComponent_
	Type WebComponentWindowExternal As WebComponentWindowExternal_
	Type WebComponentFormat As WebComponentFormat_
	Type ILicWizExternal As ILicWizExternal_
	Type ILicValidator As ILicValidator_
	Type ILicAgent As ILicAgent_
	Type IMsoEServicesDialog As IMsoEServicesDialog_
	Type WebComponentProperties As WebComponentProperties_
	Type SmartDocument As SmartDocument_
	Type SharedWorkspaceMember As SharedWorkspaceMember_
	Type SharedWorkspaceMembers As SharedWorkspaceMembers_
	Type SharedWorkspaceTask As SharedWorkspaceTask_
	Type SharedWorkspaceTasks As SharedWorkspaceTasks_
	Type SharedWorkspaceFile As SharedWorkspaceFile_
	Type SharedWorkspaceFiles As SharedWorkspaceFiles_
	Type SharedWorkspaceFolder As SharedWorkspaceFolder_
	Type SharedWorkspaceFolders As SharedWorkspaceFolders_
	Type SharedWorkspaceLink As SharedWorkspaceLink_
	Type SharedWorkspaceLinks As SharedWorkspaceLinks_
	Type SharedWorkspace As SharedWorkspace_
	Type Sync As Sync_
	Type DocumentLibraryVersion As DocumentLibraryVersion_
	Type DocumentLibraryVersions As DocumentLibraryVersions_
	Type UserPermission As UserPermission_
	Type Permission As Permission_
	Type MsoDebugOptions_UTRunResult As MsoDebugOptions_UTRunResult_
	Type MsoDebugOptions_UT As MsoDebugOptions_UT_
	Type MsoDebugOptions_UTs As MsoDebugOptions_UTs_
	Type MsoDebugOptions_UTManager As MsoDebugOptions_UTManager_
	Type MetaProperty As MetaProperty_
	Type MetaProperties As MetaProperties_
	Type PolicyItem As PolicyItem_
	Type ServerPolicy As ServerPolicy_
	Type DocumentInspector As DocumentInspector_
	Type DocumentInspectors As DocumentInspectors_
	Type WorkflowTask As WorkflowTask_
	Type WorkflowTasks As WorkflowTasks_
	Type WorkflowTemplate As WorkflowTemplate_
	Type WorkflowTemplates As WorkflowTemplates_
	Type SignatureSetup As SignatureSetup_
	Type SignatureInfo As SignatureInfo_
	Type SignatureProvider As SignatureProvider_
	Type CustomXMLPrefixMapping As CustomXMLPrefixMapping_
	Type CustomXMLPrefixMappings As CustomXMLPrefixMappings_
	Type CustomXMLSchema As CustomXMLSchema_
	Type _CustomXMLSchemaCollection As _CustomXMLSchemaCollection_
	Type CustomXMLNodes As CustomXMLNodes_
	Type CustomXMLNode As CustomXMLNode_
	Type CustomXMLValidationError As CustomXMLValidationError_
	Type CustomXMLValidationErrors As CustomXMLValidationErrors_
	Type _CustomXMLPart As _CustomXMLPart_
	Type ICustomXMLPartEvents As ICustomXMLPartEvents_
	Type _CustomXMLPartEvents As _CustomXMLPartEvents_
	Type _CustomXMLParts As _CustomXMLParts_
	Type ICustomXMLPartsEvents As ICustomXMLPartsEvents_
	Type _CustomXMLPartsEvents As _CustomXMLPartsEvents_
	Type GradientStop As GradientStop_
	Type GradientStops As GradientStops_
	Type SoftEdgeFormat As SoftEdgeFormat_
	Type GlowFormat As GlowFormat_
	Type ReflectionFormat As ReflectionFormat_
	Type ParagraphFormat2 As ParagraphFormat2_
	Type Font2 As Font2_
	Type TextColumn2 As TextColumn2_
	Type TextRange2 As TextRange2_
	Type TextFrame2 As TextFrame2_
	Type ThemeColor As ThemeColor_
	Type ThemeColorScheme As ThemeColorScheme_
	Type ThemeFont As ThemeFont_
	Type ThemeFonts As ThemeFonts_
	Type ThemeFontScheme As ThemeFontScheme_
	Type ThemeEffectScheme As ThemeEffectScheme_
	Type OfficeTheme As OfficeTheme_
	Type _CustomTaskPane As _CustomTaskPane_
	Type CustomTaskPaneEvents As CustomTaskPaneEvents_
	Type _CustomTaskPaneEvents As _CustomTaskPaneEvents_
	Type ICTPFactory As ICTPFactory_
	Type ICustomTaskPaneConsumer As ICustomTaskPaneConsumer_
	Type IRibbonUI As IRibbonUI_
	Type IRibbonControl As IRibbonControl_
	Type IRibbonExtensibility As IRibbonExtensibility_
	Type IAssistance As IAssistance_
	Type IMsoChartData As IMsoChartData_
	Type IMsoChart As IMsoChart_
	Type IMsoCorners As IMsoCorners_
	Type IMsoLegend As IMsoLegend_
	Type IMsoBorder As IMsoBorder_
	Type IMsoWalls As IMsoWalls_
	Type IMsoFloor As IMsoFloor_
	Type IMsoPlotArea As IMsoPlotArea_
	Type IMsoChartArea As IMsoChartArea_
	Type IMsoSeriesLines As IMsoSeriesLines_
	Type IMsoLeaderLines As IMsoLeaderLines_
	Type GridLines As GridLines_
	Type IMsoUpBars As IMsoUpBars_
	Type IMsoDownBars As IMsoDownBars_
	Type IMsoInterior As IMsoInterior_
	Type ChartFillFormat As ChartFillFormat_
	Type ChartFont As ChartFont_
	Type Axes As Axes_
	Type IMsoAxis As IMsoAxis_
	Type IMsoDataTable As IMsoDataTable_
	Type IMsoChartTitle As IMsoChartTitle_
	Type IMsoAxisTitle As IMsoAxisTitle_
	Type IMsoDisplayUnitLabel As IMsoDisplayUnitLabel_
	Type IMsoTickLabels As IMsoTickLabels_
	Type IMsoHyperlinks As IMsoHyperlinks_
	Type IMsoDropLines As IMsoDropLines_
	Type IMsoHiLoLines As IMsoHiLoLines_
	Type IMsoChartGroup As IMsoChartGroup_
	Type ChartGroups As ChartGroups_
	Type IMsoCharacters As IMsoCharacters_
	Type IMsoChartFormat As IMsoChartFormat_
	Type BulletFormat2 As BulletFormat2_
	Type TabStops2 As TabStops2_
	Type TabStop2 As TabStop2_
	Type Ruler2 As Ruler2_
	Type RulerLevels2 As RulerLevels2_
	Type RulerLevel2 As RulerLevel2_
	Type EncryptionProvider As EncryptionProvider_
	Type IBlogExtensibility As IBlogExtensibility_
	Type IBlogPictureExtensibility As IBlogPictureExtensibility_
	Type SmartArt As SmartArt_
	Type SmartArtNodes As SmartArtNodes_
	Type SmartArtNode As SmartArtNode_
	Type SmartArtLayouts As SmartArtLayouts_
	Type SmartArtLayout As SmartArtLayout_
	Type SmartArtQuickStyles As SmartArtQuickStyles_
	Type SmartArtQuickStyle As SmartArtQuickStyle_
	Type SmartArtColors As SmartArtColors_
	Type SmartArtColor As SmartArtColor_
	Type PickerField As PickerField_
	Type PickerFields As PickerFields_
	Type PickerProperty As PickerProperty_
	Type PickerProperties As PickerProperties_
	Type PickerResult As PickerResult_
	Type PickerResults As PickerResults_
	Type PickerDialog As PickerDialog_
	Type IMsoContactCard As IMsoContactCard_
	Type EffectParameter As EffectParameter_
	Type EffectParameters As EffectParameters_
	Type PictureEffect As PictureEffect_
	Type PictureEffects As PictureEffects_
	Type Crop As Crop_
	Type ContactCard As ContactCard_

	Type DocumentProperty_ Extends CAIDispatch
		Declare Abstract Function Get_Parent () As IDispatch Ptr
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Name (Byval lcid As Long, Byval pbstrRetVal As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval lcid As Long, Byval pbstrRetVal As BSTR) As HRESULT
		Declare Abstract Function Get_Value (Byval lcid As Long, Byval pvargRetVal As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Value (Byval lcid As Long, Byval pvargRetVal As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval lcid As Long, Byval ptypeRetVal As MsoDocProperties Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval lcid As Long, Byval ptypeRetVal As MsoDocProperties) As HRESULT
		Declare Abstract Function Get_LinkToContent (Byval pfLinkRetVal As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_LinkToContent (Byval pfLinkRetVal As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_LinkSource (Byval pbstrSourceRetVal As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_LinkSource (Byval pbstrSourceRetVal As BSTR) As HRESULT
		Declare Abstract Function Get_Application (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval plCreator As Long Ptr) As HRESULT
	End Type 'DocumentProperty_

	Type DocumentProperties_ Extends CAIDispatch
		Declare Abstract Function Get_Parent () As IDispatch Ptr
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval lcid As Long, Byval ppIDocProp As DocumentProperty Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pc As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval Name As BSTR, Byval LinkToContent As VARIANT_BOOL, Byval Type_v As Variant Ptr, Byval Value As Variant Ptr, Byval LinkSource As Variant Ptr, Byval lcid As Long, Byval ppIDocProp As DocumentProperty Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval plCreator As Long Ptr) As HRESULT
	End Type 'DocumentProperties_

	Type IDocumentInspector_ Extends CAIUnknown
		Declare Abstract Function GetInfo (Byval Name As BSTR Ptr, Byval Desc As BSTR Ptr) As HRESULT
		Declare Abstract Function Inspect (Byval Doc As IDispatch Ptr, Byval Status As MsoDocInspectorStatus Ptr, Byval Result As BSTR Ptr, Byval Action As BSTR Ptr) As HRESULT
		Declare Abstract Function Fix_ (Byval Doc As IDispatch Ptr, Byval hwnd As Long, Byval Status As MsoDocInspectorStatus Ptr, Byval Result As BSTR Ptr) As HRESULT
	End Type 'IDocumentInspector_

	Type LegendEntries_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RHS As LegendEntry Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Variant Ptr, Byval RHS As LegendEntry Ptr Ptr) As HRESULT
	End Type 'LegendEntries_

	Type ChartColorFormat_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SchemeColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_SchemeColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_RGB (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_RGB (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get__Default (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'ChartColorFormat_

	Type LegendEntry_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval RHS As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Index (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Get_LegendKey (Byval RHS As IMsoLegendKey Ptr Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Width (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'LegendEntry_

	Type IMsoLegendKey_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval RHS As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval RHS As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_InvertIfNegative (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_InvertIfNegative (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MarkerBackgroundColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerBackgroundColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerBackgroundColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_MarkerBackgroundColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_MarkerForegroundColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerForegroundColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerForegroundColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_MarkerForegroundColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_MarkerSize (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerSize (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerStyle (Byval RHS As XlMarkerStyle Ptr) As HRESULT
		Declare Abstract Function Let_MarkerStyle (Byval RHS As XlMarkerStyle) As HRESULT
		Declare Abstract Function Get_PictureType (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_PictureType (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_PictureUnit (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit (Byval RHS As Double) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Smooth (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Smooth (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Left (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Width (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_PictureUnit2 (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit2 (Byval RHS As Double) As HRESULT
	End Type 'IMsoLegendKey_

	Type SeriesCollection_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Source As Variant Ptr, Byval Rowcol As XlRowCol, Byval SeriesLabels As Variant Ptr, Byval CategoryLabels As Variant Ptr, Byval Replace As Variant Ptr, Byval RHS As IMsoSeries Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Extend (Byval Source As Variant Ptr, Byval Rowcol As Variant Ptr, Byval CategoryLabels As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RHS As IMsoSeries Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Paste (Byval Rowcol As XlRowCol, Byval SeriesLabels As Variant Ptr, Byval CategoryLabels As Variant Ptr, Byval Replace As Variant Ptr, Byval NewSeries_v As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function NewSeries (Byval RHS As IMsoSeries Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Variant Ptr, Byval RHS As IMsoSeries Ptr Ptr) As HRESULT
	End Type 'SeriesCollection_

	Type IMsoSeries_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function _ApplyDataLabels (Byval Type_v As XlDataLabelsType, Byval IMsoLegendKey As Variant Ptr, Byval AutoText As Variant Ptr, Byval HasLeaderLines As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AxisGroup (Byval RHS As XlAxisGroup Ptr) As HRESULT
		Declare Abstract Function Let_AxisGroup (Byval RHS As XlAxisGroup) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Copy (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function DataLabels (Byval Index As Variant Ptr, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function ErrorBar (Byval Direction As XlErrorBarDirection, Byval Include As XlErrorBarInclude, Byval Type_v As XlErrorBarType, Byval Amount As Variant Ptr, Byval MinusValues As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ErrorBars (Byval RHS As IMsoErrorBars Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Explosion (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Explosion (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_Formula (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Formula (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaLocal (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaLocal (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaR1C1 (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaR1C1 (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaR1C1Local (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaR1C1Local (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_HasDataLabels (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasDataLabels (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasErrorBars (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasErrorBars (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Interior (Byval RHS As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval RHS As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_InvertIfNegative (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_InvertIfNegative (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MarkerBackgroundColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerBackgroundColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerBackgroundColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_MarkerBackgroundColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_MarkerForegroundColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerForegroundColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerForegroundColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_MarkerForegroundColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_MarkerSize (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerSize (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerStyle (Byval RHS As XlMarkerStyle Ptr) As HRESULT
		Declare Abstract Function Let_MarkerStyle (Byval RHS As XlMarkerStyle) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Paste (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PictureType (Byval RHS As XlChartPictureType Ptr) As HRESULT
		Declare Abstract Function Let_PictureType (Byval RHS As XlChartPictureType) As HRESULT
		Declare Abstract Function Get_PictureUnit (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_PlotOrder (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_PlotOrder (Byval RHS As Long) As HRESULT
		Declare Abstract Function Points (Byval Index As Variant Ptr, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Smooth (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Smooth (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Trendlines (Byval Index As Variant Ptr, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_ChartType (Byval RHS As XlChartType Ptr) As HRESULT
		Declare Abstract Function Let_ChartType (Byval RHS As XlChartType) As HRESULT
		Declare Abstract Function ApplyCustomType (Byval ChartType As XlChartType) As HRESULT
		Declare Abstract Function Get_Values (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Values (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_XValues (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_XValues (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_BubbleSizes (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_BubbleSizes (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_BarShape (Byval RHS As XlBarShape Ptr) As HRESULT
		Declare Abstract Function Let_BarShape (Byval RHS As XlBarShape) As HRESULT
		Declare Abstract Function Get_ApplyPictToSides (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ApplyPictToSides (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ApplyPictToFront (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ApplyPictToFront (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ApplyPictToEnd (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ApplyPictToEnd (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Has3DEffect (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Has3DEffect (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Shadow (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasLeaderLines (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasLeaderLines (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_LeaderLines (Byval RHS As IMsoLeaderLines Ptr Ptr) As HRESULT
		Declare Abstract Function ApplyDataLabels (Byval Type_v As XlDataLabelsType, Byval IMsoLegendKey As Variant Ptr, Byval AutoText As Variant Ptr, Byval HasLeaderLines As Variant Ptr, Byval ShowSeriesName As Variant Ptr, Byval ShowCategoryName As Variant Ptr, Byval ShowValue As Variant Ptr, Byval ShowPercentage As Variant Ptr, Byval ShowBubbleSize As Variant Ptr, Byval Separator As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_PictureUnit2 (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit2 (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_PlotColorIndex (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Get_InvertColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_InvertColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_InvertColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_InvertColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_IsFiltered (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_IsFiltered (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ParentDataLabelOption (Byval RHS As XlParentDataLabelOptions Ptr) As HRESULT
		Declare Abstract Function Let_ParentDataLabelOption (Byval RHS As XlParentDataLabelOptions) As HRESULT
		Declare Abstract Function Get_QuartileCalculationInclusiveMedian (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_QuartileCalculationInclusiveMedian (Byval RHS As VARIANT_BOOL) As HRESULT
	End Type 'IMsoSeries_

	Type IMsoErrorBars_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_EndStyle (Byval RHS As XlEndStyleCap Ptr) As HRESULT
		Declare Abstract Function Let_EndStyle (Byval RHS As XlEndStyleCap) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoErrorBars_

	Type IMsoTrendline_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Backward (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Backward (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DataLabel (Byval RHS As IMsoDataLabel Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DisplayEquation (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisplayEquation (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_DisplayRSquared (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisplayRSquared (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Forward (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Forward (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Index (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Get_Intercept (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Intercept (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_InterceptIsAuto (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_InterceptIsAuto (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_NameIsAuto (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_NameIsAuto (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Order (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Order (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_Period (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Period (Byval RHS As Long) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval RHS As XlTrendlineType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval RHS As XlTrendlineType) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Backward2 (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Backward2 (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Forward2 (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Forward2 (Byval RHS As Double) As HRESULT
	End Type 'IMsoTrendline_

	Type Trendlines_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Type_v As XlTrendlineType, Byval Order As Variant Ptr, Byval Period As Variant Ptr, Byval Forward As Variant Ptr, Byval Backward As Variant Ptr, Byval Intercept As Variant Ptr, Byval DisplayEquation As Variant Ptr, Byval DisplayRSquared As Variant Ptr, Byval Name As Variant Ptr, Byval RHS As IMsoTrendline Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RHS As IMsoTrendline Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Variant Ptr, Byval RHS As IMsoTrendline Ptr Ptr) As HRESULT
	End Type 'Trendlines_

	Type IMsoDataLabels_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval RHS As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval RHS As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Characters (Byval Start As Variant Ptr, Byval Length As Variant Ptr, Byval RHS As IMsoCharacters Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval RHS As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HorizontalAlignment (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_HorizontalAlignment (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Orientation (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Orientation (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_VerticalAlignment (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_VerticalAlignment (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ReadingOrder (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_ReadingOrder (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_AutoText (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AutoText (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_NumberFormat (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormat (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_NumberFormatLinked (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormatLinked (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_NumberFormatLocal (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormatLocal (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ShowLegendKey (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowLegendKey (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Type (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Position (Byval RHS As XlDataLabelPosition Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval RHS As XlDataLabelPosition) As HRESULT
		Declare Abstract Function Get_ShowSeriesName (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowSeriesName (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowCategoryName (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowCategoryName (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowValue (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowValue (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowPercentage (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowPercentage (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowBubbleSize (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowBubbleSize (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Separator (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Separator (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RHS As IMsoDataLabel Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Variant Ptr, Byval RHS As IMsoDataLabel Ptr Ptr) As HRESULT
		Declare Abstract Function Propagate (Byval Index As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ShowRange (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowRange (Byval RHS As VARIANT_BOOL) As HRESULT
	End Type 'IMsoDataLabels_

	Type IMsoDataLabel_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval RHS As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval RHS As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Caption (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Caption (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_Characters (Byval Start As Variant Ptr, Byval Length As Variant Ptr, Byval RHS As IMsoCharacters Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval RHS As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HorizontalAlignment (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_HorizontalAlignment (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Orientation (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Orientation (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Text (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_Top (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_VerticalAlignment (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_VerticalAlignment (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ReadingOrder (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_ReadingOrder (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_AutoText (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AutoText (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_NumberFormat (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormat (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_NumberFormatLinked (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormatLinked (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_NumberFormatLocal (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormatLocal (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ShowLegendKey (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowLegendKey (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Type (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Position (Byval RHS As XlDataLabelPosition Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval RHS As XlDataLabelPosition) As HRESULT
		Declare Abstract Function Get_ShowSeriesName (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowSeriesName (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowCategoryName (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowCategoryName (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowValue (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowValue (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowPercentage (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowPercentage (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowBubbleSize (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowBubbleSize (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Separator (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Separator (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get__Height (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Width (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_Formula (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Formula (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaR1C1 (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaR1C1 (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaLocal (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaLocal (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaR1C1Local (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaR1C1Local (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ShowRange (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowRange (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Height (Byval pHeight As Double Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval pHeight As Double) As HRESULT
		Declare Abstract Function Get_Width (Byval pWidth As Double Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval pWidth As Double) As HRESULT
	End Type 'IMsoDataLabel_

	Type Points_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Long, Byval RHS As ChartPoint Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Long, Byval RHS As ChartPoint Ptr Ptr) As HRESULT
	End Type 'Points_

	Type ChartPoint_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function _ApplyDataLabels (Byval Type_v As XlDataLabelsType, Byval IMsoLegendKey As Variant Ptr, Byval AutoText As Variant Ptr, Byval HasLeaderLines As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Copy (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DataLabel (Byval RHS As IMsoDataLabel Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Explosion (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Explosion (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_HasDataLabel (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasDataLabel (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Interior (Byval RHS As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_InvertIfNegative (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_InvertIfNegative (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MarkerBackgroundColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerBackgroundColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerBackgroundColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_MarkerBackgroundColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_MarkerForegroundColor (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerForegroundColor (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerForegroundColorIndex (Byval RHS As XlColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_MarkerForegroundColorIndex (Byval RHS As XlColorIndex) As HRESULT
		Declare Abstract Function Get_MarkerSize (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_MarkerSize (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_MarkerStyle (Byval RHS As XlMarkerStyle Ptr) As HRESULT
		Declare Abstract Function Let_MarkerStyle (Byval RHS As XlMarkerStyle) As HRESULT
		Declare Abstract Function Paste (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PictureType (Byval RHS As XlChartPictureType Ptr) As HRESULT
		Declare Abstract Function Let_PictureType (Byval RHS As XlChartPictureType) As HRESULT
		Declare Abstract Function Get_PictureUnit (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit (Byval RHS As Double) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ApplyPictToSides (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ApplyPictToSides (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ApplyPictToFront (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ApplyPictToFront (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ApplyPictToEnd (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ApplyPictToEnd (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Shadow (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_SecondaryPlot (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_SecondaryPlot (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Fill (Byval RHS As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function ApplyDataLabels (Byval Type_v As XlDataLabelsType, Byval IMsoLegendKey As Variant Ptr, Byval AutoText As Variant Ptr, Byval HasLeaderLines As Variant Ptr, Byval ShowSeriesName As Variant Ptr, Byval ShowCategoryName As Variant Ptr, Byval ShowValue As Variant Ptr, Byval ShowPercentage As Variant Ptr, Byval ShowBubbleSize As Variant Ptr, Byval Separator As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Has3DEffect (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Has3DEffect (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_PictureUnit2 (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit2 (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Width (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function PieSliceLocation (Byval loc As XlPieSliceLocation, Byval Index As XlPieSliceIndex, Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_IsTotal (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_IsTotal (Byval pval As VARIANT_BOOL) As HRESULT
	End Type 'ChartPoint_

	Type IConverterPreferences_ Extends CAIUnknown
		Declare Abstract Function HrGetMacroEnabled (Byval pfMacroEnabled As Long Ptr) As HRESULT
		Declare Abstract Function HrCheckFormat (Byval pFormat As Long Ptr) As HRESULT
		Declare Abstract Function HrGetLossySave (Byval pfLossySave As Long Ptr) As HRESULT
	End Type 'IConverterPreferences_

	Type IConverterApplicationPreferences_ Extends CAIUnknown
		Declare Abstract Function HrGetLcid (Byval plcid As ULong Ptr) As HRESULT
		Declare Abstract Function HrGetHwnd (Byval phwnd As Long Ptr) As HRESULT
		Declare Abstract Function HrGetApplication (Byval pbstrApplication As BSTR Ptr) As HRESULT
		Declare Abstract Function HrCheckFormat (Byval pFormat As Long Ptr) As HRESULT
	End Type 'IConverterApplicationPreferences_

	Type IConverterUICallback_ Extends CAIUnknown
		Declare Abstract Function HrReportProgress (Byval uPercentComplete As ULong) As HRESULT
		Declare Abstract Function HrMessageBox (Byval bstrText As BSTR, Byval bstrCaption As BSTR, Byval uType As ULong, Byval pidResult As Long Ptr) As HRESULT
		Declare Abstract Function HrInputBox (Byval bstrText As BSTR, Byval bstrCaption As BSTR, Byval pbstrInput As BSTR Ptr, Byval fPassword As Long) As HRESULT
	End Type 'IConverterUICallback_

	Type IConverter_ Extends CAIUnknown
		Declare Abstract Function HrInitConverter (Byval pcap As IConverterApplicationPreferences Ptr, Byval ppcp As IConverterPreferences Ptr Ptr, Byval pcuic As IConverterUICallback Ptr) As HRESULT
		Declare Abstract Function HrUninitConverter (Byval pcuic As IConverterUICallback Ptr) As HRESULT
		Declare Abstract Function HrImport (Byval bstrSourcePath As BSTR, Byval bstrDestPath As BSTR, Byval pcap As IConverterApplicationPreferences Ptr, Byval ppcp As IConverterPreferences Ptr Ptr, Byval pcuic As IConverterUICallback Ptr) As HRESULT
		Declare Abstract Function HrExport (Byval bstrSourcePath As BSTR, Byval bstrDestPath As BSTR, Byval bstrClass As BSTR, Byval pcap As IConverterApplicationPreferences Ptr, Byval ppcp As IConverterPreferences Ptr Ptr, Byval pcuic As IConverterUICallback Ptr) As HRESULT
		Declare Abstract Function HrGetFormat (Byval bstrPath As BSTR, Byval pbstrClass As BSTR Ptr, Byval pcap As IConverterApplicationPreferences Ptr, Byval ppcp As IConverterPreferences Ptr Ptr, Byval pcuic As IConverterUICallback Ptr) As HRESULT
		Declare Abstract Function HrGetErrorString (Byval hrErr As Long, Byval pbstrErrorMsg As BSTR Ptr, Byval pcap As IConverterApplicationPreferences Ptr) As HRESULT
	End Type 'IConverter_

	Type FullSeriesCollection_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RHS As IMsoSeries Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Variant Ptr, Byval RHS As IMsoSeries Ptr Ptr) As HRESULT
	End Type 'FullSeriesCollection_

	Type IMsoCategory_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_IsFiltered (Byval pfIsFiltered As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_IsFiltered (Byval pfIsFiltered As VARIANT_BOOL) As HRESULT
	End Type 'IMsoCategory_

	Type CategoryCollection_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval cCategory As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval ppcategory As IMsoCategory Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Index As Variant Ptr, Byval RHS As IMsoCategory Ptr Ptr) As HRESULT
	End Type 'CategoryCollection_

	Type IAccessible_ Extends CAIDispatch
		Declare Abstract Function Get_accParent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_accChildCount (Byval pcountChildren As Long Ptr) As HRESULT
		Declare Abstract Function Get_accChild (Byval varChild As Variant Ptr, Byval ppdispChild As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_accName (Byval varChild As Variant Ptr, Byval pszName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_accValue (Byval varChild As Variant Ptr, Byval pszValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_accDescription (Byval varChild As Variant Ptr, Byval pszDescription As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_accRole (Byval varChild As Variant Ptr, Byval pvarRole As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_accState (Byval varChild As Variant Ptr, Byval pvarState As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_accHelp (Byval varChild As Variant Ptr, Byval pszHelp As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_accHelpTopic (Byval pszHelpFile As BSTR Ptr, Byval varChild As Variant Ptr, Byval pidTopic As Long Ptr) As HRESULT
		Declare Abstract Function Get_accKeyboardShortcut (Byval varChild As Variant Ptr, Byval pszKeyboardShortcut As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_accFocus (Byval pvarChild As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_accSelection (Byval pvarChildren As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_accDefaultAction (Byval varChild As Variant Ptr, Byval pszDefaultAction As BSTR Ptr) As HRESULT
		Declare Abstract Function accSelect (Byval flagsSelect As Long, Byval varChild As Variant Ptr) As HRESULT
		Declare Abstract Function accLocation (Byval pxLeft As Long Ptr, Byval pyTop As Long Ptr, Byval pcxWidth As Long Ptr, Byval pcyHeight As Long Ptr, Byval varChild As Variant Ptr) As HRESULT
		Declare Abstract Function accNavigate (Byval navDir As Long, Byval varStart As Variant Ptr, Byval pvarEndUpAt As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function accHitTest (Byval xLeft As Long, Byval yTop As Long, Byval pvarChild As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function accDoDefaultAction (Byval varChild As Variant Ptr) As HRESULT
		Declare Abstract Function Let_accName (Byval varChild As Variant Ptr, Byval pszName As BSTR) As HRESULT
		Declare Abstract Function Let_accValue (Byval varChild As Variant Ptr, Byval pszValue As BSTR) As HRESULT
	End Type 'IAccessible_

	Type _IMsoDispObj_ Extends CAIDispatch
		Declare Abstract Function Get_Application (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval plCreator As Long Ptr) As HRESULT
	End Type '_IMsoDispObj_

	Type _IMsoOleAccDispObj_ Extends IAccessible
		Declare Abstract Function Get_Application (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval plCreator As Long Ptr) As HRESULT
	End Type '_IMsoOleAccDispObj_

	Type _CommandBars_ Extends _IMsoDispObj
		Declare Abstract Function Get_ActionControl (Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ActiveMenuBar (Byval ppcb As CommandBar Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Name As Variant Ptr, Byval Position As Variant Ptr, Byval MenuBar As Variant Ptr, Byval Temporary As Variant Ptr, Byval ppcb As CommandBar Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcToolbars As Long Ptr) As HRESULT
		Declare Abstract Function Get_DisplayTooltips (Byval pvarfDisplayTooltips As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisplayTooltips (Byval pvarfDisplayTooltips As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_DisplayKeysInTooltips (Byval pvarfDisplayKeys As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisplayKeysInTooltips (Byval pvarfDisplayKeys As VARIANT_BOOL) As HRESULT
		Declare Abstract Function FindControl (Byval Type_v As Variant Ptr, Byval Id As Variant Ptr, Byval Tag As Variant Ptr, Byval Visible As Variant Ptr, Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval ppcb As CommandBar Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LargeButtons (Byval pvarfLargeButtons As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_LargeButtons (Byval pvarfLargeButtons As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MenuAnimationStyle (Byval pma As MsoMenuAnimation Ptr) As HRESULT
		Declare Abstract Function Let_MenuAnimationStyle (Byval pma As MsoMenuAnimation) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function ReleaseFocus () As HRESULT
		Declare Abstract Function Get_IdsString (Byval ids As Long, Byval pbstrName As BSTR Ptr, Byval pcch As Long Ptr) As HRESULT
		Declare Abstract Function Get_TmcGetName (Byval tmc As Long, Byval pbstrName As BSTR Ptr, Byval pcch As Long Ptr) As HRESULT
		Declare Abstract Function Get_AdaptiveMenus (Byval pvarfAdaptiveMenus As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AdaptiveMenus (Byval pvarfAdaptiveMenus As VARIANT_BOOL) As HRESULT
		Declare Abstract Function FindControls (Byval Type_v As Variant Ptr, Byval Id As Variant Ptr, Byval Tag As Variant Ptr, Byval Visible As Variant Ptr, Byval ppcbcs As CommandBarControls Ptr Ptr) As HRESULT
		Declare Abstract Function AddEx (Byval TbidOrName As Variant Ptr, Byval Position As Variant Ptr, Byval MenuBar As Variant Ptr, Byval Temporary As Variant Ptr, Byval TbtrProtection As Variant Ptr, Byval ppcb As CommandBar Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DisplayFonts (Byval pvarfDisplayFonts As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisplayFonts (Byval pvarfDisplayFonts As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_DisableCustomize (Byval pvarfDisableCustomize As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisableCustomize (Byval pvarfDisableCustomize As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_DisableAskAQuestionDropdown (Byval pvarfDisableAskAQuestionDropdown As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_DisableAskAQuestionDropdown (Byval pvarfDisableAskAQuestionDropdown As VARIANT_BOOL) As HRESULT
		Declare Abstract Function ExecuteMso (Byval idMso As BSTR) As HRESULT
		Declare Abstract Function GetEnabledMso (Byval idMso As BSTR, Byval Enabled As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function GetVisibleMso (Byval idMso As BSTR, Byval Visible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function GetPressedMso (Byval idMso As BSTR, Byval Pressed As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function GetLabelMso (Byval idMso As BSTR, Byval Label As BSTR Ptr) As HRESULT
		Declare Abstract Function GetScreentipMso (Byval idMso As BSTR, Byval Screentip As BSTR Ptr) As HRESULT
		Declare Abstract Function GetSupertipMso (Byval idMso As BSTR, Byval Supertip As BSTR Ptr) As HRESULT
		Declare Abstract Function GetImageMso (Byval idMso As BSTR, Byval Width As Long, Byval Height As Long, Byval Image As stdole.Picture Ptr Ptr) As HRESULT
		Declare Abstract Function CommitRenderingTransaction (Byval hwnd As Long) As HRESULT
	End Type '_CommandBars_

	Type CommandBar_ Extends _IMsoOleAccDispObj
		Declare Abstract Function Get_BuiltIn (Byval pvarfBuiltIn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Context (Byval pbstrContext As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Context (Byval pbstrContext As BSTR) As HRESULT
		Declare Abstract Function Get_Controls (Byval ppcbcs As CommandBarControls Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Enabled (Byval pvarfEnabled As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Enabled (Byval pvarfEnabled As VARIANT_BOOL) As HRESULT
		Declare Abstract Function FindControl (Byval Type_v As Variant Ptr, Byval Id As Variant Ptr, Byval Tag As Variant Ptr, Byval Visible As Variant Ptr, Byval Recursive As Variant Ptr, Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pdy As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval pdy As Long) As HRESULT
		Declare Abstract Function Get_Index (Byval pi As Long Ptr) As HRESULT
		Declare Abstract Function Get_InstanceId (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval pxpLeft As Long Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval pxpLeft As Long) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval pbstrName As BSTR) As HRESULT
		Declare Abstract Function Get_NameLocal (Byval pbstrNameLocal As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NameLocal (Byval pbstrNameLocal As BSTR) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Position (Byval ppos As MsoBarPosition Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval ppos As MsoBarPosition) As HRESULT
		Declare Abstract Function Get_RowIndex (Byval piRow As Long Ptr) As HRESULT
		Declare Abstract Function Let_RowIndex (Byval piRow As Long) As HRESULT
		Declare Abstract Function Get_Protection (Byval pprot As MsoBarProtection Ptr) As HRESULT
		Declare Abstract Function Let_Protection (Byval pprot As MsoBarProtection) As HRESULT
		Declare Abstract Function Reset () As HRESULT
		Declare Abstract Function ShowPopup (Byval x As Variant Ptr, Byval y As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval pypTop As Long Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval pypTop As Long) As HRESULT
		Declare Abstract Function Get_Type (Byval ptype As MsoBarType Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval pvarfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval pvarfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Width (Byval pdx As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval pdx As Long) As HRESULT
		Declare Abstract Function Get_AdaptiveMenu (Byval pvarfAdaptiveMenu As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AdaptiveMenu (Byval pvarfAdaptiveMenu As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Id (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function Get_InstanceIdPtr (Byval pvarPitb As Variant Ptr Ptr) As HRESULT
	End Type 'CommandBar_

	Type CommandBarControls_ Extends _IMsoDispObj
		Declare Abstract Function Add (Byval Type_v As Variant Ptr, Byval Id As Variant Ptr, Byval Parameter As Variant Ptr, Byval Before As Variant Ptr, Byval Temporary As Variant Ptr, Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcToolbarControls As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppcb As CommandBar Ptr Ptr) As HRESULT
	End Type 'CommandBarControls_

	Type CommandBarControl_ Extends _IMsoOleAccDispObj
		Declare Abstract Function Get_BeginGroup (Byval pvarfBeginGroup As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_BeginGroup (Byval pvarfBeginGroup As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_BuiltIn (Byval pvarfBuiltIn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Caption (Byval pbstrCaption As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Caption (Byval pbstrCaption As BSTR) As HRESULT
		Declare Abstract Function Get_Control (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Copy (Byval Bar As Variant Ptr, Byval Before As Variant Ptr, Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval Temporary As Variant Ptr) As HRESULT
		Declare Abstract Function Get_DescriptionText (Byval pbstrText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_DescriptionText (Byval pbstrText As BSTR) As HRESULT
		Declare Abstract Function Get_Enabled (Byval pvarfEnabled As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Enabled (Byval pvarfEnabled As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Execute () As HRESULT
		Declare Abstract Function Get_Height (Byval pdy As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval pdy As Long) As HRESULT
		Declare Abstract Function Get_HelpContextId (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function Let_HelpContextId (Byval pid As Long) As HRESULT
		Declare Abstract Function Get_HelpFile (Byval pbstrFilename As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_HelpFile (Byval pbstrFilename As BSTR) As HRESULT
		Declare Abstract Function Get_Id (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function Get_Index (Byval pi As Long Ptr) As HRESULT
		Declare Abstract Function Get_InstanceId (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function Move (Byval Bar As Variant Ptr, Byval Before As Variant Ptr, Byval ppcbc As CommandBarControl Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval px As Long Ptr) As HRESULT
		Declare Abstract Function Get_OLEUsage (Byval pcou As MsoControlOLEUsage Ptr) As HRESULT
		Declare Abstract Function Let_OLEUsage (Byval pcou As MsoControlOLEUsage) As HRESULT
		Declare Abstract Function Get_OnAction (Byval pbstrOnAction As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_OnAction (Byval pbstrOnAction As BSTR) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppcb As CommandBar Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parameter (Byval pbstrParam As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Parameter (Byval pbstrParam As BSTR) As HRESULT
		Declare Abstract Function Get_Priority (Byval pnPri As Long Ptr) As HRESULT
		Declare Abstract Function Let_Priority (Byval pnPri As Long) As HRESULT
		Declare Abstract Function Reset () As HRESULT
		Declare Abstract Function SetFocus () As HRESULT
		Declare Abstract Function Get_Tag (Byval pbstrTag As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Tag (Byval pbstrTag As BSTR) As HRESULT
		Declare Abstract Function Get_TooltipText (Byval pbstrTooltip As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_TooltipText (Byval pbstrTooltip As BSTR) As HRESULT
		Declare Abstract Function Get_Top (Byval py As Long Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval ptype As MsoControlType Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval pvarfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval pvarfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Width (Byval pdx As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval pdx As Long) As HRESULT
		Declare Abstract Function Get_IsPriorityDropped (Byval pvarfDropped As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Reserved1 () As HRESULT
		Declare Abstract Function Reserved2 () As HRESULT
		Declare Abstract Function Reserved3 () As HRESULT
		Declare Abstract Function Reserved4 () As HRESULT
		Declare Abstract Function Reserved5 () As HRESULT
		Declare Abstract Function Reserved6 () As HRESULT
		Declare Abstract Function Reserved7 () As HRESULT
	End Type 'CommandBarControl_

	Type _CommandBarButton_ Extends CommandBarControl
		Declare Abstract Function Get_BuiltInFace (Byval pvarfBuiltIn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_BuiltInFace (Byval pvarfBuiltIn As VARIANT_BOOL) As HRESULT
		Declare Abstract Function CopyFace () As HRESULT
		Declare Abstract Function Get_FaceId (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function Let_FaceId (Byval pid As Long) As HRESULT
		Declare Abstract Function PasteFace () As HRESULT
		Declare Abstract Function Get_ShortcutText (Byval pbstrText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_ShortcutText (Byval pbstrText As BSTR) As HRESULT
		Declare Abstract Function Get_State (Byval pstate As MsoButtonState Ptr) As HRESULT
		Declare Abstract Function Let_State (Byval pstate As MsoButtonState) As HRESULT
		Declare Abstract Function Get_Style (Byval pstyle As MsoButtonStyle Ptr) As HRESULT
		Declare Abstract Function Let_Style (Byval pstyle As MsoButtonStyle) As HRESULT
		Declare Abstract Function Get_HyperlinkType (Byval phlType As MsoCommandBarButtonHyperlinkType Ptr) As HRESULT
		Declare Abstract Function Let_HyperlinkType (Byval phlType As MsoCommandBarButtonHyperlinkType) As HRESULT
		Declare Abstract Function Get_Picture (Byval ppdispPicture As stdole.Picture Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Picture (Byval ppdispPicture As stdole.Picture Ptr) As HRESULT
		Declare Abstract Function Get_Mask (Byval ppipictdispMask As stdole.Picture Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Mask (Byval ppipictdispMask As stdole.Picture Ptr) As HRESULT
		Declare Abstract Function Get_InstanceIdPtr (Byval pvarPic As Variant Ptr Ptr) As HRESULT
	End Type '_CommandBarButton_

	Type CommandBarPopup_ Extends CommandBarControl
		Declare Abstract Function Get_CommandBar (Byval ppcb As CommandBar Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Controls (Byval ppcbcs As CommandBarControls Ptr Ptr) As HRESULT
		Declare Abstract Function Get_OLEMenuGroup (Byval pomg As MsoOLEMenuGroup Ptr) As HRESULT
		Declare Abstract Function Let_OLEMenuGroup (Byval pomg As MsoOLEMenuGroup) As HRESULT
		Declare Abstract Function Get_InstanceIdPtr (Byval pvarPic As Variant Ptr Ptr) As HRESULT
	End Type 'CommandBarPopup_

	Type _CommandBarComboBox_ Extends CommandBarControl
		Declare Abstract Function AddItem (Byval Text As BSTR, Byval Index As Variant Ptr) As HRESULT
		Declare Abstract Function Clear () As HRESULT
		Declare Abstract Function Get_DropDownLines (Byval pcLines As Long Ptr) As HRESULT
		Declare Abstract Function Let_DropDownLines (Byval pcLines As Long) As HRESULT
		Declare Abstract Function Get_DropDownWidth (Byval pdx As Long Ptr) As HRESULT
		Declare Abstract Function Let_DropDownWidth (Byval pdx As Long) As HRESULT
		Declare Abstract Function Get_List (Byval Index As Long, Byval pbstrItem As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_List (Byval Index As Long, Byval pbstrItem As BSTR) As HRESULT
		Declare Abstract Function Get_ListCount (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Get_ListHeaderCount (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Let_ListHeaderCount (Byval pcItems As Long) As HRESULT
		Declare Abstract Function Get_ListIndex (Byval pi As Long Ptr) As HRESULT
		Declare Abstract Function Let_ListIndex (Byval pi As Long) As HRESULT
		Declare Abstract Function RemoveItem (Byval Index As Long) As HRESULT
		Declare Abstract Function Get_Style (Byval pstyle As MsoComboStyle Ptr) As HRESULT
		Declare Abstract Function Let_Style (Byval pstyle As MsoComboStyle) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstrText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstrText As BSTR) As HRESULT
		Declare Abstract Function Get_InstanceIdPtr (Byval pvarPic As Variant Ptr Ptr) As HRESULT
	End Type '_CommandBarComboBox_

	Type _CommandBarActiveX_ Extends CommandBarControl
		Declare Abstract Function Get_ControlCLSID (Byval pbstrClsid As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_ControlCLSID (Byval pbstrClsid As BSTR) As HRESULT
		Declare Abstract Function Get_QueryControlInterface (Byval bstrIid As BSTR, Byval ppUnk As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function SetInnerObjectFactory (Byval pUnk As IUnknown Ptr) As HRESULT
		Declare Abstract Function EnsureControl () As HRESULT
		Declare Abstract Function Let_InitWith (Byval RHS As IUnknown Ptr) As HRESULT
		Declare Abstract Function Get_InstanceIdPtr (Byval pvarPic As Variant Ptr Ptr) As HRESULT
	End Type '_CommandBarActiveX_

	Type Adjustments_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval Val As Single Ptr) As HRESULT
		Declare Abstract Function Let_Item (Byval Index As Long, Byval Val As Single) As HRESULT
	End Type 'Adjustments_

	Type CalloutFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function AutomaticLength () As HRESULT
		Declare Abstract Function CustomDrop (Byval Drop As Single) As HRESULT
		Declare Abstract Function CustomLength (Byval Length As Single) As HRESULT
		Declare Abstract Function PresetDrop (Byval DropType As MsoCalloutDropType) As HRESULT
		Declare Abstract Function Get_Accent (Byval Accent As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Accent (Byval Accent As MsoTriState) As HRESULT
		Declare Abstract Function Get_Angle (Byval Angle As MsoCalloutAngleType Ptr) As HRESULT
		Declare Abstract Function Let_Angle (Byval Angle As MsoCalloutAngleType) As HRESULT
		Declare Abstract Function Get_AutoAttach (Byval AutoAttach As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_AutoAttach (Byval AutoAttach As MsoTriState) As HRESULT
		Declare Abstract Function Get_AutoLength (Byval AutoLength As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval Border As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Border (Byval Border As MsoTriState) As HRESULT
		Declare Abstract Function Get_Drop (Byval Drop As Single Ptr) As HRESULT
		Declare Abstract Function Get_DropType (Byval DropType As MsoCalloutDropType Ptr) As HRESULT
		Declare Abstract Function Get_Gap (Byval Gap As Single Ptr) As HRESULT
		Declare Abstract Function Let_Gap (Byval Gap As Single) As HRESULT
		Declare Abstract Function Get_Length (Byval Length As Single Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoCalloutType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoCalloutType) As HRESULT
	End Type 'CalloutFormat_

	Type ColorFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_RGB (Byval RGB_v As Long Ptr) As HRESULT
		Declare Abstract Function Let_RGB (Byval RGB_v As Long) As HRESULT
		Declare Abstract Function Get_SchemeColor (Byval SchemeColor As Long Ptr) As HRESULT
		Declare Abstract Function Let_SchemeColor (Byval SchemeColor As Long) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoColorType Ptr) As HRESULT
		Declare Abstract Function Get_TintAndShade (Byval pValue As Single Ptr) As HRESULT
		Declare Abstract Function Let_TintAndShade (Byval pValue As Single) As HRESULT
		Declare Abstract Function Get_ObjectThemeColor (Byval ObjectThemeColor As MsoThemeColorIndex Ptr) As HRESULT
		Declare Abstract Function Let_ObjectThemeColor (Byval ObjectThemeColor As MsoThemeColorIndex) As HRESULT
		Declare Abstract Function Get_Brightness (Byval Brightness As Single Ptr) As HRESULT
		Declare Abstract Function Let_Brightness (Byval Brightness As Single) As HRESULT
	End Type 'ColorFormat_

	Type ConnectorFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function BeginConnect (Byval ConnectedShape As Shape Ptr, Byval ConnectionSite As Long) As HRESULT
		Declare Abstract Function BeginDisconnect () As HRESULT
		Declare Abstract Function EndConnect (Byval ConnectedShape As Shape Ptr, Byval ConnectionSite As Long) As HRESULT
		Declare Abstract Function EndDisconnect () As HRESULT
		Declare Abstract Function Get_BeginConnected (Byval BeginConnected As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_BeginConnectedShape (Byval BeginConnectedShape As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BeginConnectionSite (Byval BeginConnectionSite As Long Ptr) As HRESULT
		Declare Abstract Function Get_EndConnected (Byval EndConnected As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_EndConnectedShape (Byval EndConnectedShape As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get_EndConnectionSite (Byval EndConnectionSite As Long Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoConnectorType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoConnectorType) As HRESULT
	End Type 'ConnectorFormat_

	Type FillFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Background () As HRESULT
		Declare Abstract Function OneColorGradient (Byval Style As MsoGradientStyle, Byval Variant As Long, Byval Degree As Single) As HRESULT
		Declare Abstract Function Patterned (Byval Pattern As MsoPatternType) As HRESULT
		Declare Abstract Function PresetGradient (Byval Style As MsoGradientStyle, Byval Variant As Long, Byval PresetGradientType As MsoPresetGradientType) As HRESULT
		Declare Abstract Function PresetTextured (Byval PresetTexture As MsoPresetTexture) As HRESULT
		Declare Abstract Function Solid () As HRESULT
		Declare Abstract Function TwoColorGradient (Byval Style As MsoGradientStyle, Byval Variant As Long) As HRESULT
		Declare Abstract Function UserPicture (Byval PictureFile As BSTR) As HRESULT
		Declare Abstract Function UserTextured (Byval TextureFile As BSTR) As HRESULT
		Declare Abstract Function Get_BackColor (Byval BackColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Let_BackColor (Byval BackColor As ColorFormat Ptr) As HRESULT
		Declare Abstract Function Get_ForeColor (Byval ForeColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ForeColor (Byval ForeColor As ColorFormat Ptr) As HRESULT
		Declare Abstract Function Get_GradientColorType (Byval GradientColorType As MsoGradientColorType Ptr) As HRESULT
		Declare Abstract Function Get_GradientDegree (Byval GradientDegree As Single Ptr) As HRESULT
		Declare Abstract Function Get_GradientStyle (Byval GradientStyle As MsoGradientStyle Ptr) As HRESULT
		Declare Abstract Function Get_GradientVariant (Byval GradientVariant As Long Ptr) As HRESULT
		Declare Abstract Function Get_Pattern (Byval Pattern As MsoPatternType Ptr) As HRESULT
		Declare Abstract Function Get_PresetGradientType (Byval PresetGradientType As MsoPresetGradientType Ptr) As HRESULT
		Declare Abstract Function Get_PresetTexture (Byval PresetTexture As MsoPresetTexture Ptr) As HRESULT
		Declare Abstract Function Get_TextureName (Byval TextureName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_TextureType (Byval TextureType As MsoTextureType Ptr) As HRESULT
		Declare Abstract Function Get_Transparency (Byval Transparency As Single Ptr) As HRESULT
		Declare Abstract Function Let_Transparency (Byval Transparency As Single) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoFillType Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function Get_GradientStops (Byval GradientStops As GradientStops Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextureOffsetX (Byval TextureOffsetX As Single Ptr) As HRESULT
		Declare Abstract Function Let_TextureOffsetX (Byval TextureOffsetX As Single) As HRESULT
		Declare Abstract Function Get_TextureOffsetY (Byval TextureOffsetY As Single Ptr) As HRESULT
		Declare Abstract Function Let_TextureOffsetY (Byval TextureOffsetY As Single) As HRESULT
		Declare Abstract Function Get_TextureAlignment (Byval TextureAlignment As MsoTextureAlignment Ptr) As HRESULT
		Declare Abstract Function Let_TextureAlignment (Byval TextureAlignment As MsoTextureAlignment) As HRESULT
		Declare Abstract Function Get_TextureHorizontalScale (Byval HorizontalScale As Single Ptr) As HRESULT
		Declare Abstract Function Let_TextureHorizontalScale (Byval HorizontalScale As Single) As HRESULT
		Declare Abstract Function Get_TextureVerticalScale (Byval VerticalScale As Single Ptr) As HRESULT
		Declare Abstract Function Let_TextureVerticalScale (Byval VerticalScale As Single) As HRESULT
		Declare Abstract Function Get_TextureTile (Byval TextureTile As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_TextureTile (Byval TextureTile As MsoTriState) As HRESULT
		Declare Abstract Function Get_RotateWithObject (Byval RotateWithObject As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_RotateWithObject (Byval RotateWithObject As MsoTriState) As HRESULT
		Declare Abstract Function Get_PictureEffects (Byval PictureEffects As PictureEffects Ptr Ptr) As HRESULT
		Declare Abstract Function Get_GradientAngle (Byval GradientAngle As Single Ptr) As HRESULT
		Declare Abstract Function Let_GradientAngle (Byval GradientAngle As Single) As HRESULT
	End Type 'FillFormat_

	Type FreeformBuilder_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function AddNodes (Byval SegmentType As MsoSegmentType, Byval EditingType As MsoEditingType, Byval X1 As Single, Byval Y1 As Single, Byval X2 As Single, Byval Y2 As Single, Byval X3 As Single, Byval Y3 As Single) As HRESULT
		Declare Abstract Function ConvertToShape (Byval Freeform As Shape Ptr Ptr) As HRESULT
	End Type 'FreeformBuilder_

	Type GroupShapes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pnShapes As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Range (Byval Index As Variant Ptr, Byval Range_v As ShapeRange Ptr Ptr) As HRESULT
	End Type 'GroupShapes_

	Type LineFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BackColor (Byval BackColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Let_BackColor (Byval BackColor As ColorFormat Ptr) As HRESULT
		Declare Abstract Function Get_BeginArrowheadLength (Byval BeginArrowheadLength As MsoArrowheadLength Ptr) As HRESULT
		Declare Abstract Function Let_BeginArrowheadLength (Byval BeginArrowheadLength As MsoArrowheadLength) As HRESULT
		Declare Abstract Function Get_BeginArrowheadStyle (Byval BeginArrowheadStyle As MsoArrowheadStyle Ptr) As HRESULT
		Declare Abstract Function Let_BeginArrowheadStyle (Byval BeginArrowheadStyle As MsoArrowheadStyle) As HRESULT
		Declare Abstract Function Get_BeginArrowheadWidth (Byval BeginArrowheadWidth As MsoArrowheadWidth Ptr) As HRESULT
		Declare Abstract Function Let_BeginArrowheadWidth (Byval BeginArrowheadWidth As MsoArrowheadWidth) As HRESULT
		Declare Abstract Function Get_DashStyle (Byval DashStyle As MsoLineDashStyle Ptr) As HRESULT
		Declare Abstract Function Let_DashStyle (Byval DashStyle As MsoLineDashStyle) As HRESULT
		Declare Abstract Function Get_EndArrowheadLength (Byval EndArrowheadLength As MsoArrowheadLength Ptr) As HRESULT
		Declare Abstract Function Let_EndArrowheadLength (Byval EndArrowheadLength As MsoArrowheadLength) As HRESULT
		Declare Abstract Function Get_EndArrowheadStyle (Byval EndArrowheadStyle As MsoArrowheadStyle Ptr) As HRESULT
		Declare Abstract Function Let_EndArrowheadStyle (Byval EndArrowheadStyle As MsoArrowheadStyle) As HRESULT
		Declare Abstract Function Get_EndArrowheadWidth (Byval EndArrowheadWidth As MsoArrowheadWidth Ptr) As HRESULT
		Declare Abstract Function Let_EndArrowheadWidth (Byval EndArrowheadWidth As MsoArrowheadWidth) As HRESULT
		Declare Abstract Function Get_ForeColor (Byval ForeColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ForeColor (Byval ForeColor As ColorFormat Ptr) As HRESULT
		Declare Abstract Function Get_Pattern (Byval Pattern As MsoPatternType Ptr) As HRESULT
		Declare Abstract Function Let_Pattern (Byval Pattern As MsoPatternType) As HRESULT
		Declare Abstract Function Get_Style (Byval Style As MsoLineStyle Ptr) As HRESULT
		Declare Abstract Function Let_Style (Byval Style As MsoLineStyle) As HRESULT
		Declare Abstract Function Get_Transparency (Byval Transparency As Single Ptr) As HRESULT
		Declare Abstract Function Let_Transparency (Byval Transparency As Single) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function Get_Weight (Byval Weight As Single Ptr) As HRESULT
		Declare Abstract Function Let_Weight (Byval Weight As Single) As HRESULT
		Declare Abstract Function Get_InsetPen (Byval InsetPen As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_InsetPen (Byval InsetPen As MsoTriState) As HRESULT
	End Type 'LineFormat_

	Type ShapeNode_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_EditingType (Byval EditingType As MsoEditingType Ptr) As HRESULT
		Declare Abstract Function Get_Points (Byval Points As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SegmentType (Byval SegmentType As MsoSegmentType Ptr) As HRESULT
	End Type 'ShapeNode_

	Type ShapeNodes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As ShapeNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval Index As Long) As HRESULT
		Declare Abstract Function Insert (Byval Index As Long, Byval SegmentType As MsoSegmentType, Byval EditingType As MsoEditingType, Byval X1 As Single, Byval Y1 As Single, Byval X2 As Single, Byval Y2 As Single, Byval X3 As Single, Byval Y3 As Single) As HRESULT
		Declare Abstract Function SetEditingType (Byval Index As Long, Byval EditingType As MsoEditingType) As HRESULT
		Declare Abstract Function SetPosition (Byval Index As Long, Byval X1 As Single, Byval Y1 As Single) As HRESULT
		Declare Abstract Function SetSegmentType (Byval Index As Long, Byval SegmentType As MsoSegmentType) As HRESULT
	End Type 'ShapeNodes_

	Type PictureFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function IncrementBrightness (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementContrast (Byval Increment As Single) As HRESULT
		Declare Abstract Function Get_Brightness (Byval Brightness As Single Ptr) As HRESULT
		Declare Abstract Function Let_Brightness (Byval Brightness As Single) As HRESULT
		Declare Abstract Function Get_ColorType (Byval ColorType As MsoPictureColorType Ptr) As HRESULT
		Declare Abstract Function Let_ColorType (Byval ColorType As MsoPictureColorType) As HRESULT
		Declare Abstract Function Get_Contrast (Byval Contrast As Single Ptr) As HRESULT
		Declare Abstract Function Let_Contrast (Byval Contrast As Single) As HRESULT
		Declare Abstract Function Get_CropBottom (Byval CropBottom As Single Ptr) As HRESULT
		Declare Abstract Function Let_CropBottom (Byval CropBottom As Single) As HRESULT
		Declare Abstract Function Get_CropLeft (Byval CropLeft As Single Ptr) As HRESULT
		Declare Abstract Function Let_CropLeft (Byval CropLeft As Single) As HRESULT
		Declare Abstract Function Get_CropRight (Byval CropRight As Single Ptr) As HRESULT
		Declare Abstract Function Let_CropRight (Byval CropRight As Single) As HRESULT
		Declare Abstract Function Get_CropTop (Byval CropTop As Single Ptr) As HRESULT
		Declare Abstract Function Let_CropTop (Byval CropTop As Single) As HRESULT
		Declare Abstract Function Get_TransparencyColor (Byval TransparencyColor As Long Ptr) As HRESULT
		Declare Abstract Function Let_TransparencyColor (Byval TransparencyColor As Long) As HRESULT
		Declare Abstract Function Get_TransparentBackground (Byval TransparentBackground As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_TransparentBackground (Byval TransparentBackground As MsoTriState) As HRESULT
		Declare Abstract Function Get_Crop (Byval Crop As Crop Ptr Ptr) As HRESULT
	End Type 'PictureFormat_

	Type ShadowFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function IncrementOffsetX (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementOffsetY (Byval Increment As Single) As HRESULT
		Declare Abstract Function Get_ForeColor (Byval ForeColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ForeColor (Byval ForeColor As ColorFormat Ptr) As HRESULT
		Declare Abstract Function Get_Obscured (Byval Obscured As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Obscured (Byval Obscured As MsoTriState) As HRESULT
		Declare Abstract Function Get_OffsetX (Byval OffsetX As Single Ptr) As HRESULT
		Declare Abstract Function Let_OffsetX (Byval OffsetX As Single) As HRESULT
		Declare Abstract Function Get_OffsetY (Byval OffsetY As Single Ptr) As HRESULT
		Declare Abstract Function Let_OffsetY (Byval OffsetY As Single) As HRESULT
		Declare Abstract Function Get_Transparency (Byval Transparency As Single Ptr) As HRESULT
		Declare Abstract Function Let_Transparency (Byval Transparency As Single) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoShadowType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoShadowType) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function Get_Style (Byval ShadowStyle As MsoShadowStyle Ptr) As HRESULT
		Declare Abstract Function Let_Style (Byval ShadowStyle As MsoShadowStyle) As HRESULT
		Declare Abstract Function Get_Blur (Byval Blur As Single Ptr) As HRESULT
		Declare Abstract Function Let_Blur (Byval Blur As Single) As HRESULT
		Declare Abstract Function Get_Size (Byval Size As Single Ptr) As HRESULT
		Declare Abstract Function Let_Size (Byval Size As Single) As HRESULT
		Declare Abstract Function Get_RotateWithShape (Byval RotateWithShape As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_RotateWithShape (Byval RotateWithShape As MsoTriState) As HRESULT
	End Type 'ShadowFormat_

	Type Script_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Extended (Byval Extended As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Extended (Byval Extended As BSTR) As HRESULT
		Declare Abstract Function Get_Id (Byval Id As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Id (Byval Id As BSTR) As HRESULT
		Declare Abstract Function Get_Language (Byval Language As MsoScriptLanguage Ptr) As HRESULT
		Declare Abstract Function Let_Language (Byval Language As MsoScriptLanguage) As HRESULT
		Declare Abstract Function Get_Location (Byval Location As MsoScriptLocation Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Shape (Byval Object As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ScriptText (Byval Script As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_ScriptText (Byval Script As BSTR) As HRESULT
	End Type 'Script_

	Type Scripts_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As Script Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Anchor As IDispatch Ptr, Byval Location As MsoScriptLocation, Byval Language As MsoScriptLanguage, Byval Id As BSTR, Byval Extended As BSTR, Byval ScriptText As BSTR, Byval Add_v As Script Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
	End Type 'Scripts_

	Type Shape_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Apply () As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Duplicate (Byval Duplicate_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Flip (Byval FlipCmd As MsoFlipCmd) As HRESULT
		Declare Abstract Function IncrementLeft (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementRotation (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementTop (Byval Increment As Single) As HRESULT
		Declare Abstract Function PickUp () As HRESULT
		Declare Abstract Function RerouteConnections () As HRESULT
		Declare Abstract Function ScaleHeight (Byval Factor As Single, Byval RelativeToOriginalSize As MsoTriState, Byval fScale As MsoScaleFrom) As HRESULT
		Declare Abstract Function ScaleWidth (Byval Factor As Single, Byval RelativeToOriginalSize As MsoTriState, Byval fScale As MsoScaleFrom) As HRESULT
		Declare Abstract Function Select_ (Byval Replace As Variant Ptr) As HRESULT
		Declare Abstract Function SetShapesDefaultProperties () As HRESULT
		Declare Abstract Function Ungroup (Byval Ungroup_v As ShapeRange Ptr Ptr) As HRESULT
		Declare Abstract Function ZOrder (Byval ZOrderCmd As MsoZOrderCmd) As HRESULT
		Declare Abstract Function Get_Adjustments (Byval Adjustments As Adjustments Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AutoShapeType (Byval AutoShapeType As MsoAutoShapeType Ptr) As HRESULT
		Declare Abstract Function Let_AutoShapeType (Byval AutoShapeType As MsoAutoShapeType) As HRESULT
		Declare Abstract Function Get_BlackWhiteMode (Byval BlackWhiteMode As MsoBlackWhiteMode Ptr) As HRESULT
		Declare Abstract Function Let_BlackWhiteMode (Byval BlackWhiteMode As MsoBlackWhiteMode) As HRESULT
		Declare Abstract Function Get_Callout (Byval Callout As CalloutFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ConnectionSiteCount (Byval ConnectionSiteCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Connector (Byval Connector As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_ConnectorFormat (Byval ConnectorFormat As ConnectorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval Fill As FillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_GroupItems (Byval GroupItems As GroupShapes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval Height As Single Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval Height As Single) As HRESULT
		Declare Abstract Function Get_HorizontalFlip (Byval HorizontalFlip As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval Left As Single Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval Left As Single) As HRESULT
		Declare Abstract Function Get_Line (Byval Line As LineFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LockAspectRatio (Byval LockAspectRatio As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_LockAspectRatio (Byval LockAspectRatio As MsoTriState) As HRESULT
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval Name As BSTR) As HRESULT
		Declare Abstract Function Get_Nodes (Byval Nodes As ShapeNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Rotation (Byval Rotation As Single Ptr) As HRESULT
		Declare Abstract Function Let_Rotation (Byval Rotation As Single) As HRESULT
		Declare Abstract Function Get_PictureFormat (Byval Picture As PictureFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval Shadow As ShadowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextEffect (Byval TextEffect As TextEffectFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextFrame (Byval TextFrame As TextFrame Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThreeD (Byval ThreeD As ThreeDFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval Top As Single Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval Top As Single) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoShapeType Ptr) As HRESULT
		Declare Abstract Function Get_VerticalFlip (Byval VerticalFlip As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Vertices (Byval Vertices As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function Get_Width (Byval Width As Single Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval Width As Single) As HRESULT
		Declare Abstract Function Get_ZOrderPosition (Byval ZOrderPosition As Long Ptr) As HRESULT
		Declare Abstract Function Get_Script (Byval Script As Script Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AlternativeText (Byval AlternativeText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_AlternativeText (Byval AlternativeText As BSTR) As HRESULT
		Declare Abstract Function Get_HasDiagram (Byval pHasDiagram As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Diagram (Byval Diagram As IMsoDiagram Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasDiagramNode (Byval pHasDiagram As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_DiagramNode (Byval DiagramNode As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Child (Byval Child As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_ParentGroup (Byval Parent As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CanvasItems (Byval CanvasShapes As CanvasShapes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function CanvasCropLeft (Byval Increment As Single) As HRESULT
		Declare Abstract Function CanvasCropTop (Byval Increment As Single) As HRESULT
		Declare Abstract Function CanvasCropRight (Byval Increment As Single) As HRESULT
		Declare Abstract Function CanvasCropBottom (Byval Increment As Single) As HRESULT
		Declare Abstract Function Let_RTF (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_TextFrame2 (Byval Frame As TextFrame2 Ptr Ptr) As HRESULT
		Declare Abstract Function Cut () As HRESULT
		Declare Abstract Function Copy () As HRESULT
		Declare Abstract Function Get_HasChart (Byval pHasChart As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Chart (Byval Chart As IMsoChart Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ShapeStyle (Byval ShapeStyle As MsoShapeStyleIndex Ptr) As HRESULT
		Declare Abstract Function Let_ShapeStyle (Byval ShapeStyle As MsoShapeStyleIndex) As HRESULT
		Declare Abstract Function Get_BackgroundStyle (Byval BackgroundStyle As MsoBackgroundStyleIndex Ptr) As HRESULT
		Declare Abstract Function Let_BackgroundStyle (Byval BackgroundStyle As MsoBackgroundStyleIndex) As HRESULT
		Declare Abstract Function Get_SoftEdge (Byval SoftEdge As SoftEdgeFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Glow (Byval Glow As GlowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Reflection (Byval Reflection As ReflectionFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasSmartArt (Byval HasSmartArt As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_SmartArt (Byval SmartArt As SmartArt Ptr Ptr) As HRESULT
		Declare Abstract Function ConvertTextToSmartArt (Byval Layout As SmartArtLayout Ptr) As HRESULT
		Declare Abstract Function Get_Title (Byval Title As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Title (Byval Title As BSTR) As HRESULT
	End Type 'Shape_

	Type ShapeRange_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Align (Byval AlignCmd As MsoAlignCmd, Byval RelativeTo As MsoTriState) As HRESULT
		Declare Abstract Function Apply () As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Distribute (Byval DistributeCmd As MsoDistributeCmd, Byval RelativeTo As MsoTriState) As HRESULT
		Declare Abstract Function Duplicate (Byval Duplicate_v As ShapeRange Ptr Ptr) As HRESULT
		Declare Abstract Function Flip (Byval FlipCmd As MsoFlipCmd) As HRESULT
		Declare Abstract Function IncrementLeft (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementRotation (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementTop (Byval Increment As Single) As HRESULT
		Declare Abstract Function Group (Byval Group_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function PickUp () As HRESULT
		Declare Abstract Function Regroup (Byval Regroup_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function RerouteConnections () As HRESULT
		Declare Abstract Function ScaleHeight (Byval Factor As Single, Byval RelativeToOriginalSize As MsoTriState, Byval fScale As MsoScaleFrom) As HRESULT
		Declare Abstract Function ScaleWidth (Byval Factor As Single, Byval RelativeToOriginalSize As MsoTriState, Byval fScale As MsoScaleFrom) As HRESULT
		Declare Abstract Function Select_ (Byval Replace As Variant Ptr) As HRESULT
		Declare Abstract Function SetShapesDefaultProperties () As HRESULT
		Declare Abstract Function Ungroup (Byval Ungroup_v As ShapeRange Ptr Ptr) As HRESULT
		Declare Abstract Function ZOrder (Byval ZOrderCmd As MsoZOrderCmd) As HRESULT
		Declare Abstract Function Get_Adjustments (Byval Adjustments As Adjustments Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AutoShapeType (Byval AutoShapeType As MsoAutoShapeType Ptr) As HRESULT
		Declare Abstract Function Let_AutoShapeType (Byval AutoShapeType As MsoAutoShapeType) As HRESULT
		Declare Abstract Function Get_BlackWhiteMode (Byval BlackWhiteMode As MsoBlackWhiteMode Ptr) As HRESULT
		Declare Abstract Function Let_BlackWhiteMode (Byval BlackWhiteMode As MsoBlackWhiteMode) As HRESULT
		Declare Abstract Function Get_Callout (Byval Callout As CalloutFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ConnectionSiteCount (Byval ConnectionSiteCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Connector (Byval Connector As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_ConnectorFormat (Byval ConnectorFormat As ConnectorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval Fill As FillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_GroupItems (Byval GroupItems As GroupShapes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval Height As Single Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval Height As Single) As HRESULT
		Declare Abstract Function Get_HorizontalFlip (Byval HorizontalFlip As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval Left As Single Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval Left As Single) As HRESULT
		Declare Abstract Function Get_Line (Byval Line As LineFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LockAspectRatio (Byval LockAspectRatio As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_LockAspectRatio (Byval LockAspectRatio As MsoTriState) As HRESULT
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval Name As BSTR) As HRESULT
		Declare Abstract Function Get_Nodes (Byval Nodes As ShapeNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Rotation (Byval Rotation As Single Ptr) As HRESULT
		Declare Abstract Function Let_Rotation (Byval Rotation As Single) As HRESULT
		Declare Abstract Function Get_PictureFormat (Byval Picture As PictureFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval Shadow As ShadowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextEffect (Byval TextEffect As TextEffectFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextFrame (Byval TextFrame As TextFrame Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThreeD (Byval ThreeD As ThreeDFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval Top As Single Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval Top As Single) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoShapeType Ptr) As HRESULT
		Declare Abstract Function Get_VerticalFlip (Byval VerticalFlip As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Vertices (Byval Vertices As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function Get_Width (Byval Width As Single Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval Width As Single) As HRESULT
		Declare Abstract Function Get_ZOrderPosition (Byval ZOrderPosition As Long Ptr) As HRESULT
		Declare Abstract Function Get_Script (Byval Script As Script Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AlternativeText (Byval AlternativeText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_AlternativeText (Byval AlternativeText As BSTR) As HRESULT
		Declare Abstract Function Get_HasDiagram (Byval pHasDiagram As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Diagram (Byval Diagram As IMsoDiagram Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasDiagramNode (Byval pHasDiagram As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_DiagramNode (Byval DiagramNode As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Child (Byval Child As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_ParentGroup (Byval Parent As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CanvasItems (Byval CanvasShapes As CanvasShapes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval pid As Long Ptr) As HRESULT
		Declare Abstract Function CanvasCropLeft (Byval Increment As Single) As HRESULT
		Declare Abstract Function CanvasCropTop (Byval Increment As Single) As HRESULT
		Declare Abstract Function CanvasCropRight (Byval Increment As Single) As HRESULT
		Declare Abstract Function CanvasCropBottom (Byval Increment As Single) As HRESULT
		Declare Abstract Function Let_RTF (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_TextFrame2 (Byval Frame As TextFrame2 Ptr Ptr) As HRESULT
		Declare Abstract Function Cut () As HRESULT
		Declare Abstract Function Copy () As HRESULT
		Declare Abstract Function Get_HasChart (Byval pHasChart As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Chart (Byval Chart As IMsoChart Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ShapeStyle (Byval ShapeStyle As MsoShapeStyleIndex Ptr) As HRESULT
		Declare Abstract Function Let_ShapeStyle (Byval ShapeStyle As MsoShapeStyleIndex) As HRESULT
		Declare Abstract Function Get_BackgroundStyle (Byval BackgroundStyle As MsoBackgroundStyleIndex Ptr) As HRESULT
		Declare Abstract Function Let_BackgroundStyle (Byval BackgroundStyle As MsoBackgroundStyleIndex) As HRESULT
		Declare Abstract Function Get_SoftEdge (Byval SoftEdge As SoftEdgeFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Glow (Byval Glow As GlowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Reflection (Byval Reflection As ReflectionFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Title (Byval Title As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Title (Byval Title As BSTR) As HRESULT
		Declare Abstract Function MergeShapes (Byval MergeCmd As MsoMergeCmd, Byval PrimaryShape As Shape Ptr) As HRESULT
	End Type 'ShapeRange_

	Type Shapes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function AddCallout (Byval Type_v As MsoCalloutType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Callout As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddConnector (Byval Type_v As MsoConnectorType, Byval BeginX As Single, Byval BeginY As Single, Byval EndX As Single, Byval EndY As Single, Byval Connector As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddCurve (Byval SafeArrayOfPoints As Variant Ptr, Byval Curve As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddLabel (Byval Orientation As MsoTextOrientation, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Label As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddLine (Byval BeginX As Single, Byval BeginY As Single, Byval EndX As Single, Byval EndY As Single, Byval Line As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddPicture (Byval FileName As BSTR, Byval LinkToFile As MsoTriState, Byval SaveWithDocument As MsoTriState, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Picture As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddPolyline (Byval SafeArrayOfPoints As Variant Ptr, Byval Polyline As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddShape (Byval Type_v As MsoAutoShapeType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Shape As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddTextEffect (Byval PresetTextEffect As MsoPresetTextEffect, Byval Text As BSTR, Byval FontName As BSTR, Byval FontSize As Single, Byval FontBold As MsoTriState, Byval FontItalic As MsoTriState, Byval Left As Single, Byval Top As Single, Byval TextEffect As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddTextbox (Byval Orientation As MsoTextOrientation, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Textbox As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function BuildFreeform (Byval EditingType As MsoEditingType, Byval X1 As Single, Byval Y1 As Single, Byval FreeformBuilder As FreeformBuilder Ptr Ptr) As HRESULT
		Declare Abstract Function Range (Byval Index As Variant Ptr, Byval Range_v As ShapeRange Ptr Ptr) As HRESULT
		Declare Abstract Function SelectAll () As HRESULT
		Declare Abstract Function Get_Background (Byval Background As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Default (Byval Default As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddDiagram (Byval Type_v As MsoDiagramType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Diagram As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddCanvas (Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Shape As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddChart (Byval Type_v As XlChartType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Chart As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddTable (Byval NumRows As Long, Byval NumColumns As Long, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Table As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddSmartArt (Byval Layout As SmartArtLayout Ptr, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval SmartArt As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddChart2 (Byval Style As Long, Byval Type_v As XlChartType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval NewLayout As VARIANT_BOOL, Byval Chart As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddPicture2 (Byval FileName As BSTR, Byval LinkToFile As MsoTriState, Byval SaveWithDocument As MsoTriState, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Compress As MsoPictureCompress, Byval Picture As Shape Ptr Ptr) As HRESULT
	End Type 'Shapes_

	Type TextEffectFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function ToggleVerticalText () As HRESULT
		Declare Abstract Function Get_Alignment (Byval Alignment As MsoTextEffectAlignment Ptr) As HRESULT
		Declare Abstract Function Let_Alignment (Byval Alignment As MsoTextEffectAlignment) As HRESULT
		Declare Abstract Function Get_FontBold (Byval FontBold As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_FontBold (Byval FontBold As MsoTriState) As HRESULT
		Declare Abstract Function Get_FontItalic (Byval FontItalic As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_FontItalic (Byval FontItalic As MsoTriState) As HRESULT
		Declare Abstract Function Get_FontName (Byval FontName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FontName (Byval FontName As BSTR) As HRESULT
		Declare Abstract Function Get_FontSize (Byval FontSize As Single Ptr) As HRESULT
		Declare Abstract Function Let_FontSize (Byval FontSize As Single) As HRESULT
		Declare Abstract Function Get_KernedPairs (Byval KernedPairs As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_KernedPairs (Byval KernedPairs As MsoTriState) As HRESULT
		Declare Abstract Function Get_NormalizedHeight (Byval NormalizedHeight As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_NormalizedHeight (Byval NormalizedHeight As MsoTriState) As HRESULT
		Declare Abstract Function Get_PresetShape (Byval PresetShape As MsoPresetTextEffectShape Ptr) As HRESULT
		Declare Abstract Function Let_PresetShape (Byval PresetShape As MsoPresetTextEffectShape) As HRESULT
		Declare Abstract Function Get_PresetTextEffect (Byval Preset As MsoPresetTextEffect Ptr) As HRESULT
		Declare Abstract Function Let_PresetTextEffect (Byval Preset As MsoPresetTextEffect) As HRESULT
		Declare Abstract Function Get_RotatedChars (Byval RotatedChars As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_RotatedChars (Byval RotatedChars As MsoTriState) As HRESULT
		Declare Abstract Function Get_Text (Byval Text As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval Text As BSTR) As HRESULT
		Declare Abstract Function Get_Tracking (Byval Tracking As Single Ptr) As HRESULT
		Declare Abstract Function Let_Tracking (Byval Tracking As Single) As HRESULT
	End Type 'TextEffectFormat_

	Type TextFrame_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_MarginBottom (Byval MarginBottom As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginBottom (Byval MarginBottom As Single) As HRESULT
		Declare Abstract Function Get_MarginLeft (Byval MarginLeft As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginLeft (Byval MarginLeft As Single) As HRESULT
		Declare Abstract Function Get_MarginRight (Byval MarginRight As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginRight (Byval MarginRight As Single) As HRESULT
		Declare Abstract Function Get_MarginTop (Byval MarginTop As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginTop (Byval MarginTop As Single) As HRESULT
		Declare Abstract Function Get_Orientation (Byval Orientation As MsoTextOrientation Ptr) As HRESULT
		Declare Abstract Function Let_Orientation (Byval Orientation As MsoTextOrientation) As HRESULT
	End Type 'TextFrame_

	Type ThreeDFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function IncrementRotationX (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementRotationY (Byval Increment As Single) As HRESULT
		Declare Abstract Function ResetRotation () As HRESULT
		Declare Abstract Function SetThreeDFormat (Byval PresetThreeDFormat As MsoPresetThreeDFormat) As HRESULT
		Declare Abstract Function SetExtrusionDirection (Byval PresetExtrusionDirection As MsoPresetExtrusionDirection) As HRESULT
		Declare Abstract Function Get_Depth (Byval Depth As Single Ptr) As HRESULT
		Declare Abstract Function Let_Depth (Byval Depth As Single) As HRESULT
		Declare Abstract Function Get_ExtrusionColor (Byval ExtrusionColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ExtrusionColorType (Byval ExtrusionColorType As MsoExtrusionColorType Ptr) As HRESULT
		Declare Abstract Function Let_ExtrusionColorType (Byval ExtrusionColorType As MsoExtrusionColorType) As HRESULT
		Declare Abstract Function Get_Perspective (Byval Perspective As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Perspective (Byval Perspective As MsoTriState) As HRESULT
		Declare Abstract Function Get_PresetExtrusionDirection (Byval PresetExtrusionDirection As MsoPresetExtrusionDirection Ptr) As HRESULT
		Declare Abstract Function Get_PresetLightingDirection (Byval PresetLightingDirection As MsoPresetLightingDirection Ptr) As HRESULT
		Declare Abstract Function Let_PresetLightingDirection (Byval PresetLightingDirection As MsoPresetLightingDirection) As HRESULT
		Declare Abstract Function Get_PresetLightingSoftness (Byval PresetLightingSoftness As MsoPresetLightingSoftness Ptr) As HRESULT
		Declare Abstract Function Let_PresetLightingSoftness (Byval PresetLightingSoftness As MsoPresetLightingSoftness) As HRESULT
		Declare Abstract Function Get_PresetMaterial (Byval PresetMaterial As MsoPresetMaterial Ptr) As HRESULT
		Declare Abstract Function Let_PresetMaterial (Byval PresetMaterial As MsoPresetMaterial) As HRESULT
		Declare Abstract Function Get_PresetThreeDFormat (Byval PresetThreeDFormat As MsoPresetThreeDFormat Ptr) As HRESULT
		Declare Abstract Function Get_RotationX (Byval RotationX As Single Ptr) As HRESULT
		Declare Abstract Function Let_RotationX (Byval RotationX As Single) As HRESULT
		Declare Abstract Function Get_RotationY (Byval RotationY As Single Ptr) As HRESULT
		Declare Abstract Function Let_RotationY (Byval RotationY As Single) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function SetPresetCamera (Byval PresetCamera As MsoPresetCamera) As HRESULT
		Declare Abstract Function IncrementRotationZ (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementRotationHorizontal (Byval Increment As Single) As HRESULT
		Declare Abstract Function IncrementRotationVertical (Byval Increment As Single) As HRESULT
		Declare Abstract Function Get_PresetLighting (Byval PresetLightRigType As MsoLightRigType Ptr) As HRESULT
		Declare Abstract Function Let_PresetLighting (Byval PresetLightRigType As MsoLightRigType) As HRESULT
		Declare Abstract Function Get_Z (Byval Z As Single Ptr) As HRESULT
		Declare Abstract Function Let_Z (Byval Z As Single) As HRESULT
		Declare Abstract Function Get_BevelTopType (Byval BevelTopType As MsoBevelType Ptr) As HRESULT
		Declare Abstract Function Let_BevelTopType (Byval BevelTopType As MsoBevelType) As HRESULT
		Declare Abstract Function Get_BevelTopInset (Byval BevelTopInset As Single Ptr) As HRESULT
		Declare Abstract Function Let_BevelTopInset (Byval BevelTopInset As Single) As HRESULT
		Declare Abstract Function Get_BevelTopDepth (Byval BevelTopDepth As Single Ptr) As HRESULT
		Declare Abstract Function Let_BevelTopDepth (Byval BevelTopDepth As Single) As HRESULT
		Declare Abstract Function Get_BevelBottomType (Byval BevelBottomType As MsoBevelType Ptr) As HRESULT
		Declare Abstract Function Let_BevelBottomType (Byval BevelBottomType As MsoBevelType) As HRESULT
		Declare Abstract Function Get_BevelBottomInset (Byval BevelBottomInset As Single Ptr) As HRESULT
		Declare Abstract Function Let_BevelBottomInset (Byval BevelBottomInset As Single) As HRESULT
		Declare Abstract Function Get_BevelBottomDepth (Byval BevelBottomDepth As Single Ptr) As HRESULT
		Declare Abstract Function Let_BevelBottomDepth (Byval BevelBottomDepth As Single) As HRESULT
		Declare Abstract Function Get_PresetCamera (Byval PresetCamera As MsoPresetCamera Ptr) As HRESULT
		Declare Abstract Function Get_RotationZ (Byval RotationZ As Single Ptr) As HRESULT
		Declare Abstract Function Let_RotationZ (Byval RotationZ As Single) As HRESULT
		Declare Abstract Function Get_ContourWidth (Byval Width As Single Ptr) As HRESULT
		Declare Abstract Function Let_ContourWidth (Byval Width As Single) As HRESULT
		Declare Abstract Function Get_ContourColor (Byval ContourColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_FieldOfView (Byval FOV As Single Ptr) As HRESULT
		Declare Abstract Function Let_FieldOfView (Byval FOV As Single) As HRESULT
		Declare Abstract Function Get_ProjectText (Byval ProjectText As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_ProjectText (Byval ProjectText As MsoTriState) As HRESULT
		Declare Abstract Function Get_LightAngle (Byval LightAngle As Single Ptr) As HRESULT
		Declare Abstract Function Let_LightAngle (Byval LightAngle As Single) As HRESULT
	End Type 'ThreeDFormat_

	Type IMsoDispCagNotifySink_ Extends CAIDispatch
		Declare Abstract Function InsertClip (Byval pClipMoniker As IUnknown Ptr, Byval pItemMoniker As IUnknown Ptr) As HRESULT
		Declare Abstract Function WindowIsClosing () As HRESULT
	End Type 'IMsoDispCagNotifySink_

	Type Balloon_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Checkboxes (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Labels (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_BalloonType (Byval pbty As MsoBalloonType) As HRESULT
		Declare Abstract Function Get_BalloonType (Byval pbty As MsoBalloonType Ptr) As HRESULT
		Declare Abstract Function Let_Icon (Byval picn As MsoIconType) As HRESULT
		Declare Abstract Function Get_Icon (Byval picn As MsoIconType Ptr) As HRESULT
		Declare Abstract Function Let_Heading (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Heading (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Mode (Byval pmd As MsoModeType) As HRESULT
		Declare Abstract Function Get_Mode (Byval pmd As MsoModeType Ptr) As HRESULT
		Declare Abstract Function Let_Animation (Byval pfca As MsoAnimationType) As HRESULT
		Declare Abstract Function Get_Animation (Byval pfca As MsoAnimationType Ptr) As HRESULT
		Declare Abstract Function Let_Button (Byval psbs As MsoButtonSetType) As HRESULT
		Declare Abstract Function Get_Button (Byval psbs As MsoButtonSetType Ptr) As HRESULT
		Declare Abstract Function Let_Callback (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Callback (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Private (Byval plPrivate As Long) As HRESULT
		Declare Abstract Function Get_Private (Byval plPrivate As Long Ptr) As HRESULT
		Declare Abstract Function SetAvoidRectangle (Byval Left As Long, Byval Top As Long, Byval Right As Long, Byval Bottom As Long) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Show (Byval pibtn As MsoBalloonButtonType Ptr) As HRESULT
		Declare Abstract Function Close () As HRESULT
	End Type 'Balloon_

	Type BalloonCheckboxes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pccbx As Long Ptr) As HRESULT
		Declare Abstract Function Let_Count (Byval pccbx As Long) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
	End Type 'BalloonCheckboxes_

	Type BalloonCheckbox_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Checked (Byval pvarfChecked As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Checked (Byval pvarfChecked As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstr As BSTR Ptr) As HRESULT
	End Type 'BalloonCheckbox_

	Type BalloonLabels_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcwz As Long Ptr) As HRESULT
		Declare Abstract Function Let_Count (Byval pcwz As Long) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
	End Type 'BalloonLabels_

	Type BalloonLabel_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstr As BSTR Ptr) As HRESULT
	End Type 'BalloonLabel_

	Type AnswerWizardFiles_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pCount As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Delete_ (Byval FileName As BSTR) As HRESULT
	End Type 'AnswerWizardFiles_

	Type AnswerWizard_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Files (Byval Files As AnswerWizardFiles Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFileList () As HRESULT
		Declare Abstract Function ResetFileList () As HRESULT
	End Type 'AnswerWizard_

	Type Assistant_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Move (Byval xLeft As Long, Byval yTop As Long) As HRESULT
		Declare Abstract Function Let_Top (Byval pyTop As Long) As HRESULT
		Declare Abstract Function Get_Top (Byval pyTop As Long Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval pxLeft As Long) As HRESULT
		Declare Abstract Function Get_Left (Byval pxLeft As Long Ptr) As HRESULT
		Declare Abstract Function Help () As HRESULT
		Declare Abstract Function StartWizard (Byval On As VARIANT_BOOL, Byval Callback As BSTR, Byval PrivateX As Long, Byval Animation As Variant Ptr, Byval CustomTeaser As Variant Ptr, Byval Top As Variant Ptr, Byval Left As Variant Ptr, Byval Bottom As Variant Ptr, Byval Right As Variant Ptr, Byval plWizID As Long Ptr) As HRESULT
		Declare Abstract Function EndWizard (Byval WizardID As Long, Byval varfSuccess As VARIANT_BOOL, Byval Animation As Variant Ptr) As HRESULT
		Declare Abstract Function ActivateWizard (Byval WizardID As Long, Byval act As MsoWizardActType, Byval Animation As Variant Ptr) As HRESULT
		Declare Abstract Function ResetTips () As HRESULT
		Declare Abstract Function Get_NewBalloon (Byval ppibal As Balloon Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BalloonError (Byval pbne As MsoBalloonErrorType Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval pvarfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval pvarfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Animation (Byval pfca As MsoAnimationType Ptr) As HRESULT
		Declare Abstract Function Let_Animation (Byval pfca As MsoAnimationType) As HRESULT
		Declare Abstract Function Get_Reduced (Byval pvarfReduced As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Reduced (Byval pvarfReduced As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Let_AssistWithHelp (Byval pvarfAssistWithHelp As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_AssistWithHelp (Byval pvarfAssistWithHelp As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AssistWithWizards (Byval pvarfAssistWithWizards As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_AssistWithWizards (Byval pvarfAssistWithWizards As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AssistWithAlerts (Byval pvarfAssistWithAlerts As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_AssistWithAlerts (Byval pvarfAssistWithAlerts As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MoveWhenInTheWay (Byval pvarfMove As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MoveWhenInTheWay (Byval pvarfMove As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Sounds (Byval pvarfSounds As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Sounds (Byval pvarfSounds As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_FeatureTips (Byval pvarfFeatures As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_FeatureTips (Byval pvarfFeatures As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MouseTips (Byval pvarfMouse As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MouseTips (Byval pvarfMouse As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_KeyboardShortcutTips (Byval pvarfKeyboardShortcuts As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_KeyboardShortcutTips (Byval pvarfKeyboardShortcuts As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HighPriorityTips (Byval pvarfHighPriorityTips As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HighPriorityTips (Byval pvarfHighPriorityTips As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_TipOfDay (Byval pvarfTipOfDay As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_TipOfDay (Byval pvarfTipOfDay As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_GuessHelp (Byval pvarfGuessHelp As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_GuessHelp (Byval pvarfGuessHelp As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_SearchWhenProgramming (Byval pvarfSearchInProgram As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_SearchWhenProgramming (Byval pvarfSearchInProgram As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_FileName (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FileName (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_On (Byval pvarfOn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_On (Byval pvarfOn As VARIANT_BOOL) As HRESULT
		Declare Abstract Function DoAlert (Byval bstrAlertTitle As BSTR, Byval bstrAlertText As BSTR, Byval alb As MsoAlertButtonType, Byval alc As MsoAlertIconType, Byval ald As MsoAlertDefaultType, Byval alq As MsoAlertCancelType, Byval varfSysAlert As VARIANT_BOOL, Byval pibtn As Long Ptr) As HRESULT
	End Type 'Assistant_

	Type IFoundFiles_ Extends CAIDispatch
		Declare Abstract Function Get_Item (Byval Index As Long, Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pCount As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'IFoundFiles_

	Type IFind_ Extends CAIDispatch
		Declare Abstract Function Get_SearchPath (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_SubDir (Byval retval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Title (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Author (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Keywords (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Subject (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Options (Byval penmOptions As MsoFileFindOptions Ptr) As HRESULT
		Declare Abstract Function Get_MatchCase (Byval retval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_PatternMatch (Byval retval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_DateSavedFrom (Byval pdatSavedFrom As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DateSavedTo (Byval pdatSavedTo As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SavedBy (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_DateCreatedFrom (Byval pdatCreatedFrom As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DateCreatedTo (Byval pdatCreatedTo As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_View (Byval penmView As MsoFileFindView Ptr) As HRESULT
		Declare Abstract Function Get_SortBy (Byval penmSortBy As MsoFileFindSortBy Ptr) As HRESULT
		Declare Abstract Function Get_ListBy (Byval penmListBy As MsoFileFindListBy Ptr) As HRESULT
		Declare Abstract Function Get_SelectedFile (Byval pintSelectedFile As Long Ptr) As HRESULT
		Declare Abstract Function Get_Results (Byval pdisp As IFoundFiles Ptr Ptr) As HRESULT
		Declare Abstract Function Show (Byval pRows As Long Ptr) As HRESULT
		Declare Abstract Function Let_SearchPath (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_Name (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_SubDir (Byval retval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Let_Title (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_Author (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_Keywords (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_Subject (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_Options (Byval penmOptions As MsoFileFindOptions) As HRESULT
		Declare Abstract Function Let_MatchCase (Byval retval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_PatternMatch (Byval retval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Let_DateSavedFrom (Byval pdatSavedFrom As Variant Ptr) As HRESULT
		Declare Abstract Function Let_DateSavedTo (Byval pdatSavedTo As Variant Ptr) As HRESULT
		Declare Abstract Function Let_SavedBy (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Let_DateCreatedFrom (Byval pdatCreatedFrom As Variant Ptr) As HRESULT
		Declare Abstract Function Let_DateCreatedTo (Byval pdatCreatedTo As Variant Ptr) As HRESULT
		Declare Abstract Function Let_View (Byval penmView As MsoFileFindView) As HRESULT
		Declare Abstract Function Let_SortBy (Byval penmSortBy As MsoFileFindSortBy) As HRESULT
		Declare Abstract Function Let_ListBy (Byval penmListBy As MsoFileFindListBy) As HRESULT
		Declare Abstract Function Let_SelectedFile (Byval pintSelectedFile As Long) As HRESULT
		Declare Abstract Function Execute () As HRESULT
		Declare Abstract Function Load (Byval bstrQueryName As BSTR) As HRESULT
		Declare Abstract Function Save (Byval bstrQueryName As BSTR) As HRESULT
		Declare Abstract Function Delete_ (Byval bstrQueryName As BSTR) As HRESULT
		Declare Abstract Function Get_FileType (Byval plFileType As Long Ptr) As HRESULT
		Declare Abstract Function Let_FileType (Byval plFileType As Long) As HRESULT
	End Type 'IFind_

	Type FoundFiles_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval lcid As Long, Byval pbstrFile As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pc As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'FoundFiles_

	Type PropertyTest_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval pbstrRetVal As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Condition (Byval pConditionRetVal As MsoCondition Ptr) As HRESULT
		Declare Abstract Function Get_Value (Byval pvargRetVal As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SecondValue (Byval pvargRetVal2 As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Connector (Byval pConnector As MsoConnector Ptr) As HRESULT
	End Type 'PropertyTest_

	Type PropertyTests_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval lcid As Long, Byval ppIDocProp As PropertyTest Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pc As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval Name As BSTR, Byval Condition As MsoCondition, Byval Value As Variant Ptr, Byval SecondValue As Variant Ptr, Byval Connector As MsoConnector) As HRESULT
		Declare Abstract Function Remove (Byval Index As Long) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'PropertyTests_

	Type FileSearch_ Extends _IMsoDispObj
		Declare Abstract Function Get_SearchSubFolders (Byval SearchSubFoldersRetVal As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_SearchSubFolders (Byval SearchSubFoldersRetVal As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MatchTextExactly (Byval MatchTextRetVal As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MatchTextExactly (Byval MatchTextRetVal As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MatchAllWordForms (Byval MatchAllWordFormsRetVal As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MatchAllWordForms (Byval MatchAllWordFormsRetVal As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_FileName (Byval FileNameRetVal As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FileName (Byval FileNameRetVal As BSTR) As HRESULT
		Declare Abstract Function Get_FileType (Byval FileTypeRetVal As MsoFileType Ptr) As HRESULT
		Declare Abstract Function Let_FileType (Byval FileTypeRetVal As MsoFileType) As HRESULT
		Declare Abstract Function Get_LastModified (Byval LastModifiedRetVal As MsoLastModified Ptr) As HRESULT
		Declare Abstract Function Let_LastModified (Byval LastModifiedRetVal As MsoLastModified) As HRESULT
		Declare Abstract Function Get_TextOrProperty (Byval TextOrProperty As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_TextOrProperty (Byval TextOrProperty As BSTR) As HRESULT
		Declare Abstract Function Get_LookIn (Byval LookInRetVal As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_LookIn (Byval LookInRetVal As BSTR) As HRESULT
		Declare Abstract Function Execute (Byval SortBy As MsoSortBy, Byval SortOrder As MsoSortOrder, Byval AlwaysAccurate As VARIANT_BOOL, Byval pRet As Long Ptr) As HRESULT
		Declare Abstract Function NewSearch () As HRESULT
		Declare Abstract Function Get_FoundFiles (Byval FoundFilesRet As FoundFiles Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PropertyTests (Byval PropTestsRet As PropertyTests Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SearchScopes (Byval SearchScopesRet As SearchScopes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SearchFolders (Byval SearchFoldersRet As SearchFolders Ptr Ptr) As HRESULT
		Declare Abstract Function Get_FileTypes (Byval FileTypesRet As FileTypes Ptr Ptr) As HRESULT
		Declare Abstract Function RefreshScopes () As HRESULT
	End Type 'FileSearch_

	Type COMAddIn_ Extends _IMsoDispObj
		Declare Abstract Function Get_Description (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Description (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_ProgId (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Guid (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Connect (Byval RetValue As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Connect (Byval RetValue As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Object (Byval RetValue As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Object (Byval RetValue As IDispatch Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval retval As IDispatch Ptr Ptr) As HRESULT
	End Type 'COMAddIn_

	Type COMAddIns_ Extends _IMsoDispObj
		Declare Abstract Function Item (Byval Index As Variant Ptr Ptr, Byval RetValue As COMAddIn Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval RetValue As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Update () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function SetAppModal (Byval varfModal As VARIANT_BOOL) As HRESULT
	End Type 'COMAddIns_

	Type LanguageSettings_ Extends _IMsoDispObj
		Declare Abstract Function Get_LanguageID (Byval Id As MsoAppLanguageID, Byval plid As Long Ptr) As HRESULT
		Declare Abstract Function Get_LanguagePreferredForEditing (Byval lid As MsoLanguageID, Byval pf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'LanguageSettings_

	Type ICommandBarsEvents_ Extends CAIDispatch
		Declare Abstract Function OnUpdate () As HRESULT
	End Type 'ICommandBarsEvents_

	Type _CommandBarsEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function OnUpdate () As HRESULT
	End Type '_CommandBarsEvents_

	Type ICommandBarComboBoxEvents_ Extends CAIDispatch
		Declare Abstract Function Change (Byval Ctrl As CommandBarComboBox Ptr) As HRESULT
	End Type 'ICommandBarComboBoxEvents_

	Type _CommandBarComboBoxEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function Change (Byval Ctrl As CommandBarComboBox Ptr) As HRESULT
	End Type '_CommandBarComboBoxEvents_

	Type ICommandBarButtonEvents_ Extends CAIDispatch
		Declare Abstract Function Click (Byval Ctrl As CommandBarButton Ptr, Byval CancelDefault As VARIANT_BOOL Ptr) As HRESULT
	End Type 'ICommandBarButtonEvents_

	Type _CommandBarButtonEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function Click (Byval Ctrl As CommandBarButton Ptr, Byval CancelDefault As VARIANT_BOOL Ptr) As HRESULT
	End Type '_CommandBarButtonEvents_

	Type WebPageFont_ Extends _IMsoDispObj
		Declare Abstract Function Get_ProportionalFont (Byval pstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_ProportionalFont (Byval pstr As BSTR) As HRESULT
		Declare Abstract Function Get_ProportionalFontSize (Byval pf As Single Ptr) As HRESULT
		Declare Abstract Function Let_ProportionalFontSize (Byval pf As Single) As HRESULT
		Declare Abstract Function Get_FixedWidthFont (Byval pstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FixedWidthFont (Byval pstr As BSTR) As HRESULT
		Declare Abstract Function Get_FixedWidthFontSize (Byval pf As Single Ptr) As HRESULT
		Declare Abstract Function Let_FixedWidthFontSize (Byval pf As Single) As HRESULT
	End Type 'WebPageFont_

	Type WebPageFonts_ Extends _IMsoDispObj
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As MsoCharacterSet, Byval Item As WebPageFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'WebPageFonts_

	Type HTMLProjectItem_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_IsOpen (Byval RetValue As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function LoadFromFile (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Open (Byval OpenKind As MsoHTMLProjectOpen) As HRESULT
		Declare Abstract Function SaveCopyAs (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Get_Text (Byval Text As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval Text As BSTR) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'HTMLProjectItem_

	Type HTMLProjectItems_ Extends _IMsoDispObj
		Declare Abstract Function Item (Byval Index As Variant Ptr Ptr, Byval RetValue As HTMLProjectItem Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval RetValue As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'HTMLProjectItems_

	Type HTMLProject_ Extends _IMsoDispObj
		Declare Abstract Function Get_State (Byval State As MsoHTMLProjectState Ptr) As HRESULT
		Declare Abstract Function RefreshProject (Byval Refresh As VARIANT_BOOL) As HRESULT
		Declare Abstract Function RefreshDocument (Byval Refresh As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HTMLProjectItems (Byval HTMLProjectItems As HTMLProjectItems Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Open (Byval OpenKind As MsoHTMLProjectOpen) As HRESULT
	End Type 'HTMLProject_

	Type MsoDebugOptions_ Extends _IMsoDispObj
		Declare Abstract Function Get_FeatureReports (Byval puintFeatureReports As Long Ptr) As HRESULT
		Declare Abstract Function Let_FeatureReports (Byval puintFeatureReports As Long) As HRESULT
		Declare Abstract Function Get_OutputToDebugger (Byval pvarfOutputToDebugger As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_OutputToDebugger (Byval pvarfOutputToDebugger As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_OutputToFile (Byval pvarfOutputToFile As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_OutputToFile (Byval pvarfOutputToFile As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_OutputToMessageBox (Byval pvarfOutputToMessageBox As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_OutputToMessageBox (Byval pvarfOutputToMessageBox As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_UnitTestManager (Byval ppMsoUnitTestManager As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function AddIgnoredAssertTag (Byval bstrTagToIgnore As BSTR) As HRESULT
		Declare Abstract Function RemoveIgnoredAssertTag (Byval bstrTagToIgnore As BSTR) As HRESULT
	End Type 'MsoDebugOptions_

	Type FileDialogSelectedItems_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcFiles As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Long, Byval Item_v As BSTR Ptr) As HRESULT
	End Type 'FileDialogSelectedItems_

	Type FileDialogFilter_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Extensions (Byval Extensions As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
	End Type 'FileDialogFilter_

	Type FileDialogFilters_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcFilters As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Long, Byval Item_v As FileDialogFilter Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval filter As Variant Ptr) As HRESULT
		Declare Abstract Function Clear () As HRESULT
		Declare Abstract Function Add (Byval Description As BSTR, Byval Extensions As BSTR, Byval Position As Variant Ptr, Byval Add_v As FileDialogFilter Ptr Ptr) As HRESULT
	End Type 'FileDialogFilters_

	Type FileDialog_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Filters (Byval Filters As FileDialogFilters Ptr Ptr) As HRESULT
		Declare Abstract Function Get_FilterIndex (Byval FilterIndex As Long Ptr) As HRESULT
		Declare Abstract Function Let_FilterIndex (Byval FilterIndex As Long) As HRESULT
		Declare Abstract Function Get_Title (Byval Title As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Title (Byval Title As BSTR) As HRESULT
		Declare Abstract Function Get_ButtonName (Byval ButtonName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_ButtonName (Byval ButtonName As BSTR) As HRESULT
		Declare Abstract Function Get_AllowMultiSelect (Byval pvarfAllowMultiSelect As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AllowMultiSelect (Byval pvarfAllowMultiSelect As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_InitialView (Byval pinitialview As MsoFileDialogView Ptr) As HRESULT
		Declare Abstract Function Let_InitialView (Byval pinitialview As MsoFileDialogView) As HRESULT
		Declare Abstract Function Get_InitialFileName (Byval InitialFileName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_InitialFileName (Byval InitialFileName As BSTR) As HRESULT
		Declare Abstract Function Get_SelectedItems (Byval Files As FileDialogSelectedItems Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DialogType (Byval pdialogtype As MsoFileDialogType Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Show (Byval rval As Long Ptr) As HRESULT
		Declare Abstract Function Execute () As HRESULT
	End Type 'FileDialog_

	Type SignatureSet_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcSig As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval iSig As Long, Byval ppidisp As Signature Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval ppidisp As Signature Ptr Ptr) As HRESULT
		Declare Abstract Function Commit () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function AddNonVisibleSignature (Byval varSigProv As Variant Ptr, Byval ppidisp As Signature Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CanAddSignatureLine (Byval pvarfCanAddSigLine As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function AddSignatureLine (Byval varSigProv As Variant Ptr, Byval ppidisp As Signature Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Subset (Byval psubset As MsoSignatureSubset Ptr) As HRESULT
		Declare Abstract Function Let_Subset (Byval psubset As MsoSignatureSubset) As HRESULT
		Declare Abstract Function Let_ShowSignaturesPane (Byval RHS As VARIANT_BOOL) As HRESULT
	End Type 'SignatureSet_

	Type Signature_ Extends _IMsoDispObj
		Declare Abstract Function Get_Signer (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Issuer (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ExpireDate (Byval pvarDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IsValid (Byval pvarfValid As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_AttachCertificate (Byval pvarfAttach As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AttachCertificate (Byval pvarfAttach As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IsCertificateExpired (Byval pvarfExpired As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_IsCertificateRevoked (Byval pvarfRevoked As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_SignDate (Byval pvarDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IsSigned (Byval pvarfSigned As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Sign (Byval varSigImg As Variant Ptr, Byval varDelSuggSigner As Variant Ptr, Byval varDelSuggSignerLine2 As Variant Ptr, Byval varDelSuggSignerEmail As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Details (Byval ppsiginfo As SignatureInfo Ptr Ptr) As HRESULT
		Declare Abstract Function ShowDetails () As HRESULT
		Declare Abstract Function Get_CanSetup (Byval pvarfCanSetup As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Setup (Byval ppsigsetup As SignatureSetup Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IsSignatureLine (Byval pvarfSignatureLine As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_SignatureLineShape (Byval ppidispShape As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SortHint (Byval plSortHint As Long Ptr) As HRESULT
	End Type 'Signature_

	Type IMsoEnvelopeVB_ Extends CAIDispatch
		Declare Abstract Function Get_Introduction (Byval pbstrIntro As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Introduction (Byval pbstrIntro As BSTR) As HRESULT
		Declare Abstract Function Get_Item (Byval ppdisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppdisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CommandBars (Byval ppdisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoEnvelopeVB_

	Type IMsoEnvelopeVBEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function EnvelopeShow () As HRESULT
		' Declare Abstract Function EnvelopeHide () As HRESULT
	End Type 'IMsoEnvelopeVBEvents_

	Type FileTypes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval MsoFileTypeRet As MsoFileType Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iCountRetVal As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval FileType As MsoFileType) As HRESULT
		Declare Abstract Function Remove (Byval Index As Long) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'FileTypes_

	Type SearchFolders_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ScopeFolderRet As ScopeFolder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iCountRetVal As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval ScopeFolder As ScopeFolder Ptr) As HRESULT
		Declare Abstract Function Remove (Byval Index As Long) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'SearchFolders_

	Type ScopeFolders_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ScopeFolderRet As ScopeFolder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iCountRetVal As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'ScopeFolders_

	Type ScopeFolder_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Path (Byval pbstrPath As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ScopeFolders (Byval ScopeFoldersRet As ScopeFolders Ptr Ptr) As HRESULT
		Declare Abstract Function AddToSearchFolders () As HRESULT
	End Type 'ScopeFolder_

	Type SearchScope_ Extends _IMsoDispObj
		Declare Abstract Function Get_Type (Byval MsoSearchInRetVal As MsoSearchIn Ptr) As HRESULT
		Declare Abstract Function Get_ScopeFolder (Byval ScopeFolderRet As ScopeFolder Ptr Ptr) As HRESULT
	End Type 'SearchScope_

	Type SearchScopes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval SearchScopeRet As SearchScope Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iCountRetVal As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'SearchScopes_

	Type IMsoDiagram_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Nodes (Byval Nodes As DiagramNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoDiagramType Ptr) As HRESULT
		Declare Abstract Function Get_AutoLayout (Byval AutoLayout As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_AutoLayout (Byval AutoLayout As MsoTriState) As HRESULT
		Declare Abstract Function Get_Reverse (Byval Reverse As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Reverse (Byval Reverse As MsoTriState) As HRESULT
		Declare Abstract Function Get_AutoFormat (Byval AutoFormat As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_AutoFormat (Byval AutoFormat As MsoTriState) As HRESULT
		Declare Abstract Function Convert (Byval Type_v As MsoDiagramType) As HRESULT
		Declare Abstract Function FitText () As HRESULT
	End Type 'IMsoDiagram_

	Type DiagramNodes_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval ppdn As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function SelectAll () As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iDiagramNodes As Long Ptr) As HRESULT
	End Type 'DiagramNodes_

	Type DiagramNodeChildren_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Node As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function AddNode (Byval Index As Variant Ptr, Byval NodeType As MsoDiagramNodeType, Byval NewNode As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function SelectAll () As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iDiagramNodes As Long Ptr) As HRESULT
		Declare Abstract Function Get_FirstChild (Byval First As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LastChild (Byval Last As DiagramNode Ptr Ptr) As HRESULT
	End Type 'DiagramNodeChildren_

	Type DiagramNode_ Extends _IMsoDispObj
		Declare Abstract Function AddNode (Byval Pos As MsoRelativeNodePosition, Byval NodeType As MsoDiagramNodeType, Byval NewNode As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function MoveNode (Byval TargetNode As DiagramNode Ptr, Byval Pos As MsoRelativeNodePosition) As HRESULT
		Declare Abstract Function ReplaceNode (Byval TargetNode As DiagramNode Ptr) As HRESULT
		Declare Abstract Function SwapNode (Byval TargetNode As DiagramNode Ptr, Byval SwapChildren As VARIANT_BOOL) As HRESULT
		Declare Abstract Function CloneNode (Byval CopyChildren As VARIANT_BOOL, Byval TargetNode As DiagramNode Ptr, Byval Pos As MsoRelativeNodePosition, Byval Node As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function TransferChildren (Byval ReceivingNode As DiagramNode Ptr) As HRESULT
		Declare Abstract Function NextNode (Byval NextNode_v As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function PrevNode (Byval PrevNode_v As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Children (Byval Children As DiagramNodeChildren Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shape (Byval Shape As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Root (Byval Root As DiagramNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Diagram (Byval Diagram As IMsoDiagram Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Layout (Byval Type_v As MsoOrgChartLayoutType Ptr) As HRESULT
		Declare Abstract Function Let_Layout (Byval Type_v As MsoOrgChartLayoutType) As HRESULT
		Declare Abstract Function Get_TextShape (Byval Shape As Shape Ptr Ptr) As HRESULT
	End Type 'DiagramNode_

	Type CanvasShapes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function AddCallout (Byval Type_v As MsoCalloutType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Callout As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddConnector (Byval Type_v As MsoConnectorType, Byval BeginX As Single, Byval BeginY As Single, Byval EndX As Single, Byval EndY As Single, Byval Connector As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddCurve (Byval SafeArrayOfPoints As Variant Ptr, Byval Curve As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddLabel (Byval Orientation As MsoTextOrientation, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Label As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddLine (Byval BeginX As Single, Byval BeginY As Single, Byval EndX As Single, Byval EndY As Single, Byval Line As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddPicture (Byval FileName As BSTR, Byval LinkToFile As MsoTriState, Byval SaveWithDocument As MsoTriState, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Picture As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddPolyline (Byval SafeArrayOfPoints As Variant Ptr, Byval Polyline As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddShape (Byval Type_v As MsoAutoShapeType, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Shape As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddTextEffect (Byval PresetTextEffect As MsoPresetTextEffect, Byval Text As BSTR, Byval FontName As BSTR, Byval FontSize As Single, Byval FontBold As MsoTriState, Byval FontItalic As MsoTriState, Byval Left As Single, Byval Top As Single, Byval TextEffect As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function AddTextbox (Byval Orientation As MsoTextOrientation, Byval Left As Single, Byval Top As Single, Byval Width As Single, Byval Height As Single, Byval Textbox As Shape Ptr Ptr) As HRESULT
		Declare Abstract Function BuildFreeform (Byval EditingType As MsoEditingType, Byval X1 As Single, Byval Y1 As Single, Byval FreeformBuilder As FreeformBuilder Ptr Ptr) As HRESULT
		Declare Abstract Function Range (Byval Index As Variant Ptr, Byval Range_v As ShapeRange Ptr Ptr) As HRESULT
		Declare Abstract Function SelectAll () As HRESULT
		Declare Abstract Function Get_Background (Byval Background As Shape Ptr Ptr) As HRESULT
	End Type 'CanvasShapes_

	Type OfficeDataSourceObject_ Extends CAIDispatch
		Declare Abstract Function Get_ConnectString (Byval pbstrConnect As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_ConnectString (Byval pbstrConnect As BSTR) As HRESULT
		Declare Abstract Function Get_Table (Byval pbstrTable As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Table (Byval pbstrTable As BSTR) As HRESULT
		Declare Abstract Function Get_DataSource (Byval pbstrSrc As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_DataSource (Byval pbstrSrc As BSTR) As HRESULT
		Declare Abstract Function Get_Columns (Byval ppColumns As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_RowCount (Byval pcRows As Long Ptr) As HRESULT
		Declare Abstract Function Get_Filters (Byval ppFilters As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Move (Byval MsoMoveRow As MsoMoveRow, Byval RowNbr As Long, Byval rval As Long Ptr) As HRESULT
		Declare Abstract Function Open (Byval bstrSrc As BSTR, Byval bstrConnect As BSTR, Byval bstrTable As BSTR, Byval fOpenExclusive As Long, Byval fNeverPrompt As Long) As HRESULT
		Declare Abstract Function SetSortOrder (Byval SortField1 As BSTR, Byval SortAscending1 As VARIANT_BOOL, Byval SortField2 As BSTR, Byval SortAscending2 As VARIANT_BOOL, Byval SortField3 As BSTR, Byval SortAscending3 As VARIANT_BOOL) As HRESULT
		Declare Abstract Function ApplyFilter () As HRESULT
	End Type 'OfficeDataSourceObject_

	Type ODSOColumn_ Extends _IMsoDispObj
		Declare Abstract Function Get_Index (Byval plIndex As Long Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Value (Byval pbstrValue As BSTR Ptr) As HRESULT
	End Type 'ODSOColumn_

	Type ODSOColumns_ Extends _IMsoDispObj
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParentOdso As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval varIndex As Variant Ptr, Byval ppColumn As IDispatch Ptr Ptr) As HRESULT
	End Type 'ODSOColumns_

	Type ODSOFilter_ Extends _IMsoDispObj
		Declare Abstract Function Get_Index (Byval plIndex As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Column (Byval pbstrCol As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Column (Byval pbstrCol As BSTR) As HRESULT
		Declare Abstract Function Get_Comparison (Byval pComparison As MsoFilterComparison Ptr) As HRESULT
		Declare Abstract Function Let_Comparison (Byval pComparison As MsoFilterComparison) As HRESULT
		Declare Abstract Function Get_CompareTo (Byval pbstrCompareTo As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_CompareTo (Byval pbstrCompareTo As BSTR) As HRESULT
		Declare Abstract Function Get_Conjunction (Byval pConjunction As MsoFilterConjunction Ptr) As HRESULT
		Declare Abstract Function Let_Conjunction (Byval pConjunction As MsoFilterConjunction) As HRESULT
	End Type 'ODSOFilter_

	Type ODSOFilters_ Extends _IMsoDispObj
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParentOdso As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Long, Byval ppColumn As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Column As BSTR, Byval Comparison As MsoFilterComparison, Byval Conjunction As MsoFilterConjunction, Byval bstrCompareTo As BSTR, Byval DeferUpdate As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Delete_ (Byval Index As Long, Byval DeferUpdate As VARIANT_BOOL) As HRESULT
	End Type 'ODSOFilters_

	Type NewFile_ Extends _IMsoDispObj
		Declare Abstract Function Add (Byval FileName As BSTR, Byval Section As Variant Ptr, Byval DisplayName As Variant Ptr, Byval Action As Variant Ptr, Byval pvarf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Remove (Byval FileName As BSTR, Byval Section As Variant Ptr, Byval DisplayName As Variant Ptr, Byval Action As Variant Ptr, Byval pvarf As VARIANT_BOOL Ptr) As HRESULT
	End Type 'NewFile_

	Type WebComponent_ Extends CAIDispatch
		Declare Abstract Function Get_Shape (Byval RetValue As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_URL (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_URL (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_HTML (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_HTML (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_Name (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_Width (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval RetValue As Long) As HRESULT
		Declare Abstract Function Get_Height (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval RetValue As Long) As HRESULT
		Declare Abstract Function SetPlaceHolderGraphic (Byval PlaceHolderGraphic As BSTR) As HRESULT
		Declare Abstract Function Commit () As HRESULT
		Declare Abstract Function Revert () As HRESULT
	End Type 'WebComponent_

	Type WebComponentWindowExternal_ Extends CAIDispatch
		Declare Abstract Function Get_InterfaceVersion (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Get_ApplicationName (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ApplicationVersion (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval RetValue As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function CloseWindow () As HRESULT
		Declare Abstract Function Get_WebComponent (Byval RetValue As WebComponent Ptr Ptr) As HRESULT
	End Type 'WebComponentWindowExternal_

	Type WebComponentFormat_ Extends CAIDispatch
		Declare Abstract Function Get_Application (Byval RetValue As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_URL (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_URL (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_HTML (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_HTML (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_Name (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_Width (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval RetValue As Long) As HRESULT
		Declare Abstract Function Get_Height (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval RetValue As Long) As HRESULT
		Declare Abstract Function Get_PreviewGraphic (Byval retval As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_PreviewGraphic (Byval retval As BSTR) As HRESULT
		Declare Abstract Function LaunchPropertiesWindow () As HRESULT
	End Type 'WebComponentFormat_

	Type ILicWizExternal_ Extends CAIDispatch
		Declare Abstract Function PrintHtmlDocument (Byval punkHtmlDoc As IUnknown Ptr) As HRESULT
		Declare Abstract Function InvokeDateTimeApplet () As HRESULT
		Declare Abstract Function FormatDate (Byval date As Date_, Byval pFormat As BSTR, Byval pDateString As BSTR Ptr) As HRESULT
		Declare Abstract Function ShowHelp (Byval pvarId As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Terminate () As HRESULT
		Declare Abstract Function DisableVORWReminder (Byval BPC As Long) As HRESULT
		Declare Abstract Function SaveReceipt (Byval bstrReceipt As BSTR, Byval pbstrPath As BSTR Ptr) As HRESULT
		Declare Abstract Function OpenInDefaultBrowser (Byval bstrUrl As BSTR) As HRESULT
		Declare Abstract Function MsoAlert (Byval bstrText As BSTR, Byval bstrButtons As BSTR, Byval bstrIcon As BSTR, Byval plRet As Long Ptr) As HRESULT
		Declare Abstract Function DepositPidKey (Byval bstrKey As BSTR, Byval fMORW As Long, Byval plRet As Long Ptr) As HRESULT
		Declare Abstract Function WriteLog (Byval bstrMessage As BSTR) As HRESULT
		Declare Abstract Function ResignDpc (Byval bstrProductCode As BSTR) As HRESULT
		Declare Abstract Function ResetPID () As HRESULT
		Declare Abstract Function SetDialogSize (Byval dx As Long, Byval dy As Long) As HRESULT
		Declare Abstract Function VerifyClock (Byval lMode As Long, Byval plRet As Long Ptr) As HRESULT
		Declare Abstract Function SortSelectOptions (Byval pdispSelect As IDispatch Ptr) As HRESULT
		Declare Abstract Function InternetDisconnect () As HRESULT
		Declare Abstract Function GetConnectedState (Byval pfConnected As Long Ptr) As HRESULT
		Declare Abstract Function Get_Context (Byval plwctx As Long Ptr) As HRESULT
		Declare Abstract Function Get_Validator (Byval ppdispValidator As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LicAgent (Byval ppdispLicAgent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CountryInfo (Byval pbstrUrl As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_WizardVisible (Byval RHS As Long) As HRESULT
		Declare Abstract Function Let_WizardTitle (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_AnimationEnabled (Byval fEnabled As Long Ptr) As HRESULT
		Declare Abstract Function Let_CurrentHelpId (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_OfficeOnTheWebUrl (Byval bstrUrl As BSTR Ptr) As HRESULT
	End Type 'ILicWizExternal_

	Type ILicValidator_ Extends CAIDispatch
		Declare Abstract Function Get_Products (Byval pVariant As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Selection (Byval piSel As Long Ptr) As HRESULT
		Declare Abstract Function Let_Selection (Byval piSel As Long) As HRESULT
	End Type 'ILicValidator_

	Type ILicAgent_ Extends CAIDispatch
		Declare Abstract Function Initialize (Byval dwBPC As ULong, Byval dwMode As ULong, Byval bstrLicSource As BSTR, Byval pdwRetCode As ULong Ptr) As HRESULT
		Declare Abstract Function GetFirstName (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetFirstName (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetLastName (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetLastName (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetOrgName (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetOrgName (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetEmail (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetEmail (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetPhone (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetPhone (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetAddress1 (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetAddress1 (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetCity (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetCity (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetState (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetState (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetCountryCode (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetCountryCode (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetCountryDesc (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetCountryDesc (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetZip (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetZip (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetIsoLanguage (Byval pdwVal As ULong Ptr) As HRESULT
		Declare Abstract Function SetIsoLanguage (Byval dwNewVal As ULong) As HRESULT
		Declare Abstract Function GetMSUpdate (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetMSUpdate (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetMSOffer (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetMSOffer (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetOtherOffer (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetOtherOffer (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetAddress2 (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetAddress2 (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function CheckSystemClock (Byval pdwRetCode As ULong Ptr) As HRESULT
		Declare Abstract Function GetExistingExpiryDate (Byval pDateVal As Date_ Ptr) As HRESULT
		Declare Abstract Function GetNewExpiryDate (Byval pDateVal As Date_ Ptr) As HRESULT
		Declare Abstract Function GetBillingFirstName (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingFirstName (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingLastName (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingLastName (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingPhone (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingPhone (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingAddress1 (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingAddress1 (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingAddress2 (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingAddress2 (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingCity (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingCity (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingState (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingState (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingCountryCode (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingCountryCode (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function GetBillingZip (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function SetBillingZip (Byval bstrNewVal As BSTR) As HRESULT
		Declare Abstract Function SaveBillingInfo (Byval bSave As Long, Byval pdwRetVal As ULong Ptr) As HRESULT
		Declare Abstract Function IsCCRenewalCountry (Byval bstrCountryCode As BSTR, Byval pbRetVal As Long Ptr) As HRESULT
		Declare Abstract Function GetVATLabel (Byval bstrCountryCode As BSTR, Byval pbstrVATLabel As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCCRenewalExpiryDate (Byval pDateVal As Date_ Ptr) As HRESULT
		Declare Abstract Function SetVATNumber (Byval bstrVATNumber As BSTR) As HRESULT
		Declare Abstract Function SetCreditCardType (Byval bstrCCCode As BSTR) As HRESULT
		Declare Abstract Function SetCreditCardNumber (Byval bstrCCNumber As BSTR) As HRESULT
		Declare Abstract Function SetCreditCardExpiryYear (Byval dwCCYear As ULong) As HRESULT
		Declare Abstract Function SetCreditCardExpiryMonth (Byval dwCCMonth As ULong) As HRESULT
		Declare Abstract Function GetCreditCardCount (Byval pdwCount As ULong Ptr) As HRESULT
		Declare Abstract Function GetCreditCardCode (Byval dwIndex As ULong, Byval pbstrCode As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCreditCardName (Byval dwIndex As ULong, Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function GetVATNumber (Byval pbstrVATNumber As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCreditCardType (Byval pbstrCCCode As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCreditCardNumber (Byval pbstrCCNumber As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCreditCardExpiryYear (Byval pdwCCYear As ULong Ptr) As HRESULT
		Declare Abstract Function GetCreditCardExpiryMonth (Byval pdwCCMonth As ULong Ptr) As HRESULT
		Declare Abstract Function GetDisconnectOption (Byval pbRetVal As Long Ptr) As HRESULT
		Declare Abstract Function SetDisconnectOption (Byval bNewVal As Long) As HRESULT
		Declare Abstract Function AsyncProcessHandshakeRequest (Byval bReviseCustInfo As Long) As HRESULT
		Declare Abstract Function AsyncProcessNewLicenseRequest () As HRESULT
		Declare Abstract Function AsyncProcessReissueLicenseRequest () As HRESULT
		Declare Abstract Function AsyncProcessRetailRenewalLicenseRequest () As HRESULT
		Declare Abstract Function AsyncProcessReviseCustInfoRequest () As HRESULT
		Declare Abstract Function AsyncProcessCCRenewalPriceRequest () As HRESULT
		Declare Abstract Function AsyncProcessCCRenewalLicenseRequest () As HRESULT
		Declare Abstract Function GetAsyncProcessReturnCode (Byval pdwRetCode As ULong Ptr) As HRESULT
		Declare Abstract Function IsUpgradeAvailable (Byval pbUpgradeAvailable As Long Ptr) As HRESULT
		Declare Abstract Function WantUpgrade (Byval bWantUpgrade As Long) As HRESULT
		Declare Abstract Function AsyncProcessDroppedLicenseRequest () As HRESULT
		Declare Abstract Function GenerateInstallationId (Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function DepositConfirmationId (Byval bstrVal As BSTR, Byval pdwRetCode As ULong Ptr) As HRESULT
		Declare Abstract Function VerifyCheckDigits (Byval bstrCIDIID As BSTR, Byval pbValue As Long Ptr) As HRESULT
		Declare Abstract Function GetCurrentExpiryDate (Byval pDateVal As Date_ Ptr) As HRESULT
		Declare Abstract Function CancelAsyncProcessRequest (Byval bIsLicenseRequest As Long) As HRESULT
		Declare Abstract Function GetCurrencyDescription (Byval dwCurrencyIndex As ULong, Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function GetPriceItemCount (Byval pdwCount As ULong Ptr) As HRESULT
		Declare Abstract Function GetPriceItemLabel (Byval dwIndex As ULong, Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function GetPriceItemValue (Byval dwCurrencyIndex As ULong, Byval dwIndex As ULong, Byval pbstrVal As BSTR Ptr) As HRESULT
		Declare Abstract Function GetInvoiceText (Byval pNewVal As BSTR Ptr) As HRESULT
		Declare Abstract Function GetBackendErrorMsg (Byval pbstrErrMsg As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCurrencyOption (Byval dwCurrencyOption As ULong Ptr) As HRESULT
		Declare Abstract Function SetCurrencyOption (Byval dwCurrencyOption As ULong) As HRESULT
		Declare Abstract Function GetEndOfLifeHtmlText (Byval pbstrHtmlText As BSTR Ptr) As HRESULT
		Declare Abstract Function DisplaySSLCert (Byval dwRetCode As ULong Ptr) As HRESULT
	End Type 'ILicAgent_

	Type IMsoEServicesDialog_ Extends CAIDispatch
		Declare Abstract Function Close (Byval ApplyWebComponentChanges As VARIANT_BOOL) As HRESULT
		Declare Abstract Function AddTrustedDomain (Byval Domain As BSTR) As HRESULT
		Declare Abstract Function Get_ApplicationName (Byval retval As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppdisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_WebComponent (Byval ppdisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ClipArt (Byval ppdisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoEServicesDialog_

	Type WebComponentProperties_ Extends CAIDispatch
		Declare Abstract Function Get_Shape (Byval RetValue As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_URL (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_URL (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_HTML (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_HTML (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_PreviewGraphic (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_PreviewGraphic (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_PreviewHTML (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_PreviewHTML (Byval RetValue As BSTR) As HRESULT
		Declare Abstract Function Get_Width (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval RetValue As Long) As HRESULT
		Declare Abstract Function Get_Height (Byval RetValue As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval RetValue As Long) As HRESULT
		Declare Abstract Function Get_Tag (Byval RetValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Tag (Byval RetValue As BSTR) As HRESULT
	End Type 'WebComponentProperties_

	Type SmartDocument_ Extends _IMsoDispObj
		Declare Abstract Function Get_SolutionID (Byval pbstrID As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SolutionID (Byval pbstrID As BSTR) As HRESULT
		Declare Abstract Function Get_SolutionURL (Byval pbstrUrl As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SolutionURL (Byval pbstrUrl As BSTR) As HRESULT
		Declare Abstract Function PickSolution (Byval ConsiderAllSchemas As VARIANT_BOOL) As HRESULT
		Declare Abstract Function RefreshPane () As HRESULT
	End Type 'SmartDocument_

	Type SharedWorkspaceMember_ Extends _IMsoDispObj
		Declare Abstract Function Get_DomainName (Byval pbstrDomainName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Email (Byval pbstrEmail As BSTR Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Id (Byval Id As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'SharedWorkspaceMember_

	Type SharedWorkspaceMembers_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As SharedWorkspaceMember Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval Email As BSTR, Byval DomainName As BSTR, Byval DisplayName As BSTR, Byval Role As Variant Ptr, Byval ppMember As SharedWorkspaceMember Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ItemCountExceeded (Byval pf As VARIANT_BOOL Ptr) As HRESULT
	End Type 'SharedWorkspaceMembers_

	Type SharedWorkspaceTask_ Extends _IMsoDispObj
		Declare Abstract Function Get_Title (Byval Title As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Title (Byval Title As BSTR) As HRESULT
		Declare Abstract Function Get_AssignedTo (Byval AssignedTo As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_AssignedTo (Byval AssignedTo As BSTR) As HRESULT
		Declare Abstract Function Get_Status (Byval Status As MsoSharedWorkspaceTaskStatus Ptr) As HRESULT
		Declare Abstract Function Let_Status (Byval Status As MsoSharedWorkspaceTaskStatus) As HRESULT
		Declare Abstract Function Get_Priority (Byval Priority As MsoSharedWorkspaceTaskPriority Ptr) As HRESULT
		Declare Abstract Function Let_Priority (Byval Priority As MsoSharedWorkspaceTaskPriority) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Description (Byval Description As BSTR) As HRESULT
		Declare Abstract Function Get_DueDate (Byval DueDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_DueDate (Byval DueDate As Variant Ptr) As HRESULT
		Declare Abstract Function Get_CreatedBy (Byval CreatedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CreatedDate (Byval CreatedDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedBy (Byval ModifiedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedDate (Byval ModifiedDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Save () As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'SharedWorkspaceTask_

	Type SharedWorkspaceTasks_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As SharedWorkspaceTask Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval Title As BSTR, Byval Status As Variant Ptr, Byval Priority As Variant Ptr, Byval Assignee As Variant Ptr, Byval Description As Variant Ptr, Byval DueDate As Variant Ptr, Byval ppTask As SharedWorkspaceTask Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ItemCountExceeded (Byval pf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
	End Type 'SharedWorkspaceTasks_

	Type SharedWorkspaceFile_ Extends _IMsoDispObj
		Declare Abstract Function Get_URL (Byval pbstrFilename As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CreatedBy (Byval pbstrCreatedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CreatedDate (Byval CreatedDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedBy (Byval pbstrModifiedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedDate (Byval ModifiedDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'SharedWorkspaceFile_

	Type SharedWorkspaceFiles_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As SharedWorkspaceFile Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval FileName As BSTR, Byval ParentFolder As Variant Ptr, Byval OverwriteIfFileAlreadyExists As Variant Ptr, Byval KeepInSync As Variant Ptr, Byval ppFile As SharedWorkspaceFile Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ItemCountExceeded (Byval pf As VARIANT_BOOL Ptr) As HRESULT
	End Type 'SharedWorkspaceFiles_

	Type SharedWorkspaceFolder_ Extends _IMsoDispObj
		Declare Abstract Function Get_FolderName (Byval FolderName As BSTR Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval DeleteEventIfFolderContainsFiles As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'SharedWorkspaceFolder_

	Type SharedWorkspaceFolders_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As SharedWorkspaceFolder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval FolderName As BSTR, Byval ParentFolder As Variant Ptr, Byval ppFolder As SharedWorkspaceFolder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ItemCountExceeded (Byval pf As VARIANT_BOOL Ptr) As HRESULT
	End Type 'SharedWorkspaceFolders_

	Type SharedWorkspaceLink_ Extends _IMsoDispObj
		Declare Abstract Function Get_URL (Byval URL As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_URL (Byval URL As BSTR) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Description (Byval Description As BSTR) As HRESULT
		Declare Abstract Function Get_Notes (Byval Notes As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Notes (Byval Notes As BSTR) As HRESULT
		Declare Abstract Function Get_CreatedBy (Byval CreatedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CreatedDate (Byval CreatedDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedBy (Byval ModifiedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedDate (Byval ModifiedDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Save () As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'SharedWorkspaceLink_

	Type SharedWorkspaceLinks_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As SharedWorkspaceLink Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval URL As BSTR, Byval Description As Variant Ptr, Byval Notes As Variant Ptr, Byval ppLink As SharedWorkspaceLink Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ItemCountExceeded (Byval pf As VARIANT_BOOL Ptr) As HRESULT
	End Type 'SharedWorkspaceLinks_

	Type SharedWorkspace_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval Name As BSTR) As HRESULT
		Declare Abstract Function Get_Members (Byval ppMembers As SharedWorkspaceMembers Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Tasks (Byval ppTasks As SharedWorkspaceTasks Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Files (Byval ppFiles As SharedWorkspaceFiles Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Folders (Byval ppFolders As SharedWorkspaceFolders Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Links (Byval ppLinks As SharedWorkspaceLinks Ptr Ptr) As HRESULT
		Declare Abstract Function Refresh () As HRESULT
		Declare Abstract Function CreateNew (Byval URL As Variant Ptr, Byval Name As Variant Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_URL (Byval pbstrUrl As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Connected (Byval pfConnected As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_LastRefreshed (Byval pvarLastRefreshed As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SourceURL (Byval pbstrSourceURL As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SourceURL (Byval pbstrSourceURL As BSTR) As HRESULT
		Declare Abstract Function RemoveDocument () As HRESULT
		Declare Abstract Function Disconnect () As HRESULT
	End Type 'SharedWorkspace_

	Type Sync_ Extends _IMsoDispObj
		Declare Abstract Function Get_Status (Byval pStatusType As MsoSyncStatusType Ptr) As HRESULT
		Declare Abstract Function Get_WorkspaceLastChangedBy (Byval pbstrWorkspaceLastChangedBy As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_LastSyncTime (Byval pdatSavedTo As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ErrorType (Byval pErrorType As MsoSyncErrorType Ptr) As HRESULT
		Declare Abstract Function GetUpdate () As HRESULT
		Declare Abstract Function PutUpdate () As HRESULT
		Declare Abstract Function OpenVersion (Byval SyncVersionType As MsoSyncVersionType) As HRESULT
		Declare Abstract Function ResolveConflict (Byval SyncConflictResolution As MsoSyncConflictResolutionType) As HRESULT
		Declare Abstract Function Unsuspend () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'Sync_

	Type DocumentLibraryVersion_ Extends _IMsoDispObj
		Declare Abstract Function Get_Modified (Byval pvarDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Index (Byval lIndex As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ModifiedBy (Byval userName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Comments (Byval Comments As BSTR Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Open (Byval ppdispOpened As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Restore (Byval ppdispOpened As IDispatch Ptr Ptr) As HRESULT
	End Type 'DocumentLibraryVersion_

	Type DocumentLibraryVersions_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval lIndex As Long, Byval ppidisp As DocumentLibraryVersion Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval lCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IsVersioningEnabled (Byval pvarfVersioningOn As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
	End Type 'DocumentLibraryVersions_

	Type UserPermission_ Extends _IMsoDispObj
		Declare Abstract Function Get_UserId (Byval UserId As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Permission (Byval Permission As Long Ptr) As HRESULT
		Declare Abstract Function Let_Permission (Byval Permission As Long) As HRESULT
		Declare Abstract Function Get_ExpirationDate (Byval ExpirationDate As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ExpirationDate (Byval ExpirationDate As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Remove () As HRESULT
	End Type 'UserPermission_

	Type Permission_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval UserPerm As UserPermission Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get_EnableTrustedBrowser (Byval Enable As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_EnableTrustedBrowser (Byval Enable As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Add (Byval UserId As BSTR, Byval Permission As Variant Ptr, Byval ExpirationDate As Variant Ptr, Byval UserPerm As UserPermission Ptr Ptr) As HRESULT
		Declare Abstract Function ApplyPolicy (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function RemoveAll () As HRESULT
		Declare Abstract Function Get_Enabled (Byval Enabled As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Enabled (Byval Enabled As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_RequestPermissionURL (Byval Contact As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_RequestPermissionURL (Byval Contact As BSTR) As HRESULT
		Declare Abstract Function Get_PolicyName (Byval PolicyName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_PolicyDescription (Byval PolicyDescription As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_StoreLicenses (Byval Enabled As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_StoreLicenses (Byval Enabled As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_DocumentAuthor (Byval Author As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_DocumentAuthor (Byval Author As BSTR) As HRESULT
		Declare Abstract Function Get_PermissionFromPolicy (Byval FromPolicy As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'Permission_

	Type MsoDebugOptions_UTRunResult_ Extends _IMsoDispObj
		Declare Abstract Function Get_Passed (Byval Passed As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_ErrorString (Byval Error_v As BSTR Ptr) As HRESULT
	End Type 'MsoDebugOptions_UTRunResult_

	Type MsoDebugOptions_UT_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CollectionName (Byval pbstrColName As BSTR Ptr) As HRESULT
		Declare Abstract Function Run (Byval ppRunResult As MsoDebugOptions_UTRunResult Ptr Ptr) As HRESULT
	End Type 'MsoDebugOptions_UT_

	Type MsoDebugOptions_UTs_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppUnitTest As MsoDebugOptions_UT Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval iCountRetVal As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function GetUnitTestsInCollection (Byval bstrCollectionName As BSTR, Byval MsoDebugOptions_UTs As MsoDebugOptions_UTs Ptr Ptr) As HRESULT
		Declare Abstract Function GetUnitTest (Byval bstrCollectionName As BSTR, Byval bstrUnitTestName As BSTR, Byval MsoDebugOptions_UT As MsoDebugOptions_UT Ptr Ptr) As HRESULT
		Declare Abstract Function GetMatchingUnitTestsInCollection (Byval bstrCollectionName As BSTR, Byval bstrUnitTestNameFilter As BSTR, Byval MsoDebugOptions_UTs As MsoDebugOptions_UTs Ptr Ptr) As HRESULT
	End Type 'MsoDebugOptions_UTs_

	Type MsoDebugOptions_UTManager_ Extends _IMsoDispObj
		Declare Abstract Function Get_UnitTests (Byval ppMsoUnitTests As MsoDebugOptions_UTs Ptr Ptr) As HRESULT
		Declare Abstract Function NotifyStartOfTestSuiteRun () As HRESULT
		Declare Abstract Function NotifyEndOfTestSuiteRun () As HRESULT
		Declare Abstract Function Get_ReportErrors (Byval pfReportErrors As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ReportErrors (Byval pfReportErrors As VARIANT_BOOL) As HRESULT
	End Type 'MsoDebugOptions_UTManager_

	Type MetaProperty_ Extends _IMsoDispObj
		Declare Abstract Function Get_Value (Byval pvarValue As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Value (Byval pvarValue As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval pbstrID As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_IsReadOnly (Byval pfReadOnly As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_IsRequired (Byval pfRequired As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval ptype As MsoMetaPropertyType Ptr) As HRESULT
		Declare Abstract Function Validate (Byval pbstrError As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ValidationError (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'MetaProperty_

	Type MetaProperties_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval ppmp As MetaProperty Ptr Ptr) As HRESULT
		Declare Abstract Function GetItemByInternalName (Byval InternalName As BSTR, Byval ppmp As MetaProperty Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pc As Long Ptr) As HRESULT
		Declare Abstract Function Validate (Byval pbstrError As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ValidationError (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SchemaXml (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'MetaProperties_

	Type PolicyItem_ Extends _IMsoDispObj
		Declare Abstract Function Get_Id (Byval pbstrID As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval pbstrDescription As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Data (Byval pbstrStatement As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'PolicyItem_

	Type ServerPolicy_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval pppi As PolicyItem Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval pbstrID As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval pbstrDescription As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Statement (Byval pbstrStatement As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pc As Long Ptr) As HRESULT
		Declare Abstract Function Get_BlockPreview (Byval pfBlockPreview As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'ServerPolicy_

	Type DocumentInspector_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
		Declare Abstract Function Inspect (Byval Status As MsoDocInspectorStatus Ptr, Byval Results As BSTR Ptr) As HRESULT
		Declare Abstract Function Fix_ (Byval Status As MsoDocInspectorStatus Ptr, Byval Results As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'DocumentInspector_

	Type DocumentInspectors_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppidisp As DocumentInspector Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pcItems As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppidisp As IDispatch Ptr Ptr) As HRESULT
	End Type 'DocumentInspectors_

	Type WorkflowTask_ Extends _IMsoDispObj
		Declare Abstract Function Get_Id (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ListID (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_WorkflowID (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_AssignedTo (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_CreatedBy (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_DueDate (Byval pdate As Date_ Ptr) As HRESULT
		Declare Abstract Function Get_CreatedDate (Byval pdate As Date_ Ptr) As HRESULT
		Declare Abstract Function Show (Byval pRet As Long Ptr) As HRESULT
	End Type 'WorkflowTask_

	Type WorkflowTasks_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppret As WorkflowTask Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pCount As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'WorkflowTasks_

	Type WorkflowTemplate_ Extends _IMsoDispObj
		Declare Abstract Function Get_Id (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_DocumentLibraryName (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_DocumentLibraryURL (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Show (Byval pRet As Long Ptr) As HRESULT
	End Type 'WorkflowTemplate_

	Type WorkflowTemplates_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppret As WorkflowTemplate Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval pCount As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'WorkflowTemplates_

	Type SignatureSetup_ Extends _IMsoDispObj
		Declare Abstract Function Get_ReadOnly (Byval pvarf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_SignatureProvider (Byval pbstrSigProv As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_SuggestedSigner (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SuggestedSigner (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_SuggestedSignerLine2 (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SuggestedSignerLine2 (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_SuggestedSignerEmail (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SuggestedSignerEmail (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_SigningInstructions (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SigningInstructions (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_AllowComments (Byval pvarf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AllowComments (Byval pvarf As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowSignDate (Byval pvarf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowSignDate (Byval pvarf As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_AdditionalXml (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_AdditionalXml (Byval pbstr As BSTR) As HRESULT
	End Type 'SignatureSetup_

	Type SignatureInfo_ Extends _IMsoDispObj
		Declare Abstract Function Get_ReadOnly (Byval pvarf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_SignatureProvider (Byval pbstrSigProv As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_SignatureText (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SignatureText (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_SignatureImage (Byval ppipictdisp As stdole.Picture Ptr Ptr) As HRESULT
		Declare Abstract Function Let_SignatureImage (Byval ppipictdisp As stdole.Picture Ptr) As HRESULT
		Declare Abstract Function Get_SignatureComment (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SignatureComment (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function GetSignatureDetail (Byval sigdet As SignatureDetail, Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function GetCertificateDetail (Byval certdet As CertificateDetail, Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ContentVerificationResults (Byval pcontverres As ContentVerificationResults Ptr) As HRESULT
		Declare Abstract Function Get_CertificateVerificationResults (Byval pcertverres As CertificateVerificationResults Ptr) As HRESULT
		Declare Abstract Function Get_IsValid (Byval pvarfValid As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_IsCertificateExpired (Byval pvarfExpired As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_IsCertificateRevoked (Byval pvarfRevoked As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_IsCertificateUntrusted (Byval pvarfUntrusted As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function ShowSignatureCertificate (Byval ParentWindow As IUnknown Ptr) As HRESULT
		Declare Abstract Function SelectSignatureCertificate (Byval ParentWindow As IUnknown Ptr) As HRESULT
		Declare Abstract Function SelectCertificateDetailByThumbprint (Byval bstrThumbprint As BSTR) As HRESULT
	End Type 'SignatureInfo_

	Type SignatureProvider_ Extends CAIDispatch
		Declare Abstract Function GenerateSignatureLineImage (Byval siglnimg As SignatureLineImage, Byval psigsetup As SignatureSetup Ptr, Byval psiginfo As SignatureInfo Ptr, Byval XmlDsigStream As IUnknown Ptr, Byval ppipictdisp As stdole.Picture Ptr Ptr) As HRESULT
		Declare Abstract Function ShowSignatureSetup (Byval ParentWindow As IUnknown Ptr, Byval psigsetup As SignatureSetup Ptr) As HRESULT
		Declare Abstract Function ShowSigningCeremony (Byval ParentWindow As IUnknown Ptr, Byval psigsetup As SignatureSetup Ptr, Byval psiginfo As SignatureInfo Ptr) As HRESULT
		Declare Abstract Function SignXmlDsig (Byval QueryContinue As IUnknown Ptr, Byval psigsetup As SignatureSetup Ptr, Byval psiginfo As SignatureInfo Ptr, Byval XmlDsigStream As IUnknown Ptr) As HRESULT
		Declare Abstract Function NotifySignatureAdded (Byval ParentWindow As IUnknown Ptr, Byval psigsetup As SignatureSetup Ptr, Byval psiginfo As SignatureInfo Ptr) As HRESULT
		Declare Abstract Function VerifyXmlDsig (Byval QueryContinue As IUnknown Ptr, Byval psigsetup As SignatureSetup Ptr, Byval psiginfo As SignatureInfo Ptr, Byval XmlDsigStream As IUnknown Ptr, Byval pcontverres As ContentVerificationResults Ptr, Byval pcertverres As CertificateVerificationResults Ptr) As HRESULT
		Declare Abstract Function ShowSignatureDetails (Byval ParentWindow As IUnknown Ptr, Byval psigsetup As SignatureSetup Ptr, Byval psiginfo As SignatureInfo Ptr, Byval XmlDsigStream As IUnknown Ptr, Byval pcontverres As ContentVerificationResults Ptr, Byval pcertverres As CertificateVerificationResults Ptr) As HRESULT
		Declare Abstract Function GetProviderDetail (Byval sigprovdet As SignatureProviderDetail, Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function HashStream (Byval QueryContinue As IUnknown Ptr, Byval Stream As IUnknown Ptr, Byval ppsargb As SAFEARRAY Ptr) As HRESULT
	End Type 'SignatureProvider_

	Type CustomXMLPrefixMapping_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Prefix (Byval pbstrPrefix As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_NamespaceURI (Byval pbstrNamespaceURI As BSTR Ptr) As HRESULT
	End Type 'CustomXMLPrefixMapping_

	Type CustomXMLPrefixMappings_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval ppPrefixMapping As CustomXMLPrefixMapping Ptr Ptr) As HRESULT
		Declare Abstract Function AddNamespace (Byval Prefix As BSTR, Byval NamespaceURI As BSTR) As HRESULT
		Declare Abstract Function LookupNamespace (Byval Prefix As BSTR, Byval pbstrNamespaceURI As BSTR Ptr) As HRESULT
		Declare Abstract Function LookupPrefix (Byval NamespaceURI As BSTR, Byval pbstrPrefix As BSTR Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'CustomXMLPrefixMappings_

	Type CustomXMLSchema_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Location (Byval pbstrLocation As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_NamespaceURI (Byval pbstrNamespaceURI As BSTR Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Reload () As HRESULT
	End Type 'CustomXMLSchema_

	Type _CustomXMLSchemaCollection_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval ppSchema As CustomXMLSchema Ptr Ptr) As HRESULT
		Declare Abstract Function Get_NamespaceURI (Byval Index As Long, Byval pbstrNamespaceURI As BSTR Ptr) As HRESULT
		Declare Abstract Function Add (Byval NamespaceURI As BSTR, Byval Alias_v As BSTR, Byval FileName As BSTR, Byval InstallForAllUsers As VARIANT_BOOL, Byval ppSchema As CustomXMLSchema Ptr Ptr) As HRESULT
		Declare Abstract Function AddCollection (Byval SchemaCollection As CustomXMLSchemaCollection Ptr) As HRESULT
		Declare Abstract Function Validate (Byval pfResult As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type '_CustomXMLSchemaCollection_

	Type CustomXMLNodes_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppNode As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'CustomXMLNodes_

	Type CustomXMLNode_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Attributes (Byval ppAttributes As CustomXMLNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BaseName (Byval pbstrBaseName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_ChildNodes (Byval ppChildNodes As CustomXMLNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_FirstChild (Byval ppFirstChild As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_LastChild (Byval ppLastChild As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_NamespaceURI (Byval pbstrNamespaceURI As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_NextSibling (Byval ppNextSibling As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_NodeType (Byval pNodeType As MsoCustomXMLNodeType Ptr) As HRESULT
		Declare Abstract Function Get_NodeValue (Byval pbstrNodeValue As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NodeValue (Byval pbstrNodeValue As BSTR) As HRESULT
		Declare Abstract Function Get_OwnerDocument (Byval ppdispDoc As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_OwnerPart (Byval ppOwnerPart As CustomXMLPart Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PreviousSibling (Byval ppPreviousSibling As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ParentNode (Byval ppParentNode As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstrText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstrText As BSTR) As HRESULT
		Declare Abstract Function Get_XPath (Byval pbstrXPath As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_XML (Byval pbstrXML As BSTR Ptr) As HRESULT
		Declare Abstract Function AppendChildNode (Byval Name As BSTR, Byval NamespaceURI As BSTR, Byval NodeType As MsoCustomXMLNodeType, Byval NodeValue As BSTR) As HRESULT
		Declare Abstract Function AppendChildSubtree (Byval XML As BSTR) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function HasChildNodes (Byval pfHasChildNodes As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function InsertNodeBefore (Byval Name As BSTR, Byval NamespaceURI As BSTR, Byval NodeType As MsoCustomXMLNodeType, Byval NodeValue As BSTR, Byval NextSibling As CustomXMLNode Ptr) As HRESULT
		Declare Abstract Function InsertSubtreeBefore (Byval XML As BSTR, Byval NextSibling As CustomXMLNode Ptr) As HRESULT
		Declare Abstract Function RemoveChild (Byval Child As CustomXMLNode Ptr) As HRESULT
		Declare Abstract Function ReplaceChildNode (Byval OldNode As CustomXMLNode Ptr, Byval Name As BSTR, Byval NamespaceURI As BSTR, Byval NodeType As MsoCustomXMLNodeType, Byval NodeValue As BSTR) As HRESULT
		Declare Abstract Function ReplaceChildSubtree (Byval XML As BSTR, Byval OldNode As CustomXMLNode Ptr) As HRESULT
		Declare Abstract Function SelectNodes (Byval XPath As BSTR, Byval ppNodes As CustomXMLNodes Ptr Ptr) As HRESULT
		Declare Abstract Function SelectSingleNode (Byval XPath As BSTR, Byval ppNode As CustomXMLNode Ptr Ptr) As HRESULT
	End Type 'CustomXMLNode_

	Type CustomXMLValidationError_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstrName As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Node (Byval ppNode As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstrText As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval pErrorType As MsoCustomXMLValidationErrorType Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_ErrorCode (Byval plErrorCode As Long Ptr) As HRESULT
	End Type 'CustomXMLValidationError_

	Type CustomXMLValidationErrors_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Long, Byval ppError As CustomXMLValidationError Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Node As CustomXMLNode Ptr, Byval ErrorName As BSTR, Byval ErrorText As BSTR, Byval ClearedOnUpdate As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'CustomXMLValidationErrors_

	Type _CustomXMLPart_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DocumentElement (Byval ppDocumentElement As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval pbstrID As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_NamespaceURI (Byval pbstrNamespaceURI As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_SchemaCollection (Byval ppSchemaCollection As CustomXMLSchemaCollection Ptr Ptr) As HRESULT
		Declare Abstract Function Let_SchemaCollection (Byval ppSchemaCollection As CustomXMLSchemaCollection Ptr) As HRESULT
		Declare Abstract Function Get_NamespaceManager (Byval ppPrefixMappings As CustomXMLPrefixMappings Ptr Ptr) As HRESULT
		Declare Abstract Function Get_XML (Byval pbstrXML As BSTR Ptr) As HRESULT
		Declare Abstract Function AddNode (Byval Parent As CustomXMLNode Ptr, Byval Name As BSTR, Byval NamespaceURI As BSTR, Byval NextSibling As CustomXMLNode Ptr, Byval NodeType As MsoCustomXMLNodeType, Byval NodeValue As BSTR) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Load (Byval FilePath As BSTR, Byval pfRet As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function LoadXML (Byval XML As BSTR, Byval pfRet As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function SelectNodes (Byval XPath As BSTR, Byval ppNodes As CustomXMLNodes Ptr Ptr) As HRESULT
		Declare Abstract Function SelectSingleNode (Byval XPath As BSTR, Byval ppNode As CustomXMLNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Errors (Byval ppErrors As CustomXMLValidationErrors Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BuiltIn (Byval pfRet As VARIANT_BOOL Ptr) As HRESULT
	End Type '_CustomXMLPart_

	Type ICustomXMLPartEvents_ Extends CAIDispatch
		Declare Abstract Function NodeAfterInsert (Byval NewNode As CustomXMLNode Ptr, Byval InUndoRedo As VARIANT_BOOL) As HRESULT
		Declare Abstract Function NodeAfterDelete (Byval OldNode As CustomXMLNode Ptr, Byval OldParentNode As CustomXMLNode Ptr, Byval OldNextSibling As CustomXMLNode Ptr, Byval InUndoRedo As VARIANT_BOOL) As HRESULT
		Declare Abstract Function NodeAfterReplace (Byval OldNode As CustomXMLNode Ptr, Byval NewNode As CustomXMLNode Ptr, Byval InUndoRedo As VARIANT_BOOL) As HRESULT
	End Type 'ICustomXMLPartEvents_

	Type _CustomXMLPartEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function NodeAfterInsert (Byval NewNode As CustomXMLNode Ptr, Byval InUndoRedo As VARIANT_BOOL) As HRESULT
		' Declare Abstract Function NodeAfterDelete (Byval OldNode As CustomXMLNode Ptr, Byval OldParentNode As CustomXMLNode Ptr, Byval OldNextSibling As CustomXMLNode Ptr, Byval InUndoRedo As VARIANT_BOOL) As HRESULT
		' Declare Abstract Function NodeAfterReplace (Byval OldNode As CustomXMLNode Ptr, Byval NewNode As CustomXMLNode Ptr, Byval InUndoRedo As VARIANT_BOOL) As HRESULT
	End Type '_CustomXMLPartEvents_

	Type _CustomXMLParts_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval plCount As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval ppPart As CustomXMLPart Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval XML As BSTR, Byval SchemaCollection As Variant Ptr, Byval ppPart As CustomXMLPart Ptr Ptr) As HRESULT
		Declare Abstract Function SelectByID (Byval Id As BSTR, Byval ppPart As CustomXMLPart Ptr Ptr) As HRESULT
		Declare Abstract Function SelectByNamespace (Byval NamespaceURI As BSTR, Byval ppParts As CustomXMLParts Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppunkEnum As IUnknown Ptr Ptr) As HRESULT
	End Type '_CustomXMLParts_

	Type ICustomXMLPartsEvents_ Extends CAIDispatch
		Declare Abstract Function PartAfterAdd (Byval NewPart As CustomXMLPart Ptr) As HRESULT
		Declare Abstract Function PartBeforeDelete (Byval OldPart As CustomXMLPart Ptr) As HRESULT
		Declare Abstract Function PartAfterLoad (Byval Part As CustomXMLPart Ptr) As HRESULT
	End Type 'ICustomXMLPartsEvents_

	Type _CustomXMLPartsEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function PartAfterAdd (Byval NewPart As CustomXMLPart Ptr) As HRESULT
		' Declare Abstract Function PartBeforeDelete (Byval OldPart As CustomXMLPart Ptr) As HRESULT
		' Declare Abstract Function PartAfterLoad (Byval Part As CustomXMLPart Ptr) As HRESULT
	End Type '_CustomXMLPartsEvents_

	Type GradientStop_ Extends _IMsoDispObj
		Declare Abstract Function Get_Color (Byval Color As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Position (Byval Position As Single Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval Position As Single) As HRESULT
		Declare Abstract Function Get_Transparency (Byval Transparency As Single Ptr) As HRESULT
		Declare Abstract Function Let_Transparency (Byval Transparency As Single) As HRESULT
	End Type 'GradientStop_

	Type GradientStops_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval Item As GradientStop Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval Index As Long) As HRESULT
		Declare Abstract Function Insert (Byval RGB_v As Long, Byval Position As Single, Byval Transparency As Single, Byval Index As Long) As HRESULT
		Declare Abstract Function Insert2 (Byval RGB_v As Long, Byval Position As Single, Byval Transparency As Single, Byval Index As Long, Byval Brightness As Single) As HRESULT
	End Type 'GradientStops_

	Type SoftEdgeFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Type (Byval Type_v As MsoSoftEdgeType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoSoftEdgeType) As HRESULT
		Declare Abstract Function Get_Radius (Byval Radius As Single Ptr) As HRESULT
		Declare Abstract Function Let_Radius (Byval Radius As Single) As HRESULT
	End Type 'SoftEdgeFormat_

	Type GlowFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Radius (Byval Radius As Single Ptr) As HRESULT
		Declare Abstract Function Let_Radius (Byval Radius As Single) As HRESULT
		Declare Abstract Function Get_Color (Byval Color As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Transparency (Byval Transparency As Single Ptr) As HRESULT
		Declare Abstract Function Let_Transparency (Byval Transparency As Single) As HRESULT
	End Type 'GlowFormat_

	Type ReflectionFormat_ Extends _IMsoDispObj
		Declare Abstract Function Get_Type (Byval Type_v As MsoReflectionType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoReflectionType) As HRESULT
		Declare Abstract Function Get_Transparency (Byval Transparency As Single Ptr) As HRESULT
		Declare Abstract Function Let_Transparency (Byval Transparency As Single) As HRESULT
		Declare Abstract Function Get_Size (Byval Size As Single Ptr) As HRESULT
		Declare Abstract Function Let_Size (Byval Size As Single) As HRESULT
		Declare Abstract Function Get_Offset (Byval Offset As Single Ptr) As HRESULT
		Declare Abstract Function Let_Offset (Byval Offset As Single) As HRESULT
		Declare Abstract Function Get_Blur (Byval Blur As Single Ptr) As HRESULT
		Declare Abstract Function Let_Blur (Byval Blur As Single) As HRESULT
	End Type 'ReflectionFormat_

	Type ParagraphFormat2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Alignment (Byval Alignment As MsoParagraphAlignment Ptr) As HRESULT
		Declare Abstract Function Let_Alignment (Byval Alignment As MsoParagraphAlignment) As HRESULT
		Declare Abstract Function Get_BaselineAlignment (Byval BaselineAlignment As MsoBaselineAlignment Ptr) As HRESULT
		Declare Abstract Function Let_BaselineAlignment (Byval BaselineAlignment As MsoBaselineAlignment) As HRESULT
		Declare Abstract Function Get_Bullet (Byval Bullet As BulletFormat2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_FarEastLineBreakLevel (Byval Break As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_FarEastLineBreakLevel (Byval Break As MsoTriState) As HRESULT
		Declare Abstract Function Get_FirstLineIndent (Byval Indent As Single Ptr) As HRESULT
		Declare Abstract Function Let_FirstLineIndent (Byval Indent As Single) As HRESULT
		Declare Abstract Function Get_HangingPunctuation (Byval Hanging As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_HangingPunctuation (Byval Hanging As MsoTriState) As HRESULT
		Declare Abstract Function Get_IndentLevel (Byval Level As Long Ptr) As HRESULT
		Declare Abstract Function Let_IndentLevel (Byval Level As Long) As HRESULT
		Declare Abstract Function Get_LeftIndent (Byval Indent As Single Ptr) As HRESULT
		Declare Abstract Function Let_LeftIndent (Byval Indent As Single) As HRESULT
		Declare Abstract Function Get_LineRuleAfter (Byval LineRule As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_LineRuleAfter (Byval LineRule As MsoTriState) As HRESULT
		Declare Abstract Function Get_LineRuleBefore (Byval LineRule As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_LineRuleBefore (Byval LineRule As MsoTriState) As HRESULT
		Declare Abstract Function Get_LineRuleWithin (Byval LineRule As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_LineRuleWithin (Byval LineRule As MsoTriState) As HRESULT
		Declare Abstract Function Get_RightIndent (Byval Indent As Single Ptr) As HRESULT
		Declare Abstract Function Let_RightIndent (Byval Indent As Single) As HRESULT
		Declare Abstract Function Get_SpaceAfter (Byval Space As Single Ptr) As HRESULT
		Declare Abstract Function Let_SpaceAfter (Byval Space As Single) As HRESULT
		Declare Abstract Function Get_SpaceBefore (Byval Space As Single Ptr) As HRESULT
		Declare Abstract Function Let_SpaceBefore (Byval Space As Single) As HRESULT
		Declare Abstract Function Get_SpaceWithin (Byval Space As Single Ptr) As HRESULT
		Declare Abstract Function Let_SpaceWithin (Byval Space As Single) As HRESULT
		Declare Abstract Function Get_TabStops (Byval TabStops As TabStops2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextDirection (Byval Direction As MsoTextDirection Ptr) As HRESULT
		Declare Abstract Function Let_TextDirection (Byval Direction As MsoTextDirection) As HRESULT
		Declare Abstract Function Get_WordWrap (Byval WordWrap As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_WordWrap (Byval WordWrap As MsoTriState) As HRESULT
	End Type 'ParagraphFormat2_

	Type Font2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Bold (Byval Bold As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Bold (Byval Bold As MsoTriState) As HRESULT
		Declare Abstract Function Get_Italic (Byval Italic As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Italic (Byval Italic As MsoTriState) As HRESULT
		Declare Abstract Function Get_Strike (Byval Strike As MsoTextStrike Ptr) As HRESULT
		Declare Abstract Function Let_Strike (Byval Strike As MsoTextStrike) As HRESULT
		Declare Abstract Function Get_Caps (Byval Caps As MsoTextCaps Ptr) As HRESULT
		Declare Abstract Function Let_Caps (Byval Caps As MsoTextCaps) As HRESULT
		Declare Abstract Function Get_AutorotateNumbers (Byval RotateNumbers As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_AutorotateNumbers (Byval RotateNumbers As MsoTriState) As HRESULT
		Declare Abstract Function Get_BaselineOffset (Byval Offset As Single Ptr) As HRESULT
		Declare Abstract Function Let_BaselineOffset (Byval Offset As Single) As HRESULT
		Declare Abstract Function Get_Kerning (Byval KerningSize As Single Ptr) As HRESULT
		Declare Abstract Function Let_Kerning (Byval KerningSize As Single) As HRESULT
		Declare Abstract Function Get_Size (Byval Size As Single Ptr) As HRESULT
		Declare Abstract Function Let_Size (Byval Size As Single) As HRESULT
		Declare Abstract Function Get_Spacing (Byval Spacing As Single Ptr) As HRESULT
		Declare Abstract Function Let_Spacing (Byval Spacing As Single) As HRESULT
		Declare Abstract Function Get_UnderlineStyle (Byval Style As MsoTextUnderlineType Ptr) As HRESULT
		Declare Abstract Function Let_UnderlineStyle (Byval Style As MsoTextUnderlineType) As HRESULT
		Declare Abstract Function Get_Allcaps (Byval Allcaps As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Allcaps (Byval Allcaps As MsoTriState) As HRESULT
		Declare Abstract Function Get_DoubleStrikeThrough (Byval DoubleStrikeThrough As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_DoubleStrikeThrough (Byval DoubleStrikeThrough As MsoTriState) As HRESULT
		Declare Abstract Function Get_Equalize (Byval Equalize As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Equalize (Byval Equalize As MsoTriState) As HRESULT
		Declare Abstract Function Get_Fill (Byval Fill As FillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Glow (Byval Glow As GlowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Reflection (Byval Reflection As ReflectionFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Line (Byval Line As LineFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval Shadow As ShadowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Highlight (Byval Highlight As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_UnderlineColor (Byval UnderlineColor As ColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Smallcaps (Byval Smallcaps As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Smallcaps (Byval Smallcaps As MsoTriState) As HRESULT
		Declare Abstract Function Get_SoftEdgeFormat (Byval SoftEdgeFormat As MsoSoftEdgeType Ptr) As HRESULT
		Declare Abstract Function Let_SoftEdgeFormat (Byval SoftEdgeFormat As MsoSoftEdgeType) As HRESULT
		Declare Abstract Function Get_StrikeThrough (Byval StrikeThrough As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_StrikeThrough (Byval StrikeThrough As MsoTriState) As HRESULT
		Declare Abstract Function Get_Subscript (Byval Subscript As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Subscript (Byval Subscript As MsoTriState) As HRESULT
		Declare Abstract Function Get_Superscript (Byval Superscript As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Superscript (Byval Superscript As MsoTriState) As HRESULT
		Declare Abstract Function Get_WordArtformat (Byval WordArtformat As MsoPresetTextEffect Ptr) As HRESULT
		Declare Abstract Function Let_WordArtformat (Byval WordArtformat As MsoPresetTextEffect) As HRESULT
		Declare Abstract Function Get_Embeddable (Byval Embeddable As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Embedded (Byval Embedded As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval Name As BSTR) As HRESULT
		Declare Abstract Function Get_NameAscii (Byval NameAscii As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NameAscii (Byval NameAscii As BSTR) As HRESULT
		Declare Abstract Function Get_NameComplexScript (Byval NameComplexScript As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NameComplexScript (Byval NameComplexScript As BSTR) As HRESULT
		Declare Abstract Function Get_NameFarEast (Byval NameFarEast As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NameFarEast (Byval NameFarEast As BSTR) As HRESULT
		Declare Abstract Function Get_NameOther (Byval NameOther As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NameOther (Byval NameOther As BSTR) As HRESULT
	End Type 'Font2_

	Type TextColumn2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Number (Byval Number As Long Ptr) As HRESULT
		Declare Abstract Function Let_Number (Byval Number As Long) As HRESULT
		Declare Abstract Function Get_Spacing (Byval Spacing As Single Ptr) As HRESULT
		Declare Abstract Function Let_Spacing (Byval Spacing As Single) As HRESULT
		Declare Abstract Function Get_TextDirection (Byval Direction As MsoTextDirection Ptr) As HRESULT
		Declare Abstract Function Let_TextDirection (Byval Direction As MsoTextDirection) As HRESULT
	End Type 'TextColumn2_

	Type TextRange2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Text (Byval pbstrText As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstrText As BSTR) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Item_v As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Paragraphs (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Sentences (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Words (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Characters (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Lines (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Runs (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ParagraphFormat (Byval Format As ParagraphFormat2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval Font As Font2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Length (Byval Length As Long Ptr) As HRESULT
		Declare Abstract Function Get_Start (Byval Start As Long Ptr) As HRESULT
		Declare Abstract Function Get_BoundLeft (Byval BoundLeft As Single Ptr) As HRESULT
		Declare Abstract Function Get_BoundTop (Byval BoundTop As Single Ptr) As HRESULT
		Declare Abstract Function Get_BoundWidth (Byval BoundWidth As Single Ptr) As HRESULT
		Declare Abstract Function Get_BoundHeight (Byval BoundHeight As Single Ptr) As HRESULT
		Declare Abstract Function TrimText (Byval TrimText_v As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function InsertAfter (Byval NewText As BSTR, Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function InsertBefore (Byval NewText As BSTR, Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function InsertSymbol (Byval FontName As BSTR, Byval CharNumber As Long, Byval Unicode As MsoTriState, Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Select_ () As HRESULT
		Declare Abstract Function Cut () As HRESULT
		Declare Abstract Function Copy () As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Paste (Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function PasteSpecial (Byval Format As MsoClipboardFormat, Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function ChangeCase (Byval Type_v As MsoTextChangeCase) As HRESULT
		Declare Abstract Function AddPeriods () As HRESULT
		Declare Abstract Function RemovePeriods () As HRESULT
		Declare Abstract Function Find (Byval FindWhat As BSTR, Byval After As Long, Byval MatchCase As MsoTriState, Byval WholeWords As MsoTriState, Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Replace (Byval FindWhat As BSTR, Byval ReplaceWhat As BSTR, Byval After As Long, Byval MatchCase As MsoTriState, Byval WholeWords As MsoTriState, Byval TextRange As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function RotatedBounds (Byval X1 As Single Ptr, Byval Y1 As Single Ptr, Byval X2 As Single Ptr, Byval Y2 As Single Ptr, Byval X3 As Single Ptr, Byval Y3 As Single Ptr, Byval x4 As Single Ptr, Byval y4 As Single Ptr) As HRESULT
		Declare Abstract Function Get_LanguageID (Byval LanguageID As MsoLanguageID Ptr) As HRESULT
		Declare Abstract Function Let_LanguageID (Byval LanguageID As MsoLanguageID) As HRESULT
		Declare Abstract Function RtlRun () As HRESULT
		Declare Abstract Function LtrRun () As HRESULT
		Declare Abstract Function Get_MathZones (Byval Start As Long, Byval Length As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function InsertChartField (Byval ChartFieldType As MsoChartFieldType, Byval Formula As BSTR, Byval Position As Long, Byval Range As TextRange2 Ptr Ptr) As HRESULT
	End Type 'TextRange2_

	Type TextFrame2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_MarginBottom (Byval MarginBottom As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginBottom (Byval MarginBottom As Single) As HRESULT
		Declare Abstract Function Get_MarginLeft (Byval MarginLeft As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginLeft (Byval MarginLeft As Single) As HRESULT
		Declare Abstract Function Get_MarginRight (Byval MarginRight As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginRight (Byval MarginRight As Single) As HRESULT
		Declare Abstract Function Get_MarginTop (Byval MarginTop As Single Ptr) As HRESULT
		Declare Abstract Function Let_MarginTop (Byval MarginTop As Single) As HRESULT
		Declare Abstract Function Get_Orientation (Byval Orientation As MsoTextOrientation Ptr) As HRESULT
		Declare Abstract Function Let_Orientation (Byval Orientation As MsoTextOrientation) As HRESULT
		Declare Abstract Function Get_HorizontalAnchor (Byval HorizontalAnchor As MsoHorizontalAnchor Ptr) As HRESULT
		Declare Abstract Function Let_HorizontalAnchor (Byval HorizontalAnchor As MsoHorizontalAnchor) As HRESULT
		Declare Abstract Function Get_VerticalAnchor (Byval VerticalAnchor As MsoVerticalAnchor Ptr) As HRESULT
		Declare Abstract Function Let_VerticalAnchor (Byval VerticalAnchor As MsoVerticalAnchor) As HRESULT
		Declare Abstract Function Get_PathFormat (Byval PathFormat As MsoPathFormat Ptr) As HRESULT
		Declare Abstract Function Let_PathFormat (Byval PathFormat As MsoPathFormat) As HRESULT
		Declare Abstract Function Get_WarpFormat (Byval WarpFormat As MsoWarpFormat Ptr) As HRESULT
		Declare Abstract Function Let_WarpFormat (Byval WarpFormat As MsoWarpFormat) As HRESULT
		Declare Abstract Function Get_WordArtformat (Byval WordArtformat As MsoPresetTextEffect Ptr) As HRESULT
		Declare Abstract Function Let_WordArtformat (Byval WordArtformat As MsoPresetTextEffect) As HRESULT
		Declare Abstract Function Get_WordWrap (Byval WordWrap As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_WordWrap (Byval WordWrap As MsoTriState) As HRESULT
		Declare Abstract Function Get_AutoSize (Byval AutoSize As MsoAutoSize Ptr) As HRESULT
		Declare Abstract Function Let_AutoSize (Byval AutoSize As MsoAutoSize) As HRESULT
		Declare Abstract Function Get_ThreeD (Byval ThreeD As ThreeDFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasText (Byval pHasText As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_TextRange (Byval Range As TextRange2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Column (Byval Column As TextColumn2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Ruler (Byval Ruler As Ruler2 Ptr Ptr) As HRESULT
		Declare Abstract Function DeleteText () As HRESULT
		Declare Abstract Function Get_NoTextRotation (Byval NoTextRotation As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_NoTextRotation (Byval NoTextRotation As MsoTriState) As HRESULT
	End Type 'TextFrame2_

	Type ThemeColor_ Extends _IMsoDispObj
		Declare Abstract Function Get_RGB (Byval RGB_v As Long Ptr) As HRESULT
		Declare Abstract Function Let_RGB (Byval RGB_v As Long) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThemeColorSchemeIndex (Byval pValue As MsoThemeColorSchemeIndex Ptr) As HRESULT
	End Type 'ThemeColor_

	Type ThemeColorScheme_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Colors (Byval Index As MsoThemeColorSchemeIndex, Byval Color As ThemeColor Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Load (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Save (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function GetCustomColor (Byval Name As BSTR, Byval CustomColor As Long Ptr) As HRESULT
	End Type 'ThemeColorScheme_

	Type ThemeFont_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval Val As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval Val As BSTR) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
	End Type 'ThemeFont_

	Type ThemeFonts_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As MsoFontLanguageIndex, Byval Val As ThemeFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval ppienum As IUnknown Ptr Ptr) As HRESULT
	End Type 'ThemeFonts_

	Type ThemeFontScheme_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Load (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Save (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Get_MinorFont (Byval MinorFont As ThemeFonts Ptr Ptr) As HRESULT
		Declare Abstract Function Get_MajorFont (Byval MajorFont As ThemeFonts Ptr Ptr) As HRESULT
	End Type 'ThemeFontScheme_

	Type ThemeEffectScheme_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Load (Byval FileName As BSTR) As HRESULT
	End Type 'ThemeEffectScheme_

	Type OfficeTheme_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThemeColorScheme (Byval ThemeColorScheme As ThemeColorScheme Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThemeFontScheme (Byval ThemeFontScheme As ThemeFontScheme Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThemeEffectScheme (Byval ThemeEffectScheme As ThemeEffectScheme Ptr Ptr) As HRESULT
	End Type 'OfficeTheme_

	Type _CustomTaskPane_ Extends CAIDispatch
		Declare Abstract Function Get_Title (Byval prop As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval prop As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Window (Byval prop As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Visible (Byval prop As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval prop As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ContentControl (Byval prop As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval prop As Long Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval prop As Long) As HRESULT
		Declare Abstract Function Get_Width (Byval prop As Long Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval prop As Long) As HRESULT
		Declare Abstract Function Get_DockPosition (Byval prop As MsoCTPDockPosition Ptr) As HRESULT
		Declare Abstract Function Let_DockPosition (Byval prop As MsoCTPDockPosition) As HRESULT
		Declare Abstract Function Get_DockPositionRestrict (Byval prop As MsoCTPDockPositionRestrict Ptr) As HRESULT
		Declare Abstract Function Let_DockPositionRestrict (Byval prop As MsoCTPDockPositionRestrict) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
	End Type '_CustomTaskPane_

	Type CustomTaskPaneEvents_ Extends CAIDispatch
		Declare Abstract Function VisibleStateChange (Byval CustomTaskPaneInst As _CustomTaskPane Ptr) As HRESULT
		Declare Abstract Function DockPositionStateChange (Byval CustomTaskPaneInst As _CustomTaskPane Ptr) As HRESULT
	End Type 'CustomTaskPaneEvents_

	Type _CustomTaskPaneEvents_ Extends CAIDispatch ' Dispinterface接口仅支持后期绑定!
		' Declare Abstract Function VisibleStateChange (Byval CustomTaskPaneInst As _CustomTaskPane Ptr) As HRESULT
		' Declare Abstract Function DockPositionStateChange (Byval CustomTaskPaneInst As _CustomTaskPane Ptr) As HRESULT
	End Type '_CustomTaskPaneEvents_

	Type ICTPFactory_ Extends CAIDispatch
		Declare Abstract Function CreateCTP (Byval CTPAxID As BSTR, Byval CTPTitle As BSTR, Byval CTPParentWindow As Variant Ptr, Byval CTPInst As _CustomTaskPane Ptr Ptr) As HRESULT
	End Type 'ICTPFactory_

	Type ICustomTaskPaneConsumer_ Extends CAIDispatch
		Declare Abstract Function CTPFactoryAvailable (Byval CTPFactoryInst As ICTPFactory Ptr) As HRESULT
	End Type 'ICustomTaskPaneConsumer_

	Type IRibbonUI_ Extends CAIDispatch
		Declare Abstract Function Invalidate () As HRESULT
		Declare Abstract Function InvalidateControl (Byval ControlID As BSTR) As HRESULT
		Declare Abstract Function InvalidateControlMso (Byval ControlID As BSTR) As HRESULT
		Declare Abstract Function ActivateTab (Byval ControlID As BSTR) As HRESULT
		Declare Abstract Function ActivateTabMso (Byval ControlID As BSTR) As HRESULT
		Declare Abstract Function ActivateTabQ (Byval ControlID As BSTR, Byval Namespace_v As BSTR) As HRESULT
	End Type 'IRibbonUI_

	Type IRibbonControl_ Extends CAIDispatch
		Declare Abstract Function Get_Id (Byval Id As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Context (Byval Context As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Tag (Byval Tag As BSTR Ptr) As HRESULT
	End Type 'IRibbonControl_

	Type IRibbonExtensibility_ Extends CAIDispatch
		Declare Abstract Function GetCustomUI (Byval RibbonID As BSTR, Byval RibbonXml As BSTR Ptr) As HRESULT
	End Type 'IRibbonExtensibility_

	Type IAssistance_ Extends CAIDispatch
		Declare Abstract Function ShowHelp (Byval HelpId As BSTR, Byval Scope_v As BSTR) As HRESULT
		Declare Abstract Function SearchHelp (Byval Query As BSTR, Byval Scope_v As BSTR) As HRESULT
		Declare Abstract Function SetDefaultContext (Byval HelpId As BSTR) As HRESULT
		Declare Abstract Function ClearDefaultContext (Byval HelpId As BSTR) As HRESULT
	End Type 'IAssistance_

	Type IMsoChartData_ Extends CAIDispatch
		Declare Abstract Function Get_Workbook (Byval ppdispWorkbook As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Activate () As HRESULT
		Declare Abstract Function Get_IsLinked (Byval pfIsLinked As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function BreakLink () As HRESULT
		Declare Abstract Function ActivateChartDataWindow () As HRESULT
	End Type 'IMsoChartData_

	Type IMsoChart_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_HasTitle (Byval fTitle As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasTitle (Byval fTitle As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_ChartTitle (Byval pval As IMsoChartTitle Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DepthPercent (Byval pwDepthPercent As Long Ptr) As HRESULT
		Declare Abstract Function Let_DepthPercent (Byval pwDepthPercent As Long) As HRESULT
		Declare Abstract Function Get_Elevation (Byval pwElevation As Long Ptr) As HRESULT
		Declare Abstract Function Let_Elevation (Byval pwElevation As Long) As HRESULT
		Declare Abstract Function Get_GapDepth (Byval pwGapDepth As Long Ptr) As HRESULT
		Declare Abstract Function Let_GapDepth (Byval pwGapDepth As Long) As HRESULT
		Declare Abstract Function Get_HeightPercent (Byval pwHeightPercent As Long Ptr) As HRESULT
		Declare Abstract Function Let_HeightPercent (Byval pwHeightPercent As Long) As HRESULT
		Declare Abstract Function Get_Perspective (Byval pwPerspective As Long Ptr) As HRESULT
		Declare Abstract Function Let_Perspective (Byval pwPerspective As Long) As HRESULT
		Declare Abstract Function Get_RightAngleAxes (Byval pvarRightAngleAxes As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_RightAngleAxes (Byval pvarRightAngleAxes As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Rotation (Byval pvarRotation As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Rotation (Byval pvarRotation As Variant Ptr) As HRESULT
		Declare Abstract Function Let_DisplayBlanksAs (Byval pres As XlDisplayBlanksAs) As HRESULT
		Declare Abstract Function Get_DisplayBlanksAs (Byval pres As XlDisplayBlanksAs Ptr) As HRESULT
		Declare Abstract Function Let_ProtectData (Byval pres As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ProtectData (Byval pres As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ProtectFormatting (Byval pres As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ProtectFormatting (Byval pres As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ProtectGoalSeek (Byval pres As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ProtectGoalSeek (Byval pres As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ProtectSelection (Byval pres As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ProtectSelection (Byval pres As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ProtectChartObjects (Byval pres As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ProtectChartObjects (Byval pres As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function UnProtect (Byval Password As Variant Ptr) As HRESULT
		Declare Abstract Function Protect (Byval Password As Variant Ptr, Byval DrawingObjects As Variant Ptr, Byval Contents As Variant Ptr, Byval Scenarios As Variant Ptr, Byval UserInterfaceOnly As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ChartGroups (Byval pvarIndex As Variant Ptr Ptr, Byval varIgallery As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function SeriesCollection (Byval Index As Variant Ptr, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function _ApplyDataLabels (Byval Type_v As XlDataLabelsType, Byval IMsoLegendKey As Variant Ptr, Byval AutoText As Variant Ptr, Byval HasLeaderLines As Variant Ptr) As HRESULT
		Declare Abstract Function Get_SubType (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_SubType (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_Type (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_Corners (Byval RHS As IMsoCorners Ptr Ptr) As HRESULT
		Declare Abstract Function ApplyDataLabels (Byval Type_v As XlDataLabelsType, Byval IMsoLegendKey As Variant Ptr, Byval AutoText As Variant Ptr, Byval HasLeaderLines As Variant Ptr, Byval ShowSeriesName As Variant Ptr, Byval ShowCategoryName As Variant Ptr, Byval ShowValue As Variant Ptr, Byval ShowPercentage As Variant Ptr, Byval ShowBubbleSize As Variant Ptr, Byval Separator As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ChartType (Byval RHS As XlChartType Ptr) As HRESULT
		Declare Abstract Function Let_ChartType (Byval RHS As XlChartType) As HRESULT
		Declare Abstract Function Get_HasDataTable (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasDataTable (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function ApplyCustomType (Byval ChartType As XlChartType, Byval TypeName As Variant Ptr) As HRESULT
		Declare Abstract Function GetChartElement (Byval x As Long, Byval y As Long, Byval ElementID As Long Ptr, Byval Arg1 As Long Ptr, Byval Arg2 As Long Ptr) As HRESULT
		Declare Abstract Function SetSourceData (Byval Source As BSTR, Byval PlotBy As Variant Ptr) As HRESULT
		Declare Abstract Function Get_PlotBy (Byval PlotBy As XlRowCol Ptr) As HRESULT
		Declare Abstract Function Let_PlotBy (Byval PlotBy As XlRowCol) As HRESULT
		Declare Abstract Function Get_HasLegend (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasLegend (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Legend (Byval RHS As IMsoLegend Ptr Ptr) As HRESULT
		Declare Abstract Function Axes (Byval Type_v As Variant Ptr, Byval AxisGroup As XlAxisGroup, Byval ppAxes As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_HasAxis (Byval axisType As Variant Ptr, Byval AxisGroup As Variant Ptr, Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_HasAxis (Byval axisType As Variant Ptr, Byval AxisGroup As Variant Ptr, Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Walls (Byval fBackWall As VARIANT_BOOL, Byval ppwalls As IMsoWalls Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Floor (Byval ppfloor As IMsoFloor Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PlotArea (Byval ppplotarea As IMsoPlotArea Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PlotVisibleOnly (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_PlotVisibleOnly (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ChartArea (Byval ppchartarea As IMsoChartArea Ptr Ptr) As HRESULT
		Declare Abstract Function AutoFormat (Byval rGallery As Long, Byval varFormat As Variant Ptr) As HRESULT
		Declare Abstract Function Get_AutoScaling (Byval f As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaling (Byval f As VARIANT_BOOL) As HRESULT
		Declare Abstract Function SetBackgroundPicture (Byval bstr As BSTR) As HRESULT
		Declare Abstract Function ChartWizard (Byval varSource As Variant Ptr, Byval varGallery As Variant Ptr, Byval varFormat As Variant Ptr, Byval varPlotBy As Variant Ptr, Byval varCategoryLabels As Variant Ptr, Byval varSeriesLabels As Variant Ptr, Byval varHasLegend As Variant Ptr, Byval varTitle As Variant Ptr, Byval varCategoryTitle As Variant Ptr, Byval varValueTitle As Variant Ptr, Byval varExtraTitle As Variant Ptr, Byval LocaleID As Long) As HRESULT
		Declare Abstract Function CopyPicture (Byval Appearance As Long, Byval Format As Long, Byval Size As Long, Byval LocaleID As Long) As HRESULT
		Declare Abstract Function Get_DataTable (Byval RHS As IMsoDataTable Ptr Ptr) As HRESULT
		Declare Abstract Function Evaluate (Byval varName As Variant Ptr, Byval LocaleID As Long, Byval ObjType As Long Ptr, Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function _Evaluate (Byval varName As Variant Ptr, Byval LocaleID As Long, Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Paste (Byval varType As Variant Ptr, Byval LocaleID As Long) As HRESULT
		Declare Abstract Function Get_BarShape (Byval pShape As XlBarShape Ptr) As HRESULT
		Declare Abstract Function Let_BarShape (Byval pShape As XlBarShape) As HRESULT
		Declare Abstract Function Export_ (Byval bstr As BSTR, Byval varFilterName As Variant Ptr, Byval varInteractive As Variant Ptr, Byval f As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function SetDefaultChart (Byval varName As Variant Ptr) As HRESULT
		Declare Abstract Function ApplyChartTemplate (Byval bstrFileName As BSTR) As HRESULT
		Declare Abstract Function SaveChartTemplate (Byval bstrFileName As BSTR) As HRESULT
		Declare Abstract Function Get_SideWall (Byval RHS As IMsoWalls Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BackWall (Byval RHS As IMsoWalls Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ChartStyle (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ChartStyle (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function ClearToMatchStyle () As HRESULT
		Declare Abstract Function Get_PivotLayout (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasPivotFields (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasPivotFields (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function RefreshPivotTable () As HRESULT
		Declare Abstract Function Let_ShowDataLabelsOverMaximum (Byval pRHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowDataLabelsOverMaximum (Byval pRHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function ApplyLayout (Byval Layout As Long, Byval varChartType As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Selection (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Refresh () As HRESULT
		Declare Abstract Function SetElement (Byval RHS As MsoChartElementType) As HRESULT
		Declare Abstract Function Get_ChartData (Byval ppchartdata As IMsoChartData Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shapes (Byval ppShapes As Shapes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Area3DGroup (Byval lcid As Long, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function AreaGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Bar3DGroup (Byval lcid As Long, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function BarGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Column3DGroup (Byval lcid As Long, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function ColumnGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Line3DGroup (Byval lcid As Long, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function LineGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Pie3DGroup (Byval lcid As Long, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function PieGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function DoughnutGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function RadarGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SurfaceGroup (Byval lcid As Long, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function XYGroups (Byval Index As Variant Ptr, Byval lcid As Long, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Copy (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval Replace As Variant Ptr, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ShowReportFilterFieldButtons (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowReportFilterFieldButtons (Byval res As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowLegendFieldButtons (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowLegendFieldButtons (Byval res As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowAxisFieldButtons (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowAxisFieldButtons (Byval res As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowValueFieldButtons (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowValueFieldButtons (Byval res As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowAllFieldButtons (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowAllFieldButtons (Byval res As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Let_ProtectChartSheetFormatting (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function FullSeriesCollection (Byval Index As Variant Ptr, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Let_CategoryLabelLevel (Byval plevel As XlCategoryLabelLevel) As HRESULT
		Declare Abstract Function Get_CategoryLabelLevel (Byval plevel As XlCategoryLabelLevel Ptr) As HRESULT
		Declare Abstract Function Let_SeriesNameLevel (Byval plevel As XlSeriesNameLevel) As HRESULT
		Declare Abstract Function Get_SeriesNameLevel (Byval plevel As XlSeriesNameLevel Ptr) As HRESULT
		Declare Abstract Function Get_HasHiddenContent (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function DeleteHiddenContent () As HRESULT
		Declare Abstract Function Get_ChartColor (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ChartColor (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function ClearToMatchColorStyle () As HRESULT
		Declare Abstract Function Get_ShowExpandCollapseEntireFieldButtons (Byval res As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ShowExpandCollapseEntireFieldButtons (Byval res As VARIANT_BOOL) As HRESULT
	End Type 'IMsoChart_

	Type IMsoCorners_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoCorners_

	Type IMsoLegend_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval RHS As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function LegendEntries (Byval Index As Variant Ptr, Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Position (Byval RHS As XlLegendPosition Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval RHS As XlLegendPosition) As HRESULT
		Declare Abstract Function Get_Shadow (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Clear (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Interior (Byval RHS As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval RHS As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Top (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_Width (Byval RHS As Double Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval RHS As Double) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_IncludeInLayout (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_IncludeInLayout (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoLegend_

	Type IMsoBorder_ Extends CAIDispatch
		Declare Abstract Function Let_Color (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Color (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ColorIndex (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ColorIndex (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_LineStyle (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_LineStyle (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Weight (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Weight (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoBorder_

	Type IMsoWalls_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppfill As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PictureType (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_PictureType (Byval pvar As Variant Ptr) As HRESULT
		Declare Abstract Function Paste () As HRESULT
		Declare Abstract Function Get_PictureUnit (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_PictureUnit (Byval pvar As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Thickness (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Thickness (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoWalls_

	Type IMsoFloor_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppfill As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PictureType (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_PictureType (Byval pvar As Variant Ptr) As HRESULT
		Declare Abstract Function Paste () As HRESULT
		Declare Abstract Function Get_Thickness (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Let_Thickness (Byval RHS As Long) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoFloor_

	Type IMsoPlotArea_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function ClearFormats (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppfill As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Top (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Width (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_InsideLeft (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_InsideLeft (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_InsideTop (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_InsideTop (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_InsideWidth (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_InsideWidth (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_InsideHeight (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_InsideHeight (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Position (Byval pval As XlChartElementPosition Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval pval As XlChartElementPosition) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoPlotArea_

	Type IMsoChartArea_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Clear (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function ClearContents (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Copy (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval ppfont As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval pf As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval pf As VARIANT_BOOL) As HRESULT
		Declare Abstract Function ClearFormats (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Height (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppfill As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Top (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_Width (Byval pd As Double Ptr) As HRESULT
		Declare Abstract Function Let_Width (Byval pd As Double) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval pvar As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_RoundedCorners (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_RoundedCorners (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoChartArea_

	Type IMsoSeriesLines_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoSeriesLines_

	Type IMsoLeaderLines_ Extends CAIDispatch
		Declare Abstract Function Select_ () As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoLeaderLines_

	Type GridLines_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'GridLines_

	Type IMsoUpBars_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppfill As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoUpBars_

	Type IMsoDownBars_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval bstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppfill As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoDownBars_

	Type IMsoInterior_ Extends CAIDispatch
		Declare Abstract Function Let_Color (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Color (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ColorIndex (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ColorIndex (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_InvertIfNegative (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_InvertIfNegative (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Pattern (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Pattern (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_PatternColor (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_PatternColor (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_PatternColorIndex (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_PatternColorIndex (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoInterior_

	Type ChartFillFormat_ Extends CAIDispatch
		Declare Abstract Function OneColorGradient (Byval Style As Long, Byval Variant As Long, Byval Degree As Single) As HRESULT
		Declare Abstract Function TwoColorGradient (Byval Style As Long, Byval Variant As Long) As HRESULT
		Declare Abstract Function PresetTextured (Byval PresetTexture As Long) As HRESULT
		Declare Abstract Function Solid () As HRESULT
		Declare Abstract Function Patterned (Byval Pattern As Long) As HRESULT
		Declare Abstract Function UserPicture (Byval PictureFile As Variant Ptr, Byval PictureFormat As Variant Ptr, Byval PictureStackUnit As Variant Ptr, Byval PicturePlacement As Variant Ptr) As HRESULT
		Declare Abstract Function UserTextured (Byval TextureFile As BSTR) As HRESULT
		Declare Abstract Function PresetGradient (Byval Style As Long, Byval Variant As Long, Byval PresetGradientType As Long) As HRESULT
		Declare Abstract Function Get_BackColor (Byval pval As ChartColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ForeColor (Byval pval As ChartColorFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_GradientColorType (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_GradientDegree (Byval pval As Single Ptr) As HRESULT
		Declare Abstract Function Get_GradientStyle (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_GradientVariant (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Pattern (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_PresetGradientType (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_PresetTexture (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_TextureName (Byval pval As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_TextureType (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_Visible (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'ChartFillFormat_

	Type ChartFont_ Extends CAIDispatch
		Declare Abstract Function Let_Background (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Background (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Bold (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Bold (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Color (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Color (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ColorIndex (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_ColorIndex (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_FontStyle (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_FontStyle (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Italic (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Italic (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Name (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_OutlineFont (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_OutlineFont (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Size (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Size (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_StrikeThrough (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_StrikeThrough (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Subscript (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Subscript (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Superscript (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Superscript (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Underline (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Underline (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'ChartFont_

	Type Axes_ Extends CAIDispatch
		Declare Abstract Function Get_Count (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Item (Byval Type_v As XlAxisType, Byval AxisGroup As XlAxisGroup, Byval RHS As IMsoAxis Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval pval As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get__Default (Byval Type_v As XlAxisType, Byval AxisGroup As XlAxisGroup, Byval RHS As IMsoAxis Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'Axes_

	Type IMsoAxis_ Extends CAIDispatch
		Declare Abstract Function Get_AxisBetweenCategories (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_AxisBetweenCategories (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_AxisGroup (Byval pval As XlAxisGroup Ptr) As HRESULT
		Declare Abstract Function Get_AxisTitle (Byval pval As IMsoAxisTitle Ptr Ptr) As HRESULT
		Declare Abstract Function Get_CategoryNames (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_CategoryNames (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Crosses (Byval pval As XlAxisCrosses Ptr) As HRESULT
		Declare Abstract Function Let_Crosses (Byval pval As XlAxisCrosses) As HRESULT
		Declare Abstract Function Get_CrossesAt (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_CrossesAt (Byval pval As Double) As HRESULT
		Declare Abstract Function Delete_ (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_HasMajorGridlines (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasMajorGridlines (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasMinorGridlines (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasMinorGridlines (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasTitle (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasTitle (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MajorGridlines (Byval ppval As GridLines Ptr Ptr) As HRESULT
		Declare Abstract Function Get_MajorTickMark (Byval pval As XlTickMark Ptr) As HRESULT
		Declare Abstract Function Let_MajorTickMark (Byval pval As XlTickMark) As HRESULT
		Declare Abstract Function Get_MajorUnit (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_MajorUnit (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_LogBase (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_LogBase (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_TickLabelSpacingIsAuto (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_TickLabelSpacingIsAuto (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MajorUnitIsAuto (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MajorUnitIsAuto (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MaximumScale (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_MaximumScale (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_MaximumScaleIsAuto (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MaximumScaleIsAuto (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MinimumScale (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_MinimumScale (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_MinimumScaleIsAuto (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MinimumScaleIsAuto (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MinorGridlines (Byval ppval As GridLines Ptr Ptr) As HRESULT
		Declare Abstract Function Get_MinorTickMark (Byval pval As XlTickMark Ptr) As HRESULT
		Declare Abstract Function Let_MinorTickMark (Byval pval As XlTickMark) As HRESULT
		Declare Abstract Function Get_MinorUnit (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_MinorUnit (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_MinorUnitIsAuto (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MinorUnitIsAuto (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ReversePlotOrder (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_ReversePlotOrder (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ScaleType (Byval pval As XlScaleType Ptr) As HRESULT
		Declare Abstract Function Let_ScaleType (Byval pval As XlScaleType) As HRESULT
		Declare Abstract Function Select_ (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TickLabelPosition (Byval pval As XlTickLabelPosition Ptr) As HRESULT
		Declare Abstract Function Let_TickLabelPosition (Byval pval As XlTickLabelPosition) As HRESULT
		Declare Abstract Function Get_TickLabels (Byval pval As IMsoTickLabels Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TickLabelSpacing (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_TickLabelSpacing (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_TickMarkSpacing (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_TickMarkSpacing (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_Type (Byval pval As XlAxisType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval pval As XlAxisType) As HRESULT
		Declare Abstract Function Get_BaseUnit (Byval pval As XlTimeUnit Ptr) As HRESULT
		Declare Abstract Function Let_BaseUnit (Byval pval As XlTimeUnit) As HRESULT
		Declare Abstract Function Get_BaseUnitIsAuto (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_BaseUnitIsAuto (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_MajorUnitScale (Byval pval As XlTimeUnit Ptr) As HRESULT
		Declare Abstract Function Let_MajorUnitScale (Byval pval As XlTimeUnit) As HRESULT
		Declare Abstract Function Get_MinorUnitScale (Byval pval As XlTimeUnit Ptr) As HRESULT
		Declare Abstract Function Let_MinorUnitScale (Byval pval As XlTimeUnit) As HRESULT
		Declare Abstract Function Get_CategoryType (Byval pval As XlCategoryType Ptr) As HRESULT
		Declare Abstract Function Let_CategoryType (Byval pval As XlCategoryType) As HRESULT
		Declare Abstract Function Get_Left (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Width (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_DisplayUnit (Byval pval As XlDisplayUnit Ptr) As HRESULT
		Declare Abstract Function Let_DisplayUnit (Byval pval As XlDisplayUnit) As HRESULT
		Declare Abstract Function Get_DisplayUnitCustom (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_DisplayUnitCustom (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_HasDisplayUnitLabel (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasDisplayUnitLabel (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_DisplayUnitLabel (Byval pval As IMsoDisplayUnitLabel Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoAxis_

	Type IMsoDataTable_ Extends CAIDispatch
		Declare Abstract Function Let_ShowLegendKey (Byval pfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowLegendKey (Byval pfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasBorderHorizontal (Byval pfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasBorderHorizontal (Byval pfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasBorderVertical (Byval pfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasBorderVertical (Byval pfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasBorderOutline (Byval pfVisible As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasBorderOutline (Byval pfVisible As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppline As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval pfont As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Select_ () As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval RHS As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoDataTable_

	Type IMsoChartTitle_ Extends CAIDispatch
		Declare Abstract Function Let_Caption (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Caption (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Characters (Byval Start As Variant Ptr, Byval Length As Variant Ptr, Byval RHS As IMsoCharacters Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval ppfont As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Let_HorizontalAlignment (Byval Val As Variant Ptr) As HRESULT
		Declare Abstract Function Get_HorizontalAlignment (Byval Val As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Left (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_Left (Byval pval As Double) As HRESULT
		Declare Abstract Function Let_Orientation (Byval Val As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Orientation (Byval Val As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Shadow (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Let_Text (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Text (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Top (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_Top (Byval pval As Double) As HRESULT
		Declare Abstract Function Let_VerticalAlignment (Byval Val As Variant Ptr) As HRESULT
		Declare Abstract Function Get_VerticalAlignment (Byval Val As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ReadingOrder (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_ReadingOrder (Byval pval As Long) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval Val As Variant Ptr) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval Val As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Interior (Byval ppinterior As IMsoInterior Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fill (Byval ppinterior As ChartFillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval ppborder As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pval As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Select_ (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_IncludeInLayout (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_IncludeInLayout (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Position (Byval pval As XlChartElementPosition Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval pval As XlChartElementPosition) As HRESULT
		Declare Abstract Function Get_Format (Byval ppval As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Height (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Width (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_Formula (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_Formula (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaR1C1 (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaR1C1 (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaLocal (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaLocal (Byval pbstr As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_FormulaR1C1Local (Byval pbstr As BSTR) As HRESULT
		Declare Abstract Function Get_FormulaR1C1Local (Byval pbstr As BSTR Ptr) As HRESULT
	End Type 'IMsoChartTitle_

	Type IMsoAxisTitle_ Extends IMsoChartTitle
	End Type 'IMsoAxisTitle_

	Type IMsoDisplayUnitLabel_ Extends IMsoChartTitle
	End Type 'IMsoDisplayUnitLabel_

	Type IMsoTickLabels_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval ppval As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval pval As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_NumberFormat (Byval pval As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormat (Byval pval As BSTR) As HRESULT
		Declare Abstract Function Get_NumberFormatLinked (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormatLinked (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_NumberFormatLocal (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_NumberFormatLocal (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Orientation (Byval pval As XlTickLabelOrientation Ptr) As HRESULT
		Declare Abstract Function Let_Orientation (Byval pval As XlTickLabelOrientation) As HRESULT
		Declare Abstract Function Select_ (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ReadingOrder (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_ReadingOrder (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_AutoScaleFont (Byval pval As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_AutoScaleFont (Byval pval As Variant Ptr) As HRESULT
		Declare Abstract Function Get_Depth (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Offset (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_Offset (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_Alignment (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_Alignment (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_MultiLevel (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_MultiLevel (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoTickLabels_

	Type IMsoHyperlinks_ Extends CAIDispatch
	End Type 'IMsoHyperlinks_

	Type IMsoDropLines_ Extends CAIDispatch
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ () As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoDropLines_

	Type IMsoHiLoLines_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Select_ () As HRESULT
		Declare Abstract Function Get_Border (Byval RHS As IMsoBorder Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_Format (Byval ppChartFormat As IMsoChartFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoHiLoLines_

	Type IMsoChartGroup_ Extends CAIDispatch
		Declare Abstract Function Let_AxisGroup (Byval piGroup As Long) As HRESULT
		Declare Abstract Function Get_AxisGroup (Byval piGroup As Long Ptr) As HRESULT
		Declare Abstract Function Let_DoughnutHoleSize (Byval pDoughnutHoleSize As Long) As HRESULT
		Declare Abstract Function Get_DoughnutHoleSize (Byval pDoughnutHoleSize As Long Ptr) As HRESULT
		Declare Abstract Function Get_DownBars (Byval ppdownbars As IMsoDownBars Ptr Ptr) As HRESULT
		Declare Abstract Function Get_DropLines (Byval ppdroplines As IMsoDropLines Ptr Ptr) As HRESULT
		Declare Abstract Function Let_FirstSliceAngle (Byval pFirstSliceAngle As Long) As HRESULT
		Declare Abstract Function Get_FirstSliceAngle (Byval pFirstSliceAngle As Long Ptr) As HRESULT
		Declare Abstract Function Let_GapWidth (Byval pGapWidth As Long) As HRESULT
		Declare Abstract Function Get_GapWidth (Byval pGapWidth As Long Ptr) As HRESULT
		Declare Abstract Function Let_HasDropLines (Byval pfHasDropLines As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasDropLines (Byval pfHasDropLines As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasHiLoLines (Byval pfHasHiLoLines As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasHiLoLines (Byval pfHasHiLoLines As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasRadarAxisLabels (Byval pfHasRadarAxisLabels As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasRadarAxisLabels (Byval pfHasRadarAxisLabels As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasSeriesLines (Byval pfHasSeriesLines As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasSeriesLines (Byval pfHasSeriesLines As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_HasUpDownBars (Byval pfHasUpDownBars As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_HasUpDownBars (Byval pfHasUpDownBars As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_HiLoLines (Byval ppHiLoLines As IMsoHiLoLines Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Index (Byval pIndex As Long Ptr) As HRESULT
		Declare Abstract Function Let_Overlap (Byval pOverlap As Long) As HRESULT
		Declare Abstract Function Get_Overlap (Byval pOverlap As Long Ptr) As HRESULT
		Declare Abstract Function Get_RadarAxisLabels (Byval ppRadarAxisLabels As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function SeriesCollection (Byval Index As Variant Ptr, Byval ppSeriesCollection As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SeriesLines (Byval ppSeriesLines As IMsoSeriesLines Ptr Ptr) As HRESULT
		Declare Abstract Function Let_SubType (Byval pSubType As Long) As HRESULT
		Declare Abstract Function Get_SubType (Byval pSubType As Long Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval ptype As Long) As HRESULT
		Declare Abstract Function Get_Type (Byval ptype As Long Ptr) As HRESULT
		Declare Abstract Function Get_UpBars (Byval ppUpBars As IMsoUpBars Ptr Ptr) As HRESULT
		Declare Abstract Function Let_VaryByCategories (Byval pfVaryByCategories As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_VaryByCategories (Byval pfVaryByCategories As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Get_SizeRepresents (Byval pXlSizeRepresents As XlSizeRepresents Ptr) As HRESULT
		Declare Abstract Function Let_SizeRepresents (Byval pXlSizeRepresents As XlSizeRepresents) As HRESULT
		Declare Abstract Function Let_BubbleScale (Byval pbubblescale As Long) As HRESULT
		Declare Abstract Function Get_BubbleScale (Byval pbubblescale As Long Ptr) As HRESULT
		Declare Abstract Function Let_ShowNegativeBubbles (Byval pfShowNegativeBubbles As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_ShowNegativeBubbles (Byval pfShowNegativeBubbles As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_SplitType (Byval pChartSplitType As XlChartSplitType) As HRESULT
		Declare Abstract Function Get_SplitType (Byval pChartSplitType As XlChartSplitType Ptr) As HRESULT
		Declare Abstract Function Get_SplitValue (Byval pSplitValue As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_SplitValue (Byval pSplitValue As Variant Ptr) As HRESULT
		Declare Abstract Function Get_SecondPlotSize (Byval pSecondPlotSize As Long Ptr) As HRESULT
		Declare Abstract Function Let_SecondPlotSize (Byval pSecondPlotSize As Long) As HRESULT
		Declare Abstract Function Get_Has3DShading (Byval RHS As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_Has3DShading (Byval RHS As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function CategoryCollection (Byval Index As Variant Ptr, Byval ppcatcollection As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function FullCategoryCollection (Byval Index As Variant Ptr, Byval ppcatcollection As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_BinsType (Byval RHS As XlBinsType Ptr) As HRESULT
		Declare Abstract Function Let_BinsType (Byval RHS As XlBinsType) As HRESULT
		Declare Abstract Function Get_BinWidthValue (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_BinWidthValue (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_BinsCountValue (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Let_BinsCountValue (Byval pval As Long) As HRESULT
		Declare Abstract Function Get_BinsOverflowEnabled (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_BinsOverflowEnabled (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_BinsOverflowValue (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_BinsOverflowValue (Byval pval As Double) As HRESULT
		Declare Abstract Function Get_BinsUnderflowEnabled (Byval pval As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function Let_BinsUnderflowEnabled (Byval pval As VARIANT_BOOL) As HRESULT
		Declare Abstract Function Get_BinsUnderflowValue (Byval pval As Double Ptr) As HRESULT
		Declare Abstract Function Let_BinsUnderflowValue (Byval pval As Double) As HRESULT
	End Type 'IMsoChartGroup_

	Type ChartGroups_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RHS As IMsoChartGroup Ptr Ptr) As HRESULT
		Declare Abstract Function _NewEnum (Byval RHS As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'ChartGroups_

	Type IMsoCharacters_ Extends CAIDispatch
		Declare Abstract Function Get_Parent (Byval RHS As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Caption (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Caption (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_Count (Byval RHS As Long Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Font (Byval RHS As ChartFont Ptr Ptr) As HRESULT
		Declare Abstract Function Insert (Byval bstr As BSTR, Byval RHS As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Text (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Text (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_PhoneticCharacters (Byval RHS As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_PhoneticCharacters (Byval RHS As BSTR) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
	End Type 'IMsoCharacters_

	Type IMsoChartFormat_ Extends CAIDispatch
		Declare Abstract Function Get_Fill (Byval ppfill As FillFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Glow (Byval ppGlow As GlowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Line (Byval ppline As LineFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppParent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_PictureFormat (Byval ppPictureFormat As PictureFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Shadow (Byval ppShadow As ShadowFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_SoftEdge (Byval ppSoftEdge As SoftEdgeFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextFrame2 (Byval ppTextFrame As TextFrame2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ThreeD (Byval ppThreeD As ThreeDFormat Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Application (Byval ppval As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Creator (Byval pval As Long Ptr) As HRESULT
		Declare Abstract Function Get_Adjustments (Byval ppAdjustments As Adjustments Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AutoShapeType (Byval AutoShapeType As MsoAutoShapeType Ptr) As HRESULT
		Declare Abstract Function Let_AutoShapeType (Byval AutoShapeType As MsoAutoShapeType) As HRESULT
	End Type 'IMsoChartFormat_

	Type BulletFormat2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Character (Byval Character As Long Ptr) As HRESULT
		Declare Abstract Function Let_Character (Byval Character As Long) As HRESULT
		Declare Abstract Function Get_Font (Byval Font As Font2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Number (Byval Number As Long Ptr) As HRESULT
		Declare Abstract Function Picture (Byval FileName As BSTR) As HRESULT
		Declare Abstract Function Get_RelativeSize (Byval Size As Single Ptr) As HRESULT
		Declare Abstract Function Let_RelativeSize (Byval Size As Single) As HRESULT
		Declare Abstract Function Get_StartValue (Byval Start As Long Ptr) As HRESULT
		Declare Abstract Function Let_StartValue (Byval Start As Long) As HRESULT
		Declare Abstract Function Get_Style (Byval Style As MsoNumberedBulletStyle Ptr) As HRESULT
		Declare Abstract Function Let_Style (Byval Style As MsoNumberedBulletStyle) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoBulletType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoBulletType) As HRESULT
		Declare Abstract Function Get_UseTextColor (Byval UseTextColor As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_UseTextColor (Byval UseTextColor As MsoTriState) As HRESULT
		Declare Abstract Function Get_UseTextFont (Byval UseTextFont As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_UseTextFont (Byval UseTextFont As MsoTriState) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
	End Type 'BulletFormat2_

	Type TabStops2_ Extends _IMsoDispObj
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval TabStop As TabStop2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Add (Byval Type_v As MsoTabStopType, Byval Position As Single, Byval TabStop As TabStop2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get_DefaultSpacing (Byval Spacing As Single Ptr) As HRESULT
		Declare Abstract Function Let_DefaultSpacing (Byval Spacing As Single) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'TabStops2_

	Type TabStop2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Clear () As HRESULT
		Declare Abstract Function Get_Position (Byval Position As Single Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval Position As Single) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoTabStopType Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As MsoTabStopType) As HRESULT
	End Type 'TabStop2_

	Type Ruler2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Levels (Byval RulerLevels As RulerLevels2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TabStops (Byval TabStops As TabStops2 Ptr Ptr) As HRESULT
	End Type 'Ruler2_

	Type RulerLevels2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval RulerLevel As RulerLevel2 Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'RulerLevels2_

	Type RulerLevel2_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_FirstMargin (Byval FirstMargin As Single Ptr) As HRESULT
		Declare Abstract Function Let_FirstMargin (Byval FirstMargin As Single) As HRESULT
		Declare Abstract Function Get_LeftMargin (Byval LeftMargin As Single Ptr) As HRESULT
		Declare Abstract Function Let_LeftMargin (Byval LeftMargin As Single) As HRESULT
	End Type 'RulerLevel2_

	Type EncryptionProvider_ Extends CAIDispatch
		Declare Abstract Function GetProviderDetail (Byval encprovdet As EncryptionProviderDetail, Byval pvar As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function NewSession (Byval ParentWindow As IUnknown Ptr, Byval SessionHandle As Long Ptr) As HRESULT
		Declare Abstract Function Authenticate (Byval ParentWindow As IUnknown Ptr, Byval EncryptionData As IUnknown Ptr, Byval PermissionsMask As ULong Ptr, Byval SessionHandle As Long Ptr) As HRESULT
		Declare Abstract Function CloneSession (Byval SessionHandle As Long, Byval SessionHandleClone As Long Ptr) As HRESULT
		Declare Abstract Function EndSession (Byval SessionHandle As Long) As HRESULT
		Declare Abstract Function Save (Byval SessionHandle As Long, Byval EncryptionData As IUnknown Ptr, Byval EncryptionDataSize As Long Ptr) As HRESULT
		Declare Abstract Function EncryptStream (Byval SessionHandle As Long, Byval StreamName As BSTR, Byval UnencryptedStream As IUnknown Ptr, Byval EncryptedStream As IUnknown Ptr) As HRESULT
		Declare Abstract Function DecryptStream (Byval SessionHandle As Long, Byval StreamName As BSTR, Byval EncryptedStream As IUnknown Ptr, Byval UnencryptedStream As IUnknown Ptr) As HRESULT
		Declare Abstract Function ShowSettings (Byval SessionHandle As Long, Byval ParentWindow As IUnknown Ptr, Byval ReadOnly As VARIANT_BOOL, Byval Remove As VARIANT_BOOL Ptr) As HRESULT
	End Type 'EncryptionProvider_

	Type IBlogExtensibility_ Extends CAIDispatch
		Declare Abstract Function BlogProviderProperties (Byval BlogProvider As BSTR Ptr, Byval FriendlyName As BSTR Ptr, Byval CategorySupport As MsoBlogCategorySupport Ptr, Byval Padding As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function SetupBlogAccount (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval NewAccount As VARIANT_BOOL, Byval ShowPictureUI As VARIANT_BOOL Ptr) As HRESULT
		Declare Abstract Function GetUserBlogs (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval BlogNames As SAFEARRAY Ptr, Byval BlogIDs As SAFEARRAY Ptr, Byval BlogURLs As SAFEARRAY Ptr) As HRESULT
		Declare Abstract Function GetRecentPosts (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval PostTitles As SAFEARRAY Ptr, Byval PostDates As SAFEARRAY Ptr, Byval PostIDs As SAFEARRAY Ptr) As HRESULT
		Declare Abstract Function Open (Byval Account As BSTR, Byval PostID As BSTR, Byval ParentWindow As Long, Byval xHTML As BSTR Ptr, Byval Title As BSTR Ptr, Byval DatePosted As BSTR Ptr, Byval Categories As SAFEARRAY Ptr) As HRESULT
		Declare Abstract Function PublishPost (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval xHTML As BSTR, Byval Title As BSTR, Byval DateTime As BSTR, Byval Categories As SAFEARRAY, Byval Draft As VARIANT_BOOL, Byval PostID As BSTR Ptr, Byval PublishMessage As BSTR Ptr) As HRESULT
		Declare Abstract Function RepublishPost (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval PostID As BSTR, Byval xHTML As BSTR, Byval Title As BSTR, Byval DateTime As BSTR, Byval Categories As SAFEARRAY, Byval Draft As VARIANT_BOOL, Byval PublishMessage As BSTR Ptr) As HRESULT
		Declare Abstract Function GetCategories (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval Categories As SAFEARRAY Ptr) As HRESULT
	End Type 'IBlogExtensibility_

	Type IBlogPictureExtensibility_ Extends CAIDispatch
		Declare Abstract Function BlogPictureProviderProperties (Byval BlogPictureProvider As BSTR Ptr, Byval FriendlyName As BSTR Ptr) As HRESULT
		Declare Abstract Function CreatePictureAccount (Byval Account As BSTR, Byval BlogProvider As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr) As HRESULT
		Declare Abstract Function PublishPicture (Byval Account As BSTR, Byval ParentWindow As Long, Byval Document As IDispatch Ptr, Byval Image As IUnknown Ptr, Byval PictureURI As BSTR Ptr, Byval ImageType As Long) As HRESULT
	End Type 'IBlogPictureExtensibility_

	Type SmartArt_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_AllNodes (Byval Nodes As SmartArtNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Nodes (Byval Nodes As SmartArtNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Layout (Byval Layout As SmartArtLayout Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Layout (Byval Layout As SmartArtLayout Ptr) As HRESULT
		Declare Abstract Function Get_QuickStyle (Byval Style As SmartArtQuickStyle Ptr Ptr) As HRESULT
		Declare Abstract Function Let_QuickStyle (Byval Style As SmartArtQuickStyle Ptr) As HRESULT
		Declare Abstract Function Get_Color (Byval ColorStyle As SmartArtColor Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Color (Byval ColorStyle As SmartArtColor Ptr) As HRESULT
		Declare Abstract Function Get_Reverse (Byval Reverse As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Let_Reverse (Byval Reverse As MsoTriState) As HRESULT
		Declare Abstract Function Reset () As HRESULT
	End Type 'SmartArt_

	Type SmartArtNodes_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval SmartArtNode As SmartArtNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval NewNode As SmartArtNode Ptr Ptr) As HRESULT
	End Type 'SmartArtNodes_

	Type SmartArtNode_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function AddNode (Byval Position As MsoSmartArtNodePosition, Byval Type_v As MsoSmartArtNodeType, Byval NewNode As SmartArtNode Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Promote () As HRESULT
		Declare Abstract Function Demote () As HRESULT
		Declare Abstract Function Get_OrgChartLayout (Byval Type_v As MsoOrgChartLayoutType Ptr) As HRESULT
		Declare Abstract Function Let_OrgChartLayout (Byval Type_v As MsoOrgChartLayoutType) As HRESULT
		Declare Abstract Function Get_Shapes (Byval Shape As ShapeRange Ptr Ptr) As HRESULT
		Declare Abstract Function Get_TextFrame2 (Byval Frame As TextFrame2 Ptr Ptr) As HRESULT
		Declare Abstract Function Larger () As HRESULT
		Declare Abstract Function Smaller () As HRESULT
		Declare Abstract Function Get_Level (Byval Level As Long Ptr) As HRESULT
		Declare Abstract Function Get_Hidden (Byval Hidden As MsoTriState Ptr) As HRESULT
		Declare Abstract Function Get_Nodes (Byval Nodes As SmartArtNodes Ptr Ptr) As HRESULT
		Declare Abstract Function Get_ParentNode (Byval Node As SmartArtNode Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoSmartArtNodeType Ptr) As HRESULT
		Declare Abstract Function ReorderUp () As HRESULT
		Declare Abstract Function ReorderDown () As HRESULT
	End Type 'SmartArtNode_

	Type SmartArtLayouts_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval SmartArtLayout As SmartArtLayout Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
	End Type 'SmartArtLayouts_

	Type SmartArtLayout_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval LayoutId As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Category (Byval Category As BSTR Ptr) As HRESULT
	End Type 'SmartArtLayout_

	Type SmartArtQuickStyles_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval Style As SmartArtQuickStyle Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
	End Type 'SmartArtQuickStyles_

	Type SmartArtQuickStyle_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval StyleId As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Category (Byval Category As BSTR Ptr) As HRESULT
	End Type 'SmartArtQuickStyle_

	Type SmartArtColors_ Extends _IMsoDispObj
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Item (Byval Index As Variant Ptr, Byval SmartArtColor As SmartArtColor Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
	End Type 'SmartArtColors_

	Type SmartArtColor_ Extends _IMsoDispObj
		Declare Abstract Function Get_Parent (Byval Parent As IDispatch Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Id (Byval ColorStyleId As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Description (Byval Description As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Category (Byval Category As BSTR Ptr) As HRESULT
	End Type 'SmartArtColor_

	Type PickerField_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoPickerField Ptr) As HRESULT
		Declare Abstract Function Get_IsHidden (Byval IsHidden As VARIANT_BOOL Ptr) As HRESULT
	End Type 'PickerField_

	Type PickerFields_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval Field As PickerField Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'PickerFields_

	Type PickerProperty_ Extends _IMsoDispObj
		Declare Abstract Function Get_Id (Byval Id As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Value (Byval Value As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As MsoPickerField Ptr) As HRESULT
	End Type 'PickerProperty_

	Type PickerProperties_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval prop As PickerProperty Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval Id As BSTR, Byval Value As BSTR, Byval Type_v As MsoPickerField, Byval prop As PickerProperty Ptr Ptr) As HRESULT
		Declare Abstract Function Remove (Byval Id As BSTR) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'PickerProperties_

	Type PickerResult_ Extends _IMsoDispObj
		Declare Abstract Function Get_Id (Byval Id As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_DisplayName (Byval DisplayName As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_DisplayName (Byval DisplayName As BSTR) As HRESULT
		Declare Abstract Function Get_Type (Byval Type_v As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Type (Byval Type_v As BSTR) As HRESULT
		Declare Abstract Function Get_SIPId (Byval SIPId As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_SIPId (Byval SIPId As BSTR) As HRESULT
		Declare Abstract Function Get_ItemData (Byval ItemData As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_ItemData (Byval ItemData As Variant Ptr) As HRESULT
		Declare Abstract Function Get_SubItems (Byval SubItems As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_SubItems (Byval SubItems As Variant Ptr) As HRESULT
		Declare Abstract Function Get_DuplicateResults (Byval DuplicateResults As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Fields (Byval Fields As PickerFields Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Fields (Byval Fields As PickerFields Ptr) As HRESULT
	End Type 'PickerResult_

	Type PickerResults_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval Result As PickerResult Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Add (Byval Id As BSTR, Byval DisplayName As BSTR, Byval Type_v As BSTR, Byval SIPId As BSTR, Byval ItemData As Variant Ptr, Byval SubItems As Variant Ptr, Byval Result As PickerResult Ptr Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'PickerResults_

	Type PickerDialog_ Extends _IMsoDispObj
		Declare Abstract Function Get_DataHandlerId (Byval Id As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_DataHandlerId (Byval Id As BSTR) As HRESULT
		Declare Abstract Function Get_Title (Byval Title As BSTR Ptr) As HRESULT
		Declare Abstract Function Let_Title (Byval Title As BSTR) As HRESULT
		Declare Abstract Function Get_Properties (Byval Props As PickerProperties Ptr Ptr) As HRESULT
		Declare Abstract Function CreatePickerResults (Byval Results As PickerResults Ptr Ptr) As HRESULT
		Declare Abstract Function Show (Byval IsMultiSelect As VARIANT_BOOL, Byval ExistingResults As PickerResults Ptr, Byval Results As PickerResults Ptr Ptr) As HRESULT
		Declare Abstract Function Resolve (Byval TokenText As BSTR, Byval duplicateDlgMode As Long, Byval Results As PickerResults Ptr Ptr) As HRESULT
	End Type 'PickerDialog_

	Type IMsoContactCard_ Extends _IMsoDispObj
		Declare Abstract Function Get_Address (Byval pAddress As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_AddressType (Byval pAddressType As MsoContactCardAddressType Ptr) As HRESULT
		Declare Abstract Function Get_CardType (Byval pCardType As MsoContactCardType Ptr) As HRESULT
		Declare Abstract Function Get_Parent (Byval ppdispParent As IDispatch Ptr Ptr) As HRESULT
	End Type 'IMsoContactCard_

	Type EffectParameter_ Extends _IMsoDispObj
		Declare Abstract Function Get_Name (Byval Name As BSTR Ptr) As HRESULT
		Declare Abstract Function Get_Value (Byval Value As Variant Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Value (Byval Value As Variant Ptr) As HRESULT
	End Type 'EffectParameter_

	Type EffectParameters_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Variant Ptr, Byval EffectParameter As EffectParameter Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
	End Type 'EffectParameters_

	Type PictureEffect_ Extends _IMsoDispObj
		Declare Abstract Function Get_Type (Byval EffectType As MsoPictureEffectType Ptr) As HRESULT
		Declare Abstract Function Let_Position (Byval Position As Long) As HRESULT
		Declare Abstract Function Get_Position (Byval Position As Long Ptr) As HRESULT
		Declare Abstract Function Delete_ () As HRESULT
		Declare Abstract Function Get_EffectParameters (Byval EffectParameters As EffectParameters Ptr Ptr) As HRESULT
		Declare Abstract Function Let_Visible (Byval Visible As MsoTriState) As HRESULT
		Declare Abstract Function Get_Visible (Byval Visible As MsoTriState Ptr) As HRESULT
	End Type 'PictureEffect_

	Type PictureEffects_ Extends _IMsoDispObj
		Declare Abstract Function Get_Item (Byval Index As Long, Byval Item As PictureEffect Ptr Ptr) As HRESULT
		Declare Abstract Function Get_Count (Byval Count As Long Ptr) As HRESULT
		Declare Abstract Function Get__NewEnum (Byval _NewEnum As IUnknown Ptr Ptr) As HRESULT
		Declare Abstract Function Insert (Byval EffectType As MsoPictureEffectType, Byval Position As Long, Byval Effect As PictureEffect Ptr Ptr) As HRESULT
		Declare Abstract Function Delete_ (Byval Index As Long) As HRESULT
	End Type 'PictureEffects_

	Type Crop_ Extends _IMsoDispObj
		Declare Abstract Function Get_PictureOffsetX (Byval PictureOffsetX As Single Ptr) As HRESULT
		Declare Abstract Function Let_PictureOffsetX (Byval PictureOffsetX As Single) As HRESULT
		Declare Abstract Function Get_PictureOffsetY (Byval PictureOffsetY As Single Ptr) As HRESULT
		Declare Abstract Function Let_PictureOffsetY (Byval PictureOffsetY As Single) As HRESULT
		Declare Abstract Function Get_PictureWidth (Byval PictureWidth As Single Ptr) As HRESULT
		Declare Abstract Function Let_PictureWidth (Byval PictureWidth As Single) As HRESULT
		Declare Abstract Function Get_PictureHeight (Byval PictureHeight As Single Ptr) As HRESULT
		Declare Abstract Function Let_PictureHeight (Byval PictureHeight As Single) As HRESULT
		Declare Abstract Function Get_ShapeLeft (Byval ShapeLeft As Single Ptr) As HRESULT
		Declare Abstract Function Let_ShapeLeft (Byval ShapeLeft As Single) As HRESULT
		Declare Abstract Function Get_ShapeTop (Byval ShapeTop As Single Ptr) As HRESULT
		Declare Abstract Function Let_ShapeTop (Byval ShapeTop As Single) As HRESULT
		Declare Abstract Function Get_ShapeWidth (Byval ShapeWidth As Single Ptr) As HRESULT
		Declare Abstract Function Let_ShapeWidth (Byval ShapeWidth As Single) As HRESULT
		Declare Abstract Function Get_ShapeHeight (Byval ShapeHeight As Single Ptr) As HRESULT
		Declare Abstract Function Let_ShapeHeight (Byval ShapeHeight As Single) As HRESULT
	End Type 'Crop_

	Type ContactCard_ Extends _IMsoDispObj
		Declare Abstract Function Close () As HRESULT
		Declare Abstract Function Show (Byval CardStyle As MsoContactCardStyle, Byval RectangleLeft As Long, Byval RectangleRight As Long, Byval RectangleTop As Long, Byval RectangleBottom As Long, Byval HorizontalPosition As Long, Byval ShowWithDelay As VARIANT_BOOL) As HRESULT
	End Type 'ContactCard_

End Namespace