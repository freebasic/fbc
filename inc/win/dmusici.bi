''
''
'' dmusici -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmusici_bi__
#define __win_dmusici_bi__

#include once "windows.bi"
#include once "win/ole2.bi"
#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"
#include once "win/mmsystem.bi"
#include once "win/dmusicc.bi"
#include once "win/dmplugin.bi"

type TRANSITION_TYPE as WORD
type REFERENCE_TIME as longint
type MUSIC_TIME as integer

#define MT_MIN &h80000000
#define MT_MAX &h7FFFFFFF
#define DMUS_PPQ 768

enum DMUS_STYLET_TYPES
	DMUS_STYLET_PATTERN = 0
	DMUS_STYLET_MOTIF = 1
end enum

enum DMUS_COMMANDT_TYPES
	DMUS_COMMANDT_GROOVE = 0
	DMUS_COMMANDT_FILL = 1
	DMUS_COMMANDT_INTRO = 2
	DMUS_COMMANDT_BREAK = 3
	DMUS_COMMANDT_END = 4
	DMUS_COMMANDT_ENDANDINTRO = 5
end enum

enum DMUS_SHAPET_TYPES
	DMUS_SHAPET_FALLING = 0
	DMUS_SHAPET_LEVEL = 1
	DMUS_SHAPET_LOOPABLE = 2
	DMUS_SHAPET_LOUD = 3
	DMUS_SHAPET_QUIET = 4
	DMUS_SHAPET_PEAKING = 5
	DMUS_SHAPET_RANDOM = 6
	DMUS_SHAPET_RISING = 7
	DMUS_SHAPET_SONG = 8
end enum

enum DMUS_COMPOSEF_FLAGS
	DMUS_COMPOSEF_NONE = 0
	DMUS_COMPOSEF_ALIGN = &h1
	DMUS_COMPOSEF_OVERLAP = &h2
	DMUS_COMPOSEF_IMMEDIATE = &h4
	DMUS_COMPOSEF_GRID = &h8
	DMUS_COMPOSEF_BEAT = &h10
	DMUS_COMPOSEF_MEASURE = &h20
	DMUS_COMPOSEF_AFTERPREPARETIME = &h40
	DMUS_COMPOSEF_VALID_START_BEAT = &h80
	DMUS_COMPOSEF_VALID_START_GRID = &h100
	DMUS_COMPOSEF_VALID_START_TICK = &h200
	DMUS_COMPOSEF_SEGMENTEND = &h400
	DMUS_COMPOSEF_MARKER = &h800
	DMUS_COMPOSEF_MODULATE = &h1000
	DMUS_COMPOSEF_LONG = &h2000
	DMUS_COMPOSEF_ENTIRE_TRANSITION = &h4000
	DMUS_COMPOSEF_1BAR_TRANSITION = &h8000
	DMUS_COMPOSEF_ENTIRE_ADDITION = &h10000
	DMUS_COMPOSEF_1BAR_ADDITION = &h20000
	DMUS_COMPOSEF_VALID_START_MEASURE = &h40000
	DMUS_COMPOSEF_DEFAULT = &h80000
	DMUS_COMPOSEF_NOINVALIDATE = &h100000
	DMUS_COMPOSEF_USE_AUDIOPATH = &h200000
	DMUS_COMPOSEF_INVALIDATE_PRI = &h400000
end enum

type IDirectMusicTool_ as IDirectMusicTool
type IDirectMusicGraph_ as IDirectMusicGraph

type DMUS_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
end type

#define DMUS_PCHANNEL_BROADCAST_PERFORMANCE &hFFFFFFFF
#define DMUS_PCHANNEL_BROADCAST_AUDIOPATH &hFFFFFFFE
#define DMUS_PCHANNEL_BROADCAST_SEGMENT &hFFFFFFFD
#define DMUS_PCHANNEL_BROADCAST_GROUPS &hFFFFFFFC
#define DMUS_PATH_SEGMENT &h1000
#define DMUS_PATH_SEGMENT_TRACK &h1100
#define DMUS_PATH_SEGMENT_GRAPH &h1200
#define DMUS_PATH_SEGMENT_TOOL &h1300
#define DMUS_PATH_AUDIOPATH &h2000
#define DMUS_PATH_AUDIOPATH_GRAPH &h2200
#define DMUS_PATH_AUDIOPATH_TOOL &h2300
#define DMUS_PATH_PERFORMANCE &h3000
#define DMUS_PATH_PERFORMANCE_GRAPH &h3200
#define DMUS_PATH_PERFORMANCE_TOOL &h3300
#define DMUS_PATH_PORT &h4000
#define DMUS_PATH_BUFFER &h6000
#define DMUS_PATH_BUFFER_DMO &h6100
#define DMUS_PATH_MIXIN_BUFFER &h7000
#define DMUS_PATH_MIXIN_BUFFER_DMO &h7100
#define DMUS_PATH_PRIMARY_BUFFER &h8000
#define DMUS_PCHANNEL_ALL &hFFFFFFFB
#define DMUS_APATH_SHARED_STEREOPLUSREVERB 1
#define DMUS_APATH_DYNAMIC_3D 6
#define DMUS_APATH_DYNAMIC_MONO 7
#define DMUS_APATH_DYNAMIC_STEREO 8

type DMUS_AUDIOPARAMS
	dwSize as DWORD
	fInitNow as BOOL
	dwValidData as DWORD
	dwFeatures as DWORD
	dwVoices as DWORD
	dwSampleRate as DWORD
	clsidDefaultSynth as CLSID
end type

#define DMUS_AUDIOF_3D &h1
#define DMUS_AUDIOF_ENVIRON &h2
#define DMUS_AUDIOF_EAX &h4
#define DMUS_AUDIOF_DMOS &h8
#define DMUS_AUDIOF_STREAMING &h10
#define DMUS_AUDIOF_BUFFERS &h20
#define DMUS_AUDIOF_ALL &h3F
#define DMUS_AUDIOPARAMS_FEATURES &h00000001
#define DMUS_AUDIOPARAMS_VOICES &h00000002
#define DMUS_AUDIOPARAMS_SAMPLERATE &h00000004
#define DMUS_AUDIOPARAMS_DEFAULTSYNTH &h00000008

enum DMUS_PMSGF_FLAGS
	DMUS_PMSGF_REFTIME = 1
	DMUS_PMSGF_MUSICTIME = 2
	DMUS_PMSGF_TOOL_IMMEDIATE = 4
	DMUS_PMSGF_TOOL_QUEUE = 8
	DMUS_PMSGF_TOOL_ATTIME = &h10
	DMUS_PMSGF_TOOL_FLUSH = &h20
	DMUS_PMSGF_LOCKTOREFTIME = &h40
	DMUS_PMSGF_DX8 = &h80
end enum

enum DMUS_PMSGT_TYPES
	DMUS_PMSGT_MIDI = 0
	DMUS_PMSGT_NOTE = 1
	DMUS_PMSGT_SYSEX = 2
	DMUS_PMSGT_NOTIFICATION = 3
	DMUS_PMSGT_TEMPO = 4
	DMUS_PMSGT_CURVE = 5
	DMUS_PMSGT_TIMESIG = 6
	DMUS_PMSGT_PATCH = 7
	DMUS_PMSGT_TRANSPOSE = 8
	DMUS_PMSGT_CHANNEL_PRIORITY = 9
	DMUS_PMSGT_STOP = 10
	DMUS_PMSGT_DIRTY = 11
	DMUS_PMSGT_WAVE = 12
	DMUS_PMSGT_LYRIC = 13
	DMUS_PMSGT_SCRIPTLYRIC = 14
	DMUS_PMSGT_USER = 255
end enum

enum DMUS_SEGF_FLAGS
	DMUS_SEGF_REFTIME = 1 shl 6
	DMUS_SEGF_SECONDARY = 1 shl 7
	DMUS_SEGF_QUEUE = 1 shl 8
	DMUS_SEGF_CONTROL = 1 shl 9
	DMUS_SEGF_AFTERPREPARETIME = 1 shl 10
	DMUS_SEGF_GRID = 1 shl 11
	DMUS_SEGF_BEAT = 1 shl 12
	DMUS_SEGF_MEASURE = 1 shl 13
	DMUS_SEGF_DEFAULT = 1 shl 14
	DMUS_SEGF_NOINVALIDATE = 1 shl 15
	DMUS_SEGF_ALIGN = 1 shl 16
	DMUS_SEGF_VALID_START_BEAT = 1 shl 17
	DMUS_SEGF_VALID_START_GRID = 1 shl 18
	DMUS_SEGF_VALID_START_TICK = 1 shl 19
	DMUS_SEGF_AUTOTRANSITION = 1 shl 20
	DMUS_SEGF_AFTERQUEUETIME = 1 shl 21
	DMUS_SEGF_AFTERLATENCYTIME = 1 shl 22
	DMUS_SEGF_SEGMENTEND = 1 shl 23
	DMUS_SEGF_MARKER = 1 shl 24
	DMUS_SEGF_TIMESIG_ALWAYS = 1 shl 25
	DMUS_SEGF_USE_AUDIOPATH = 1 shl 26
	DMUS_SEGF_VALID_START_MEASURE = 1 shl 27
	DMUS_SEGF_INVALIDATE_PRI = 1 shl 28
