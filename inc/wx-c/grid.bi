#Ifndef __grid_bi__
#Define __grid_bi__

#Include Once "common.bi"

Type Virtual_SetParameters       As Sub      WXCALL (p As wxString Ptr)

Type Virtual_Create              As Sub      WXCALL (ein As wxWindow Ptr, id As wxWindowID, wvnt As wxEventHandler Ptr)
Type Virtual_BeginEdit           As Sub      WXCALL (x As wxInt, y As wxInt, grid As wxGrid Ptr)
Type Virtual_EndEdit             As Function WXCALL (x As wxInt, y As wxInt, grid As wxGrid Ptr) As wxBool
Type Virtual_Reset               As Sub      WXCALL
Type Virtual_Clone               As Function WXCALL As wxGridCellEditor Ptr
Type Virtual_SetSize             As Sub      WXCALL (r As wxRect Ptr)
Type Virtual_Show                As Sub      WXCALL (i As wxInt, gca As wxGridCellAttr Ptr)
Type Virtual_PaintBackground     As Sub      WXCALL (r As wxRect Ptr, gca As wxGridCellAttr Ptr)
Type Virtual_IsAcceptedKey       As Function WXCALL (k As wxKeyEvent Ptr) As wxBool
Type Virtual_StartingKey         As Sub      WXCALL (k As wxKeyEvent Ptr)
Type Virtual_StartingClick       As Sub      WXCALL
Type Virtual_HandleReturn        As Sub      WXCALL (k As wxKeyEvent Ptr)
Type Virtual_Destroy             As Sub      WXCALL
Type Virtual_GetValue            As Function WXCALL As _DisposableStringBox Ptr

Type Virtual_GetNumberRows       As Function WXCALL () As wxInt
Type Virtual_GetNumberCols       As Function WXCALL () As wxInt
Type Virtual_IsEmptyCell         As Function WXCALL (As wxInt, As wxInt) As wxBool
Type Virtual_GetValue2           As Function WXCALL ( As wxInt, As wxInt) As _DisposableStringBox Ptr
Type Virtual_SetValue            As Sub      WXCALL ( As wxInt, As wxInt, value As wxString Ptr)
Type Virtual_CanGetValueAs       As Function WXCALL ( As wxInt, As wxInt, As wxString Ptr) As wxBool
Type Virtual_GetValueAsLong      As Function WXCALL ( As wxInt, As wxInt) As wxLong
Type Virtual_GetValueAsDouble    As Function WXCALL ( As wxInt, As wxInt) As wxDouble
Type Virtual_SetValueAsLong      As Sub      WXCALL ( As wxInt, As wxInt, As wxLong)
Type Virtual_SetValueAsDouble    As Sub      WXCALL ( As wxInt, As wxInt, As wxDouble)
Type Virtual_SetValueAsBool      As Sub      WXCALL ( As wxInt, As wxInt, As wxBool)
Type Virtual_GetValueAsCustom    As Function WXCALL ( As wxInt, As wxInt, As wxString Ptr) As Any Ptr
Type Virtual_SetValueAsCustom    As Sub      WXCALL ( As wxInt, As wxInt, As wxString Ptr, As Any Ptr)
Type Virtual_GetColLabelValue    As Function WXCALL ( As wxInt) As _DisposableStringBox Ptr
Type Virtual_SetView             As Sub      WXCALL (As wxGrid Ptr)
Type Virtual_GetView             As Function WXCALL As wxGrid Ptr
Type Virtual_Clear               As Sub      WXCALL 
Type Virtual_InsertRows          As Function WXCALL (As wxInt, As wxInt) As wxBool
Type Virtual_AppendRows          As Function WXCALL (As wxInt) As wxBool
Type Virtual_SetRowLabelValue    As Sub      WXCALL (As wxInt, As wxString Ptr)
Type Virtual_SetAttrProvider     As Sub      WXCALL (As wxGridCellAttrProvider Ptr)
Type Virtual_GetAttrProvider     As Function WXCALL As wxGridCellAttrProvider Ptr
Type Virtual_CanHaveAttributes   As Function WXCALL  As wxBool
Type Virtual_GetAttr             As Function WXCALL (As wxInt, As wxInt,kind As wxAttrKind) As wxGridCellAttr Ptr
Type Virtual_SetAttr             As Sub      WXCALL (gca As wxGridCellAttr Ptr, As wxInt, As wxInt)
Type Virtual_SetRowAttr          As Sub      WXCALL (gca As wxGridCellAttr Ptr, As wxInt)

Type Virtual_Draw                As Sub      WXCALL (grid As wxGrid Ptr, As wxGridCellAttr Ptr, As wxDC Ptr, r As wxRect Ptr, x As wxInt, y As wxInt, As wxBool)
Type Virtual_GetBestSize         As Function WXCALL (grid As wxGrid Ptr, gca As wxGridCellAttr Ptr, dc As wxDC Ptr, x As wxInt, y As wxInt) As wxSize Ptr
Type Virtual_RendererClone       As Function WXCALL As wxGridCellRenderer Ptr


' class wxGridEvent
Declare Function wxGridEvent_ctor WXCALL Alias "wxGridEvent_ctor" (id    As wxInt, _
                      typ   As wxEventType, _
                      obj   As wxObject Ptr, _
                      row   As wxInt, _
                      col   As wxInt, _
                      x     As wxInt, _
                      y     As wxInt, _
                      sel   As wxBool, _
                      ctl   As wxBool, _
                      shift As wxBool, _
                      alt   As wxBool, _
                      meta  As wxBool) As wxGridEvent Ptr
Declare Function wxGridEvent_GetRow WXCALL Alias "wxGridEvent_GetRow" (self As wxGridEvent Ptr) As wxInt
Declare Function wxGridEvent_GetCol WXCALL Alias "wxGridEvent_GetCol" (self As wxGridEvent Ptr) As wxInt
Declare Sub wxGridEvent_GetPosition WXCALL Alias "wxGridEvent_GetPosition" (self As wxGridEvent Ptr, pt As wxPoint Ptr)
Declare Function wxGridEvent_Selecting WXCALL Alias "wxGridEvent_Selecting" (self As wxGridEvent Ptr) As wxBool
Declare Function wxGridEvent_ControlDown WXCALL Alias "wxGridEvent_ControlDown" (self As wxGridEvent Ptr) As wxBool
Declare Function wxGridEvent_MetaDown WXCALL Alias "wxGridEvent_MetaDown" (self As wxGridEvent Ptr) As wxBool
Declare Function wxGridEvent_ShiftDown WXCALL Alias "wxGridEvent_ShiftDown" (self As wxGridEvent Ptr) As wxBool
Declare Function wxGridEvent_AltDown WXCALL Alias "wxGridEvent_AltDown" (self As wxGridEvent Ptr) As wxBool
Declare Sub wxGridEvent_Veto WXCALL Alias "wxGridEvent_Veto" (self As wxGridEvent Ptr)
Declare Sub wxGridEvent_Allow WXCALL Alias "wxGridEvent_Allow" (self As wxGridEvent Ptr)
Declare Function wxGridEvent_IsAllowed WXCALL Alias "wxGridEvent_IsAllowed" (self As wxGridEvent Ptr) As wxBool

' class wxGridRangeSelectEvent
Declare Function wxGridRangeSelectEvent_ctor WXCALL Alias "wxGridRangeSelectEvent_ctor" (id As wxInt, _
                                 typ         As wxEventType, _
                                 obj         As wxObject Ptr, _
                                 topleft     As wxGridCellCoords Ptr, _
                                 bottomRight As wxGridCellCoords Ptr, _
                                 sel         As wxBool, _
                                 control     As wxBool, _
                                 shift       As wxBool, _
                                 alt         As wxBool, _
                                 meta        As wxBool) As wxGridRangeSelectEvent Ptr
Declare Function wxGridRangeSelectEvent_GetTopLeftCoords WXCALL Alias "wxGridRangeSelectEvent_GetTopLeftCoords" (self As wxGridRangeSelectEvent Ptr) As wxGridCellCoords Ptr
Declare Function wxGridRangeSelectEvent_GetBottomRightCoords WXCALL Alias "wxGridRangeSelectEvent_GetBottomRightCoords" (self As wxGridRangeSelectEvent Ptr) As wxGridCellCoords Ptr
Declare Function wxGridRangeSelectEvent_GetTopRow WXCALL Alias "wxGridRangeSelectEvent_GetTopRow" (self As wxGridRangeSelectEvent Ptr) As wxInt
Declare Function wxGridRangeSelectEvent_GetBottomRow WXCALL Alias "wxGridRangeSelectEvent_GetBottomRow" (self As wxGridRangeSelectEvent Ptr) As wxInt
Declare Function wxGridRangeSelectEvent_GetLeftCol WXCALL Alias "wxGridRangeSelectEvent_GetLeftCol" (self As wxGridRangeSelectEvent Ptr) As wxInt
Declare Function wxGridRangeSelectEvent_GetRightCol WXCALL Alias "wxGridRangeSelectEvent_GetRightCol" (self As wxGridRangeSelectEvent Ptr) As wxInt
Declare Function wxGridRangeSelectEvent_Selecting WXCALL Alias "wxGridRangeSelectEvent_Selecting" (self As wxGridRangeSelectEvent Ptr) As wxBool
Declare Function wxGridRangeSelectEvent_ControlDown WXCALL Alias "wxGridRangeSelectEvent_ControlDown" (self As wxGridRangeSelectEvent Ptr) As wxBool
Declare Function wxGridRangeSelectEvent_MetaDown WXCALL Alias "wxGridRangeSelectEvent_MetaDown" (self As wxGridRangeSelectEvent Ptr) As wxBool
Declare Function wxGridRangeSelectEvent_ShiftDown WXCALL Alias "wxGridRangeSelectEvent_ShiftDown" (self As wxGridRangeSelectEvent Ptr) As wxBool
Declare Function wxGridRangeSelectEvent_AltDown WXCALL Alias "wxGridRangeSelectEvent_AltDown" (self As wxGridRangeSelectEvent Ptr) As wxBool
Declare Sub wxGridRangeSelectEvent_Veto WXCALL Alias "wxGridRangeSelectEvent_Veto" (self As wxGridRangeSelectEvent Ptr)
Declare Sub wxGridRangeSelectEvent_Allow WXCALL Alias "wxGridRangeSelectEvent_Allow" (self As wxGridRangeSelectEvent Ptr)
Declare Function wxGridRangeSelectEvent_IsAllowed WXCALL Alias "wxGridRangeSelectEvent_IsAllowed" (self As wxGridRangeSelectEvent Ptr) As wxBool

' class wxGridCellWorker
Declare Function wxGridCellWorker_ctor WXCALL Alias "wxGridCellWorker_ctor" () As wxGridCellWorker Ptr
Declare Sub wxGridCellWorker_RegisterVirtual WXCALL Alias "wxGridCellWorker_RegisterVirtual" (self As wxGridCellWorker Ptr, fSetParams As Virtual_SetParameters)
Declare Sub wxGridCellWorker_IncRef WXCALL Alias "wxGridCellWorker_IncRef" (self As wxGridCellWorker Ptr)
Declare Sub wxGridCellWorker_DecRef WXCALL Alias "wxGridCellWorker_DecRef" (self As wxGridCellWorker Ptr)
Declare Sub wxGridCellWorker_SetParameters WXCALL Alias "wxGridCellWorker_SetParameters" (self As wxGridCellWorker Ptr, params As wxString Ptr)

' class wxGridEditorCreatedEvent
Declare Function wxGridEditorCreatedEvent_ctor WXCALL Alias "wxGridEditorCreatedEvent_ctor" (id As wxInt, _
                                   typ As wxEventType, _
                                   obj As wxObject Ptr, _
                                   row As wxInt, _
                                   col As wxInt, _
                                   control As wxControl Ptr) As wxGridEditorCreatedEvent Ptr
