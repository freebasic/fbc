''
''
'' dmusicf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmusicf_bi__
#define __win_dmusicf_bi__

#include once "windows.bi"
#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"
#include once "win/mmsystem.bi"

#define DMUS_FOURCC_GUID_CHUNK mmioFOURCC(asc("g"),asc("u"),asc("i"),asc("d"))
#define DMUS_FOURCC_INFO_LIST mmioFOURCC(asc("I"),asc("N"),asc("F"),asc("O"))
#define DMUS_FOURCC_UNFO_LIST mmioFOURCC(asc("U"),asc("N"),asc("F"),asc("O"))
#define DMUS_FOURCC_UNAM_CHUNK mmioFOURCC(asc("U"),asc("N"),asc("A"),asc("M"))
#define DMUS_FOURCC_UART_CHUNK mmioFOURCC(asc("U"),asc("A"),asc("R"),asc("T"))
#define DMUS_FOURCC_UCOP_CHUNK mmioFOURCC(asc("U"),asc("C"),asc("O"),asc("P"))
#define DMUS_FOURCC_USBJ_CHUNK mmioFOURCC(asc("U"),asc("S"),asc("B"),asc("J"))
#define DMUS_FOURCC_UCMT_CHUNK mmioFOURCC(asc("U"),asc("C"),asc("M"),asc("T"))
#define DMUS_FOURCC_CATEGORY_CHUNK mmioFOURCC(asc("c"),asc("a"),asc("t"),asc("g"))
#define DMUS_FOURCC_VERSION_CHUNK mmioFOURCC(asc("v"),asc("e"),asc("r"),asc("s"))

#define DMUS_FOURCC_STYLE_FORM mmioFOURCC(asc("D"),asc("M"),asc("S"),asc("T"))
#define DMUS_FOURCC_STYLE_CHUNK mmioFOURCC(asc("s"),asc("t"),asc("y"),asc("h"))
#define DMUS_FOURCC_PART_LIST mmioFOURCC(asc("p"),asc("a"),asc("r"),asc("t"))
#define DMUS_FOURCC_PART_CHUNK mmioFOURCC(asc("p"),asc("r"),asc("t"),asc("h"))
#define DMUS_FOURCC_NOTE_CHUNK mmioFOURCC(asc("n"),asc("o"),asc("t"),asc("e"))
#define DMUS_FOURCC_CURVE_CHUNK mmioFOURCC(asc("c"),asc("r"),asc("v"),asc("e"))
#define DMUS_FOURCC_MARKER_CHUNK mmioFOURCC(asc("m"),asc("r"),asc("k"),asc("r"))
#define DMUS_FOURCC_RESOLUTION_CHUNK mmioFOURCC(asc("r"),asc("s"),asc("l"),asc("n"))
#define DMUS_FOURCC_ANTICIPATION_CHUNK mmioFOURCC(asc("a"),asc("n"),asc("p"),asc("n"))
#define DMUS_FOURCC_PATTERN_LIST mmioFOURCC(asc("p"),asc("t"),asc("t"),asc("n"))
#define DMUS_FOURCC_PATTERN_CHUNK mmioFOURCC(asc("p"),asc("t"),asc("n"),asc("h"))
#define DMUS_FOURCC_RHYTHM_CHUNK mmioFOURCC(asc("r"),asc("h"),asc("t"),asc("m"))
#define DMUS_FOURCC_PARTREF_LIST mmioFOURCC(asc("p"),asc("r"),asc("e"),asc("f"))
#define DMUS_FOURCC_PARTREF_CHUNK mmioFOURCC(asc("p"),asc("r"),asc("f"),asc("c"))
#define DMUS_FOURCC_STYLE_PERS_REF_LIST mmioFOURCC(asc("p"),asc("r"),asc("r"),asc("f"))
#define DMUS_FOURCC_MOTIFSETTINGS_CHUNK mmioFOURCC(asc("m"),asc("t"),asc("f"),asc("s"))

#define DMUS_FOURCC_PATTERN_FORM mmioFOURCC(asc("D"),asc("M"),asc("P"),asc("T"))

#define DMUS_FOURCC_CHORDTRACK_LIST mmioFOURCC(asc("c"),asc("o"),asc("r"),asc("d"))
#define DMUS_FOURCC_CHORDTRACKHEADER_CHUNK mmioFOURCC(asc("c"),asc("r"),asc("d"),asc("h"))
#define DMUS_FOURCC_CHORDTRACKBODY_CHUNK mmioFOURCC(asc("c"),asc("r"),asc("d"),asc("b"))

#define DMUS_FOURCC_COMMANDTRACK_CHUNK mmioFOURCC(asc("c"),asc("m"),asc("n"),asc("d"))

#define DMUS_FOURCC_TOOLGRAPH_FORM mmioFOURCC(asc("D"),asc("M"),asc("T"),asc("G"))
#define DMUS_FOURCC_TOOL_LIST mmioFOURCC(asc("t"),asc("o"),asc("l"),asc("l"))
#define DMUS_FOURCC_TOOL_FORM mmioFOURCC(asc("D"),asc("M"),asc("T"),asc("L"))
#define DMUS_FOURCC_TOOL_CHUNK mmioFOURCC(asc("t"),asc("o"),asc("l"),asc("h"))

