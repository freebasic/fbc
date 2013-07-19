#Ifndef __common_bi__
#Define __common_bi__

#Include Once "crt/stddef.bi"


#Ifdef __FB_WIN32__
#Define WXCALL StdCall
#Else
#Define WXCALL Cdecl
#EndIf

#Inclib "wx-c-0-9-0-2"


' filesystem >4GB
#Define wxHAS_HUGE_FILES

' none wxWidget classes
Type _ByteBuffer As Any : Type ByteBuffer As _ByteBuffer
Type _DisposableHtmlTagBox As Any : Type DisposableHtmlTagBox As _DisposableHtmlTagBox
Type _DisposableStringBox As Any : Type DisposableStringBox As _DisposableStringBox

' NET classes
Type _DotNetFileSystemHandler As Any : Type DotNetFileSystemHandler As _DotNetFileSystemHandler

' wxWidgets classes
Type _wxAcceleratorArrayNet As Any : Type wxAcceleratorArrayNet As _wxAcceleratorArrayNet
Type _wxAcceleratorEntry As Any : Type wxAcceleratorEntry As _wxAcceleratorEntry
Type _wxAcceleratorTable As Any : Type wxAcceleratorTable As _wxAcceleratorTable
Type _wxActivateEvent As Any : Type wxActivateEvent As _wxActivateEvent
Type _wxANIHandler As Any : Type wxANIHandler As _wxANIHandler
Type _wxApp As Any : Type wxApp As _wxApp
Type _wxArchiveEntry As Any : Type wxArchiveEntry As _wxArchiveEntry
Type _wxArchiveInputStream As Any : Type wxArchiveInputStream As _wxArchiveInputStream
Type _wxArchiveInputStreamPair As Any : Type wxArchiveInputStreamPair As _wxArchiveInputStreamPair
Type _wxArchiveOutputStreamPair As Any : Type wxArchiveOutputStreamPair As _wxArchiveOutputStreamPair
Type _wxArrayInt As Any : Type wxArrayInt As _wxArrayInt
Type _wxArrayIntPtr As Any : Type wxArrayIntPtr As _wxArrayIntPtr
Type _wxArrayString As Any : Type wxArrayString As _wxArrayString
Type _wxArrayTreeItemIds As Any : Type wxArrayTreeItemIds As _wxArrayTreeItemIds
Type _wxBitmap As Any : Type wxBitmap As _wxBitmap
Type _wxBitmapButton As Any : Type wxBitmapButton As _wxBitmapButton
Type _wxBitmapDataObject As Any : Type wxBitmapDataObject As _wxBitmapDataObject
Type _wxBitmapHandler As Any : Type wxBitmapHandler As _wxBitmapHandler
Type _wxBMPHandler As Any : Type wxBMPHandler As _wxBMPHandler
Type _wxBoxSizer As Any : Type wxBoxSizer As _wxBoxSizer
Type _wxBrush As Any : Type wxBrush As _wxBrush
Type _wxBrushList As Any : Type wxBrushList As _wxBrushList
Type _wxBufferedDC As Any : Type wxBufferedDC As _wxBufferedDC
Type _wxBufferedPaintDC As Any : Type wxBufferedPaintDC As _wxBufferedPaintDC
Type _wxBusyInfo As Any : Type wxBusyInfo As _wxBusyInfo
Type _wxButton As Any : Type wxButton As _wxButton
Type _wxCalculateLayoutEvent As Any : Type wxCalculateLayoutEvent As _wxCalculateLayoutEvent
Type _wxCalendarCtrl As Any : Type wxCalendarCtrl As _wxCalendarCtrl
Type _wxCalendarDateAttr As Any : Type wxCalendarDateAttr As _wxCalendarDateAttr
Type _wxCalendarEvent As Any : Type wxCalendarEvent As _wxCalendarEvent
Type _wxCaret As Any : Type wxCaret As _wxCaret
Type _wxCaretSuspend As Any : Type wxCaretSuspend As _wxCaretSuspend
Type _wxCheckBox As Any : Type wxCheckBox As _wxCheckBox
Type _wxCheckListBox As Any : Type wxCheckListBox As _wxCheckListBox
Type _wxChildFocusEvent As Any : Type wxChildFocusEvent As _wxChildFocusEvent
Type _wxChoice As Any : Type wxChoice As _wxChoice
Type _wxClassInfo As Any : Type wxClassInfo As _wxClassInfo
Type _wxClientDC As Any : Type wxClientDC As _wxClientDC
Type _wxClientData As Any : Type wxClientData As _wxClientData
Type _wxClipboard As Any : Type wxClipboard As _wxClipboard
Type _wxClipboardLocker As Any : Type wxClipBoardLocker As _wxClipboardLocker
Type _wxCloseEvent As Any : Type wxCloseEvent As _wxCloseEvent
Type _wxColour As Any : Type wxColour As _wxColour
Type _wxColourData As Any : Type wxColourData As _wxColourData
Type _wxColourDataBase As Any : Type wxColourDatabase As _wxColourDataBase
Type _wxColourDialog As Any : Type wxColourDialog As _wxColourDialog
Type _wxColourPickerCtrl As Any : Type wxColourPickerCtrl As _wxColourPickerCtrl
Type _wxColourPickerEvent As Any : Type wxColourPickerEvent As _wxColourPickerEvent
Type _wxComboBox As Any : Type wxComboBox As _wxComboBox
Type _wxComboCtrl As Any : Type wxComboCtrl As _wxComboCtrl
Type _wxComboPopup As Any : Type wxComboPopup As _wxComboPopup
Type _wxCommandEvent As Any : Type wxCommandEvent As _wxCommandEvent
Type _wxCommandProcessor As Any : Type wxCommandProcessor As _wxCommandProcessor
Type _wxConfigBase As Any : Type wxConfigBase As _wxConfigBase
Type _wxContextMenuEvent As Any : Type wxContextMenuEvent As _wxContextMenuEvent
Type _wxControl As Any : Type wxControl As _wxControl
Type _wxControlWithItems As Any : Type wxControlWithItems As _wxControlWithItems
Type _wxCURHandler As Any : Type wxCURHandler As _wxCURHandler
Type _wxCursor As Any : Type wxCursor As _wxCursor
Type _wxDateEvent As Any : Type wxDateEvent As _wxDateEvent
Type _wxDatePickerCtrl As Any : Type wxDatePickerCtrl As _wxDatePickerCtrl
Type _wxDataFormat As Any : Type wxDataFormat As _wxDataFormat
Type _wxDataObject As Any : Type wxDataObject As _wxDataObject
Type _wxDataObjectComposite As Any : Type wxDataObjectComposite As _wxDataObjectComposite
Type _wxDataObjectSimple As Any : Type wxDataObjectSimple As _wxDataObjectSimple
Type _wxDateTime As Any : Type wxDateTime As _wxDateTime
Type _wxDC As Any : Type wxDC As _wxDC
Type _wxDialog As Any : Type wxDialog As _wxDialog
Type _wxDirDialog As Any : Type wxDirDialog As _wxDirDialog
Type _wxDisplayChangedEvent As Any : Type wxDisplayChangedEvent As _wxDisplayChangedEvent
Type _wxDocument As Any : Type wxDocument As _wxDocument
Type _wxDocManager As Any : Type wxDocManager As _wxDocManager
Type _wxDocTemplate As Any : Type wxDocTemplate As _wxDocTemplate
Type _wxDropSource As Any : Type wxDropSource As _wxDropSource
Type _wxDropFilesEvent As Any : Type wxDropFilesEvent As _wxDropFilesEvent
Type _wxDropTarget As Any : Type wxDropTarget As _wxDropTarget
Type _wxEncodingConverter As Any : Type wxEncodingConverter As _wxEncodingConverter
Type _wxEraseEvent As Any : Type wxEraseEvent As _wxEraseEvent
Type _wxEventHandler As Any : Type wxEventHandler As _wxEventHandler
Type _wxEvent As Any : Type wxEvent As _wxEvent
Type _wxFileDataObject As Any : Type wxFileDataObject As _wxFileDataObject
Type _wxFileDialog As Any : Type wxFileDialog As _wxFileDialog
Type _wxFileDropTarget As Any : Type wxFileDropTarget As _wxFileDropTarget
Type _wxFileSystem As Any : Type wxFileSystem As _wxFileSystem
Type _wxFileSystemHandler As Any : Type wxFileSystemHandler As _wxFileSystemHandler
Type _wxFindReplaceData As Any : Type wxFindReplaceData As _wxFindReplaceData
Type _wxFindReplaceDialog As Any : Type wxFindReplaceDialog As _wxFindReplaceDialog
Type _wxFindDialogEvent As Any : Type wxFindDialogEvent As _wxFindDialogEvent
Type _wxFlexGridSizer As Any : Type wxFlexGridSizer As _wxFlexGridSizer
Type _wxFocusEvent As Any : Type wxFocusEvent As _wxFocusEvent
Type _wxFont As Any : Type wxFont As _wxFont
Type _wxFontData As Any : Type wxFontData As _wxFontData
Type _wxFontDialog As Any : Type wxFontDialog As _wxFontDialog
Type _wxFontEnumerator As Any : Type wxFontEnumerator As _wxFontEnumerator
Type _wxFontList As Any : Type wxFontList As _wxFontList
Type _wxFontMapper As Any : Type wxFontMapper As _wxFontMapper
Type _wxFontPickerCtrl As Any : Type wxFontPickerCtrl As _wxFontPickerCtrl
Type _wxFontPickerEvent As Any : Type wxFontPickerEvent As _wxFontPickerEvent
Type _wxFrame As Any : Type wxFrame As _wxFrame
Type _wxFSFile As Any : Type wxFSFile As _wxFSFile
Type _wxGauge As Any : Type wxGauge As _wxGauge
Type _wxGBPosition As Any : Type wxGBPosition As _wxGBPosition
Type _wxGBSizerItem As Any : Type wxGBSizerItem As _wxGBSizerItem
Type _wxGBSpan As Any : Type wxGBSpan As _wxGBSpan
Type _wxGDIObject As Any : Type wxGDIObject As _wxGDIObject
Type _wxGIFHandler As Any : Type wxGIFHandler As _wxGIFHandler
Type _wxGrid As Any : Type wxGrid As _wxGrid
Type _wxGridBagSizer As Any : Type wxGridBagSizer As _wxGridBagSizer
Type _wxGridCellAttr As Any : Type wxGridCellAttr As _wxGridCellAttr
Type _wxGridCellAttrProvider As Any : Type wxGridCellAttrProvider As _wxGridCellAttrProvider
Type _wxGridCellAutoWrapStringEditor As Any : Type wxGridCellAutoWrapStringEditor As _wxGridCellAutoWrapStringEditor
Type _wxGridCellAutoWrapStringRenderer As Any : Type wxGridCellAutoWrapStringRenderer As _wxGridCellAutoWrapStringRenderer
Type _wxGridCellBoolEditor As Any : Type wxGridCellBoolEditor As _wxGridCellBoolEditor
Type _wxGridCellBoolRenderer As Any : Type wxGridCellBoolRenderer As _wxGridCellBoolRenderer
Type _wxGridCellCoords As Any : Type wxGridCellCoords As _wxGridCellCoords
Type _wxGridCellCoordsArray As Any : Type wxGridCellCoordsArray As _wxGridCellCoordsArray
Type _wxGridCellChoiceEditor As Any : Type wxGridCellChoiceEditor As _wxGridCellChoiceEditor
Type _wxGridCellDateTimeRenderer As Any : Type wxGridCellDateTimeRenderer As _wxGridCellDateTimeRenderer
Type _wxGridCellEditor As Any : Type wxGridCellEditor As _wxGridCellEditor
Type _wxGridCellEnumRenderer As Any : Type wxGridCellEnumRenderer As _wxGridCellEnumRenderer
Type _wxGridCellEnumEditor As Any : Type wxGridCellEnumEditor As _wxGridCellEnumEditor
Type _wxGridCellFloatEditor As Any : Type wxGridCellFloatEditor As _wxGridCellFloatEditor
Type _wxGridCellFloatRenderer As Any : Type wxGridCellFloatRenderer As _wxGridCellFloatRenderer
Type _wxGridCellNumberEditor As Any : Type wxGridCellNumberEditor As _wxGridCellNumberEditor
Type _wxGridCellNumberRenderer As Any : Type wxGridCellNumberRenderer As _wxGridCellNumberRenderer
Type _wxGridCellRenderer As Any : Type wxGridCellRenderer As _wxGridCellRenderer
Type _wxGridCellStringEditor As Any : Type wxGridCellStringEditor As _wxGridCellStringEditor
Type _wxGridCellStringRenderer As Any : Type wxGridCellStringRenderer As _wxGridCellStringRenderer
Type _wxGridCellTextEditor As Any : Type wxGridCellTextEditor As _wxGridCellTextEditor
Type _wxGridCellWorker As Any : Type wxGridCellWorker As _wxGridCellWorker
Type _wxGridEditorCreatedEvent As Any : Type wxGridEditorCreatedEvent As _wxGridEditorCreatedEvent
Type _wxGridEvent As Any : Type wxGridEvent As _wxGridEvent
Type _wxGridRangeSelectEvent As Any : Type wxGridRangeSelectEvent As _wxGridRangeSelectEvent
Type _wxGridSizeEvent As Any : Type wxGridSizeEvent As _wxGridSizeEvent
Type _wxGridSizer As Any : Type wxGridSizer As _wxGridSizer
Type _wxGridStringTable As Any : Type wxGridStringTable As _wxGridStringTable
Type _wxGridTableBase As Any : Type wxGridTableBase As _wxGridTableBase
Type _wxGridTableMessage As Any : Type wxGridTableMessage As _wxGridTableMessage
Type _wxHelpEvent As Any : Type wxHelpEvent As _wxHelpEvent
Type _wxHitTest As Any : Type wxHitTest As _wxHitTest
Type _wxHtmlBookRecArray As Any : Type wxHtmlBookRecArray As _wxHtmlBookRecArray
Type _wxHtmlBookRecord As Any : Type wxHtmlBookRecord As _wxHtmlBookRecord
Type _wxHtmlCell As Any : Type wxHtmlCell As _wxHtmlCell
Type _wxHtmlColourCell As Any : Type wxHtmlColourCell As _wxHtmlColourCell
Type _wxHtmlContainerCell As Any : Type wxHtmlContainerCell As _wxHtmlContainerCell
Type _wxHtmlEasyPrinting As Any : Type wxHtmlEasyPrinting As _wxHtmlEasyPrinting
Type _wxHtmlEntitiesParser As Any : Type wxHtmlEntitiesParser As _wxHtmlEntitiesParser
Type _wxHtmlFilter As Any : Type wxHtmlFilter As _wxHtmlFilter
Type _wxHtmlFilterHTML As Any : Type wxHtmlFilterHTML As _wxHtmlFilterHTML
Type _wxHtmlFilterPlainText As Any : Type wxHtmlFilterPlainText As _wxHtmlFilterPlainText
Type _wxHtmlFontCell As Any : Type wxHtmlFontCell As _wxHtmlFontCell
Type _wxHtmlHelpController As Any : Type wxHtmlHelpController As _wxHtmlHelpController
Type _wxHtmlHelpFrame As Any : Type wxHtmlHelpFrame As _wxHtmlHelpFrame
Type _wxHtmlHelpData As Any : Type wxHtmlHelpData As _wxHtmlHelpData
Type _wxHtmlHelpDataItems As Any : Type wxHtmlHelpDataItems As _wxHtmlHelpDataItems
Type _wxHtmlHelpDataItem As Any : Type wxHtmlHelpDataItem As _wxHtmlHelpDataItem
Type _wxHtmlLinkInfo As Any : Type wxHtmlLinkInfo As _wxHtmlLinkInfo
Type _wxHtmlListBox As Any : Type wxHtmlListBox As _wxHtmlListBox
Type _wxHtmlParser As Any : Type wxHtmlParser As _wxHtmlParser
Type _wxHtmlProcessor As Any : Type wxHtmlProcessor As _wxHtmlProcessor
Type _wxHtmlRenderingInfo As Any : Type wxHtmlRenderingInfo As _wxHtmlRenderingInfo
Type _wxHtmlSearchStatus As Any : Type wxHtmlSearchStatus As _wxHtmlSearchStatus
Type _wxHtmlSelection As Any : Type wxHtmlSelection As _wxHtmlSelection
Type _wxHtmlTag As Any : Type wxHtmlTag As _wxHtmlTag
Type _wxHtmlTagsModule As Any : Type wxHtmlTagsModule As _wxHtmlTagsModule
Type _wxHtmlTagHandler As Any : Type wxHtmlTagHandler As _wxHtmlTagHandler
Type _wxHtmlWidgetCell As Any : Type wxHtmlWidgetCell As _wxHtmlWidgetCell
Type _wxHtmlWindow As Any : Type wxHtmlWindow As _wxHtmlWindow
Type _wxHtmlWinParser As Any : Type wxHtmlWinParser As _wxHtmlWinParser
Type _wxHtmlWordCell As Any : Type wxHtmlWordCell As _wxHtmlWordCell
Type _wxIcon As Any : Type wxIcon As _wxIcon
Type _wxIconBundle As Any : Type wxIconBundle As _wxIconBundle
Type _wxICOHandler As Any : Type wxICOHandler As _wxICOHandler
Type _wxIconizeEvent As Any : Type wxIconizeEvent As _wxIconizeEvent
Type _wxIdleEvent As Any : Type wxIdleEvent As _wxIdleEvent
Type _wxImage As Any : Type wxImage As _wxImage
Type _wxImageHandler As Any : Type wxImageHandler As _wxImageHandler
Type _wxImageHistogram As Any : Type wxImageHistogram As _wxImageHistogram
Type _wxImageHistogramEntry As Any : Type wxImageHistogramEntry As _wxImageHistogramEntry
Type _wxImageList As Any : Type wxImageList As _wxImageList
Type _wxInitDialogEvent As Any : Type wxInitDialogEvent As _wxInitDialogEvent
Type _wxInputStream As Any : Type wxInputStream As _wxInputStream
Type _wxInternetFSHandler As Any : Type wxInternetFSHandler As _wxInternetFSHandler
Type _wxJPEGHandler As Any : Type wxJPEGHandler As _wxJPEGHandler
Type _wxKeyEvent As Any : Type wxKeyEvent As _wxKeyEvent
Type _wxLanguageInfo As Any : Type wxLanguageInfo As _wxLanguageInfo
Type _wxLayoutAlgorithm As Any : Type wxLayoutAlgorithm As _wxLayoutAlgorithm
Type _wxLayoutConstraints As Any : Type wxLayoutConstraints As _wxLayoutConstraints
Type _wxList As Any : Type wxList As _wxList
Type _wxListbook As Any : Type wxListbook As _wxListbook
Type _wxListbookEvent As Any : Type wxListbookEvent As _wxListbookEvent
Type _wxListBox As Any : Type wxListBox As _wxListBox
Type _wxListCtrl As Any : Type wxListCtrl As _wxListCtrl
Type _wxListEvent As Any : Type wxListEvent As _wxListEvent
Type _wxListItemAttr As Any : Type wxListItemAttr As _wxListItemAttr
Type _wxListItem As Any : Type wxListItem As _wxListItem
Type _wxListView As Any : Type wxListView As _wxListView
Type _wxLocale As Any : Type wxLocale As _wxLocale
Type _wxLog As Any : Type wxLog As _wxLog
Type _wxMask As Any : Type wxMask As _wxMask
Type _wxMaximizeEvent As Any : Type wxMaximizeEvent As _wxMaximizeEvent
Type _wxMDIChildFrame As Any : Type wxMDIChildFrame As _wxMDIChildFrame
Type _wxMDIClientWindow As Any : Type wxMDIClientWindow As _wxMDIClientWindow
Type _wxMDIParentFrame As Any : Type wxMDIParentFrame As _wxMDIParentFrame
Type _wxMemoryBuffer As Any : Type wxMemoryBuffer As _wxMemoryBuffer
Type _wxMemoryDC As Any : Type wxMemoryDC As _wxMemoryDC
Type _wxMemoryFSHandler As Any : Type wxMemoryFSHandler As _wxMemoryFSHandler
Type _wxMenu As Any : Type wxMenu As _wxMenu
Type _wxMenuBar As Any : Type wxMenuBar As _wxMenuBar
Type _wxMenuBase As Any : Type wxMenuBase As _wxMenuBase
Type _wxMenuItem As Any : Type wxMenuItem As _wxMenuItem
Type _wxMessageDialog As Any : Type wxMessageDialog As _wxMessageDialog
Type _wxMiniFrame As Any : Type wxMiniFrame As _wxMiniFrame
Type _wxMouseCaptureChangedEvent As Any : Type wxMouseCaptureChangedEvent As _wxMouseCaptureChangedEvent
Type _wxMouseEvent As Any : Type wxMouseEvent As _wxMouseEvent
Type _wxMoveEvent As Any : Type wxMoveEvent As _wxMoveEvent
Type _wxMultiChoiceDialog As Any : Type wxMultiChoiceDialog As _wxMultiChoiceDialog
Type _wxNativeFontInfo As Any : Type wxNativeFontInfo As _wxNativeFontInfo
Type _wxNavigationKeyEvent As Any : Type wxNavigationKeyEvent As _wxNavigationKeyEvent
Type _wxNcPaintEvent As Any : Type wxNcPaintEvent As _wxNcPaintEvent
Type _wxNode As Any : Type wxNode As _wxNode
Type _wxNotebook As Any : Type wxNotebook As _wxNotebook
Type _wxNotebookBase As Any : Type wxNotebookBase As _wxNotebookBase
Type _wxNotebookEvent As Any : Type wxNotebookEvent As _wxNotebookEvent
Type _wxNotebookPage As Any : Type wxNotebookPage As _wxNotebookPage
Type _wxNotifyEvent As Any : Type wxNotifyEvent As _wxNotifyEvent
Type _wxObject As Any : Type wxObject As _wxObject
Type _wxOutputStream As Any : Type wxOutputStream As _wxOutputStream
Type _wxPageSetupData As Any : Type wxPageSetupData As _wxPageSetupData
Type _wxPageSetupDialog As Any : Type wxPageSetupDialog As _wxPageSetupDialog
Type _wxPageSetupDialogData As Any : Type wxPageSetupDialogData As _wxPageSetupDialogData
Type _wxPaintDC As Any : Type wxPaintDC As _wxPaintDC
Type _wxPaintEvent As Any : Type wxPaintEvent As _wxPaintEvent
Type _wxPalette As Any : Type wxPalette As _wxPalette
Type _wxPaletteChangedEvent As Any : Type wxPaletteChangedEvent As _wxPaletteChangedEvent
Type _wxPanel As Any : Type wxPanel As _wxPanel
Type _wxPCXHandler As Any : Type wxPCXHandler As _wxPCXHandler
Type _wxPen As Any : Type wxPen As _wxPen
Type _wxPenList As Any : Type wxPenList As _wxPenList
Type _wxPickerBase As Any : Type wxPickerBase As _wxPickerBase
Type _wxPNGHandler As Any : Type wxPNGHandler As _wxPNGHandler
Type _wxPNMHandler As Any : Type wxPNMHandler As _wxPNMHandler
Type _wxPoint As Any : Type wxPoint As _wxPoint
Type _wxPreviewCanvas As Any : Type wxPreviewCanvas As _wxPreviewCanvas
Type _wxPreviewFrame As Any : Type wxPreviewFrame As _wxPreviewFrame
Type _wxPrintData As Any : Type wxPrintData As _wxPrintData
Type _wxPrintDialog As Any : Type wxPrintDialog As _wxPrintDialog
Type _wxPrintDialogData As Any : Type wxPrintDialogData As _wxPrintDialogData
Type _wxPrinter As Any : Type wxPrinter As _wxPrinter
Type _wxPrintOut As Any : Type wxPrintout As _wxPrintOut
Type _wxPrintPreview As Any : Type wxPrintPreview As _wxPrintPreview
Type _wxPrintPreviewBase As Any : Type wxPrintPreviewBase As _wxPrintPreviewBase
Type _wxPrintSetupData As Any : Type wxPrintSetupData As _wxPrintSetupData
Type _wxPrintSetupDialog As Any : Type wxPrintSetupDialog As _wxPrintSetupDialog
Type _wxProgressDialog As Any : Type wxProgressDialog As _wxProgressDialog
Type _wxQueryLayoutInfoEvent As Any : Type wxQueryLayoutInfoEvent As _wxQueryLayoutInfoEvent
Type _wxQueryLayoutEvent As Any : Type wxQueryLayoutEvent As _wxQueryLayoutEvent
Type _wxQueryNewPaletteEvent As Any : Type wxQueryNewPaletteEvent As _wxQueryNewPaletteEvent
Type _wxRadioBox As Any : Type wxRadioBox As _wxRadioBox
Type _wxRadioButton As Any : Type wxRadioButton As _wxRadioButton
Type _wxRect As Any : Type wxRect As _wxRect
Type _wxRegion As Any : Type wxRegion As _wxRegion
Type _wxRegionIterator As Any : Type wxRegionIterator As _wxRegionIterator
Type _wxSashEdge As Any : Type wxSashEdge As _wxSashEdge
Type _wxSashEvent As Any : Type wxSashEvent As _wxSashEvent
Type _wxSashLayoutWindow As Any : Type wxSashLayoutWindow As _wxSashLayoutWindow
Type _wxSashWindow As Any : Type wxSashWindow As _wxSashWindow
Type _wxScrollBar As Any : Type wxScrollBar As _wxScrollBar
Type _wxScrolledWindow As Any : Type wxScrolledWindow As _wxScrolledWindow
Type _wxSetCursorEvent As Any : Type wxSetCursorEvent As _wxSetCursorEvent
Type _wxShowEvent As Any : Type wxShowEvent As _wxShowEvent
Type _wxSingleChoiceDialog As Any : Type wxSingleChoiceDialog As _wxSingleChoiceDialog
Type _wxSize As Any : Type wxSize As _wxSize
Type _wxSizeEvent As Any : Type wxSizeEvent As _wxSizeEvent
Type _wxSizer As Any : Type wxSizer As _wxSizer
Type _wxSizerItem As Any : Type wxSizerItem As _wxSizerItem
Type _wxSlider As Any : Type wxSlider As _wxSlider
Type _wxSpinButton As Any : Type wxSpinButton As _wxSpinButton
Type _wxSpinCtrl As Any : Type wxSpinCtrl As _wxSpinCtrl
Type _wxSpinEvent As Any : Type wxSpinEvent As _wxSpinEvent
Type _wxSplashScreen As Any : Type wxSplashScreen As _wxSplashScreen
Type _wxSplashScreenWindow As Any : Type wxSplashScreenWindow As _wxSplashScreenWindow
Type _wxSplitterWindow As Any : Type wxSplitterWindow As _wxSplitterWindow
Type _wxStaticBitmap As Any : Type wxStaticBitmap As _wxStaticBitmap
Type _wxStaticBox As Any : Type wxStaticBox As _wxStaticBox
Type _wxStaticBoxSizer As Any : Type wxStaticBoxSizer As _wxStaticBoxSizer
Type _wxStaticLine As Any : Type wxStaticLine As _wxStaticLine
Type _wxStaticText As Any : Type wxStaticText As _wxStaticText
Type _wxStatusBar As Any : Type wxStatusBar As _wxStatusBar
Type _wxString As Any : Type wxString As _wxString
Type _wxStringClientData As Any : Type wxStringClientData As _wxStringClientData
Type _wxStyledTextCtrl As Any : Type wxStyledTextCtrl As _wxStyledTextCtrl
Type _wxStyledTextEvent As Any : Type wxStyledTextEvent As _wxStyledTextEvent
Type _wxSysColourChangedEvent As Any : Type wxSysColourChangedEvent As _wxSysColourChangedEvent
#Ifdef __FB_WIN32__
Type _wxTabCtrl As Any : Type wxTabCtrl As _wxTabCtrl
Type _wxTabEvent As Any : Type wxTabEvent As _wxTabEvent
#EndIf
Type _wxTaskBarIcon As Any : Type wxTaskBarIcon As _wxTaskBarIcon
Type _wxTextAttr As Any : Type wxTextAttr As _wxTextAttr
Type _wxTextCtrl As Any : Type wxTextCtrl As _wxTextCtrl
Type _wxTextDataObject As Any : Type wxTextDataObject As _wxTextDataObject
Type _wxTextDropTarget As Any : Type wxTextDropTarget As _wxTextDropTarget
Type _wxTextEntryDialog As Any : Type wxTextEntryDialog As _wxTextEntryDialog
Type _wxTextUrlEvent As Any : Type wxTextUrlEvent As _wxTextUrlEvent
Type _wxTIFFHandler As Any : Type wxTIFFHandler As _wxTIFFHandler
Type _wxTimer As Any : Type wxTimer As _wxTimer
Type _wxTipProvider As Any : Type wxTipProvider As _wxTipProvider
Type _wxTipWindow As Any : Type wxTipWindow As _wxTipWindow
Type _wxToggleButton As Any : Type wxToggleButton As _wxToggleButton
Type _wxToolBar As Any : Type wxToolBar As _wxToolBar
Type _wxToolBarBase As Any : Type wxToolBarBase As _wxToolBarBase
Type _wxToolBarToolBase As Any : Type wxToolBarToolBase As _wxToolBarToolBase
Type _wxToolTip As Any : Type wxToolTip As _wxToolTip
Type _wxTopLevelWindow As Any : Type wxTopLevelWindow As _wxTopLevelWindow
Type _wxTreeCtrl As Any : Type wxTreeCtrl As _wxTreeCtrl
Type _wxTreeEvent As Any : Type wxTreeEvent As _wxTreeEvent
Type _wxTreeItemAttr As Any : Type wxTreeItemAttr As _wxTreeItemAttr
Type _wxTreeItemData As Any : Type wxTreeItemData As _wxTreeItemData
Type _wxTreeItemIcon As Any : Type wxTreeItemIcon As _wxTreeItemIcon
Type _wxTreeItemId As Any : Type wxTreeItemId As _wxTreeItemId
Type _wxUpdateUIEvent As Any : Type wxUpdateUIEvent As _wxUpdateUIEvent
Type _wxValidator As Any : Type wxValidator As _wxValidator
Type _wxView As Any : Type wxView As _wxView
Type _wxVisualAttributes As Any : Type wxVisualAttributes As _wxVisualAttributes
Type _wxVListBox As Any : Type wxVListBox As _wxVListBox
Type _wxVScrolledWindow As Any : Type wxVScrolledWindow As _wxVScrolledWindow
Type _wxWCharBuffer As Any : Type wxWCharBuffer As _wxWCharBuffer
Type _wxWindow As Any : Type wxWindow As _wxWindow
Type _wxWindowCreateEvent As Any : Type wxWindowCreateEvent As _wxWindowCreateEvent
Type _wxWindowDC As Any : Type wxWindowDC As _wxWindowDC
Type _wxWindowDestroyEvent As Any : Type wxWindowDestroyEvent As _wxWindowDestroyEvent
Type _wxWindowDisabler As Any : Type wxWindowDisabler As _wxWindowDisabler
Type _wxWizard As Any : Type wxWizard As _wxWizard
Type _wxWizardEvent As Any : Type wxWizardEvent As _wxWizardEvent
Type _wxWizardPage As Any : Type wxWizardPage As _wxWizardPage
Type _wxWizardPageSimple As Any : Type wxWizardPageSimple As _wxWizardPageSimple
Type _wxXmlResource As Any : Type wxXmlResource As _wxXmlResource
Type _wxXPMHandler As Any : Type wxXPMHandler As _wxXPMHandler
Type _wxZipFSHandler As Any : Type wxZipFSHandler As _wxZipFSHandler

#Define WX_TRUE 1
#Define WX_FALSE 0
#Define WX_NULL CPtr(Any Ptr,0)

' wx simple data types
Type wxChar      As UByte
Type wxInt       As Integer
Type wxUInt      As UInteger
Type wxFloat     As Single
Type wxDouble    As Double
Type wxLong      As Long
Type wxCoord     As wxInt
Type wxBool      As wxChar
Type wxWindowID  As wxInt
Type wxEventType As wxInt
Type wxWeekDay   As wxInt
Type wxTextCoord As wxLong

#Ifdef wxHAS_HUGE_FILES
Type wxFileOffset As LongInt
#Else
Type wxFileOffset As Integer
#EndIf

Type _wxWidget As Any  : Type wxWidget As _wxWidget
' callbacks used by many wx classes
Type Virtual_Dispose   As Sub      WXCALL 

#EndIf ' __common_bi__