Declare Function wxGridEditorCreatedEvent_GetRow WXCALL Alias "wxGridEditorCreatedEvent_GetRow" (self As wxGridEditorCreatedEvent Ptr) As wxInt
Declare Function wxGridEditorCreatedEvent_GetCol WXCALL Alias "wxGridEditorCreatedEvent_GetCol" (self As wxGridEditorCreatedEvent Ptr) As wxInt
Declare Function wxGridEditorCreatedEvent_GetControl WXCALL Alias "wxGridEditorCreatedEvent_GetControl" (self As wxGridEditorCreatedEvent Ptr) As wxControl Ptr
Declare Sub wxGridEditorCreatedEvent_SetRow WXCALL Alias "wxGridEditorCreatedEvent_SetRow" (self As wxGridEditorCreatedEvent Ptr, row As wxInt)
Declare Sub wxGridEditorCreatedEvent_SetCol WXCALL Alias "wxGridEditorCreatedEvent_SetCol" (self As wxGridEditorCreatedEvent Ptr, col As wxInt)
Declare Sub wxGridEditorCreatedEvent_SetControl WXCALL Alias "wxGridEditorCreatedEvent_SetControl" (self As wxGridEditorCreatedEvent Ptr, ctrl As wxControl Ptr)

' class wxGrid
Declare Function wxGrid_ctor WXCALL Alias "wxGrid_ctor" () As wxGrid Ptr
Declare Function wxGrid_ctorFull WXCALL Alias "wxGrid_ctorFull" (parent  As wxWindow Ptr, _
                     id      As  wxWindowID   = -1, _
                     x       As  wxInt        = -1, _
                     y       As  wxInt        = -1, _
                     w       As  wxInt        = -1, _
                     h       As  wxInt        = -1, _
                     style   As  wxInt        =  0, _
                     nameArg As wxString Ptr = WX_NULL) As wxGrid Ptr