#define DMUS_FOURCC_AUDIOPATH_FORM mmioFOURCC(asc("D"),asc("M"),asc("A"),asc("P"))

#define DMUS_FOURCC_PORTCONFIGS_LIST mmioFOURCC(asc("p"),asc("c"),asc("s"),asc("l"))
#define DMUS_FOURCC_PORTCONFIG_LIST mmioFOURCC(asc("p"),asc("c"),asc("f"),asc("l"))
#define DMUS_FOURCC_PORTCONFIG_ITEM mmioFOURCC(asc("p"),asc("c"),asc("f"),asc("h"))
#define DMUS_FOURCC_PORTPARAMS_ITEM mmioFOURCC(asc("p"),asc("p"),asc("r"),asc("h"))
#define DMUS_FOURCC_DSBUFFER_LIST mmioFOURCC(asc("d"),asc("b"),asc("f"),asc("l"))
#define DMUS_FOURCC_DSBUFFATTR_ITEM mmioFOURCC(asc("d"),asc("d"),asc("a"),asc("h"))
#define DMUS_FOURCC_PCHANNELS_LIST mmioFOURCC(asc("p"),asc("c"),asc("h"),asc("l"))
#define DMUS_FOURCC_PCHANNELS_ITEM mmioFOURCC(asc("p"),asc("c"),asc("h"),asc("h"))

#define DMUS_FOURCC_BANDTRACK_FORM mmioFOURCC(asc("D"),asc("M"),asc("B"),asc("T"))
#define DMUS_FOURCC_BANDTRACK_CHUNK mmioFOURCC(asc("b"),asc("d"),asc("t"),asc("h"))
#define DMUS_FOURCC_BANDS_LIST mmioFOURCC(asc("l"),asc("b"),asc("d"),asc("l"))
#define DMUS_FOURCC_BAND_LIST mmioFOURCC(asc("l"),asc("b"),asc("n"),asc("d"))
#define DMUS_FOURCC_BANDITEM_CHUNK mmioFOURCC(asc("b"),asc("d"),asc("i"),asc("h"))
#define DMUS_FOURCC_BANDITEM_CHUNK2 mmioFOURCC(asc("b"),asc("d"),asc("2"),asc("h"))

#define DMUS_FOURCC_BAND_FORM mmioFOURCC(asc("D"),asc("M"),asc("B"),asc("D"))
#define DMUS_FOURCC_INSTRUMENTS_LIST mmioFOURCC(asc("l"),asc("b"),asc("i"),asc("l"))
#define DMUS_FOURCC_INSTRUMENT_LIST mmioFOURCC(asc("l"),asc("b"),asc("i"),asc("n"))
#define DMUS_FOURCC_INSTRUMENT_CHUNK mmioFOURCC(asc("b"),asc("i"),asc("n"),asc("s"))

#define DMUS_FOURCC_WAVETRACK_LIST mmioFOURCC(asc("w"),asc("a"),asc("v"),asc("t"))
#define DMUS_FOURCC_WAVETRACK_CHUNK mmioFOURCC(asc("w"),asc("a"),asc("t"),asc("h"))
#define DMUS_FOURCC_WAVEPART_LIST mmioFOURCC(asc("w"),asc("a"),asc("v"),asc("p"))
#define DMUS_FOURCC_WAVEPART_CHUNK mmioFOURCC(asc("w"),asc("a"),asc("p"),asc("h"))
#define DMUS_FOURCC_WAVEITEM_LIST mmioFOURCC(asc("w"),asc("a"),asc("v"),asc("i"))
#define DMUS_FOURCC_WAVE_LIST mmioFOURCC(asc("w"),asc("a"),asc("v"),asc("e"))
#define DMUS_FOURCC_WAVEITEM_CHUNK mmioFOURCC(asc("w"),asc("a"),asc("i"),asc("h"))

#define DMUS_FOURCC_CONTAINER_FORM mmioFOURCC(asc("D"),asc("M"),asc("C"),asc("N"))
#define DMUS_FOURCC_CONTAINER_CHUNK mmioFOURCC(asc("c"),asc("o"),asc("n"),asc("h"))
#define DMUS_FOURCC_CONTAINED_ALIAS_CHUNK mmioFOURCC(asc("c"),asc("o"),asc("b"),asc("a"))
#define DMUS_FOURCC_CONTAINED_OBJECT_CHUNK mmioFOURCC(asc("c"),asc("o"),asc("b"),asc("h"))
#define DMUS_FOURCC_CONTAINED_OBJECTS_LIST mmioFOURCC(asc("c"),asc("o"),asc("s"),asc("l"))
#define DMUS_FOURCC_CONTAINED_OBJECT_LIST mmioFOURCC(asc("c"),asc("o"),asc("b"),asc("l"))