end enum

#define DMUS_SEG_REPEAT_INFINITE &hFFFFFFFF
#define DMUS_SEG_ALLTRACKS &h80000000
#define DMUS_SEG_ANYTRACK &h80000000

enum DMUS_TIME_RESOLVE_FLAGS
	DMUS_TIME_RESOLVE_AFTERPREPARETIME = DMUS_SEGF_AFTERPREPARETIME
	DMUS_TIME_RESOLVE_AFTERQUEUETIME = DMUS_SEGF_AFTERQUEUETIME
	DMUS_TIME_RESOLVE_AFTERLATENCYTIME = DMUS_SEGF_AFTERLATENCYTIME
	DMUS_TIME_RESOLVE_GRID = DMUS_SEGF_GRID
	DMUS_TIME_RESOLVE_BEAT = DMUS_SEGF_BEAT
	DMUS_TIME_RESOLVE_MEASURE = DMUS_SEGF_MEASURE
	DMUS_TIME_RESOLVE_MARKER = DMUS_SEGF_MARKER
	DMUS_TIME_RESOLVE_SEGMENTEND = DMUS_SEGF_SEGMENTEND
end enum

enum DMUS_CHORDKEYF_FLAGS
	DMUS_CHORDKEYF_SILENT = 1
end enum

#define DMUS_MAXSUBCHORD 8

type DMUS_SUBCHORD
	dwChordPattern as DWORD
	dwScalePattern as DWORD
	dwInversionPoints as DWORD
	dwLevels as DWORD
	bChordRoot as UBYTE
	bScaleRoot as UBYTE
end type

type DMUS_CHORD_KEY
	wszName(0 to 16-1) as WCHAR
	wMeasure as WORD
	bBeat as UBYTE
	bSubChordCount as UBYTE
	SubChordList(0 to 8-1) as DMUS_SUBCHORD
	dwScale as DWORD
	bKey as UBYTE
	bFlags as UBYTE
end type

type DMUS_NOTE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	mtDuration as MUSIC_TIME
	wMusicValue as WORD
	wMeasure as WORD
	nOffset as short
	bBeat as UBYTE
	bGrid as UBYTE
	bVelocity as UBYTE
	bFlags as UBYTE
	bTimeRange as UBYTE
	bDurRange as UBYTE
	bVelRange as UBYTE
	bPlayModeFlags as UBYTE
	bSubChordLevel as UBYTE
	bMidiValue as UBYTE
	cTranspose as byte
end type

enum DMUS_NOTEF_FLAGS
	DMUS_NOTEF_NOTEON = 1
	DMUS_NOTEF_NOINVALIDATE = 2
	DMUS_NOTEF_NOINVALIDATE_INSCALE = 4
	DMUS_NOTEF_NOINVALIDATE_INCHORD = 8
	DMUS_NOTEF_REGENERATE = &h10
end enum

enum DMUS_PLAYMODE_FLAGS
	DMUS_PLAYMODE_KEY_ROOT = 1
	DMUS_PLAYMODE_CHORD_ROOT = 2
	DMUS_PLAYMODE_SCALE_INTERVALS = 4
	DMUS_PLAYMODE_CHORD_INTERVALS = 8
	DMUS_PLAYMODE_NONE = 16
end enum

#define DMUS_PLAYMODE_FIXED 0

type DMUS_MIDI_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	bStatus as UBYTE
	bByte1 as UBYTE
	bByte2 as UBYTE
	bPad(0 to 1-1) as UBYTE
end type

type DMUS_PATCH_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	byInstrument as UBYTE
	byMSB as UBYTE
	byLSB as UBYTE
	byPad(0 to 1-1) as UBYTE
end type

type DMUS_TRANSPOSE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	nTranspose as short
	wMergeIndex as WORD
end type

type DMUS_CHANNEL_PRIORITY_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	dwChannelPriority as DWORD
end type

type DMUS_TEMPO_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	dblTempo as double
end type

#define DMUS_TEMPO_MAX 1000
#define DMUS_TEMPO_MIN 1
#define DMUS_MASTERTEMPO_MAX 100.0f
#define DMUS_MASTERTEMPO_MIN 0.01f

type DMUS_SYSEX_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	dwLen as DWORD
	abData(0 to 1-1) as UBYTE
end type

type DMUS_CURVE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	mtDuration as MUSIC_TIME
	mtOriginalStart as MUSIC_TIME
	mtResetDuration as MUSIC_TIME
	nStartValue as short
	nEndValue as short
	nResetValue as short
	wMeasure as WORD
	nOffset as short
	bBeat as UBYTE
	bGrid as UBYTE
	bType as UBYTE
	bCurveShape as UBYTE
	bCCData as UBYTE
	bFlags as UBYTE
	wParamType as WORD
	wMergeIndex as WORD
end type

enum DMUS_CURVE_FLAGS
	DMUS_CURVE_RESET = 1
	DMUS_CURVE_START_FROM_CURRENT = 2
end enum

enum 
	DMUS_CURVES_LINEAR = 0
	DMUS_CURVES_INSTANT = 1
	DMUS_CURVES_EXP = 2
	DMUS_CURVES_LOG = 3
	DMUS_CURVES_SINE = 4
end enum

#define DMUS_CURVET_PBCURVE &h03
#define DMUS_CURVET_CCCURVE &h04
#define DMUS_CURVET_MATCURVE &h05
#define DMUS_CURVET_PATCURVE &h06
#define DMUS_CURVET_RPNCURVE &h07
#define DMUS_CURVET_NRPNCURVE &h08

type DMUS_TIMESIG_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	bBeatsPerMeasure as UBYTE
	bBeat as UBYTE
	wGridsPerBeat as WORD
end type

#define DMUS_NOTIFICATION_SEGSTART 0
#define DMUS_NOTIFICATION_SEGEND 1
#define DMUS_NOTIFICATION_SEGALMOSTEND 2
#define DMUS_NOTIFICATION_SEGLOOP 3
#define DMUS_NOTIFICATION_SEGABORT 4
#define DMUS_NOTIFICATION_MUSICSTARTED 0
#define DMUS_NOTIFICATION_MUSICSTOPPED 1
#define DMUS_NOTIFICATION_MUSICALMOSTEND 2
#define DMUS_NOTIFICATION_MEASUREBEAT 0
#define DMUS_NOTIFICATION_CHORD 0
#define DMUS_NOTIFICATION_GROOVE 0
#define DMUS_NOTIFICATION_EMBELLISHMENT 1
#define DMUS_NOTIFICATION_RECOMPOSE 0

type DMUS_NOTIFICATION_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	guidNotificationType as GUID
	dwNotificationOption as DWORD
	dwField1 as DWORD
	dwField2 as DWORD
end type

type DMUS_WAVE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	rtStartOffset as REFERENCE_TIME
	rtDuration as REFERENCE_TIME
	lOffset as integer
	lVolume as integer
	lPitch as integer
	bFlags as UBYTE
end type

#define DMUS_WAVEF_OFF 1
#define DMUS_WAVEF_STREAMING 2
#define DMUS_WAVEF_NOINVALIDATE 4
#define DMUS_WAVEF_NOPREROLL 8
#define DMUS_WAVEF_IGNORELOOPS &h20

type DMUS_LYRIC_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool_ ptr
	pGraph as IDirectMusicGraph_ ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	wszString(0 to 1-1) as WCHAR
end type

#define DMUS_MAX_NAME 64
#define DMUS_MAX_CATEGORY 64
#define DMUS_MAX_FILENAME 260

type DMUS_VERSION
	dwVersionMS as DWORD
	dwVersionLS as DWORD
end type

type LPDMUS_VERSION as DMUS_VERSION ptr

type DMUS_TIMESIGNATURE
	mtTime as MUSIC_TIME
	bBeatsPerMeasure as UBYTE
	bBeat as UBYTE
	wGridsPerBeat as WORD
end type

type DMUS_VALID_START_PARAM
	mtTime as MUSIC_TIME
end type

type DMUS_PLAY_MARKER_PARAM
	mtTime as MUSIC_TIME
end type