Declare Sub wxGrid_dtor WXCALL Alias "wxGrid_dtor" (self As wxGrid Ptr)
Declare Function wxGrid_CreateGrid WXCALL Alias "wxGrid_CreateGrid" (self As wxGrid Ptr, numRows As wxInt, numCols As wxInt, mode As wxGridSelectionModes) As wxBool
Declare Sub wxGrid_SetSelectionMode WXCALL Alias "wxGrid_SetSelectionMode" (self As wxGrid Ptr, mode As wxGridSelectionModes)
Declare Function wxGrid_GetSelectionMode WXCALL Alias "wxGrid_GetSelectionMode" (self As wxGrid Ptr) As wxGridSelectionModes
Declare Function wxGrid_GetNumberRows WXCALL Alias "wxGrid_GetNumberRows" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetNumberCols WXCALL Alias "wxGrid_GetNumberCols" (self As wxGrid Ptr) As wxInt
Declare Sub wxGrid_ProcessRowLabelMouseEvent WXCALL Alias "wxGrid_ProcessRowLabelMouseEvent" (self As wxGrid Ptr, evn As wxMouseEvent Ptr)
Declare Sub wxGrid_ProcessColLabelMouseEvent WXCALL Alias "wxGrid_ProcessColLabelMouseEvent" (self As wxGrid Ptr, evn As wxMouseEvent Ptr)
Declare Sub wxGrid_ProcessCornerLabelMouseEvent WXCALL Alias "wxGrid_ProcessCornerLabelMouseEvent" (self As wxGrid Ptr, evn As wxMouseEvent Ptr)
Declare Sub wxGrid_ProcessGridCellMouseEvent WXCALL Alias "wxGrid_ProcessGridCellMouseEvent" (self As wxGrid Ptr, evn As wxMouseEvent Ptr)
Declare Function wxGrid_ProcessTableMessage WXCALL Alias "wxGrid_ProcessTableMessage" (self As wxGrid Ptr, msg As wxGridTableMessage Ptr) As wxBool
Declare Function wxGridTableMessage_ctor1 WXCALL Alias "wxGridTableMessage_ctor1" () As wxGridTableMessage Ptr
Declare Function wxGridTableMessage_ctor2 WXCALL Alias "wxGridTableMessage_ctor2" (table As wxGridTableBase Ptr, id As wxInt, comInt1 As wxInt, comInt2 As wxInt) As wxGridTableMessage Ptr
Declare Sub wxGridTableMessage_SetTableObject WXCALL Alias "wxGridTableMessage_SetTableObject" (self As wxGridTableMessage Ptr, table As wxGridTableBase Ptr)
Declare Function wxGridTableMessage_GetTableObject WXCALL Alias "wxGridTableMessage_GetTableObject" (self As wxGridTableMessage Ptr) As wxGridTableBase Ptr
Declare Sub wxGridTableMessage_SetId WXCALL Alias "wxGridTableMessage_SetId" (self As wxGridTableMessage Ptr, id As wxInt)
Declare Function wxGridTableMessage_GetId WXCALL Alias "wxGridTableMessage_GetId" (self As wxGridTableMessage Ptr) As wxInt
Declare Sub wxGridTableMessage_SetCommandInt WXCALL Alias "wxGridTableMessage_SetCommandInt" (self As wxGridTableMessage Ptr, ComInt As wxInt)
Declare Function wxGridTableMessage_GetCommandInt WXCALL Alias "wxGridTableMessage_GetCommandInt" (self As wxGridTableMessage Ptr) As wxInt
Declare Sub wxGridTableMessage_SetCommandInt2 WXCALL Alias "wxGridTableMessage_SetCommandInt2" (self As wxGridTableMessage Ptr, ComInt As wxInt)
Declare Function wxGridTableMessage_GetCommandInt2 WXCALL Alias "wxGridTableMessage_GetCommandInt2" (self As wxGridTableMessage Ptr) As wxInt
Declare Function wxGrid_GetTable WXCALL Alias "wxGrid_GetTable" (self As wxGrid Ptr) As wxGridTableBase Ptr
Declare Function wxGrid_SetTable WXCALL Alias "wxGrid_SetTable" (self As wxGrid Ptr, table As wxGridTableBase Ptr, takeOwnership As wxBool, mode As wxGridSelectionModes) As wxBool
Declare Function wxGridStringTable_GetNumberRows WXCALL Alias "wxGridStringTable_GetNumberRows" (self As wxGridStringTable Ptr) As wxInt
Declare Function wxGridStringTable_GetNumberCols WXCALL Alias "wxGridStringTable_GetNumberCols" (self As wxGridStringTable Ptr) As wxInt
Declare Function wxGridStringTable_IsEmptyCell WXCALL Alias "wxGridStringTable_IsEmptyCell" (self As wxGridStringTable Ptr, row As wxInt, col As wxInt) As wxBool
Declare Function wxGridStringTable_GetValue WXCALL Alias "wxGridStringTable_GetValue" (self As wxGridStringTable Ptr, row As wxInt, col As wxInt) As wxString Ptr
Declare Sub wxGridStringTable_SetValue WXCALL Alias "wxGridStringTable_SetValue" (self As wxGridStringTable Ptr, row As wxInt, col As wxInt, value As wxString Ptr)
Declare Sub wxGrid_ClearGrid WXCALL Alias "wxGrid_ClearGrid" (self As wxGrid Ptr)
Declare Function wxGrid_InsertRows WXCALL Alias "wxGrid_InsertRows" (self As wxGrid Ptr,position As wxInt, numRows As wxInt, updateLabels As wxBool) As wxBool
Declare Function wxGrid_AppendRows WXCALL Alias "wxGrid_AppendRows" (self As wxGrid Ptr, numRows As wxInt, updateLabels As wxBool) As wxBool
Declare Function wxGrid_DeleteRows WXCALL Alias "wxGrid_DeleteRows" (self As wxGrid Ptr,position As wxInt, numRows As wxInt, updateLabels As wxBool) As wxBool
Declare Function wxGrid_InsertCols WXCALL Alias "wxGrid_InsertCols" (self As wxGrid Ptr,position As wxInt,  numCols As wxInt, updateLabels As wxBool) As wxBool
Declare Function wxGrid_AppendCols WXCALL Alias "wxGrid_AppendCols" (self As wxGrid Ptr,  numCols As wxInt, updateLabels As wxBool) As wxBool
Declare Function wxGrid_DeleteCols WXCALL Alias "wxGrid_DeleteCols" (self As wxGrid Ptr,position As wxInt,  numCols As wxInt, updateLabels As wxBool) As wxBool
Declare Sub wxGrid_DrawGridCellArea WXCALL Alias "wxGrid_DrawGridCellArea" (self As wxGrid Ptr, dc As wxDC Ptr, cells As wxGridCellCoordsArray Ptr)
Declare Sub wxGrid_DrawGridSpace WXCALL Alias "wxGrid_DrawGridSpace" (self As wxGrid Ptr, dc As wxDC Ptr)
Declare Sub wxGrid_BeginBatch WXCALL Alias "wxGrid_BeginBatch" (self As wxGrid Ptr)
Declare Sub wxGrid_EndBatch WXCALL Alias "wxGrid_EndBatch" (self As wxGrid Ptr)
Declare Function wxGrid_GetBatchCount WXCALL Alias "wxGrid_GetBatchCount" (self As wxGrid Ptr) As wxInt
Declare Sub wxGrid_ForceRefresh WXCALL Alias "wxGrid_ForceRefresh" (self As wxGrid Ptr)
Declare Function wxGrid_IsEditable WXCALL Alias "wxGrid_IsEditable" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_EnableEditing WXCALL Alias "wxGrid_EnableEditing" (self As wxGrid Ptr, edit As wxBool)
Declare Sub wxGrid_EnableCellEditControl WXCALL Alias "wxGrid_EnableCellEditControl" (self As wxGrid Ptr, enable As wxBool)
Declare Sub wxGrid_DisableCellEditControl WXCALL Alias "wxGrid_DisableCellEditControl" (self As wxGrid Ptr)
Declare Function wxGrid_CanEnableCellControl WXCALL Alias "wxGrid_CanEnableCellControl" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_IsCellEditControlEnabled WXCALL Alias "wxGrid_IsCellEditControlEnabled" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_IsCellEditControlShown WXCALL Alias "wxGrid_IsCellEditControlShown" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_IsCurrentCellReadOnly WXCALL Alias "wxGrid_IsCurrentCellReadOnly" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_ShowCellEditControl WXCALL Alias "wxGrid_ShowCellEditControl" (self As wxGrid Ptr)
Declare Sub wxGrid_HideCellEditControl WXCALL Alias "wxGrid_HideCellEditControl" (self As wxGrid Ptr)
Declare Sub wxGrid_SaveEditControlValue WXCALL Alias "wxGrid_SaveEditControlValue" (self As wxGrid Ptr)
Declare Function wxGrid_YToRow WXCALL Alias "wxGrid_YToRow" (self As wxGrid Ptr, y As wxInt) As wxInt
Declare Function wxGrid_XToCol WXCALL Alias "wxGrid_XToCol" (self As wxGrid Ptr, y As wxInt) As wxInt
Declare Function wxGrid_YToEdgeOfRow WXCALL Alias "wxGrid_YToEdgeOfRow" (self As wxGrid Ptr, y As wxInt) As wxInt
Declare Function wxGrid_XToEdgeOfCol WXCALL Alias "wxGrid_XToEdgeOfCol" (self As wxGrid Ptr, y As wxInt) As wxInt
Declare Sub wxGrid_CellToRect WXCALL Alias "wxGrid_CellToRect" (self As wxGrid Ptr, row As wxInt, col As wxInt, r As wxRect Ptr)
Declare Function wxGrid_GetGridCursorRow WXCALL Alias "wxGrid_GetGridCursorRow" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetGridCursorCol WXCALL Alias "wxGrid_GetGridCursorCol" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_IsVisible WXCALL Alias "wxGrid_IsVisible" (self As wxGrid Ptr, row As wxInt, col As wxInt, wholeCellVisible As wxBool) As wxBool
Declare Sub wxGrid_MakeCellVisible WXCALL Alias "wxGrid_MakeCellVisible" (self As wxGrid Ptr, row As wxInt, col As wxInt)
Declare Sub wxGrid_SetGridCursor WXCALL Alias "wxGrid_SetGridCursor" (self As wxGrid Ptr, row As wxInt, col As wxInt)
Declare Function wxGrid_MoveCursorUp WXCALL Alias "wxGrid_MoveCursorUp" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MoveCursorDown WXCALL Alias "wxGrid_MoveCursorDown" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MoveCursorLeft WXCALL Alias "wxGrid_MoveCursorLeft" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MoveCursorRight WXCALL Alias "wxGrid_MoveCursorRight" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MovePageDown WXCALL Alias "wxGrid_MovePageDown" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_MovePageUp WXCALL Alias "wxGrid_MovePageUp" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_MoveCursorUpBlock WXCALL Alias "wxGrid_MoveCursorUpBlock" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MoveCursorDownBlock WXCALL Alias "wxGrid_MoveCursorDownBlock" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MoveCursorLeftBlock WXCALL Alias "wxGrid_MoveCursorLeftBlock" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_MoveCursorRightBlock WXCALL Alias "wxGrid_MoveCursorRightBlock" (self As wxGrid Ptr, expandSelection As wxBool) As wxBool
Declare Function wxGrid_GetDefaultRowLabelSize WXCALL Alias "wxGrid_GetDefaultRowLabelSize" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetRowLabelSize WXCALL Alias "wxGrid_GetRowLabelSize" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetDefaultColLabelSize WXCALL Alias "wxGrid_GetDefaultColLabelSize" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetColLabelSize WXCALL Alias "wxGrid_GetColLabelSize" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetLabelBackgroundColour WXCALL Alias "wxGrid_GetLabelBackgroundColour" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetLabelTextColour WXCALL Alias "wxGrid_GetLabelTextColour" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetLabelFont WXCALL Alias "wxGrid_GetLabelFont" (self As wxGrid Ptr) As wxFont Ptr
Declare Sub wxGrid_GetRowLabelAlignment WXCALL Alias "wxGrid_GetRowLabelAlignment" (self As wxGrid Ptr, h As wxInt Ptr, v As wxInt Ptr)
Declare Sub wxGrid_GetColLabelAlignment WXCALL Alias "wxGrid_GetColLabelAlignment" (self As wxGrid Ptr, h As wxInt Ptr, v As wxInt Ptr)
Declare Function wxGrid_GetRowLabelValue WXCALL Alias "wxGrid_GetRowLabelValue" (self As wxGrid Ptr, row As wxInt) As wxString Ptr
Declare Function wxGrid_GetColLabelValue WXCALL Alias "wxGrid_GetColLabelValue" (self As wxGrid Ptr, col As wxInt) As wxString Ptr
Declare Function wxGrid_GetGridLineColour WXCALL Alias "wxGrid_GetGridLineColour" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetCellHighlightColour WXCALL Alias "wxGrid_GetCellHighlightColour" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetCellHighlightPenWidth WXCALL Alias "wxGrid_GetCellHighlightPenWidth" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetCellHighlightROPenWidth WXCALL Alias "wxGrid_GetCellHighlightROPenWidth" (self As wxGrid Ptr) As wxInt
Declare Sub wxGrid_SetRowLabelSize WXCALL Alias "wxGrid_SetRowLabelSize" (self As wxGrid Ptr, w As wxInt)
Declare Sub wxGrid_SetColLabelSize WXCALL Alias "wxGrid_SetColLabelSize" (self As wxGrid Ptr, h As wxInt)
Declare Sub wxGrid_SetLabelBackgroundColour WXCALL Alias "wxGrid_SetLabelBackgroundColour" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetLabelTextColour WXCALL Alias "wxGrid_SetLabelTextColour" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetLabelFont WXCALL Alias "wxGrid_SetLabelFont" (self As wxGrid Ptr, font As wxFont Ptr)
Declare Sub wxGrid_SetRowLabelAlignment WXCALL Alias "wxGrid_SetRowLabelAlignment" (self As wxGrid Ptr, h As wxInt, v As wxInt)
Declare Sub wxGrid_SetColLabelAlignment WXCALL Alias "wxGrid_SetColLabelAlignment" (self As wxGrid Ptr, h As wxInt, v As wxInt)
Declare Sub wxGrid_SetRowLabelValue WXCALL Alias "wxGrid_SetRowLabelValue" (self As wxGrid Ptr, row As wxInt, value As wxString Ptr)
Declare Sub wxGrid_SetColLabelValue WXCALL Alias "wxGrid_SetColLabelValue" (self As wxGrid Ptr, col As wxInt, value As wxString Ptr)
Declare Sub wxGrid_SetGridLineColour WXCALL Alias "wxGrid_SetGridLineColour" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetCellHighlightColour WXCALL Alias "wxGrid_SetCellHighlightColour" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetCellHighlightPenWidth WXCALL Alias "wxGrid_SetCellHighlightPenWidth" (self As wxGrid Ptr, w As wxInt)
Declare Sub wxGrid_SetCellHighlightROPenWidth WXCALL Alias "wxGrid_SetCellHighlightROPenWidth" (self As wxGrid Ptr, w As wxInt)
Declare Sub wxGrid_EnableDragRowSize WXCALL Alias "wxGrid_EnableDragRowSize" (self As wxGrid Ptr, enable As wxBool)
Declare Sub wxGrid_DisableDragRowSize WXCALL Alias "wxGrid_DisableDragRowSize" (self As wxGrid Ptr)
Declare Function wxGrid_CanDragRowSize WXCALL Alias "wxGrid_CanDragRowSize" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_EnableDragColSize WXCALL Alias "wxGrid_EnableDragColSize" (self As wxGrid Ptr, enable As wxBool)
Declare Sub wxGrid_DisableDragColSize WXCALL Alias "wxGrid_DisableDragColSize" (self As wxGrid Ptr)
Declare Function wxGrid_CanDragColSize WXCALL Alias "wxGrid_CanDragColSize" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_EnableDragGridSize WXCALL Alias "wxGrid_EnableDragGridSize" (self As wxGrid Ptr, enable As wxBool)
Declare Sub wxGrid_DisableDragGridSize WXCALL Alias "wxGrid_DisableDragGridSize" (self As wxGrid Ptr)
Declare Function wxGrid_CanDragGridSize WXCALL Alias "wxGrid_CanDragGridSize" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_SetAttr WXCALL Alias "wxGrid_SetAttr" (self As wxGrid Ptr, row As wxInt, col As wxInt, attr As wxGridCellAttr Ptr)
Declare Sub wxGrid_SetRowAttr WXCALL Alias "wxGrid_SetRowAttr" (self As wxGrid Ptr, row As wxInt, attr As wxGridCellAttr Ptr)
Declare Sub wxGrid_SetColAttr WXCALL Alias "wxGrid_SetColAttr" (self As wxGrid Ptr, col As wxInt, attr As wxGridCellAttr Ptr)
Declare Sub wxGrid_SetColFormatBool WXCALL Alias "wxGrid_SetColFormatBool" (self As wxGrid Ptr, col As wxInt)
Declare Sub wxGrid_SetColFormatNumber WXCALL Alias "wxGrid_SetColFormatNumber" (self As wxGrid Ptr, col As wxInt)
Declare Sub wxGrid_SetColFormatFloat WXCALL Alias "wxGrid_SetColFormatFloat" (self As wxGrid Ptr, col As wxInt, w As wxInt, precision As wxInt)
Declare Sub wxGrid_SetColFormatCustom WXCALL Alias "wxGrid_SetColFormatCustom" (self As wxGrid Ptr, col As wxInt, typeName As wxString Ptr)
Declare Sub wxGrid_EnableGridLines WXCALL Alias "wxGrid_EnableGridLines" (self As wxGrid Ptr, enable As wxBool)
Declare Function wxGrid_GridLinesEnabled WXCALL Alias "wxGrid_GridLinesEnabled" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_GetDefaultRowSize WXCALL Alias "wxGrid_GetDefaultRowSize" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetRowSize WXCALL Alias "wxGrid_GetRowSize" (self As wxGrid Ptr, row As wxInt) As wxInt
Declare Function wxGrid_GetDefaultColSize WXCALL Alias "wxGrid_GetDefaultColSize" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetColSize WXCALL Alias "wxGrid_GetColSize" (self As wxGrid Ptr, col As wxInt) As wxInt
Declare Function wxGrid_GetDefaultCellBackgroundColour WXCALL Alias "wxGrid_GetDefaultCellBackgroundColour" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetCellBackgroundColour WXCALL Alias "wxGrid_GetCellBackgroundColour" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxColour Ptr
Declare Function wxGrid_GetDefaultCellTextColour WXCALL Alias "wxGrid_GetDefaultCellTextColour" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetCellTextColour WXCALL Alias "wxGrid_GetCellTextColour" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxColour Ptr
Declare Function wxGrid_GetDefaultCellFont WXCALL Alias "wxGrid_GetDefaultCellFont" (self As wxGrid Ptr) As wxFont Ptr
Declare Function wxGrid_GetCellFont WXCALL Alias "wxGrid_GetCellFont" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxFont Ptr
Declare Sub wxGrid_GetDefaultCellAlignment WXCALL Alias "wxGrid_GetDefaultCellAlignment" (self As wxGrid Ptr, h As wxInt Ptr, v As wxInt Ptr)
Declare Sub wxGrid_GetCellAlignment WXCALL Alias "wxGrid_GetCellAlignment" (self As wxGrid Ptr, row As wxInt, col As wxInt, h As wxInt Ptr, v As wxInt Ptr)
Declare Function wxGrid_GetDefaultCellOverflow WXCALL Alias "wxGrid_GetDefaultCellOverflow" (self As wxGrid Ptr) As wxBool
Declare Function wxGrid_GetCellOverflow WXCALL Alias "wxGrid_GetCellOverflow" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxBool
Declare Sub wxGrid_GetCellSize WXCALL Alias "wxGrid_GetCellSize" (self As wxGrid Ptr, row As wxInt, col As wxInt, nRows As wxInt Ptr, nCols As wxInt Ptr)
Declare Sub wxGrid_SetDefaultRowSize WXCALL Alias "wxGrid_SetDefaultRowSize" (self As wxGrid Ptr, h As wxInt, resizeExistingRows As wxBool)
Declare Sub wxGrid_SetRowSize WXCALL Alias "wxGrid_SetRowSize" (self As wxGrid Ptr, row As wxInt, h As wxInt)
Declare Sub wxGrid_SetDefaultColSize WXCALL Alias "wxGrid_SetDefaultColSize" (self As wxGrid Ptr, w As wxInt, resizeExistingCols As wxBool)
Declare Sub wxGrid_SetColSize WXCALL Alias "wxGrid_SetColSize" (self As wxGrid Ptr, col As wxInt, w As wxInt)
Declare Sub wxGrid_AutoSizeColumn WXCALL Alias "wxGrid_AutoSizeColumn" (self As wxGrid Ptr, col As wxInt, setAsMin As wxBool)
Declare Sub wxGrid_AutoSizeRow WXCALL Alias "wxGrid_AutoSizeRow" (self As wxGrid Ptr, row As wxInt, setAsMin As wxBool)
Declare Sub wxGrid_AutoSizeColumns WXCALL Alias "wxGrid_AutoSizeColumns" (self As wxGrid Ptr, setAsMin As wxBool)
Declare Sub wxGrid_AutoSizeRows WXCALL Alias "wxGrid_AutoSizeRows" (self As wxGrid Ptr, setAsMin As wxBool)
Declare Sub wxGrid_AutoSize WXCALL Alias "wxGrid_AutoSize" (self As wxGrid Ptr)
Declare Sub wxGrid_SetColMinimalWidth WXCALL Alias "wxGrid_SetColMinimalWidth" (self As wxGrid Ptr, col As wxInt, w As wxInt)
Declare Sub wxGrid_SetRowMinimalHeight WXCALL Alias "wxGrid_SetRowMinimalHeight" (self As wxGrid Ptr, row As wxInt, w As wxInt)
Declare Sub wxGrid_SetColMinimalAcceptableWidth WXCALL Alias "wxGrid_SetColMinimalAcceptableWidth" (self As wxGrid Ptr, w As wxInt)
Declare Sub wxGrid_SetRowMinimalAcceptableHeight WXCALL Alias "wxGrid_SetRowMinimalAcceptableHeight" (self As wxGrid Ptr, w As wxInt)
Declare Function wxGrid_GetColMinimalAcceptableWidth WXCALL Alias "wxGrid_GetColMinimalAcceptableWidth" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetRowMinimalAcceptableHeight WXCALL Alias "wxGrid_GetRowMinimalAcceptableHeight" (self As wxGrid Ptr) As wxInt
Declare Sub wxGrid_SetDefaultCellBackgroundColour WXCALL Alias "wxGrid_SetDefaultCellBackgroundColour" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetDefaultCellTextColour WXCALL Alias "wxGrid_SetDefaultCellTextColour" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetDefaultCellFont WXCALL Alias "wxGrid_SetDefaultCellFont" (self As wxGrid Ptr, font As wxFont Ptr)
Declare Sub wxGrid_SetCellFont WXCALL Alias "wxGrid_SetCellFont" (self As wxGrid Ptr, row As wxInt, col As wxInt, font As wxFont Ptr)
Declare Sub wxGrid_SetDefaultCellAlignment WXCALL Alias "wxGrid_SetDefaultCellAlignment" (self As wxGrid Ptr, h As wxInt, v As wxInt)
Declare Sub wxGrid_SetCellAlignmentHV WXCALL Alias "wxGrid_SetCellAlignmentHV" (self As wxGrid Ptr, row As wxInt, col As wxInt, h As wxInt, v As wxInt)
Declare Sub wxGrid_SetDefaultCellOverflow WXCALL Alias "wxGrid_SetDefaultCellOverflow" (self As wxGrid Ptr, allow As wxBool)
Declare Sub wxGrid_SetCellOverflow WXCALL Alias "wxGrid_SetCellOverflow" (self As wxGrid Ptr, row As wxInt, col As wxInt, allow As wxBool)
Declare Sub wxGrid_SetCellSize WXCALL Alias "wxGrid_SetCellSize" (self As wxGrid Ptr, row As wxInt, col As wxInt, nRows As wxInt, nCols As wxInt)
Declare Sub wxGrid_SetDefaultRenderer WXCALL Alias "wxGrid_SetDefaultRenderer" (self As wxGrid Ptr, renderer As wxGridCellRenderer Ptr)
Declare Sub wxGrid_SetCellRenderer WXCALL Alias "wxGrid_SetCellRenderer" (self As wxGrid Ptr, row As wxInt, col As wxInt, renderer As wxGridCellRenderer Ptr)
Declare Function wxGrid_GetDefaultRenderer WXCALL Alias "wxGrid_GetDefaultRenderer" (self As wxGrid Ptr) As wxGridCellRenderer Ptr
Declare Function wxGrid_GetCellRenderer WXCALL Alias "wxGrid_GetCellRenderer" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxGridCellRenderer Ptr
Declare Sub wxGrid_SetDefaultEditor WXCALL Alias "wxGrid_SetDefaultEditor" (self As wxGrid Ptr, editor As wxGridCellEditor Ptr)
Declare Sub wxGrid_SetCellEditor WXCALL Alias "wxGrid_SetCellEditor" (self As wxGrid Ptr, row As wxInt, col As wxInt, editor As wxGridCellEditor Ptr)
Declare Function wxGrid_GetDefaultEditor WXCALL Alias "wxGrid_GetDefaultEditor" (self As wxGrid Ptr) As wxGridCellEditor Ptr
Declare Function wxGrid_GetCellEditor WXCALL Alias "wxGrid_GetCellEditor" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxGridCellEditor Ptr
Declare Function wxGrid_GetCellValue WXCALL Alias "wxGrid_GetCellValue" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxString Ptr
Declare Sub wxGrid_SetCellValue WXCALL Alias "wxGrid_SetCellValue" (self As wxGrid Ptr, row As wxInt, col As wxInt, Value As wxString Ptr)
Declare Function wxGrid_IsReadOnly WXCALL Alias "wxGrid_IsReadOnly" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxBool
Declare Sub wxGrid_SetReadOnly WXCALL Alias "wxGrid_SetReadOnly" (self As wxGrid Ptr, row As wxInt, col As wxInt, IsReadOnly As wxBool)
Declare Sub wxGrid_SelectRow WXCALL Alias "wxGrid_SelectRow" (self As wxGrid Ptr, row As wxInt, addToEnd As wxBool)
Declare Sub wxGrid_SelectCol WXCALL Alias "wxGrid_SelectCol" (self As wxGrid Ptr, col As wxInt, addToEnd As wxBool)
Declare Sub wxGrid_SelectBlock WXCALL Alias "wxGrid_SelectBlock" (self As wxGrid Ptr, topRow As wxInt, leftCol As wxInt, bottomRow As wxInt, rightCol As wxInt, addToSelected As wxBool)
Declare Sub wxGrid_SelectAll WXCALL Alias "wxGrid_SelectAll" (self As wxGrid Ptr)
Declare Function wxGrid_IsSelection WXCALL Alias "wxGrid_IsSelection" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_DeselectRow WXCALL Alias "wxGrid_DeselectRow" (self As wxGrid Ptr, row As wxInt)
Declare Sub wxGrid_DeselectCol WXCALL Alias "wxGrid_DeselectCol" (self As wxGrid Ptr, col As wxInt)
Declare Sub wxGrid_DeselectCell WXCALL Alias "wxGrid_DeselectCell" (self As wxGrid Ptr, row As wxInt, col As wxInt)
Declare Sub wxGrid_ClearSelection WXCALL Alias "wxGrid_ClearSelection" (self As wxGrid Ptr)
Declare Function wxGrid_IsInSelection WXCALL Alias "wxGrid_IsInSelection" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxBool
Declare Function wxGrid_GetSelectedCells WXCALL Alias "wxGrid_GetSelectedCells" (self As wxGrid Ptr) As wxGridCellCoordsArray Ptr
Declare Function wxGrid_GetSelectionBlockTopLeft WXCALL Alias "wxGrid_GetSelectionBlockTopLeft" (self As wxGrid Ptr) As wxGridCellCoordsArray Ptr
Declare Function wxGrid_GetSelectionBlockBottomRight WXCALL Alias "wxGrid_GetSelectionBlockBottomRight" (self As wxGrid Ptr) As wxGridCellCoordsArray Ptr
Declare Function wxGrid_GetSelectedRows WXCALL Alias "wxGrid_GetSelectedRows" (self As wxGrid Ptr) As wxArrayInt Ptr
Declare Function wxGrid_GetSelectedCols WXCALL Alias "wxGrid_GetSelectedCols" (self As wxGrid Ptr) As wxArrayInt Ptr
Declare Sub wxGrid_BlockToDeviceRect WXCALL Alias "wxGrid_BlockToDeviceRect" (self As wxGrid Ptr, topLeft As wxGridCellCoords Ptr, bottomRight As wxGridCellCoords Ptr, r As wxRect Ptr)
Declare Function wxGrid_GetSelectionBackground WXCALL Alias "wxGrid_GetSelectionBackground" (self As wxGrid Ptr) As wxColour Ptr
Declare Function wxGrid_GetSelectionForeground WXCALL Alias "wxGrid_GetSelectionForeground" (self As wxGrid Ptr) As wxColour Ptr
Declare Sub wxGrid_SetSelectionBackground WXCALL Alias "wxGrid_SetSelectionBackground" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetSelectionForeground WXCALL Alias "wxGrid_SetSelectionForeground" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_RegisterDataType WXCALL Alias "wxGrid_RegisterDataType" (self As wxGrid Ptr, typeName As wxString Ptr, renderer As wxGridCellRenderer Ptr, editor As wxGridCellEditor Ptr)
Declare Function wxGrid_GetDefaultEditorForCell WXCALL Alias "wxGrid_GetDefaultEditorForCell" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxGridCellEditor Ptr
Declare Function wxGrid_GetDefaultRendererForCell WXCALL Alias "wxGrid_GetDefaultRendererForCell" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxGridCellRenderer Ptr
Declare Function wxGrid_GetDefaultEditorForType WXCALL Alias "wxGrid_GetDefaultEditorForType" (self As wxGrid Ptr, typeName As wxString Ptr) As wxGridCellEditor Ptr
Declare Function wxGrid_GetDefaultRendererForType WXCALL Alias "wxGrid_GetDefaultRendererForType" (self As wxGrid Ptr, typeName As wxString Ptr) As wxGridCellRenderer Ptr
Declare Sub wxGrid_SetMargins WXCALL Alias "wxGrid_SetMargins" (self As wxGrid Ptr, w As wxInt, h As wxInt)
Declare Function wxGrid_GetGridWindow WXCALL Alias "wxGrid_GetGridWindow" (self As wxGrid Ptr) As wxWindow Ptr
Declare Function wxGrid_GetGridRowLabelWindow WXCALL Alias "wxGrid_GetGridRowLabelWindow" (self As wxGrid Ptr) As wxWindow Ptr
Declare Function wxGrid_GetGridColLabelWindow WXCALL Alias "wxGrid_GetGridColLabelWindow" (self As wxGrid Ptr) As wxWindow Ptr
Declare Function wxGrid_GetGridCornerLabelWindow WXCALL Alias "wxGrid_GetGridCornerLabelWindow" (self As wxGrid Ptr) As wxWindow Ptr
Declare Sub wxGrid_UpdateDimensions WXCALL Alias "wxGrid_UpdateDimensions" (self As wxGrid Ptr)
Declare Function wxGrid_GetRows WXCALL Alias "wxGrid_GetRows" (self As wxGrid Ptr) As wxInt 
Declare Function wxGrid_GetCols WXCALL Alias "wxGrid_GetCols" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetCursorRow WXCALL Alias "wxGrid_GetCursorRow" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetCursorColumn WXCALL Alias "wxGrid_GetCursorColumn" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetScrollPosX WXCALL Alias "wxGrid_GetScrollPosX" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetScrollPosY WXCALL Alias "wxGrid_GetScrollPosY" (self As wxGrid Ptr) As wxInt
Declare Sub wxGrid_SetScrollX WXCALL Alias "wxGrid_SetScrollX" (self As wxGrid Ptr, y As wxInt)
Declare Sub wxGrid_SetScrollY WXCALL Alias "wxGrid_SetScrollY" (self As wxGrid Ptr, y As wxInt)
Declare Sub wxGrid_SetColumnWidth WXCALL Alias "wxGrid_SetColumnWidth" (self As wxGrid Ptr, col As wxInt, w As wxInt)
Declare Function wxGrid_GetColumnWidth WXCALL Alias "wxGrid_GetColumnWidth" (self As wxGrid Ptr, col As wxInt) As wxInt
Declare Sub wxGrid_SetRowHeight WXCALL Alias "wxGrid_SetRowHeight" (self As wxGrid Ptr, row As wxInt, h As wxInt)
Declare Function wxGrid_GetViewHeight WXCALL Alias "wxGrid_GetViewHeight" (self As wxGrid Ptr) As wxInt
Declare Function wxGrid_GetViewWidth WXCALL Alias "wxGrid_GetViewWidth" (self As wxGrid Ptr) As wxInt
Declare Sub wxGrid_SetLabelSize WXCALL Alias "wxGrid_SetLabelSize" (self As wxGrid Ptr, orientation As wxInt, sz As wxInt)
Declare Function wxGrid_GetLabelSize WXCALL Alias "wxGrid_GetLabelSize" (self As wxGrid Ptr, orientation As wxInt) As wxInt
Declare Sub wxGrid_SetLabelAlignment WXCALL Alias "wxGrid_SetLabelAlignment" (self As wxGrid Ptr, orientation As wxInt, align As wxInt)
Declare Function wxGrid_GetLabelAlignment WXCALL Alias "wxGrid_GetLabelAlignment" (self As wxGrid Ptr, orientation As wxInt, align As wxInt) As wxInt
Declare Sub wxGrid_SetLabelValue WXCALL Alias "wxGrid_SetLabelValue" (self As wxGrid Ptr, orientation As wxInt, value As wxString Ptr,position As wxInt)
Declare Function wxGrid_GetLabelValue WXCALL Alias "wxGrid_GetLabelValue" (self As wxGrid Ptr, orientation As wxInt,position As wxInt) As wxString Ptr
Declare Function wxGrid_GetCellTextFontGrid WXCALL Alias "wxGrid_GetCellTextFontGrid" (self As wxGrid Ptr) As wxFont Ptr
Declare Function wxGrid_GetCellTextFont WXCALL Alias "wxGrid_GetCellTextFont" (self As wxGrid Ptr, row As wxInt, col As wxInt) As wxFont Ptr
Declare Sub wxGrid_SetCellTextFontGrid WXCALL Alias "wxGrid_SetCellTextFontGrid" (self As wxGrid Ptr, font As wxFont Ptr)
Declare Sub wxGrid_SetCellTextFont WXCALL Alias "wxGrid_SetCellTextFont" (self As wxGrid Ptr, font As wxFont Ptr, row As wxInt, col As wxInt)
Declare Sub wxGrid_SetCellTextColour WXCALL Alias "wxGrid_SetCellTextColour" (self As wxGrid Ptr, row As wxInt, col As wxInt, c As wxColour Ptr)
Declare Sub wxGrid_SetCellTextColourGrid WXCALL Alias "wxGrid_SetCellTextColourGrid" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetCellBackgroundColourGrid WXCALL Alias "wxGrid_SetCellBackgroundColourGrid" (self As wxGrid Ptr, col As wxColour Ptr)
Declare Sub wxGrid_SetCellBackgroundColour WXCALL Alias "wxGrid_SetCellBackgroundColour" (self As wxGrid Ptr, row As wxInt, col As wxInt, col As wxColour Ptr)
Declare Function wxGrid_GetEditable WXCALL Alias "wxGrid_GetEditable" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_SetEditable WXCALL Alias "wxGrid_SetEditable" (self As wxGrid Ptr, edit As wxBool)
Declare Function wxGrid_GetEditInPlace WXCALL Alias "wxGrid_GetEditInPlace" (self As wxGrid Ptr) As wxBool
Declare Sub wxGrid_SetCellAlignment WXCALL Alias "wxGrid_SetCellAlignment" (self As wxGrid Ptr, align As wxInt, row As wxInt, col As wxInt)
Declare Sub wxGrid_SetCellAlignmentGrid WXCALL Alias "wxGrid_SetCellAlignmentGrid" (self As wxGrid Ptr, align As wxInt)
Declare Sub wxGrid_SetCellBitmap WXCALL Alias "wxGrid_SetCellBitmap" (self As wxGrid Ptr, bitmap As wxBitmap Ptr, row As wxInt, col As wxInt)
Declare Sub wxGrid_SetDividerPen WXCALL Alias "wxGrid_SetDividerPen" (self As wxGrid Ptr, pen As wxPen Ptr)
Declare Function wxGrid_GetDividerPen WXCALL Alias "wxGrid_GetDividerPen" (self As wxGrid Ptr) As wxPen Ptr
Declare Sub wxGrid_OnActivate WXCALL Alias "wxGrid_OnActivate" (self As wxGrid Ptr, active As wxBool)
Declare Function wxGrid_GetRowHeight WXCALL Alias "wxGrid_GetRowHeight" (self As wxGrid Ptr, row As wxInt) As wxInt