#define DMUS_FOURCC_SEGMENT_FORM mmioFOURCC(asc("D"),asc("M"),asc("S"),asc("G"))
#define DMUS_FOURCC_SEGMENT_CHUNK mmioFOURCC(asc("s"),asc("e"),asc("g"),asc("h"))
#define DMUS_FOURCC_TRACK_LIST mmioFOURCC(asc("t"),asc("r"),asc("k"),asc("l"))
#define DMUS_FOURCC_TRACK_FORM mmioFOURCC(asc("D"),asc("M"),asc("T"),asc("K"))
#define DMUS_FOURCC_TRACK_CHUNK mmioFOURCC(asc("t"),asc("r"),asc("k"),asc("h"))
#define DMUS_FOURCC_TRACK_EXTRAS_CHUNK mmioFOURCC(asc("t"),asc("r"),asc("k"),asc("x"))

#define DMUS_FOURCC_REF_LIST mmioFOURCC(asc("D"),asc("M"),asc("R"),asc("F"))
#define DMUS_FOURCC_REF_CHUNK mmioFOURCC(asc("r"),asc("e"),asc("f"),asc("h"))
#define DMUS_FOURCC_DATE_CHUNK mmioFOURCC(asc("d"),asc("a"),asc("t"),asc("e"))
#define DMUS_FOURCC_NAME_CHUNK mmioFOURCC(asc("n"),asc("a"),asc("m"),asc("e"))
#define DMUS_FOURCC_FILE_CHUNK mmioFOURCC(asc("f"),asc("i"),asc("l"),asc("e"))

#define DMUS_FOURCC_CHORDMAP_FORM mmioFOURCC(asc("D"),asc("M"),asc("P"),asc("R"))
#define DMUS_FOURCC_IOCHORDMAP_CHUNK mmioFOURCC(asc("p"),asc("e"),asc("r"),asc("h"))
#define DMUS_FOURCC_SUBCHORD_CHUNK mmioFOURCC(asc("c"),asc("h"),asc("d"),asc("t"))
#define DMUS_FOURCC_CHORDENTRY_CHUNK mmioFOURCC(asc("c"),asc("h"),asc("e"),asc("h"))
#define DMUS_FOURCC_SUBCHORDID_CHUNK mmioFOURCC(asc("s"),asc("b"),asc("c"),asc("n"))
#define DMUS_FOURCC_IONEXTCHORD_CHUNK mmioFOURCC(asc("n"),asc("c"),asc("r"),asc("d"))
#define DMUS_FOURCC_NEXTCHORDSEQ_CHUNK mmioFOURCC(asc("n"),asc("c"),asc("s"),asc("q"))
#define DMUS_FOURCC_IOSIGNPOST_CHUNK mmioFOURCC(asc("s"),asc("p"),asc("s"),asc("h"))
#define DMUS_FOURCC_CHORDNAME_CHUNK mmioFOURCC(asc("I"),asc("N"),asc("A"),asc("M"))

#define DMUS_FOURCC_CHORDENTRY_LIST mmioFOURCC(asc("c"),asc("h"),asc("o"),asc("e"))
#define DMUS_FOURCC_CHORDMAP_LIST mmioFOURCC(asc("c"),asc("m"),asc("a"),asc("p"))
#define DMUS_FOURCC_CHORD_LIST mmioFOURCC(asc("c"),asc("h"),asc("r"),asc("d"))
#define DMUS_FOURCC_CHORDPALETTE_LIST mmioFOURCC(asc("c"),asc("h"),asc("p"),asc("l"))
#define DMUS_FOURCC_CADENCE_LIST mmioFOURCC(asc("c"),asc("a"),asc("d"),asc("e"))
#define DMUS_FOURCC_SIGNPOSTITEM_LIST mmioFOURCC(asc("s"),asc("p"),asc("s"),asc("t"))

#define DMUS_FOURCC_SIGNPOST_LIST mmioFOURCC(asc("s"),asc("p"),asc("s"),asc("q"))

#define DMUS_FOURCC_SCRIPT_FORM mmioFOURCC(asc("D"),asc("M"),asc("S"),asc("C"))
#define DMUS_FOURCC_SCRIPT_CHUNK mmioFOURCC(asc("s"),asc("c"),asc("h"),asc("d"))
#define DMUS_FOURCC_SCRIPTVERSION_CHUNK mmioFOURCC(asc("s"),asc("c"),asc("v"),asc("e"))
#define DMUS_FOURCC_SCRIPTLANGUAGE_CHUNK mmioFOURCC(asc("s"),asc("c"),asc("l"),asc("a"))
#define DMUS_FOURCC_SCRIPTSOURCE_CHUNK mmioFOURCC(asc("s"),asc("c"),asc("s"),asc("r"))

#define DMUS_FOURCC_SIGNPOST_TRACK_CHUNK mmioFOURCC( 's', 'g', 'n', 'p' )

#define DMUS_FOURCC_MUTE_CHUNK mmioFOURCC(asc("m"),asc("u"),asc("t"),asc("e"))

#define DMUS_FOURCC_TIME_STAMP_CHUNK mmioFOURCC(asc("s', 't', 'm', 'p"))

#define DMUS_FOURCC_STYLE_TRACK_LIST mmioFOURCC(asc("s', 't', 't', 'r"))
#define DMUS_FOURCC_STYLE_REF_LIST mmioFOURCC(asc("s', 't', 'r', 'f"))

#define DMUS_FOURCC_TEMPO_TRACK mmioFOURCC(asc("t"),asc("e"),asc("t"),asc("r"))

