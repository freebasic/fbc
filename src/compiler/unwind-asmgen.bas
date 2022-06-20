#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "symb.bi"
#include once "unwind.bi"
#include once "ast.bi"
#include once "list.bi"
#include once "crt/string.bi"

'' Version 1 coverage table is made up of three parts
'' a fixed size header
'' variable length array of cleanup ranges
'' variable length array of 'catch' ranges
'' variable length array of 'catch' types
''
'' The header looks like this:
'' - 2-byte version field - always 1 for this data
'' - 2 byte offset of cleanup ranges (from start of this header, so earliest can be 8)
'' - 2-byte offset of catch ranges (from start of this header)
'' - 2-byte offset of catch types (from start of this header)
'' 
'' Directly after the header are the cleanup ranges. If there are none, the offset of 
'' the catch ranges will be 6
''
'' Cleanup ranges:
'' ---------------
'' Each entry has three data points
''    - offset into the function where it starts
''    - size of the covered range
''    - offset of where cleanup code for this range starts
''
'' For example, the entries will always look like this
''    .unwindLabel1 - .startOfFunctionLabel '' offset to start of this range
''    .endOfScopeLabel - .unwindLabel1 '' size of the range
''    .unwindcleanupLabel1 - .startOfFunctionLabel '' offset of cleanup code
''
'' Values are stored in uleb128 format, this is a variable length encoding
'' similar to UTF-8. As most of the offsets/sizes in these tables will be small
'' this saves on wasted bytes if, for example, they were defined as longs.
'' These tables will only be decoded when there's an error - that it'll
'' tke a bit longer to decode them vs the optimal 3-byte per label saving
''
'' Catch ranges:
'' -------------
'' These work similarly to the cleanup ranges but define the regions
'' covered by On Error Goto statements and where the handlers are
'' In C++/Java/C# terms, the On Error is treated as the start of a try{} block
'' and the handler/label the start of the catch{}
''
'' Each entry has 4 data points
''    - offset into the function where it starts
''    - size of the covered rages
''    - offset of the goto label/handler for this range
''    - 1-based index into the catch types array, or 0 for an on error goto
''
'' Both types of ranges are ordered by start address of the region, i.e. as they are encountered in the code, so top to bottom
''
'' Catch types:
'' ------------
'' This table supports the catching of arbitrary types
'' type info format tbd
''    - first byte of 0 ends the list
'' 
'' GCC personality routine - https://code.woboq.org/gcc/libstdc++-v3/libsupc++/eh_personality.cc.html
'' 
'' 
'' This is all generated inline so no pointers
'' just offsets from the start of the table

'' These functions are fiddly because of each platform's
'' restiction of what bits of data it needs and where in the eventual asm
'' it needs to be

'' There are 3 cases for the CFI statements we need to generate
'' Windows 32 - don't need to generate any, the coverage table is linked in the fb_fn_ranges data
'' Windows 64 - need to generate .seh_handler and .seh_handlerdata within proc bounds
''            - the handlerdata is the coverage table and so this has to be generated inline within
''            - the function's last } in the GCC case, which is a mess in the eventual asm
'' Linux 32   - same as Windows 32
'' Linux 64   - need to generate .cfi_personality and .cfi_lsda. the lsda is the coverage table
''            - but in this case .cfi_lsda takes a pointer/label instead of needing the data inline
''            - so the table is generated outside of proc bounds (after the last } for GCC) otherwise
''            - it would get mixed into the instruction stream and cause problems
''

'' This is in ir-hlc.bas, we need it to generate
'' the proper proc start label to use in the coverage tables
declare function hlcGetMangledNameForASM _
	( _
		byval sym as FBSYMBOL ptr, _
		byval underscore_prefix as integer _
	) as string

private function hProcStartLabel( byval proc as FBSYMBOL ptr ) as string
	return iif( fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GCC, hlcGetMangledNameForASM( proc, TRUE ), *symbGetMangledName( proc ) )
end function

private function hTableHeader( _
	byval tableasm as ASTASMTOK ptr, _
	byref baselabel as string, _
	byref cleanuplabel as string, _
	byref catchlabel as string, _
	byref catchtypelabel as string, _
	byref lineend as string _
) as ASTASMTOK ptr
	dim as ASTASMTOK ptr tabletail = tableasm
	dim as string wordstr = ".word "
	'' version - .word 1
	tabletail = astAsmAppendText( tabletail, wordstr + "1" + lineend )

	'' offset of cleanup ranges
	tabletail = astAsmAppendText( tabletail, wordstr + cleanuplabel + "-" + baselabel + lineend )

	'' offset of catch ranges
	tabletail = astAsmAppendText( tabletail, wordstr + catchlabel + "-" + baselabel + lineend )

	'' offset of catchtype entries
	tabletail = astAsmAppendText( tabletail, wordstr + catchtypelabel + "-" + baselabel + lineend )
	return tabletail