' class wxGridCellCoords
Declare Function wxGridCellCoords_ctor WXCALL Alias "wxGridCellCoords_ctor" () As wxGridCellCoords Ptr
Declare Sub wxGridCellCoords_dtor WXCALL Alias "wxGridCellCoords_dtor" (self As wxGridCellCoords Ptr)
Declare Function wxGridCellCoords_GetRow WXCALL Alias "wxGridCellCoords_GetRow" (self As wxGridCellCoords Ptr) As wxInt
Declare Sub wxGridCellCoords_SetRow WXCALL Alias "wxGridCellCoords_SetRow" (self As wxGridCellCoords Ptr, n As wxInt)
Declare Function wxGridCellCoords_GetCol WXCALL Alias "wxGridCellCoords_GetCol" (self As wxGridCellCoords Ptr) As wxInt
Declare Sub wxGridCellCoords_SetCol WXCALL Alias "wxGridCellCoords_SetCol" (self As wxGridCellCoords Ptr, n As wxInt)
Declare Sub wxGridCellCoords_Set WXCALL Alias "wxGridCellCoords_Set" (self As wxGridCellCoords Ptr, row As wxInt, col As wxInt)
Declare Sub wxGridCellCoordsArray_dtor WXCALL Alias "wxGridCellCoordsArray_dtor" (sel As wxGridCellCoordsArray Ptr)
Declare Function wxGridCellCoordsArray_Item WXCALL Alias "wxGridCellCoordsArray_Item" (sel As wxGridCellCoordsArray Ptr, n As wxInt) As wxGridCellCoords Ptr
Declare Function wxGridCellCoordsArray_GetCount WXCALL Alias "wxGridCellCoordsArray_GetCount" (sel As wxGridCellCoordsArray Ptr) As wxInt

