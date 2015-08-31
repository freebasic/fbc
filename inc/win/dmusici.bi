'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DirectMusic Performance API
''
''   Copyright (C) 2003-2004 Rok Mandeljc
''
''   This program is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "windows.bi"
#include once "objbase.bi"
#include once "mmsystem.bi"
#include once "dmusicc.bi"
#include once "dmplugin.bi"

extern "Windows"

#define __WINE_DMUSIC_PERFORMANCE_H
extern CLSID_DirectMusicAudioPathConfig as const GUID
extern CLSID_DirectMusicBand as const GUID
extern CLSID_DirectMusicChordMap as const GUID
extern CLSID_DirectMusicComposer as const GUID
extern CLSID_DirectMusicContainer as const GUID
extern CLSID_DirectMusicGraph as const GUID
extern CLSID_DirectMusicLoader as const GUID
extern CLSID_DirectMusicPatternTrack as const GUID
extern CLSID_DirectMusicPerformance as const GUID
extern CLSID_DirectMusicScript as const GUID
extern CLSID_DirectMusicSegment as const GUID
extern CLSID_DirectMusicSegmentState as const GUID
extern CLSID_DirectMusicStyle as const GUID
extern CLSID_DirectSoundWave as const GUID
extern CLSID_DirectMusicSong as const GUID
extern CLSID_DirectMusicSynthSink as const GUID
extern CLSID_DirectMusicSection as const GUID
extern CLSID_DirectMusicAuditionTrack as const GUID
extern CLSID_DirectMusicSegTriggerTrack as const GUID
extern CLSID_DirectMusicTemplate as const GUID
extern CLSID_DirectMusicScriptAutoImpSegment as const GUID
extern CLSID_AudioVBScript as const GUID
extern CLSID_DirectMusicScriptAutoImpPerformance as const GUID
extern CLSID_DirectMusicScriptSourceCodeLoader as const GUID
extern CLSID_DirectMusicScriptAutoImpSegmentState as const GUID
extern CLSID_DirectMusicScriptAutoImpAudioPathConfig as const GUID
extern CLSID_DirectMusicScriptAutoImpAudioPath as const GUID
extern CLSID_DirectMusicScriptAutoImpSong as const GUID
extern IID_IDirectMusicAudioPath as const GUID
extern IID_IDirectMusicBand as const GUID
extern IID_IDirectMusicChordMap as const GUID
extern IID_IDirectMusicComposer as const GUID
extern IID_IDirectMusicContainer as const GUID
extern IID_IDirectMusicGetLoader as const GUID
extern IID_IDirectMusicGraph as const GUID
extern IID_IDirectMusicLoader as const GUID
extern IID_IDirectMusicLoader8 as const GUID
extern IID_IDirectMusicObject as const GUID
extern IID_IDirectMusicPatternTrack as const GUID
extern IID_IDirectMusicPerformance as const GUID
extern IID_IDirectMusicPerformance2 as const GUID
extern IID_IDirectMusicPerformance8 as const GUID
extern IID_IDirectMusicScript as const GUID
extern IID_IDirectMusicSegment as const GUID
extern IID_IDirectMusicSegment2 as const GUID
extern IID_IDirectMusicSegment8 as const GUID
extern IID_IDirectMusicSegmentState as const GUID
extern IID_IDirectMusicSegmentState8 as const GUID
extern IID_IDirectMusicStyle as const GUID
extern IID_IDirectMusicStyle8 as const GUID
extern IID_IDirectMusicAudioPath8 alias "IID_IDirectMusicAudioPath" as const GUID
extern IID_IDirectMusicBand8 alias "IID_IDirectMusicBand" as const GUID
extern IID_IDirectMusicChordMap8 alias "IID_IDirectMusicChordMap" as const GUID
extern IID_IDirectMusicComposer8 alias "IID_IDirectMusicComposer" as const GUID
extern IID_IDirectMusicContainer8 alias "IID_IDirectMusicContainer" as const GUID
extern IID_IDirectMusicGetLoader8 alias "IID_IDirectMusicGetLoader" as const GUID
extern IID_IDirectMusicGraph8 alias "IID_IDirectMusicGraph" as const GUID
extern IID_IDirectMusicObject8 alias "IID_IDirectMusicObject" as const GUID
extern IID_IDirectMusicPatternTrack8 alias "IID_IDirectMusicPatternTrack" as const GUID
extern IID_IDirectMusicScript8 alias "IID_IDirectMusicScript" as const GUID

type IDirectMusicBand as IDirectMusicBand_
type LPDIRECTMUSICBAND as IDirectMusicBand ptr
type IDirectMusicBand8 as IDirectMusicBand
type LPDIRECTMUSICBAND8 as IDirectMusicBand ptr
type LPDIRECTMUSICOBJECT as IDirectMusicObject ptr
type IDirectMusicObject8 as IDirectMusicObject
type LPDIRECTMUSICOBJECT8 as IDirectMusicObject ptr
type LPDIRECTMUSICLOADER as IDirectMusicLoader ptr
type LPDIRECTMUSICLOADER8 as IDirectMusicLoader8 ptr
type LPDIRECTMUSICGETLOADER as IDirectMusicGetLoader ptr
type IDirectMusicGetLoader8 as IDirectMusicGetLoader
type LPDIRECTMUSICGETLOADER8 as IDirectMusicGetLoader ptr
type LPDIRECTMUSICAUDIOPATH as IDirectMusicAudioPath ptr
type IDirectMusicAudioPath8 as IDirectMusicAudioPath
type LPDIRECTMUSICAUDIOPATH8 as IDirectMusicAudioPath ptr
type LPDIRECTMUSICSTYLE as IDirectMusicStyle ptr
type LPDIRECTMUSICSTYLE8 as IDirectMusicStyle8 ptr
type IDirectMusicChordMap as IDirectMusicChordMap_
type LPDIRECTMUSICCHORDMAP as IDirectMusicChordMap ptr
type IDirectMusicChordMap8 as IDirectMusicChordMap
type LPDIRECTMUSICCHORDMAP8 as IDirectMusicChordMap ptr
type LPDIRECTMUSICCOMPOSER as IDirectMusicComposer ptr
type IDirectMusicComposer8 as IDirectMusicComposer
type LPDIRECTMUSICCOMPOSER8 as IDirectMusicComposer ptr
type LPDIRECTMUSICPATTERNTRACK as IDirectMusicPatternTrack ptr
type IDirectMusicPatternTrack8 as IDirectMusicPatternTrack
type LPDIRECTMUSICPATTERNTRACK8 as IDirectMusicPatternTrack ptr
type LPDIRECTMUSICSCRIPT as IDirectMusicScript ptr
type IDirectMusicScript8 as IDirectMusicScript
type LPDIRECTMUSICSCRIPT8 as IDirectMusicScript ptr
type LPDIRECTMUSICCONTAINER as IDirectMusicContainer ptr
type IDirectMusicContainer8 as IDirectMusicContainer
type LPDIRECTMUSICCONTAINER8 as IDirectMusicContainer ptr
type LPDMUS_BAND as IDirectMusicBand ptr
type LPDMUS_LOADER as IDirectMusicLoader ptr
type LPDMUS_OBJECT as IDirectMusicObject ptr

extern GUID_DirectMusicAllTypes as const GUID
extern GUID_NOTIFICATION_CHORD as const GUID
extern GUID_NOTIFICATION_COMMAND as const GUID
extern GUID_NOTIFICATION_MEASUREANDBEAT as const GUID
extern GUID_NOTIFICATION_PERFORMANCE as const GUID
extern GUID_NOTIFICATION_RECOMPOSE as const GUID
extern GUID_NOTIFICATION_SEGMENT as const GUID
extern GUID_BandParam as const GUID
extern GUID_ChordParam as const GUID
extern GUID_CommandParam as const GUID
extern GUID_CommandParam2 as const GUID
extern GUID_CommandParamNext as const GUID
extern GUID_IDirectMusicBand as const GUID
extern GUID_IDirectMusicChordMap as const GUID
extern GUID_IDirectMusicStyle as const GUID
extern GUID_MuteParam as const GUID
extern GUID_Play_Marker as const GUID
extern GUID_RhythmParam as const GUID
extern GUID_TempoParam as const GUID
extern GUID_TimeSignature as const GUID
extern GUID_Valid_Start_Time as const GUID
extern GUID_Clear_All_Bands as const GUID
extern GUID_ConnectToDLSCollection as const GUID
extern GUID_Disable_Auto_Download as const GUID
extern GUID_DisableTempo as const GUID
extern GUID_DisableTimeSig as const GUID
extern GUID_Download as const GUID
extern GUID_DownloadToAudioPath as const GUID
extern GUID_Enable_Auto_Download as const GUID
extern GUID_EnableTempo as const GUID
extern GUID_EnableTimeSig as const GUID
extern GUID_SeedVariations as const GUID
extern GUID_StandardMIDIFile as const GUID
extern GUID_IgnoreBankSelectForGM alias "GUID_StandardMIDIFile" as const GUID
extern GUID_Unload as const GUID
extern GUID_UnloadFromAudioPath as const GUID
extern GUID_Variations as const GUID
extern GUID_PerfMasterTempo as const GUID
extern GUID_PerfMasterVolume as const GUID
extern GUID_PerfMasterGrooveLevel as const GUID
extern GUID_PerfAutoDownload as const GUID
extern GUID_DefaultGMCollection as const GUID
extern GUID_Synth_Default as const GUID
extern GUID_Buffer_Reverb as const GUID
extern GUID_Buffer_EnvReverb as const GUID
extern GUID_Buffer_Stereo as const GUID
extern GUID_Buffer_3D_Dry as const GUID
extern GUID_Buffer_Mono as const GUID
type TRANSITION_TYPE as WORD
type LPTRANSITION_TYPE as WORD ptr

const DMUS_APATH_SHARED_STEREOPLUSREVERB = &h1
const DMUS_APATH_DYNAMIC_3D = &h6
const DMUS_APATH_DYNAMIC_MONO = &h7
const DMUS_APATH_DYNAMIC_STEREO = &h8
const DMUS_AUDIOF_3D = &h01
const DMUS_AUDIOF_ENVIRON = &h02
const DMUS_AUDIOF_EAX = &h04
const DMUS_AUDIOF_DMOS = &h08
const DMUS_AUDIOF_STREAMING = &h10
const DMUS_AUDIOF_BUFFERS = &h20
const DMUS_AUDIOF_ALL = &h3F
const DMUS_AUDIOPARAMS_FEATURES = &h1
const DMUS_AUDIOPARAMS_VOICES = &h2
const DMUS_AUDIOPARAMS_SAMPLERATE = &h4
const DMUS_AUDIOPARAMS_DEFAULTSYNTH = &h8
const DMUS_CURVET_PBCURVE = &h03
const DMUS_CURVET_CCCURVE = &h04
const DMUS_CURVET_MATCURVE = &h05
const DMUS_CURVET_PATCURVE = &h06
const DMUS_CURVET_RPNCURVE = &h07
const DMUS_CURVET_NRPNCURVE = &h08
const DMUS_MASTERTEMPO_MAX = 100.0f
const DMUS_MASTERTEMPO_MIN = 0.01f
const DMUS_MAX_NAME = &h40
const DMUS_MAX_CATEGORY = &h40
const DMUS_MAX_FILENAME = MAX_PATH
const DMUS_MAXSUBCHORD = &h8
const DMUS_NOTIFICATION_SEGSTART = &h0
const DMUS_NOTIFICATION_SEGEND = &h1
const DMUS_NOTIFICATION_SEGALMOSTEND = &h2
const DMUS_NOTIFICATION_SEGLOOP = &h3
const DMUS_NOTIFICATION_SEGABORT = &h4
const DMUS_NOTIFICATION_MUSICSTARTED = &h0
const DMUS_NOTIFICATION_MUSICSTOPPED = &h1
const DMUS_NOTIFICATION_MUSICALMOSTEND = &h2
const DMUS_NOTIFICATION_MEASUREBEAT = &h0
const DMUS_NOTIFICATION_CHORD = &h0
const DMUS_NOTIFICATION_GROOVE = &h0
const DMUS_NOTIFICATION_EMBELLISHMENT = &h1
const DMUS_NOTIFICATION_RECOMPOSE = &h0
const DMUS_OBJ_OBJECT = &h001
const DMUS_OBJ_CLASS = &h002
const DMUS_OBJ_NAME = &h004
const DMUS_OBJ_CATEGORY = &h008
const DMUS_OBJ_FILENAME = &h010
const DMUS_OBJ_FULLPATH = &h020
const DMUS_OBJ_URL = &h040
const DMUS_OBJ_VERSION = &h080
const DMUS_OBJ_DATE = &h100
const DMUS_OBJ_LOADED = &h200
const DMUS_OBJ_MEMORY = &h400
const DMUS_OBJ_STREAM = &h800
const DMUS_PATH_SEGMENT = &h1000
const DMUS_PATH_SEGMENT_TRACK = &h1100
const DMUS_PATH_SEGMENT_GRAPH = &h1200
const DMUS_PATH_SEGMENT_TOOL = &h1300
const DMUS_PATH_AUDIOPATH = &h2000
const DMUS_PATH_AUDIOPATH_GRAPH = &h2200
const DMUS_PATH_AUDIOPATH_TOOL = &h2300
const DMUS_PATH_PERFORMANCE = &h3000
const DMUS_PATH_PERFORMANCE_GRAPH = &h3200
const DMUS_PATH_PERFORMANCE_TOOL = &h3300
const DMUS_PATH_PORT = &h4000
const DMUS_PATH_BUFFER = &h6000
const DMUS_PATH_BUFFER_DMO = &h6100
const DMUS_PATH_MIXIN_BUFFER = &h7000
const DMUS_PATH_MIXIN_BUFFER_DMO = &h7100
const DMUS_PATH_PRIMARY_BUFFER = &h8000
const DMUS_PCHANNEL_BROADCAST_PERFORMANCE = &hFFFFFFFF
const DMUS_PCHANNEL_BROADCAST_AUDIOPATH = &hFFFFFFFE
const DMUS_PCHANNEL_BROADCAST_SEGMENT = &hFFFFFFFD
const DMUS_PCHANNEL_BROADCAST_GROUPS = &hFFFFFFFC
const DMUS_PCHANNEL_ALL = &hFFFFFFFB
const DMUS_PLAYMODE_FIXED = &h0
#define DMUS_PLAYMODE_PEDALPOINT (DMUS_PLAYMODE_KEY_ROOT or DMUS_PLAYMODE_SCALE_INTERVALS)
#define DMUS_PLAYMODE_MELODIC (DMUS_PLAYMODE_CHORD_ROOT or DMUS_PLAYMODE_SCALE_INTERVALS)
#define DMUS_PLAYMODE_NORMALCHORD (DMUS_PLAYMODE_CHORD_ROOT or DMUS_PLAYMODE_CHORD_INTERVALS)
#define DMUS_PLAYMODE_ALWAYSPLAY (DMUS_PLAYMODE_MELODIC or DMUS_PLAYMODE_NORMALCHORD)
#define DMUS_PLAYMODE_PEDALPOINTCHORD (DMUS_PLAYMODE_KEY_ROOT or DMUS_PLAYMODE_CHORD_INTERVALS)
#define DMUS_PLAYMODE_PEDALPOINTALWAYS (DMUS_PLAYMODE_PEDALPOINT or DMUS_PLAYMODE_PEDALPOINTCHORD)
#define DMUS_PLAYMODE_PURPLEIZED DMUS_PLAYMODE_ALWAYSPLAY
const DMUS_PPQ = 768
const DMUS_SEG_REPEAT_INFINITE = &hFFFFFFFF
const DMUS_SEG_ALLTRACKS = &h80000000
const DMUS_SEG_ANYTRACK = &h80000000
const DMUS_TEMPO_MAX = 1000
const DMUS_TEMPO_MIN = 1
const DMUS_TRACKCONFIG_OVERRIDE_ALL = &h00001
const DMUS_TRACKCONFIG_OVERRIDE_PRIMARY = &h00002
const DMUS_TRACKCONFIG_FALLBACK = &h00004
const DMUS_TRACKCONFIG_CONTROL_ENABLED = &h00008
const DMUS_TRACKCONFIG_PLAY_ENABLED = &h00010
const DMUS_TRACKCONFIG_NOTIFICATION_ENABLED = &h00020
const DMUS_TRACKCONFIG_PLAY_CLOCKTIME = &h00040
const DMUS_TRACKCONFIG_PLAY_COMPOSE = &h00080
const DMUS_TRACKCONFIG_LOOP_COMPOSE = &h00100
const DMUS_TRACKCONFIG_COMPOSING = &h00200
const DMUS_TRACKCONFIG_TRANS1_FROMSEGSTART = &h00400
const DMUS_TRACKCONFIG_TRANS1_FROMSEGCURRENT = &h00800
const DMUS_TRACKCONFIG_TRANS1_TOSEGSTART = &h01000
const DMUS_TRACKCONFIG_CONTROL_PLAY = &h10000
const DMUS_TRACKCONFIG_CONTROL_NOTIFICATION = &h20000
const DMUS_TRACKCONFIG_DEFAULT = (DMUS_TRACKCONFIG_CONTROL_ENABLED or DMUS_TRACKCONFIG_PLAY_ENABLED) or DMUS_TRACKCONFIG_NOTIFICATION_ENABLED
const DMUS_WAVEF_OFF = &h01
const DMUS_WAVEF_STREAMING = &h02
const DMUS_WAVEF_NOINVALIDATE = &h04
const DMUS_WAVEF_NOPREROLL = &h08
const DMUS_WAVEF_IGNORELOOPS = &h20
const DMUSB_LOADED = &h1
const DMUSB_DEFAULT = &h2
const MT_MIN = &h80000000
const MT_MAX = &h7FFFFFFF

