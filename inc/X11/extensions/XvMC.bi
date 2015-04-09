'' FreeBASIC binding for videoproto-2.3.2

#pragma once

#include once "X11/X.bi"
#include once "X11/extensions/Xv.bi"

#define _XVMC_H_
#define XvMCName "XVideo-MotionCompensation"
const XvMCNumEvents = 0
const XvMCNumErrors = 3
const XvMCVersion = 1
const XvMCRevision = 1
const XvMCBadContext = 0
const XvMCBadSurface = 1
const XvMCBadSubpicture = 2
const XVMC_CHROMA_FORMAT_420 = &h00000001
const XVMC_CHROMA_FORMAT_422 = &h00000002
const XVMC_CHROMA_FORMAT_444 = &h00000003
const XVMC_OVERLAID_SURFACE = &h00000001
const XVMC_BACKEND_SUBPICTURE = &h00000002
const XVMC_SUBPICTURE_INDEPENDENT_SCALING = &h00000004
const XVMC_INTRA_UNSIGNED = &h00000008
const XVMC_MOCOMP = &h00000000
const XVMC_IDCT = &h00010000
const XVMC_MPEG_1 = &h00000001
const XVMC_MPEG_2 = &h00000002
const XVMC_H263 = &h00000003
const XVMC_MPEG_4 = &h00000004
const XVMC_MB_TYPE_MOTION_FORWARD = &h02
const XVMC_MB_TYPE_MOTION_BACKWARD = &h04
const XVMC_MB_TYPE_PATTERN = &h08
const XVMC_MB_TYPE_INTRA = &h10
const XVMC_PREDICTION_FIELD = &h01
const XVMC_PREDICTION_FRAME = &h02
const XVMC_PREDICTION_DUAL_PRIME = &h03
const XVMC_PREDICTION_16x8 = &h02
const XVMC_PREDICTION_4MV = &h04
const XVMC_SELECT_FIRST_FORWARD = &h01
const XVMC_SELECT_FIRST_BACKWARD = &h02
const XVMC_SELECT_SECOND_FORWARD = &h04
const XVMC_SELECT_SECOND_BACKWARD = &h08
const XVMC_DCT_TYPE_FRAME = &h00
const XVMC_DCT_TYPE_FIELD = &h01
const XVMC_TOP_FIELD = &h00000001
const XVMC_BOTTOM_FIELD = &h00000002
#define XVMC_FRAME_PICTURE (XVMC_TOP_FIELD or XVMC_BOTTOM_FIELD)
const XVMC_SECOND_FIELD = &h00000004
const XVMC_DIRECT = &h00000001
const XVMC_RENDERING = &h00000001
const XVMC_DISPLAYING = &h00000002

type XvMCSurfaceInfo
	surface_type_id as long
	chroma_format as long
	max_width as ushort
	max_height as ushort
	subpicture_max_width as ushort
	subpicture_max_height as ushort
	mc_type as long
	flags as long
end type

type XvMCContext
	context_id as XID
	surface_type_id as long
	width as ushort
	height as ushort
	port as XvPortID
	flags as long
	privData as any ptr
end type

type XvMCSurface
	surface_id as XID
	context_id as XID
	surface_type_id as long
	width as ushort
	height as ushort
	privData as any ptr
end type

type XvMCSubpicture
	subpicture_id as XID
	context_id as XID
	xvimage_id as long
	width as ushort
	height as ushort
	num_palette_entries as long
	entry_bytes as long
	component_order as zstring * 4
	privData as any ptr
end type

type XvMCBlockArray
	num_blocks as ulong
	context_id as XID
	privData as any ptr
	blocks as short ptr
end type

type XvMCMacroBlock
	x as ushort
	y as ushort
	macroblock_type as ubyte
	motion_type as ubyte
	motion_vertical_field_select as ubyte
	dct_type as ubyte
	PMV(0 to 1, 0 to 1, 0 to 1) as short
	index as ulong
	coded_block_pattern as ushort
	pad0 as ushort
end type

type XvMCMacroBlockArray
	num_blocks as ulong
	context_id as XID
	privData as any ptr
	macro_blocks as XvMCMacroBlock ptr
end type
