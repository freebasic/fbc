''
''
'' dvdevcod -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dvdevcod_bi__
#define __win_dvdevcod_bi__

#define EC_DVDBASE &h0100

enum DVD_ERROR
	DVD_ERROR_Unexpected = 1
	DVD_ERROR_CopyProtectFail = 2
	DVD_ERROR_InvalidDVD1_0Disc = 3
	DVD_ERROR_InvalidDiscRegion = 4
	DVD_ERROR_LowParentalLevel = 5
	DVD_ERROR_MacrovisionFail = 6
	DVD_ERROR_IncompatibleSystemAndDecoderRegions = 7
	DVD_ERROR_IncompatibleDiscAndDecoderRegions = 8
end enum

enum DVD_WARNING
	DVD_WARNING_InvalidDVD1_0Disc = 1
	DVD_WARNING_FormatNotSupported = 2
	DVD_WARNING_IllegalNavCommand = 3
	DVD_WARNING_Open = 4
	DVD_WARNING_Seek = 5
	DVD_WARNING_Read = 6
end enum

enum DVD_PB_STOPPED
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

#define EC_DVD_DOMAIN_CHANGE (&h0100+&h01)
#define EC_DVD_TITLE_CHANGE (&h0100+&h02)
#define EC_DVD_CHAPTER_START (&h0100+&h03)
#define EC_DVD_AUDIO_STREAM_CHANGE (&h0100+&h04)
#define EC_DVD_SUBPICTURE_STREAM_CHANGE (&h0100+&h05)
#define EC_DVD_ANGLE_CHANGE (&h0100+&h06)
#define EC_DVD_BUTTON_CHANGE (&h0100+&h07)
#define EC_DVD_VALID_UOPS_CHANGE (&h0100+&h08)
#define EC_DVD_STILL_ON (&h0100+&h09)
#define EC_DVD_STILL_OFF (&h0100+&h0a)
#define EC_DVD_CURRENT_TIME (&h0100+&h&b)
#define EC_DVD_ERROR (&h0100+&h0c)
#define EC_DVD_WARNING (&h0100+&h0d)
#define EC_DVD_CHAPTER_AUTOSTOP (&h0100+&h0e)
#define EC_DVD_NO_FP_PGC (&h0100+&h0f)
#define EC_DVD_PLAYBACK_RATE_CHANGE (&h0100+&h10)
#define EC_DVD_PARENTAL_LEVEL_CHANGE (&h0100+&h11)
#define EC_DVD_PLAYBACK_STOPPED (&h0100+&h12)
#define EC_DVD_ANGLES_AVAILABLE (&h0100+&h13)
#define EC_DVD_PLAYPERIOD_AUTOSTOP (&h0100+&h14)
#define EC_DVD_BUTTON_AUTO_ACTIVATED (&h0100+&h15)
#define EC_DVD_CMD_START (&h0100+&h16)
#define EC_DVD_CMD_END (&h0100+&h17)
#define EC_DVD_DISC_EJECTED (&h0100+&h18)
#define EC_DVD_DISC_INSERTED (&h0100+&h19)
#define EC_DVD_CURRENT_HMSF_TIME (&h0100+&h1a)
#define EC_DVD_KARAOKE_MODE (&h0100+&h1b)

#endif