' class wxGridCellAttr
Declare Function wxGridCellAttr_ctor WXCALL Alias "wxGridCellAttr_ctor" (TextCol As wxColour Ptr, colBack As wxColour Ptr, font As wxFont Ptr, h As wxInt, v As wxInt) As wxGridCellAttr Ptr
Declare Function wxGridCellAttr_ctor2 WXCALL Alias "wxGridCellAttr_ctor2" () As wxGridCellAttr Ptr
Declare Function wxGridCellAttr_ctor3 WXCALL Alias "wxGridCellAttr_ctor3" (DefaultAttr As wxGridCellAttr Ptr) As wxGridCellAttr Ptr
Declare Sub wxGridCellAttr_RegisterDispose WXCALL Alias "wxGridCellAttr_RegisterDispose" (sel As wxGridCellAttr Ptr, on_dispose As Virtual_Dispose)
Declare Function wxGridCellAttr_Clone WXCALL Alias "wxGridCellAttr_Clone" (self As wxGridCellAttr Ptr) As wxGridCellAttr Ptr
Declare Sub wxGridCellAttr_MergeWith WXCALL Alias "wxGridCellAttr_MergeWith" (sel As wxGridCellAttr Ptr, mergefrom As wxGridCellAttr Ptr)
Declare Sub wxGridCellAttr_IncRef WXCALL Alias "wxGridCellAttr_IncRef" (sel As wxGridCellAttr Ptr)
Declare Sub wxGridCellAttr_DecRef WXCALL Alias "wxGridCellAttr_DecRef" (sel As wxGridCellAttr Ptr)
Declare Sub wxGridCellAttr_SetTextColour WXCALL Alias "wxGridCellAttr_SetTextColour" (sel As wxGridCellAttr Ptr, col As wxColour Ptr)
Declare Sub wxGridCellAttr_SetBackgroundColour WXCALL Alias "wxGridCellAttr_SetBackgroundColour" (sel As wxGridCellAttr Ptr, col As wxColour Ptr)
Declare Sub wxGridCellAttr_SetFont WXCALL Alias "wxGridCellAttr_SetFont" (sel As wxGridCellAttr Ptr, font As wxFont Ptr)
Declare Sub wxGridCellAttr_SetAlignment WXCALL Alias "wxGridCellAttr_SetAlignment" (sel As wxGridCellAttr Ptr, h As wxInt, v As wxInt)
Declare Sub wxGridCellAttr_SetSize WXCALL Alias "wxGridCellAttr_SetSize" (sel As wxGridCellAttr Ptr, nRows As wxInt, nCols As wxInt)
Declare Sub wxGridCellAttr_SetOverflow WXCALL Alias "wxGridCellAttr_SetOverflow" (sel As wxGridCellAttr Ptr, allow As wxBool)
Declare Sub wxGridCellAttr_SetReadOnly WXCALL Alias "wxGridCellAttr_SetReadOnly" (sel As wxGridCellAttr Ptr, IsReadOnly As wxBool)
Declare Sub wxGridCellAttr_SetRenderer WXCALL Alias "wxGridCellAttr_SetRenderer" (sel As wxGridCellAttr Ptr, renderer As wxGridCellRenderer Ptr)
Declare Sub wxGridCellAttr_SetEditor WXCALL Alias "wxGridCellAttr_SetEditor" (sel As wxGridCellAttr Ptr, editor As wxGridCellEditor Ptr)
Declare Function wxGridCellAttr_HasTextColour WXCALL Alias "wxGridCellAttr_HasTextColour" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_HasBackgroundColour WXCALL Alias "wxGridCellAttr_HasBackgroundColour" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_HasFont WXCALL Alias "wxGridCellAttr_HasFont" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_HasAlignment WXCALL Alias "wxGridCellAttr_HasAlignment" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_HasRenderer WXCALL Alias "wxGridCellAttr_HasRenderer" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_HasEditor WXCALL Alias "wxGridCellAttr_HasEditor" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_HasReadWriteMode WXCALL Alias "wxGridCellAttr_HasReadWriteMode" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_GetTextColour WXCALL Alias "wxGridCellAttr_GetTextColour" (sel As wxGridCellAttr Ptr) As wxColour Ptr
Declare Function wxGridCellAttr_GetBackgroundColour WXCALL Alias "wxGridCellAttr_GetBackgroundColour" (sel As wxGridCellAttr Ptr) As wxColour Ptr
Declare Function wxGridCellAttr_GetFont WXCALL Alias "wxGridCellAttr_GetFont" (sel As wxGridCellAttr Ptr) As wxFont Ptr
Declare Sub wxGridCellAttr_GetAlignment WXCALL Alias "wxGridCellAttr_GetAlignment" (sel As wxGridCellAttr Ptr, h As wxInt Ptr, v As wxInt Ptr)
Declare Sub wxGridCellAttr_GetSize WXCALL Alias "wxGridCellAttr_GetSize" (sel As wxGridCellAttr Ptr, nRows As wxInt Ptr, nCols As wxInt Ptr)
Declare Function wxGridCellAttr_GetOverflow WXCALL Alias "wxGridCellAttr_GetOverflow" (sel As wxGridCellAttr Ptr) As wxBool
Declare Function wxGridCellAttr_GetRenderer WXCALL Alias "wxGridCellAttr_GetRenderer" (sel As wxGridCellAttr Ptr, grid As wxGrid Ptr, row As wxInt, col As wxInt) As wxGridCellRenderer Ptr
Declare Function wxGridCellAttr_GetEditor WXCALL Alias "wxGridCellAttr_GetEditor" (sel As wxGridCellAttr Ptr, grid As wxGrid Ptr, row As wxInt, col As wxInt) As wxGridCellEditor Ptr
Declare Function wxGridCellAttr_IsReadOnly WXCALL Alias "wxGridCellAttr_IsReadOnly" (sel As wxGridCellAttr Ptr) As wxBool 
Declare Sub wxGridCellAttr_SetDefAttr WXCALL Alias "wxGridCellAttr_SetDefAttr" (sel As wxGridCellAttr Ptr, attr As wxGridCellAttr Ptr)

' class wxGridSizeEvent
Declare Function wxGridSizeEvent_ctor WXCALL Alias "wxGridSizeEvent_ctor" () As wxGridSizeEvent Ptr
Declare Function wxGridSizeEvent_ctorParam WXCALL Alias "wxGridSizeEvent_ctorParam" (id As  wxInt, _
                               typ      As  wxEventType, _
                               obj      As wxObject Ptr, _
                               RowOrCol As  wxInt, _
                               x        As  wxInt, _
                               y        As  wxInt, _
                               control  As  wxBool, _
                               shift    As  wxBool, _
                               alt      As  wxBool, _
                               meta     As  wxBool) As wxGridSizeEvent Ptr