end function

private function hCleanupRegionEntries( _
	byval tableasm as ASTASMTOK ptr, _
	byref procstartlabel as string, _
	byval region as FB_UNWINDREGION ptr, _
	byref lineend as string _
) as ASTASMTOK ptr

	dim as string uleb = ".uleb128 "
	dim as string subtract = "-"
	dim as ASTASMTOK ptr tabletail = tableasm
	while region <> NULL
		dim as FBSYMBOL ptr startlabel = region->startlabel
		dim as FBSYMBOL ptr endlabel = region->endlabel
		dim as FBSYMBOL ptr actionlabel = region->actionlabel

		'' offset to region start
		'' ".uleb128 " + startlabelname + "-" + procstartlabel + lineend
		tabletail = astAsmAppendText( tabletail, uleb ) 
		tabletail = astAsmAppendSymb( tabletail, startlabel ) 
		tabletail = astAsmAppendText( tabletail, subtract + procstartlabel + lineend )

		'' size of region
		'' ".uleb128 " + endlabelname + "-" + startlabelname + lineend
		tabletail = astAsmAppendText( tabletail, uleb )
		tabletail = astAsmAppendSymb( tabletail, endlabel )
		tabletail = astAsmAppendText( tabletail, subtract )
		tabletail = astAsmAppendSymb( tabletail, startlabel )
		tabletail = astAsmAppendText( tabletail, lineend )

		'' offset of destruction/catch label
		'' tablestring += ".uleb128 " + actionlabelname + "-" + procstartlabel + lineend
		tabletail = astAsmAppendText( tabletail, uleb ) 
		tabletail = astAsmAppendSymb( tabletail, actionlabel )
		tabletail = astAsmAppendText( tabletail, subtract + procstartlabel + lineend )

		region = region->next
	wend
	return tabletail
end function

private function hCatchRegionEntries( _
	byval tableasm as ASTASMTOK ptr, _
	byref procstartlabel as string, _
	byval procendlabel as FBSYMBOL ptr, _
	byval region as FB_UNWINDREGION ptr, _
	byval catchtypes as any ptr, _
	byref lineend as string _
) as ASTASMTOK ptr

	dim as string uleb = ".uleb128 "
	dim as string subtract = "-"
	dim as ASTASMTOK ptr tabletail = tableasm
	while region <> NULL
		dim as FBSyMBOL ptr startlabel = region->startlabel
		dim as FBSYMBOL ptr regionendlabel = iif( region->endlabel, region->endlabel, procendlabel )
		dim as FBSYMBOL ptr actionlabel = region->actionlabel

		'' offset to region start
		'' ".uleb128 " + startlabelname + "-" + procstartlabel + lineend
		tabletail = astAsmAppendText( tabletail, uleb ) 
		tabletail = astAsmAppendSymb( tabletail, startlabel )
		tabletail = astAsmAppendText( tabletail, subtract + procstartlabel + lineend )

		'' size of region
		'' ".uleb128 " + endlabelname + "-" + startlabelname + lineend
		tabletail = astAsmAppendText( tabletail, strptr( uleb ) ) 
		tabletail = astAsmAppendSymb( tabletail, regionendlabel )
		tabletail = astAsmAppendText( tabletail, strptr( subtract ) )
		tabletail = astAsmAppendSymb( tabletail, startlabel )
		tabletail = astAsmAppendText( tabletail, strptr( lineend ) )

		'' offset of destruction/catch label
		'' ".uleb128 " + actionlabelname + "-" + procstartlabel + lineend
		tabletail = astAsmAppendText( tabletail, uleb ) 
		tabletail = astAsmAppendSymb( tabletail, actionlabel )
		tabletail = astAsmAppendText( tabletail, subtract + procstartlabel + lineend )

		'' catch type index
		tabletail = astAsmAppendText( tabletail, uleb + "0" + lineend )

		region = region->next
	wend
	return tabletail
end function

private function hCatchTypeEntries( _
	byval tableasm as ASTASMTOK ptr, _
	byref lineend as string _
) as ASTASMTOK ptr

	'' don't have these yet
	dim as string tempstr = ".long 0" + lineend
	return astAsmAppendText( tableasm, strptr( tempstr ) )
end function

