''
''
'' dls1 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dls1_bi__
#define __win_dls1_bi__

#define FOURCC_DLS   mmioFOURCCasc("D"),asc("L"),asc("S"),asc(" "))
#define FOURCC_DLID  mmioFOURCCasc("d"),asc("l"),asc("i"),asc("d"))
#define FOURCC_COLH  mmioFOURCCasc("c"),asc("o"),asc("l"),asc("h"))
#define FOURCC_WVPL  mmioFOURCCasc("w"),asc("v"),asc("p"),asc("l"))
#define FOURCC_PTBL  mmioFOURCCasc("p"),asc("t"),asc("b"),asc("l"))
#define FOURCC_PATH  mmioFOURCCasc("p"),asc("a"),asc("t"),asc("h"))
#define FOURCC_wave  mmioFOURCCasc("w"),asc("a"),asc("v"),asc("e"))
#define FOURCC_LINS  mmioFOURCCasc("l"),asc("i"),asc("n"),asc("s"))
#define FOURCC_INS   mmioFOURCCasc("i"),asc("n"),asc("s"),asc(" "))
#define FOURCC_INSH  mmioFOURCCasc("i"),asc("n"),asc("s"),asc("h"))
#define FOURCC_LRGN  mmioFOURCCasc("l"),asc("r"),asc("g"),asc("n"))
#define FOURCC_RGN   mmioFOURCCasc("r"),asc("g"),asc("n"),asc(" "))
#define FOURCC_RGNH  mmioFOURCCasc("r"),asc("g"),asc("n"),asc("h"))
#define FOURCC_LART  mmioFOURCCasc("l"),asc("a"),asc("r"),asc("t"))
#define FOURCC_ART1  mmioFOURCCasc("a"),asc("r"),asc("t"),asc("1"))
#define FOURCC_WLNK  mmioFOURCCasc("w"),asc("l"),asc("n"),asc("k"))
#define FOURCC_WSMP  mmioFOURCCasc("w"),asc("s"),asc("m"),asc("p"))
#define FOURCC_VERS  mmioFOURCCasc("v"),asc("e"),asc("r"),asc("s"))

#define CONN_SRC_NONE &h0000
#define CONN_SRC_LFO &h0001
#define CONN_SRC_KEYONVELOCITY &h0002
#define CONN_SRC_KEYNUMBER &h0003
#define CONN_SRC_EG1 &h0004
#define CONN_SRC_EG2 &h0005
#define CONN_SRC_PITCHWHEEL &h0006
#define CONN_SRC_CC1 &h0081
#define CONN_SRC_CC7 &h0087
#define CONN_SRC_CC10 &h008a
#define CONN_SRC_CC11 &h008b
#define CONN_DST_NONE &h0000
#define CONN_DST_ATTENUATION &h0001
#define CONN_DST_PITCH &h0003
#define CONN_DST_PAN &h0004
#define CONN_DST_LFO_FREQUENCY &h0104
#define CONN_DST_LFO_STARTDELAY &h0105
#define CONN_DST_EG1_ATTACKTIME &h0206
#define CONN_DST_EG1_DECAYTIME &h0207
#define CONN_DST_EG1_RELEASETIME &h0209
#define CONN_DST_EG1_SUSTAINLEVEL &h020a
#define CONN_DST_EG2_ATTACKTIME &h030a
#define CONN_DST_EG2_DECAYTIME &h03&b
#define CONN_DST_EG2_RELEASETIME &h030d
#define CONN_DST_EG2_SUSTAINLEVEL &h030e
#define CONN_TRN_NONE &h0000
#define CONN_TRN_CONCAVE &h0001

type DLSID
	ulData1 as ULONG
	usData2 as USHORT
	usData3 as USHORT
	abData4(0 to 8-1) as UBYTE
end type

type LPDLSID as DLSID ptr

type DLSVERSION
	dwVersionMS as DWORD
	dwVersionLS as DWORD
end type

type LPDLSVERSION as DLSVERSION ptr

type CONNECTION
	usSource as USHORT
	usControl as USHORT
	usDestination as USHORT
	usTransform as USHORT
	lScale as LONG
end type

type LPCONNECTION as CONNECTION ptr

type CONNECTIONLIST
	cbSize as ULONG
	cConnections as ULONG
end type

type LPCONNECTIONLIST as CONNECTIONLIST ptr

type RGNRANGE
	usLow as USHORT
	usHigh as USHORT
end type

type LPRGNRANGE as RGNRANGE ptr

#define F_INSTRUMENT_DRUMS &h80000000

type MIDILOCALE
	ulBank as ULONG
	ulInstrument as ULONG
end type

type LPMIDILOCALE as MIDILOCALE ptr

#define F_RGN_OPTION_SELFNONEXCLUSIVE &h0001

type RGNHEADER
	RangeKey as RGNRANGE
	RangeVelocity as RGNRANGE
	fusOptions as USHORT
	usKeyGroup as USHORT
end type

type LPRGNHEADER as RGNHEADER ptr

type INSTHEADER
	cRegions as ULONG
	Locale as MIDILOCALE
end type

type LPINSTHEADER as INSTHEADER ptr

type DLSHEADER
	cInstruments as ULONG
end type

type LPDLSHEADER as DLSHEADER ptr

#define WAVELINK_CHANNEL_LEFT &h0001l
#define WAVELINK_CHANNEL_RIGHT &h0002l
#define F_WAVELINK_PHASE_MASTER &h0001

type WAVELINK
	fusOptions as USHORT
	usPhaseGroup as USHORT
	ulChannel as ULONG
	ulTableIndex as ULONG
end type

type LPWAVELINK as WAVELINK ptr

#define POOL_CUE_NULL &hffffffffl

type POOLCUE
	ulOffset as ULONG
end type

type LPPOOLCUE as POOLCUE ptr

type POOLTABLE
	cbSize as ULONG
	cCues as ULONG
end type

type LPPOOLTABLE as POOLTABLE ptr

#define F_WSMP_NO_TRUNCATION &h0001l
#define F_WSMP_NO_COMPRESSION &h0002l

type WSMPL
	cbSize as ULONG
	usUnityNote as USHORT
	sFineTune as SHORT
	lAttenuation as LONG
	fulOptions as ULONG
	cSampleLoops as ULONG
end type

type LPWSMPL as WSMPL ptr

#define WLOOP_TYPE_FORWARD 0

type WLOOP
	cbSize as ULONG
	ulType as ULONG
	ulStart as ULONG
	ulLength as ULONG
end type

type LPWLOOP as WLOOP ptr

#endif
