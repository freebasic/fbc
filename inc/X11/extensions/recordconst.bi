'' FreeBASIC binding for recordproto-1.14.2
''
'' based on the C header files:
''   ************************************************************************
''    Copyright 1995 Network Computing Devices
''
''    Permission to use, copy, modify, distribute, and sell this software and
''    its documentation for any purpose is hereby granted without fee, provided
''    that the above copyright notice appear in all copies and that both that
''    copyright notice and this permission notice appear in supporting
''    documentation, and that the name of Network Computing Devices 
''    not be used in advertising or publicity pertaining to distribution
''    of the software without specific, written prior permission.
''
''    NETWORK COMPUTING DEVICES DISCLAIMs ALL WARRANTIES WITH REGARD TO 
''    THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
''    AND FITNESS, IN NO EVENT SHALL NETWORK COMPUTING DEVICES BE LIABLE 
''    FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES 
''    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN 
''    AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING 
''    OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''   ************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

#define _RECORDCONST_H_
#define RECORD_NAME "RECORD"
const RECORD_MAJOR_VERSION = 1
const RECORD_MINOR_VERSION = 13
const RECORD_LOWEST_MAJOR_VERSION = 1
const RECORD_LOWEST_MINOR_VERSION = 12
const XRecordBadContext = 0
const RecordNumErrors = XRecordBadContext + 1
const RecordNumEvents = cast(clong, 0)
const XRecordFromServerTime = &h01
const XRecordFromClientTime = &h02
const XRecordFromClientSequence = &h04
const XRecordCurrentClients = 1
const XRecordFutureClients = 2
const XRecordAllClients = 3
const XRecordFromServer = 0
const XRecordFromClient = 1
const XRecordClientStarted = 2
const XRecordClientDied = 3
const XRecordStartOfData = 4
const XRecordEndOfData = 5