private function hGenerateCoverageFragments ( _
	byval tableasm as ASTASMTOK ptr, _
	byval proc as FBSYMBOL ptr, _
	byval procext as FB_PROCEXT ptr, _
	byref procstartlabel as string, _
	byval datastartlabel as FBSYMBOL ptr, _
	byval procendlabel as FBSYMBOL ptr, _
	byref lineend as string _
) as ASTASMTOK ptr

	dim as FB_UNWINDREGION ptr cleanupregions = procext->cleanupregionshead
	dim as FB_UNWINDREGION ptr catchregions = procext->catchregionshead
	dim as ASTASMTOK ptr tabletail = tableasm
	dim as string datastartlabelname = *symbGetName( datastartlabel )

	'' shouldn't be here if both are NULL
	assert( ( cleanupregions <> NULL ) OrElse ( catchregions <> NULL ) )

	tabletail = astAsmAppendText( tabletail, datastartlabelname + ":" + lineend )

	dim as string labelnamestem = *symbGetMangledName( proc )
	dim as string cleanupoffsetlabel = labelnamestem + "_unw_cleanupstart"
	dim as string catchoffsetlabel = labelnamestem + "_unw_catchstart"
	dim as string catchtypeoffsetlabel = labelnamestem + "_unw_catchtypestart"

	tabletail = hTableHeader( tabletail, datastartlabelname, cleanupoffsetlabel, catchoffsetlabel, catchtypeoffsetlabel, lineend )

	tabletail = astAsmAppendText( tabletail, cleanupoffsetlabel + ":" + lineend )
	tabletail = hCleanupRegionEntries( tabletail, procstartlabel, cleanupregions, lineend )

	tabletail = astAsmAppendText( tabletail, catchoffsetlabel + ":" + lineend )
	tabletail = hCatchRegionEntries( tabletail, procstartlabel, procendlabel, catchregions, 0, lineend )

	tabletail = astAsmAppendText( tabletail, catchtypeoffsetlabel + ":" + lineend )
	tabletail = hCatchTypeEntries( tabletail, lineend )
	return tabletail
end function

private function hGenFnInfoSectionEntry( _
	byval tableasm as ASTASMTOK ptr, _
	byref procstartlabel as string, _
	byval procendlabel as FBSYMBOL ptr, _
	byref datastartlabel as FBSYMBOL ptr, _
	byref lineend as string _
) as ASTASMTOK ptr

	dim as ASTASMTOK ptr tabletail = tableasm
	dim as string longtext = ".long "
	tabletail = astAsmAppendText( tabletail, !".section fbexcept,\"rd\"" + lineend )

	'' ".long " + procstartlabel + lineend _
	tabletail = astAsmAppendText( tabletail, longtext + procstartlabel + lineend )

	''".long " + procendlabel + lineend _
	tabletail = astAsmAppendText( tabletail, longtext )
	tabletail = astAsmAppendSymb( tabletail, procendlabel )
	tabletail = astAsmAppendText( tabletail, lineend )

	'' ".long " + tablestartlabel + lineend _
	tabletail = astAsmAppendText( tabletail, longtext + *symbGetName( datastartlabel ) + lineend )
	return tabletail
end function

private function hGenLoadConfigReference( _
	byval tableasm as ASTASMTOK ptr, _
	byref lineend as string _
) as ASTASMTOK ptr
	dim as ASTASMTOK ptr tabletail = astAsmAppendText( tableasm, ".section .rdata" + lineend )
	tabletail = astAsmAppendText( tabletail, ".global __load_config_used" + lineend )
	return tabletail
end function

