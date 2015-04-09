'' FreeBASIC binding for videoproto-2.3.2

#pragma once

'' The following symbols have been renamed:
''     struct xvmcSurfaceInfo => xvmcSurfaceInfo_

#define _XVMCPROTO_H_
const xvmc_QueryVersion = 0
const xvmc_ListSurfaceTypes = 1
const xvmc_CreateContext = 2
const xvmc_DestroyContext = 3
const xvmc_CreateSurface = 4
const xvmc_DestroySurface = 5
const xvmc_CreateSubpicture = 6
const xvmc_DestroySubpicture = 7
const xvmc_ListSubpictureTypes = 8
const xvmc_GetDRInfo = 9
#define xvmc_LastRequest xvmc_GetDRInfo
#define xvmcNumRequest (xvmc_LastRequest + 1)

type xvmcSurfaceInfo_
	surface_type_id as CARD32
	chroma_format as CARD16
	pad0 as CARD16
	max_width as CARD16
	max_height as CARD16
	subpicture_max_width as CARD16
	subpicture_max_height as CARD16
	mc_type as CARD32
	flags as CARD32
end type

const sz_xvmcSurfaceInfo = 24

type xvmcQueryVersionReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
end type

const sz_xvmcQueryVersionReq = 4

type xvmcQueryVersionReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	major as CARD32
	minor as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
end type

const sz_xvmcQueryVersionReply = 32

type xvmcListSurfaceTypesReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	port as CARD32
end type

const sz_xvmcListSurfaceTypesReq = 8

type xvmcListSurfaceTypesReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	num as CARD32
	padl3 as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
end type

const sz_xvmcListSurfaceTypesReply = 32

type xvmcCreateContextReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	context_id as CARD32
	port as CARD32
	surface_type_id as CARD32
	width as CARD16
	height as CARD16
	flags as CARD32
end type

const sz_xvmcCreateContextReq = 24

type xvmcCreateContextReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	width_actual as CARD16
	height_actual as CARD16
	flags_return as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
end type

const sz_xvmcCreateContextReply = 32

type xvmcDestroyContextReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	context_id as CARD32
end type

const sz_xvmcDestroyContextReq = 8

type xvmcCreateSurfaceReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	surface_id as CARD32
	context_id as CARD32
end type

const sz_xvmcCreateSurfaceReq = 12

type xvmcCreateSurfaceReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	padl2 as CARD32
	padl3 as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
end type

const sz_xvmcCreateSurfaceReply = 32

type xvmcDestroySurfaceReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	surface_id as CARD32
end type

const sz_xvmcDestroySurfaceReq = 8

type xvmcCreateSubpictureReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	subpicture_id as CARD32
	context_id as CARD32
	xvimage_id as CARD32
	width as CARD16
	height as CARD16
end type

const sz_xvmcCreateSubpictureReq = 20

type xvmcCreateSubpictureReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	width_actual as CARD16
	height_actual as CARD16
	num_palette_entries as CARD16
	entry_bytes as CARD16
	component_order(0 to 3) as CARD8
	padl5 as CARD32
	padl6 as CARD32
	padl7 as CARD32
end type

const sz_xvmcCreateSubpictureReply = 32

type xvmcDestroySubpictureReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	subpicture_id as CARD32
end type

const sz_xvmcDestroySubpictureReq = 8

type xvmcListSubpictureTypesReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	port as CARD32
	surface_type_id as CARD32
end type

const sz_xvmcListSubpictureTypesReq = 12

type xvmcListSubpictureTypesReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	num as CARD32
	padl2 as CARD32
	padl3 as CARD32
	padl4 as CARD32
	padl5 as CARD32
	padl6 as CARD32
end type

const sz_xvmcListSubpictureTypesReply = 32

type xvmcGetDRInfoReq
	reqType as CARD8
	xvmcReqType as CARD8
	length as CARD16
	port as CARD32
	shmKey as CARD32
	magic as CARD32
end type

const sz_xvmcGetDRInfoReq = 16

type xvmcGetDRInfoReply
	as UBYTE type
	padb1 as UBYTE
	sequenceNumber as CARD16
	length as CARD32
	major as CARD32
	minor as CARD32
	patchLevel as CARD32
	nameLen as CARD32
	busIDLen as CARD32
	isLocal as CARD32
end type

const sz_xvmcGetDRInfoReply = 32
