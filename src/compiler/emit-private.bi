const COMMA   = ", "

type EMITDATATYPE
	rnametb         as integer
	mname           as zstring * 11+1
end type

extern dtypeTB(0 to FB_DATATYPES-1) as EMITDATATYPE

const EMIT_MEMBLOCK_MAXLEN  = 16          '' when to use memblk clear/move (needed by AST)

const EMIT_MAXRNAMES  = REG_MAXREGS
const EMIT_MAXRTABLES   = 4               '' 8-bit, 16-bit, 32-bit, fpoint

const EMIT_LOCSTART     = 0
const EMIT_ARGSTART     = 4 + 4 '' skip return address + saved ebp

enum EMITREG_ENUM
	EMIT_REG_FP0    = 0
	EMIT_REG_FP1
	EMIT_REG_FP2
	EMIT_REG_FP3
	EMIT_REG_FP4
	EMIT_REG_FP5
	EMIT_REG_FP6
	EMIT_REG_FP7

	EMIT_REG_EDX    = EMIT_REG_FP0              '' aliased
	EMIT_REG_EDI
	EMIT_REG_ESI
	EMIT_REG_ECX
	EMIT_REG_EBX
	EMIT_REG_EAX
	EMIT_REG_EBP
	EMIT_REG_ESP
end enum

declare sub hPrepOperand _
	( _
		byval vreg as IRVREG ptr, _
		byref operand as string, _
		byval dtype as FB_DATATYPE = FB_DATATYPE_INVALID, _
		byval ofs as integer = 0, _
		byval isaux as integer = FALSE, _
		byval addprefix as integer = TRUE _
	)

declare sub hPrepOperand64 _
	( _
		byval vreg as IRVREG ptr, _
		byref operand1 as string, _
		byref operand2 as string _
	)


declare sub hPUSH _
	( _
		byval rname as zstring ptr _
	)

declare sub hPOP _
	( _
		byval rname as zstring ptr _
	)


declare function hFindRegNotInVreg _
	( _
		byval vreg as IRVREG ptr, _
		byval noSIDI as integer = FALSE _
	) as integer

declare function hFindFreeReg( byval dclass as integer ) as integer

declare function hIsRegFree _
	( _
		byval dclass as integer, _
		byval reg as integer _
	) as integer

declare function hIsRegInVreg _
	( _
		byval vreg as IRVREG ptr, _
		byval reg as integer _
	) as integer

declare function hGetRegName _
	( _
		byval dtype as integer, _
		byval reg as integer _
	) as zstring ptr

declare sub outp _
	( _
		byval s as zstring ptr _
	)

declare sub hLABEL _
	( _
		byval label as zstring ptr _
	)

declare sub hBRANCH _
	( _
		byval mnemonic as zstring ptr, _
		byval label as zstring ptr _
	)

declare sub hMOV _
	( _
		byval dname as zstring ptr, _
		byval sname as zstring ptr _
	)

declare function _init_opFnTB_SSE _
	( _
		byval _opFnTB_SSE as any ptr ptr _
	) as integer
