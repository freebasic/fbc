'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DirectMusic DLS Download Definitions
''
''    Copyright (C) 2003-2004 Rok Mandeljc
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

#include once "dls1.bi"

#define __WINE_DMUSIC_DLS_H
type GCENT as LONG
type PCENT as LONG
type PERCENT as LONG
type TCENT as LONG
type REFERENCE_TIME as LONGLONG
type LPREFERENCE_TIME as LONGLONG ptr

const DMUS_DEFAULT_SIZE_OFFSETTABLE = &h1
const DMUS_DOWNLOADINFO_INSTRUMENT = &h1
const DMUS_DOWNLOADINFO_WAVE = &h2
const DMUS_DOWNLOADINFO_INSTRUMENT2 = &h3
const DMUS_DOWNLOADINFO_WAVEARTICULATION = &h4
const DMUS_DOWNLOADINFO_STREAMINGWAVE = &h5
const DMUS_DOWNLOADINFO_ONESHOTWAVE = &h6
const DMUS_INSTRUMENT_GM_INSTRUMENT = &h1
const DMUS_MIN_DATA_SIZE = &h4

type DMUS_DOWNLOADINFO as _DMUS_DOWNLOADINFO
type LPDMUS_DOWNLOADINFO as _DMUS_DOWNLOADINFO ptr
type DMUS_OFFSETTABLE as _DMUS_OFFSETTABLE
type LPDMUS_OFFSETTABLE as _DMUS_OFFSETTABLE ptr
type DMUS_INSTRUMENT as _DMUS_INSTRUMENT
type LPDMUS_INSTRUMENT as _DMUS_INSTRUMENT ptr
type DMUS_REGION as _DMUS_REGION
type LPDMUS_REGION as _DMUS_REGION ptr
type DMUS_LFOPARAMS as _DMUS_LFOPARAMS
type LPDMUS_LFOPARAMS as _DMUS_LFOPARAMS ptr
type DMUS_VEGPARAMS as _DMUS_VEGPARAMS
type LPDMUS_VEGPARAMS as _DMUS_VEGPARAMS ptr
type DMUS_PEGPARAMS as _DMUS_PEGPARAMS
type LPDMUS_PEGPARAMS as _DMUS_PEGPARAMS ptr
type DMUS_MSCPARAMS as _DMUS_MSCPARAMS
type LPDMUS_MSCPARAMS as _DMUS_MSCPARAMS ptr
type DMUS_ARTICPARAMS as _DMUS_ARTICPARAMS
type LPDMUS_ARTICPARAMS as _DMUS_ARTICPARAMS ptr
type DMUS_ARTICULATION as _DMUS_ARTICULATION
type LPDMUS_ARTICULATION as _DMUS_ARTICULATION ptr
type DMUS_ARTICULATION2 as _DMUS_ARTICULATION2
type LPDMUS_ARTICULATION2 as _DMUS_ARTICULATION2 ptr
type DMUS_EXTENSIONCHUNK as _DMUS_EXTENSIONCHUNK
type LPDMUS_EXTENSIONCHUNK as _DMUS_EXTENSIONCHUNK ptr
type DMUS_COPYRIGHT as _DMUS_COPYRIGHT
type LPDMUS_COPYRIGHT as _DMUS_COPYRIGHT ptr
type DMUS_WAVEDATA as _DMUS_WAVEDATA
type LPDMUS_WAVEDATA as _DMUS_WAVEDATA ptr
type DMUS_WAVE as _DMUS_WAVE
type LPDMUS_WAVE as _DMUS_WAVE ptr
type DMUS_NOTERANGE as _DMUS_NOTERANGE
type LPDMUS_NOTERANGE as _DMUS_NOTERANGE ptr
type DMUS_WAVEARTDL as _DMUS_WAVEARTDL
type LPDMUS_WAVEARTDL as _DMUS_WAVEARTDL ptr
type DMUS_WAVEDL as _DMUS_WAVEDL
type LPDMUS_WAVEDL as _DMUS_WAVEDL ptr

type _DMUS_DOWNLOADINFO
	dwDLType as DWORD
	dwDLId as DWORD
	dwNumOffsetTableEntries as DWORD
	cbSize as DWORD
end type

type _DMUS_OFFSETTABLE
	ulOffsetTable(0 to 0) as ULONG
end type

type _DMUS_INSTRUMENT
	ulPatch as ULONG
	ulFirstRegionIdx as ULONG
	ulGlobalArtIdx as ULONG
	ulFirstExtCkIdx as ULONG
	ulCopyrightIdx as ULONG
	ulFlags as ULONG
end type

type _DMUS_REGION
	RangeKey as RGNRANGE
	RangeVelocity as RGNRANGE
	fusOptions as USHORT
	usKeyGroup as USHORT
	ulRegionArtIdx as ULONG
	ulNextRegionIdx as ULONG
	ulFirstExtCkIdx as ULONG
	WaveLink as WAVELINK
	WSMP as WSMPL
	WLOOP(0 to 0) as _rloop
end type

type _DMUS_LFOPARAMS
	pcFrequency as PCENT
	tcDelay as TCENT
	gcVolumeScale as GCENT
	pcPitchScale as PCENT
	gcMWToVolume as GCENT
	pcMWToPitch as PCENT
end type

type _DMUS_VEGPARAMS
	tcAttack as TCENT
	tcDecay as TCENT
	ptSustain as PERCENT
	tcRelease as TCENT
	tcVel2Attack as TCENT
	tcKey2Decay as TCENT
end type

type _DMUS_PEGPARAMS
	tcAttack as TCENT
	tcDecay as TCENT
	ptSustain as PERCENT
	tcRelease as TCENT
	tcVel2Attack as TCENT
	tcKey2Decay as TCENT
	pcRange as PCENT
end type

type _DMUS_MSCPARAMS
	ptDefaultPan as PERCENT
end type

type _DMUS_ARTICPARAMS
	LFO as DMUS_LFOPARAMS
	VolEG as DMUS_VEGPARAMS
	PitchEG as DMUS_PEGPARAMS
	Misc as DMUS_MSCPARAMS
end type

type _DMUS_ARTICULATION
	ulArt1Idx as ULONG
	ulFirstExtCkIdx as ULONG
end type

type _DMUS_ARTICULATION2
	ulArtIdx as ULONG
	ulFirstExtCkIdx as ULONG
	ulNextArtIdx as ULONG
end type

type _DMUS_EXTENSIONCHUNK
	cbSize as ULONG
	ulNextExtCkIdx as ULONG
	ExtCkID as FOURCC
	byExtCk(0 to 3) as UBYTE
end type

type _DMUS_COPYRIGHT
	cbSize as ULONG
	byCopyright(0 to 3) as UBYTE
end type

type _DMUS_WAVEDATA
	cbSize as ULONG
	byData(0 to 3) as UBYTE
end type

type _DMUS_WAVE
	ulFirstExtCkIdx as ULONG
	ulCopyrightIdx as ULONG
	ulWaveDataIdx as ULONG
	WaveformatEx as WAVEFORMATEX
end type

type _DMUS_NOTERANGE
	dwLowNote as DWORD
	dwHighNote as DWORD
end type

type _DMUS_WAVEARTDL
	ulDownloadIdIdx as ULONG
	ulBus as ULONG
	ulBuffers as ULONG
	ulMasterDLId as ULONG
	usOptions as USHORT
end type

type _DMUS_WAVEDL
	cbWaveData as ULONG
end type
