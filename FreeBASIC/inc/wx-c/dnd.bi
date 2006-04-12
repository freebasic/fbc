''
''
'' dnd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_dnd_bi__
#define __wxc_dnd_bi__

#include once "wx-c/wx.bi"


type Virtual_DoDragDrop as function (byval as integer) as wxDragResult

declare function wxDropSource_Win cdecl alias "wxDropSource_Win_ctor" (byval win as wxWindow ptr) as wxDropSource ptr
declare function wxDropSource_DataObject cdecl alias "wxDropSource_DataObject_ctor" (byval dataObject as wxDataObject ptr, byval win as wxWindow ptr) as wxDropSource ptr
declare sub wxDropSource_dtor cdecl alias "wxDropSource_dtor" (byval self as _DropSource ptr)
declare sub wxDropSource_RegisterVirtual cdecl alias "wxDropSource_RegisterVirtual" (byval self as _DropSource ptr, byval doDragDrop as Virtual_DoDragDrop)
declare function wxDropSource_DoDragDrop cdecl alias "wxDropSource_DoDragDrop" (byval self as _DropSource ptr, byval flags as integer) as integer
declare sub wxDropSource_SetData cdecl alias "wxDropSource_SetData" (byval self as _DropSource ptr, byval data as wxDataObject ptr)
declare function wxDropSource_GetDataObject cdecl alias "wxDropSource_GetDataObject" (byval self as _DropSource ptr) as wxDataObject ptr
declare sub wxDropSource_SetCursor cdecl alias "wxDropSource_SetCursor" (byval self as _DropSource ptr, byval res as wxDragResult ptr, byval cursor as wxCursor ptr)
declare function wxDropSource_GiveFeedback cdecl alias "wxDropSource_GiveFeedback" (byval self as _DropSource ptr, byval effect as wxDragResult ptr) as integer

type Virtual_OnDragOver as function (byval as wxCoord, byval as wxCoord, byval as wxDragResult) as wxDragResult
type Virtual_OnDrop as function (byval as wxCoord, byval as wxCoord) as integer
type Virtual_OnData3 as function (byval as wxCoord, byval as wxCoord, byval as wxDragResult) as wxDragResult
type Virtual_GetData as function ( ) as integer
type Virtual_OnLeave as sub ( )
type Virtual_OnEnter as function (byval as wxCoord, byval as wxCoord, byval as wxDragResult) as wxDragResult

declare function wxDropTarget cdecl alias "wxDropTarget_ctor" (byval dataObject as wxDataObject ptr) as wxDropTarget ptr
declare sub wxDropTarget_dtor cdecl alias "wxDropTarget_dtor" (byval self as _DropTarget ptr)
declare sub wxDropTarget_RegisterVirtual cdecl alias "wxDropTarget_RegisterVirtual" (byval self as _DropTarget ptr, byval onDragOver as Virtual_OnDragOver, byval onDrop as Virtual_OnDrop, byval onData as Virtual_OnData3, byval getData as Virtual_GetData, byval onLeave as Virtual_OnLeave, byval onEnter as Virtual_OnEnter)
declare sub wxDropTarget_RegisterDisposable cdecl alias "wxDropTarget_RegisterDisposable" (byval self as _DropTarget ptr, byval onDispose as Virtual_Dispose)
declare sub wxDropTarget_SetDataObject cdecl alias "wxDropTarget_SetDataObject" (byval self as _DropTarget ptr, byval dataObject as wxDataObject ptr)
declare function wxDropTarget_OnEnter cdecl alias "wxDropTarget_OnEnter" (byval self as _DropTarget ptr, byval x as wxCoord, byval y as wxCoord, byval def as wxDragResult) as wxDragResult
declare function wxDropTarget_OnDragOver cdecl alias "wxDropTarget_OnDragOver" (byval self as _DropTarget ptr, byval x as wxCoord, byval y as wxCoord, byval def as wxDragResult) as wxDragResult
declare sub wxDropTarget_OnLeave cdecl alias "wxDropTarget_OnLeave" (byval self as _DropTarget ptr)
declare function wxDropTarget_OnDrop cdecl alias "wxDropTarget_OnDrop" (byval self as _DropTarget ptr, byval x as wxCoord, byval y as wxCoord) as integer
declare function wxDropTarget_GetData cdecl alias "wxDropTarget_GetData" (byval self as _DropTarget ptr) as integer

type Virtual_OnDropText as function (byval as wxCoord, byval as wxCoord, byval as wxString ptr) as integer
type Virtual_OnData as function (byval as wxCoord, byval as wxCoord, byval as wxDragResult) as wxDragResult

declare function wxTextDropTarget cdecl alias "wxTextDropTarget_ctor" () as wxTextDropTarget ptr
declare sub wxTextDropTarget_RegisterVirtual cdecl alias "wxTextDropTarget_RegisterVirtual" (byval self as _TextDropTarget ptr, byval onDropText as Virtual_OnDropText, byval onData as Virtual_OnData)
declare function wxTextDropTarget_OnData cdecl alias "wxTextDropTarget_OnData" (byval self as _TextDropTarget ptr, byval x as wxCoord, byval y as wxCoord, byval def as wxDragResult) as wxDragResult
declare function wxTextDropTarget_OnDrop cdecl alias "wxTextDropTarget_OnDrop" (byval self as _TextDropTarget ptr, byval x as integer, byval y as integer) as integer
declare function wxTextDropTarget_GetData cdecl alias "wxTextDropTarget_GetData" (byval self as _TextDropTarget ptr) as integer

type Virtual_OnDropFiles as function (byval as wxCoord, byval as wxCoord, byval as wxArrayString ptr) as integer
type Virtual_OnData2 as function (byval as wxCoord, byval as wxCoord, byval as wxDragResult) as wxDragResult

declare function wxFileDropTarget cdecl alias "wxFileDropTarget_ctor" () as wxFileDropTarget ptr
declare sub wxFileDropTarget_RegisterVirtual cdecl alias "wxFileDropTarget_RegisterVirtual" (byval self as _FileDropTarget ptr, byval onDropFiles as Virtual_OnDropFiles, byval onData as Virtual_OnData2)
declare function wxFileDropTarget_OnData cdecl alias "wxFileDropTarget_OnData" (byval self as _FileDropTarget ptr, byval x as wxCoord, byval y as wxCoord, byval def as wxDragResult) as wxDragResult
declare function wxFileDropTarget_OnDrop cdecl alias "wxFileDropTarget_OnDrop" (byval self as _FileDropTarget ptr, byval x as integer, byval y as integer) as integer
declare function wxFileDropTarget_GetData cdecl alias "wxFileDropTarget_GetData" (byval self as _FileDropTarget ptr) as integer

#endif
