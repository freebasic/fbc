'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _DVDEVCOD_H
const EC_DVD_ANGLE_CHANGE = &h0106
const EC_DVD_ANGLES_AVAILABLE = &h0113
const EC_DVD_AUDIO_STREAM_CHANGE = &h0104
const EC_DVD_BUTTON_AUTO_ACTIVATED = &h0115
const EC_DVD_BUTTON_CHANGE = &h0107
const EC_DVD_CHAPTER_AUTOSTOP = &h010E
const EC_DVD_CHAPTER_START = &h0103
const EC_DVD_CMD_START = &h0116
const EC_DVD_CMD_END = &h0117
const EC_DVD_CURRENT_HMSF_TIME = &h011A
const EC_DVD_CURRENT_TIME = &h010B
const EC_DVD_DISC_EJECTED = &h0118
const EC_DVD_DISC_INSERTED = &h0119
const EC_DVD_DOMAIN_CHANGE = &h0101
const EC_DVD_ERROR = &h010C
const EC_DVD_KARAOKE_MODE = &h011B
const EC_DVD_NO_FP_PGC = &h010F
const EC_DVD_PARENTAL_LEVEL_CHANGE = &h0111
const EC_DVD_PLAYBACK_RATE_CHANGE = &h0110
const EC_DVD_PLAYBACK_STOPPED = &h0112
const EC_DVD_PLAYPERIOD_AUTOSTOP = &h0114
const EC_DVD_STILL_OFF = &h010A
const EC_DVD_STILL_ON = &h0109
const EC_DVD_SUBPICTURE_STREAM_CHANGE = &h0105
const EC_DVD_TITLE_CHANGE = &h0102
const EC_DVD_VALID_UOPS_CHANGE = &h0108
const EC_DVD_WARNING = &h010D

type _tagDVD_ERROR as long
enum
	DVD_ERROR_Unexpected = 1
	DVD_ERROR_CopyProtectFail = 2
	DVD_ERROR_InvalidDVD1_0Disc = 3
	DVD_ERROR_InvalidDiscRegion = 4
	DVD_ERROR_LowParentalLevel = 5
	DVD_ERROR_MacrovisionFail = 6
	DVD_ERROR_IncompatibleSystemAndDecoderRegions = 7
	DVD_ERROR_IncompatibleDiscAndDecoderRegions = 8
end enum

type DVD_ERROR as _tagDVD_ERROR

type _tagDVD_PB_STOPPED as long
enum
	DVD_PB_STOPPED_Other = 0
	DVD_PB_STOPPED_NoBranch = 1
	DVD_PB_STOPPED_NoFirstPlayDomain = 2
	DVD_PB_STOPPED_StopCommand = 3
	DVD_PB_STOPPED_Reset = 4
	DVD_PB_STOPPED_DiscEjected = 5
	DVD_PB_STOPPED_IllegalNavCommand = 6
	DVD_PB_STOPPED_PlayPeriodAutoStop = 7
	DVD_PB_STOPPED_PlayChapterAutoStop = 8
	DVD_PB_STOPPED_ParentalFailure = 9
	DVD_PB_STOPPED_RegionFailure = 10
	DVD_PB_STOPPED_MacrovisionFailure = 11
	DVD_PB_STOPPED_DiscReadError = 12
	DVD_PB_STOPPED_CopyProtectFailure = 13
end enum

type DVD_PB_STOPPED as _tagDVD_PB_STOPPED

type _tagDVD_WARNING as long
enum
	DVD_WARNING_InvalidDVD1_0Disc = 1
	DVD_WARNING_FormatNotSupported = 2
	DVD_WARNING_IllegalNavCommand = 3
	DVD_WARNING_Open = 4
	DVD_WARNING_Seek = 5
	DVD_WARNING_Read = 6
end enum

type DVD_WARNING as _tagDVD_WARNING