#define DMUS_FOURCC_SEQ_TRACK mmioFOURCC(asc("s"),asc("e"),asc("q"),asc("t"))
#define DMUS_FOURCC_SEQ_LIST mmioFOURCC(asc("e"),asc("v"),asc("t"),asc("l"))
#define DMUS_FOURCC_CURVE_LIST mmioFOURCC(asc("c"),asc("u"),asc("r"),asc("l"))

#define DMUS_FOURCC_SYSEX_TRACK mmioFOURCC(asc("s"),asc("y"),asc("e"),asc("x"))

#define DMUS_FOURCC_TIMESIGNATURE_TRACK mmioFOURCC(asc("t"),asc("i"),asc("m"),asc("s"))

#define DMUS_FOURCC_TIMESIGTRACK_LIST mmioFOURCC(asc("T"),asc("I"),asc("M"),asc("S"))
#define DMUS_FOURCC_TIMESIG_CHUNK       DMUS_FOURCC_TIMESIGNATURE_TRACK

#define DMUS_FOURCC_MARKERTRACK_LIST mmioFOURCC(asc("M"),asc("A"),asc("R"),asc("K"))
#define DMUS_FOURCC_VALIDSTART_CHUNK mmioFOURCC(asc("v"),asc("a"),asc("l"),asc("s"))
#define DMUS_FOURCC_PLAYMARKER_CHUNK mmioFOURCC(asc("p"),asc("l"),asc("a"),asc("y"))

#define DMUS_FOURCC_SEGTRACK_LIST mmioFOURCC(asc("s"),asc("e"),asc("g"),asc("t"))
#define DMUS_FOURCC_SEGTRACK_CHUNK mmioFOURCC(asc("s"),asc("g"),asc("t"),asc("h"))
#define DMUS_FOURCC_SEGMENTS_LIST mmioFOURCC(asc("l"),asc("s"),asc("g"),asc("l"))
#define DMUS_FOURCC_SEGMENT_LIST mmioFOURCC(asc("l"),asc("s"),asc("e"),asc("g"))
#define DMUS_FOURCC_SEGMENTITEM_CHUNK mmioFOURCC(asc("s"),asc("g"),asc("i"),asc("h"))
#define DMUS_FOURCC_SEGMENTITEMNAME_CHUNK mmioFOURCC(asc("s"),asc("n"),asc("a"),asc("m"))

#define DMUS_FOURCC_SCRIPTTRACK_LIST mmioFOURCC(asc("s"),asc("c"),asc("r"),asc("t"))
#define DMUS_FOURCC_SCRIPTTRACKEVENTS_LIST mmioFOURCC(asc("s"),asc("c"),asc("r"),asc("l"))
#define DMUS_FOURCC_SCRIPTTRACKEVENT_LIST mmioFOURCC(asc("s"),asc("c"),asc("r"),asc("e"))
#define DMUS_FOURCC_SCRIPTTRACKEVENTHEADER_CHUNK mmioFOURCC(asc("s"),asc("c"),asc("r"),asc("h"))
#define DMUS_FOURCC_SCRIPTTRACKEVENTNAME_CHUNK mmioFOURCC(asc("s"),asc("c"),asc("r"),asc("n"))

#define DMUS_FOURCC_LYRICSTRACK_LIST mmioFOURCC(asc("l"),asc("y"),asc("r"),asc("t"))
#define DMUS_FOURCC_LYRICSTRACKEVENTS_LIST mmioFOURCC(asc("l"),asc("y"),asc("r"),asc("l"))
#define DMUS_FOURCC_LYRICSTRACKEVENT_LIST mmioFOURCC(asc("l"),asc("y"),asc("r"),asc("e"))
#define DMUS_FOURCC_LYRICSTRACKEVENTHEADER_CHUNK mmioFOURCC(asc("l"),asc("y"),asc("r"),asc("h"))
#define DMUS_FOURCC_LYRICSTRACKEVENTTEXT_CHUNK mmioFOURCC(asc("l"),asc("y"),asc("r"),asc("n"))

#define DMUS_FOURCC_PARAMCONTROLTRACK_TRACK_LIST mmioFOURCC(asc("p"),asc("r"),asc("m"),asc("t"))
#define DMUS_FOURCC_PARAMCONTROLTRACK_OBJECT_LIST mmioFOURCC(asc("p"),asc("r"),asc("o"),asc("l"))
#define DMUS_FOURCC_PARAMCONTROLTRACK_OBJECT_CHUNK mmioFOURCC(asc("p"),asc("r"),asc("o"),asc("h"))
#define DMUS_FOURCC_PARAMCONTROLTRACK_PARAM_LIST mmioFOURCC(asc("p"),asc("r"),asc("p"),asc("l"))
#define DMUS_FOURCC_PARAMCONTROLTRACK_PARAM_CHUNK mmioFOURCC(asc("p"),asc("r"),asc("p"),asc("h"))
#define DMUS_FOURCC_PARAMCONTROLTRACK_CURVES_CHUNK mmioFOURCC(asc("p"),asc("r"),asc("c"),asc("c"))