Declare Function wxGridSizeEvent_GetRowOrCol WXCALL Alias "wxGridSizeEvent_GetRowOrCol" (self As wxGridSizeEvent Ptr) As wxInt
Declare Sub wxGridSizeEvent_GetPosition WXCALL Alias "wxGridSizeEvent_GetPosition" (self As wxGridSizeEvent Ptr, pt As wxPoint Ptr)
Declare Function wxGridSizeEvent_ControlDown WXCALL Alias "wxGridSizeEvent_ControlDown" (self As wxGridSizeEvent Ptr) As wxBool
Declare Function wxGridSizeEvent_MetaDown WXCALL Alias "wxGridSizeEvent_MetaDown" (self As wxGridSizeEvent Ptr) As wxBool
Declare Function wxGridSizeEvent_ShiftDown WXCALL Alias "wxGridSizeEvent_ShiftDown" (self As wxGridSizeEvent Ptr) As wxBool
Declare Function wxGridSizeEvent_AltDown WXCALL Alias "wxGridSizeEvent_AltDown" (self As wxGridSizeEvent Ptr) As wxBool
Declare Sub wxGridSizeEvent_Veto WXCALL Alias "wxGridSizeEvent_Veto" (self As wxGridSizeEvent Ptr)
Declare Sub wxGridSizeEvent_Allow WXCALL Alias "wxGridSizeEvent_Allow" (self As wxGridSizeEvent Ptr)
Declare Function wxGridSizeEvent_IsAllowed WXCALL Alias "wxGridSizeEvent_IsAllowed" (self As wxGridSizeEvent Ptr) As wxBool

' class wxGridCellEditor
Declare Function wxGridCellEditor_ctor WXCALL Alias "wxGridCellEditor_ctor" () As wxGridCellEditor Ptr
Declare Sub wxGridCellEditor_RegisterVirtual WXCALL Alias "wxGridCellEditor_RegisterVirtual" (self As wxGridCellEditor Ptr, _
                                      on_dispose  As Virtual_Dispose, _
                                      fCreate     As Virtual_Create, _
                                      fBeginEdit  As Virtual_BeginEdit, _
                                      fEndEdit    As Virtual_EndEdit, _
                                      fReset      As Virtual_Reset, _
                                      fClone      As Virtual_Clone, _
                                      fSetSize    As Virtual_SetSize, _
                                      fShow       As Virtual_Show, _
                                      fPaintBgr   As Virtual_PaintBackground , _
                                      fIsAccKey   As Virtual_IsAcceptedKey , _
                                      fStartKey   As Virtual_StartingKey, _
                                      fStartClick As Virtual_StartingClick, _
                                      fHandleRet  As Virtual_HandleReturn, _
                                      fDestroy    As Virtual_Destroy, _
                                      fGetValue   As Virtual_GetValue)
Declare Sub wxGridCellEditor_DeregisterVirtual WXCALL Alias "wxGridCellEditor_DeregisterVirtual" (self As wxGridCellEditor Ptr)
Declare Sub wxGridCellEditor_dtor WXCALL Alias "wxGridCellEditor_dtor" (self As wxGridCellEditor Ptr)
Declare Sub wxGridCellEditor_Create WXCALL Alias "wxGridCellEditor_Create" (self As wxGridCellEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evh As wxEventHandler Ptr)
Declare Function wxGridCellEditor_IsCreated WXCALL Alias "wxGridCellEditor_IsCreated" (self As wxGridCellEditor Ptr) As wxBool
Declare Sub wxGridCellEditor_SetControl WXCALL Alias "wxGridCellEditor_SetControl" (self As wxGridCellEditor Ptr, control As wxControl Ptr)
Declare Function wxGridCellEditor_GetControl WXCALL Alias "wxGridCellEditor_GetControl" (self As wxGridCellEditor Ptr) As wxControl Ptr
Declare Function wxGridCellEditor_IsAcceptedKey WXCALL Alias "wxGridCellEditor_IsAcceptedKey" (self As wxGridCellEditor Ptr, evnt As wxKeyEvent Ptr) As wxBool
Declare Sub wxGridCellEditor_SetSize WXCALL Alias "wxGridCellEditor_SetSize" (self As wxGridCellEditor Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt)
Declare Sub wxGridCellEditor_Show WXCALL Alias "wxGridCellEditor_Show" (self As wxGridCellEditor Ptr, show As wxBool, attr As wxGridCellAttr Ptr)
Declare Sub wxGridCellEditor_PaintBackground WXCALL Alias "wxGridCellEditor_PaintBackground" (self As wxGridCellEditor Ptr, r As wxRect Ptr, attr As wxGridCellAttr Ptr)
Declare Sub wxGridCellEditor_StartingKey WXCALL Alias "wxGridCellEditor_StartingKey" (self As wxGridCellEditor Ptr, evnt As wxKeyEvent Ptr)
Declare Sub wxGridCellEditor_StartingClick WXCALL Alias "wxGridCellEditor_StartingClick" (self As wxGridCellEditor Ptr)
Declare Sub wxGridCellEditor_HandleReturn WXCALL Alias "wxGridCellEditor_HandleReturn" (self As wxGridCellEditor Ptr, evnt As wxKeyEvent Ptr)
Declare Sub wxGridCellEditor_Destroy WXCALL Alias "wxGridCellEditor_Destroy" (self As wxGridCellEditor Ptr)

' class wxGridTableBase...
Declare Function wxGridTableBase_ctor WXCALL Alias "wxGridTableBase_ctor" () As wxGridTableBase Ptr
Declare Sub wxGridTableBase_RegisterVirtual WXCALL Alias "wxGridTableBase_RegisterVirtual" (self As wxGridTableBase Ptr, _
                                     fGetNumberRows     As Virtual_GetNumberRows, _
                                     fGetNumberCols     As Virtual_GetNumberCols, _
                                     fIsEmptyCell       As Virtual_IsEmptyCell, _
                                     fGetValue          As Virtual_GetValue2, _
                                     fSetValue          As Virtual_SetValue, _
                                     fGetTypeName       As Virtual_GetValue2, _
                                     fCanGetValueAs     As Virtual_CanGetValueAs, _
                                     fCanSetValueAs     As Virtual_CanGetValueAs, _
                                     fGetValueAsLong    As Virtual_GetValueAsLong, _
                                     fGetValueAsDouble  As Virtual_GetValueAsDouble, _
                                     fGetValueAsBool    As Virtual_IsEmptyCell, _
                                     fSetValueAsLong    As Virtual_SetValueAsLong, _
                                     fSetValueAsDouble  As Virtual_SetValueAsDouble, _
                                     fSetValueAsBool    As Virtual_SetValueAsBool, _
                                     fGetValueAsCustom  As Virtual_GetValueAsCustom, _
                                     fSetValueAsCustom  As Virtual_SetValueAsCustom, _
                                     fSetView           As Virtual_SetView, _
                                     fGetView           As Virtual_GetView, _
                                     fClear             As Virtual_Clear, _
                                     fInsertRows        As Virtual_InsertRows, _
                                     fAppendRows        As Virtual_AppendRows, _
                                     fDeleteRows        As Virtual_InsertRows, _ 
                                     fInsertCols        As Virtual_InsertRows, _
                                     fAppendCols        As Virtual_AppendRows, _
                                     fDeleteCols        As Virtual_InsertRows, _
                                     fGetRowLabelValue  As Virtual_GetColLabelValue, _
                                     fGetColLabelValue  As Virtual_GetColLabelValue, _
                                     fSetRowLabelValue  As Virtual_SetRowLabelValue, _
                                     fSetColLabelValue  As Virtual_SetRowLabelValue, _
                                     fSetAttrProvider   As Virtual_SetAttrProvider, _
                                     fGetAttrProvider   As Virtual_GetAttrProvider, _
                                     fCanHaveAttributes As Virtual_CanHaveAttributes, _
                                     fGetAttr           As Virtual_GetAttr, _
                                     fSetAttr           As Virtual_SetAttr, _
                                     fSetRowAttr        As Virtual_SetRowAttr, _
                                     fsetColAttr        As Virtual_SetRowAttr)
Declare Function wxGridTableBase_GetTypeName WXCALL Alias "wxGridTableBase_GetTypeName" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt) As wxString Ptr
Declare Function wxGridTableBase_CanGetValueAs WXCALL Alias "wxGridTableBase_CanGetValueAs" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, typeName As wxString Ptr) As wxBool
Declare Function wxGridTableBase_CanSetValueAs WXCALL Alias "wxGridTableBase_CanSetValueAs" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, typeName As wxString Ptr) As wxBool
Declare Function wxGridTableBase_GetValueAsLong WXCALL Alias "wxGridTableBase_GetValueAsLong" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt) As wxLong
Declare Function wxGridTableBase_GetValueAsDouble WXCALL Alias "wxGridTableBase_GetValueAsDouble" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt) As wxDouble
Declare Function wxGridTableBase_GetValueAsBool WXCALL Alias "wxGridTableBase_GetValueAsBool" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt) As wxBool
Declare Sub wxGridTableBase_SetValueAsLong WXCALL Alias "wxGridTableBase_SetValueAsLong" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, value As wxLong)
Declare Sub wxGridTableBase_SetValueAsDouble WXCALL Alias "wxGridTableBase_SetValueAsDouble" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, value As wxDouble)
Declare Sub wxGridTableBase_SetValueAsBool WXCALL Alias "wxGridTableBase_SetValueAsBool" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, value As wxBool)
Declare Function wxGridTableBase_GetValueAsCustom WXCALL Alias "wxGridTableBase_GetValueAsCustom" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, typeName As wxString Ptr) As Any Ptr
Declare Sub wxGridTableBase_SetValueAsCustom WXCALL Alias "wxGridTableBase_SetValueAsCustom" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, typeName As wxString Ptr, value As Any Ptr)
Declare Sub wxGridTableBase_SetView WXCALL Alias "wxGridTableBase_SetView" (self As wxGridTableBase Ptr, grid As wxGrid Ptr)
Declare Function wxGridTableBase_GetView WXCALL Alias "wxGridTableBase_GetView" (self As wxGridTableBase Ptr) As wxGrid Ptr
Declare Sub wxGridTableBase_Clear WXCALL Alias "wxGridTableBase_Clear" (self As wxGridTableBase Ptr)
Declare Function wxGridTableBase_InsertRows WXCALL Alias "wxGridTableBase_InsertRows" (self As wxGridTableBase Ptr,position As wxInt, numRows As wxInt) As wxBool
Declare Function wxGridTableBase_AppendRows WXCALL Alias "wxGridTableBase_AppendRows" (self As wxGridTableBase Ptr, numRows As wxInt) As wxBool
Declare Function wxGridTableBase_DeleteRows WXCALL Alias "wxGridTableBase_DeleteRows" (self As wxGridTableBase Ptr,position As wxInt, numRows As wxInt) As wxBool
Declare Function wxGridTableBase_InsertCols WXCALL Alias "wxGridTableBase_InsertCols" (self As wxGridTableBase Ptr,position As wxInt,  numCols As wxInt) As wxBool
Declare Function wxGridTableBase_AppendCols WXCALL Alias "wxGridTableBase_AppendCols" (self As wxGridTableBase Ptr,  numCols As wxInt) As wxBool
Declare Function wxGridTableBase_DeleteCols WXCALL Alias "wxGridTableBase_DeleteCols" (self As wxGridTableBase Ptr,position As wxInt, numCols As wxInt) As wxBool
Declare Function wxGridTableBase_GetRowLabelValue WXCALL Alias "wxGridTableBase_GetRowLabelValue" (self As wxGridTableBase Ptr, row As wxInt) As wxString Ptr
Declare Function wxGridTableBase_GetColLabelValue WXCALL Alias "wxGridTableBase_GetColLabelValue" (self As wxGridTableBase Ptr, col As wxInt) As wxString Ptr
Declare Sub wxGridTableBase_SetRowLabelValue WXCALL Alias "wxGridTableBase_SetRowLabelValue" (self As wxGridTableBase Ptr, row As wxInt, value As wxString Ptr)
Declare Sub wxGridTableBase_SetColLabelValue WXCALL Alias "wxGridTableBase_SetColLabelValue" (self As wxGridTableBase Ptr, col As wxInt, value As wxString Ptr)
Declare Sub wxGridTableBase_SetAttrProvider WXCALL Alias "wxGridTableBase_SetAttrProvider" (self As wxGridTableBase Ptr, ap As wxGridCellAttrProvider Ptr)
Declare Function wxGridTableBase_GetAttrProvider WXCALL Alias "wxGridTableBase_GetAttrProvider" (self As wxGridTableBase Ptr) As wxGridCellAttrProvider Ptr
Declare Function wxGridTableBase_CanHaveAttributes WXCALL Alias "wxGridTableBase_CanHaveAttributes" (self As wxGridTableBase Ptr) As wxBool
Declare Function wxGridTableBase_GetAttr WXCALL Alias "wxGridTableBase_GetAttr" (self As wxGridTableBase Ptr, row As wxInt, col As wxInt, kind As wxAttrKind) As wxGridCellAttr Ptr
Declare Sub wxGridTableBase_SetAttr WXCALL Alias "wxGridTableBase_SetAttr" (self As wxGridTableBase Ptr, attr As wxGridCellAttr Ptr, row As wxInt, col As wxInt)
Declare Sub wxGridTableBase_SetRowAttr WXCALL Alias "wxGridTableBase_SetRowAttr" (self As wxGridTableBase Ptr, attr As wxGridCellAttr Ptr, row As wxInt)
Declare Sub wxGridTableBase_SetColAttr WXCALL Alias "wxGridTableBase_SetColAttr" (self As wxGridTableBase Ptr, attr As wxGridCellAttr Ptr, col As wxInt)

