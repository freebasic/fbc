''
''
'' dmdls -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmdls_bi__
#define __win_dmdls_bi__

#include once "win/dls1.bi"

type PCENT as integer
type GCENT as integer
type TCENT as integer
type PERCENT as integer
type REFERENCE_TIME as LONGLONG
type LPREFERENCE_TIME as REFERENCE_TIME ptr

#ifndef MAKEFOURCC
#define MAKEFOURCC(c0,c1,c2,c3) (cuint(c0) or (cuint(c1) shl 8) or (cuint(c2) shl 16) or (cuint(c3) shl 24))
type FOURCC as DWORD
#endif

type DMUS_DOWNLOADINFO
	dwDLType as DWORD
	dwDLId as DWORD
	dwNumOffsetTableEntries as DWORD
	cbSize as DWORD
end type

#define DMUS_DOWNLOADINFO_INSTRUMENT 1
#define DMUS_DOWNLOADINFO_WAVE 2
#define DMUS_DOWNLOADINFO_INSTRUMENT2 3
#define DMUS_DOWNLOADINFO_WAVEARTICULATION 4
#define DMUS_DOWNLOADINFO_STREAMINGWAVE 5
#define DMUS_DOWNLOADINFO_ONESHOTWAVE 6
#define DMUS_DEFAULT_SIZE_OFFSETTABLE 1
#define DMUS_INSTRUMENT_GM_INSTRUMENT (1 shl 0)

type DMUS_OFFSETTABLE
	ulOffsetTable(0 to 1-1) as ULONG
end type

type DMUS_INSTRUMENT
	ulPatch as ULONG
	ulFirstRegionIdx as ULONG
	ulGlobalArtIdx as ULONG
	ulFirstExtCkIdx as ULONG
	ulCopyrightIdx as ULONG
	ulFlags as ULONG
end type

type DMUS_REGION
	RangeKey as RGNRANGE
	RangeVelocity as RGNRANGE
	fusOptions as USHORT
	usKeyGroup as USHORT
	ulRegionArtIdx as ULONG
	ulNextRegionIdx as ULONG
	ulFirstExtCkIdx as ULONG
	WaveLink as WAVELINK
	WSMP as WSMPL
	WLOOP(0 to 1-1) as WLOOP
end type

type DMUS_LFOPARAMS
	pcFrequency as PCENT
	tcDelay as TCENT
	gcVolumeScale as GCENT
	pcPitchScale as PCENT
	gcMWToVolume as GCENT
	pcMWToPitch as PCENT
end type

type DMUS_VEGPARAMS
	tcAttack as TCENT
	tcDecay as TCENT
	ptSustain as PERCENT
	tcRelease as TCENT
	tcVel2Attack as TCENT
	tcKey2Decay as TCENT
end type

type DMUS_PEGPARAMS
	tcAttack as TCENT
	tcDecay as TCENT
	ptSustain as PERCENT
	tcRelease as TCENT
	tcVel2Attack as TCENT
	tcKey2Decay as TCENT
	pcRange as PCENT
end type

type DMUS_MSCPARAMS
	ptDefaultPan as PERCENT
end type

type DMUS_ARTICPARAMS
	LFO as DMUS_LFOPARAMS
	VolEG as DMUS_VEGPARAMS
	PitchEG as DMUS_PEGPARAMS
	Misc as DMUS_MSCPARAMS
end type

type DMUS_ARTICULATION
	ulArt1Idx as ULONG
	ulFirstExtCkIdx as ULONG
end type

type DMUS_ARTICULATION2
	ulArtIdx as ULONG
	ulFirstExtCkIdx as ULONG
	ulNextArtIdx as ULONG
end type

#define DMUS_MIN_DATA_SIZE 4

type DMUS_EXTENSIONCHUNK
	cbSize as ULONG
	ulNextExtCkIdx as ULONG
	ExtCkID as FOURCC
	byExtCk(0 to 4-1) as UBYTE
end type

type DMUS_COPYRIGHT
	cbSize as ULONG
	byCopyright(0 to 4-1) as UBYTE
end type

type DMUS_WAVEDATA
	cbSize as ULONG
	byData(0 to 4-1) as UBYTE
end type

type DMUS_WAVE
	ulFirstExtCkIdx as ULONG
	ulCopyrightIdx as ULONG
	ulWaveDataIdx as ULONG
	WaveformatEx as WAVEFORMATEX
end type

type LPDMUS_NOTERANGE as DMUS_NOTERANGE ptr

type DMUS_NOTERANGE
	dwLowNote as DWORD
	dwHighNote as DWORD
end type

type DMUS_WAVEARTDL
	ulDownloadIdIdx as ULONG
	ulBus as ULONG
	ulBuffers as ULONG
	ulMasterDLId as ULONG
	usOptions as USHORT
end type

type LPDMUS_WAVEARTDL as DMUS_WAVEARTDL ptr

type DMUS_WAVEDL
	cbWaveData as ULONG
end type

type LPDMUS_WAVEDL as DMUS_WAVEDL ptr

#endif