#define DMUS_FOURCC_DSBC_FORM mmioFOURCC(asc("D"),asc("S"),asc("B"),asc("C"))
#define DMUS_FOURCC_DSBD_CHUNK mmioFOURCC(asc("d"),asc("s"),asc("b"),asc("d"))
#define DMUS_FOURCC_BSID_CHUNK mmioFOURCC(asc("b"),asc("s"),asc("i"),asc("d"))
#define DMUS_FOURCC_DS3D_CHUNK mmioFOURCC(asc("d"),asc("s"),asc("3"),asc("d"))
#define DMUS_FOURCC_DSBC_LIST mmioFOURCC(asc("f"),asc("x"),asc("l"),asc("s"))
#define DMUS_FOURCC_DSFX_FORM mmioFOURCC(asc("D"),asc("S"),asc("F"),asc("X"))
#define DMUS_FOURCC_DSFX_CHUNK mmioFOURCC(asc("f"),asc("x"),asc("h"),asc("r"))
#define DMUS_FOURCC_DSFX_DATA mmioFOURCC(asc("d"),asc("a"),asc("t"),asc("a"))

type DMUS_IO_SEQ_ITEM
	mtTime as MUSIC_TIME
	mtDuration as MUSIC_TIME
	dwPChannel as DWORD
	nOffset as short
	bStatus as UBYTE
	bByte1 as UBYTE
	bByte2 as UBYTE
end type

type DMUS_IO_CURVE_ITEM
	mtStart as MUSIC_TIME
	mtDuration as MUSIC_TIME
	mtResetDuration as MUSIC_TIME
	dwPChannel as DWORD
	nOffset as short
	nStartValue as short
	nEndValue as short
	nResetValue as short
	bType as UBYTE
	bCurveShape as UBYTE
	bCCData as UBYTE
	bFlags as UBYTE
	wParamType as WORD
	wMergeIndex as WORD
end type

type DMUS_IO_TEMPO_ITEM
	lTime as MUSIC_TIME
	dblTempo as double
end type

type DMUS_IO_SYSEX_ITEM
	mtTime as MUSIC_TIME
	dwPChannel as DWORD
	dwSysExLength as DWORD
end type

type DMUS_CHORD_PARAM as DMUS_CHORD_KEY

type DMUS_RHYTHM_PARAM
	TimeSig as DMUS_TIMESIGNATURE
	dwRhythmPattern as DWORD
end type

type DMUS_TEMPO_PARAM
	mtTime as MUSIC_TIME
	dblTempo as double
end type

type DMUS_MUTE_PARAM
	dwPChannel as DWORD
	dwPChannelMap as DWORD
	fMute as BOOL
end type

#define DMUS_VARIATIONF_MAJOR &h0000007F
#define DMUS_VARIATIONF_MINOR &h00003F80
#define DMUS_VARIATIONF_OTHER &h001FC000
#define DMUS_VARIATIONF_ROOT_SCALE &h00200000
#define DMUS_VARIATIONF_ROOT_FLAT &h00400000
#define DMUS_VARIATIONF_ROOT_SHARP &h00800000
#define DMUS_VARIATIONF_TYPE_TRIAD &h01000000
#define DMUS_VARIATIONF_TYPE_6AND7 &h02000000
#define DMUS_VARIATIONF_TYPE_COMPLEX &h04000000
#define DMUS_VARIATIONF_DEST_TO1 &h08000000
#define DMUS_VARIATIONF_DEST_TO5 &h10000000
#define DMUS_VARIATIONF_DEST_OTHER &h40000000
#define DMUS_VARIATIONF_MODES &hE0000000
#define DMUS_VARIATIONF_MODES_EX (&h20000000 or &h80000000)
#define DMUS_VARIATIONF_IMA25_MODE &h00000000
#define DMUS_VARIATIONF_DMUS_MODE &h20000000
#define DMUS_PARTF_USE_MARKERS &h1
#define DMUS_PARTF_ALIGN_CHORDS &h2
#define DMUS_MARKERF_START &h1
#define DMUS_MARKERF_STOP &h2
#define DMUS_MARKERF_CHORD_ALIGN &h4
#define DMUS_PATTERNF_PERSIST_CONTROL &h1

enum DMUS_VARIATIONT_TYPES
	DMUS_VARIATIONT_SEQUENTIAL = 0
	DMUS_VARIATIONT_RANDOM = 1
	DMUS_VARIATIONT_RANDOM_START = 2
	DMUS_VARIATIONT_NO_REPEAT = 3
	DMUS_VARIATIONT_RANDOM_ROW = 4
end enum

enum DMUS_EMBELLISHT_TYPES
	DMUS_EMBELLISHT_NORMAL = 0
	DMUS_EMBELLISHT_FILL = 1
	DMUS_EMBELLISHT_BREAK = 2
	DMUS_EMBELLISHT_INTRO = 4
	DMUS_EMBELLISHT_END = 8
	DMUS_EMBELLISHT_MOTIF = 16
	DMUS_EMBELLISHT_ALL = &hFFFF
end enum

type DMUS_IO_TIMESIG
	bBeatsPerMeasure as UBYTE
	bBeat as UBYTE
	wGridsPerBeat as WORD
end type

type DMUS_IO_STYLE
	timeSig as DMUS_IO_TIMESIG
	dblTempo as double
end type

type DMUS_IO_VERSION
	dwVersionMS as DWORD
	dwVersionLS as DWORD