type DMUS_OBJECTDESC
	dwSize as DWORD
	dwValidData as DWORD
	guidObject as GUID
	guidClass as GUID
	ftDate as FILETIME
	vVersion as DMUS_VERSION
	wszName(0 to 64-1) as WCHAR
	wszCategory(0 to 64-1) as WCHAR
	wszFileName(0 to 260-1) as WCHAR
	llMemLength as LONGLONG
	pbMemData as LPBYTE
	pStream as IStream ptr
end type

type LPDMUS_OBJECTDESC as DMUS_OBJECTDESC ptr

#define DMUS_OBJ_OBJECT (1 shl 0)
#define DMUS_OBJ_CLASS (1 shl 1)
#define DMUS_OBJ_NAME (1 shl 2)
#define DMUS_OBJ_CATEGORY (1 shl 3)
#define DMUS_OBJ_FILENAME (1 shl 4)
#define DMUS_OBJ_FULLPATH (1 shl 5)
#define DMUS_OBJ_URL (1 shl 6)
#define DMUS_OBJ_VERSION (1 shl 7)
#define DMUS_OBJ_DATE (1 shl 8)
#define DMUS_OBJ_LOADED (1 shl 9)
#define DMUS_OBJ_MEMORY (1 shl 10)
#define DMUS_OBJ_STREAM (1 shl 11)

type DMUS_SCRIPT_ERRORINFO
	dwSize as DWORD
	hr as HRESULT
	ulLineNumber as ULONG
	ichCharPosition as LONG
	wszSourceFile(0 to 260-1) as WCHAR
	wszSourceComponent(0 to 260-1) as WCHAR
	wszDescription(0 to 260-1) as WCHAR
	wszSourceLineText(0 to 260-1) as WCHAR
end type

#define DMUS_TRACKCONFIG_OVERRIDE_ALL 1
#define DMUS_TRACKCONFIG_OVERRIDE_PRIMARY 2
#define DMUS_TRACKCONFIG_FALLBACK 4
#define DMUS_TRACKCONFIG_CONTROL_ENABLED 8
#define DMUS_TRACKCONFIG_PLAY_ENABLED &h10
#define DMUS_TRACKCONFIG_NOTIFICATION_ENABLED &h20
#define DMUS_TRACKCONFIG_PLAY_CLOCKTIME &h40
#define DMUS_TRACKCONFIG_PLAY_COMPOSE &h80
#define DMUS_TRACKCONFIG_LOOP_COMPOSE &h100
#define DMUS_TRACKCONFIG_COMPOSING &h200
#define DMUS_TRACKCONFIG_CONTROL_PLAY &h10000
#define DMUS_TRACKCONFIG_CONTROL_NOTIFICATION &h20000
#define DMUS_TRACKCONFIG_TRANS1_FROMSEGSTART &h400
#define DMUS_TRACKCONFIG_TRANS1_FROMSEGCURRENT &h800
#define DMUS_TRACKCONFIG_TRANS1_TOSEGSTART &h1000
#define DMUS_TRACKCONFIG_DEFAULT (8 or &h10 or &h20)

type DMUS_COMMAND_PARAM
	bCommand as UBYTE
	bGrooveLevel as UBYTE
	bGrooveRange as UBYTE
	bRepeatMode as UBYTE
end type

type DMUS_COMMAND_PARAM_2
	mtTime as MUSIC_TIME
	bCommand as UBYTE
	bGrooveLevel as UBYTE
	bGrooveRange as UBYTE
	bRepeatMode as UBYTE
end type

type LPDMUS_OBJECT as IDirectMusicObject ptr
type LPDMUS_LOADER as IDirectMusicLoader ptr
type LPDMUS_BAND as IDirectMusicBand ptr

#define DMUSB_LOADED (1 shl 0)
#define DMUSB_DEFAULT (1 shl 1)

type IDirectMusicBandVtbl_ as IDirectMusicBandVtbl

type IDirectMusicBand
	lpVtbl as IDirectMusicBandVtbl_ ptr
end type

type IDirectMusicSegment_ as IDirectMusicSegment
type IDirectMusicPerformance_ as IDirectMusicPerformance

type IDirectMusicBandVtbl
	QueryInterface as function(byval as IDirectMusicBand ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicBand ptr) as ULONG
	Release as function(byval as IDirectMusicBand ptr) as ULONG
	CreateSegment as function(byval as IDirectMusicBand ptr, byval as IDirectMusicSegment_ ptr ptr) as HRESULT
	Download as function(byval as IDirectMusicBand ptr, byval as IDirectMusicPerformance_ ptr) as HRESULT
	Unload as function(byval as IDirectMusicBand ptr, byval as IDirectMusicPerformance_ ptr) as HRESULT
end type

type IDirectMusicBand8 as IDirectMusicBand

type IDirectMusicObjectVtbl_ as IDirectMusicObjectVtbl

type IDirectMusicObject
	lpVtbl as IDirectMusicObjectVtbl_ ptr
end type

type IDirectMusicObjectVtbl
	QueryInterface as function(byval as IDirectMusicObject ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicObject ptr) as ULONG
	Release as function(byval as IDirectMusicObject ptr) as ULONG
	GetDescriptor as function(byval as IDirectMusicObject ptr, byval as LPDMUS_OBJECTDESC) as HRESULT
	SetDescriptor as function(byval as IDirectMusicObject ptr, byval as LPDMUS_OBJECTDESC) as HRESULT
	ParseDescriptor as function(byval as IDirectMusicObject ptr, byval as LPSTREAM, byval as LPDMUS_OBJECTDESC) as HRESULT
end type

type IDirectMusicObject8 as IDirectMusicObject

type IDirectMusicLoaderVtbl_ as IDirectMusicLoaderVtbl

type IDirectMusicLoader
	lpVtbl as IDirectMusicLoaderVtbl_ ptr
end type

