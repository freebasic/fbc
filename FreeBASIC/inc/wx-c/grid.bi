''
''
'' grid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __grid_bi__
#define __grid_bi__

#include once "wx-c/wx.bi"

declare function wxGridEvent cdecl alias "wxGridEvent_ctor" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval row as integer, byval col as integer, byval x as integer, byval y as integer, byval sel as integer, byval control as integer, byval shift as integer, byval alt as integer, byval meta as integer) as wxGridEvent ptr
declare function wxGridEvent_GetRow cdecl alias "wxGridEvent_GetRow" (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_GetCol cdecl alias "wxGridEvent_GetCol" (byval self as wxGridEvent ptr) as integer
declare sub wxGridEvent_GetPosition cdecl alias "wxGridEvent_GetPosition" (byval self as wxGridEvent ptr, byval pt as wxPoint ptr)
declare function wxGridEvent_Selecting cdecl alias "wxGridEvent_Selecting" (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_ControlDown cdecl alias "wxGridEvent_ControlDown" (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_MetaDown cdecl alias "wxGridEvent_MetaDown" (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_ShiftDown cdecl alias "wxGridEvent_ShiftDown" (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_AltDown cdecl alias "wxGridEvent_AltDown" (byval self as wxGridEvent ptr) as integer
declare sub wxGridEvent_Veto cdecl alias "wxGridEvent_Veto" (byval self as wxGridEvent ptr)
declare sub wxGridEvent_Allow cdecl alias "wxGridEvent_Allow" (byval self as wxGridEvent ptr)
declare function wxGridEvent_IsAllowed cdecl alias "wxGridEvent_IsAllowed" (byval self as wxGridEvent ptr) as integer
declare function wxGridRangeSelectEvent cdecl alias "wxGridRangeSelectEvent_ctor" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval topLeft as wxGridCellCoords ptr, byval bottomRight as wxGridCellCoords ptr, byval sel as integer, byval control as integer, byval shift as integer, byval alt as integer, byval meta as integer) as wxGridRangeSelectEvent ptr
declare function wxGridRangeSelectEvent_GetTopLeftCoords cdecl alias "wxGridRangeSelectEvent_GetTopLeftCoords" (byval self as wxGridRangeSelectEvent ptr) as wxGridCellCoords ptr
declare function wxGridRangeSelectEvent_GetBottomRightCoords cdecl alias "wxGridRangeSelectEvent_GetBottomRightCoords" (byval self as wxGridRangeSelectEvent ptr) as wxGridCellCoords ptr
declare function wxGridRangeSelectEvent_GetTopRow cdecl alias "wxGridRangeSelectEvent_GetTopRow" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_GetBottomRow cdecl alias "wxGridRangeSelectEvent_GetBottomRow" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_GetLeftCol cdecl alias "wxGridRangeSelectEvent_GetLeftCol" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_GetRightCol cdecl alias "wxGridRangeSelectEvent_GetRightCol" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_Selecting cdecl alias "wxGridRangeSelectEvent_Selecting" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_ControlDown cdecl alias "wxGridRangeSelectEvent_ControlDown" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_MetaDown cdecl alias "wxGridRangeSelectEvent_MetaDown" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_ShiftDown cdecl alias "wxGridRangeSelectEvent_ShiftDown" (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_AltDown cdecl alias "wxGridRangeSelectEvent_AltDown" (byval self as wxGridRangeSelectEvent ptr) as integer
declare sub wxGridRangeSelectEvent_Veto cdecl alias "wxGridRangeSelectEvent_Veto" (byval self as wxGridRangeSelectEvent ptr)
declare sub wxGridRangeSelectEvent_Allow cdecl alias "wxGridRangeSelectEvent_Allow" (byval self as wxGridRangeSelectEvent ptr)
declare function wxGridRangeSelectEvent_IsAllowed cdecl alias "wxGridRangeSelectEvent_IsAllowed" (byval self as wxGridRangeSelectEvent ptr) as integer

type Virtual_SetParameters as sub (byval as wxString ptr)

declare function wxGridCellWorker cdecl alias "wxGridCellWorker_ctor" () as wxGridCellWorker ptr
declare sub wxGridCellWorker_RegisterVirtual cdecl alias "wxGridCellWorker_RegisterVirtual" (byval self as _GridCellWorker ptr, byval setParameters as Virtual_SetParameters)
declare sub wxGridCellWorker_IncRef cdecl alias "wxGridCellWorker_IncRef" (byval self as _GridCellWorker ptr)
declare sub wxGridCellWorker_DecRef cdecl alias "wxGridCellWorker_DecRef" (byval self as _GridCellWorker ptr)
declare sub wxGridCellWorker_SetParameters cdecl alias "wxGridCellWorker_SetParameters" (byval self as _GridCellWorker ptr, byval params as string)
declare function wxGridEditorCreatedEvent cdecl alias "wxGridEditorCreatedEvent_ctor" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval row as integer, byval col as integer, byval ctrl as wxControl ptr) as wxGridEditorCreatedEvent ptr
declare function wxGridEditorCreatedEvent_GetRow cdecl alias "wxGridEditorCreatedEvent_GetRow" (byval self as wxGridEditorCreatedEvent ptr) as integer
declare function wxGridEditorCreatedEvent_GetCol cdecl alias "wxGridEditorCreatedEvent_GetCol" (byval self as wxGridEditorCreatedEvent ptr) as integer
declare function wxGridEditorCreatedEvent_GetControl cdecl alias "wxGridEditorCreatedEvent_GetControl" (byval self as wxGridEditorCreatedEvent ptr) as wxControl ptr
declare sub wxGridEditorCreatedEvent_SetRow cdecl alias "wxGridEditorCreatedEvent_SetRow" (byval self as wxGridEditorCreatedEvent ptr, byval row as integer)
declare sub wxGridEditorCreatedEvent_SetCol cdecl alias "wxGridEditorCreatedEvent_SetCol" (byval self as wxGridEditorCreatedEvent ptr, byval col as integer)
declare sub wxGridEditorCreatedEvent_SetControl cdecl alias "wxGridEditorCreatedEvent_SetControl" (byval self as wxGridEditorCreatedEvent ptr, byval ctrl as wxControl ptr)

declare function wxGrid cdecl alias "wxGrid_ctor" () as wxGrid ptr
declare function wxGrid_ctorFull cdecl alias "wxGrid_ctorFull" (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as string) as wxGrid ptr
declare sub wxGrid_dtor cdecl alias "wxGrid_dtor" (byval self as wxGrid ptr)
declare function wxGrid_CreateGrid cdecl alias "wxGrid_CreateGrid" (byval self as wxGrid ptr, byval numRows as integer, byval numCols as integer, byval selmode as integer) as integer
declare sub wxGrid_SetSelectionMode cdecl alias "wxGrid_SetSelectionMode" (byval self as wxGrid ptr, byval selmode as integer)
declare function wxGrid_GetSelectionMode cdecl alias "wxGrid_GetSelectionMode" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetNumberRows cdecl alias "wxGrid_GetNumberRows" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetNumberCols cdecl alias "wxGrid_GetNumberCols" (byval self as wxGrid ptr) as integer
declare sub wxGrid_ProcessRowLabelMouseEvent cdecl alias "wxGrid_ProcessRowLabelMouseEvent" (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare sub wxGrid_ProcessColLabelMouseEvent cdecl alias "wxGrid_ProcessColLabelMouseEvent" (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare sub wxGrid_ProcessCornerLabelMouseEvent cdecl alias "wxGrid_ProcessCornerLabelMouseEvent" (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare sub wxGrid_ProcessGridCellMouseEvent cdecl alias "wxGrid_ProcessGridCellMouseEvent" (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare function wxGrid_GetTable cdecl alias "wxGrid_GetTable" (byval self as wxGrid ptr) as wxGridTableBase ptr
declare function wxGrid_SetTable cdecl alias "wxGrid_SetTable" (byval self as wxGrid ptr, byval table as wxGridTableBase ptr, byval takeOwnership as integer, byval selmode as integer) as integer
declare sub wxGrid_ClearGrid cdecl alias "wxGrid_ClearGrid" (byval self as wxGrid ptr)
declare function wxGrid_InsertRows cdecl alias "wxGrid_InsertRows" (byval self as wxGrid ptr, byval pos as integer, byval numRows as integer, byval updateLabels as integer) as integer
declare function wxGrid_AppendRows cdecl alias "wxGrid_AppendRows" (byval self as wxGrid ptr, byval numRows as integer, byval updateLabels as integer) as integer
declare function wxGrid_DeleteRows cdecl alias "wxGrid_DeleteRows" (byval self as wxGrid ptr, byval pos as integer, byval numRows as integer, byval updateLabels as integer) as integer
declare function wxGrid_InsertCols cdecl alias "wxGrid_InsertCols" (byval self as wxGrid ptr, byval pos as integer, byval numCols as integer, byval updateLabels as integer) as integer
declare function wxGrid_AppendCols cdecl alias "wxGrid_AppendCols" (byval self as wxGrid ptr, byval numCols as integer, byval updateLabels as integer) as integer
declare function wxGrid_DeleteCols cdecl alias "wxGrid_DeleteCols" (byval self as wxGrid ptr, byval pos as integer, byval numCols as integer, byval updateLabels as integer) as integer
declare sub wxGrid_DrawGridCellArea cdecl alias "wxGrid_DrawGridCellArea" (byval self as wxGrid ptr, byval dc as wxDC ptr, byval cells as wxGridCellCoordsArray ptr)
declare sub wxGrid_DrawGridSpace cdecl alias "wxGrid_DrawGridSpace" (byval self as wxGrid ptr, byval dc as wxDC ptr)
declare sub wxGrid_BeginBatch cdecl alias "wxGrid_BeginBatch" (byval self as wxGrid ptr)
declare sub wxGrid_EndBatch cdecl alias "wxGrid_EndBatch" (byval self as wxGrid ptr)
declare function wxGrid_GetBatchCount cdecl alias "wxGrid_GetBatchCount" (byval self as wxGrid ptr) as integer
declare sub wxGrid_ForceRefresh cdecl alias "wxGrid_ForceRefresh" (byval self as wxGrid ptr)
declare function wxGrid_IsEditable cdecl alias "wxGrid_IsEditable" (byval self as wxGrid ptr) as integer
declare sub wxGrid_EnableEditing cdecl alias "wxGrid_EnableEditing" (byval self as wxGrid ptr, byval edit as integer)
declare sub wxGrid_EnableCellEditControl cdecl alias "wxGrid_EnableCellEditControl" (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableCellEditControl cdecl alias "wxGrid_DisableCellEditControl" (byval self as wxGrid ptr)
declare function wxGrid_CanEnableCellControl cdecl alias "wxGrid_CanEnableCellControl" (byval self as wxGrid ptr) as integer
declare function wxGrid_IsCellEditControlEnabled cdecl alias "wxGrid_IsCellEditControlEnabled" (byval self as wxGrid ptr) as integer
declare function wxGrid_IsCellEditControlShown cdecl alias "wxGrid_IsCellEditControlShown" (byval self as wxGrid ptr) as integer
declare function wxGrid_IsCurrentCellReadOnly cdecl alias "wxGrid_IsCurrentCellReadOnly" (byval self as wxGrid ptr) as integer
declare sub wxGrid_ShowCellEditControl cdecl alias "wxGrid_ShowCellEditControl" (byval self as wxGrid ptr)
declare sub wxGrid_HideCellEditControl cdecl alias "wxGrid_HideCellEditControl" (byval self as wxGrid ptr)
declare sub wxGrid_SaveEditControlValue cdecl alias "wxGrid_SaveEditControlValue" (byval self as wxGrid ptr)
declare function wxGrid_YToRow cdecl alias "wxGrid_YToRow" (byval self as wxGrid ptr, byval y as integer) as integer
declare function wxGrid_XToCol cdecl alias "wxGrid_XToCol" (byval self as wxGrid ptr, byval x as integer) as integer
declare function wxGrid_YToEdgeOfRow cdecl alias "wxGrid_YToEdgeOfRow" (byval self as wxGrid ptr, byval y as integer) as integer
declare function wxGrid_XToEdgeOfCol cdecl alias "wxGrid_XToEdgeOfCol" (byval self as wxGrid ptr, byval x as integer) as integer
declare sub wxGrid_CellToRect cdecl alias "wxGrid_CellToRect" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval rc as wxRect ptr)
declare function wxGrid_GetGridCursorRow cdecl alias "wxGrid_GetGridCursorRow" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetGridCursorCol cdecl alias "wxGrid_GetGridCursorCol" (byval self as wxGrid ptr) as integer
declare function wxGrid_IsVisible cdecl alias "wxGrid_IsVisible" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval wholeCellVisible as integer) as integer
declare sub wxGrid_MakeCellVisible cdecl alias "wxGrid_MakeCellVisible" (byval self as wxGrid ptr, byval row as integer, byval col as integer)
declare sub wxGrid_SetGridCursor cdecl alias "wxGrid_SetGridCursor" (byval self as wxGrid ptr, byval row as integer, byval col as integer)
declare function wxGrid_MoveCursorUp cdecl alias "wxGrid_MoveCursorUp" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorDown cdecl alias "wxGrid_MoveCursorDown" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorLeft cdecl alias "wxGrid_MoveCursorLeft" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorRight cdecl alias "wxGrid_MoveCursorRight" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MovePageDown cdecl alias "wxGrid_MovePageDown" (byval self as wxGrid ptr) as integer
declare function wxGrid_MovePageUp cdecl alias "wxGrid_MovePageUp" (byval self as wxGrid ptr) as integer
declare function wxGrid_MoveCursorUpBlock cdecl alias "wxGrid_MoveCursorUpBlock" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorDownBlock cdecl alias "wxGrid_MoveCursorDownBlock" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorLeftBlock cdecl alias "wxGrid_MoveCursorLeftBlock" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorRightBlock cdecl alias "wxGrid_MoveCursorRightBlock" (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_GetDefaultRowLabelSize cdecl alias "wxGrid_GetDefaultRowLabelSize" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetRowLabelSize cdecl alias "wxGrid_GetRowLabelSize" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetDefaultColLabelSize cdecl alias "wxGrid_GetDefaultColLabelSize" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetColLabelSize cdecl alias "wxGrid_GetColLabelSize" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetLabelBackgroundColour cdecl alias "wxGrid_GetLabelBackgroundColour" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetLabelTextColour cdecl alias "wxGrid_GetLabelTextColour" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetLabelFont cdecl alias "wxGrid_GetLabelFont" (byval self as wxGrid ptr) as wxFont ptr
declare sub wxGrid_GetRowLabelAlignment cdecl alias "wxGrid_GetRowLabelAlignment" (byval self as wxGrid ptr, byval horiz as integer ptr, byval vert as integer ptr)
declare sub wxGrid_GetColLabelAlignment cdecl alias "wxGrid_GetColLabelAlignment" (byval self as wxGrid ptr, byval horiz as integer ptr, byval vert as integer ptr)
declare function wxGrid_GetRowLabelValue cdecl alias "wxGrid_GetRowLabelValue" (byval self as wxGrid ptr, byval row as integer) as wxString ptr
declare function wxGrid_GetColLabelValue cdecl alias "wxGrid_GetColLabelValue" (byval self as wxGrid ptr, byval col as integer) as wxString ptr
declare function wxGrid_GetGridLineColour cdecl alias "wxGrid_GetGridLineColour" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellHighlightColour cdecl alias "wxGrid_GetCellHighlightColour" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellHighlightPenWidth cdecl alias "wxGrid_GetCellHighlightPenWidth" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCellHighlightROPenWidth cdecl alias "wxGrid_GetCellHighlightROPenWidth" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetRowLabelSize cdecl alias "wxGrid_SetRowLabelSize" (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_SetColLabelSize cdecl alias "wxGrid_SetColLabelSize" (byval self as wxGrid ptr, byval height as integer)
declare sub wxGrid_SetLabelBackgroundColour cdecl alias "wxGrid_SetLabelBackgroundColour" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetLabelTextColour cdecl alias "wxGrid_SetLabelTextColour" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetLabelFont cdecl alias "wxGrid_SetLabelFont" (byval self as wxGrid ptr, byval font as wxFont ptr)
declare sub wxGrid_SetRowLabelAlignment cdecl alias "wxGrid_SetRowLabelAlignment" (byval self as wxGrid ptr, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetColLabelAlignment cdecl alias "wxGrid_SetColLabelAlignment" (byval self as wxGrid ptr, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetRowLabelValue cdecl alias "wxGrid_SetRowLabelValue" (byval self as wxGrid ptr, byval row as integer, byval val as string)
declare sub wxGrid_SetColLabelValue cdecl alias "wxGrid_SetColLabelValue" (byval self as wxGrid ptr, byval col as integer, byval val as string)
declare sub wxGrid_SetGridLineColour cdecl alias "wxGrid_SetGridLineColour" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellHighlightColour cdecl alias "wxGrid_SetCellHighlightColour" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellHighlightPenWidth cdecl alias "wxGrid_SetCellHighlightPenWidth" (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_SetCellHighlightROPenWidth cdecl alias "wxGrid_SetCellHighlightROPenWidth" (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_EnableDragRowSize cdecl alias "wxGrid_EnableDragRowSize" (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableDragRowSize cdecl alias "wxGrid_DisableDragRowSize" (byval self as wxGrid ptr)
declare function wxGrid_CanDragRowSize cdecl alias "wxGrid_CanDragRowSize" (byval self as wxGrid ptr) as integer
declare sub wxGrid_EnableDragColSize cdecl alias "wxGrid_EnableDragColSize" (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableDragColSize cdecl alias "wxGrid_DisableDragColSize" (byval self as wxGrid ptr)
declare function wxGrid_CanDragColSize cdecl alias "wxGrid_CanDragColSize" (byval self as wxGrid ptr) as integer
declare sub wxGrid_EnableDragGridSize cdecl alias "wxGrid_EnableDragGridSize" (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableDragGridSize cdecl alias "wxGrid_DisableDragGridSize" (byval self as wxGrid ptr)
declare function wxGrid_CanDragGridSize cdecl alias "wxGrid_CanDragGridSize" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetAttr cdecl alias "wxGrid_SetAttr" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGrid_SetRowAttr cdecl alias "wxGrid_SetRowAttr" (byval self as wxGrid ptr, byval row as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGrid_SetColAttr cdecl alias "wxGrid_SetColAttr" (byval self as wxGrid ptr, byval col as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGrid_SetColFormatBool cdecl alias "wxGrid_SetColFormatBool" (byval self as wxGrid ptr, byval col as integer)
declare sub wxGrid_SetColFormatNumber cdecl alias "wxGrid_SetColFormatNumber" (byval self as wxGrid ptr, byval col as integer)
declare sub wxGrid_SetColFormatFloat cdecl alias "wxGrid_SetColFormatFloat" (byval self as wxGrid ptr, byval col as integer, byval width as integer, byval precision as integer)
declare sub wxGrid_SetColFormatCustom cdecl alias "wxGrid_SetColFormatCustom" (byval self as wxGrid ptr, byval col as integer, byval typeName as string)
declare sub wxGrid_EnableGridLines cdecl alias "wxGrid_EnableGridLines" (byval self as wxGrid ptr, byval enable as integer)
declare function wxGrid_GridLinesEnabled cdecl alias "wxGrid_GridLinesEnabled" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetDefaultRowSize cdecl alias "wxGrid_GetDefaultRowSize" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetRowSize cdecl alias "wxGrid_GetRowSize" (byval self as wxGrid ptr, byval row as integer) as integer
declare function wxGrid_GetDefaultColSize cdecl alias "wxGrid_GetDefaultColSize" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetColSize cdecl alias "wxGrid_GetColSize" (byval self as wxGrid ptr, byval col as integer) as integer
declare function wxGrid_GetDefaultCellBackgroundColour cdecl alias "wxGrid_GetDefaultCellBackgroundColour" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellBackgroundColour cdecl alias "wxGrid_GetCellBackgroundColour" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxColour ptr
declare function wxGrid_GetDefaultCellTextColour cdecl alias "wxGrid_GetDefaultCellTextColour" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellTextColour cdecl alias "wxGrid_GetCellTextColour" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxColour ptr
declare function wxGrid_GetDefaultCellFont cdecl alias "wxGrid_GetDefaultCellFont" (byval self as wxGrid ptr) as wxFont ptr
declare function wxGrid_GetCellFont cdecl alias "wxGrid_GetCellFont" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxFont ptr
declare sub wxGrid_GetDefaultCellAlignment cdecl alias "wxGrid_GetDefaultCellAlignment" (byval self as wxGrid ptr, byval horiz as integer ptr, byval vert as integer ptr)
declare sub wxGrid_GetCellAlignment cdecl alias "wxGrid_GetCellAlignment" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval horiz as integer ptr, byval vert as integer ptr)
declare function wxGrid_GetDefaultCellOverflow cdecl alias "wxGrid_GetDefaultCellOverflow" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCellOverflow cdecl alias "wxGrid_GetCellOverflow" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as integer
declare sub wxGrid_GetCellSize cdecl alias "wxGrid_GetCellSize" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval num_rows as integer ptr, byval num_cols as integer ptr)
declare sub wxGrid_SetDefaultRowSize cdecl alias "wxGrid_SetDefaultRowSize" (byval self as wxGrid ptr, byval height as integer, byval resizeExistingRows as integer)
declare sub wxGrid_SetRowSize cdecl alias "wxGrid_SetRowSize" (byval self as wxGrid ptr, byval row as integer, byval height as integer)
declare sub wxGrid_SetDefaultColSize cdecl alias "wxGrid_SetDefaultColSize" (byval self as wxGrid ptr, byval width as integer, byval resizeExistingCols as integer)
declare sub wxGrid_SetColSize cdecl alias "wxGrid_SetColSize" (byval self as wxGrid ptr, byval col as integer, byval width as integer)
declare sub wxGrid_AutoSizeColumn cdecl alias "wxGrid_AutoSizeColumn" (byval self as wxGrid ptr, byval col as integer, byval setAsMin as integer)
declare sub wxGrid_AutoSizeRow cdecl alias "wxGrid_AutoSizeRow" (byval self as wxGrid ptr, byval row as integer, byval setAsMin as integer)
declare sub wxGrid_AutoSizeColumns cdecl alias "wxGrid_AutoSizeColumns" (byval self as wxGrid ptr, byval setAsMin as integer)
declare sub wxGrid_AutoSizeRows cdecl alias "wxGrid_AutoSizeRows" (byval self as wxGrid ptr, byval setAsMin as integer)
declare sub wxGrid_AutoSize cdecl alias "wxGrid_AutoSize" (byval self as wxGrid ptr)
declare sub wxGrid_SetColMinimalWidth cdecl alias "wxGrid_SetColMinimalWidth" (byval self as wxGrid ptr, byval col as integer, byval width as integer)
declare sub wxGrid_SetRowMinimalHeight cdecl alias "wxGrid_SetRowMinimalHeight" (byval self as wxGrid ptr, byval row as integer, byval width as integer)
declare sub wxGrid_SetColMinimalAcceptableWidth cdecl alias "wxGrid_SetColMinimalAcceptableWidth" (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_SetRowMinimalAcceptableHeight cdecl alias "wxGrid_SetRowMinimalAcceptableHeight" (byval self as wxGrid ptr, byval width as integer)
declare function wxGrid_GetColMinimalAcceptableWidth cdecl alias "wxGrid_GetColMinimalAcceptableWidth" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetRowMinimalAcceptableHeight cdecl alias "wxGrid_GetRowMinimalAcceptableHeight" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetDefaultCellBackgroundColour cdecl alias "wxGrid_SetDefaultCellBackgroundColour" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetDefaultCellTextColour cdecl alias "wxGrid_SetDefaultCellTextColour" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetDefaultCellFont cdecl alias "wxGrid_SetDefaultCellFont" (byval self as wxGrid ptr, byval font as wxFont ptr)
declare sub wxGrid_SetCellFont cdecl alias "wxGrid_SetCellFont" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval font as wxFont ptr)
declare sub wxGrid_SetDefaultCellAlignment cdecl alias "wxGrid_SetDefaultCellAlignment" (byval self as wxGrid ptr, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetCellAlignmentHV cdecl alias "wxGrid_SetCellAlignmentHV" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetDefaultCellOverflow cdecl alias "wxGrid_SetDefaultCellOverflow" (byval self as wxGrid ptr, byval allow as integer)
declare sub wxGrid_SetCellOverflow cdecl alias "wxGrid_SetCellOverflow" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval allow as integer)
declare sub wxGrid_SetCellSize cdecl alias "wxGrid_SetCellSize" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval num_rows as integer, byval num_cols as integer)
declare sub wxGrid_SetDefaultRenderer cdecl alias "wxGrid_SetDefaultRenderer" (byval self as wxGrid ptr, byval renderer as wxGridCellRenderer ptr)
declare sub wxGrid_SetCellRenderer cdecl alias "wxGrid_SetCellRenderer" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval renderer as wxGridCellRenderer ptr)
declare function wxGrid_GetDefaultRenderer cdecl alias "wxGrid_GetDefaultRenderer" (byval self as wxGrid ptr) as wxGridCellRenderer ptr
declare function wxGrid_GetCellRenderer cdecl alias "wxGrid_GetCellRenderer" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellRenderer ptr
declare sub wxGrid_SetDefaultEditor cdecl alias "wxGrid_SetDefaultEditor" (byval self as wxGrid ptr, byval editor as wxGridCellEditor ptr)
declare sub wxGrid_SetCellEditor cdecl alias "wxGrid_SetCellEditor" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval editor as wxGridCellEditor ptr)
declare function wxGrid_GetDefaultEditor cdecl alias "wxGrid_GetDefaultEditor" (byval self as wxGrid ptr) as wxGridCellEditor ptr
declare function wxGrid_GetCellEditor cdecl alias "wxGrid_GetCellEditor" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellEditor ptr
declare function wxGrid_GetCellValue cdecl alias "wxGrid_GetCellValue" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxString ptr
declare sub wxGrid_SetCellValue cdecl alias "wxGrid_SetCellValue" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval s as string)
declare function wxGrid_IsReadOnly cdecl alias "wxGrid_IsReadOnly" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as integer
declare sub wxGrid_SetReadOnly cdecl alias "wxGrid_SetReadOnly" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval isReadOnly as integer)
declare sub wxGrid_SelectRow cdecl alias "wxGrid_SelectRow" (byval self as wxGrid ptr, byval row as integer, byval addToSelected as integer)
declare sub wxGrid_SelectCol cdecl alias "wxGrid_SelectCol" (byval self as wxGrid ptr, byval col as integer, byval addToSelected as integer)
declare sub wxGrid_SelectBlock cdecl alias "wxGrid_SelectBlock" (byval self as wxGrid ptr, byval topRow as integer, byval leftCol as integer, byval bottomRow as integer, byval rightCol as integer, byval addToSelected as integer)
declare sub wxGrid_SelectAll cdecl alias "wxGrid_SelectAll" (byval self as wxGrid ptr)
declare function wxGrid_IsSelection cdecl alias "wxGrid_IsSelection" (byval self as wxGrid ptr) as integer
declare sub wxGrid_DeselectRow cdecl alias "wxGrid_DeselectRow" (byval self as wxGrid ptr, byval row as integer)
declare sub wxGrid_DeselectCol cdecl alias "wxGrid_DeselectCol" (byval self as wxGrid ptr, byval col as integer)
declare sub wxGrid_DeselectCell cdecl alias "wxGrid_DeselectCell" (byval self as wxGrid ptr, byval row as integer, byval col as integer)
declare sub wxGrid_ClearSelection cdecl alias "wxGrid_ClearSelection" (byval self as wxGrid ptr)
declare function wxGrid_IsInSelection cdecl alias "wxGrid_IsInSelection" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as integer
declare sub wxGrid_BlockToDeviceRect cdecl alias "wxGrid_BlockToDeviceRect" (byval self as wxGrid ptr, byval topLeft as wxGridCellCoords ptr, byval bottomRight as wxGridCellCoords ptr, byval rc as wxRect ptr)
declare function wxGrid_GetSelectionBackground cdecl alias "wxGrid_GetSelectionBackground" (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetSelectionForeground cdecl alias "wxGrid_GetSelectionForeground" (byval self as wxGrid ptr) as wxColour ptr
declare sub wxGrid_SetSelectionBackground cdecl alias "wxGrid_SetSelectionBackground" (byval self as wxGrid ptr, byval c as wxColour ptr)
declare sub wxGrid_SetSelectionForeground cdecl alias "wxGrid_SetSelectionForeground" (byval self as wxGrid ptr, byval c as wxColour ptr)
declare sub wxGrid_RegisterDataType cdecl alias "wxGrid_RegisterDataType" (byval self as wxGrid ptr, byval typeName as string, byval renderer as wxGridCellRenderer ptr, byval editor as wxGridCellEditor ptr)
declare function wxGrid_GetDefaultEditorForCell cdecl alias "wxGrid_GetDefaultEditorForCell" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellEditor ptr
declare function wxGrid_GetDefaultRendererForCell cdecl alias "wxGrid_GetDefaultRendererForCell" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellRenderer ptr
declare function wxGrid_GetDefaultEditorForType cdecl alias "wxGrid_GetDefaultEditorForType" (byval self as wxGrid ptr, byval typeName as string) as wxGridCellEditor ptr
declare function wxGrid_GetDefaultRendererForType cdecl alias "wxGrid_GetDefaultRendererForType" (byval self as wxGrid ptr, byval typeName as string) as wxGridCellRenderer ptr
declare sub wxGrid_SetMargins cdecl alias "wxGrid_SetMargins" (byval self as wxGrid ptr, byval extraWidth as integer, byval extraHeight as integer)
declare function wxGrid_GetGridWindow cdecl alias "wxGrid_GetGridWindow" (byval self as wxGrid ptr) as wxWindow ptr
declare function wxGrid_GetGridRowLabelWindow cdecl alias "wxGrid_GetGridRowLabelWindow" (byval self as wxGrid ptr) as wxWindow ptr
declare function wxGrid_GetGridColLabelWindow cdecl alias "wxGrid_GetGridColLabelWindow" (byval self as wxGrid ptr) as wxWindow ptr
declare function wxGrid_GetGridCornerLabelWindow cdecl alias "wxGrid_GetGridCornerLabelWindow" (byval self as wxGrid ptr) as wxWindow ptr
declare sub wxGrid_UpdateDimensions cdecl alias "wxGrid_UpdateDimensions" (byval self as wxGrid ptr)
declare function wxGrid_GetRows cdecl alias "wxGrid_GetRows" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCols cdecl alias "wxGrid_GetCols" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCursorRow cdecl alias "wxGrid_GetCursorRow" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCursorColumn cdecl alias "wxGrid_GetCursorColumn" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetScrollPosX cdecl alias "wxGrid_GetScrollPosX" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetScrollPosY cdecl alias "wxGrid_GetScrollPosY" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetScrollX cdecl alias "wxGrid_SetScrollX" (byval self as wxGrid ptr, byval x as integer)
declare sub wxGrid_SetScrollY cdecl alias "wxGrid_SetScrollY" (byval self as wxGrid ptr, byval y as integer)
declare sub wxGrid_SetColumnWidth cdecl alias "wxGrid_SetColumnWidth" (byval self as wxGrid ptr, byval col as integer, byval width as integer)
declare function wxGrid_GetColumnWidth cdecl alias "wxGrid_GetColumnWidth" (byval self as wxGrid ptr, byval col as integer) as integer
declare sub wxGrid_SetRowHeight cdecl alias "wxGrid_SetRowHeight" (byval self as wxGrid ptr, byval row as integer, byval height as integer)
declare function wxGrid_GetViewHeight cdecl alias "wxGrid_GetViewHeight" (byval self as wxGrid ptr) as integer
declare function wxGrid_GetViewWidth cdecl alias "wxGrid_GetViewWidth" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetLabelSize cdecl alias "wxGrid_SetLabelSize" (byval self as wxGrid ptr, byval orientation as integer, byval sz as integer)
declare function wxGrid_GetLabelSize cdecl alias "wxGrid_GetLabelSize" (byval self as wxGrid ptr, byval orientation as integer) as integer
declare sub wxGrid_SetLabelAlignment cdecl alias "wxGrid_SetLabelAlignment" (byval self as wxGrid ptr, byval orientation as integer, byval align as integer)
declare function wxGrid_GetLabelAlignment cdecl alias "wxGrid_GetLabelAlignment" (byval self as wxGrid ptr, byval orientation as integer, byval align as integer) as integer
declare sub wxGrid_SetLabelValue cdecl alias "wxGrid_SetLabelValue" (byval self as wxGrid ptr, byval orientation as integer, byval val as string, byval pos as integer)
declare function wxGrid_GetLabelValue cdecl alias "wxGrid_GetLabelValue" (byval self as wxGrid ptr, byval orientation as integer, byval pos as integer) as wxString ptr
declare function wxGrid_GetCellTextFontGrid cdecl alias "wxGrid_GetCellTextFontGrid" (byval self as wxGrid ptr) as wxFont ptr
declare function wxGrid_GetCellTextFont cdecl alias "wxGrid_GetCellTextFont" (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxFont ptr
declare sub wxGrid_SetCellTextFontGrid cdecl alias "wxGrid_SetCellTextFontGrid" (byval self as wxGrid ptr, byval fnt as wxFont ptr)
declare sub wxGrid_SetCellTextFont cdecl alias "wxGrid_SetCellTextFont" (byval self as wxGrid ptr, byval fnt as wxFont ptr, byval row as integer, byval col as integer)
declare sub wxGrid_SetCellTextColour cdecl alias "wxGrid_SetCellTextColour" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval val as wxColour ptr)
declare sub wxGrid_SetCellTextColourGrid cdecl alias "wxGrid_SetCellTextColourGrid" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellBackgroundColourGrid cdecl alias "wxGrid_SetCellBackgroundColourGrid" (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellBackgroundColour cdecl alias "wxGrid_SetCellBackgroundColour" (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval colour as wxColour ptr)
declare function wxGrid_GetEditable cdecl alias "wxGrid_GetEditable" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetEditable cdecl alias "wxGrid_SetEditable" (byval self as wxGrid ptr, byval edit as integer)
declare function wxGrid_GetEditInPlace cdecl alias "wxGrid_GetEditInPlace" (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetCellAlignment cdecl alias "wxGrid_SetCellAlignment" (byval self as wxGrid ptr, byval align as integer, byval row as integer, byval col as integer)
declare sub wxGrid_SetCellAlignmentGrid cdecl alias "wxGrid_SetCellAlignmentGrid" (byval self as wxGrid ptr, byval align as integer)
declare sub wxGrid_SetCellBitmap cdecl alias "wxGrid_SetCellBitmap" (byval self as wxGrid ptr, byval bitmap as wxBitmap ptr, byval row as integer, byval col as integer)
declare sub wxGrid_SetDividerPen cdecl alias "wxGrid_SetDividerPen" (byval self as wxGrid ptr, byval pen as wxPen ptr)
declare function wxGrid_GetDividerPen cdecl alias "wxGrid_GetDividerPen" (byval self as wxGrid ptr) as wxPen ptr
declare sub wxGrid_OnActivate cdecl alias "wxGrid_OnActivate" (byval self as wxGrid ptr, byval active as integer)
declare function wxGrid_GetRowHeight cdecl alias "wxGrid_GetRowHeight" (byval self as wxGrid ptr, byval row as integer) as integer
declare function wxGridCellCoords cdecl alias "wxGridCellCoords_ctor" () as wxGridCellCoords ptr
declare sub wxGridCellCoords_dtor cdecl alias "wxGridCellCoords_dtor" (byval self as wxGridCellCoords ptr)
declare function wxGridCellCoords_GetRow cdecl alias "wxGridCellCoords_GetRow" (byval self as wxGridCellCoords ptr) as integer
declare sub wxGridCellCoords_SetRow cdecl alias "wxGridCellCoords_SetRow" (byval self as wxGridCellCoords ptr, byval n as integer)
declare function wxGridCellCoords_GetCol cdecl alias "wxGridCellCoords_GetCol" (byval self as wxGridCellCoords ptr) as integer
declare sub wxGridCellCoords_SetCol cdecl alias "wxGridCellCoords_SetCol" (byval self as wxGridCellCoords ptr, byval n as integer)
declare sub wxGridCellCoords_Set cdecl alias "wxGridCellCoords_Set" (byval self as wxGridCellCoords ptr, byval row as integer, byval col as integer)
declare function wxGridCellAttr cdecl alias "wxGridCellAttr_ctor" (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr, byval hAlign as integer, byval vAlign as integer) as wxGridCellAttr ptr
declare function wxGridCellAttr_ctor2 cdecl alias "wxGridCellAttr_ctor2" () as wxGridCellAttr ptr
declare function wxGridCellAttr_ctor3 cdecl alias "wxGridCellAttr_ctor3" (byval attrDefault as wxGridCellAttr ptr) as wxGridCellAttr ptr
declare function wxGridCellAttr_Clone cdecl alias "wxGridCellAttr_Clone" (byval self as wxGridCellAttr ptr) as wxGridCellAttr ptr
declare sub wxGridCellAttr_MergeWith cdecl alias "wxGridCellAttr_MergeWith" (byval self as wxGridCellAttr ptr, byval mergefrom as wxGridCellAttr ptr)
declare sub wxGridCellAttr_IncRef cdecl alias "wxGridCellAttr_IncRef" (byval self as wxGridCellAttr ptr)
declare sub wxGridCellAttr_DecRef cdecl alias "wxGridCellAttr_DecRef" (byval self as wxGridCellAttr ptr)
declare sub wxGridCellAttr_SetTextColour cdecl alias "wxGridCellAttr_SetTextColour" (byval self as wxGridCellAttr ptr, byval colText as wxColour ptr)
declare sub wxGridCellAttr_SetBackgroundColour cdecl alias "wxGridCellAttr_SetBackgroundColour" (byval self as wxGridCellAttr ptr, byval colBack as wxColour ptr)
declare sub wxGridCellAttr_SetFont cdecl alias "wxGridCellAttr_SetFont" (byval self as wxGridCellAttr ptr, byval font as wxFont ptr)
declare sub wxGridCellAttr_SetAlignment cdecl alias "wxGridCellAttr_SetAlignment" (byval self as wxGridCellAttr ptr, byval hAlign as integer, byval vAlign as integer)
declare sub wxGridCellAttr_SetSize cdecl alias "wxGridCellAttr_SetSize" (byval self as wxGridCellAttr ptr, byval num_rows as integer, byval num_cols as integer)
declare sub wxGridCellAttr_SetOverflow cdecl alias "wxGridCellAttr_SetOverflow" (byval self as wxGridCellAttr ptr, byval allow as integer)
declare sub wxGridCellAttr_SetReadOnly cdecl alias "wxGridCellAttr_SetReadOnly" (byval self as wxGridCellAttr ptr, byval isReadOnly as integer)
declare sub wxGridCellAttr_SetRenderer cdecl alias "wxGridCellAttr_SetRenderer" (byval self as wxGridCellAttr ptr, byval renderer as wxGridCellRenderer ptr)
declare sub wxGridCellAttr_SetEditor cdecl alias "wxGridCellAttr_SetEditor" (byval self as wxGridCellAttr ptr, byval editor as wxGridCellEditor ptr)
declare function wxGridCellAttr_HasTextColour cdecl alias "wxGridCellAttr_HasTextColour" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasBackgroundColour cdecl alias "wxGridCellAttr_HasBackgroundColour" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasFont cdecl alias "wxGridCellAttr_HasFont" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasAlignment cdecl alias "wxGridCellAttr_HasAlignment" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasRenderer cdecl alias "wxGridCellAttr_HasRenderer" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasEditor cdecl alias "wxGridCellAttr_HasEditor" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasReadWriteMode cdecl alias "wxGridCellAttr_HasReadWriteMode" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_GetTextColour cdecl alias "wxGridCellAttr_GetTextColour" (byval self as wxGridCellAttr ptr) as wxColour ptr
declare function wxGridCellAttr_GetBackgroundColour cdecl alias "wxGridCellAttr_GetBackgroundColour" (byval self as wxGridCellAttr ptr) as wxColour ptr
declare function wxGridCellAttr_GetFont cdecl alias "wxGridCellAttr_GetFont" (byval self as wxGridCellAttr ptr) as wxFont ptr
declare sub wxGridCellAttr_GetAlignment cdecl alias "wxGridCellAttr_GetAlignment" (byval self as wxGridCellAttr ptr, byval hAlign as integer ptr, byval vAlign as integer ptr)
declare sub wxGridCellAttr_GetSize cdecl alias "wxGridCellAttr_GetSize" (byval self as wxGridCellAttr ptr, byval num_rows as integer ptr, byval num_cols as integer ptr)
declare function wxGridCellAttr_GetOverflow cdecl alias "wxGridCellAttr_GetOverflow" (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_GetRenderer cdecl alias "wxGridCellAttr_GetRenderer" (byval self as wxGridCellAttr ptr, byval grid as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellRenderer ptr
declare function wxGridCellAttr_GetEditor cdecl alias "wxGridCellAttr_GetEditor" (byval self as wxGridCellAttr ptr, byval grid as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellEditor ptr
declare function wxGridCellAttr_IsReadOnly cdecl alias "wxGridCellAttr_IsReadOnly" (byval self as wxGridCellAttr ptr) as integer
declare sub wxGridCellAttr_SetDefAttr cdecl alias "wxGridCellAttr_SetDefAttr" (byval self as wxGridCellAttr ptr, byval defAttr as wxGridCellAttr ptr)
declare function wxGridSizeEvent cdecl alias "wxGridSizeEvent_ctor" () as wxGridSizeEvent ptr
declare function wxGridSizeEvent_ctorParam cdecl alias "wxGridSizeEvent_ctorParam" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval rowOrCol as integer, byval x as integer, byval y as integer, byval control as integer, byval shift as integer, byval alt as integer, byval meta as integer) as wxGridSizeEvent ptr
declare function wxGridSizeEvent_GetRowOrCol cdecl alias "wxGridSizeEvent_GetRowOrCol" (byval self as wxGridSizeEvent ptr) as integer
declare sub wxGridSizeEvent_GetPosition cdecl alias "wxGridSizeEvent_GetPosition" (byval self as wxGridSizeEvent ptr, byval pt as wxPoint ptr)
declare function wxGridSizeEvent_ControlDown cdecl alias "wxGridSizeEvent_ControlDown" (byval self as wxGridSizeEvent ptr) as integer
declare function wxGridSizeEvent_MetaDown cdecl alias "wxGridSizeEvent_MetaDown" (byval self as wxGridSizeEvent ptr) as integer
declare function wxGridSizeEvent_ShiftDown cdecl alias "wxGridSizeEvent_ShiftDown" (byval self as wxGridSizeEvent ptr) as integer
declare function wxGridSizeEvent_AltDown cdecl alias "wxGridSizeEvent_AltDown" (byval self as wxGridSizeEvent ptr) as integer
declare sub wxGridSizeEvent_Veto cdecl alias "wxGridSizeEvent_Veto" (byval self as wxGridSizeEvent ptr)
declare sub wxGridSizeEvent_Allow cdecl alias "wxGridSizeEvent_Allow" (byval self as wxGridSizeEvent ptr)
declare function wxGridSizeEvent_IsAllowed cdecl alias "wxGridSizeEvent_IsAllowed" (byval self as wxGridSizeEvent ptr) as integer

type Virtual_Create as sub (byval as wxWindow ptr, byval as wxWindowID, byval as wxEvtHandler ptr)
type Virtual_BeginEdit as sub (byval as integer, byval as integer, byval as wxGrid ptr)
type Virtual_EndEdit as function (byval as integer, byval as integer, byval as wxGrid ptr) as integer
type Virtual_Reset as sub ( )
type Virtual_Clone as function ( ) as wxGridCellEditor
type Virtual_SetSize as sub (byval as wxRect ptr)
type Virtual_Show as sub (byval as integer, byval as wxGridCellAttr ptr)
type Virtual_PaintBackground as sub (byval as wxRect ptr, byval as wxGridCellAttr ptr)
type Virtual_IsAcceptedKey as function (byval as wxKeyEvent ptr) as integer
type Virtual_StartingKey as sub (byval as wxKeyEvent ptr)
type Virtual_StartingClick as sub ( )
type Virtual_HandleReturn as sub (byval as wxKeyEvent ptr)
type Virtual_Destroy as sub ( )
type Virtual_GetValue as function ( ) as byte

declare sub wxGridCellEditor_RegisterVirtual cdecl alias "wxGridCellEditor_RegisterVirtual" (byval self as _GridCellEditor ptr, byval create as Virtual_Create, byval beginEdit as Virtual_BeginEdit, byval endEdit as Virtual_EndEdit, byval reset as Virtual_Reset, byval clone as Virtual_Clone, byval setSize as Virtual_SetSize, byval show as Virtual_Show, byval paintBackground as Virtual_PaintBackground, byval isAcceptedKey as Virtual_IsAcceptedKey, byval startingKey as Virtual_StartingKey, byval startingClick as Virtual_StartingClick, byval handleReturn as Virtual_HandleReturn, byval destroy as Virtual_Destroy, byval getvalue as Virtual_GetValue)
declare function wxGridCellEditor cdecl alias "wxGridCellEditor_ctor" () as wxGridCellEditor ptr
declare sub wxGridCellEditor_dtor cdecl alias "wxGridCellEditor_dtor" (byval self as _GridCellEditor ptr)
declare sub wxGridCellEditor_Create cdecl alias "wxGridCellEditor_Create" (byval self as _GridCellEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare function wxGridCellEditor_IsCreated cdecl alias "wxGridCellEditor_IsCreated" (byval self as _GridCellEditor ptr) as integer
declare function wxGridCellEditor_IsAcceptedKey cdecl alias "wxGridCellEditor_IsAcceptedKey" (byval self as _GridCellEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellEditor_SetSize cdecl alias "wxGridCellEditor_SetSize" (byval self as _GridCellEditor ptr, byval rect as wxRect ptr)
declare sub wxGridCellEditor_Show cdecl alias "wxGridCellEditor_Show" (byval self as _GridCellEditor ptr, byval show as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGridCellEditor_PaintBackground cdecl alias "wxGridCellEditor_PaintBackground" (byval self as _GridCellEditor ptr, byval rectCell as wxRect ptr, byval attr as wxGridCellAttr ptr)
declare sub wxGridCellEditor_StartingKey cdecl alias "wxGridCellEditor_StartingKey" (byval self as _GridCellEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellEditor_StartingClick cdecl alias "wxGridCellEditor_StartingClick" (byval self as _GridCellEditor ptr)
declare sub wxGridCellEditor_HandleReturn cdecl alias "wxGridCellEditor_HandleReturn" (byval self as _GridCellEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellEditor_Destroy cdecl alias "wxGridCellEditor_Destroy" (byval self as _GridCellEditor ptr)

type Virtual_GetNumberRows as function ( ) as integer
type Virtual_GetNumberCols as function ( ) as integer
type Virtual_IsEmptyCell as function (byval as integer, byval as integer) as integer
type Virtual_GetValue2 as function (byval as integer, byval as integer) as byte
type Virtual_SetValue as sub (byval as integer, byval as integer, byval as wxString ptr)
type Virtual_CanGetValueAs as function (byval as integer, byval as integer, byval as wxString ptr) as integer
type Virtual_GetValueAsLong as function (byval as integer, byval as integer) as integer
type Virtual_GetValueAsDouble as function (byval as integer, byval as integer) as double
type Virtual_SetValueAsLong as sub (byval as integer, byval as integer, byval as integer)
type Virtual_SetValueAsDouble as sub (byval as integer, byval as integer, byval as double)
type Virtual_SetValueAsBool as sub (byval as integer, byval as integer, byval as integer)
type Virtual_GetValueAsCustom as sub (byval as integer, byval as integer, byval as wxString ptr)
type Virtual_SetValueAsCustom as sub (byval as integer, byval as integer, byval as wxString ptr, byval as any ptr)
type Virtual_GetColLabelValue as function (byval as integer) as byte
type Virtual_SetView as sub (byval as wxGrid ptr)
type Virtual_GetView as function ( ) as wxGrid
type Virtual_Clear as sub ( )
type Virtual_InsertRows as function (byval as integer, byval as integer) as integer
type Virtual_AppendRows as function (byval as integer) as integer
type Virtual_SetRowLabelValue as sub (byval as integer, byval as wxString ptr)
type Virtual_SetAttrProvider as sub (byval as wxGridCellAttrProvider ptr)
type Virtual_GetAttrProvider as function ( ) as wxGridCellAttrProvider
type Virtual_CanHaveAttributes as function ( ) as integer
type Virtual_GetAttr as function (byval as integer, byval as integer, byval as integer) as wxGridCellAttr
type Virtual_SetAttr as sub (byval as wxGridCellAttr ptr, byval as integer, byval as integer)
type Virtual_SetRowAttr as sub (byval as wxGridCellAttr ptr, byval as integer)

declare function wxGridTableBase cdecl alias "wxGridTableBase_ctor" () as wxGridTableBase ptr
declare sub wxGridTableBase_RegisterVirtual cdecl alias "wxGridTableBase_RegisterVirtual" (byval self as _GridTableBase ptr, byval getNumberRows as Virtual_GetNumberRows, byval getNumberCols as Virtual_GetNumberCols, byval isEmptyCell as Virtual_IsEmptyCell, byval getValue as Virtual_GetValue2, byval setValue as Virtual_SetValue, byval getTypeName as Virtual_GetValue2, byval canGetValueAs as Virtual_CanGetValueAs, byval canSetValueAs as Virtual_CanGetValueAs, byval getValueAsLong as Virtual_GetValueAsLong, byval getValueAsDouble as Virtual_GetValueAsDouble, byval getValueAsBool as Virtual_IsEmptyCell, byval setValueAsLong as Virtual_SetValueAsLong, byval setValueAsDouble as Virtual_SetValueAsDouble, byval setValueAsBool as Virtual_SetValueAsBool, byval getValueAsCustom as Virtual_GetValueAsCustom, byval setValueAsCustom as Virtual_SetValueAsCustom, byval setView as Virtual_SetView, byval getView as Virtual_GetView, byval clear as Virtual_Clear, byval insertRows as Virtual_InsertRows, byval appendRows as Virtual_AppendRows, byval deleteRows as Virtual_InsertRows, byval insertCols as Virtual_InsertRows, byval appendCols as Virtual_AppendRows, byval deleteCols as Virtual_InsertRows, byval getRowLabelValue as Virtual_GetColLabelValue, byval getColLabelValue as Virtual_GetColLabelValue, byval setRowLabelValue as Virtual_SetRowLabelValue, byval setColLabelValue as Virtual_SetRowLabelValue, byval setAttrProvider as Virtual_SetAttrProvider, byval getAttrProvider as Virtual_GetAttrProvider, byval canHaveAttributes as Virtual_CanHaveAttributes, byval getAttr as Virtual_GetAttr, byval setAttr as Virtual_SetAttr, byval setRowAttr as Virtual_SetRowAttr, byval setColAttr as Virtual_SetRowAttr)
declare function wxGridTableBase_GetTypeName cdecl alias "wxGridTableBase_GetTypeName" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as wxString ptr
declare function wxGridTableBase_CanGetValueAs cdecl alias "wxGridTableBase_CanGetValueAs" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as string) as integer
declare function wxGridTableBase_CanSetValueAs cdecl alias "wxGridTableBase_CanSetValueAs" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as string) as integer
declare function wxGridTableBase_GetValueAsLong cdecl alias "wxGridTableBase_GetValueAsLong" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as integer
declare function wxGridTableBase_GetValueAsDouble cdecl alias "wxGridTableBase_GetValueAsDouble" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as double
declare function wxGridTableBase_GetValueAsBool cdecl alias "wxGridTableBase_GetValueAsBool" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as integer
declare sub wxGridTableBase_SetValueAsLong cdecl alias "wxGridTableBase_SetValueAsLong" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval value as integer)
declare sub wxGridTableBase_SetValueAsDouble cdecl alias "wxGridTableBase_SetValueAsDouble" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval value as double)
declare sub wxGridTableBase_SetValueAsBool cdecl alias "wxGridTableBase_SetValueAsBool" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval value as integer)
declare function wxGridTableBase_GetValueAsCustom cdecl alias "wxGridTableBase_GetValueAsCustom" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as string) as any ptr
declare sub wxGridTableBase_SetValueAsCustom cdecl alias "wxGridTableBase_SetValueAsCustom" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as string, byval value as any ptr)
declare sub wxGridTableBase_SetView cdecl alias "wxGridTableBase_SetView" (byval self as _GridTableBase ptr, byval grid as wxGrid ptr)
declare function wxGridTableBase_GetView cdecl alias "wxGridTableBase_GetView" (byval self as _GridTableBase ptr) as wxGrid ptr
declare sub wxGridTableBase_Clear cdecl alias "wxGridTableBase_Clear" (byval self as _GridTableBase ptr)
declare function wxGridTableBase_InsertRows cdecl alias "wxGridTableBase_InsertRows" (byval self as _GridTableBase ptr, byval pos as integer, byval numRows as integer) as integer
declare function wxGridTableBase_AppendRows cdecl alias "wxGridTableBase_AppendRows" (byval self as _GridTableBase ptr, byval numRows as integer) as integer
declare function wxGridTableBase_DeleteRows cdecl alias "wxGridTableBase_DeleteRows" (byval self as _GridTableBase ptr, byval pos as integer, byval numRows as integer) as integer
declare function wxGridTableBase_InsertCols cdecl alias "wxGridTableBase_InsertCols" (byval self as _GridTableBase ptr, byval pos as integer, byval numCols as integer) as integer
declare function wxGridTableBase_AppendCols cdecl alias "wxGridTableBase_AppendCols" (byval self as _GridTableBase ptr, byval numCols as integer) as integer
declare function wxGridTableBase_DeleteCols cdecl alias "wxGridTableBase_DeleteCols" (byval self as _GridTableBase ptr, byval pos as integer, byval numCols as integer) as integer
declare function wxGridTableBase_GetRowLabelValue cdecl alias "wxGridTableBase_GetRowLabelValue" (byval self as _GridTableBase ptr, byval row as integer) as wxString ptr
declare function wxGridTableBase_GetColLabelValue cdecl alias "wxGridTableBase_GetColLabelValue" (byval self as _GridTableBase ptr, byval col as integer) as wxString ptr
declare sub wxGridTableBase_SetRowLabelValue cdecl alias "wxGridTableBase_SetRowLabelValue" (byval self as _GridTableBase ptr, byval row as integer, byval value as string)
declare sub wxGridTableBase_SetColLabelValue cdecl alias "wxGridTableBase_SetColLabelValue" (byval self as _GridTableBase ptr, byval col as integer, byval value as string)
declare sub wxGridTableBase_SetAttrProvider cdecl alias "wxGridTableBase_SetAttrProvider" (byval self as _GridTableBase ptr, byval attrProvider as wxGridCellAttrProvider ptr)
declare function wxGridTableBase_GetAttrProvider cdecl alias "wxGridTableBase_GetAttrProvider" (byval self as _GridTableBase ptr) as wxGridCellAttrProvider ptr
declare function wxGridTableBase_CanHaveAttributes cdecl alias "wxGridTableBase_CanHaveAttributes" (byval self as _GridTableBase ptr) as integer
declare function wxGridTableBase_GetAttr cdecl alias "wxGridTableBase_GetAttr" (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval kind as integer) as wxGridCellAttr ptr
declare sub wxGridTableBase_SetAttr cdecl alias "wxGridTableBase_SetAttr" (byval self as _GridTableBase ptr, byval attr as wxGridCellAttr ptr, byval row as integer, byval col as integer)
declare sub wxGridTableBase_SetRowAttr cdecl alias "wxGridTableBase_SetRowAttr" (byval self as _GridTableBase ptr, byval attr as wxGridCellAttr ptr, byval row as integer)
declare sub wxGridTableBase_SetColAttr cdecl alias "wxGridTableBase_SetColAttr" (byval self as _GridTableBase ptr, byval attr as wxGridCellAttr ptr, byval col as integer)
declare function wxGridCellTextEditor cdecl alias "wxGridCellTextEditor_ctor" () as wxGridCellTextEditor ptr
declare sub wxGridCellTextEditor_dtor cdecl alias "wxGridCellTextEditor_dtor" (byval self as wxGridCellTextEditor ptr)
declare sub wxGridCellTextEditor_Create cdecl alias "wxGridCellTextEditor_Create" (byval self as wxGridCellTextEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare sub wxGridCellTextEditor_SetSize cdecl alias "wxGridCellTextEditor_SetSize" (byval self as wxGridCellTextEditor ptr, byval rect as wxRect ptr)
declare sub wxGridCellTextEditor_PaintBackground cdecl alias "wxGridCellTextEditor_PaintBackground" (byval self as wxGridCellTextEditor ptr, byval rectCell as wxRect ptr, byval attr as wxGridCellAttr ptr)
declare function wxGridCellTextEditor_IsAcceptedKey cdecl alias "wxGridCellTextEditor_IsAcceptedKey" (byval self as wxGridCellTextEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellTextEditor_BeginEdit cdecl alias "wxGridCellTextEditor_BeginEdit" (byval self as wxGridCellTextEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellTextEditor_EndEdit cdecl alias "wxGridCellTextEditor_EndEdit" (byval self as wxGridCellTextEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellTextEditor_Reset cdecl alias "wxGridCellTextEditor_Reset" (byval self as wxGridCellTextEditor ptr)
declare sub wxGridCellTextEditor_StartingKey cdecl alias "wxGridCellTextEditor_StartingKey" (byval self as wxGridCellTextEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellTextEditor_SetParameters cdecl alias "wxGridCellTextEditor_SetParameters" (byval self as wxGridCellTextEditor ptr, byval params as string)
declare function wxGridCellTextEditor_Clone cdecl alias "wxGridCellTextEditor_Clone" (byval self as wxGridCellTextEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellAttrProvider cdecl alias "wxGridCellAttrProvider_ctor" () as wxGridCellAttrProvider ptr
declare sub wxGridCellAttrProvider_dtor cdecl alias "wxGridCellAttrProvider_dtor" (byval self as _GridCellAttrProvider ptr)
declare sub wxGridCellAttrProvider_RegisterVirtual cdecl alias "wxGridCellAttrProvider_RegisterVirtual" (byval self as _GridCellAttrProvider ptr, byval getAttr as Virtual_GetAttr, byval setAttr as Virtual_SetAttr, byval setRowAttr as Virtual_SetRowAttr, byval setColAttr as Virtual_SetRowAttr)
declare function wxGridCellAttrProvider_GetAttr cdecl alias "wxGridCellAttrProvider_GetAttr" (byval self as _GridCellAttrProvider ptr, byval row as integer, byval col as integer, byval kind as integer) as wxGridCellAttr ptr
declare sub wxGridCellAttrProvider_SetAttr cdecl alias "wxGridCellAttrProvider_SetAttr" (byval self as _GridCellAttrProvider ptr, byval attr as wxGridCellAttr ptr, byval row as integer, byval col as integer)
declare sub wxGridCellAttrProvider_SetRowAttr cdecl alias "wxGridCellAttrProvider_SetRowAttr" (byval self as _GridCellAttrProvider ptr, byval attr as wxGridCellAttr ptr, byval row as integer)
declare sub wxGridCellAttrProvider_SetColAttr cdecl alias "wxGridCellAttrProvider_SetColAttr" (byval self as _GridCellAttrProvider ptr, byval attr as wxGridCellAttr ptr, byval col as integer)
declare sub wxGridCellAttrProvider_UpdateAttrRows cdecl alias "wxGridCellAttrProvider_UpdateAttrRows" (byval self as _GridCellAttrProvider ptr, byval pos as integer, byval numRows as integer)
declare sub wxGridCellAttrProvider_UpdateAttrCols cdecl alias "wxGridCellAttrProvider_UpdateAttrCols" (byval self as _GridCellAttrProvider ptr, byval pos as integer, byval numCols as integer)

declare function wxGridCellNumberEditor cdecl alias "wxGridCellNumberEditor_ctor" (byval min as integer, byval max as integer) as wxGridCellNumberEditor ptr
declare sub wxGridCellNumberEditor_dtor cdecl alias "wxGridCellNumberEditor_dtor" (byval self as wxGridCellNumberEditor ptr)
declare sub wxGridCellNumberEditor_RegisterDisposable cdecl alias "wxGridCellNumberEditor_RegisterDisposable" (byval self as _GridCellNumberEditor ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellNumberEditor_Create cdecl alias "wxGridCellNumberEditor_Create" (byval self as wxGridCellNumberEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare function wxGridCellNumberEditor_IsAcceptedKey cdecl alias "wxGridCellNumberEditor_IsAcceptedKey" (byval self as wxGridCellNumberEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellNumberEditor_BeginEdit cdecl alias "wxGridCellNumberEditor_BeginEdit" (byval self as wxGridCellNumberEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellNumberEditor_EndEdit cdecl alias "wxGridCellNumberEditor_EndEdit" (byval self as wxGridCellNumberEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellNumberEditor_Reset cdecl alias "wxGridCellNumberEditor_Reset" (byval self as wxGridCellNumberEditor ptr)
declare sub wxGridCellNumberEditor_StartingKey cdecl alias "wxGridCellNumberEditor_StartingKey" (byval self as wxGridCellNumberEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellNumberEditor_SetParameters cdecl alias "wxGridCellNumberEditor_SetParameters" (byval self as wxGridCellNumberEditor ptr, byval params as string)
declare function wxGridCellNumberEditor_Clone cdecl alias "wxGridCellNumberEditor_Clone" (byval self as wxGridCellNumberEditor ptr) as wxGridCellEditor ptr
declare function wxGridCellFloatEditor cdecl alias "wxGridCellFloatEditor_ctor" (byval width as integer, byval precision as integer) as wxGridCellFloatEditor ptr
declare sub wxGridCellFloatEditor_dtor cdecl alias "wxGridCellFloatEditor_dtor" (byval self as wxGridCellFloatEditor ptr)
declare sub wxGridCellFloatEditor_Create cdecl alias "wxGridCellFloatEditor_Create" (byval self as wxGridCellFloatEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare function wxGridCellFloatEditor_IsAcceptedKey cdecl alias "wxGridCellFloatEditor_IsAcceptedKey" (byval self as wxGridCellFloatEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellFloatEditor_BeginEdit cdecl alias "wxGridCellFloatEditor_BeginEdit" (byval self as wxGridCellFloatEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellFloatEditor_EndEdit cdecl alias "wxGridCellFloatEditor_EndEdit" (byval self as wxGridCellFloatEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellFloatEditor_Reset cdecl alias "wxGridCellFloatEditor_Reset" (byval self as wxGridCellFloatEditor ptr)
declare sub wxGridCellFloatEditor_StartingKey cdecl alias "wxGridCellFloatEditor_StartingKey" (byval self as wxGridCellFloatEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellFloatEditor_SetParameters cdecl alias "wxGridCellFloatEditor_SetParameters" (byval self as wxGridCellFloatEditor ptr, byval params as string)
declare function wxGridCellFloatEditor_Clone cdecl alias "wxGridCellFloatEditor_Clone" (byval self as wxGridCellFloatEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellBoolEditor cdecl alias "wxGridCellBoolEditor_ctor" () as wxGridCellBoolEditor ptr
declare sub wxGridCellBoolEditor_dtor cdecl alias "wxGridCellBoolEditor_dtor" (byval self as wxGridCellBoolEditor ptr)
declare sub wxGridCellBoolEditor_RegisterDisposable cdecl alias "wxGridCellBoolEditor_RegisterDisposable" (byval self as _GridCellBoolEditor ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellBoolEditor_Create cdecl alias "wxGridCellBoolEditor_Create" (byval self as wxGridCellBoolEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare sub wxGridCellBoolEditor_SetSize cdecl alias "wxGridCellBoolEditor_SetSize" (byval self as wxGridCellBoolEditor ptr, byval rect as wxRect ptr)
declare function wxGridCellBoolEditor_IsAcceptedKey cdecl alias "wxGridCellBoolEditor_IsAcceptedKey" (byval self as wxGridCellBoolEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellBoolEditor_BeginEdit cdecl alias "wxGridCellBoolEditor_BeginEdit" (byval self as wxGridCellBoolEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellBoolEditor_EndEdit cdecl alias "wxGridCellBoolEditor_EndEdit" (byval self as wxGridCellBoolEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellBoolEditor_Reset cdecl alias "wxGridCellBoolEditor_Reset" (byval self as wxGridCellBoolEditor ptr)
declare sub wxGridCellBoolEditor_StartingClick cdecl alias "wxGridCellBoolEditor_StartingClick" (byval self as wxGridCellFloatEditor ptr)
declare function wxGridCellBoolEditor_Clone cdecl alias "wxGridCellBoolEditor_Clone" (byval self as wxGridCellBoolEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellChoiceEditor cdecl alias "wxGridCellChoiceEditor_ctor" (byval n as integer, byval choices as byte ptr ptr, byval allowOthers as integer) as wxGridCellChoiceEditor ptr
declare sub wxGridCellChoiceEditor_dtor cdecl alias "wxGridCellChoiceEditor_dtor" (byval self as wxGridCellChoiceEditor ptr)
declare sub wxGridCellChoiceEditor_RegisterDisposable cdecl alias "wxGridCellChoiceEditor_RegisterDisposable" (byval self as _GridCellChoiceEditor ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellChoiceEditor_Create cdecl alias "wxGridCellChoiceEditor_Create" (byval self as wxGridCellChoiceEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare sub wxGridCellChoiceEditor_PaintBackground cdecl alias "wxGridCellChoiceEditor_PaintBackground" (byval self as wxGridCellChoiceEditor ptr, byval rect as wxRect ptr, byval attr as wxGridCellAttr ptr)
declare sub wxGridCellChoiceEditor_BeginEdit cdecl alias "wxGridCellChoiceEditor_BeginEdit" (byval self as wxGridCellChoiceEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellChoiceEditor_EndEdit cdecl alias "wxGridCellChoiceEditor_EndEdit" (byval self as wxGridCellChoiceEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellChoiceEditor_Reset cdecl alias "wxGridCellChoiceEditor_Reset" (byval self as wxGridCellChoiceEditor ptr)
declare sub wxGridCellChoiceEditor_SetParameters cdecl alias "wxGridCellChoiceEditor_SetParameters" (byval self as wxGridCellChoiceEditor ptr, byval params as string)
declare function wxGridCellChoiceEditor_Clone cdecl alias "wxGridCellChoiceEditor_Clone" (byval self as wxGridCellChoiceEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellStringRenderer cdecl alias "wxGridCellStringRenderer_ctor" () as wxGridCellStringRenderer ptr
declare sub wxGridCellStringRenderer_dtor cdecl alias "wxGridCellStringRenderer_dtor" (byval self as wxGridCellStringRenderer ptr)
declare sub wxGridCellStringRenderer_RegisterDisposable cdecl alias "wxGridCellStringRenderer_RegisterDisposable" (byval self as _GridCellStringRenderer ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellStringRenderer_Draw cdecl alias "wxGridCellStringRenderer_Draw" (byval self as wxGridCellStringRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellStringRenderer_GetBestSize cdecl alias "wxGridCellStringRenderer_GetBestSize" (byval self as wxGridCellStringRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellStringRenderer_Clone cdecl alias "wxGridCellStringRenderer_Clone" (byval self as wxGridCellStringRenderer ptr) as wxGridCellRenderer ptr
declare function wxGridCellNumberRenderer cdecl alias "wxGridCellNumberRenderer_ctor" () as wxGridCellNumberRenderer ptr
declare sub wxGridCellNumberRenderer_dtor cdecl alias "wxGridCellNumberRenderer_dtor" (byval self as wxGridCellNumberRenderer ptr)
declare sub wxGridCellNumberRenderer_Draw cdecl alias "wxGridCellNumberRenderer_Draw" (byval self as wxGridCellNumberRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellNumberRenderer_GetBestSize cdecl alias "wxGridCellNumberRenderer_GetBestSize" (byval self as wxGridCellNumberRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellNumberRenderer_Clone cdecl alias "wxGridCellNumberRenderer_Clone" (byval self as wxGridCellNumberRenderer ptr) as wxGridCellRenderer ptr
declare function wxGridCellFloatRenderer cdecl alias "wxGridCellFloatRenderer_ctor" (byval width as integer, byval precision as integer) as wxGridCellFloatRenderer ptr
declare sub wxGridCellFloatRenderer_dtor cdecl alias "wxGridCellFloatRenderer_dtor" (byval self as wxGridCellFloatRenderer ptr)
declare sub wxGridCellFloatRenderer_Draw cdecl alias "wxGridCellFloatRenderer_Draw" (byval self as wxGridCellFloatRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellFloatRenderer_GetBestSize cdecl alias "wxGridCellFloatRenderer_GetBestSize" (byval self as wxGridCellFloatRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellFloatRenderer_Clone cdecl alias "wxGridCellFloatRenderer_Clone" (byval self as wxGridCellFloatRenderer ptr) as wxGridCellRenderer ptr
declare function wxGridCellFloatRenderer_GetWidth cdecl alias "wxGridCellFloatRenderer_GetWidth" (byval self as wxGridCellFloatRenderer ptr) as integer
declare sub wxGridCellFloatRenderer_SetWidth cdecl alias "wxGridCellFloatRenderer_SetWidth" (byval self as wxGridCellFloatRenderer ptr, byval width as integer)
declare function wxGridCellFloatRenderer_GetPrecision cdecl alias "wxGridCellFloatRenderer_GetPrecision" (byval self as wxGridCellFloatRenderer ptr) as integer
declare sub wxGridCellFloatRenderer_SetPrecision cdecl alias "wxGridCellFloatRenderer_SetPrecision" (byval self as wxGridCellFloatRenderer ptr, byval precision as integer)
declare sub wxGridCellFloatRenderer_SetParameters cdecl alias "wxGridCellFloatRenderer_SetParameters" (byval self as wxGridCellFloatRenderer ptr, byval params as string)

declare function wxGridCellBoolRenderer cdecl alias "wxGridCellBoolRenderer_ctor" () as wxGridCellBoolRenderer ptr
declare sub wxGridCellBoolRenderer_dtor cdecl alias "wxGridCellBoolRenderer_dtor" (byval self as wxGridCellBoolRenderer ptr)
declare sub wxGridCellBoolRenderer_RegisterDisposable cdecl alias "wxGridCellBoolRenderer_RegisterDisposable" (byval self as _GridCellBoolRenderer ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellBoolRenderer_Draw cdecl alias "wxGridCellBoolRenderer_Draw" (byval self as wxGridCellBoolRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellBoolRenderer_GetBestSize cdecl alias "wxGridCellBoolRenderer_GetBestSize" (byval self as wxGridCellBoolRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellBoolRenderer_Clone cdecl alias "wxGridCellBoolRenderer_Clone" (byval self as wxGridCellBoolRenderer ptr) as wxGridCellRenderer ptr

type Virtual_Draw as sub (byval as wxGrid ptr, byval as wxGridCellAttr ptr, byval as wxDC ptr, byval as wxRect ptr, byval as integer, byval as integer, byval as integer)
type Virtual_GetBestSize as function (byval as wxGrid ptr, byval as wxGridCellAttr ptr, byval as wxDC ptr, byval as integer, byval as integer) as wxSize
type Virtual_RendererClone as function ( ) as wxGridCellRenderer

declare function wxGridCellRenderer cdecl alias "wxGridCellRenderer_ctor" () as wxGridCellRenderer ptr
declare sub wxGridCellRenderer_dtor cdecl alias "wxGridCellRenderer_dtor" (byval self as _GridCellRenderer ptr)
declare sub wxGridCellRenderer_RegisterVirtual cdecl alias "wxGridCellRenderer_RegisterVirtual" (byval self as _GridCellRenderer ptr, byval draw as Virtual_Draw, byval getBestSize as Virtual_GetBestSize, byval clone as Virtual_RendererClone)

#endif