end type

type DMUS_IO_PATTERN
	timeSig as DMUS_IO_TIMESIG
	bGrooveBottom as UBYTE
	bGrooveTop as UBYTE
	wEmbellishment as WORD
	wNbrMeasures as WORD
	bDestGrooveBottom as UBYTE
	bDestGrooveTop as UBYTE
	dwFlags as DWORD
end type

type DMUS_IO_STYLEPART
	timeSig as DMUS_IO_TIMESIG
	dwVariationChoices(0 to 32-1) as DWORD
	guidPartID as GUID
	wNbrMeasures as WORD
	bPlayModeFlags as UBYTE
	bInvertUpper as UBYTE
	bInvertLower as UBYTE
	bPad(0 to 3-1) as UBYTE
	dwFlags as DWORD
end type

type DMUS_IO_PARTREF
	guidPartID as GUID
	wLogicalPartID as WORD
	bVariationLockID as UBYTE
	bSubChordLevel as UBYTE
	bPriority as UBYTE
	bRandomVariation as UBYTE
	wPad as WORD
	dwPChannel as DWORD
end type

type DMUS_IO_STYLENOTE
	mtGridStart as MUSIC_TIME
	dwVariation as DWORD
	mtDuration as MUSIC_TIME
	nTimeOffset as short
	wMusicValue as WORD
	bVelocity as UBYTE
	bTimeRange as UBYTE
	bDurRange as UBYTE
	bVelRange as UBYTE
	bInversionID as UBYTE
	bPlayModeFlags as UBYTE
	bNoteFlags as UBYTE
end type

type DMUS_IO_STYLECURVE
	mtGridStart as MUSIC_TIME
	dwVariation as DWORD
	mtDuration as MUSIC_TIME
	mtResetDuration as MUSIC_TIME
	nTimeOffset as short
	nStartValue as short
	nEndValue as short
	nResetValue as short
	bEventType as UBYTE
	bCurveShape as UBYTE
	bCCData as UBYTE
	bFlags as UBYTE
	wParamType as WORD
	wMergeIndex as WORD
end type

type DMUS_IO_STYLEMARKER
	mtGridStart as MUSIC_TIME
	dwVariation as DWORD
	wMarkerFlags as WORD
end type

type DMUS_IO_STYLERESOLUTION
	dwVariation as DWORD
	wMusicValue as WORD
	bInversionID as UBYTE
	bPlayModeFlags as UBYTE
end type

type DMUS_IO_STYLE_ANTICIPATION
	mtGridStart as MUSIC_TIME
	dwVariation as DWORD
	nTimeOffset as short
	bTimeRange as UBYTE
end type

type DMUS_IO_MOTIFSETTINGS
	dwRepeats as DWORD
	mtPlayStart as MUSIC_TIME
	mtLoopStart as MUSIC_TIME
	mtLoopEnd as MUSIC_TIME
	dwResolution as DWORD
end type

enum DMUS_PATTERNT_TYPES
	DMUS_PATTERNT_RANDOM = 0
	DMUS_PATTERNT_REPEAT = 1
	DMUS_PATTERNT_SEQUENTIAL = 2
	DMUS_PATTERNT_RANDOM_START = 3
	DMUS_PATTERNT_NO_REPEAT = 4
	DMUS_PATTERNT_RANDOM_ROW = 5
end enum

type DMUS_IO_CHORD
	wszName(0 to 16-1) as WCHAR
	mtTime as MUSIC_TIME
	wMeasure as WORD
	bBeat as UBYTE
	bFlags as UBYTE
end type

type DMUS_IO_SUBCHORD
	dwChordPattern as DWORD
	dwScalePattern as DWORD
	dwInversionPoints as DWORD
	dwLevels as DWORD
	bChordRoot as UBYTE
	bScaleRoot as UBYTE
end type

type DMUS_IO_COMMAND
	mtTime as MUSIC_TIME
	wMeasure as WORD
	bBeat as UBYTE
	bCommand as UBYTE
	bGrooveLevel as UBYTE
	bGrooveRange as UBYTE
	bRepeatMode as UBYTE
end type

type DMUS_IO_TOOL_HEADER
	guidClassID as GUID
	lIndex as integer
	cPChannels as DWORD
	ckid as FOURCC
	fccType as FOURCC
	dwPChannels(0 to 1-1) as DWORD
end type

type DMUS_IO_PORTCONFIG_HEADER
	guidPort as GUID
	dwPChannelBase as DWORD
	dwPChannelCount as DWORD
	dwFlags as DWORD
end type

#define DMUS_PORTCONFIGF_DRUMSON10 1
#define DMUS_PORTCONFIGF_USEDEFAULT 2

type DMUS_IO_PCHANNELTOBUFFER_HEADER
	dwPChannelBase as DWORD
	dwPChannelCount as DWORD
	dwBufferCount as DWORD
	dwFlags as DWORD
end type

type DMUS_IO_BUFFER_ATTRIBUTES_HEADER
	guidBufferID as GUID
	dwFlags as DWORD
end type

#define DMUS_BUFFERF_SHARED 1
#define DMUS_BUFFERF_DEFINED 2
#define DMUS_BUFFERF_MIXIN 8