type IDirectMusicLoaderVtbl
	QueryInterface as function(byval as IDirectMusicLoader ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicLoader ptr) as ULONG
	Release as function(byval as IDirectMusicLoader ptr) as ULONG
	GetObjectA as function(byval as IDirectMusicLoader ptr, byval as LPDMUS_OBJECTDESC, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	SetObject as function(byval as IDirectMusicLoader ptr, byval as LPDMUS_OBJECTDESC) as HRESULT
	SetSearchDirectory as function(byval as IDirectMusicLoader ptr, byval as GUID ptr, byval as WCHAR ptr, byval as BOOL) as HRESULT
	ScanDirectory as function(byval as IDirectMusicLoader ptr, byval as GUID ptr, byval as WCHAR ptr, byval as WCHAR ptr) as HRESULT
	CacheObject as function(byval as IDirectMusicLoader ptr, byval as IDirectMusicObject ptr) as HRESULT
	ReleaseObject as function(byval as IDirectMusicLoader ptr, byval as IDirectMusicObject ptr) as HRESULT
	ClearCache as function(byval as IDirectMusicLoader ptr, byval as GUID ptr) as HRESULT
	EnableCache as function(byval as IDirectMusicLoader ptr, byval as GUID ptr, byval as BOOL) as HRESULT
	EnumObject as function(byval as IDirectMusicLoader ptr, byval as GUID ptr, byval as DWORD, byval as LPDMUS_OBJECTDESC) as HRESULT
end type

type IDirectMusicLoader8Vtbl_ as IDirectMusicLoader8Vtbl

type IDirectMusicLoader8
	lpVtbl as IDirectMusicLoader8Vtbl_ ptr
end type

type IDirectMusicLoader8Vtbl
	QueryInterface as function(byval as IDirectMusicLoader8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicLoader8 ptr) as ULONG
	Release as function(byval as IDirectMusicLoader8 ptr) as ULONG
	GetObjectA as function(byval as IDirectMusicLoader8 ptr, byval as LPDMUS_OBJECTDESC, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	SetObject as function(byval as IDirectMusicLoader8 ptr, byval as LPDMUS_OBJECTDESC) as HRESULT
	SetSearchDirectory as function(byval as IDirectMusicLoader8 ptr, byval as GUID ptr, byval as WCHAR ptr, byval as BOOL) as HRESULT
	ScanDirectory as function(byval as IDirectMusicLoader8 ptr, byval as GUID ptr, byval as WCHAR ptr, byval as WCHAR ptr) as HRESULT
	CacheObject as function(byval as IDirectMusicLoader8 ptr, byval as IDirectMusicObject ptr) as HRESULT
	ReleaseObject as function(byval as IDirectMusicLoader8 ptr, byval as IDirectMusicObject ptr) as HRESULT
	ClearCache as function(byval as IDirectMusicLoader8 ptr, byval as GUID ptr) as HRESULT
	EnableCache as function(byval as IDirectMusicLoader8 ptr, byval as GUID ptr, byval as BOOL) as HRESULT
	EnumObject as function(byval as IDirectMusicLoader8 ptr, byval as GUID ptr, byval as DWORD, byval as LPDMUS_OBJECTDESC) as HRESULT
	CollectGarbage as sub(byval as IDirectMusicLoader8 ptr)
	ReleaseObjectByUnknown as function(byval as IDirectMusicLoader8 ptr, byval as IUnknown ptr) as HRESULT
	LoadObjectFromFile as function(byval as IDirectMusicLoader8 ptr, byval as GUID ptr, byval as IID ptr, byval as WCHAR ptr, byval as any ptr ptr) as HRESULT
end type

type IDirectMusicGetLoaderVtbl_ as IDirectMusicGetLoaderVtbl

type IDirectMusicGetLoader
	lpVtbl as IDirectMusicGetLoaderVtbl_ ptr
end type

type IDirectMusicGetLoaderVtbl
	QueryInterface as function(byval as IDirectMusicGetLoader ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicGetLoader ptr) as ULONG
	Release as function(byval as IDirectMusicGetLoader ptr) as ULONG
	GetLoader as function(byval as IDirectMusicGetLoader ptr, byval as IDirectMusicLoader ptr ptr) as HRESULT
end type

type IDirectMusicGetLoader8 as IDirectMusicGetLoader

type IDirectMusicSegmentVtbl_ as IDirectMusicSegmentVtbl

type IDirectMusicSegment
	lpVtbl as IDirectMusicSegmentVtbl_ ptr
end type

type IDirectMusicTrack_ as IDirectMusicTrack
type IDirectMusicSegmentState_ as IDirectMusicSegmentState

type IDirectMusicSegmentVtbl
	QueryInterface as function(byval as IDirectMusicSegment ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSegment ptr) as ULONG
	Release as function(byval as IDirectMusicSegment ptr) as ULONG
	GetLength as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetLength as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME) as HRESULT
	GetRepeats as function(byval as IDirectMusicSegment ptr, byval as DWORD ptr) as HRESULT
	SetRepeats as function(byval as IDirectMusicSegment ptr, byval as DWORD) as HRESULT
	GetDefaultResolution as function(byval as IDirectMusicSegment ptr, byval as DWORD ptr) as HRESULT
	SetDefaultResolution as function(byval as IDirectMusicSegment ptr, byval as DWORD) as HRESULT
	GetTrack as function(byval as IDirectMusicSegment ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as IDirectMusicTrack_ ptr ptr) as HRESULT
	GetTrackGroup as function(byval as IDirectMusicSegment ptr, byval as IDirectMusicTrack_ ptr, byval as DWORD ptr) as HRESULT
	InsertTrack as function(byval as IDirectMusicSegment ptr, byval as IDirectMusicTrack_ ptr, byval as DWORD) as HRESULT
	RemoveTrack as function(byval as IDirectMusicSegment ptr, byval as IDirectMusicTrack_ ptr) as HRESULT
	InitPlay as function(byval as IDirectMusicSegment ptr, byval as IDirectMusicSegmentState_ ptr ptr, byval as IDirectMusicPerformance_ ptr, byval as DWORD) as HRESULT
	GetGraph as function(byval as IDirectMusicSegment ptr, byval as IDirectMusicGraph_ ptr ptr) as HRESULT
	SetGraph as function(byval as IDirectMusicSegment ptr, byval as IDirectMusicGraph_ ptr) as HRESULT
	AddNotificationType as function(byval as IDirectMusicSegment ptr, byval as GUID ptr) as HRESULT
	RemoveNotificationType as function(byval as IDirectMusicSegment ptr, byval as GUID ptr) as HRESULT
	GetParam as function(byval as IDirectMusicSegment ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
	SetParam as function(byval as IDirectMusicSegment ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as any ptr) as HRESULT
	Clone as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as IDirectMusicSegment ptr ptr) as HRESULT
	SetStartPoint as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME) as HRESULT
	GetStartPoint as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetLoopPoints as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME, byval as MUSIC_TIME) as HRESULT
	GetLoopPoints as function(byval as IDirectMusicSegment ptr, byval as MUSIC_TIME ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetPChannelsUsed as function(byval as IDirectMusicSegment ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

type IDirectMusicSegment8Vtbl_ as IDirectMusicSegment8Vtbl

type IDirectMusicSegment8
	lpVtbl as IDirectMusicSegment8Vtbl_ ptr
end type

type IDirectMusicSegment8Vtbl
	QueryInterface as function(byval as IDirectMusicSegment8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSegment8 ptr) as ULONG
	Release as function(byval as IDirectMusicSegment8 ptr) as ULONG
	GetLength as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetLength as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME) as HRESULT
	GetRepeats as function(byval as IDirectMusicSegment8 ptr, byval as DWORD ptr) as HRESULT
	SetRepeats as function(byval as IDirectMusicSegment8 ptr, byval as DWORD) as HRESULT
	GetDefaultResolution as function(byval as IDirectMusicSegment8 ptr, byval as DWORD ptr) as HRESULT
	SetDefaultResolution as function(byval as IDirectMusicSegment8 ptr, byval as DWORD) as HRESULT
	GetTrack as function(byval as IDirectMusicSegment8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as IDirectMusicTrack_ ptr ptr) as HRESULT
	GetTrackGroup as function(byval as IDirectMusicSegment8 ptr, byval as IDirectMusicTrack_ ptr, byval as DWORD ptr) as HRESULT
	InsertTrack as function(byval as IDirectMusicSegment8 ptr, byval as IDirectMusicTrack_ ptr, byval as DWORD) as HRESULT
	RemoveTrack as function(byval as IDirectMusicSegment8 ptr, byval as IDirectMusicTrack_ ptr) as HRESULT
	InitPlay as function(byval as IDirectMusicSegment8 ptr, byval as IDirectMusicSegmentState_ ptr ptr, byval as IDirectMusicPerformance_ ptr, byval as DWORD) as HRESULT
	GetGraph as function(byval as IDirectMusicSegment8 ptr, byval as IDirectMusicGraph_ ptr ptr) as HRESULT
	SetGraph as function(byval as IDirectMusicSegment8 ptr, byval as IDirectMusicGraph_ ptr) as HRESULT
	AddNotificationType as function(byval as IDirectMusicSegment8 ptr, byval as GUID ptr) as HRESULT
	RemoveNotificationType as function(byval as IDirectMusicSegment8 ptr, byval as GUID ptr) as HRESULT
	GetParam as function(byval as IDirectMusicSegment8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
	SetParam as function(byval as IDirectMusicSegment8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as any ptr) as HRESULT
	Clone as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as IDirectMusicSegment_ ptr ptr) as HRESULT
	SetStartPoint as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME) as HRESULT
	GetStartPoint as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetLoopPoints as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME, byval as MUSIC_TIME) as HRESULT
	GetLoopPoints as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetPChannelsUsed as function(byval as IDirectMusicSegment8 ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
	SetTrackConfig as function(byval as IDirectMusicSegment8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	GetAudioPathConfig as function(byval as IDirectMusicSegment8 ptr, byval as IUnknown ptr ptr) as HRESULT
	Compose as function(byval as IDirectMusicSegment8 ptr, byval as MUSIC_TIME, byval as IDirectMusicSegment_ ptr, byval as IDirectMusicSegment ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	Download as function(byval as IDirectMusicSegment8 ptr, byval as IUnknown ptr) as HRESULT
	Unload as function(byval as IDirectMusicSegment8 ptr, byval as IUnknown ptr) as HRESULT
end type

type IDirectMusicSegmentStateVtbl_ as IDirectMusicSegmentStateVtbl

type IDirectMusicSegmentState
	lpVtbl as IDirectMusicSegmentStateVtbl_ ptr
end type

type IDirectMusicSegmentStateVtbl
	QueryInterface as function(byval as IDirectMusicSegmentState ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSegmentState ptr) as ULONG
	Release as function(byval as IDirectMusicSegmentState ptr) as ULONG
	GetRepeats as function(byval as IDirectMusicSegmentState ptr, byval as DWORD ptr) as HRESULT
	GetSegment as function(byval as IDirectMusicSegmentState ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	GetStartTime as function(byval as IDirectMusicSegmentState ptr, byval as MUSIC_TIME ptr) as HRESULT
	GetSeek as function(byval as IDirectMusicSegmentState ptr, byval as MUSIC_TIME ptr) as HRESULT
	GetStartPoint as function(byval as IDirectMusicSegmentState ptr, byval as MUSIC_TIME ptr) as HRESULT
end type

type IDirectMusicSegmentState8Vtbl_ as IDirectMusicSegmentState8Vtbl

type IDirectMusicSegmentState8
	lpVtbl as IDirectMusicSegmentState8Vtbl_ ptr
end type

type IDirectMusicSegmentState8Vtbl
	QueryInterface as function(byval as IDirectMusicSegmentState8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSegmentState8 ptr) as ULONG
	Release as function(byval as IDirectMusicSegmentState8 ptr) as ULONG
	GetRepeats as function(byval as IDirectMusicSegmentState8 ptr, byval as DWORD ptr) as HRESULT
	GetSegment as function(byval as IDirectMusicSegmentState8 ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	GetStartTime as function(byval as IDirectMusicSegmentState8 ptr, byval as MUSIC_TIME ptr) as HRESULT
	GetSeek as function(byval as IDirectMusicSegmentState8 ptr, byval as MUSIC_TIME ptr) as HRESULT
	GetStartPoint as function(byval as IDirectMusicSegmentState8 ptr, byval as MUSIC_TIME ptr) as HRESULT
	SetTrackConfig as function(byval as IDirectMusicSegmentState8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	GetObjectInPath as function(byval as IDirectMusicSegmentState8 ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as GUID ptr, byval as DWORD, byval as GUID ptr, byval as any ptr ptr) as HRESULT
end type

type IDirectMusicAudioPathVtbl_ as IDirectMusicAudioPathVtbl

type IDirectMusicAudioPath
	lpVtbl as IDirectMusicAudioPathVtbl_ ptr
end type

type IDirectMusicAudioPathVtbl
	QueryInterface as function(byval as IDirectMusicAudioPath ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicAudioPath ptr) as ULONG
	Release as function(byval as IDirectMusicAudioPath ptr) as ULONG
	GetObjectInPath as function(byval as IDirectMusicAudioPath ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as GUID ptr, byval as DWORD, byval as GUID ptr, byval as any ptr ptr) as HRESULT
	Activate as function(byval as IDirectMusicAudioPath ptr, byval as BOOL) as HRESULT
	SetVolume as function(byval as IDirectMusicAudioPath ptr, byval as integer, byval as DWORD) as HRESULT
	ConvertPChannel as function(byval as IDirectMusicAudioPath ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

type IDirectMusicAudioPath8 as IDirectMusicAudioPath

type IDirectMusicPerformanceVtbl_ as IDirectMusicPerformanceVtbl

type IDirectMusicPerformance
	lpVtbl as IDirectMusicPerformanceVtbl_ ptr
end type

type IDirectMusicPerformanceVtbl
	QueryInterface as function(byval as IDirectMusicPerformance ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicPerformance ptr) as ULONG
	Release as function(byval as IDirectMusicPerformance ptr) as ULONG
	Init as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusic ptr ptr, byval as LPDIRECTSOUND, byval as HWND) as HRESULT
	PlaySegment as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegment ptr, byval as DWORD, byval as longint, byval as IDirectMusicSegmentState ptr ptr) as HRESULT
	Stop as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegment ptr, byval as IDirectMusicSegmentState ptr, byval as MUSIC_TIME, byval as DWORD) as HRESULT
	GetSegmentState as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegmentState ptr ptr, byval as MUSIC_TIME) as HRESULT
	SetPrepareTime as function(byval as IDirectMusicPerformance ptr, byval as DWORD) as HRESULT
	GetPrepareTime as function(byval as IDirectMusicPerformance ptr, byval as DWORD ptr) as HRESULT
	SetBumperLength as function(byval as IDirectMusicPerformance ptr, byval as DWORD) as HRESULT
	GetBumperLength as function(byval as IDirectMusicPerformance ptr, byval as DWORD ptr) as HRESULT
	SendPMsg as function(byval as IDirectMusicPerformance ptr, byval as DMUS_PMSG ptr) as HRESULT
	MusicToReferenceTime as function(byval as IDirectMusicPerformance ptr, byval as MUSIC_TIME, byval as REFERENCE_TIME ptr) as HRESULT
	ReferenceToMusicTime as function(byval as IDirectMusicPerformance ptr, byval as REFERENCE_TIME, byval as MUSIC_TIME ptr) as HRESULT
	IsPlaying as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegment ptr, byval as IDirectMusicSegmentState ptr) as HRESULT
	GetTime as function(byval as IDirectMusicPerformance ptr, byval as REFERENCE_TIME ptr, byval as MUSIC_TIME ptr) as HRESULT
	AllocPMsg as function(byval as IDirectMusicPerformance ptr, byval as ULONG, byval as DMUS_PMSG ptr ptr) as HRESULT
	FreePMsg as function(byval as IDirectMusicPerformance ptr, byval as DMUS_PMSG ptr) as HRESULT
	GetGraph as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicGraph_ ptr ptr) as HRESULT
	SetGraph as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicGraph_ ptr) as HRESULT
	SetNotificationHandle as function(byval as IDirectMusicPerformance ptr, byval as HANDLE, byval as REFERENCE_TIME) as HRESULT
	GetNotificationPMsg as function(byval as IDirectMusicPerformance ptr, byval as DMUS_NOTIFICATION_PMSG ptr ptr) as HRESULT
	AddNotificationType as function(byval as IDirectMusicPerformance ptr, byval as GUID ptr) as HRESULT
	RemoveNotificationType as function(byval as IDirectMusicPerformance ptr, byval as GUID ptr) as HRESULT
	AddPort as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicPort ptr) as HRESULT
	RemovePort as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicPort ptr) as HRESULT
	AssignPChannelBlock as function(byval as IDirectMusicPerformance ptr, byval as DWORD, byval as IDirectMusicPort ptr, byval as DWORD) as HRESULT
	AssignPChannel as function(byval as IDirectMusicPerformance ptr, byval as DWORD, byval as IDirectMusicPort ptr, byval as DWORD, byval as DWORD) as HRESULT
	PChannelInfo as function(byval as IDirectMusicPerformance ptr, byval as DWORD, byval as IDirectMusicPort ptr ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	DownloadInstrument as function(byval as IDirectMusicPerformance ptr, byval as IDirectMusicInstrument ptr, byval as DWORD, byval as IDirectMusicDownloadedInstrument ptr ptr, byval as DMUS_NOTERANGE ptr, byval as DWORD, byval as IDirectMusicPort ptr ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	Invalidate as function(byval as IDirectMusicPerformance ptr, byval as MUSIC_TIME, byval as DWORD) as HRESULT
	GetParam as function(byval as IDirectMusicPerformance ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
	SetParam as function(byval as IDirectMusicPerformance ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as any ptr) as HRESULT
	GetGlobalParam as function(byval as IDirectMusicPerformance ptr, byval as GUID ptr, byval as any ptr, byval as DWORD) as HRESULT
	SetGlobalParam as function(byval as IDirectMusicPerformance ptr, byval as GUID ptr, byval as any ptr, byval as DWORD) as HRESULT
	GetLatencyTime as function(byval as IDirectMusicPerformance ptr, byval as REFERENCE_TIME ptr) as HRESULT
	GetQueueTime as function(byval as IDirectMusicPerformance ptr, byval as REFERENCE_TIME ptr) as HRESULT
	AdjustTime as function(byval as IDirectMusicPerformance ptr, byval as REFERENCE_TIME) as HRESULT
	CloseDown as function(byval as IDirectMusicPerformance ptr) as HRESULT
	GetResolvedTime as function(byval as IDirectMusicPerformance ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME ptr, byval as DWORD) as HRESULT
	MIDIToMusic as function(byval as IDirectMusicPerformance ptr, byval as UBYTE, byval as DMUS_CHORD_KEY ptr, byval as UBYTE, byval as UBYTE, byval as WORD ptr) as HRESULT
	MusicToMIDI as function(byval as IDirectMusicPerformance ptr, byval as WORD, byval as DMUS_CHORD_KEY ptr, byval as UBYTE, byval as UBYTE, byval as UBYTE ptr) as HRESULT
	TimeToRhythm as function(byval as IDirectMusicPerformance ptr, byval as MUSIC_TIME, byval as DMUS_TIMESIGNATURE ptr, byval as WORD ptr, byval as UBYTE ptr, byval as UBYTE ptr, byval as short ptr) as HRESULT
	RhythmToTime as function(byval as IDirectMusicPerformance ptr, byval as WORD, byval as UBYTE, byval as UBYTE, byval as short, byval as DMUS_TIMESIGNATURE ptr, byval as MUSIC_TIME ptr) as HRESULT
end type

type IDirectMusicPerformance8Vtbl_ as IDirectMusicPerformance8Vtbl

type IDirectMusicPerformance8
	lpVtbl as IDirectMusicPerformance8Vtbl_ ptr
end type

type IDirectMusicPerformance8Vtbl
	QueryInterface as function(byval as IDirectMusicPerformance8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicPerformance8 ptr) as ULONG
	Release as function(byval as IDirectMusicPerformance8 ptr) as ULONG
	Init as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusic ptr ptr, byval as LPDIRECTSOUND, byval as HWND) as HRESULT
	PlaySegment as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicSegment ptr, byval as DWORD, byval as longint, byval as IDirectMusicSegmentState ptr ptr) as HRESULT
	Stop as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicSegment ptr, byval as IDirectMusicSegmentState ptr, byval as MUSIC_TIME, byval as DWORD) as HRESULT
	GetSegmentState as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicSegmentState ptr ptr, byval as MUSIC_TIME) as HRESULT
	SetPrepareTime as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD) as HRESULT
	GetPrepareTime as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD ptr) as HRESULT
	SetBumperLength as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD) as HRESULT
	GetBumperLength as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD ptr) as HRESULT
	SendPMsg as function(byval as IDirectMusicPerformance8 ptr, byval as DMUS_PMSG ptr) as HRESULT
	MusicToReferenceTime as function(byval as IDirectMusicPerformance8 ptr, byval as MUSIC_TIME, byval as REFERENCE_TIME ptr) as HRESULT
	ReferenceToMusicTime as function(byval as IDirectMusicPerformance8 ptr, byval as REFERENCE_TIME, byval as MUSIC_TIME ptr) as HRESULT
	IsPlaying as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicSegment ptr, byval as IDirectMusicSegmentState ptr) as HRESULT
	GetTime as function(byval as IDirectMusicPerformance8 ptr, byval as REFERENCE_TIME ptr, byval as MUSIC_TIME ptr) as HRESULT
	AllocPMsg as function(byval as IDirectMusicPerformance8 ptr, byval as ULONG, byval as DMUS_PMSG ptr ptr) as HRESULT
	FreePMsg as function(byval as IDirectMusicPerformance8 ptr, byval as DMUS_PMSG ptr) as HRESULT
	GetGraph as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicGraph_ ptr ptr) as HRESULT
	SetGraph as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicGraph_ ptr) as HRESULT
	SetNotificationHandle as function(byval as IDirectMusicPerformance8 ptr, byval as HANDLE, byval as REFERENCE_TIME) as HRESULT
	GetNotificationPMsg as function(byval as IDirectMusicPerformance8 ptr, byval as DMUS_NOTIFICATION_PMSG ptr ptr) as HRESULT
	AddNotificationType as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr) as HRESULT
	RemoveNotificationType as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr) as HRESULT
	AddPort as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicPort ptr) as HRESULT
	RemovePort as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicPort ptr) as HRESULT
	AssignPChannelBlock as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD, byval as IDirectMusicPort ptr, byval as DWORD) as HRESULT
	AssignPChannel as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD, byval as IDirectMusicPort ptr, byval as DWORD, byval as DWORD) as HRESULT
	PChannelInfo as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD, byval as IDirectMusicPort ptr ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	DownloadInstrument as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicInstrument ptr, byval as DWORD, byval as IDirectMusicDownloadedInstrument ptr ptr, byval as DMUS_NOTERANGE ptr, byval as DWORD, byval as IDirectMusicPort ptr ptr, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	Invalidate as function(byval as IDirectMusicPerformance8 ptr, byval as MUSIC_TIME, byval as DWORD) as HRESULT
	GetParam as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
	SetParam as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as any ptr) as HRESULT
	GetGlobalParam as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD) as HRESULT
	SetGlobalParam as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr, byval as any ptr, byval as DWORD) as HRESULT
	GetLatencyTime as function(byval as IDirectMusicPerformance8 ptr, byval as REFERENCE_TIME ptr) as HRESULT
	GetQueueTime as function(byval as IDirectMusicPerformance8 ptr, byval as REFERENCE_TIME ptr) as HRESULT
	AdjustTime as function(byval as IDirectMusicPerformance8 ptr, byval as REFERENCE_TIME) as HRESULT
	CloseDown as function(byval as IDirectMusicPerformance8 ptr) as HRESULT
	GetResolvedTime as function(byval as IDirectMusicPerformance8 ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME ptr, byval as DWORD) as HRESULT
	MIDIToMusic as function(byval as IDirectMusicPerformance8 ptr, byval as UBYTE, byval as DMUS_CHORD_KEY ptr, byval as UBYTE, byval as UBYTE, byval as WORD ptr) as HRESULT
	MusicToMIDI as function(byval as IDirectMusicPerformance8 ptr, byval as WORD, byval as DMUS_CHORD_KEY ptr, byval as UBYTE, byval as UBYTE, byval as UBYTE ptr) as HRESULT
	TimeToRhythm as function(byval as IDirectMusicPerformance8 ptr, byval as MUSIC_TIME, byval as DMUS_TIMESIGNATURE ptr, byval as WORD ptr, byval as UBYTE ptr, byval as UBYTE ptr, byval as short ptr) as HRESULT
	RhythmToTime as function(byval as IDirectMusicPerformance8 ptr, byval as WORD, byval as UBYTE, byval as UBYTE, byval as short, byval as DMUS_TIMESIGNATURE ptr, byval as MUSIC_TIME ptr) as HRESULT
	InitAudio as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusic ptr ptr, byval as IDirectSound ptr ptr, byval as HWND, byval as DWORD, byval as DWORD, byval as DWORD, byval as DMUS_AUDIOPARAMS ptr) as HRESULT
	PlaySegmentEx as function(byval as IDirectMusicPerformance8 ptr, byval as IUnknown ptr, byval as WCHAR ptr, byval as IUnknown ptr, byval as DWORD, byval as longint, byval as IDirectMusicSegmentState ptr ptr, byval as IUnknown ptr, byval as IUnknown ptr) as HRESULT
	StopEx as function(byval as IDirectMusicPerformance8 ptr, byval as IUnknown ptr, byval as longint, byval as DWORD) as HRESULT
	ClonePMsg as function(byval as IDirectMusicPerformance8 ptr, byval as DMUS_PMSG ptr, byval as DMUS_PMSG ptr ptr) as HRESULT
	CreateAudioPath as function(byval as IDirectMusicPerformance8 ptr, byval as IUnknown ptr, byval as BOOL, byval as IDirectMusicAudioPath ptr ptr) as HRESULT
	CreateStandardAudioPath as function(byval as IDirectMusicPerformance8 ptr, byval as DWORD, byval as DWORD, byval as BOOL, byval as IDirectMusicAudioPath ptr ptr) as HRESULT
	SetDefaultAudioPath as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicAudioPath ptr) as HRESULT
	GetDefaultAudioPath as function(byval as IDirectMusicPerformance8 ptr, byval as IDirectMusicAudioPath ptr ptr) as HRESULT
	GetParamEx as function(byval as IDirectMusicPerformance8 ptr, byval as GUID ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
end type

type IDirectMusicGraphVtbl_ as IDirectMusicGraphVtbl

type IDirectMusicGraph
	lpVtbl as IDirectMusicGraphVtbl_ ptr
end type

type IDirectMusicGraphVtbl
	QueryInterface as function(byval as IDirectMusicGraph ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicGraph ptr) as ULONG
	Release as function(byval as IDirectMusicGraph ptr) as ULONG
	StampPMsg as function(byval as IDirectMusicGraph ptr, byval as DMUS_PMSG ptr) as HRESULT
	InsertTool as function(byval as IDirectMusicGraph ptr, byval as IDirectMusicTool_ ptr, byval as DWORD ptr, byval as DWORD, byval as LONG) as HRESULT
	GetTool as function(byval as IDirectMusicGraph ptr, byval as DWORD, byval as IDirectMusicTool_ ptr ptr) as HRESULT
	RemoveTool as function(byval as IDirectMusicGraph ptr, byval as IDirectMusicTool_ ptr) as HRESULT
end type

type IDirectMusicGraph8 as IDirectMusicGraph

type IDirectMusicStyleVtbl_ as IDirectMusicStyleVtbl

type IDirectMusicStyle
	lpVtbl as IDirectMusicStyleVtbl_ ptr
end type

type IDirectMusicChordMap_ as IDirectMusicChordMap

type IDirectMusicStyleVtbl
	QueryInterface as function(byval as IDirectMusicStyle ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicStyle ptr) as ULONG
	Release as function(byval as IDirectMusicStyle ptr) as ULONG
	GetBand as function(byval as IDirectMusicStyle ptr, byval as WCHAR ptr, byval as IDirectMusicBand ptr ptr) as HRESULT
	EnumBand as function(byval as IDirectMusicStyle ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	GetDefaultBand as function(byval as IDirectMusicStyle ptr, byval as IDirectMusicBand ptr ptr) as HRESULT
	EnumMotif as function(byval as IDirectMusicStyle ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	GetMotif as function(byval as IDirectMusicStyle ptr, byval as WCHAR ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	GetDefaultChordMap as function(byval as IDirectMusicStyle ptr, byval as IDirectMusicChordMap_ ptr ptr) as HRESULT
	EnumChordMap as function(byval as IDirectMusicStyle ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	GetChordMap as function(byval as IDirectMusicStyle ptr, byval as WCHAR ptr, byval as IDirectMusicChordMap_ ptr ptr) as HRESULT
	GetTimeSignature as function(byval as IDirectMusicStyle ptr, byval as DMUS_TIMESIGNATURE ptr) as HRESULT
	GetEmbellishmentLength as function(byval as IDirectMusicStyle ptr, byval as DWORD, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GetTempo as function(byval as IDirectMusicStyle ptr, byval as double ptr) as HRESULT
end type

type IDirectMusicStyle8Vtbl_ as IDirectMusicStyle8Vtbl

type IDirectMusicStyle8
	lpVtbl as IDirectMusicStyle8Vtbl_ ptr
end type

type IDirectMusicStyle8Vtbl
	QueryInterface as function(byval as IDirectMusicStyle8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicStyle8 ptr) as ULONG
	Release as function(byval as IDirectMusicStyle8 ptr) as ULONG
	GetBand as function(byval as IDirectMusicStyle8 ptr, byval as WCHAR ptr, byval as IDirectMusicBand ptr ptr) as HRESULT
	EnumBand as function(byval as IDirectMusicStyle8 ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	GetDefaultBand as function(byval as IDirectMusicStyle8 ptr, byval as IDirectMusicBand ptr ptr) as HRESULT
	EnumMotif as function(byval as IDirectMusicStyle8 ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	GetMotif as function(byval as IDirectMusicStyle8 ptr, byval as WCHAR ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	GetDefaultChordMap as function(byval as IDirectMusicStyle8 ptr, byval as IDirectMusicChordMap_ ptr ptr) as HRESULT
	EnumChordMap as function(byval as IDirectMusicStyle8 ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	GetChordMap as function(byval as IDirectMusicStyle8 ptr, byval as WCHAR ptr, byval as IDirectMusicChordMap_ ptr ptr) as HRESULT
	GetTimeSignature as function(byval as IDirectMusicStyle8 ptr, byval as DMUS_TIMESIGNATURE ptr) as HRESULT
	GetEmbellishmentLength as function(byval as IDirectMusicStyle8 ptr, byval as DWORD, byval as DWORD, byval as DWORD ptr, byval as DWORD ptr) as HRESULT
	GetTempo as function(byval as IDirectMusicStyle8 ptr, byval as double ptr) as HRESULT
	EnumPattern as function(byval as IDirectMusicStyle8 ptr, byval as DWORD, byval as DWORD, byval as WCHAR ptr) as HRESULT
end type

type IDirectMusicChordMapVtbl_ as IDirectMusicChordMapVtbl

type IDirectMusicChordMap
	lpVtbl as IDirectMusicChordMapVtbl_ ptr
end type

type IDirectMusicChordMapVtbl
	QueryInterface as function(byval as IDirectMusicChordMap ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicChordMap ptr) as ULONG
	Release as function(byval as IDirectMusicChordMap ptr) as ULONG
	GetScale as function(byval as IDirectMusicChordMap ptr, byval as DWORD ptr) as HRESULT
end type

type IDirectMusicChordMap8 as IDirectMusicChordMap

type IDirectMusicComposerVtbl_ as IDirectMusicComposerVtbl

type IDirectMusicComposer
	lpVtbl as IDirectMusicComposerVtbl_ ptr
end type

type IDirectMusicComposerVtbl
	QueryInterface as function(byval as IDirectMusicComposer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicComposer ptr) as ULONG
	Release as function(byval as IDirectMusicComposer ptr) as ULONG
	ComposeSegmentFromTemplate as function(byval as IDirectMusicComposer ptr, byval as IDirectMusicStyle ptr, byval as IDirectMusicSegment ptr, byval as WORD, byval as IDirectMusicChordMap ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	ComposeSegmentFromShape as function(byval as IDirectMusicComposer ptr, byval as IDirectMusicStyle ptr, byval as WORD, byval as WORD, byval as WORD, byval as BOOL, byval as BOOL, byval as IDirectMusicChordMap ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	ComposeTransition as function(byval as IDirectMusicComposer ptr, byval as IDirectMusicSegment ptr, byval as IDirectMusicSegment ptr, byval as MUSIC_TIME, byval as WORD, byval as DWORD, byval as IDirectMusicChordMap ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	AutoTransition as function(byval as IDirectMusicComposer ptr, byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegment ptr, byval as WORD, byval as DWORD, byval as IDirectMusicChordMap ptr, byval as IDirectMusicSegment ptr ptr, byval as IDirectMusicSegmentState ptr ptr, byval as IDirectMusicSegmentState ptr ptr) as HRESULT
	ComposeTemplateFromShape as function(byval as IDirectMusicComposer ptr, byval as WORD, byval as WORD, byval as BOOL, byval as BOOL, byval as WORD, byval as IDirectMusicSegment ptr ptr) as HRESULT
	ChangeChordMap as function(byval as IDirectMusicComposer ptr, byval as IDirectMusicSegment ptr, byval as BOOL, byval as IDirectMusicChordMap ptr) as HRESULT
end type

type IDirectMusicComposer8 as IDirectMusicComposer

type IDirectMusicPatternTrackVtbl_ as IDirectMusicPatternTrackVtbl

type IDirectMusicPatternTrack
	lpVtbl as IDirectMusicPatternTrackVtbl_ ptr
end type

type IDirectMusicPatternTrackVtbl
	QueryInterface as function(byval as IDirectMusicPatternTrack ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicPatternTrack ptr) as ULONG
	Release as function(byval as IDirectMusicPatternTrack ptr) as ULONG
	CreateSegment as function(byval as IDirectMusicPatternTrack ptr, byval as IDirectMusicStyle ptr, byval as IDirectMusicSegment ptr ptr) as HRESULT
	SetVariation as function(byval as IDirectMusicPatternTrack ptr, byval as IDirectMusicSegmentState ptr, byval as DWORD, byval as DWORD) as HRESULT
	SetPatternByName as function(byval as IDirectMusicPatternTrack ptr, byval as IDirectMusicSegmentState ptr, byval as WCHAR ptr, byval as IDirectMusicStyle ptr, byval as DWORD, byval as DWORD ptr) as HRESULT
end type

type IDirectMusicPatternTrack8 as IDirectMusicPatternTrack

type IDirectMusicScriptVtbl_ as IDirectMusicScriptVtbl

type IDirectMusicScript
	lpVtbl as IDirectMusicScriptVtbl_ ptr
end type

type IDirectMusicScriptVtbl
	QueryInterface as function(byval as IDirectMusicScript ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicScript ptr) as ULONG
	Release as function(byval as IDirectMusicScript ptr) as ULONG
	Init as function(byval as IDirectMusicScript ptr, byval as IDirectMusicPerformance ptr, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	CallRoutine as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	SetVariableVariant as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as VARIANT_, byval as BOOL, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	GetVariableVariant as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as VARIANT_ ptr, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	SetVariableNumber as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as LONG, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	GetVariableNumber as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as LONG ptr, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	SetVariableObject as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as IUnknown ptr, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	GetVariableObject as function(byval as IDirectMusicScript ptr, byval as WCHAR ptr, byval as IID ptr, byval as LPVOID ptr, byval as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	EnumRoutine as function(byval as IDirectMusicScript ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
	EnumVariable as function(byval as IDirectMusicScript ptr, byval as DWORD, byval as WCHAR ptr) as HRESULT
end type

type IDirectMusicScript8 as IDirectMusicScript

type IDirectMusicContainerVtbl_ as IDirectMusicContainerVtbl

type IDirectMusicContainer
	lpVtbl as IDirectMusicContainerVtbl_ ptr
end type

type IDirectMusicContainerVtbl
	QueryInterface as function(byval as IDirectMusicContainer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicContainer ptr) as ULONG
	Release as function(byval as IDirectMusicContainer ptr) as ULONG
	EnumObject as function(byval as IDirectMusicContainer ptr, byval as GUID ptr, byval as DWORD, byval as LPDMUS_OBJECTDESC, byval as WCHAR ptr) as HRESULT
end type

type IDirectMusicContainer8 as IDirectMusicContainer

extern CLSID_DirectMusicPerformance alias "CLSID_DirectMusicPerformance" as GUID
extern CLSID_DirectMusicSegment alias "CLSID_DirectMusicSegment" as GUID
extern CLSID_DirectMusicSegmentState alias "CLSID_DirectMusicSegmentState" as GUID
extern CLSID_DirectMusicGraph alias "CLSID_DirectMusicGraph" as GUID
extern CLSID_DirectMusicStyle alias "CLSID_DirectMusicStyle" as GUID
extern CLSID_DirectMusicChordMap alias "CLSID_DirectMusicChordMap" as GUID
extern CLSID_DirectMusicComposer alias "CLSID_DirectMusicComposer" as GUID
extern CLSID_DirectMusicLoader alias "CLSID_DirectMusicLoader" as GUID
extern CLSID_DirectMusicBand alias "CLSID_DirectMusicBand" as GUID
extern CLSID_DirectMusicPatternTrack alias "CLSID_DirectMusicPatternTrack" as GUID
extern CLSID_DirectMusicScript alias "CLSID_DirectMusicScript" as GUID
extern CLSID_DirectMusicContainer alias "CLSID_DirectMusicContainer" as GUID
extern CLSID_DirectSoundWave alias "CLSID_DirectSoundWave" as GUID
extern CLSID_DirectMusicAudioPathConfig alias "CLSID_DirectMusicAudioPathConfig" as GUID
extern GUID_DirectMusicAllTypes alias "GUID_DirectMusicAllTypes" as GUID
extern GUID_NOTIFICATION_SEGMENT alias "GUID_NOTIFICATION_SEGMENT" as GUID
extern GUID_NOTIFICATION_PERFORMANCE alias "GUID_NOTIFICATION_PERFORMANCE" as GUID
extern GUID_NOTIFICATION_MEASUREANDBEAT alias "GUID_NOTIFICATION_MEASUREANDBEAT" as GUID
extern GUID_NOTIFICATION_CHORD alias "GUID_NOTIFICATION_CHORD" as GUID
extern GUID_NOTIFICATION_COMMAND alias "GUID_NOTIFICATION_COMMAND" as GUID
extern GUID_NOTIFICATION_RECOMPOSE alias "GUID_NOTIFICATION_RECOMPOSE" as GUID
extern GUID_CommandParam alias "GUID_CommandParam" as GUID
extern GUID_CommandParam2 alias "GUID_CommandParam2" as GUID
extern GUID_CommandParamNext alias "GUID_CommandParamNext" as GUID
extern GUID_ChordParam alias "GUID_ChordParam" as GUID
extern GUID_RhythmParam alias "GUID_RhythmParam" as GUID
extern GUID_IDirectMusicStyle alias "GUID_IDirectMusicStyle" as GUID
extern GUID_TimeSignature alias "GUID_TimeSignature" as GUID
extern GUID_TempoParam alias "GUID_TempoParam" as GUID
extern GUID_Valid_Start_Time alias "GUID_Valid_Start_Time" as GUID
extern GUID_Play_Marker alias "GUID_Play_Marker" as GUID
extern GUID_BandParam alias "GUID_BandParam" as GUID

type DMUS_BAND_PARAM
	mtTimePhysical as MUSIC_TIME
	pBand as IDirectMusicBand ptr
end type

extern GUID_IDirectMusicBand alias "GUID_IDirectMusicBand" as GUID
extern GUID_IDirectMusicChordMap alias "GUID_IDirectMusicChordMap" as GUID
extern GUID_MuteParam alias "GUID_MuteParam" as GUID
extern GUID_Download alias "GUID_Download" as GUID
extern GUID_Unload alias "GUID_Unload" as GUID
extern GUID_ConnectToDLSCollection alias "GUID_ConnectToDLSCollection" as GUID
extern GUID_Enable_Auto_Download alias "GUID_Enable_Auto_Download" as GUID
extern GUID_Disable_Auto_Download alias "GUID_Disable_Auto_Download" as GUID
extern GUID_Clear_All_Bands alias "GUID_Clear_All_Bands" as GUID
extern GUID_StandardMIDIFile alias "GUID_StandardMIDIFile" as GUID
extern GUID_DisableTimeSig alias "GUID_DisableTimeSig" as GUID
extern GUID_EnableTimeSig alias "GUID_EnableTimeSig" as GUID
extern GUID_DisableTempo alias "GUID_DisableTempo" as GUID
extern GUID_EnableTempo alias "GUID_EnableTempo" as GUID
extern GUID_SeedVariations alias "GUID_SeedVariations" as GUID
extern GUID_Variations alias "GUID_Variations" as GUID

type DMUS_VARIATIONS_PARAM
	dwPChannelsUsed as DWORD
	padwPChannels as DWORD ptr
	padwVariations as DWORD ptr
end type

extern GUID_DownloadToAudioPath alias "GUID_DownloadToAudioPath" as GUID
extern GUID_UnloadFromAudioPath alias "GUID_UnloadFromAudioPath" as GUID
extern GUID_PerfMasterTempo alias "GUID_PerfMasterTempo" as GUID
extern GUID_PerfMasterVolume alias "GUID_PerfMasterVolume" as GUID
extern GUID_PerfMasterGrooveLevel alias "GUID_PerfMasterGrooveLevel" as GUID
extern GUID_PerfAutoDownload alias "GUID_PerfAutoDownload" as GUID
extern GUID_DefaultGMCollection alias "GUID_DefaultGMCollection" as GUID
extern GUID_Synth_Default alias "GUID_Synth_Default" as GUID
extern GUID_Buffer_Reverb alias "GUID_Buffer_Reverb" as GUID
extern GUID_Buffer_EnvReverb alias "GUID_Buffer_EnvReverb" as GUID
extern GUID_Buffer_Stereo alias "GUID_Buffer_Stereo" as GUID
extern GUID_Buffer_3D_Dry alias "GUID_Buffer_3D_Dry" as GUID
extern GUID_Buffer_Mono alias "GUID_Buffer_Mono" as GUID
extern IID_IDirectMusicLoader alias "IID_IDirectMusicLoader" as GUID
extern IID_IDirectMusicGetLoader alias "IID_IDirectMusicGetLoader" as GUID
extern IID_IDirectMusicObject alias "IID_IDirectMusicObject" as GUID
extern IID_IDirectMusicSegment alias "IID_IDirectMusicSegment" as GUID
extern IID_IDirectMusicSegmentState alias "IID_IDirectMusicSegmentState" as GUID
extern IID_IDirectMusicPerformance alias "IID_IDirectMusicPerformance" as GUID
extern IID_IDirectMusicGraph alias "IID_IDirectMusicGraph" as GUID
extern IID_IDirectMusicStyle alias "IID_IDirectMusicStyle" as GUID
extern IID_IDirectMusicChordMap alias "IID_IDirectMusicChordMap" as GUID
extern IID_IDirectMusicComposer alias "IID_IDirectMusicComposer" as GUID
extern IID_IDirectMusicBand alias "IID_IDirectMusicBand" as GUID
extern IID_IDirectMusicPerformance2 alias "IID_IDirectMusicPerformance2" as GUID
extern IID_IDirectMusicSegment2 alias "IID_IDirectMusicSegment2" as GUID
extern IID_IDirectMusicLoader8 alias "IID_IDirectMusicLoader8" as GUID
extern IID_IDirectMusicPerformance8 alias "IID_IDirectMusicPerformance8" as GUID
extern IID_IDirectMusicSegment8 alias "IID_IDirectMusicSegment8" as GUID
extern IID_IDirectMusicSegmentState8 alias "IID_IDirectMusicSegmentState8" as GUID
extern IID_IDirectMusicStyle8 alias "IID_IDirectMusicStyle8" as GUID
extern IID_IDirectMusicPatternTrack alias "IID_IDirectMusicPatternTrack" as GUID
extern IID_IDirectMusicScript alias "IID_IDirectMusicScript" as GUID
extern IID_IDirectMusicContainer alias "IID_IDirectMusicContainer" as GUID
extern IID_IDirectMusicAudioPath alias "IID_IDirectMusicAudioPath" as GUID

#define IID_IDirectMusicPatternTrack8 IID_IDirectMusicPatternTrack
#define IID_IDirectMusicScript8 IID_IDirectMusicScript
#define IID_IDirectMusicContainer8 IID_IDirectMusicContainer
#define IID_IDirectMusicAudioPath8 IID_IDirectMusicAudioPath

#define IID_IDirectMusicGetLoader8 IID_IDirectMusicGetLoader
#define IID_IDirectMusicChordMap8 IID_IDirectMusicChordMap
#define IID_IDirectMusicGraph8 IID_IDirectMusicGraph
#define IID_IDirectMusicBand8 IID_IDirectMusicBand
#define IID_IDirectMusicObject8 IID_IDirectMusicObject
#define IID_IDirectMusicComposer8 IID_IDirectMusicComposer

#endif
