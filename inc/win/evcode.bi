'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2004 Christian Costa
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define __WINE_EVCODE_H
const EC_SYSTEMBASE = &h00
const EC_USER = &h8000
const EC_COMPLETE = &h01
const EC_USERABORT = &h02
const EC_ERRORABORT = &h03
const EC_TIME = &h04
const EC_REPAINT = &h05
const EC_STREAM_ERROR_STOPPED = &h06
const EC_STREAM_ERROR_STILLPLAYING = &h07
const EC_ERROR_STILLPLAYING = &h08
const EC_PALETTE_CHANGED = &h09
const EC_VIDEO_SIZE_CHANGED = &h0A
const EC_QUALITY_CHANGE = &h0B
const EC_SHUTTING_DOWN = &h0C
const EC_CLOCK_CHANGED = &h0D
const EC_PAUSED = &h0E
const EC_OPENING_FILE = &h10
const EC_BUFFERING_DATA = &h11
const EC_FULLSCREEN_LOST = &h12
const EC_ACTIVATE = &h13
const EC_NEED_RESTART = &h14
const EC_WINDOW_DESTROYED = &h15
const EC_DISPLAY_CHANGED = &h16
const EC_STARVATION = &h17
const EC_OLE_EVENT = &h18
const EC_NOTIFY_WINDOW = &h19
const EC_STREAM_CONTROL_STOPPED = &h1A
const EC_STREAM_CONTROL_STARTED = &h1B
const EC_END_OF_SEGMENT = &h1C
const EC_SEGMENT_STARTED = &h1D
const EC_LENGTH_CHANGED = &h1E
const EC_DEVICE_LOST = &h1F
const EC_SAMPLE_NEEDED = &h20
const EC_PROCESSING_LATENCY = &h21
const EC_SAMPLE_LATENCY = &h22
const EC_SCRUB_TIME = &h23
const EC_STEP_COMPLETE = &h24
const EC_NEW_PIN = &h20
const EC_RENDER_FINISHED = &h21
const EC_TIMECODE_AVAILABLE = &h30
const EC_EXTDEVICE_MODE_CHANGE = &h31
const EC_STATE_CHANGE = &h32
const EC_PLEASE_REOPEN = &h40
const EC_STATUS = &h41
const EC_MARKER_HIT = &h42
const EC_LOADSTATUS = &h43
const EC_FILE_CLOSED = &h44
const EC_ERRORABORTEX = &h45
const EC_EOS_SOON = &h46
const EC_CONTENTPROPERTY_CHANGED = &h47
const EC_BANDWIDTHCHANGE = &h48
const EC_VIDEOFRAMEREADY = &h49
const EC_GRAPH_CHANGED = &h50
const EC_CLOCK_UNSET = &h51
const EC_VMR_RENDERDEVICE_SET = &h53
const EC_VMR_SURFACE_FLIPPED = &h54
const EC_VMR_RECONNECTION_FAILED = &h55
const EC_PREPROCESS_COMPLETE = &h56
const EC_CODECAPI_EVENT = &h57
const EC_BUILT = &h300
const EC_UNBUILT = &h301
const EC_WMT_EVENT_BASE = &h0251
const EC_WMT_INDEX_EVENT = EC_WMT_EVENT_BASE
const EC_WMT_EVENT = EC_WMT_EVENT_BASE + 1