type DMUS_IO_BAND_TRACK_HEADER
	bAutoDownload as BOOL
end type

type DMUS_IO_BAND_ITEM_HEADER
	lBandTime as MUSIC_TIME
end type

type DMUS_IO_BAND_ITEM_HEADER2
	lBandTimeLogical as MUSIC_TIME
	lBandTimePhysical as MUSIC_TIME
end type

#define DMUS_IO_INST_PATCH (1 shl 0)
#define DMUS_IO_INST_BANKSELECT (1 shl 1)
#define DMUS_IO_INST_ASSIGN_PATCH (1 shl 3)
#define DMUS_IO_INST_NOTERANGES (1 shl 4)
#define DMUS_IO_INST_PAN (1 shl 5)
#define DMUS_IO_INST_VOLUME (1 shl 6)
#define DMUS_IO_INST_TRANSPOSE (1 shl 7)
#define DMUS_IO_INST_GM (1 shl 8)
#define DMUS_IO_INST_GS (1 shl 9)
#define DMUS_IO_INST_XG (1 shl 10)
#define DMUS_IO_INST_CHANNEL_PRIORITY (1 shl 11)
#define DMUS_IO_INST_USE_DEFAULT_GM_SET (1 shl 12)
#define DMUS_IO_INST_PITCHBENDRANGE (1 shl 13)

type DMUS_IO_INSTRUMENT
	dwPatch as DWORD
	dwAssignPatch as DWORD
	dwNoteRanges(0 to 4-1) as DWORD
	dwPChannel as DWORD
	dwFlags as DWORD
	bPan as UBYTE
	bVolume as UBYTE
	nTranspose as short
	dwChannelPriority as DWORD
	nPitchBendRange as short
end type

type DMUS_IO_WAVE_HEADER
	rtReadAhead as REFERENCE_TIME
	dwFlags as DWORD
end type

#define DMUS_WAVETRACKF_SYNC_VAR &h1
#define DMUS_WAVETRACKF_PERSIST_CONTROL &h2

type DMUS_IO_WAVE_TRACK_HEADER
	lVolume as integer
	dwFlags as DWORD
end type

type DMUS_IO_WAVE_PART_HEADER
	lVolume as integer
	dwVariations as DWORD
	dwPChannel as DWORD
	dwLockToPart as DWORD
	dwFlags as DWORD
	dwIndex as DWORD
end type

type DMUS_IO_WAVE_ITEM_HEADER
	lVolume as integer
	lPitch as integer
	dwVariations as DWORD
	rtTime as REFERENCE_TIME
	rtStartOffset as REFERENCE_TIME
	rtReserved as REFERENCE_TIME
	rtDuration as REFERENCE_TIME
	mtLogicalTime as MUSIC_TIME
	dwLoopStart as DWORD
	dwLoopEnd as DWORD
	dwFlags as DWORD
	wVolumeRange as WORD
	wPitchRange as WORD
end type

type DMUS_IO_CONTAINER_HEADER
	dwFlags as DWORD
end type

#define DMUS_CONTAINER_NOLOADS (1 shl 1)

type DMUS_IO_CONTAINED_OBJECT_HEADER
	guidClassID as GUID
	dwFlags as DWORD
	ckid as FOURCC
	fccType as FOURCC
end type

#define DMUS_CONTAINED_OBJF_KEEP 1

type DMUS_IO_SEGMENT_HEADER
	dwRepeats as DWORD
	mtLength as MUSIC_TIME
	mtPlayStart as MUSIC_TIME
	mtLoopStart as MUSIC_TIME
	mtLoopEnd as MUSIC_TIME
	dwResolution as DWORD
	rtLength as REFERENCE_TIME
	dwFlags as DWORD
	dwReserved as DWORD
	rtLoopStart as REFERENCE_TIME
	rtLoopEnd as REFERENCE_TIME
	rtPlayStart as REFERENCE_TIME
end type

#define DMUS_SEGIOF_REFLENGTH 1
#define DMUS_SEGIOF_CLOCKTIME 2

type DMUS_IO_TRACK_HEADER
	guidClassID as GUID
	dwPosition as DWORD
	dwGroup as DWORD
	ckid as FOURCC
	fccType as FOURCC
end type

type DMUS_IO_TRACK_EXTRAS_HEADER
	dwFlags as DWORD
	dwPriority as DWORD
end type

type DMUS_IO_REFERENCE
	guidClassID as GUID
	dwValidData as DWORD
end type

#define DMUS_SIGNPOSTF_A 1
#define DMUS_SIGNPOSTF_B 2
#define DMUS_SIGNPOSTF_C 4
#define DMUS_SIGNPOSTF_D 8
#define DMUS_SIGNPOSTF_E &h10
#define DMUS_SIGNPOSTF_F &h20
#define DMUS_SIGNPOSTF_LETTER (1 or 2 or 4 or 8 or &h10 or &h20)
#define DMUS_SIGNPOSTF_1 &h100
#define DMUS_SIGNPOSTF_2 &h200
#define DMUS_SIGNPOSTF_3 &h400
#define DMUS_SIGNPOSTF_4 &h800
#define DMUS_SIGNPOSTF_5 &h1000
#define DMUS_SIGNPOSTF_6 &h2000
#define DMUS_SIGNPOSTF_7 &h4000
#define DMUS_SIGNPOSTF_ROOT (&h100 or &h200 or &h400 or &h800 or &h1000 or &h2000 or &h4000)
#define DMUS_SIGNPOSTF_CADENCE &h8000
#define DMUS_CHORDMAPF_VERSION8 1
#define DMUS_SPOSTCADENCEF_1 2
#define DMUS_SPOSTCADENCEF_2 4