type DMUS_STYLET_TYPES as enumDMUS_STYLET_TYPES
type DMUS_COMMANDT_TYPES as enumDMUS_COMMANDT_TYPES
type DMUS_SHAPET_TYPES as enumDMUS_SHAPET_TYPES
type DMUS_COMPOSEF_FLAGS as enumDMUS_COMPOSEF_FLAGS
type DMUS_PMSGF_FLAGS as enumDMUS_PMSGF_FLAGS
type DMUS_PMSGT_TYPES as enumDMUS_PMSGT_TYPES
type DMUS_SEGF_FLAGS as enumDMUS_SEGF_FLAGS
type DMUS_TIME_RESOLVE_FLAGS as enumDMUS_TIME_RESOLVE_FLAGS
type DMUS_CHORDKEYF_FLAGS as enumDMUS_CHORDKEYF_FLAGS
type DMUS_NOTEF_FLAGS as enumDMUS_NOTEF_FLAGS
type DMUS_PLAYMODE_FLAGS as enumDMUS_PLAYMODE_FLAGS
type DMUS_CURVE_FLAGS as enumDMUS_CURVE_FLAGS

type enumDMUS_STYLET_TYPES as long
enum
	DMUS_STYLET_PATTERN = &h0
	DMUS_STYLET_MOTIF = &h1
end enum

type enumDMUS_COMMANDT_TYPES as long
enum
	DMUS_COMMANDT_GROOVE = &h0
	DMUS_COMMANDT_FILL = &h1
	DMUS_COMMANDT_INTRO = &h2
	DMUS_COMMANDT_BREAK = &h3
	DMUS_COMMANDT_END = &h4
	DMUS_COMMANDT_ENDANDINTRO = &h5
end enum

type enumDMUS_SHAPET_TYPES as long
enum
	DMUS_SHAPET_FALLING = &h0
	DMUS_SHAPET_LEVEL = &h1
	DMUS_SHAPET_LOOPABLE = &h2
	DMUS_SHAPET_LOUD = &h3
	DMUS_SHAPET_QUIET = &h4
	DMUS_SHAPET_PEAKING = &h5
	DMUS_SHAPET_RANDOM = &h6
	DMUS_SHAPET_RISING = &h7
	DMUS_SHAPET_SONG = &h8
end enum

type enumDMUS_COMPOSEF_FLAGS as long
enum
	DMUS_COMPOSEF_NONE = &h000000
	DMUS_COMPOSEF_ALIGN = &h000001
	DMUS_COMPOSEF_OVERLAP = &h000002
	DMUS_COMPOSEF_IMMEDIATE = &h000004
	DMUS_COMPOSEF_GRID = &h000008
	DMUS_COMPOSEF_BEAT = &h000010
	DMUS_COMPOSEF_MEASURE = &h000020
	DMUS_COMPOSEF_AFTERPREPARETIME = &h000040
	DMUS_COMPOSEF_VALID_START_BEAT = &h000080
	DMUS_COMPOSEF_VALID_START_GRID = &h000100
	DMUS_COMPOSEF_VALID_START_TICK = &h000200
	DMUS_COMPOSEF_SEGMENTEND = &h000400
	DMUS_COMPOSEF_MARKER = &h000800
	DMUS_COMPOSEF_MODULATE = &h001000
	DMUS_COMPOSEF_LONG = &h002000
	DMUS_COMPOSEF_ENTIRE_TRANSITION = &h004000
	DMUS_COMPOSEF_1BAR_TRANSITION = &h008000
	DMUS_COMPOSEF_ENTIRE_ADDITION = &h010000
	DMUS_COMPOSEF_1BAR_ADDITION = &h020000
	DMUS_COMPOSEF_VALID_START_MEASURE = &h040000
	DMUS_COMPOSEF_DEFAULT = &h080000
	DMUS_COMPOSEF_NOINVALIDATE = &h100000
	DMUS_COMPOSEF_USE_AUDIOPATH = &h200000
	DMUS_COMPOSEF_INVALIDATE_PRI = &h400000
end enum

type enumDMUS_PMSGF_FLAGS as long
enum
	DMUS_PMSGF_REFTIME = 1
	DMUS_PMSGF_MUSICTIME = 2
	DMUS_PMSGF_TOOL_IMMEDIATE = 4
	DMUS_PMSGF_TOOL_QUEUE = 8
	DMUS_PMSGF_TOOL_ATTIME = &h10
	DMUS_PMSGF_TOOL_FLUSH = &h20
	DMUS_PMSGF_LOCKTOREFTIME = &h40
	DMUS_PMSGF_DX8 = &h80
end enum

type enumDMUS_PMSGT_TYPES as long
enum
	DMUS_PMSGT_MIDI = &h00
	DMUS_PMSGT_NOTE = &h01
	DMUS_PMSGT_SYSEX = &h02
	DMUS_PMSGT_NOTIFICATION = &h03
	DMUS_PMSGT_TEMPO = &h04
	DMUS_PMSGT_CURVE = &h05
	DMUS_PMSGT_TIMESIG = &h06
	DMUS_PMSGT_PATCH = &h07
	DMUS_PMSGT_TRANSPOSE = &h08
	DMUS_PMSGT_CHANNEL_PRIORITY = &h09
	DMUS_PMSGT_STOP = &h0A
	DMUS_PMSGT_DIRTY = &h0B
	DMUS_PMSGT_WAVE = &h0C
	DMUS_PMSGT_LYRIC = &h0D
	DMUS_PMSGT_SCRIPTLYRIC = &h0E
	DMUS_PMSGT_USER = &hFF
end enum

type enumDMUS_SEGF_FLAGS as long
enum
	DMUS_SEGF_REFTIME = &h000040
	DMUS_SEGF_SECONDARY = &h000080
	DMUS_SEGF_QUEUE = &h000100
	DMUS_SEGF_CONTROL = &h000200
	DMUS_SEGF_AFTERPREPARETIME = &h000400
	DMUS_SEGF_GRID = &h000800
	DMUS_SEGF_BEAT = &h001000
	DMUS_SEGF_MEASURE = &h002000
	DMUS_SEGF_DEFAULT = &h004000
	DMUS_SEGF_NOINVALIDATE = &h008000
	DMUS_SEGF_ALIGN = &h0010000
	DMUS_SEGF_VALID_START_BEAT = &h0020000
	DMUS_SEGF_VALID_START_GRID = &h0040000
	DMUS_SEGF_VALID_START_TICK = &h0080000
	DMUS_SEGF_AUTOTRANSITION = &h0100000
	DMUS_SEGF_AFTERQUEUETIME = &h0200000
	DMUS_SEGF_AFTERLATENCYTIME = &h0400000
	DMUS_SEGF_SEGMENTEND = &h0800000
	DMUS_SEGF_MARKER = &h01000000
	DMUS_SEGF_TIMESIG_ALWAYS = &h02000000
	DMUS_SEGF_USE_AUDIOPATH = &h04000000
	DMUS_SEGF_VALID_START_MEASURE = &h08000000
	DMUS_SEGF_INVALIDATE_PRI = &h10000000
end enum

type enumDMUS_TIME_RESOLVE_FLAGS as long
enum
	DMUS_TIME_RESOLVE_AFTERPREPARETIME = DMUS_SEGF_AFTERPREPARETIME
	DMUS_TIME_RESOLVE_AFTERQUEUETIME = DMUS_SEGF_AFTERQUEUETIME
	DMUS_TIME_RESOLVE_AFTERLATENCYTIME = DMUS_SEGF_AFTERLATENCYTIME
	DMUS_TIME_RESOLVE_GRID = DMUS_SEGF_GRID
	DMUS_TIME_RESOLVE_BEAT = DMUS_SEGF_BEAT
	DMUS_TIME_RESOLVE_MEASURE = DMUS_SEGF_MEASURE
	DMUS_TIME_RESOLVE_MARKER = DMUS_SEGF_MARKER
	DMUS_TIME_RESOLVE_SEGMENTEND = DMUS_SEGF_SEGMENTEND
end enum

type enumDMUS_CHORDKEYF_FLAGS as long
enum
	DMUS_CHORDKEYF_SILENT = &h1
end enum

type enumDMUS_NOTEF_FLAGS as long
enum
	DMUS_NOTEF_NOTEON = &h01
	DMUS_NOTEF_NOINVALIDATE = &h02
	DMUS_NOTEF_NOINVALIDATE_INSCALE = &h04
	DMUS_NOTEF_NOINVALIDATE_INCHORD = &h08
	DMUS_NOTEF_REGENERATE = &h10
end enum

type enumDMUS_PLAYMODE_FLAGS as long
enum
	DMUS_PLAYMODE_KEY_ROOT = &h01
	DMUS_PLAYMODE_CHORD_ROOT = &h02
	DMUS_PLAYMODE_SCALE_INTERVALS = &h04
	DMUS_PLAYMODE_CHORD_INTERVALS = &h08
	DMUS_PLAYMODE_NONE = &h10
end enum

const DMUS_PLAYMODE_FIXEDTOCHORD = DMUS_PLAYMODE_CHORD_ROOT
const DMUS_PLAYMODE_FIXEDTOKEY = DMUS_PLAYMODE_KEY_ROOT
const DMUS_PLAYMODE_FIXEDTOSCALE = DMUS_PLAYMODE_FIXEDTOKEY
const DMUS_PLAYMODE_SCALE_ROOT = DMUS_PLAYMODE_KEY_ROOT

type enumDMUS_CURVE_FLAGS as long
enum
	DMUS_CURVE_RESET = &h1
	DMUS_CURVE_START_FROM_CURRENT = &h2
end enum

enum
	DMUS_CURVES_LINEAR = &h0
	DMUS_CURVES_INSTANT = &h1
	DMUS_CURVES_EXP = &h2
	DMUS_CURVES_LOG = &h3
	DMUS_CURVES_SINE = &h4
end enum