' class wxGridCellTextEditor
Declare Function wxGridCellTextEditor_ctor WXCALL Alias "wxGridCellTextEditor_ctor" () As wxGridCellTextEditor Ptr
Declare Function GridCellTextEditor_GetWxClassInfo WXCALL Alias "GridCellTextEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Sub wxGridCellTextEditor_dtor WXCALL Alias "wxGridCellTextEditor_dtor" (self As wxGridCellTextEditor Ptr)
Declare Sub wxGridCellTextEditor_Create WXCALL Alias "wxGridCellTextEditor_Create" (self As wxGridCellTextEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evh As wxEventHandler Ptr)
Declare Sub wxGridCellTextEditor_SetSize WXCALL Alias "wxGridCellTextEditor_SetSize" (self As wxGridCellTextEditor Ptr, r As wxRect Ptr)
Declare Sub wxGridCellTextEditor_PaintBackground WXCALL Alias "wxGridCellTextEditor_PaintBackground" (self As wxGridCellTextEditor Ptr, r As wxRect Ptr, attr As wxGridCellAttr Ptr)
Declare Function wxGridCellTextEditor_IsAcceptedKey WXCALL Alias "wxGridCellTextEditor_IsAcceptedKey" (self As wxGridCellTextEditor Ptr, evnt As wxKeyEvent Ptr) As wxBool
Declare Sub wxGridCellTextEditor_BeginEdit WXCALL Alias "wxGridCellTextEditor_BeginEdit" (self As wxGridCellTextEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr)
Declare Function wxGridCellTextEditor_EndEdit WXCALL Alias "wxGridCellTextEditor_EndEdit" (self As wxGridCellTextEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr) As wxBool
Declare Sub wxGridCellTextEditor_Reset WXCALL Alias "wxGridCellTextEditor_Reset" (self As wxGridCellTextEditor Ptr)
Declare Sub wxGridCellTextEditor_StartingKey WXCALL Alias "wxGridCellTextEditor_StartingKey" (self As wxGridCellTextEditor Ptr, evnt As wxKeyEvent Ptr)
Declare Sub wxGridCellTextEditor_SetParameters WXCALL Alias "wxGridCellTextEditor_SetParameters" (self As wxGridCellTextEditor Ptr, param As wxString Ptr)
Declare Function wxGridCellTextEditor_Clone WXCALL Alias "wxGridCellTextEditor_Clone" (self As wxGridCellTextEditor Ptr) As wxGridCellEditor Ptr

' class wxGridCellAttrProvider
Declare Function wxGridCellAttrProvider_ctor WXCALL Alias "wxGridCellAttrProvider_ctor" () As wxGridCellAttrProvider Ptr
Declare Sub wxGridCellAttrProvider_dtor WXCALL Alias "wxGridCellAttrProvider_dtor" (self As wxGridCellAttrProvider Ptr)
Declare Sub wxGridCellAttrProvider_RegisterVirtual WXCALL Alias "wxGridCellAttrProvider_RegisterVirtual" (self As wxGridCellAttrProvider Ptr, on_dispose As Virtual_Dispose, fGetAttr As Virtual_GetAttr, fSetAttr As Virtual_SetAttr, fSetRowAttr As Virtual_SetRowAttr, fSetrColAttr As Virtual_SetRowAttr)
Declare Function wxGridCellAttrProvider_GetAttr WXCALL Alias "wxGridCellAttrProvider_GetAttr" (self As wxGridCellAttrProvider Ptr, row As wxInt, col As wxInt, kind As wxAttrKind) As wxGridCellAttr Ptr
Declare Sub wxGridCellAttrProvider_SetAttr WXCALL Alias "wxGridCellAttrProvider_SetAttr" (self As wxGridCellAttrProvider Ptr, attr As wxGridCellAttr Ptr, row As wxInt, col As wxInt)
Declare Sub wxGridCellAttrProvider_SetRowAttr WXCALL Alias "wxGridCellAttrProvider_SetRowAttr" (self As wxGridCellAttrProvider Ptr, attr As wxGridCellAttr Ptr, row As wxInt)
Declare Sub wxGridCellAttrProvider_SetColAttr WXCALL Alias "wxGridCellAttrProvider_SetColAttr" (self As wxGridCellAttrProvider Ptr, attr As wxGridCellAttr Ptr, col As wxInt)
Declare Sub wxGridCellAttrProvider_UpdateAttrRows WXCALL Alias "wxGridCellAttrProvider_UpdateAttrRows" (self As wxGridCellAttrProvider Ptr,position As wxInt, numRows As wxInt)
Declare Sub wxGridCellAttrProvider_UpdateAttrCols WXCALL Alias "wxGridCellAttrProvider_UpdateAttrCols" (self As wxGridCellAttrProvider Ptr,position As wxInt, numCols As wxInt)