type DMUS_IO_CHORDMAP
	wszLoadName(0 to 20-1) as WCHAR
	dwScalePattern as DWORD
	dwFlags as DWORD
end type

type DMUS_IO_CHORDMAP_SUBCHORD
	dwChordPattern as DWORD
	dwScalePattern as DWORD
	dwInvertPattern as DWORD
	bChordRoot as UBYTE
	bScaleRoot as UBYTE
	wCFlags as WORD
	dwLevels as DWORD
end type

type DMUS_IO_PERS_SUBCHORD as DMUS_IO_CHORDMAP_SUBCHORD

type DMUS_IO_CHORDENTRY
	dwFlags as DWORD
	wConnectionID as WORD
end type

type DMUS_IO_NEXTCHORD
	dwFlags as DWORD
	nWeight as WORD
	wMinBeats as WORD
	wMaxBeats as WORD
	wConnectionID as WORD
end type

type DMUS_IO_CHORDMAP_SIGNPOST
	dwChords as DWORD
	dwFlags as DWORD
end type

type DMUS_IO_PERS_SIGNPOST as DMUS_IO_CHORDMAP_SIGNPOST

type DMUS_IO_SCRIPT_HEADER
	dwFlags as DWORD
end type

#define DMUS_SCRIPTIOF_LOAD_ALL_CONTENT (1 shl 0)
#define DMUS_SCRIPTIOF_DOWNLOAD_ALL_SEGMENTS (1 shl 1)

type DMUS_IO_SIGNPOST
	mtTime as MUSIC_TIME
	dwChords as DWORD
	wMeasure as WORD
end type

type DMUS_IO_MUTE
	mtTime as MUSIC_TIME
	dwPChannel as DWORD
	dwPChannelMap as DWORD
end type

type DMUS_IO_TIMESIGNATURE_ITEM
	lTime as MUSIC_TIME
	bBeatsPerMeasure as UBYTE
	bBeat as UBYTE
	wGridsPerBeat as WORD
end type

type DMUS_IO_VALID_START
	mtTime as MUSIC_TIME
end type

type DMUS_IO_PLAY_MARKER
	mtTime as MUSIC_TIME
end type

type DMUS_IO_SEGMENT_TRACK_HEADER
	dwFlags as DWORD
end type

type DMUS_IO_SEGMENT_ITEM_HEADER
	lTimeLogical as MUSIC_TIME
	lTimePhysical as MUSIC_TIME
	dwPlayFlags as DWORD
	dwFlags as DWORD
end type

#define DMUS_SEGMENTTRACKF_MOTIF 1
#define DMUS_IO_SCRIPTTRACKF_PREPARE (1 shl 0)
#define DMUS_IO_SCRIPTTRACKF_QUEUE (1 shl 1)
#define DMUS_IO_SCRIPTTRACKF_ATTIME (1 shl 2)

type DMUS_IO_SCRIPTTRACK_EVENTHEADER
	dwFlags as DWORD
	lTimeLogical as MUSIC_TIME
	lTimePhysical as MUSIC_TIME
end type

type DMUS_IO_LYRICSTRACK_EVENTHEADER
	dwFlags as DWORD
	dwTimingFlags as DWORD
	lTimeLogical as MUSIC_TIME
	lTimePhysical as MUSIC_TIME
end type

type DMUS_IO_PARAMCONTROLTRACK_OBJECTHEADER
	dwFlags as DWORD
	guidTimeFormat as GUID
	dwPChannel as DWORD
	dwStage as DWORD
	dwBuffer as DWORD
	guidObject as GUID
	dwIndex as DWORD
end type

type DMUS_IO_PARAMCONTROLTRACK_PARAMHEADER
	dwFlags as DWORD
	dwIndex as DWORD
end type

type DMUS_IO_PARAMCONTROLTRACK_CURVEINFO
	mtStartTime as MUSIC_TIME
	mtEndTime as MUSIC_TIME
	fltStartValue as single
	fltEndValue as single
	dwCurveType as DWORD
	dwFlags as DWORD
end type

type DSOUND_IO_DSBUFFERDESC
	dwFlags as DWORD
	nChannels as WORD
	lVolume as LONG
	lPan as LONG
	dwReserved as DWORD
end type

type DSOUND_IO_DSBUSID
	busid(0 to 1-1) as DWORD
end type

type DSOUND_IO_3D
	guid3DAlgorithm as GUID
	ds3d as DS3DBUFFER
end type

type DSOUND_IO_DXDMO_HEADER
	dwEffectFlags as DWORD
	guidDSFXClass as GUID
	guidReserved as GUID
	guidSendBuffer as GUID
	dwReserved as DWORD
end type

type DSOUND_IO_DXDMO_DATA
	data(0 to 1-1) as DWORD
end type

#endif