type DMUS_AUDIOPARAMS as _DMUS_AUDIOPARAMS
type LPDMUS_AUDIOPARAMS as _DMUS_AUDIOPARAMS ptr
type DMUS_SUBCHORD as _DMUS_SUBCHORD
type LPDMUS_SUBCHORD as _DMUS_SUBCHORD ptr
type DMUS_CHORD_KEY as _DMUS_CHORD_KEY
type LPDMUS_CHORD_KEY as _DMUS_CHORD_KEY ptr
type DMUS_NOTE_PMSG as _DMUS_NOTE_PMSG
type LPDMUS_NOTE_PMSG as _DMUS_NOTE_PMSG ptr
type DMUS_MIDI_PMSG as _DMUS_MIDI_PMSG
type LPDMUS_MIDI_PMSG as _DMUS_MIDI_PMSG ptr
type DMUS_PATCH_PMSG as _DMUS_PATCH_PMSG
type LPDMUS_PATCH_PMSG as _DMUS_PATCH_PMSG ptr
type DMUS_TRANSPOSE_PMSG as _DMUS_TRANSPOSE_PMSG
type LPDMUS_TRANSPOSE_PMSG as _DMUS_TRANSPOSE_PMSG ptr
type DMUS_CHANNEL_PRIORITY_PMSG as _DMUS_CHANNEL_PRIORITY_PMSG
type LPDMUS_CHANNEL_PRIORITY_PMSG as _DMUS_CHANNEL_PRIORITY_PMSG ptr
type DMUS_TEMPO_PMSG as _DMUS_TEMPO_PMSG
type LPDMUS_TEMPO_PMSG as _DMUS_TEMPO_PMSG ptr
type DMUS_SYSEX_PMSG as _DMUS_SYSEX_PMSG
type LPDMUS_SYSEX_PMSG as _DMUS_SYSEX_PMSG ptr
type DMUS_CURVE_PMSG as _DMUS_CURVE_PMSG
type LPDMUS_CURVE_PMSG as _DMUS_CURVE_PMSG ptr
type DMUS_TIMESIG_PMSG as _DMUS_TIMESIG_PMSG
type LPDMUS_TIMESIG_PMSG as _DMUS_TIMESIG_PMSG ptr
type DMUS_NOTIFICATION_PMSG as _DMUS_NOTIFICATION_PMSG
type LPDMUS_NOTIFICATION_PMSG as _DMUS_NOTIFICATION_PMSG ptr
type DMUS_WAVE_PMSG as _DMUS_WAVE_PMSG
type LPDMUS_WAVE_PMSG as _DMUS_WAVE_PMSG ptr
type DMUS_LYRIC_PMSG as _DMUS_LYRIC_PMSG
type LPDMUS_LYRIC_PMSG as _DMUS_LYRIC_PMSG ptr
type DMUS_VERSION as _DMUS_VERSION
type LPDMUS_VERSION as _DMUS_VERSION ptr
type DMUS_TIMESIGNATURE as _DMUS_TIMESIGNATURE
type LPDMUS_TIMESIGNATURE as _DMUS_TIMESIGNATURE ptr
type DMUS_VALID_START_PARAM as _DMUS_VALID_START_PARAM
type LPDMUS_VALID_START_PARAM as _DMUS_VALID_START_PARAM ptr
type DMUS_PLAY_MARKER_PARAM as _DMUS_PLAY_MARKER_PARAM
type LPDMUS_PLAY_MARKER_PARAM as _DMUS_PLAY_MARKER_PARAM ptr
type DMUS_OBJECTDESC as _DMUS_OBJECTDESC
type LPDMUS_OBJECTDESC as _DMUS_OBJECTDESC ptr
type DMUS_SCRIPT_ERRORINFO as _DMUS_SCRIPT_ERRORINFO
type LPDMUS_SCRIPT_ERRORINFO as _DMUS_SCRIPT_ERRORINFO ptr
type DMUS_COMMAND_PARAM as _DMUS_COMMAND_PARAM
type LPDMUS_COMMAND_PARAM as _DMUS_COMMAND_PARAM ptr
type DMUS_COMMAND_PARAM_2 as _DMUS_COMMAND_PARAM_2
type LPDMUS_COMMAND_PARAM_2 as _DMUS_COMMAND_PARAM_2 ptr
type DMUS_BAND_PARAM as _DMUS_BAND_PARAM
type LPDMUS_BAND_PARAM as _DMUS_BAND_PARAM ptr
type DMUS_VARIATIONS_PARAM as _DMUS_VARIATIONS_PARAM
type LPDMUS_VARIATIONS_PARAM as _DMUS_VARIATIONS_PARAM ptr

type _DMUS_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
end type

type _DMUS_AUDIOPARAMS
	dwSize as DWORD
	fInitNow as WINBOOL
	dwValidData as DWORD
	dwFeatures as DWORD
	dwVoices as DWORD
	dwSampleRate as DWORD
	clsidDefaultSynth as CLSID
end type

type _DMUS_SUBCHORD
	dwChordPattern as DWORD
	dwScalePattern as DWORD
	dwInversionPoints as DWORD
	dwLevels as DWORD
	bChordRoot as UBYTE
	bScaleRoot as UBYTE
end type

type _DMUS_CHORD_KEY
	wszName as wstring * 16
	wMeasure as WORD
	bBeat as UBYTE
	bSubChordCount as UBYTE
	SubChordList(0 to 7) as DMUS_SUBCHORD
	dwScale as DWORD
	bKey as UBYTE
	bFlags as UBYTE
end type

type _DMUS_NOTE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
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

type _DMUS_MIDI_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	bStatus as UBYTE
	bByte1 as UBYTE
	bByte2 as UBYTE
	bPad(0 to 0) as UBYTE
end type

type _DMUS_PATCH_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	byInstrument as UBYTE
	byMSB as UBYTE
	byLSB as UBYTE
	byPad(0 to 0) as UBYTE
end type

type _DMUS_TRANSPOSE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	nTranspose as short
	wMergeIndex as WORD
end type

type _DMUS_CHANNEL_PRIORITY_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	dwChannelPriority as DWORD
end type

type _DMUS_TEMPO_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	dblTempo as double
end type

type _DMUS_SYSEX_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	dwLen as DWORD
	abData(0 to 0) as UBYTE
end type

type _DMUS_CURVE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
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

type _DMUS_TIMESIG_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	bBeatsPerMeasure as UBYTE
	bBeat as UBYTE
	wGridsPerBeat as WORD
end type

type _DMUS_NOTIFICATION_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	guidNotificationType as GUID
	dwNotificationOption as DWORD
	dwField1 as DWORD
	dwField2 as DWORD
end type

type _DMUS_WAVE_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	rtStartOffset as REFERENCE_TIME
	rtDuration as REFERENCE_TIME
	lOffset as LONG
	lVolume as LONG
	lPitch as LONG
	bFlags as UBYTE
end type

type _DMUS_LYRIC_PMSG
	dwSize as DWORD
	rtTime as REFERENCE_TIME
	mtTime as MUSIC_TIME
	dwFlags as DWORD
	dwPChannel as DWORD
	dwVirtualTrackID as DWORD
	pTool as IDirectMusicTool ptr
	pGraph as IDirectMusicGraph ptr
	dwType as DWORD
	dwVoiceID as DWORD
	dwGroupID as DWORD
	punkUser as IUnknown ptr
	wszString as wstring * 1
end type

type _DMUS_VERSION
	dwVersionMS as DWORD
	dwVersionLS as DWORD
end type

type _DMUS_TIMESIGNATURE
	mtTime as MUSIC_TIME
	bBeatsPerMeasure as UBYTE
	bBeat as UBYTE
	wGridsPerBeat as WORD
end type

type _DMUS_VALID_START_PARAM
	mtTime as MUSIC_TIME
end type

type _DMUS_PLAY_MARKER_PARAM
	mtTime as MUSIC_TIME
end type

type _DMUS_OBJECTDESC
	dwSize as DWORD
	dwValidData as DWORD
	guidObject as GUID
	guidClass as GUID
	ftDate as FILETIME
	vVersion as DMUS_VERSION
	wszName as wstring * &h40
	wszCategory as wstring * &h40
	wszFileName as wstring * 260
	llMemLength as LONGLONG
	pbMemData as LPBYTE
	pStream as IStream ptr
end type

type _DMUS_SCRIPT_ERRORINFO
	dwSize as DWORD
	hr as HRESULT
	ulLineNumber as ULONG
	ichCharPosition as LONG
	wszSourceFile as wstring * 260
	wszSourceComponent as wstring * 260
	wszDescription as wstring * 260
	wszSourceLineText as wstring * 260
end type

type _DMUS_COMMAND_PARAM
	bCommand as UBYTE
	bGrooveLevel as UBYTE
	bGrooveRange as UBYTE
	bRepeatMode as UBYTE
end type

type _DMUS_COMMAND_PARAM_2
	mtTime as MUSIC_TIME
	bCommand as UBYTE
	bGrooveLevel as UBYTE
	bGrooveRange as UBYTE
	bRepeatMode as UBYTE
end type

type _DMUS_BAND_PARAM
	mtTimePhysical as MUSIC_TIME
	pBand as IDirectMusicBand ptr
end type

type _DMUS_VARIATIONS_PARAM
	dwPChannelsUsed as DWORD
	padwPChannels as DWORD ptr
	padwVariations as DWORD ptr
end type

type IDirectMusicBandVtbl as IDirectMusicBandVtbl_

type IDirectMusicBand_
	lpVtbl as IDirectMusicBandVtbl ptr
end type

