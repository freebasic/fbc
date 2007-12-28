''
''
'' grid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_grid_bi__
#define __wxc_grid_bi__

#include once "wx.bi"

declare function wxGridEvent alias "wxGridEvent_ctor" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval row as integer, byval col as integer, byval x as integer, byval y as integer, byval sel as integer, byval control as integer, byval shift as integer, byval alt as integer, byval meta as integer) as wxGridEvent ptr
declare function wxGridEvent_GetRow (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_GetCol (byval self as wxGridEvent ptr) as integer
declare sub wxGridEvent_GetPosition (byval self as wxGridEvent ptr, byval pt as wxPoint ptr)
declare function wxGridEvent_Selecting (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_ControlDown (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_MetaDown (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_ShiftDown (byval self as wxGridEvent ptr) as integer
declare function wxGridEvent_AltDown (byval self as wxGridEvent ptr) as integer
declare sub wxGridEvent_Veto (byval self as wxGridEvent ptr)
declare sub wxGridEvent_Allow (byval self as wxGridEvent ptr)
declare function wxGridEvent_IsAllowed (byval self as wxGridEvent ptr) as integer
declare function wxGridRangeSelectEvent alias "wxGridRangeSelectEvent_ctor" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval topLeft as wxGridCellCoords ptr, byval bottomRight as wxGridCellCoords ptr, byval sel as integer, byval control as integer, byval shift as integer, byval alt as integer, byval meta as integer) as wxGridRangeSelectEvent ptr
declare function wxGridRangeSelectEvent_GetTopLeftCoords (byval self as wxGridRangeSelectEvent ptr) as wxGridCellCoords ptr
declare function wxGridRangeSelectEvent_GetBottomRightCoords (byval self as wxGridRangeSelectEvent ptr) as wxGridCellCoords ptr
declare function wxGridRangeSelectEvent_GetTopRow (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_GetBottomRow (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_GetLeftCol (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_GetRightCol (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_Selecting (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_ControlDown (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_MetaDown (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_ShiftDown (byval self as wxGridRangeSelectEvent ptr) as integer
declare function wxGridRangeSelectEvent_AltDown (byval self as wxGridRangeSelectEvent ptr) as integer
declare sub wxGridRangeSelectEvent_Veto (byval self as wxGridRangeSelectEvent ptr)
declare sub wxGridRangeSelectEvent_Allow (byval self as wxGridRangeSelectEvent ptr)
declare function wxGridRangeSelectEvent_IsAllowed (byval self as wxGridRangeSelectEvent ptr) as integer

type Virtual_SetParameters as sub WXCALL (byval as wxString ptr)

declare function wxGridCellWorker alias "wxGridCellWorker_ctor" () as wxGridCellWorker ptr
declare sub wxGridCellWorker_RegisterVirtual (byval self as _GridCellWorker ptr, byval setParameters as Virtual_SetParameters)
declare sub wxGridCellWorker_IncRef (byval self as _GridCellWorker ptr)
declare sub wxGridCellWorker_DecRef (byval self as _GridCellWorker ptr)
declare sub wxGridCellWorker_SetParameters (byval self as _GridCellWorker ptr, byval params as zstring ptr)
declare function wxGridEditorCreatedEvent alias "wxGridEditorCreatedEvent_ctor" (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval row as integer, byval col as integer, byval ctrl as wxControl ptr) as wxGridEditorCreatedEvent ptr
declare function wxGridEditorCreatedEvent_GetRow (byval self as wxGridEditorCreatedEvent ptr) as integer
declare function wxGridEditorCreatedEvent_GetCol (byval self as wxGridEditorCreatedEvent ptr) as integer
declare function wxGridEditorCreatedEvent_GetControl (byval self as wxGridEditorCreatedEvent ptr) as wxControl ptr
declare sub wxGridEditorCreatedEvent_SetRow (byval self as wxGridEditorCreatedEvent ptr, byval row as integer)
declare sub wxGridEditorCreatedEvent_SetCol (byval self as wxGridEditorCreatedEvent ptr, byval col as integer)
declare sub wxGridEditorCreatedEvent_SetControl (byval self as wxGridEditorCreatedEvent ptr, byval ctrl as wxControl ptr)

declare function wxGrid alias "wxGrid_ctor" () as wxGrid ptr
declare function wxGrid_ctorFull (byval parent as wxWindow ptr, byval id as wxWindowID, byval pos as wxPoint ptr, byval size as wxSize ptr, byval style as integer, byval name as zstring ptr) as wxGrid ptr
declare sub wxGrid_dtor (byval self as wxGrid ptr)
declare function wxGrid_CreateGrid (byval self as wxGrid ptr, byval numRows as integer, byval numCols as integer, byval selmode as integer) as integer
declare sub wxGrid_SetSelectionMode (byval self as wxGrid ptr, byval selmode as integer)
declare function wxGrid_GetSelectionMode (byval self as wxGrid ptr) as integer
declare function wxGrid_GetNumberRows (byval self as wxGrid ptr) as integer
declare function wxGrid_GetNumberCols (byval self as wxGrid ptr) as integer
declare sub wxGrid_ProcessRowLabelMouseEvent (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare sub wxGrid_ProcessColLabelMouseEvent (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare sub wxGrid_ProcessCornerLabelMouseEvent (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare sub wxGrid_ProcessGridCellMouseEvent (byval self as wxGrid ptr, byval event as wxMouseEvent ptr)
declare function wxGrid_GetTable (byval self as wxGrid ptr) as wxGridTableBase ptr
declare function wxGrid_SetTable (byval self as wxGrid ptr, byval table as wxGridTableBase ptr, byval takeOwnership as integer, byval selmode as integer) as integer
declare sub wxGrid_ClearGrid (byval self as wxGrid ptr)
declare function wxGrid_InsertRows (byval self as wxGrid ptr, byval pos as integer, byval numRows as integer, byval updateLabels as integer) as integer
declare function wxGrid_AppendRows (byval self as wxGrid ptr, byval numRows as integer, byval updateLabels as integer) as integer
declare function wxGrid_DeleteRows (byval self as wxGrid ptr, byval pos as integer, byval numRows as integer, byval updateLabels as integer) as integer
declare function wxGrid_InsertCols (byval self as wxGrid ptr, byval pos as integer, byval numCols as integer, byval updateLabels as integer) as integer
declare function wxGrid_AppendCols (byval self as wxGrid ptr, byval numCols as integer, byval updateLabels as integer) as integer
declare function wxGrid_DeleteCols (byval self as wxGrid ptr, byval pos as integer, byval numCols as integer, byval updateLabels as integer) as integer
declare sub wxGrid_DrawGridCellArea (byval self as wxGrid ptr, byval dc as wxDC ptr, byval cells as wxGridCellCoordsArray ptr)
declare sub wxGrid_DrawGridSpace (byval self as wxGrid ptr, byval dc as wxDC ptr)
declare sub wxGrid_BeginBatch (byval self as wxGrid ptr)
declare sub wxGrid_EndBatch (byval self as wxGrid ptr)
declare function wxGrid_GetBatchCount (byval self as wxGrid ptr) as integer
declare sub wxGrid_ForceRefresh (byval self as wxGrid ptr)
declare function wxGrid_IsEditable (byval self as wxGrid ptr) as integer
declare sub wxGrid_EnableEditing (byval self as wxGrid ptr, byval edit as integer)
declare sub wxGrid_EnableCellEditControl (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableCellEditControl (byval self as wxGrid ptr)
declare function wxGrid_CanEnableCellControl (byval self as wxGrid ptr) as integer
declare function wxGrid_IsCellEditControlEnabled (byval self as wxGrid ptr) as integer
declare function wxGrid_IsCellEditControlShown (byval self as wxGrid ptr) as integer
declare function wxGrid_IsCurrentCellReadOnly (byval self as wxGrid ptr) as integer
declare sub wxGrid_ShowCellEditControl (byval self as wxGrid ptr)
declare sub wxGrid_HideCellEditControl (byval self as wxGrid ptr)
declare sub wxGrid_SaveEditControlValue (byval self as wxGrid ptr)
declare function wxGrid_YToRow (byval self as wxGrid ptr, byval y as integer) as integer
declare function wxGrid_XToCol (byval self as wxGrid ptr, byval x as integer) as integer
declare function wxGrid_YToEdgeOfRow (byval self as wxGrid ptr, byval y as integer) as integer
declare function wxGrid_XToEdgeOfCol (byval self as wxGrid ptr, byval x as integer) as integer
declare sub wxGrid_CellToRect (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval rc as wxRect ptr)
declare function wxGrid_GetGridCursorRow (byval self as wxGrid ptr) as integer
declare function wxGrid_GetGridCursorCol (byval self as wxGrid ptr) as integer
declare function wxGrid_IsVisible (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval wholeCellVisible as integer) as integer
declare sub wxGrid_MakeCellVisible (byval self as wxGrid ptr, byval row as integer, byval col as integer)
declare sub wxGrid_SetGridCursor (byval self as wxGrid ptr, byval row as integer, byval col as integer)
declare function wxGrid_MoveCursorUp (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorDown (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorLeft (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorRight (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MovePageDown (byval self as wxGrid ptr) as integer
declare function wxGrid_MovePageUp (byval self as wxGrid ptr) as integer
declare function wxGrid_MoveCursorUpBlock (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorDownBlock (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorLeftBlock (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_MoveCursorRightBlock (byval self as wxGrid ptr, byval expandSelection as integer) as integer
declare function wxGrid_GetDefaultRowLabelSize (byval self as wxGrid ptr) as integer
declare function wxGrid_GetRowLabelSize (byval self as wxGrid ptr) as integer
declare function wxGrid_GetDefaultColLabelSize (byval self as wxGrid ptr) as integer
declare function wxGrid_GetColLabelSize (byval self as wxGrid ptr) as integer
declare function wxGrid_GetLabelBackgroundColour (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetLabelTextColour (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetLabelFont (byval self as wxGrid ptr) as wxFont ptr
declare sub wxGrid_GetRowLabelAlignment (byval self as wxGrid ptr, byval horiz as integer ptr, byval vert as integer ptr)
declare sub wxGrid_GetColLabelAlignment (byval self as wxGrid ptr, byval horiz as integer ptr, byval vert as integer ptr)
declare function wxGrid_GetRowLabelValue (byval self as wxGrid ptr, byval row as integer) as wxString ptr
declare function wxGrid_GetColLabelValue (byval self as wxGrid ptr, byval col as integer) as wxString ptr
declare function wxGrid_GetGridLineColour (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellHighlightColour (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellHighlightPenWidth (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCellHighlightROPenWidth (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetRowLabelSize (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_SetColLabelSize (byval self as wxGrid ptr, byval height as integer)
declare sub wxGrid_SetLabelBackgroundColour (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetLabelTextColour (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetLabelFont (byval self as wxGrid ptr, byval font as wxFont ptr)
declare sub wxGrid_SetRowLabelAlignment (byval self as wxGrid ptr, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetColLabelAlignment (byval self as wxGrid ptr, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetRowLabelValue (byval self as wxGrid ptr, byval row as integer, byval val as zstring ptr)
declare sub wxGrid_SetColLabelValue (byval self as wxGrid ptr, byval col as integer, byval val as zstring ptr)
declare sub wxGrid_SetGridLineColour (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellHighlightColour (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellHighlightPenWidth (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_SetCellHighlightROPenWidth (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_EnableDragRowSize (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableDragRowSize (byval self as wxGrid ptr)
declare function wxGrid_CanDragRowSize (byval self as wxGrid ptr) as integer
declare sub wxGrid_EnableDragColSize (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableDragColSize (byval self as wxGrid ptr)
declare function wxGrid_CanDragColSize (byval self as wxGrid ptr) as integer
declare sub wxGrid_EnableDragGridSize (byval self as wxGrid ptr, byval enable as integer)
declare sub wxGrid_DisableDragGridSize (byval self as wxGrid ptr)
declare function wxGrid_CanDragGridSize (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetAttr (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGrid_SetRowAttr (byval self as wxGrid ptr, byval row as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGrid_SetColAttr (byval self as wxGrid ptr, byval col as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGrid_SetColFormatBool (byval self as wxGrid ptr, byval col as integer)
declare sub wxGrid_SetColFormatNumber (byval self as wxGrid ptr, byval col as integer)
declare sub wxGrid_SetColFormatFloat (byval self as wxGrid ptr, byval col as integer, byval width as integer, byval precision as integer)
declare sub wxGrid_SetColFormatCustom (byval self as wxGrid ptr, byval col as integer, byval typeName as zstring ptr)
declare sub wxGrid_EnableGridLines (byval self as wxGrid ptr, byval enable as integer)
declare function wxGrid_GridLinesEnabled (byval self as wxGrid ptr) as integer
declare function wxGrid_GetDefaultRowSize (byval self as wxGrid ptr) as integer
declare function wxGrid_GetRowSize (byval self as wxGrid ptr, byval row as integer) as integer
declare function wxGrid_GetDefaultColSize (byval self as wxGrid ptr) as integer
declare function wxGrid_GetColSize (byval self as wxGrid ptr, byval col as integer) as integer
declare function wxGrid_GetDefaultCellBackgroundColour (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellBackgroundColour (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxColour ptr
declare function wxGrid_GetDefaultCellTextColour (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetCellTextColour (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxColour ptr
declare function wxGrid_GetDefaultCellFont (byval self as wxGrid ptr) as wxFont ptr
declare function wxGrid_GetCellFont (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxFont ptr
declare sub wxGrid_GetDefaultCellAlignment (byval self as wxGrid ptr, byval horiz as integer ptr, byval vert as integer ptr)
declare sub wxGrid_GetCellAlignment (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval horiz as integer ptr, byval vert as integer ptr)
declare function wxGrid_GetDefaultCellOverflow (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCellOverflow (byval self as wxGrid ptr, byval row as integer, byval col as integer) as integer
declare sub wxGrid_GetCellSize (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval num_rows as integer ptr, byval num_cols as integer ptr)
declare sub wxGrid_SetDefaultRowSize (byval self as wxGrid ptr, byval height as integer, byval resizeExistingRows as integer)
declare sub wxGrid_SetRowSize (byval self as wxGrid ptr, byval row as integer, byval height as integer)
declare sub wxGrid_SetDefaultColSize (byval self as wxGrid ptr, byval width as integer, byval resizeExistingCols as integer)
declare sub wxGrid_SetColSize (byval self as wxGrid ptr, byval col as integer, byval width as integer)
declare sub wxGrid_AutoSizeColumn (byval self as wxGrid ptr, byval col as integer, byval setAsMin as integer)
declare sub wxGrid_AutoSizeRow (byval self as wxGrid ptr, byval row as integer, byval setAsMin as integer)
declare sub wxGrid_AutoSizeColumns (byval self as wxGrid ptr, byval setAsMin as integer)
declare sub wxGrid_AutoSizeRows (byval self as wxGrid ptr, byval setAsMin as integer)
declare sub wxGrid_AutoSize (byval self as wxGrid ptr)
declare sub wxGrid_SetColMinimalWidth (byval self as wxGrid ptr, byval col as integer, byval width as integer)
declare sub wxGrid_SetRowMinimalHeight (byval self as wxGrid ptr, byval row as integer, byval width as integer)
declare sub wxGrid_SetColMinimalAcceptableWidth (byval self as wxGrid ptr, byval width as integer)
declare sub wxGrid_SetRowMinimalAcceptableHeight (byval self as wxGrid ptr, byval width as integer)
declare function wxGrid_GetColMinimalAcceptableWidth (byval self as wxGrid ptr) as integer
declare function wxGrid_GetRowMinimalAcceptableHeight (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetDefaultCellBackgroundColour (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetDefaultCellTextColour (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetDefaultCellFont (byval self as wxGrid ptr, byval font as wxFont ptr)
declare sub wxGrid_SetCellFont (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval font as wxFont ptr)
declare sub wxGrid_SetDefaultCellAlignment (byval self as wxGrid ptr, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetCellAlignmentHV (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval horiz as integer, byval vert as integer)
declare sub wxGrid_SetDefaultCellOverflow (byval self as wxGrid ptr, byval allow as integer)
declare sub wxGrid_SetCellOverflow (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval allow as integer)
declare sub wxGrid_SetCellSize (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval num_rows as integer, byval num_cols as integer)
declare sub wxGrid_SetDefaultRenderer (byval self as wxGrid ptr, byval renderer as wxGridCellRenderer ptr)
declare sub wxGrid_SetCellRenderer (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval renderer as wxGridCellRenderer ptr)
declare function wxGrid_GetDefaultRenderer (byval self as wxGrid ptr) as wxGridCellRenderer ptr
declare function wxGrid_GetCellRenderer (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellRenderer ptr
declare sub wxGrid_SetDefaultEditor (byval self as wxGrid ptr, byval editor as wxGridCellEditor ptr)
declare sub wxGrid_SetCellEditor (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval editor as wxGridCellEditor ptr)
declare function wxGrid_GetDefaultEditor (byval self as wxGrid ptr) as wxGridCellEditor ptr
declare function wxGrid_GetCellEditor (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellEditor ptr
declare function wxGrid_GetCellValue (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxString ptr
declare sub wxGrid_SetCellValue (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval s as zstring ptr)
declare function wxGrid_IsReadOnly (byval self as wxGrid ptr, byval row as integer, byval col as integer) as integer
declare sub wxGrid_SetReadOnly (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval isReadOnly as integer)
declare sub wxGrid_SelectRow (byval self as wxGrid ptr, byval row as integer, byval addToSelected as integer)
declare sub wxGrid_SelectCol (byval self as wxGrid ptr, byval col as integer, byval addToSelected as integer)
declare sub wxGrid_SelectBlock (byval self as wxGrid ptr, byval topRow as integer, byval leftCol as integer, byval bottomRow as integer, byval rightCol as integer, byval addToSelected as integer)
declare sub wxGrid_SelectAll (byval self as wxGrid ptr)
declare function wxGrid_IsSelection (byval self as wxGrid ptr) as integer
declare sub wxGrid_DeselectRow (byval self as wxGrid ptr, byval row as integer)
declare sub wxGrid_DeselectCol (byval self as wxGrid ptr, byval col as integer)
declare sub wxGrid_DeselectCell (byval self as wxGrid ptr, byval row as integer, byval col as integer)
declare sub wxGrid_ClearSelection (byval self as wxGrid ptr)
declare function wxGrid_IsInSelection (byval self as wxGrid ptr, byval row as integer, byval col as integer) as integer
declare sub wxGrid_BlockToDeviceRect (byval self as wxGrid ptr, byval topLeft as wxGridCellCoords ptr, byval bottomRight as wxGridCellCoords ptr, byval rc as wxRect ptr)
declare function wxGrid_GetSelectionBackground (byval self as wxGrid ptr) as wxColour ptr
declare function wxGrid_GetSelectionForeground (byval self as wxGrid ptr) as wxColour ptr
declare sub wxGrid_SetSelectionBackground (byval self as wxGrid ptr, byval c as wxColour ptr)
declare sub wxGrid_SetSelectionForeground (byval self as wxGrid ptr, byval c as wxColour ptr)
declare sub wxGrid_RegisterDataType (byval self as wxGrid ptr, byval typeName as zstring ptr, byval renderer as wxGridCellRenderer ptr, byval editor as wxGridCellEditor ptr)
declare function wxGrid_GetDefaultEditorForCell (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellEditor ptr
declare function wxGrid_GetDefaultRendererForCell (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellRenderer ptr
declare function wxGrid_GetDefaultEditorForType (byval self as wxGrid ptr, byval typeName as zstring ptr) as wxGridCellEditor ptr
declare function wxGrid_GetDefaultRendererForType (byval self as wxGrid ptr, byval typeName as zstring ptr) as wxGridCellRenderer ptr
declare sub wxGrid_SetMargins (byval self as wxGrid ptr, byval extraWidth as integer, byval extraHeight as integer)
declare function wxGrid_GetGridWindow (byval self as wxGrid ptr) as wxWindow ptr
declare function wxGrid_GetGridRowLabelWindow (byval self as wxGrid ptr) as wxWindow ptr
declare function wxGrid_GetGridColLabelWindow (byval self as wxGrid ptr) as wxWindow ptr
declare function wxGrid_GetGridCornerLabelWindow (byval self as wxGrid ptr) as wxWindow ptr
declare sub wxGrid_UpdateDimensions (byval self as wxGrid ptr)
declare function wxGrid_GetRows (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCols (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCursorRow (byval self as wxGrid ptr) as integer
declare function wxGrid_GetCursorColumn (byval self as wxGrid ptr) as integer
declare function wxGrid_GetScrollPosX (byval self as wxGrid ptr) as integer
declare function wxGrid_GetScrollPosY (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetScrollX (byval self as wxGrid ptr, byval x as integer)
declare sub wxGrid_SetScrollY (byval self as wxGrid ptr, byval y as integer)
declare sub wxGrid_SetColumnWidth (byval self as wxGrid ptr, byval col as integer, byval width as integer)
declare function wxGrid_GetColumnWidth (byval self as wxGrid ptr, byval col as integer) as integer
declare sub wxGrid_SetRowHeight (byval self as wxGrid ptr, byval row as integer, byval height as integer)
declare function wxGrid_GetViewHeight (byval self as wxGrid ptr) as integer
declare function wxGrid_GetViewWidth (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetLabelSize (byval self as wxGrid ptr, byval orientation as integer, byval sz as integer)
declare function wxGrid_GetLabelSize (byval self as wxGrid ptr, byval orientation as integer) as integer
declare sub wxGrid_SetLabelAlignment (byval self as wxGrid ptr, byval orientation as integer, byval align as integer)
declare function wxGrid_GetLabelAlignment (byval self as wxGrid ptr, byval orientation as integer, byval align as integer) as integer
declare sub wxGrid_SetLabelValue (byval self as wxGrid ptr, byval orientation as integer, byval val as zstring ptr, byval pos as integer)
declare function wxGrid_GetLabelValue (byval self as wxGrid ptr, byval orientation as integer, byval pos as integer) as wxString ptr
declare function wxGrid_GetCellTextFontGrid (byval self as wxGrid ptr) as wxFont ptr
declare function wxGrid_GetCellTextFont (byval self as wxGrid ptr, byval row as integer, byval col as integer) as wxFont ptr
declare sub wxGrid_SetCellTextFontGrid (byval self as wxGrid ptr, byval fnt as wxFont ptr)
declare sub wxGrid_SetCellTextFont (byval self as wxGrid ptr, byval fnt as wxFont ptr, byval row as integer, byval col as integer)
declare sub wxGrid_SetCellTextColour (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval val as wxColour ptr)
declare sub wxGrid_SetCellTextColourGrid (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellBackgroundColourGrid (byval self as wxGrid ptr, byval col as wxColour ptr)
declare sub wxGrid_SetCellBackgroundColour (byval self as wxGrid ptr, byval row as integer, byval col as integer, byval colour as wxColour ptr)
declare function wxGrid_GetEditable (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetEditable (byval self as wxGrid ptr, byval edit as integer)
declare function wxGrid_GetEditInPlace (byval self as wxGrid ptr) as integer
declare sub wxGrid_SetCellAlignment (byval self as wxGrid ptr, byval align as integer, byval row as integer, byval col as integer)
declare sub wxGrid_SetCellAlignmentGrid (byval self as wxGrid ptr, byval align as integer)
declare sub wxGrid_SetCellBitmap (byval self as wxGrid ptr, byval bitmap as wxBitmap ptr, byval row as integer, byval col as integer)
declare sub wxGrid_SetDividerPen (byval self as wxGrid ptr, byval pen as wxPen ptr)
declare function wxGrid_GetDividerPen (byval self as wxGrid ptr) as wxPen ptr
declare sub wxGrid_OnActivate (byval self as wxGrid ptr, byval active as integer)
declare function wxGrid_GetRowHeight (byval self as wxGrid ptr, byval row as integer) as integer
declare function wxGridCellCoords alias "wxGridCellCoords_ctor" () as wxGridCellCoords ptr
declare sub wxGridCellCoords_dtor (byval self as wxGridCellCoords ptr)
declare function wxGridCellCoords_GetRow (byval self as wxGridCellCoords ptr) as integer
declare sub wxGridCellCoords_SetRow (byval self as wxGridCellCoords ptr, byval n as integer)
declare function wxGridCellCoords_GetCol (byval self as wxGridCellCoords ptr) as integer
declare sub wxGridCellCoords_SetCol (byval self as wxGridCellCoords ptr, byval n as integer)
declare sub wxGridCellCoords_Set (byval self as wxGridCellCoords ptr, byval row as integer, byval col as integer)
declare function wxGridCellAttr alias "wxGridCellAttr_ctor" (byval colText as wxColour ptr, byval colBack as wxColour ptr, byval font as wxFont ptr, byval hAlign as integer, byval vAlign as integer) as wxGridCellAttr ptr
declare function wxGridCellAttr_ctor2 () as wxGridCellAttr ptr
declare function wxGridCellAttr_ctor3 (byval attrDefault as wxGridCellAttr ptr) as wxGridCellAttr ptr
declare function wxGridCellAttr_Clone (byval self as wxGridCellAttr ptr) as wxGridCellAttr ptr
declare sub wxGridCellAttr_MergeWith (byval self as wxGridCellAttr ptr, byval mergefrom as wxGridCellAttr ptr)
declare sub wxGridCellAttr_IncRef (byval self as wxGridCellAttr ptr)
declare sub wxGridCellAttr_DecRef (byval self as wxGridCellAttr ptr)
declare sub wxGridCellAttr_SetTextColour (byval self as wxGridCellAttr ptr, byval colText as wxColour ptr)
declare sub wxGridCellAttr_SetBackgroundColour (byval self as wxGridCellAttr ptr, byval colBack as wxColour ptr)
declare sub wxGridCellAttr_SetFont (byval self as wxGridCellAttr ptr, byval font as wxFont ptr)
declare sub wxGridCellAttr_SetAlignment (byval self as wxGridCellAttr ptr, byval hAlign as integer, byval vAlign as integer)
declare sub wxGridCellAttr_SetSize (byval self as wxGridCellAttr ptr, byval num_rows as integer, byval num_cols as integer)
declare sub wxGridCellAttr_SetOverflow (byval self as wxGridCellAttr ptr, byval allow as integer)
declare sub wxGridCellAttr_SetReadOnly (byval self as wxGridCellAttr ptr, byval isReadOnly as integer)
declare sub wxGridCellAttr_SetRenderer (byval self as wxGridCellAttr ptr, byval renderer as wxGridCellRenderer ptr)
declare sub wxGridCellAttr_SetEditor (byval self as wxGridCellAttr ptr, byval editor as wxGridCellEditor ptr)
declare function wxGridCellAttr_HasTextColour (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasBackgroundColour (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasFont (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasAlignment (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasRenderer (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasEditor (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_HasReadWriteMode (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_GetTextColour (byval self as wxGridCellAttr ptr) as wxColour ptr
declare function wxGridCellAttr_GetBackgroundColour (byval self as wxGridCellAttr ptr) as wxColour ptr
declare function wxGridCellAttr_GetFont (byval self as wxGridCellAttr ptr) as wxFont ptr
declare sub wxGridCellAttr_GetAlignment (byval self as wxGridCellAttr ptr, byval hAlign as integer ptr, byval vAlign as integer ptr)
declare sub wxGridCellAttr_GetSize (byval self as wxGridCellAttr ptr, byval num_rows as integer ptr, byval num_cols as integer ptr)
declare function wxGridCellAttr_GetOverflow (byval self as wxGridCellAttr ptr) as integer
declare function wxGridCellAttr_GetRenderer (byval self as wxGridCellAttr ptr, byval grid as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellRenderer ptr
declare function wxGridCellAttr_GetEditor (byval self as wxGridCellAttr ptr, byval grid as wxGrid ptr, byval row as integer, byval col as integer) as wxGridCellEditor ptr
declare function wxGridCellAttr_IsReadOnly (byval self as wxGridCellAttr ptr) as integer
declare sub wxGridCellAttr_SetDefAttr (byval self as wxGridCellAttr ptr, byval defAttr as wxGridCellAttr ptr)
declare function wxGridSizeEvent alias "wxGridSizeEvent_ctor" () as wxGridSizeEvent ptr
declare function wxGridSizeEvent_ctorParam (byval id as integer, byval type as wxEventType, byval obj as wxObject ptr, byval rowOrCol as integer, byval x as integer, byval y as integer, byval control as integer, byval shift as integer, byval alt as integer, byval meta as integer) as wxGridSizeEvent ptr
declare function wxGridSizeEvent_GetRowOrCol (byval self as wxGridSizeEvent ptr) as integer
declare sub wxGridSizeEvent_GetPosition (byval self as wxGridSizeEvent ptr, byval pt as wxPoint ptr)
declare function wxGridSizeEvent_ControlDown (byval self as wxGridSizeEvent ptr) as integer
declare function wxGridSizeEvent_MetaDown (byval self as wxGridSizeEvent ptr) as integer
declare function wxGridSizeEvent_ShiftDown (byval self as wxGridSizeEvent ptr) as integer
declare function wxGridSizeEvent_AltDown (byval self as wxGridSizeEvent ptr) as integer
declare sub wxGridSizeEvent_Veto (byval self as wxGridSizeEvent ptr)
declare sub wxGridSizeEvent_Allow (byval self as wxGridSizeEvent ptr)
declare function wxGridSizeEvent_IsAllowed (byval self as wxGridSizeEvent ptr) as integer

type Virtual_Create as sub WXCALL (byval as wxWindow ptr, byval as wxWindowID, byval as wxEvtHandler ptr)
type Virtual_BeginEdit as sub WXCALL (byval as integer, byval as integer, byval as wxGrid ptr)
type Virtual_EndEdit as function WXCALL (byval as integer, byval as integer, byval as wxGrid ptr) as integer
type Virtual_Reset as sub WXCALL ( )
type Virtual_Clone as function WXCALL ( ) as wxGridCellEditor ptr
type Virtual_SetSize as sub WXCALL (byval as wxRect ptr)
type Virtual_Show as sub WXCALL (byval as integer, byval as wxGridCellAttr ptr)
type Virtual_PaintBackground as sub WXCALL (byval as wxRect ptr, byval as wxGridCellAttr ptr)
type Virtual_IsAcceptedKey as function WXCALL (byval as wxKeyEvent ptr) as integer
type Virtual_StartingKey as sub WXCALL (byval as wxKeyEvent ptr)
type Virtual_StartingClick as sub WXCALL ( )
type Virtual_HandleReturn as sub WXCALL (byval as wxKeyEvent ptr)
type Virtual_Destroy as sub WXCALL ( )
type Virtual_GetValue as function WXCALL ( ) as byte

declare sub wxGridCellEditor_RegisterVirtual (byval self as _GridCellEditor ptr, byval create as Virtual_Create, byval beginEdit as Virtual_BeginEdit, byval endEdit as Virtual_EndEdit, byval reset as Virtual_Reset, byval clone as Virtual_Clone, byval setSize as Virtual_SetSize, byval show as Virtual_Show, byval paintBackground as Virtual_PaintBackground, byval isAcceptedKey as Virtual_IsAcceptedKey, byval startingKey as Virtual_StartingKey, byval startingClick as Virtual_StartingClick, byval handleReturn as Virtual_HandleReturn, byval destroy as Virtual_Destroy, byval getvalue as Virtual_GetValue)
declare function wxGridCellEditor alias "wxGridCellEditor_ctor" () as wxGridCellEditor ptr
declare sub wxGridCellEditor_dtor (byval self as _GridCellEditor ptr)
declare sub wxGridCellEditor_Create (byval self as _GridCellEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare function wxGridCellEditor_IsCreated (byval self as _GridCellEditor ptr) as integer
declare function wxGridCellEditor_IsAcceptedKey (byval self as _GridCellEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellEditor_SetSize (byval self as _GridCellEditor ptr, byval rect as wxRect ptr)
declare sub wxGridCellEditor_Show (byval self as _GridCellEditor ptr, byval show as integer, byval attr as wxGridCellAttr ptr)
declare sub wxGridCellEditor_PaintBackground (byval self as _GridCellEditor ptr, byval rectCell as wxRect ptr, byval attr as wxGridCellAttr ptr)
declare sub wxGridCellEditor_StartingKey (byval self as _GridCellEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellEditor_StartingClick (byval self as _GridCellEditor ptr)
declare sub wxGridCellEditor_HandleReturn (byval self as _GridCellEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellEditor_Destroy (byval self as _GridCellEditor ptr)

type Virtual_GetNumberRows as function WXCALL ( ) as integer
type Virtual_GetNumberCols as function WXCALL ( ) as integer
type Virtual_IsEmptyCell as function WXCALL (byval as integer, byval as integer) as integer
type Virtual_GetValue2 as function WXCALL (byval as integer, byval as integer) as byte
type Virtual_SetValue as sub WXCALL (byval as integer, byval as integer, byval as wxString ptr)
type Virtual_CanGetValueAs as function WXCALL (byval as integer, byval as integer, byval as wxString ptr) as integer
type Virtual_GetValueAsLong as function WXCALL (byval as integer, byval as integer) as integer
type Virtual_GetValueAsDouble as function WXCALL (byval as integer, byval as integer) as double
type Virtual_SetValueAsLong as sub WXCALL (byval as integer, byval as integer, byval as integer)
type Virtual_SetValueAsDouble as sub WXCALL (byval as integer, byval as integer, byval as double)
type Virtual_SetValueAsBool as sub WXCALL (byval as integer, byval as integer, byval as integer)
type Virtual_GetValueAsCustom as sub WXCALL (byval as integer, byval as integer, byval as wxString ptr)
type Virtual_SetValueAsCustom as sub WXCALL (byval as integer, byval as integer, byval as wxString ptr, byval as any ptr)
type Virtual_GetColLabelValue as function WXCALL (byval as integer) as byte
type Virtual_SetView as sub WXCALL (byval as wxGrid ptr)
type Virtual_GetView as function WXCALL ( ) as wxGrid ptr
type Virtual_Clear as sub WXCALL ( )
type Virtual_InsertRows as function WXCALL (byval as integer, byval as integer) as integer
type Virtual_AppendRows as function WXCALL (byval as integer) as integer
type Virtual_SetRowLabelValue as sub WXCALL (byval as integer, byval as wxString ptr)
type Virtual_SetAttrProvider as sub WXCALL (byval as wxGridCellAttrProvider ptr)
type Virtual_GetAttrProvider as function WXCALL ( ) as wxGridCellAttrProvider ptr
type Virtual_CanHaveAttributes as function WXCALL ( ) as integer
type Virtual_GetAttr as function WXCALL (byval as integer, byval as integer, byval as integer) as wxGridCellAttr ptr
type Virtual_SetAttr as sub WXCALL (byval as wxGridCellAttr ptr, byval as integer, byval as integer)
type Virtual_SetRowAttr as sub WXCALL (byval as wxGridCellAttr ptr, byval as integer)

declare function wxGridTableBase alias "wxGridTableBase_ctor" () as wxGridTableBase ptr
declare sub wxGridTableBase_RegisterVirtual (byval self as _GridTableBase ptr, byval getNumberRows as Virtual_GetNumberRows, byval getNumberCols as Virtual_GetNumberCols, byval isEmptyCell as Virtual_IsEmptyCell, byval getValue as Virtual_GetValue2, byval setValue as Virtual_SetValue, byval getTypeName as Virtual_GetValue2, byval canGetValueAs as Virtual_CanGetValueAs, byval canSetValueAs as Virtual_CanGetValueAs, byval getValueAsLong as Virtual_GetValueAsLong, byval getValueAsDouble as Virtual_GetValueAsDouble, byval getValueAsBool as Virtual_IsEmptyCell, byval setValueAsLong as Virtual_SetValueAsLong, byval setValueAsDouble as Virtual_SetValueAsDouble, byval setValueAsBool as Virtual_SetValueAsBool, byval getValueAsCustom as Virtual_GetValueAsCustom, byval setValueAsCustom as Virtual_SetValueAsCustom, byval setView as Virtual_SetView, byval getView as Virtual_GetView, byval clear as Virtual_Clear, byval insertRows as Virtual_InsertRows, byval appendRows as Virtual_AppendRows, byval deleteRows as Virtual_InsertRows, byval insertCols as Virtual_InsertRows, byval appendCols as Virtual_AppendRows, byval deleteCols as Virtual_InsertRows, byval getRowLabelValue as Virtual_GetColLabelValue, byval getColLabelValue as Virtual_GetColLabelValue, byval setRowLabelValue as Virtual_SetRowLabelValue, byval setColLabelValue as Virtual_SetRowLabelValue, byval setAttrProvider as Virtual_SetAttrProvider, byval getAttrProvider as Virtual_GetAttrProvider, byval canHaveAttributes as Virtual_CanHaveAttributes, byval getAttr as Virtual_GetAttr, byval setAttr as Virtual_SetAttr, byval setRowAttr as Virtual_SetRowAttr, byval setColAttr as Virtual_SetRowAttr)
declare function wxGridTableBase_GetTypeName (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as wxString ptr
declare function wxGridTableBase_CanGetValueAs (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as zstring ptr) as integer
declare function wxGridTableBase_CanSetValueAs (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as zstring ptr) as integer
declare function wxGridTableBase_GetValueAsLong (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as integer
declare function wxGridTableBase_GetValueAsDouble (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as double
declare function wxGridTableBase_GetValueAsBool (byval self as _GridTableBase ptr, byval row as integer, byval col as integer) as integer
declare sub wxGridTableBase_SetValueAsLong (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval value as integer)
declare sub wxGridTableBase_SetValueAsDouble (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval value as double)
declare sub wxGridTableBase_SetValueAsBool (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval value as integer)
declare function wxGridTableBase_GetValueAsCustom (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as zstring ptr) as any ptr
declare sub wxGridTableBase_SetValueAsCustom (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval typeName as zstring ptr, byval value as any ptr)
declare sub wxGridTableBase_SetView (byval self as _GridTableBase ptr, byval grid as wxGrid ptr)
declare function wxGridTableBase_GetView (byval self as _GridTableBase ptr) as wxGrid ptr
declare sub wxGridTableBase_Clear (byval self as _GridTableBase ptr)
declare function wxGridTableBase_InsertRows (byval self as _GridTableBase ptr, byval pos as integer, byval numRows as integer) as integer
declare function wxGridTableBase_AppendRows (byval self as _GridTableBase ptr, byval numRows as integer) as integer
declare function wxGridTableBase_DeleteRows (byval self as _GridTableBase ptr, byval pos as integer, byval numRows as integer) as integer
declare function wxGridTableBase_InsertCols (byval self as _GridTableBase ptr, byval pos as integer, byval numCols as integer) as integer
declare function wxGridTableBase_AppendCols (byval self as _GridTableBase ptr, byval numCols as integer) as integer
declare function wxGridTableBase_DeleteCols (byval self as _GridTableBase ptr, byval pos as integer, byval numCols as integer) as integer
declare function wxGridTableBase_GetRowLabelValue (byval self as _GridTableBase ptr, byval row as integer) as wxString ptr
declare function wxGridTableBase_GetColLabelValue (byval self as _GridTableBase ptr, byval col as integer) as wxString ptr
declare sub wxGridTableBase_SetRowLabelValue (byval self as _GridTableBase ptr, byval row as integer, byval value as zstring ptr)
declare sub wxGridTableBase_SetColLabelValue (byval self as _GridTableBase ptr, byval col as integer, byval value as zstring ptr)
declare sub wxGridTableBase_SetAttrProvider (byval self as _GridTableBase ptr, byval attrProvider as wxGridCellAttrProvider ptr)
declare function wxGridTableBase_GetAttrProvider (byval self as _GridTableBase ptr) as wxGridCellAttrProvider ptr
declare function wxGridTableBase_CanHaveAttributes (byval self as _GridTableBase ptr) as integer
declare function wxGridTableBase_GetAttr (byval self as _GridTableBase ptr, byval row as integer, byval col as integer, byval kind as integer) as wxGridCellAttr ptr
declare sub wxGridTableBase_SetAttr (byval self as _GridTableBase ptr, byval attr as wxGridCellAttr ptr, byval row as integer, byval col as integer)
declare sub wxGridTableBase_SetRowAttr (byval self as _GridTableBase ptr, byval attr as wxGridCellAttr ptr, byval row as integer)
declare sub wxGridTableBase_SetColAttr (byval self as _GridTableBase ptr, byval attr as wxGridCellAttr ptr, byval col as integer)
declare function wxGridCellTextEditor alias "wxGridCellTextEditor_ctor" () as wxGridCellTextEditor ptr
declare sub wxGridCellTextEditor_dtor (byval self as wxGridCellTextEditor ptr)
declare sub wxGridCellTextEditor_Create (byval self as wxGridCellTextEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare sub wxGridCellTextEditor_SetSize (byval self as wxGridCellTextEditor ptr, byval rect as wxRect ptr)
declare sub wxGridCellTextEditor_PaintBackground (byval self as wxGridCellTextEditor ptr, byval rectCell as wxRect ptr, byval attr as wxGridCellAttr ptr)
declare function wxGridCellTextEditor_IsAcceptedKey (byval self as wxGridCellTextEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellTextEditor_BeginEdit (byval self as wxGridCellTextEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellTextEditor_EndEdit (byval self as wxGridCellTextEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellTextEditor_Reset (byval self as wxGridCellTextEditor ptr)
declare sub wxGridCellTextEditor_StartingKey (byval self as wxGridCellTextEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellTextEditor_SetParameters (byval self as wxGridCellTextEditor ptr, byval params as zstring ptr)
declare function wxGridCellTextEditor_Clone (byval self as wxGridCellTextEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellAttrProvider alias "wxGridCellAttrProvider_ctor" () as wxGridCellAttrProvider ptr
declare sub wxGridCellAttrProvider_dtor (byval self as _GridCellAttrProvider ptr)
declare sub wxGridCellAttrProvider_RegisterVirtual (byval self as _GridCellAttrProvider ptr, byval getAttr as Virtual_GetAttr, byval setAttr as Virtual_SetAttr, byval setRowAttr as Virtual_SetRowAttr, byval setColAttr as Virtual_SetRowAttr)
declare function wxGridCellAttrProvider_GetAttr (byval self as _GridCellAttrProvider ptr, byval row as integer, byval col as integer, byval kind as integer) as wxGridCellAttr ptr
declare sub wxGridCellAttrProvider_SetAttr (byval self as _GridCellAttrProvider ptr, byval attr as wxGridCellAttr ptr, byval row as integer, byval col as integer)
declare sub wxGridCellAttrProvider_SetRowAttr (byval self as _GridCellAttrProvider ptr, byval attr as wxGridCellAttr ptr, byval row as integer)
declare sub wxGridCellAttrProvider_SetColAttr (byval self as _GridCellAttrProvider ptr, byval attr as wxGridCellAttr ptr, byval col as integer)
declare sub wxGridCellAttrProvider_UpdateAttrRows (byval self as _GridCellAttrProvider ptr, byval pos as integer, byval numRows as integer)
declare sub wxGridCellAttrProvider_UpdateAttrCols (byval self as _GridCellAttrProvider ptr, byval pos as integer, byval numCols as integer)

declare function wxGridCellNumberEditor alias "wxGridCellNumberEditor_ctor" (byval min as integer, byval max as integer) as wxGridCellNumberEditor ptr
declare sub wxGridCellNumberEditor_dtor (byval self as wxGridCellNumberEditor ptr)
declare sub wxGridCellNumberEditor_RegisterDisposable (byval self as _GridCellNumberEditor ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellNumberEditor_Create (byval self as wxGridCellNumberEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare function wxGridCellNumberEditor_IsAcceptedKey (byval self as wxGridCellNumberEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellNumberEditor_BeginEdit (byval self as wxGridCellNumberEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellNumberEditor_EndEdit (byval self as wxGridCellNumberEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellNumberEditor_Reset (byval self as wxGridCellNumberEditor ptr)
declare sub wxGridCellNumberEditor_StartingKey (byval self as wxGridCellNumberEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellNumberEditor_SetParameters (byval self as wxGridCellNumberEditor ptr, byval params as zstring ptr)
declare function wxGridCellNumberEditor_Clone (byval self as wxGridCellNumberEditor ptr) as wxGridCellEditor ptr
declare function wxGridCellFloatEditor alias "wxGridCellFloatEditor_ctor" (byval width as integer, byval precision as integer) as wxGridCellFloatEditor ptr
declare sub wxGridCellFloatEditor_dtor (byval self as wxGridCellFloatEditor ptr)
declare sub wxGridCellFloatEditor_Create (byval self as wxGridCellFloatEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare function wxGridCellFloatEditor_IsAcceptedKey (byval self as wxGridCellFloatEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellFloatEditor_BeginEdit (byval self as wxGridCellFloatEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellFloatEditor_EndEdit (byval self as wxGridCellFloatEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellFloatEditor_Reset (byval self as wxGridCellFloatEditor ptr)
declare sub wxGridCellFloatEditor_StartingKey (byval self as wxGridCellFloatEditor ptr, byval event as wxKeyEvent ptr)
declare sub wxGridCellFloatEditor_SetParameters (byval self as wxGridCellFloatEditor ptr, byval params as zstring ptr)
declare function wxGridCellFloatEditor_Clone (byval self as wxGridCellFloatEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellBoolEditor alias "wxGridCellBoolEditor_ctor" () as wxGridCellBoolEditor ptr
declare sub wxGridCellBoolEditor_dtor (byval self as wxGridCellBoolEditor ptr)
declare sub wxGridCellBoolEditor_RegisterDisposable (byval self as _GridCellBoolEditor ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellBoolEditor_Create (byval self as wxGridCellBoolEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare sub wxGridCellBoolEditor_SetSize (byval self as wxGridCellBoolEditor ptr, byval rect as wxRect ptr)
declare function wxGridCellBoolEditor_IsAcceptedKey (byval self as wxGridCellBoolEditor ptr, byval event as wxKeyEvent ptr) as integer
declare sub wxGridCellBoolEditor_BeginEdit (byval self as wxGridCellBoolEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellBoolEditor_EndEdit (byval self as wxGridCellBoolEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellBoolEditor_Reset (byval self as wxGridCellBoolEditor ptr)
declare sub wxGridCellBoolEditor_StartingClick (byval self as wxGridCellFloatEditor ptr)
declare function wxGridCellBoolEditor_Clone (byval self as wxGridCellBoolEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellChoiceEditor alias "wxGridCellChoiceEditor_ctor" (byval n as integer, byval choices as byte ptr ptr, byval allowOthers as integer) as wxGridCellChoiceEditor ptr
declare sub wxGridCellChoiceEditor_dtor (byval self as wxGridCellChoiceEditor ptr)
declare sub wxGridCellChoiceEditor_RegisterDisposable (byval self as _GridCellChoiceEditor ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellChoiceEditor_Create (byval self as wxGridCellChoiceEditor ptr, byval parent as wxWindow ptr, byval id as wxWindowID, byval evtHandler as wxEvtHandler ptr)
declare sub wxGridCellChoiceEditor_PaintBackground (byval self as wxGridCellChoiceEditor ptr, byval rect as wxRect ptr, byval attr as wxGridCellAttr ptr)
declare sub wxGridCellChoiceEditor_BeginEdit (byval self as wxGridCellChoiceEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr)
declare function wxGridCellChoiceEditor_EndEdit (byval self as wxGridCellChoiceEditor ptr, byval row as integer, byval col as integer, byval grid as wxGrid ptr) as integer
declare sub wxGridCellChoiceEditor_Reset (byval self as wxGridCellChoiceEditor ptr)
declare sub wxGridCellChoiceEditor_SetParameters (byval self as wxGridCellChoiceEditor ptr, byval params as zstring ptr)
declare function wxGridCellChoiceEditor_Clone (byval self as wxGridCellChoiceEditor ptr) as wxGridCellEditor ptr

declare function wxGridCellStringRenderer alias "wxGridCellStringRenderer_ctor" () as wxGridCellStringRenderer ptr
declare sub wxGridCellStringRenderer_dtor (byval self as wxGridCellStringRenderer ptr)
declare sub wxGridCellStringRenderer_RegisterDisposable (byval self as _GridCellStringRenderer ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellStringRenderer_Draw (byval self as wxGridCellStringRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellStringRenderer_GetBestSize (byval self as wxGridCellStringRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellStringRenderer_Clone (byval self as wxGridCellStringRenderer ptr) as wxGridCellRenderer ptr
declare function wxGridCellNumberRenderer alias "wxGridCellNumberRenderer_ctor" () as wxGridCellNumberRenderer ptr
declare sub wxGridCellNumberRenderer_dtor (byval self as wxGridCellNumberRenderer ptr)
declare sub wxGridCellNumberRenderer_Draw (byval self as wxGridCellNumberRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellNumberRenderer_GetBestSize (byval self as wxGridCellNumberRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellNumberRenderer_Clone (byval self as wxGridCellNumberRenderer ptr) as wxGridCellRenderer ptr
declare function wxGridCellFloatRenderer alias "wxGridCellFloatRenderer_ctor" (byval width as integer, byval precision as integer) as wxGridCellFloatRenderer ptr
declare sub wxGridCellFloatRenderer_dtor (byval self as wxGridCellFloatRenderer ptr)
declare sub wxGridCellFloatRenderer_Draw (byval self as wxGridCellFloatRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellFloatRenderer_GetBestSize (byval self as wxGridCellFloatRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellFloatRenderer_Clone (byval self as wxGridCellFloatRenderer ptr) as wxGridCellRenderer ptr
declare function wxGridCellFloatRenderer_GetWidth (byval self as wxGridCellFloatRenderer ptr) as integer
declare sub wxGridCellFloatRenderer_SetWidth (byval self as wxGridCellFloatRenderer ptr, byval width as integer)
declare function wxGridCellFloatRenderer_GetPrecision (byval self as wxGridCellFloatRenderer ptr) as integer
declare sub wxGridCellFloatRenderer_SetPrecision (byval self as wxGridCellFloatRenderer ptr, byval precision as integer)
declare sub wxGridCellFloatRenderer_SetParameters (byval self as wxGridCellFloatRenderer ptr, byval params as zstring ptr)

declare function wxGridCellBoolRenderer alias "wxGridCellBoolRenderer_ctor" () as wxGridCellBoolRenderer ptr
declare sub wxGridCellBoolRenderer_dtor (byval self as wxGridCellBoolRenderer ptr)
declare sub wxGridCellBoolRenderer_RegisterDisposable (byval self as _GridCellBoolRenderer ptr, byval onDispose as Virtual_Dispose)
declare sub wxGridCellBoolRenderer_Draw (byval self as wxGridCellBoolRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval rect as wxRect ptr, byval row as integer, byval col as integer, byval isSelected as integer)
declare sub wxGridCellBoolRenderer_GetBestSize (byval self as wxGridCellBoolRenderer ptr, byval grid as wxGrid ptr, byval attr as wxGridCellAttr ptr, byval dc as wxDC ptr, byval row as integer, byval col as integer, byval size as wxSize ptr)
declare function wxGridCellBoolRenderer_Clone (byval self as wxGridCellBoolRenderer ptr) as wxGridCellRenderer ptr

type Virtual_Draw as sub WXCALL (byval as wxGrid ptr, byval as wxGridCellAttr ptr, byval as wxDC ptr, byval as wxRect ptr, byval as integer, byval as integer, byval as integer)
type Virtual_GetBestSize as function WXCALL (byval as wxGrid ptr, byval as wxGridCellAttr ptr, byval as wxDC ptr, byval as integer, byval as integer) as wxSize
type Virtual_RendererClone as function WXCALL ( ) as wxGridCellRenderer ptr

declare function wxGridCellRenderer alias "wxGridCellRenderer_ctor" () as wxGridCellRenderer ptr
declare sub wxGridCellRenderer_dtor (byval self as _GridCellRenderer ptr)
declare sub wxGridCellRenderer_RegisterVirtual (byval self as _GridCellRenderer ptr, byval draw as Virtual_Draw, byval getBestSize as Virtual_GetBestSize, byval clone as Virtual_RendererClone)

#endif
