#pragma once

#include once "crt/long.bi"

#define _RECORDCONST_H_
#define RECORD_NAME "RECORD"
const RECORD_MAJOR_VERSION = 1
const RECORD_MINOR_VERSION = 13
const RECORD_LOWEST_MAJOR_VERSION = 1
const RECORD_LOWEST_MINOR_VERSION = 12
const XRecordBadContext = 0
#define RecordNumErrors (XRecordBadContext + 1)
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