' class wxGridCellNumberEditor
Declare Function GridCellNumberEditor_GetWxClassInfo WXCALL Alias "GridCellNumberEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxGridCellNumberEditor_ctor WXCALL Alias "wxGridCellNumberEditor_ctor" (min As wxInt, max As wxInt) As wxGridCellNumberEditor Ptr
Declare Sub wxGridCellNumberEditor_dtor WXCALL Alias "wxGridCellNumberEditor_dtor" (self As wxGridCellNumberEditor Ptr)
Declare Sub wxGridCellNumberEditor_RegisterDisposable WXCALL Alias "wxGridCellNumberEditor_RegisterDisposable" (self As wxGridCellNumberEditor Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxGridCellNumberEditor_Create WXCALL Alias "wxGridCellNumberEditor_Create" (self As wxGridCellNumberEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evh As wxEventHandler Ptr)
Declare Function wxGridCellNumberEditor_IsAcceptedKey WXCALL Alias "wxGridCellNumberEditor_IsAcceptedKey" (self As wxGridCellNumberEditor Ptr, evnt As wxKeyEvent Ptr) As wxBool
Declare Sub wxGridCellNumberEditor_BeginEdit WXCALL Alias "wxGridCellNumberEditor_BeginEdit" (self As wxGridCellNumberEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr)
Declare Function wxGridCellNumberEditor_EndEdit WXCALL Alias "wxGridCellNumberEditor_EndEdit" (self As wxGridCellNumberEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr) As wxBool
Declare Sub wxGridCellNumberEditor_Reset WXCALL Alias "wxGridCellNumberEditor_Reset" (self As wxGridCellNumberEditor Ptr)
Declare Sub wxGridCellNumberEditor_StartingKey WXCALL Alias "wxGridCellNumberEditor_StartingKey" (self As wxGridCellNumberEditor Ptr, evnt As wxKeyEvent Ptr)
Declare Sub wxGridCellNumberEditor_SetParameters WXCALL Alias "wxGridCellNumberEditor_SetParameters" (self As wxGridCellNumberEditor Ptr, param As wxString Ptr)
Declare Function wxGridCellNumberEditor_Clone WXCALL Alias "wxGridCellNumberEditor_Clone" (self As wxGridCellNumberEditor Ptr) As wxGridCellEditor Ptr

' wxGridCellFloatEditor
Declare Function GridCellFloatEditor_GetWxClassInfo WXCALL Alias "GridCellFloatEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxGridCellFloatEditor_ctor WXCALL Alias "wxGridCellFloatEditor_ctor" (w As wxInt, precision As wxInt) As wxGridCellFloatEditor Ptr
Declare Sub wxGridCellFloatEditor_dtor WXCALL Alias "wxGridCellFloatEditor_dtor" (self As wxGridCellFloatEditor Ptr)
Declare Sub wxGridCellFloatEditor_Create WXCALL Alias "wxGridCellFloatEditor_Create" (self As wxGridCellFloatEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evh As wxEventHandler Ptr)
Declare Function wxGridCellFloatEditor_IsAcceptedKey WXCALL Alias "wxGridCellFloatEditor_IsAcceptedKey" (self As wxGridCellFloatEditor Ptr, evnt As wxKeyEvent Ptr) As wxBool
Declare Sub wxGridCellFloatEditor_BeginEdit WXCALL Alias "wxGridCellFloatEditor_BeginEdit" (self As wxGridCellFloatEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr)
Declare Function wxGridCellFloatEditor_EndEdit WXCALL Alias "wxGridCellFloatEditor_EndEdit" (self As wxGridCellFloatEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr) As wxBool
Declare Sub wxGridCellFloatEditor_Reset WXCALL Alias "wxGridCellFloatEditor_Reset" (self As wxGridCellFloatEditor Ptr)
Declare Sub wxGridCellFloatEditor_StartingKey WXCALL Alias "wxGridCellFloatEditor_StartingKey" (self As wxGridCellFloatEditor Ptr, evnt As wxKeyEvent Ptr)
Declare Sub wxGridCellFloatEditor_SetParameters WXCALL Alias "wxGridCellFloatEditor_SetParameters" (self As wxGridCellFloatEditor Ptr, param As wxString Ptr)
Declare Function wxGridCellFloatEditor_Clone WXCALL Alias "wxGridCellFloatEditor_Clone" (self As wxGridCellFloatEditor Ptr) As wxGridCellEditor Ptr

' class wxGridCellBoolEditor
Declare Function GridCellBoolEditor_GetWxClassInfo WXCALL Alias "GridCellBoolEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxGridCellBoolEditor_ctor WXCALL Alias "wxGridCellBoolEditor_ctor" () As wxGridCellBoolEditor Ptr
Declare Sub wxGridCellBoolEditor_dtor WXCALL Alias "wxGridCellBoolEditor_dtor" (self As wxGridCellBoolEditor Ptr)
Declare Sub wxGridCellBoolEditor_UseStringValues WXCALL Alias "wxGridCellBoolEditor_UseStringValues" (valueTrue As wxString Ptr, valueFalse As wxString Ptr)
Declare Function wxGridCellBoolEditor_IsTrueValue WXCALL Alias "wxGridCellBoolEditor_IsTrueValue" (value As wxString Ptr) As wxBool
Declare Sub wxGridCellBoolEditor_RegisterDisposable WXCALL Alias "wxGridCellBoolEditor_RegisterDisposable" (self As wxGridCellBoolEditor Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxGridCellBoolEditor_Create WXCALL Alias "wxGridCellBoolEditor_Create" (self As wxGridCellBoolEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evh As wxEventHandler Ptr)
Declare Sub wxGridCellBoolEditor_SetSize WXCALL Alias "wxGridCellBoolEditor_SetSize" (self As wxGridCellBoolEditor Ptr, r As wxRect Ptr)
Declare Function wxGridCellBoolEditor_IsAcceptedKey WXCALL Alias "wxGridCellBoolEditor_IsAcceptedKey" (self As wxGridCellBoolEditor Ptr, evnt As wxKeyEvent Ptr) As wxBool
Declare Sub wxGridCellBoolEditor_BeginEdit WXCALL Alias "wxGridCellBoolEditor_BeginEdit" (self As wxGridCellBoolEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr)
Declare Function wxGridCellBoolEditor_EndEdit WXCALL Alias "wxGridCellBoolEditor_EndEdit" (self As wxGridCellBoolEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr) As wxBool
Declare Sub wxGridCellBoolEditor_Reset WXCALL Alias "wxGridCellBoolEditor_Reset" (self As wxGridCellBoolEditor Ptr)
Declare Sub wxGridCellBoolEditor_StartingClick WXCALL Alias "wxGridCellBoolEditor_StartingClick" (self As wxGridCellFloatEditor Ptr)
Declare Function wxGridCellBoolEditor_Clone WXCALL Alias "wxGridCellBoolEditor_Clone" (self As wxGridCellBoolEditor Ptr) As wxGridCellEditor Ptr

' class wxGridCellChoiceEditor
Declare Function GridCellChoiceEditor_GetWxClassInfo WXCALL Alias "GridCellChoiceEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxGridCellChoiceEditor_ctor WXCALL Alias "wxGridCellChoiceEditor_ctor" (choices As wxArrayString Ptr, allowothers As wxBool) As wxGridCellChoiceEditor Ptr
Declare Sub wxGridCellChoiceEditor_dtor WXCALL Alias "wxGridCellChoiceEditor_dtor" (self As wxGridCellChoiceEditor Ptr)
Declare Sub wxGridCellChoiceEditor_RegisterDisposable WXCALL Alias "wxGridCellChoiceEditor_RegisterDisposable" (self As wxGridCellChoiceEditor Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxGridCellChoiceEditor_Create WXCALL Alias "wxGridCellChoiceEditor_Create" (self As wxGridCellChoiceEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evh As wxEventHandler Ptr)
Declare Sub wxGridCellChoiceEditor_PaintBackground WXCALL Alias "wxGridCellChoiceEditor_PaintBackground" (self As wxGridCellChoiceEditor Ptr, r As wxRect Ptr, attr As wxGridCellAttr Ptr)
Declare Sub wxGridCellChoiceEditor_BeginEdit WXCALL Alias "wxGridCellChoiceEditor_BeginEdit" (self As wxGridCellChoiceEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr)
Declare Function wxGridCellChoiceEditor_EndEdit WXCALL Alias "wxGridCellChoiceEditor_EndEdit" (self As wxGridCellChoiceEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr) As wxBool
Declare Sub wxGridCellChoiceEditor_Reset WXCALL Alias "wxGridCellChoiceEditor_Reset" (self As wxGridCellChoiceEditor Ptr)
Declare Sub wxGridCellChoiceEditor_SetParameters WXCALL Alias "wxGridCellChoiceEditor_SetParameters" (self As wxGridCellChoiceEditor Ptr, param As wxString Ptr)
Declare Function wxGridCellChoiceEditor_Clone WXCALL Alias "wxGridCellChoiceEditor_Clone" (self As wxGridCellChoiceEditor Ptr) As wxGridCellEditor Ptr

' class wxGridCellStringRenderer
Declare Function wxGridCellStringRenderer_ctor WXCALL Alias "wxGridCellStringRenderer_ctor" () As wxGridCellStringRenderer Ptr
Declare Sub wxGridCellStringRenderer_dtor WXCALL Alias "wxGridCellStringRenderer_dtor" (self As wxGridCellStringRenderer Ptr)
Declare Sub wxGridCellStringRenderer_RegisterVirtual WXCALL Alias "wxGridCellStringRenderer_RegisterVirtual" (self As wxGridCellStringRenderer Ptr, on_dispose As Virtual_Dispose, fDraw As Virtual_Draw, fGetBestSize As Virtual_GetBestSize, fClone As Virtual_RendererClone)
Declare Sub wxGridCellStringRenderer_Draw WXCALL Alias "wxGridCellStringRenderer_Draw" (self As wxGridCellStringRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, isSelected As wxBool)
Declare Sub wxGridCellStringRenderer_GetBestSize WXCALL Alias "wxGridCellStringRenderer_GetBestSize" (self As wxGridCellStringRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellStringRenderer_Clone WXCALL Alias "wxGridCellStringRenderer_Clone" (self As wxGridCellStringRenderer Ptr) As wxGridCellRenderer Ptr

' class wxGridCellNumberRenderer
Declare Function wxGridCellNumberRenderer_ctor WXCALL Alias "wxGridCellNumberRenderer_ctor" () As wxGridCellNumberRenderer Ptr
Declare Sub wxGridCellNumberRenderer_dtor WXCALL Alias "wxGridCellNumberRenderer_dtor" (self As wxGridCellNumberRenderer Ptr)
Declare Sub wxGridCellNumberRenderer_RegisterVirtual WXCALL Alias "wxGridCellNumberRenderer_RegisterVirtual" (self As wxGridCellNumberRenderer Ptr, _
                                              on_dispose   As Virtual_Dispose, _
                                              fDraw        As Virtual_Draw, _
                                              fGetBestSize As Virtual_GetBestSize, _
                                              fClone       As Virtual_RendererClone)
Declare Sub wxGridCellNumberRenderer_Draw WXCALL Alias "wxGridCellNumberRenderer_Draw" (self As wxGridCellNumberRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, IsSelected As wxBool)
Declare Sub wxGridCellNumberRenderer_GetBestSize WXCALL Alias "wxGridCellNumberRenderer_GetBestSize" (self As wxGridCellNumberRenderer Ptr, grid As wxGrid Ptr, attrr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellNumberRenderer_Clone WXCALL Alias "wxGridCellNumberRenderer_Clone" (self As wxGridCellNumberRenderer Ptr) As wxGridCellRenderer Ptr

' class wxGridCellFloatRenderer
Declare Function wxGridCellFloatRenderer_ctor WXCALL Alias "wxGridCellFloatRenderer_ctor" (w As wxInt, precision As wxInt) As wxGridCellFloatRenderer Ptr
Declare Sub wxGridCellFloatRenderer_dtor WXCALL Alias "wxGridCellFloatRenderer_dtor" (self As wxGridCellFloatRenderer Ptr)
Declare Sub wxGridCellFloatRenderer_RegisterVirtual WXCALL Alias "wxGridCellFloatRenderer_RegisterVirtual" (self As wxGridCellFloatRenderer Ptr,  _
                                             on_dispose As Virtual_Dispose, _
                                             fDraw As Virtual_Draw, _
                                             fGetBestSize As Virtual_GetBestSize, _
                                             fClone As Virtual_RendererClone)
Declare Sub wxGridCellFloatRenderer_Draw WXCALL Alias "wxGridCellFloatRenderer_Draw" (self As wxGridCellFloatRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, IsSelected As wxBool)
Declare Sub wxGridCellFloatRenderer_GetBestSize WXCALL Alias "wxGridCellFloatRenderer_GetBestSize" (self As wxGridCellFloatRenderer Ptr, grid As wxGrid Ptr, attrr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellFloatRenderer_Clone WXCALL Alias "wxGridCellFloatRenderer_Clone" (self As wxGridCellFloatRenderer Ptr) As wxGridCellRenderer Ptr
Declare Function wxGridCellFloatRenderer_GetWidth WXCALL Alias "wxGridCellFloatRenderer_GetWidth" (self As wxGridCellFloatRenderer Ptr) As wxInt
Declare Sub wxGridCellFloatRenderer_SetWidth WXCALL Alias "wxGridCellFloatRenderer_SetWidth" (self As wxGridCellFloatRenderer Ptr, w As wxInt)
Declare Function wxGridCellFloatRenderer_GetPrecision WXCALL Alias "wxGridCellFloatRenderer_GetPrecision" (self As wxGridCellFloatRenderer Ptr) As wxInt
Declare Sub wxGridCellFloatRenderer_SetPrecision WXCALL Alias "wxGridCellFloatRenderer_SetPrecision" (self As wxGridCellFloatRenderer Ptr, precision As wxInt)
Declare Sub wxGridCellFloatRenderer_SetParameters WXCALL Alias "wxGridCellFloatRenderer_SetParameters" (self As wxGridCellFloatRenderer Ptr, param As wxString Ptr)

' class wxGridCellBoolRenderer
Declare Function wxGridCellBoolRenderer_ctor WXCALL Alias "wxGridCellBoolRenderer_ctor" () As wxGridCellBoolRenderer Ptr
Declare Sub wxGridCellBoolRenderer_dtor WXCALL Alias "wxGridCellBoolRenderer_dtor" (self As wxGridCellBoolRenderer Ptr)
Declare Sub wxGridCellBoolRenderer_RegisterDisposable WXCALL Alias "wxGridCellBoolRenderer_RegisterDisposable" (self As wxGridCellBoolRenderer Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxGridCellBoolRenderer_Draw WXCALL Alias "wxGridCellBoolRenderer_Draw" (self As wxGridCellBoolRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, IsSelected As wxBool)
Declare Sub wxGridCellBoolRenderer_GetBestSize WXCALL Alias "wxGridCellBoolRenderer_GetBestSize" (self As wxGridCellBoolRenderer Ptr, grid As wxGrid Ptr, attrr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellBoolRenderer_Clone WXCALL Alias "wxGridCellBoolRenderer_Clone" (self As wxGridCellBoolRenderer Ptr) As wxGridCellRenderer Ptr

' class wxGridCellRenderer
Declare Function wxGridCellRenderer_ctor WXCALL Alias "wxGridCellRenderer_ctor" () As wxGridCellRenderer Ptr
Declare Sub wxGridCellRenderer_dtor WXCALL Alias "wxGridCellRenderer_dtor" (self As wxGridCellRenderer Ptr)
Declare Sub wxGridCellRenderer_RegisterVirtual WXCALL Alias "wxGridCellRenderer_RegisterVirtual" (self As wxGridCellRenderer Ptr, _
                                        on_dispos As Virtual_Dispose, _
                                        fDraw As Virtual_Draw, _
                                        fGetBestSize As Virtual_GetBestSize, _
                                        fClone As Virtual_RendererClone)
Declare Function GridCellEnumEditor_GetWxClassInfo WXCALL Alias "GridCellEnumEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellAutoWrapStringEditor_GetWxClassInfo WXCALL Alias "GridCellAutoWrapStringEditor_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxGridCellEditor_GetClassInfoOnInstance WXCALL Alias "wxGridCellEditor_GetClassInfoOnInstance" (obj As wxGridCellEditor Ptr) As wxClassInfo Ptr
Declare Function GridCellRenderer_GetWxClassInfo WXCALL Alias "GridCellRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellStringRenderer_GetWxClassInfo WXCALL Alias "GridCellStringRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellNumberRenderer_GetWxClassInfo WXCALL Alias "GridCellNumberRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellFloatRenderer_GetWxClassInfo WXCALL Alias "GridCellFloatRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellBoolRenderer_GetWxClassInfo WXCALL Alias "GridCellBoolRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellEnumRenderer_GetWxClassInfo WXCALL Alias "GridCellEnumRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellDateTimeRenderer_GetWxClassInfo WXCALL Alias "GridCellDateTimeRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function GridCellAutoWrapStringRenderer_GetWxClassInfo WXCALL Alias "GridCellAutoWrapStringRenderer_GetWxClassInfo" () As wxClassInfo Ptr
Declare Function wxGridCellRenderer_GetClassInfoOnInstance WXCALL Alias "wxGridCellRenderer_GetClassInfoOnInstance" (obj As wxGridCellRenderer Ptr) As wxClassInfo Ptr

#EndIf ' __grid_bi__