function unwindGenProcTable ( _
	byval proc as FBSYMBOL ptr, _
	byref procendlabel as FBSYMBOL ptr _
) as ASTNODE ptr

	dim as integer is64target = ( fbGetCpuFamily( ) = FB_CPUFAMILY_X86_64 )
	dim as integer iswindowstarget = ( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_WIN32 )
	dim as FB_PROCEXT ptr procext = proc->proc.ext
	dim as string lineend = NEWLINE
	dim as ASTASMTOK ptr tableheadnode = any, tabletail = any
	dim as integer needsjumptoexit
	dim as ASTNODE ptr tablestartlabel

	'' the coverage tables go in different places per platform...
	dim as string sectionstmt
	dim as integer alignment
	if iswindowstarget then
		if is64target then
			'' ...win64, the tables are inline under seh_handlerdata
			'' and LD sorts out its storage
			sectionstmt = ".seh_handlerdata"
			alignment = 16
		else
			'' ...on Win32, it goes at the end of the fbexcept section
			'' that houses the function ranges, this is to minimize
			'' wasted space, as the function range entries are only 12 bytes
			sectionstmt = ".section fbexcept,3"
			alignment = 4
		end if
	else
		sectionstmt = !".section fbexcept,\"a\",@progbits"
		'' ptr size alignment
		alignment = ( abs( is64target ) + 1 ) shl 2
	end if
	'' GCC adds alignment directives between the c labels and asm statements
	'' when compiling with optimizations.
	'' Worse, different version of GCC use different alignment values
	'' So we take charge to enforce an alignment so we can actually find where
	'' our data starts
	sectionstmt += lineend + ".balign " + str( alignment ) + lineend

	dim as string procstartlabel = hProcStartLabel( proc )
	dim as FBSYMBOL ptr datastartlabel = procext->coveragetablelocation
	if( fbGetOption( FB_COMPOPT_BACKEND ) = FB_BACKEND_GCC ) then
		tablestartlabel = astNewLABEL( unwindGenGCCCoverageTableLabel( ) )
		needsjumptoexit = 1
	end if

	tableheadnode = astAsmAppendText( NULL, sectionstmt )

	tabletail = hGenerateCoverageFragments( tableheadnode, proc, procext, procstartlabel, datastartlabel, procendlabel, lineend )

	'' Linux-32 reliably generates cfi data so we don't need this crutch
	if is64target = 0 andalso iswindowstarget then
		tabletail = hGenFnInfoSectionEntry( tabletail, procstartlabel, procendlabel, datastartlabel, lineend )
		'' on win32, generate a reference to the _load_config_used in libfbexcept
		'' so it will be included in the exe (for safeseh purposes)
		tabletail = hGenLoadConfigReference( tabletail, lineend )
		'' and finally a buffer between the function ranges and the coverage table data
		'' so libfbexcept can know where the ranges end
		dim as string secbuffer = ".section fbexcept,2" + lineend + _
			".long 0,0,0" + lineend + _
			".linkonce" + lineend
		tabletail = astAsmAppendText( tabletail, secbuffer )
	end if
	tabletail = astAsmAppendText( tabletail, ".text" + lineend )
	dim as ASTNODE ptr tableasm = astNewASM( tableheadnode )
	if needsjumptoexit andalso ( symbGetFullType( proc ) <> 0 ) then
		'' the proc table is inserted after the return (and thus unreachable)
		'' in procs that return values
		'' Since we've referenced the proc table in an asm goto to make GCC not remove it
		'' (because it's unreachable), the goto makes GCC think execution /can/ get
		'' here and as such, it generates a warning of
		'' 'control reaches end of non-void function'
		'' thinking this is a valid exit path out of the function
		'' to fix this we manually add a jump to the function end label to quiet it down

		'' subs don't generate a C return statement, so we don't put this goto
		'' in those situation, otherwise we end up with an infinite loop
		'' at the end of the proc
		''tableasm = astNewLINK( tableasm, astNewBRANCH( AST_OP_JMP, procendlabel ), AST_LINK_RETURN_NONE )
	end if
	return iif( tablestartlabel, astNewLINK( tablestartlabel, tableasm, AST_LINK_RETURN_NONE ), tableasm )
end function

function unwindGenCfiHeader( byval datalabel as FBSYMBOL ptr ) as ASTNODE ptr

	dim as string cfiheader
	dim as integer is64target = ( fbGetCpuFamily( ) = FB_CPUFAMILY_X86_64 )
	dim as integer iswindows = ( fbGetOption( FB_COMPOPT_TARGET ) = FB_COMPTARGET_WIN32 )
	dim as string lineend = NEWLINE
	dim as ASTASMTOK ptr asmstmt = any

	if iswindows then
		If is64target then
			asmstmt = astAsmAppendText( NULL, ".seh_handler fb_DispatchException, @unwind, @except" + lineend )
		else
			return NULL '' not required on 32-bit
		end if
	else
		'' the 0x3 here means unsigned int encoding, but I'm not sure /what/ it's the encoding of
		'' the second is the function GCC unwinding will call when it gets to this stack frame
		'' in exception handling
		'' https://sourceware.org/binutils/docs/as/CFI-directives.html
		'' https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html

		
		'' cfiheader += ".cfi_personality 0x3,fb_DispatchException" + lineend _
		''	+ ".cfi_lsda 0x3," + *symbGetName( datalabel ) + lineend
		dim as string datalabelname = *symbGetName( datalabel )
		dim as string cfidirs = ".cfi_personality 0x3,fb_DispatchException" + lineend + _
			".cfi_lsda 0x3," + datalabelname + lineend
		asmstmt = astAsmAppendText( NULL, cfidirs )
	end if
	return astNewASM( asmstmt )
end function

'' In older versions of GCC (< 12)
'' the optimize attribute seems to /replace/ existing -f command line options
'' instead of being appended to them like it is now, which is why
'' we repeat no-omit-frame-pointer here, because that is very important
function unwindGenProcGCCAttributes( byval proc as FBSYMBOL ptr ) as string
	return !" __attribute__((noinline, no_icf, noclone)) " _
	!"__attribute__((optimize(\"no-reorder-blocks,no-reorder-blocks-and-partition,no-omit-frame-pointer\")))"
end function
