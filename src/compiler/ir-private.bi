'' Code shared by C/LLVM backends (the two "high-level" IR backends)
''
'' IRCALLARG stuff is needed to collect the args emitted per call:
''  1. C/LLVM backends need to emit calls in one go (in one line, as a single
''     statement), not like the ASM backend, where PUSHs are separate from
''     CALLs...
''  2. astLoadCALL() is recursive - ARGs can contain calls themselves, in which
''     case they (and their ARGs) are emitted recursively, before continuing to
''     the next ARG.

type IRCALLARG
	param as FBSYMBOL ptr
	vr    as IRVREG ptr
	level as integer
end type

type IRHLCONTEXT
	regcount as integer '' vreg id counter
	vregs    as TFLIST  '' IRVREG allocation
	callargs as TLIST   '' IRCALLARG's during irEmitPushArg/irEmitCall[Ptr]
end type

extern irhl as IRHLCONTEXT

declare sub irhlInit( )
declare sub irhlEnd( )
declare sub irhlEmitProcBegin( )
declare sub irhlEmitProcEnd( )

declare sub irhlEmitPushArg _
	( _
		byval param as FBSYMBOL ptr, _
		byval vr as IRVREG ptr, _
		byval udtlen as longint, _
		byval level as integer, _
		byval lreg as IRVREG ptr _ _
	)

declare function irhlNewVreg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval vtype as integer _
	) as IRVREG ptr

declare function irhlAllocVreg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as IRVREG ptr

declare function irhlAllocVrImm _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as longint _
	) as IRVREG ptr

declare function irhlAllocVrImmF _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval value as double _
	) as IRVREG ptr

declare function irhlAllocVrVar _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

declare function irhlAllocVrIdx _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval mult as integer, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

declare function irhlAllocVrPtr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval vidx as IRVREG ptr _
	) as IRVREG ptr

declare function irhlAllocVrOfs _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval symbol as FBSYMBOL ptr, _
		byval ofs as longint _
	) as IRVREG ptr

declare sub irForEachDataStmt( byval callback as sub( byval as FBSYMBOL ptr ) )
declare sub irhlFlushStaticInitializer( byval sym as FBSYMBOL ptr )