type IDirectMusicBandVtbl_
	QueryInterface as function(byval This as IDirectMusicBand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicBand ptr) as ULONG
	Release as function(byval This as IDirectMusicBand ptr) as ULONG
	CreateSegment as function(byval This as IDirectMusicBand ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	Download as function(byval This as IDirectMusicBand ptr, byval pPerformance as IDirectMusicPerformance ptr) as HRESULT
	Unload as function(byval This as IDirectMusicBand ptr, byval pPerformance as IDirectMusicPerformance ptr) as HRESULT
end type

#define IDirectMusicBand_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicBand_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicBand_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicBand_CreateSegment(p, a) (p)->lpVtbl->CreateSegment(p, a)
#define IDirectMusicBand_Download(p, a) (p)->lpVtbl->Download(p, a)
#define IDirectMusicBand_Unload(p, a) (p)->lpVtbl->Unload(p, a)
type IDirectMusicObjectVtbl as IDirectMusicObjectVtbl_

type IDirectMusicObject
	lpVtbl as IDirectMusicObjectVtbl ptr
end type

type IDirectMusicObjectVtbl_
	QueryInterface as function(byval This as IDirectMusicObject ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicObject ptr) as ULONG
	Release as function(byval This as IDirectMusicObject ptr) as ULONG
	GetDescriptor as function(byval This as IDirectMusicObject ptr, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
	SetDescriptor as function(byval This as IDirectMusicObject ptr, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
	ParseDescriptor as function(byval This as IDirectMusicObject ptr, byval pStream as LPSTREAM, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
end type

#define IDirectMusicObject_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicObject_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicObject_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicObject_GetDescriptor(p, a) (p)->lpVtbl->GetDescriptor(p, a)
#define IDirectMusicObject_SetDescriptor(p, a) (p)->lpVtbl->SetDescriptor(p, a)
#define IDirectMusicObject_ParseDescriptor(p, a, b) (p)->lpVtbl->ParseDescriptor(p, a, b)
type IDirectMusicLoaderVtbl as IDirectMusicLoaderVtbl_

type IDirectMusicLoader
	lpVtbl as IDirectMusicLoaderVtbl ptr
end type

type IDirectMusicLoaderVtbl_
	QueryInterface as function(byval This as IDirectMusicLoader ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicLoader ptr) as ULONG
	Release as function(byval This as IDirectMusicLoader ptr) as ULONG
	_GetObject as function(byval This as IDirectMusicLoader ptr, byval pDesc as LPDMUS_OBJECTDESC, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
	SetObject as function(byval This as IDirectMusicLoader ptr, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
	SetSearchDirectory as function(byval This as IDirectMusicLoader ptr, byval rguidClass as const GUID const ptr, byval pwzPath as wstring ptr, byval fClear as WINBOOL) as HRESULT
	ScanDirectory as function(byval This as IDirectMusicLoader ptr, byval rguidClass as const GUID const ptr, byval pwzFileExtension as wstring ptr, byval pwzScanFileName as wstring ptr) as HRESULT
	CacheObject as function(byval This as IDirectMusicLoader ptr, byval pObject as IDirectMusicObject ptr) as HRESULT
	ReleaseObject as function(byval This as IDirectMusicLoader ptr, byval pObject as IDirectMusicObject ptr) as HRESULT
	ClearCache as function(byval This as IDirectMusicLoader ptr, byval rguidClass as const GUID const ptr) as HRESULT
	EnableCache as function(byval This as IDirectMusicLoader ptr, byval rguidClass as const GUID const ptr, byval fEnable as WINBOOL) as HRESULT
	EnumObject as function(byval This as IDirectMusicLoader ptr, byval rguidClass as const GUID const ptr, byval dwIndex as DWORD, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
end type

#define IDirectMusicLoader_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicLoader_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicLoader_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicLoader_GetObject(p, a, b, c) (p)->lpVtbl->_GetObject(p, a, b, c)
#define IDirectMusicLoader_SetObject(p, a) (p)->lpVtbl->SetObject(p, a)
#define IDirectMusicLoader_SetSearchDirectory(p, a, b, c) (p)->lpVtbl->SetSearchDirectory(p, a, b, c)
#define IDirectMusicLoader_ScanDirectory(p, a, b, c) (p)->lpVtbl->ScanDirectory(p, a, b, c)
#define IDirectMusicLoader_CacheObject(p, a) (p)->lpVtbl->CacheObject(p, a)
#define IDirectMusicLoader_ReleaseObject(p, a) (p)->lpVtbl->ReleaseObject(p, a)
#define IDirectMusicLoader_ClearCache(p, a) (p)->lpVtbl->ClearCache(p, a)
#define IDirectMusicLoader_EnableCache(p, a, b) (p)->lpVtbl->EnableCache(p, a, b)
#define IDirectMusicLoader_EnumObject(p, a, b, c) (p)->lpVtbl->EnumObject(p, a, b, c)
type IDirectMusicLoader8Vtbl as IDirectMusicLoader8Vtbl_

type IDirectMusicLoader8
	lpVtbl as IDirectMusicLoader8Vtbl ptr
end type

type IDirectMusicLoader8Vtbl_
	QueryInterface as function(byval This as IDirectMusicLoader8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicLoader8 ptr) as ULONG
	Release as function(byval This as IDirectMusicLoader8 ptr) as ULONG
	_GetObject as function(byval This as IDirectMusicLoader8 ptr, byval pDesc as LPDMUS_OBJECTDESC, byval riid as const IID const ptr, byval ppv as LPVOID ptr) as HRESULT
	SetObject as function(byval This as IDirectMusicLoader8 ptr, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
	SetSearchDirectory as function(byval This as IDirectMusicLoader8 ptr, byval rguidClass as const GUID const ptr, byval pwzPath as wstring ptr, byval fClear as WINBOOL) as HRESULT
	ScanDirectory as function(byval This as IDirectMusicLoader8 ptr, byval rguidClass as const GUID const ptr, byval pwzFileExtension as wstring ptr, byval pwzScanFileName as wstring ptr) as HRESULT
	CacheObject as function(byval This as IDirectMusicLoader8 ptr, byval pObject as IDirectMusicObject ptr) as HRESULT
	ReleaseObject as function(byval This as IDirectMusicLoader8 ptr, byval pObject as IDirectMusicObject ptr) as HRESULT
	ClearCache as function(byval This as IDirectMusicLoader8 ptr, byval rguidClass as const GUID const ptr) as HRESULT
	EnableCache as function(byval This as IDirectMusicLoader8 ptr, byval rguidClass as const GUID const ptr, byval fEnable as WINBOOL) as HRESULT
	EnumObject as function(byval This as IDirectMusicLoader8 ptr, byval rguidClass as const GUID const ptr, byval dwIndex as DWORD, byval pDesc as LPDMUS_OBJECTDESC) as HRESULT
	CollectGarbage as sub(byval This as IDirectMusicLoader8 ptr)
	ReleaseObjectByUnknown as function(byval This as IDirectMusicLoader8 ptr, byval pObject as IUnknown ptr) as HRESULT
	LoadObjectFromFile as function(byval This as IDirectMusicLoader8 ptr, byval rguidClassID as const GUID const ptr, byval iidInterfaceID as const IID const ptr, byval pwzFilePath as wstring ptr, byval ppObject as any ptr ptr) as HRESULT
end type

#define IDirectMusicLoader8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicLoader8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicLoader8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicLoader8_GetObject(p, a, b, c) (p)->lpVtbl->_GetObject(p, a, b, c)
#define IDirectMusicLoader8_SetObject(p, a) (p)->lpVtbl->SetObject(p, a)
#define IDirectMusicLoader8_SetSearchDirectory(p, a, b, c) (p)->lpVtbl->SetSearchDirectory(p, a, b, c)
#define IDirectMusicLoader8_ScanDirectory(p, a, b, c) (p)->lpVtbl->ScanDirectory(p, a, b, c)
#define IDirectMusicLoader8_CacheObject(p, a) (p)->lpVtbl->CacheObject(p, a)
#define IDirectMusicLoader8_ReleaseObject(p, a) (p)->lpVtbl->ReleaseObject(p, a)
#define IDirectMusicLoader8_ClearCache(p, a) (p)->lpVtbl->ClearCache(p, a)
#define IDirectMusicLoader8_EnableCache(p, a, b) (p)->lpVtbl->EnableCache(p, a, b)
#define IDirectMusicLoader8_EnumObject(p, a, b, c) (p)->lpVtbl->EnumObject(p, a, b, c)
#define IDirectMusicLoader8_CollectGarbage(p) (p)->lpVtbl->CollectGarbage(p)
#define IDirectMusicLoader8_ReleaseObjectByUnknown(p, a) (p)->lpVtbl->ReleaseObjectByUnknown(p, a)
#define IDirectMusicLoader8_LoadObjectFromFile(p, a, b, c, d) (p)->lpVtbl->LoadObjectFromFile(p, a, b, c, d)
type IDirectMusicGetLoaderVtbl as IDirectMusicGetLoaderVtbl_

type IDirectMusicGetLoader
	lpVtbl as IDirectMusicGetLoaderVtbl ptr
end type

type IDirectMusicGetLoaderVtbl_
	QueryInterface as function(byval This as IDirectMusicGetLoader ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicGetLoader ptr) as ULONG
	Release as function(byval This as IDirectMusicGetLoader ptr) as ULONG
	GetLoader as function(byval This as IDirectMusicGetLoader ptr, byval ppLoader as IDirectMusicLoader ptr ptr) as HRESULT
end type

#define IDirectMusicGetLoader_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicGetLoader_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicGetLoader_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicGetLoader_GetLoader(p, a) (p)->lpVtbl->GetLoader(p, a)
type IDirectMusicSegmentVtbl as IDirectMusicSegmentVtbl_

type IDirectMusicSegment_
	lpVtbl as IDirectMusicSegmentVtbl ptr
end type

type IDirectMusicSegmentVtbl_
	QueryInterface as function(byval This as IDirectMusicSegment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSegment ptr) as ULONG
	Release as function(byval This as IDirectMusicSegment ptr) as ULONG
	GetLength as function(byval This as IDirectMusicSegment ptr, byval pmtLength as MUSIC_TIME ptr) as HRESULT
	SetLength as function(byval This as IDirectMusicSegment ptr, byval mtLength as MUSIC_TIME) as HRESULT
	GetRepeats as function(byval This as IDirectMusicSegment ptr, byval pdwRepeats as DWORD ptr) as HRESULT
	SetRepeats as function(byval This as IDirectMusicSegment ptr, byval dwRepeats as DWORD) as HRESULT
	GetDefaultResolution as function(byval This as IDirectMusicSegment ptr, byval pdwResolution as DWORD ptr) as HRESULT
	SetDefaultResolution as function(byval This as IDirectMusicSegment ptr, byval dwResolution as DWORD) as HRESULT
	GetTrack as function(byval This as IDirectMusicSegment ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval ppTrack as IDirectMusicTrack ptr ptr) as HRESULT
	GetTrackGroup as function(byval This as IDirectMusicSegment ptr, byval pTrack as IDirectMusicTrack ptr, byval pdwGroupBits as DWORD ptr) as HRESULT
	InsertTrack as function(byval This as IDirectMusicSegment ptr, byval pTrack as IDirectMusicTrack ptr, byval dwGroupBits as DWORD) as HRESULT
	RemoveTrack as function(byval This as IDirectMusicSegment ptr, byval pTrack as IDirectMusicTrack ptr) as HRESULT
	InitPlay as function(byval This as IDirectMusicSegment ptr, byval ppSegState as IDirectMusicSegmentState ptr ptr, byval pPerformance as IDirectMusicPerformance ptr, byval dwFlags as DWORD) as HRESULT
	GetGraph as function(byval This as IDirectMusicSegment ptr, byval ppGraph as IDirectMusicGraph ptr ptr) as HRESULT
	SetGraph as function(byval This as IDirectMusicSegment ptr, byval pGraph as IDirectMusicGraph ptr) as HRESULT
	AddNotificationType as function(byval This as IDirectMusicSegment ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	RemoveNotificationType as function(byval This as IDirectMusicSegment ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	GetParam as function(byval This as IDirectMusicSegment ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
	SetParam as function(byval This as IDirectMusicSegment ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pParam as any ptr) as HRESULT
	Clone as function(byval This as IDirectMusicSegment ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	SetStartPoint as function(byval This as IDirectMusicSegment ptr, byval mtStart as MUSIC_TIME) as HRESULT
	GetStartPoint as function(byval This as IDirectMusicSegment ptr, byval pmtStart as MUSIC_TIME ptr) as HRESULT
	SetLoopPoints as function(byval This as IDirectMusicSegment ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME) as HRESULT
	GetLoopPoints as function(byval This as IDirectMusicSegment ptr, byval pmtStart as MUSIC_TIME ptr, byval pmtEnd as MUSIC_TIME ptr) as HRESULT
	SetPChannelsUsed as function(byval This as IDirectMusicSegment ptr, byval dwNumPChannels as DWORD, byval paPChannels as DWORD ptr) as HRESULT
end type

#define IDirectMusicSegment_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSegment_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSegment_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSegment_GetLength(p, a) (p)->lpVtbl->GetLength(p, a)
#define IDirectMusicSegment_SetLength(p, a) (p)->lpVtbl->SetLength(p, a)
#define IDirectMusicSegment_GetRepeats(p, a) (p)->lpVtbl->GetRepeats(p, a)
#define IDirectMusicSegment_SetRepeats(p, a) (p)->lpVtbl->SetRepeats(p, a)
#define IDirectMusicSegment_GetDefaultResolution(p, a) (p)->lpVtbl->GetDefaultResolution(p, a)
#define IDirectMusicSegment_SetDefaultResolution(p, a) (p)->lpVtbl->SetDefaultResolution(p, a)
#define IDirectMusicSegment_GetTrack(p, a, b, c, d) (p)->lpVtbl->GetTrack(p, a, b, c, d)
#define IDirectMusicSegment_GetTrackGroup(p, a, b) (p)->lpVtbl->GetTrackGroup(p, a, b)
#define IDirectMusicSegment_InsertTrack(p, a, b) (p)->lpVtbl->InsertTrack(p, a, b)
#define IDirectMusicSegment_RemoveTrack(p, a) (p)->lpVtbl->RemoveTrack(p, a)
#define IDirectMusicSegment_InitPlay(p, a, b, c) (p)->lpVtbl->InitPlay(p, a, b, c)
#define IDirectMusicSegment_GetGraph(p, a) (p)->lpVtbl->GetGraph(p, a)
#define IDirectMusicSegment_SetGraph(p, a) (p)->lpVtbl->SetGraph(p, a)
#define IDirectMusicSegment_AddNotificationType(p, a) (p)->lpVtbl->AddNotificationType(p, a)
#define IDirectMusicSegment_RemoveNotificationType(p, a) (p)->lpVtbl->RemoveNotificationType(p, a)
#define IDirectMusicSegment_GetParam(p, a, b, c, d, e, f) (p)->lpVtbl->GetParam(p, a, b, c, d, e, f)
#define IDirectMusicSegment_SetParam(p, a, b, c, d, e) (p)->lpVtbl->SetParam(p, a, b, c, d, e)
#define IDirectMusicSegment_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirectMusicSegment_SetStartPoint(p, a) (p)->lpVtbl->SetStartPoint(p, a)
#define IDirectMusicSegment_GetStartPoint(p, a) (p)->lpVtbl->GetStartPoint(p, a)
#define IDirectMusicSegment_SetLoopPoints(p, a, b) (p)->lpVtbl->SetLoopPoints(p, a, b)
#define IDirectMusicSegment_GetLoopPoints(p, a, b) (p)->lpVtbl->GetLoopPoints(p, a, b)
#define IDirectMusicSegment_SetPChannelsUsed(p, a, b) (p)->lpVtbl->SetPChannelsUsed(p, a, b)
type IDirectMusicSegment8Vtbl as IDirectMusicSegment8Vtbl_

type IDirectMusicSegment8
	lpVtbl as IDirectMusicSegment8Vtbl ptr
end type

type IDirectMusicSegment8Vtbl_
	QueryInterface as function(byval This as IDirectMusicSegment8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSegment8 ptr) as ULONG
	Release as function(byval This as IDirectMusicSegment8 ptr) as ULONG
	GetLength as function(byval This as IDirectMusicSegment8 ptr, byval pmtLength as MUSIC_TIME ptr) as HRESULT
	SetLength as function(byval This as IDirectMusicSegment8 ptr, byval mtLength as MUSIC_TIME) as HRESULT
	GetRepeats as function(byval This as IDirectMusicSegment8 ptr, byval pdwRepeats as DWORD ptr) as HRESULT
	SetRepeats as function(byval This as IDirectMusicSegment8 ptr, byval dwRepeats as DWORD) as HRESULT
	GetDefaultResolution as function(byval This as IDirectMusicSegment8 ptr, byval pdwResolution as DWORD ptr) as HRESULT
	SetDefaultResolution as function(byval This as IDirectMusicSegment8 ptr, byval dwResolution as DWORD) as HRESULT
	GetTrack as function(byval This as IDirectMusicSegment8 ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval ppTrack as IDirectMusicTrack ptr ptr) as HRESULT
	GetTrackGroup as function(byval This as IDirectMusicSegment8 ptr, byval pTrack as IDirectMusicTrack ptr, byval pdwGroupBits as DWORD ptr) as HRESULT
	InsertTrack as function(byval This as IDirectMusicSegment8 ptr, byval pTrack as IDirectMusicTrack ptr, byval dwGroupBits as DWORD) as HRESULT
	RemoveTrack as function(byval This as IDirectMusicSegment8 ptr, byval pTrack as IDirectMusicTrack ptr) as HRESULT
	InitPlay as function(byval This as IDirectMusicSegment8 ptr, byval ppSegState as IDirectMusicSegmentState ptr ptr, byval pPerformance as IDirectMusicPerformance ptr, byval dwFlags as DWORD) as HRESULT
	GetGraph as function(byval This as IDirectMusicSegment8 ptr, byval ppGraph as IDirectMusicGraph ptr ptr) as HRESULT
	SetGraph as function(byval This as IDirectMusicSegment8 ptr, byval pGraph as IDirectMusicGraph ptr) as HRESULT
	AddNotificationType as function(byval This as IDirectMusicSegment8 ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	RemoveNotificationType as function(byval This as IDirectMusicSegment8 ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	GetParam as function(byval This as IDirectMusicSegment8 ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
	SetParam as function(byval This as IDirectMusicSegment8 ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pParam as any ptr) as HRESULT
	Clone as function(byval This as IDirectMusicSegment8 ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	SetStartPoint as function(byval This as IDirectMusicSegment8 ptr, byval mtStart as MUSIC_TIME) as HRESULT
	GetStartPoint as function(byval This as IDirectMusicSegment8 ptr, byval pmtStart as MUSIC_TIME ptr) as HRESULT
	SetLoopPoints as function(byval This as IDirectMusicSegment8 ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME) as HRESULT
	GetLoopPoints as function(byval This as IDirectMusicSegment8 ptr, byval pmtStart as MUSIC_TIME ptr, byval pmtEnd as MUSIC_TIME ptr) as HRESULT
	SetPChannelsUsed as function(byval This as IDirectMusicSegment8 ptr, byval dwNumPChannels as DWORD, byval paPChannels as DWORD ptr) as HRESULT
	SetTrackConfig as function(byval This as IDirectMusicSegment8 ptr, byval rguidTrackClassID as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval dwFlagsOn as DWORD, byval dwFlagsOff as DWORD) as HRESULT
	GetAudioPathConfig as function(byval This as IDirectMusicSegment8 ptr, byval ppAudioPathConfig as IUnknown ptr ptr) as HRESULT
	Compose as function(byval This as IDirectMusicSegment8 ptr, byval mtTime as MUSIC_TIME, byval pFromSegment as IDirectMusicSegment ptr, byval pToSegment as IDirectMusicSegment ptr, byval ppComposedSegment as IDirectMusicSegment ptr ptr) as HRESULT
	Download as function(byval This as IDirectMusicSegment8 ptr, byval pAudioPath as IUnknown ptr) as HRESULT
	Unload as function(byval This as IDirectMusicSegment8 ptr, byval pAudioPath as IUnknown ptr) as HRESULT
end type

#define IDirectMusicSegment8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSegment8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSegment8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSegment8_GetLength(p, a) (p)->lpVtbl->GetLength(p, a)
#define IDirectMusicSegment8_SetLength(p, a) (p)->lpVtbl->SetLength(p, a)
#define IDirectMusicSegment8_GetRepeats(p, a) (p)->lpVtbl->GetRepeats(p, a)
#define IDirectMusicSegment8_SetRepeats(p, a) (p)->lpVtbl->SetRepeats(p, a)
#define IDirectMusicSegment8_GetDefaultResolution(p, a) (p)->lpVtbl->GetDefaultResolution(p, a)
#define IDirectMusicSegment8_SetDefaultResolution(p, a) (p)->lpVtbl->SetDefaultResolution(p, a)
#define IDirectMusicSegment8_GetTrack(p, a, b, c, d) (p)->lpVtbl->GetTrack(p, a, b, c, d)
#define IDirectMusicSegment8_GetTrackGroup(p, a, b) (p)->lpVtbl->GetTrackGroup(p, a, b)
#define IDirectMusicSegment8_InsertTrack(p, a, b) (p)->lpVtbl->InsertTrack(p, a, b)
#define IDirectMusicSegment8_RemoveTrack(p, a) (p)->lpVtbl->RemoveTrack(p, a)
#define IDirectMusicSegment8_InitPlay(p, a, b, c) (p)->lpVtbl->InitPlay(p, a, b, c)
#define IDirectMusicSegment8_GetGraph(p, a) (p)->lpVtbl->GetGraph(p, a)
#define IDirectMusicSegment8_SetGraph(p, a) (p)->lpVtbl->SetGraph(p, a)
#define IDirectMusicSegment8_AddNotificationType(p, a) (p)->lpVtbl->AddNotificationType(p, a)
#define IDirectMusicSegment8_RemoveNotificationType(p, a) (p)->lpVtbl->RemoveNotificationType(p, a)
#define IDirectMusicSegment8_GetParam(p, a, b, c, d, e, f) (p)->lpVtbl->GetParam(p, a, b, c, d, e, f)
#define IDirectMusicSegment8_SetParam(p, a, b, c, d, e) (p)->lpVtbl->SetParam(p, a, b, c, d, e)
#define IDirectMusicSegment8_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirectMusicSegment8_SetStartPoint(p, a) (p)->lpVtbl->SetStartPoint(p, a)
#define IDirectMusicSegment8_GetStartPoint(p, a) (p)->lpVtbl->GetStartPoint(p, a)
#define IDirectMusicSegment8_SetLoopPoints(p, a, b) (p)->lpVtbl->SetLoopPoints(p, a, b)
#define IDirectMusicSegment8_GetLoopPoints(p, a, b) (p)->lpVtbl->GetLoopPoints(p, a, b)
#define IDirectMusicSegment8_SetPChannelsUsed(p, a, b) (p)->lpVtbl->SetPChannelsUsed(p, a, b)
#define IDirectMusicSegment8_SetTrackConfig(p, a, b, c, d, e) (p)->lpVtbl->SetTrackConfig(p, a, b, c, d, e)
#define IDirectMusicSegment8_GetAudioPathConfig(p, a) (p)->lpVtbl->GetAudioPathConfig(p, a)
#define IDirectMusicSegment8_Compose(p, a, b, c, d) (p)->lpVtbl->Compose(p, a, b, c, d)
#define IDirectMusicSegment8_Download(p, a) (p)->lpVtbl->Download(p, a)
#define IDirectMusicSegment8_Unload(p, a) (p)->lpVtbl->Unload(p, a)
type IDirectMusicSegmentStateVtbl as IDirectMusicSegmentStateVtbl_

type IDirectMusicSegmentState_
	lpVtbl as IDirectMusicSegmentStateVtbl ptr
end type

type IDirectMusicSegmentStateVtbl_
	QueryInterface as function(byval This as IDirectMusicSegmentState ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSegmentState ptr) as ULONG
	Release as function(byval This as IDirectMusicSegmentState ptr) as ULONG
	GetRepeats as function(byval This as IDirectMusicSegmentState ptr, byval pdwRepeats as DWORD ptr) as HRESULT
	GetSegment as function(byval This as IDirectMusicSegmentState ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	GetStartTime as function(byval This as IDirectMusicSegmentState ptr, byval pmtStart as MUSIC_TIME ptr) as HRESULT
	GetSeek as function(byval This as IDirectMusicSegmentState ptr, byval pmtSeek as MUSIC_TIME ptr) as HRESULT
	GetStartPoint as function(byval This as IDirectMusicSegmentState ptr, byval pmtStart as MUSIC_TIME ptr) as HRESULT
end type

#define IDirectMusicSegmentState_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSegmentState_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSegmentState_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSegmentState_GetRepeats(p, a) (p)->lpVtbl->GetRepeats(p, a)
#define IDirectMusicSegmentState_GetSegment(p, a) (p)->lpVtbl->GetSegment(p, a)
#define IDirectMusicSegmentState_GetStartTime(p, a) (p)->lpVtbl->GetStartTime(p, a)
#define IDirectMusicSegmentState_GetSeek(p, a) (p)->lpVtbl->GetSeek(p, a)
#define IDirectMusicSegmentState_GetStartPoint(p, a) (p)->lpVtbl->GetStartPoint(p, a)
type IDirectMusicSegmentState8Vtbl as IDirectMusicSegmentState8Vtbl_

type IDirectMusicSegmentState8
	lpVtbl as IDirectMusicSegmentState8Vtbl ptr
end type

type IDirectMusicSegmentState8Vtbl_
	QueryInterface as function(byval This as IDirectMusicSegmentState8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSegmentState8 ptr) as ULONG
	Release as function(byval This as IDirectMusicSegmentState8 ptr) as ULONG
	GetRepeats as function(byval This as IDirectMusicSegmentState8 ptr, byval pdwRepeats as DWORD ptr) as HRESULT
	GetSegment as function(byval This as IDirectMusicSegmentState8 ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	GetStartTime as function(byval This as IDirectMusicSegmentState8 ptr, byval pmtStart as MUSIC_TIME ptr) as HRESULT
	GetSeek as function(byval This as IDirectMusicSegmentState8 ptr, byval pmtSeek as MUSIC_TIME ptr) as HRESULT
	GetStartPoint as function(byval This as IDirectMusicSegmentState8 ptr, byval pmtStart as MUSIC_TIME ptr) as HRESULT
	SetTrackConfig as function(byval This as IDirectMusicSegmentState8 ptr, byval rguidTrackClassID as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval dwFlagsOn as DWORD, byval dwFlagsOff as DWORD) as HRESULT
	GetObjectInPath as function(byval This as IDirectMusicSegmentState8 ptr, byval dwPChannel as DWORD, byval dwStage as DWORD, byval dwBuffer as DWORD, byval guidObject as const GUID const ptr, byval dwIndex as DWORD, byval iidInterface as const GUID const ptr, byval ppObject as any ptr ptr) as HRESULT
end type

#define IDirectMusicSegmentState8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSegmentState8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSegmentState8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSegmentState8_GetRepeats(p, a) (p)->lpVtbl->GetRepeats(p, a)
#define IDirectMusicSegmentState8_GetSegment(p, a) (p)->lpVtbl->GetSegment(p, a)
#define IDirectMusicSegmentState8_GetStartTime(p, a) (p)->lpVtbl->GetStartTime(p, a)
#define IDirectMusicSegmentState8_GetSeek(p, a) (p)->lpVtbl->GetSeek(p, a)
#define IDirectMusicSegmentState8_GetStartPoint(p, a) (p)->lpVtbl->GetStartPoint(p, a)
#define IDirectMusicSegmentState8_SetTrackConfig(p, a, b, c, d, e) (p)->lpVtbl->SetTrackConfig(p, a, b, c, d, e)
#define IDirectMusicSegmentState8_GetObjectInPath(p, a, b, c, d, e, f, g) (p)->lpVtbl->GetObjectInPath(p, a, b, c, d, e, f, g)
type IDirectMusicAudioPathVtbl as IDirectMusicAudioPathVtbl_

type IDirectMusicAudioPath
	lpVtbl as IDirectMusicAudioPathVtbl ptr
end type

type IDirectMusicAudioPathVtbl_
	QueryInterface as function(byval This as IDirectMusicAudioPath ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicAudioPath ptr) as ULONG
	Release as function(byval This as IDirectMusicAudioPath ptr) as ULONG
	GetObjectInPath as function(byval This as IDirectMusicAudioPath ptr, byval dwPChannel as DWORD, byval dwStage as DWORD, byval dwBuffer as DWORD, byval guidObject as const GUID const ptr, byval dwIndex as WORD, byval iidInterface as const GUID const ptr, byval ppObject as any ptr ptr) as HRESULT
	Activate as function(byval This as IDirectMusicAudioPath ptr, byval fActivate as WINBOOL) as HRESULT
	SetVolume as function(byval This as IDirectMusicAudioPath ptr, byval lVolume as LONG, byval dwDuration as DWORD) as HRESULT
	ConvertPChannel as function(byval This as IDirectMusicAudioPath ptr, byval dwPChannelIn as DWORD, byval pdwPChannelOut as DWORD ptr) as HRESULT
end type

#define IDirectMusicAudioPath_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicAudioPath_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicAudioPath_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicAudioPath_GetObjectInPath(p, a, b, c, d, e, f, g) (p)->lpVtbl->GetObjectInPath(p, a, b, c, d, e, f, g)
#define IDirectMusicAudioPath_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusicAudioPath_SetVolume(p, a, b) (p)->lpVtbl->SetVolume(p, a, b)
#define IDirectMusicAudioPath_ConvertPChannel(p, a, b) (p)->lpVtbl->ConvertPChannel(p, a, b)
type IDirectMusicPerformanceVtbl as IDirectMusicPerformanceVtbl_

type IDirectMusicPerformance_
	lpVtbl as IDirectMusicPerformanceVtbl ptr
end type

type IDirectMusicPerformanceVtbl_
	QueryInterface as function(byval This as IDirectMusicPerformance ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicPerformance ptr) as ULONG
	Release as function(byval This as IDirectMusicPerformance ptr) as ULONG
	Init as function(byval This as IDirectMusicPerformance ptr, byval ppDirectMusic as IDirectMusic ptr ptr, byval pDirectSound as LPDIRECTSOUND, byval hWnd as HWND) as HRESULT
	PlaySegment as function(byval This as IDirectMusicPerformance ptr, byval pSegment as IDirectMusicSegment ptr, byval dwFlags as DWORD, byval i64StartTime as longint, byval ppSegmentState as IDirectMusicSegmentState ptr ptr) as HRESULT
	Stop as function(byval This as IDirectMusicPerformance ptr, byval pSegment as IDirectMusicSegment ptr, byval pSegmentState as IDirectMusicSegmentState ptr, byval mtTime as MUSIC_TIME, byval dwFlags as DWORD) as HRESULT
	GetSegmentState as function(byval This as IDirectMusicPerformance ptr, byval ppSegmentState as IDirectMusicSegmentState ptr ptr, byval mtTime as MUSIC_TIME) as HRESULT
	SetPrepareTime as function(byval This as IDirectMusicPerformance ptr, byval dwMilliSeconds as DWORD) as HRESULT
	GetPrepareTime as function(byval This as IDirectMusicPerformance ptr, byval pdwMilliSeconds as DWORD ptr) as HRESULT
	SetBumperLength as function(byval This as IDirectMusicPerformance ptr, byval dwMilliSeconds as DWORD) as HRESULT
	GetBumperLength as function(byval This as IDirectMusicPerformance ptr, byval pdwMilliSeconds as DWORD ptr) as HRESULT
	SendPMsg as function(byval This as IDirectMusicPerformance ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	MusicToReferenceTime as function(byval This as IDirectMusicPerformance ptr, byval mtTime as MUSIC_TIME, byval prtTime as REFERENCE_TIME ptr) as HRESULT
	ReferenceToMusicTime as function(byval This as IDirectMusicPerformance ptr, byval rtTime as REFERENCE_TIME, byval pmtTime as MUSIC_TIME ptr) as HRESULT
	IsPlaying as function(byval This as IDirectMusicPerformance ptr, byval pSegment as IDirectMusicSegment ptr, byval pSegState as IDirectMusicSegmentState ptr) as HRESULT
	GetTime as function(byval This as IDirectMusicPerformance ptr, byval prtNow as REFERENCE_TIME ptr, byval pmtNow as MUSIC_TIME ptr) as HRESULT
	AllocPMsg as function(byval This as IDirectMusicPerformance ptr, byval cb as ULONG, byval ppPMSG as DMUS_PMSG ptr ptr) as HRESULT
	FreePMsg as function(byval This as IDirectMusicPerformance ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	GetGraph as function(byval This as IDirectMusicPerformance ptr, byval ppGraph as IDirectMusicGraph ptr ptr) as HRESULT
	SetGraph as function(byval This as IDirectMusicPerformance ptr, byval pGraph as IDirectMusicGraph ptr) as HRESULT
	SetNotificationHandle as function(byval This as IDirectMusicPerformance ptr, byval hNotification as HANDLE, byval rtMinimum as REFERENCE_TIME) as HRESULT
	GetNotificationPMsg as function(byval This as IDirectMusicPerformance ptr, byval ppNotificationPMsg as DMUS_NOTIFICATION_PMSG ptr ptr) as HRESULT
	AddNotificationType as function(byval This as IDirectMusicPerformance ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	RemoveNotificationType as function(byval This as IDirectMusicPerformance ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	AddPort as function(byval This as IDirectMusicPerformance ptr, byval pPort as IDirectMusicPort ptr) as HRESULT
	RemovePort as function(byval This as IDirectMusicPerformance ptr, byval pPort as IDirectMusicPort ptr) as HRESULT
	AssignPChannelBlock as function(byval This as IDirectMusicPerformance ptr, byval dwBlockNum as DWORD, byval pPort as IDirectMusicPort ptr, byval dwGroup as DWORD) as HRESULT
	AssignPChannel as function(byval This as IDirectMusicPerformance ptr, byval dwPChannel as DWORD, byval pPort as IDirectMusicPort ptr, byval dwGroup as DWORD, byval dwMChannel as DWORD) as HRESULT
	PChannelInfo as function(byval This as IDirectMusicPerformance ptr, byval dwPChannel as DWORD, byval ppPort as IDirectMusicPort ptr ptr, byval pdwGroup as DWORD ptr, byval pdwMChannel as DWORD ptr) as HRESULT
	DownloadInstrument as function(byval This as IDirectMusicPerformance ptr, byval pInst as IDirectMusicInstrument ptr, byval dwPChannel as DWORD, byval ppDownInst as IDirectMusicDownloadedInstrument ptr ptr, byval pNoteRanges as DMUS_NOTERANGE ptr, byval dwNumNoteRanges as DWORD, byval ppPort as IDirectMusicPort ptr ptr, byval pdwGroup as DWORD ptr, byval pdwMChannel as DWORD ptr) as HRESULT
	Invalidate as function(byval This as IDirectMusicPerformance ptr, byval mtTime as MUSIC_TIME, byval dwFlags as DWORD) as HRESULT
	GetParam as function(byval This as IDirectMusicPerformance ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
	SetParam as function(byval This as IDirectMusicPerformance ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pParam as any ptr) as HRESULT
	GetGlobalParam as function(byval This as IDirectMusicPerformance ptr, byval rguidType as const GUID const ptr, byval pParam as any ptr, byval dwSize as DWORD) as HRESULT
	SetGlobalParam as function(byval This as IDirectMusicPerformance ptr, byval rguidType as const GUID const ptr, byval pParam as any ptr, byval dwSize as DWORD) as HRESULT
	GetLatencyTime as function(byval This as IDirectMusicPerformance ptr, byval prtTime as REFERENCE_TIME ptr) as HRESULT
	GetQueueTime as function(byval This as IDirectMusicPerformance ptr, byval prtTime as REFERENCE_TIME ptr) as HRESULT
	AdjustTime as function(byval This as IDirectMusicPerformance ptr, byval rtAmount as REFERENCE_TIME) as HRESULT
	CloseDown as function(byval This as IDirectMusicPerformance ptr) as HRESULT
	GetResolvedTime as function(byval This as IDirectMusicPerformance ptr, byval rtTime as REFERENCE_TIME, byval prtResolved as REFERENCE_TIME ptr, byval dwTimeResolveFlags as DWORD) as HRESULT
	MIDIToMusic as function(byval This as IDirectMusicPerformance ptr, byval bMIDIValue as UBYTE, byval pChord as DMUS_CHORD_KEY ptr, byval bPlayMode as UBYTE, byval bChordLevel as UBYTE, byval pwMusicValue as WORD ptr) as HRESULT
	MusicToMIDI as function(byval This as IDirectMusicPerformance ptr, byval wMusicValue as WORD, byval pChord as DMUS_CHORD_KEY ptr, byval bPlayMode as UBYTE, byval bChordLevel as UBYTE, byval pbMIDIValue as UBYTE ptr) as HRESULT
	TimeToRhythm as function(byval This as IDirectMusicPerformance ptr, byval mtTime as MUSIC_TIME, byval pTimeSig as DMUS_TIMESIGNATURE ptr, byval pwMeasure as WORD ptr, byval pbBeat as UBYTE ptr, byval pbGrid as UBYTE ptr, byval pnOffset as short ptr) as HRESULT
	RhythmToTime as function(byval This as IDirectMusicPerformance ptr, byval wMeasure as WORD, byval bBeat as UBYTE, byval bGrid as UBYTE, byval nOffset as short, byval pTimeSig as DMUS_TIMESIGNATURE ptr, byval pmtTime as MUSIC_TIME ptr) as HRESULT
end type

#define IDirectMusicPerformance_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicPerformance_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicPerformance_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicPerformance_Init(p, a, b, c) (p)->lpVtbl->Init(p, a, b, c)
#define IDirectMusicPerformance_PlaySegment(p, a, b, c, d) (p)->lpVtbl->PlaySegment(p, a, b, c, d)
#define IDirectMusicPerformance_Stop(p, a, b, c, d) (p)->lpVtbl->Stop(p, a, b, c, d)
#define IDirectMusicPerformance_GetSegmentState(p, a, b) (p)->lpVtbl->GetSegmentState(p, a, b)
#define IDirectMusicPerformance_SetPrepareTime(p, a) (p)->lpVtbl->SetPrepareTime(p, a)
#define IDirectMusicPerformance_GetPrepareTime(p, a) (p)->lpVtbl->GetPrepareTime(p, a)
#define IDirectMusicPerformance_SetBumperLength(p, a) (p)->lpVtbl->SetBumperLength(p, a)
#define IDirectMusicPerformance_GetBumperLength(p, a) (p)->lpVtbl->GetBumperLength(p, a)
#define IDirectMusicPerformance_SendPMsg(p, a) (p)->lpVtbl->SendPMsg(p, a)
#define IDirectMusicPerformance_MusicToReferenceTime(p, a, b) (p)->lpVtbl->MusicToReferenceTime(p, a, b)
#define IDirectMusicPerformance_ReferenceToMusicTime(p, a, b) (p)->lpVtbl->ReferenceToMusicTime(p, a, b)
#define IDirectMusicPerformance_IsPlaying(p, a, b) (p)->lpVtbl->IsPlaying(p, a, b)
#define IDirectMusicPerformance_GetTime(p, a, b) (p)->lpVtbl->GetTime(p, a, b)
#define IDirectMusicPerformance_AllocPMsg(p, a, b) (p)->lpVtbl->AllocPMsg(p, a, b)
#define IDirectMusicPerformance_FreePMsg(p, a) (p)->lpVtbl->FreePMsg(p, a)
#define IDirectMusicPerformance_GetGraph(p, a) (p)->lpVtbl->GetGraph(p, a)
#define IDirectMusicPerformance_SetGraph(p, a) (p)->lpVtbl->SetGraph(p, a)
#define IDirectMusicPerformance_SetNotificationHandle(p, a, b) (p)->lpVtbl->SetNotificationHandle(p, a, b)
#define IDirectMusicPerformance_GetNotificationPMsg(p, a) (p)->lpVtbl->GetNotificationPMsg(p, a)
#define IDirectMusicPerformance_AddNotificationType(p, a) (p)->lpVtbl->AddNotificationType(p, a)
#define IDirectMusicPerformance_RemoveNotificationType(p, a) (p)->lpVtbl->RemoveNotificationType(p, a)
#define IDirectMusicPerformance_AddPort(p, a) (p)->lpVtbl->AddPort(p, a)
#define IDirectMusicPerformance_RemovePort(p, a) (p)->lpVtbl->RemovePort(p, a)
#define IDirectMusicPerformance_AssignPChannelBlock(p, a, b, c) (p)->lpVtbl->AssignPChannelBlock(p, a, b, c)
#define IDirectMusicPerformance_AssignPChannel(p, a, b, c, d) (p)->lpVtbl->AssignPChannel(p, a, b, c, d)
#define IDirectMusicPerformance_PChannelInfo(p, a, b, c, d) (p)->lpVtbl->PChannelInfo(p, a, b, c, d)
#define IDirectMusicPerformance_DownloadInstrument(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->DownloadInstrument(p, a, b, c, d, e, f, g, h)
#define IDirectMusicPerformance_Invalidate(p, a, b) (p)->lpVtbl->Invalidate(p, a, b)
#define IDirectMusicPerformance_GetParam(p, a, b, c, d, e, f) (p)->lpVtbl->GetParam(p, a, b, c, d, e, f)
#define IDirectMusicPerformance_SetParam(p, a, b, c, d, e) (p)->lpVtbl->SetParam(p, a, b, c, d, e)
#define IDirectMusicPerformance_GetGlobalParam(p, a, b, c) (p)->lpVtbl->GetGlobalParam(p, a, b, c)
#define IDirectMusicPerformance_SetGlobalParam(p, a, b, c) (p)->lpVtbl->SetGlobalParam(p, a, b, c)
#define IDirectMusicPerformance_GetLatencyTime(p, a) (p)->lpVtbl->GetLatencyTime(p, a)
#define IDirectMusicPerformance_GetQueueTime(p, a) (p)->lpVtbl->GetQueueTime(p, a)
#define IDirectMusicPerformance_AdjustTime(p, a) (p)->lpVtbl->AdjustTime(p, a)
#define IDirectMusicPerformance_CloseDown(p) (p)->lpVtbl->CloseDown(p)
#define IDirectMusicPerformance_GetResolvedTime(p, a, b, c) (p)->lpVtbl->GetResolvedTime(p, a, b, c)
#define IDirectMusicPerformance_MIDIToMusic(p, a, b, c, d, e) (p)->lpVtbl->MIDIToMusic(p, a, b, c, d, e)
#define IDirectMusicPerformance_MusicToMIDI(p, a, b, c, d, e) (p)->lpVtbl->MusicToMIDI(p, a, b, c, d, e)
#define IDirectMusicPerformance_TimeToRhythm(p, a, b, c, d, e, f) (p)->lpVtbl->TimeToRhythm(p, a, b, c, d, e, f)
#define IDirectMusicPerformance_RhythmToTime(p, a, b, c, d, e, f) (p)->lpVtbl->RhythmToTime(p, a, b, c, d, e, f)
type IDirectMusicPerformance8Vtbl as IDirectMusicPerformance8Vtbl_

type IDirectMusicPerformance8
	lpVtbl as IDirectMusicPerformance8Vtbl ptr
end type

type IDirectMusicPerformance8Vtbl_
	QueryInterface as function(byval This as IDirectMusicPerformance8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicPerformance8 ptr) as ULONG
	Release as function(byval This as IDirectMusicPerformance8 ptr) as ULONG
	Init as function(byval This as IDirectMusicPerformance8 ptr, byval ppDirectMusic as IDirectMusic ptr ptr, byval pDirectSound as LPDIRECTSOUND, byval hWnd as HWND) as HRESULT
	PlaySegment as function(byval This as IDirectMusicPerformance8 ptr, byval pSegment as IDirectMusicSegment ptr, byval dwFlags as DWORD, byval i64StartTime as longint, byval ppSegmentState as IDirectMusicSegmentState ptr ptr) as HRESULT
	Stop as function(byval This as IDirectMusicPerformance8 ptr, byval pSegment as IDirectMusicSegment ptr, byval pSegmentState as IDirectMusicSegmentState ptr, byval mtTime as MUSIC_TIME, byval dwFlags as DWORD) as HRESULT
	GetSegmentState as function(byval This as IDirectMusicPerformance8 ptr, byval ppSegmentState as IDirectMusicSegmentState ptr ptr, byval mtTime as MUSIC_TIME) as HRESULT
	SetPrepareTime as function(byval This as IDirectMusicPerformance8 ptr, byval dwMilliSeconds as DWORD) as HRESULT
	GetPrepareTime as function(byval This as IDirectMusicPerformance8 ptr, byval pdwMilliSeconds as DWORD ptr) as HRESULT
	SetBumperLength as function(byval This as IDirectMusicPerformance8 ptr, byval dwMilliSeconds as DWORD) as HRESULT
	GetBumperLength as function(byval This as IDirectMusicPerformance8 ptr, byval pdwMilliSeconds as DWORD ptr) as HRESULT
	SendPMsg as function(byval This as IDirectMusicPerformance8 ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	MusicToReferenceTime as function(byval This as IDirectMusicPerformance8 ptr, byval mtTime as MUSIC_TIME, byval prtTime as REFERENCE_TIME ptr) as HRESULT
	ReferenceToMusicTime as function(byval This as IDirectMusicPerformance8 ptr, byval rtTime as REFERENCE_TIME, byval pmtTime as MUSIC_TIME ptr) as HRESULT
	IsPlaying as function(byval This as IDirectMusicPerformance8 ptr, byval pSegment as IDirectMusicSegment ptr, byval pSegState as IDirectMusicSegmentState ptr) as HRESULT
	GetTime as function(byval This as IDirectMusicPerformance8 ptr, byval prtNow as REFERENCE_TIME ptr, byval pmtNow as MUSIC_TIME ptr) as HRESULT
	AllocPMsg as function(byval This as IDirectMusicPerformance8 ptr, byval cb as ULONG, byval ppPMSG as DMUS_PMSG ptr ptr) as HRESULT
	FreePMsg as function(byval This as IDirectMusicPerformance8 ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	GetGraph as function(byval This as IDirectMusicPerformance8 ptr, byval ppGraph as IDirectMusicGraph ptr ptr) as HRESULT
	SetGraph as function(byval This as IDirectMusicPerformance8 ptr, byval pGraph as IDirectMusicGraph ptr) as HRESULT
	SetNotificationHandle as function(byval This as IDirectMusicPerformance8 ptr, byval hNotification as HANDLE, byval rtMinimum as REFERENCE_TIME) as HRESULT
	GetNotificationPMsg as function(byval This as IDirectMusicPerformance8 ptr, byval ppNotificationPMsg as DMUS_NOTIFICATION_PMSG ptr ptr) as HRESULT
	AddNotificationType as function(byval This as IDirectMusicPerformance8 ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	RemoveNotificationType as function(byval This as IDirectMusicPerformance8 ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	AddPort as function(byval This as IDirectMusicPerformance8 ptr, byval pPort as IDirectMusicPort ptr) as HRESULT
	RemovePort as function(byval This as IDirectMusicPerformance8 ptr, byval pPort as IDirectMusicPort ptr) as HRESULT
	AssignPChannelBlock as function(byval This as IDirectMusicPerformance8 ptr, byval dwBlockNum as DWORD, byval pPort as IDirectMusicPort ptr, byval dwGroup as DWORD) as HRESULT
	AssignPChannel as function(byval This as IDirectMusicPerformance8 ptr, byval dwPChannel as DWORD, byval pPort as IDirectMusicPort ptr, byval dwGroup as DWORD, byval dwMChannel as DWORD) as HRESULT
	PChannelInfo as function(byval This as IDirectMusicPerformance8 ptr, byval dwPChannel as DWORD, byval ppPort as IDirectMusicPort ptr ptr, byval pdwGroup as DWORD ptr, byval pdwMChannel as DWORD ptr) as HRESULT
	DownloadInstrument as function(byval This as IDirectMusicPerformance8 ptr, byval pInst as IDirectMusicInstrument ptr, byval dwPChannel as DWORD, byval ppDownInst as IDirectMusicDownloadedInstrument ptr ptr, byval pNoteRanges as DMUS_NOTERANGE ptr, byval dwNumNoteRanges as DWORD, byval ppPort as IDirectMusicPort ptr ptr, byval pdwGroup as DWORD ptr, byval pdwMChannel as DWORD ptr) as HRESULT
	Invalidate as function(byval This as IDirectMusicPerformance8 ptr, byval mtTime as MUSIC_TIME, byval dwFlags as DWORD) as HRESULT
	GetParam as function(byval This as IDirectMusicPerformance8 ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
	SetParam as function(byval This as IDirectMusicPerformance8 ptr, byval rguidType as const GUID const ptr, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pParam as any ptr) as HRESULT
	GetGlobalParam as function(byval This as IDirectMusicPerformance8 ptr, byval rguidType as const GUID const ptr, byval pParam as any ptr, byval dwSize as DWORD) as HRESULT
	SetGlobalParam as function(byval This as IDirectMusicPerformance8 ptr, byval rguidType as const GUID const ptr, byval pParam as any ptr, byval dwSize as DWORD) as HRESULT
	GetLatencyTime as function(byval This as IDirectMusicPerformance8 ptr, byval prtTime as REFERENCE_TIME ptr) as HRESULT
	GetQueueTime as function(byval This as IDirectMusicPerformance8 ptr, byval prtTime as REFERENCE_TIME ptr) as HRESULT
	AdjustTime as function(byval This as IDirectMusicPerformance8 ptr, byval rtAmount as REFERENCE_TIME) as HRESULT
	CloseDown as function(byval This as IDirectMusicPerformance8 ptr) as HRESULT
	GetResolvedTime as function(byval This as IDirectMusicPerformance8 ptr, byval rtTime as REFERENCE_TIME, byval prtResolved as REFERENCE_TIME ptr, byval dwTimeResolveFlags as DWORD) as HRESULT
	MIDIToMusic as function(byval This as IDirectMusicPerformance8 ptr, byval bMIDIValue as UBYTE, byval pChord as DMUS_CHORD_KEY ptr, byval bPlayMode as UBYTE, byval bChordLevel as UBYTE, byval pwMusicValue as WORD ptr) as HRESULT
	MusicToMIDI as function(byval This as IDirectMusicPerformance8 ptr, byval wMusicValue as WORD, byval pChord as DMUS_CHORD_KEY ptr, byval bPlayMode as UBYTE, byval bChordLevel as UBYTE, byval pbMIDIValue as UBYTE ptr) as HRESULT
	TimeToRhythm as function(byval This as IDirectMusicPerformance8 ptr, byval mtTime as MUSIC_TIME, byval pTimeSig as DMUS_TIMESIGNATURE ptr, byval pwMeasure as WORD ptr, byval pbBeat as UBYTE ptr, byval pbGrid as UBYTE ptr, byval pnOffset as short ptr) as HRESULT
	RhythmToTime as function(byval This as IDirectMusicPerformance8 ptr, byval wMeasure as WORD, byval bBeat as UBYTE, byval bGrid as UBYTE, byval nOffset as short, byval pTimeSig as DMUS_TIMESIGNATURE ptr, byval pmtTime as MUSIC_TIME ptr) as HRESULT
	InitAudio as function(byval This as IDirectMusicPerformance8 ptr, byval ppDirectMusic as IDirectMusic ptr ptr, byval ppDirectSound as IDirectSound ptr ptr, byval hWnd as HWND, byval dwDefaultPathType as DWORD, byval dwPChannelCount as DWORD, byval dwFlags as DWORD, byval pParams as DMUS_AUDIOPARAMS ptr) as HRESULT
	PlaySegmentEx as function(byval This as IDirectMusicPerformance8 ptr, byval pSource as IUnknown ptr, byval pwzSegmentName as wstring ptr, byval pTransition as IUnknown ptr, byval dwFlags as DWORD, byval i64StartTime as longint, byval ppSegmentState as IDirectMusicSegmentState ptr ptr, byval pFrom as IUnknown ptr, byval pAudioPath as IUnknown ptr) as HRESULT
	StopEx as function(byval This as IDirectMusicPerformance8 ptr, byval pObjectToStop as IUnknown ptr, byval i64StopTime as longint, byval dwFlags as DWORD) as HRESULT
	ClonePMsg as function(byval This as IDirectMusicPerformance8 ptr, byval pSourcePMSG as DMUS_PMSG ptr, byval ppCopyPMSG as DMUS_PMSG ptr ptr) as HRESULT
	CreateAudioPath as function(byval This as IDirectMusicPerformance8 ptr, byval pSourceConfig as IUnknown ptr, byval fActivate as WINBOOL, byval ppNewPath as IDirectMusicAudioPath ptr ptr) as HRESULT
	CreateStandardAudioPath as function(byval This as IDirectMusicPerformance8 ptr, byval dwType as DWORD, byval dwPChannelCount as DWORD, byval fActivate as WINBOOL, byval ppNewPath as IDirectMusicAudioPath ptr ptr) as HRESULT
	SetDefaultAudioPath as function(byval This as IDirectMusicPerformance8 ptr, byval pAudioPath as IDirectMusicAudioPath ptr) as HRESULT
	GetDefaultAudioPath as function(byval This as IDirectMusicPerformance8 ptr, byval ppAudioPath as IDirectMusicAudioPath ptr ptr) as HRESULT
	GetParamEx as function(byval This as IDirectMusicPerformance8 ptr, byval rguidType as const GUID const ptr, byval dwTrackID as DWORD, byval dwGroupBits as DWORD, byval dwIndex as DWORD, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
end type

#define IDirectMusicPerformance8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicPerformance8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicPerformance8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicPerformance8_Init(p, a, b, c) (p)->lpVtbl->Init(p, a, b, c)
#define IDirectMusicPerformance8_PlaySegment(p, a, b, c, d) (p)->lpVtbl->PlaySegment(p, a, b, c, d)
#define IDirectMusicPerformance8_Stop(p, a, b, c, d) (p)->lpVtbl->Stop(p, a, b, c, d)
#define IDirectMusicPerformance8_GetSegmentState(p, a, b) (p)->lpVtbl->GetSegmentState(p, a, b)
#define IDirectMusicPerformance8_SetPrepareTime(p, a) (p)->lpVtbl->SetPrepareTime(p, a)
#define IDirectMusicPerformance8_GetPrepareTime(p, a) (p)->lpVtbl->GetPrepareTime(p, a)
#define IDirectMusicPerformance8_SetBumperLength(p, a) (p)->lpVtbl->SetBumperLength(p, a)
#define IDirectMusicPerformance8_GetBumperLength(p, a) (p)->lpVtbl->GetBumperLength(p, a)
#define IDirectMusicPerformance8_SendPMsg(p, a) (p)->lpVtbl->SendPMsg(p, a)
#define IDirectMusicPerformance8_MusicToReferenceTime(p, a, b) (p)->lpVtbl->MusicToReferenceTime(p, a, b)
#define IDirectMusicPerformance8_ReferenceToMusicTime(p, a, b) (p)->lpVtbl->ReferenceToMusicTime(p, a, b)
#define IDirectMusicPerformance8_IsPlaying(p, a, b) (p)->lpVtbl->IsPlaying(p, a, b)
#define IDirectMusicPerformance8_GetTime(p, a, b) (p)->lpVtbl->GetTime(p, a, b)
#define IDirectMusicPerformance8_AllocPMsg(p, a, b) (p)->lpVtbl->AllocPMsg(p, a, b)
#define IDirectMusicPerformance8_FreePMsg(p, a) (p)->lpVtbl->FreePMsg(p, a)
#define IDirectMusicPerformance8_GetGraph(p, a) (p)->lpVtbl->GetGraph(p, a)
#define IDirectMusicPerformance8_SetGraph(p, a) (p)->lpVtbl->SetGraph(p, a)
#define IDirectMusicPerformance8_SetNotificationHandle(p, a, b) (p)->lpVtbl->SetNotificationHandle(p, a, b)
#define IDirectMusicPerformance8_GetNotificationPMsg(p, a) (p)->lpVtbl->GetNotificationPMsg(p, a)
#define IDirectMusicPerformance8_AddNotificationType(p, a) (p)->lpVtbl->AddNotificationType(p, a)
#define IDirectMusicPerformance8_RemoveNotificationType(p, a) (p)->lpVtbl->RemoveNotificationType(p, a)
#define IDirectMusicPerformance8_AddPort(p, a) (p)->lpVtbl->AddPort(p, a)
#define IDirectMusicPerformance8_RemovePort(p, a) (p)->lpVtbl->RemovePort(p, a)
#define IDirectMusicPerformance8_AssignPChannelBlock(p, a, b, c) (p)->lpVtbl->AssignPChannelBlock(p, a, b, c)
#define IDirectMusicPerformance8_AssignPChannel(p, a, b, c, d) (p)->lpVtbl->AssignPChannel(p, a, b, c, d)
#define IDirectMusicPerformance8_PChannelInfo(p, a, b, c, d) (p)->lpVtbl->PChannelInfo(p, a, b, c, d)
#define IDirectMusicPerformance8_DownloadInstrument(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->DownloadInstrument(p, a, b, c, d, e, f, g, h)
#define IDirectMusicPerformance8_Invalidate(p, a, b) (p)->lpVtbl->Invalidate(p, a, b)
#define IDirectMusicPerformance8_GetParam(p, a, b, c, d, e, f) (p)->lpVtbl->GetParam(p, a, b, c, d, e, f)
#define IDirectMusicPerformance8_SetParam(p, a, b, c, d, e) (p)->lpVtbl->SetParam(p, a, b, c, d, e)
#define IDirectMusicPerformance8_GetGlobalParam(p, a, b, c) (p)->lpVtbl->GetGlobalParam(p, a, b, c)
#define IDirectMusicPerformance8_SetGlobalParam(p, a, b, c) (p)->lpVtbl->SetGlobalParam(p, a, b, c)
#define IDirectMusicPerformance8_GetLatencyTime(p, a) (p)->lpVtbl->GetLatencyTime(p, a)
#define IDirectMusicPerformance8_GetQueueTime(p, a) (p)->lpVtbl->GetQueueTime(p, a)
#define IDirectMusicPerformance8_AdjustTime(p, a) (p)->lpVtbl->AdjustTime(p, a)
#define IDirectMusicPerformance8_CloseDown(p) (p)->lpVtbl->CloseDown(p)
#define IDirectMusicPerformance8_GetResolvedTime(p, a, b, c) (p)->lpVtbl->GetResolvedTime(p, a, b, c)
#define IDirectMusicPerformance8_MIDIToMusic(p, a, b, c, d, e) (p)->lpVtbl->MIDIToMusic(p, a, b, c, d, e)
#define IDirectMusicPerformance8_MusicToMIDI(p, a, b, c, d, e) (p)->lpVtbl->MusicToMIDI(p, a, b, c, d, e)
#define IDirectMusicPerformance8_TimeToRhythm(p, a, b, c, d, e, f) (p)->lpVtbl->TimeToRhythm(p, a, b, c, d, e, f)
#define IDirectMusicPerformance8_RhythmToTime(p, a, b, c, d, e, f) (p)->lpVtbl->RhythmToTime(p, a, b, c, d, e, f)
#define IDirectMusicPerformance8_InitAudio(p, a, b, c, d, e, f, g) (p)->lpVtbl->InitAudio(p, a, b, c, d, e, f, g)
#define IDirectMusicPerformance8_PlaySegmentEx(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->PlaySegmentEx(p, a, b, c, d, e, f, g, h)
#define IDirectMusicPerformance8_StopEx(p, a, b, c) (p)->lpVtbl->StopEx(p, a, b, c)
#define IDirectMusicPerformance8_ClonePMsg(p, a, b) (p)->lpVtbl->ClonePMsg(p, a, b)
#define IDirectMusicPerformance8_CreateAudioPath(p, a, b, c) (p)->lpVtbl->CreateAudioPath(p, a, b, c)
#define IDirectMusicPerformance8_CreateStandardAudioPath(p, a, b, c, d) (p)->lpVtbl->CreateStandardAudioPath(p, a, b, c, d)
#define IDirectMusicPerformance8_SetDefaultAudioPath(p, a) (p)->lpVtbl->SetDefaultAudioPath(p, a)
#define IDirectMusicPerformance8_GetDefaultAudioPath(p, a) (p)->lpVtbl->GetDefaultAudioPath(p, a)
#define IDirectMusicPerformance8_GetParamEx(p, a, b, c, d, e, f, g) (p)->lpVtbl->GetParamEx(p, a, b, c, d, e, f, g)
type IDirectMusicGraphVtbl as IDirectMusicGraphVtbl_

type IDirectMusicGraph_
	lpVtbl as IDirectMusicGraphVtbl ptr
end type

type IDirectMusicGraphVtbl_
	QueryInterface as function(byval This as IDirectMusicGraph ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicGraph ptr) as ULONG
	Release as function(byval This as IDirectMusicGraph ptr) as ULONG
	StampPMsg as function(byval This as IDirectMusicGraph ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	InsertTool as function(byval This as IDirectMusicGraph ptr, byval pTool as IDirectMusicTool ptr, byval pdwPChannels as DWORD ptr, byval cPChannels as DWORD, byval lIndex as LONG) as HRESULT
	GetTool as function(byval This as IDirectMusicGraph ptr, byval dwIndex as DWORD, byval ppTool as IDirectMusicTool ptr ptr) as HRESULT
	RemoveTool as function(byval This as IDirectMusicGraph ptr, byval pTool as IDirectMusicTool ptr) as HRESULT
end type

#define IDirectMusicGraph_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicGraph_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicGraph_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicGraph_StampPMsg(p, a) (p)->lpVtbl->StampPMsg(p, a)
#define IDirectMusicGraph_InsertTool(p, a, b, c, d) (p)->lpVtbl->InsertTool(p, a, b, c, d)
#define IDirectMusicGraph_GetTool(p, a, b) (p)->lpVtbl->GetTool(p, a, b)
#define IDirectMusicGraph_RemoveTool(p, a) (p)->lpVtbl->RemoveTool(p, a)
type IDirectMusicStyleVtbl as IDirectMusicStyleVtbl_

type IDirectMusicStyle
	lpVtbl as IDirectMusicStyleVtbl ptr
end type

type IDirectMusicStyleVtbl_
	QueryInterface as function(byval This as IDirectMusicStyle ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicStyle ptr) as ULONG
	Release as function(byval This as IDirectMusicStyle ptr) as ULONG
	GetBand as function(byval This as IDirectMusicStyle ptr, byval pwszName as wstring ptr, byval ppBand as IDirectMusicBand ptr ptr) as HRESULT
	EnumBand as function(byval This as IDirectMusicStyle ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	GetDefaultBand as function(byval This as IDirectMusicStyle ptr, byval ppBand as IDirectMusicBand ptr ptr) as HRESULT
	EnumMotif as function(byval This as IDirectMusicStyle ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	GetMotif as function(byval This as IDirectMusicStyle ptr, byval pwszName as wstring ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	GetDefaultChordMap as function(byval This as IDirectMusicStyle ptr, byval ppChordMap as IDirectMusicChordMap ptr ptr) as HRESULT
	EnumChordMap as function(byval This as IDirectMusicStyle ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	GetChordMap as function(byval This as IDirectMusicStyle ptr, byval pwszName as wstring ptr, byval ppChordMap as IDirectMusicChordMap ptr ptr) as HRESULT
	GetTimeSignature as function(byval This as IDirectMusicStyle ptr, byval pTimeSig as DMUS_TIMESIGNATURE ptr) as HRESULT
	GetEmbellishmentLength as function(byval This as IDirectMusicStyle ptr, byval dwType as DWORD, byval dwLevel as DWORD, byval pdwMin as DWORD ptr, byval pdwMax as DWORD ptr) as HRESULT
	GetTempo as function(byval This as IDirectMusicStyle ptr, byval pTempo as double ptr) as HRESULT
end type

#define IDirectMusicStyle_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicStyle_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicStyle_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicStyle_GetBand(p, a, b) (p)->lpVtbl->GetBand(p, a, b)
#define IDirectMusicStyle_EnumBand(p, a, b) (p)->lpVtbl->EnumBand(p, a, b)
#define IDirectMusicStyle_GetDefaultBand(p, a) (p)->lpVtbl->GetDefaultBand(p, a)
#define IDirectMusicStyle_EnumMotif(p, a, b) (p)->lpVtbl->EnumMotif(p, a, b)
#define IDirectMusicStyle_GetMotif(p, a, b) (p)->lpVtbl->GetMotif(p, a, b)
#define IDirectMusicStyle_GetDefaultChordMap(p, a) (p)->lpVtbl->GetDefaultChordMap(p, a)
#define IDirectMusicStyle_EnumChordMap(p, a, b) (p)->lpVtbl->EnumChordMap(p, a, b)
#define IDirectMusicStyle_GetChordMap(p, a, b) (p)->lpVtbl->GetChordMap(p, a, b)
#define IDirectMusicStyle_GetTimeSignature(p, a) (p)->lpVtbl->GetTimeSignature(p, a)
#define IDirectMusicStyle_GetEmbellishmentLength(p, a, b, c, d) (p)->lpVtbl->GetEmbellishmentLength(p, a, b, c, d)
#define IDirectMusicStyle_GetTempo(p, a) (p)->lpVtbl->GetTempo(p, a)
type IDirectMusicStyle8Vtbl as IDirectMusicStyle8Vtbl_

type IDirectMusicStyle8
	lpVtbl as IDirectMusicStyle8Vtbl ptr
end type

type IDirectMusicStyle8Vtbl_
	QueryInterface as function(byval This as IDirectMusicStyle8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicStyle8 ptr) as ULONG
	Release as function(byval This as IDirectMusicStyle8 ptr) as ULONG
	GetBand as function(byval This as IDirectMusicStyle8 ptr, byval pwszName as wstring ptr, byval ppBand as IDirectMusicBand ptr ptr) as HRESULT
	EnumBand as function(byval This as IDirectMusicStyle8 ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	GetDefaultBand as function(byval This as IDirectMusicStyle8 ptr, byval ppBand as IDirectMusicBand ptr ptr) as HRESULT
	EnumMotif as function(byval This as IDirectMusicStyle8 ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	GetMotif as function(byval This as IDirectMusicStyle8 ptr, byval pwszName as wstring ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	GetDefaultChordMap as function(byval This as IDirectMusicStyle8 ptr, byval ppChordMap as IDirectMusicChordMap ptr ptr) as HRESULT
	EnumChordMap as function(byval This as IDirectMusicStyle8 ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	GetChordMap as function(byval This as IDirectMusicStyle8 ptr, byval pwszName as wstring ptr, byval ppChordMap as IDirectMusicChordMap ptr ptr) as HRESULT
	GetTimeSignature as function(byval This as IDirectMusicStyle8 ptr, byval pTimeSig as DMUS_TIMESIGNATURE ptr) as HRESULT
	GetEmbellishmentLength as function(byval This as IDirectMusicStyle8 ptr, byval dwType as DWORD, byval dwLevel as DWORD, byval pdwMin as DWORD ptr, byval pdwMax as DWORD ptr) as HRESULT
	GetTempo as function(byval This as IDirectMusicStyle8 ptr, byval pTempo as double ptr) as HRESULT
	EnumPattern as function(byval This as IDirectMusicStyle8 ptr, byval dwIndex as DWORD, byval dwPatternType as DWORD, byval pwszName as wstring ptr) as HRESULT
end type

#define IDirectMusicStyle8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicStyle8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicStyle8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicStyle8_GetBand(p, a, b) (p)->lpVtbl->GetBand(p, a, b)
#define IDirectMusicStyle8_EnumBand(p, a, b) (p)->lpVtbl->EnumBand(p, a, b)
#define IDirectMusicStyle8_GetDefaultBand(p, a) (p)->lpVtbl->GetDefaultBand(p, a)
#define IDirectMusicStyle8_EnumMotif(p, a, b) (p)->lpVtbl->EnumMotif(p, a, b)
#define IDirectMusicStyle8_GetMotif(p, a, b) (p)->lpVtbl->GetMotif(p, a, b)
#define IDirectMusicStyle8_GetDefaultChordMap(p, a) (p)->lpVtbl->GetDefaultChordMap(p, a)
#define IDirectMusicStyle8_EnumChordMap(p, a, b) (p)->lpVtbl->EnumChordMap(p, a, b)
#define IDirectMusicStyle8_GetChordMap(p, a, b) (p)->lpVtbl->GetChordMap(p, a, b)
#define IDirectMusicStyle8_GetTimeSignature(p, a) (p)->lpVtbl->GetTimeSignature(p, a)
#define IDirectMusicStyle8_GetEmbellishmentLength(p, a, b, c, d) (p)->lpVtbl->GetEmbellishmentLength(p, a, b, c, d)
#define IDirectMusicStyle8_GetTempo(p, a) (p)->lpVtbl->GetTempo(p, a)
#define IDirectMusicStyle8_EnumPattern(p, a, b, c) (p)->lpVtbl->EnumPattern(p, a, b, c)
type IDirectMusicChordMapVtbl as IDirectMusicChordMapVtbl_

type IDirectMusicChordMap_
	lpVtbl as IDirectMusicChordMapVtbl ptr
end type

type IDirectMusicChordMapVtbl_
	QueryInterface as function(byval This as IDirectMusicChordMap ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicChordMap ptr) as ULONG
	Release as function(byval This as IDirectMusicChordMap ptr) as ULONG
	GetScale as function(byval This as IDirectMusicChordMap ptr, byval pdwScale as DWORD ptr) as HRESULT
end type

#define IDirectMusicChordMap_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicChordMap_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicChordMap_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicChordMap_GetScale(p, a) (p)->lpVtbl->GetScale(p, a)
type IDirectMusicComposerVtbl as IDirectMusicComposerVtbl_

type IDirectMusicComposer
	lpVtbl as IDirectMusicComposerVtbl ptr
end type

type IDirectMusicComposerVtbl_
	QueryInterface as function(byval This as IDirectMusicComposer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicComposer ptr) as ULONG
	Release as function(byval This as IDirectMusicComposer ptr) as ULONG
	ComposeSegmentFromTemplate as function(byval This as IDirectMusicComposer ptr, byval pStyle as IDirectMusicStyle ptr, byval pTemplate as IDirectMusicSegment ptr, byval wActivity as WORD, byval pChordMap as IDirectMusicChordMap ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	ComposeSegmentFromShape as function(byval This as IDirectMusicComposer ptr, byval pStyle as IDirectMusicStyle ptr, byval wNumMeasures as WORD, byval wShape as WORD, byval wActivity as WORD, byval fIntro as WINBOOL, byval fEnd as WINBOOL, byval pChordMap as IDirectMusicChordMap ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	ComposeTransition as function(byval This as IDirectMusicComposer ptr, byval pFromSeg as IDirectMusicSegment ptr, byval pToSeg as IDirectMusicSegment ptr, byval mtTime as MUSIC_TIME, byval wCommand as WORD, byval dwFlags as DWORD, byval pChordMap as IDirectMusicChordMap ptr, byval ppTransSeg as IDirectMusicSegment ptr ptr) as HRESULT
	AutoTransition as function(byval This as IDirectMusicComposer ptr, byval pPerformance as IDirectMusicPerformance ptr, byval pToSeg as IDirectMusicSegment ptr, byval wCommand as WORD, byval dwFlags as DWORD, byval pChordMap as IDirectMusicChordMap ptr, byval ppTransSeg as IDirectMusicSegment ptr ptr, byval ppToSegState as IDirectMusicSegmentState ptr ptr, byval ppTransSegState as IDirectMusicSegmentState ptr ptr) as HRESULT
	ComposeTemplateFromShape as function(byval This as IDirectMusicComposer ptr, byval wNumMeasures as WORD, byval wShape as WORD, byval fIntro as WINBOOL, byval fEnd as WINBOOL, byval wEndLength as WORD, byval ppTemplate as IDirectMusicSegment ptr ptr) as HRESULT
	ChangeChordMap as function(byval This as IDirectMusicComposer ptr, byval pSegment as IDirectMusicSegment ptr, byval fTrackScale as WINBOOL, byval pChordMap as IDirectMusicChordMap ptr) as HRESULT
end type

#define IDirectMusicComposer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicComposer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicComposer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicComposer_ComposeSegmentFromTemplate(p, a, b, c, d, e) (p)->lpVtbl->ComposeSegmentFromTemplate(p, a, b, c, d, e)
#define IDirectMusicComposer_ComposeSegmentFromShape(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->ComposeSegmentFromShape(p, a, b, c, d, e, f, g, h)
#define IDirectMusicComposer_ComposeTransition(p, a, b, c, d, e, f, g) (p)->lpVtbl->ComposeTransition(p, a, b, c, d, e, f, g)
#define IDirectMusicComposer_AutoTransition(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->AutoTransition(p, a, b, c, d, e, f, g, h)
#define IDirectMusicComposer_ComposeTemplateFromShape(p, a, b, c, d, e, f) (p)->lpVtbl->ComposeTemplateFromShape(p, a, b, c, d, e, f)
#define IDirectMusicComposer_ChangeChordMap(p, a, b, c) (p)->lpVtbl->ChangeChordMap(p, a, b, c)
type IDirectMusicPatternTrackVtbl as IDirectMusicPatternTrackVtbl_

type IDirectMusicPatternTrack
	lpVtbl as IDirectMusicPatternTrackVtbl ptr
end type

type IDirectMusicPatternTrackVtbl_
	QueryInterface as function(byval This as IDirectMusicPatternTrack ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicPatternTrack ptr) as ULONG
	Release as function(byval This as IDirectMusicPatternTrack ptr) as ULONG
	CreateSegment as function(byval This as IDirectMusicPatternTrack ptr, byval pStyle as IDirectMusicStyle ptr, byval ppSegment as IDirectMusicSegment ptr ptr) as HRESULT
	SetVariation as function(byval This as IDirectMusicPatternTrack ptr, byval pSegState as IDirectMusicSegmentState ptr, byval dwVariationFlags as DWORD, byval dwPart as DWORD) as HRESULT
	SetPatternByName as function(byval This as IDirectMusicPatternTrack ptr, byval pSegState as IDirectMusicSegmentState ptr, byval wszName as wstring ptr, byval pStyle as IDirectMusicStyle ptr, byval dwPatternType as DWORD, byval pdwLength as DWORD ptr) as HRESULT
end type

#define IDirectMusicPatternTrack_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicPatternTrack_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicPatternTrack_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicPatternTrack_CreateSegment(p, a, b) (p)->lpVtbl->CreateSegment(p, a, b)
#define IDirectMusicPatternTrack_SetVariation(p, a, b, c) (p)->lpVtbl->SetVariation(p, a, b, c)
#define IDirectMusicPatternTrack_SetPatternByName(p, a, b, c, d, e) (p)->lpVtbl->SetPatternByName(p, a, b, c, d, e)
type IDirectMusicScriptVtbl as IDirectMusicScriptVtbl_

type IDirectMusicScript
	lpVtbl as IDirectMusicScriptVtbl ptr
end type

type IDirectMusicScriptVtbl_
	QueryInterface as function(byval This as IDirectMusicScript ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicScript ptr) as ULONG
	Release as function(byval This as IDirectMusicScript ptr) as ULONG
	Init as function(byval This as IDirectMusicScript ptr, byval pPerformance as IDirectMusicPerformance ptr, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	CallRoutine as function(byval This as IDirectMusicScript ptr, byval pwszRoutineName as wstring ptr, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	SetVariableVariant as function(byval This as IDirectMusicScript ptr, byval pwszVariableName as wstring ptr, byval varValue as VARIANT, byval fSetRef as WINBOOL, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	GetVariableVariant as function(byval This as IDirectMusicScript ptr, byval pwszVariableName as wstring ptr, byval pvarValue as VARIANT ptr, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	SetVariableNumber as function(byval This as IDirectMusicScript ptr, byval pwszVariableName as wstring ptr, byval lValue as LONG, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	GetVariableNumber as function(byval This as IDirectMusicScript ptr, byval pwszVariableName as wstring ptr, byval plValue as LONG ptr, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	SetVariableObject as function(byval This as IDirectMusicScript ptr, byval pwszVariableName as wstring ptr, byval punkValue as IUnknown ptr, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	GetVariableObject as function(byval This as IDirectMusicScript ptr, byval pwszVariableName as wstring ptr, byval riid as const IID const ptr, byval ppv as LPVOID ptr, byval pErrorInfo as DMUS_SCRIPT_ERRORINFO ptr) as HRESULT
	EnumRoutine as function(byval This as IDirectMusicScript ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
	EnumVariable as function(byval This as IDirectMusicScript ptr, byval dwIndex as DWORD, byval pwszName as wstring ptr) as HRESULT
end type

#define IDirectMusicScript_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicScript_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicScript_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicPatternTrack_Init(p, a, b) (p)->lpVtbl->Init(p, a, b)
#define IDirectMusicPatternTrack_CallRoutine(p, a, b) (p)->lpVtbl->CallRoutine(p, a, b)
#define IDirectMusicPatternTrack_SetVariableVariant(p, a, b, c, d) (p)->lpVtbl->SetVariableVariant(p, a, b, c, d)
#define IDirectMusicPatternTrack_GetVariableVariant(p, a, b, c) (p)->lpVtbl->GetVariableVariant(p, a, b, c)
#define IDirectMusicPatternTrack_SetVariableNumber(p, a, b, c) (p)->lpVtbl->SetVariableNumber(p, a, b, c)
#define IDirectMusicPatternTrack_GetVariableNumber(p, a, b, c) (p)->lpVtbl->GetVariableNumber(p, a, b, c)
#define IDirectMusicPatternTrack_SetVariableObject(p, a, b, c) (p)->lpVtbl->SetVariableObject(p, a, b, c)
#define IDirectMusicPatternTrack_GetVariableObject(p, a, b, c, d) (p)->lpVtbl->GetVariableObject(p, a, b, c, d)
#define IDirectMusicPatternTrack_EnumRoutine(p, a, b) (p)->lpVtbl->EnumRoutine(p, a, b)
#define IDirectMusicPatternTrack_EnumVariable(p, a, b) (p)->lpVtbl->EnumVariable(p, a, b)
type IDirectMusicContainerVtbl as IDirectMusicContainerVtbl_

type IDirectMusicContainer
	lpVtbl as IDirectMusicContainerVtbl ptr
end type

type IDirectMusicContainerVtbl_
	QueryInterface as function(byval This as IDirectMusicContainer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicContainer ptr) as ULONG
	Release as function(byval This as IDirectMusicContainer ptr) as ULONG
	EnumObject as function(byval This as IDirectMusicContainer ptr, byval rguidClass as const GUID const ptr, byval dwIndex as DWORD, byval pDesc as LPDMUS_OBJECTDESC, byval pwszAlias as wstring ptr) as HRESULT
end type

#define IDirectMusicContainer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicContainer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicContainer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicContainer_EnumObject(p, a, b, c, d) (p)->lpVtbl->EnumObject(p, a, b, c, d)

end extern
