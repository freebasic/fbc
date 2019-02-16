declare sub edbgInit( )

declare sub edbgEmitHeader _
	( _
		byval filename as zstring ptr _
	)

declare sub edbgLineBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos as integer, _
		byval filename as zstring ptr _
	)

declare sub edbgLineEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos as integer _
	)

declare sub edbgEmitLine _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval label as FBSYMBOL ptr _
	)

declare sub edbgEmitLineFlush _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval label as FBSYMBOL ptr _
	)

declare sub edbgScopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgScopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgEmitScopeINI _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgEmitScopeEND _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgProcBegin _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgProcEnd _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgProcEmitBegin _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgEmitProcHeader _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgEmitProcFooter _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

declare sub edbgEmitFooter _
	( _
	)

declare sub edbgEmitGlobalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval section as integer _
	)

declare sub edbgEmitProcArg _
	( _
		byval sym as FBSYMBOL ptr _
	)

declare sub edbgEmitLocalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isstatic as integer _
	)

declare sub edbgInclude( byval incfile as zstring ptr )
