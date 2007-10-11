''
''
'' evcode -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_evcode_bi__
#define __win_evcode_bi__

#define EC_SYSTEMBASE &h00
#define EC_USER &h8000
#define EC_COMPLETE &h01
#define EC_USERABORT &h02
#define EC_ERRORABORT &h03
#define EC_TIME &h04
#define EC_REPAINT &h05
#define EC_STREAM_ERROR_STOPPED &h06
#define EC_STREAM_ERROR_STILLPLAYING &h07
#define EC_ERROR_STILLPLAYING &h08
#define EC_PALETTE_CHANGED &h09
#define EC_VIDEO_SIZE_CHANGED &h0A
#define EC_QUALITY_CHANGE &h0B
#define EC_SHUTTING_DOWN &h0C
#define EC_CLOCK_CHANGED &h0D
#define EC_PAUSED &h0E
#define EC_OPENING_FILE &h10
#define EC_BUFFERING_DATA &h11
#define EC_FULLSCREEN_LOST &h12
#define EC_ACTIVATE &h13
#define EC_NEED_RESTART &h14
#define EC_WINDOW_DESTROYED &h15
#define EC_DISPLAY_CHANGED &h16
#define EC_STARVATION &h17
#define EC_OLE_EVENT &h18
#define EC_NOTIFY_WINDOW &h19
#define EC_STREAM_CONTROL_STOPPED &h1A
#define EC_STREAM_CONTROL_STARTED &h1B
#define EC_END_OF_SEGMENT &h1C
#define EC_SEGMENT_STARTED &h1D
#define EC_LENGTH_CHANGED &h1E
#define EC_DEVICE_LOST &h1f
#define EC_STEP_COMPLETE &h24
#define EC_TIMECODE_AVAILABLE &h30
#define EC_EXTDEVICE_MODE_CHANGE &h31
#define EC_STATE_CHANGE &h32
#define EC_GRAPH_CHANGED &h50
#define EC_CLOCK_UNSET &h51
#define EC_VMR_RENDERDEVICE_SET &h53
#define VMR_RENDER_DEVICE_OVERLAY &h01
#define VMR_RENDER_DEVICE_VIDMEM &h02
#define VMR_RENDER_DEVICE_SYSMEM &h04
#define EC_VMR_SURFACE_FLIPPED &h54
#define EC_VMR_RECONNECTION_FAILED &h55
#define EC_PREPROCESS_COMPLETE &h56
#define EC_CODECAPI_EVENT &h57

#ifndef AM_WMT_EVENT_DATA
type AM_WMT_EVENT_DATA
	hrStatus as HRESULT
	pData as any ptr
end type
#endif

#define EC_WMT_EVENT_BASE &h0251
#define EC_WMT_INDEX_EVENT &h0251
#define EC_WMT_EVENT &h0251+1
#define EC_BUILT &h300
#define EC_UNBUILT &h301

#endif
