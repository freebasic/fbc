'' inline asm parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "parser.bi"
#include once "ast.bi"

''
'' ASM keyword lists
''
'' Identifiers in this list will be untouched in inline ASM.
''
'' Other identifiers (not in this list) can be replaced by the mangled name of
'' an equally-named FB symbol (e.g. a variable/procedure/label), if one was
'' declared (such that, for example, a call to f becomes a call to F@0).
''
dim shared asmKeywordsX86(0 to ...) as const zstring ptr => _
{ _
	@"dl", @"di", @"si", @"cl", @"bl", @"al", @"bp", @"sp", _
	@"dx", @"cx", @"bx", @"ax", _
	@"edx",  @"edi",  @"esi",  @"ecx",  @"ebx",  @"eax",  @"ebp",  @"esp", _
	@"st", @"cs", @"ds", @"es", @"fs", @"gs", @"ss", _
	@"mm0", @"mm1", @"mm2", @"mm3", @"mm4", @"mm5", @"mm6", @"mm7", _
	@"xmm0", @"xmm1", @"xmm2", @"xmm3", @"xmm4", @"xmm5", @"xmm6", @"xmm7", _
	@"byte", @"word", @"dword", @"qword", _
	@"ptr", @"offset", _
	@"aaa", @"aad", @"aam", @"aas", @"adc", @"add", @"addpd", @"addps", @"addsd", @"addss", @"and", @"andpd", @"andps", _
	@"andnpd", @"andnps", @"arpl", @"bound", @"bsf", @"bsr", @"bswap", @"bt", @"btc", @"btr", @"bts", @"call", @"cbw", _
	@"cwde", @"cdq", @"clc", @"cld", @"clflush", @"cli", @"clts", @"cmc", @"cmova", @"cmovae", @"cmovb", @"cmovbe", _
	@"cmovc", @"cmove", @"cmovg", @"cmovge", @"cmovl", @"cmovle", @"cmovna", @"cmovnae", @"cmovnb", @"cmovnbe", _
	@"cmovnc", @"cmovne", @"cmovng", @"cmovnge", @"cmovnl", @"cmovnle", @"cmovno", @"cmovnp", @"cmovns", @"cmovnz", _
	@"cmovo", @"cmovp", @"cmovpe", @"cmovpe", @"cmovpo", @"cmovs", @"cmovz", @"cmp", @"cmppd", @"cmpps", @"cmps", _
	@"cmpsb", @"cmpsw", @"cmpsd", @"cmpss", @"cmpxchg", @"cmpxchg8b", @"comisd", @"comiss", @"cpuid", @"cvtdq2pd", _
	@"cvtdq2ps", @"cvtpd2dq", @"cvtpd2pi", @"cvtpd2ps", @"cvtpi2pd", @"cvtpi2ps", @"cvtps2dq", @"cvtps2pd", _
	@"cvtps2pi", @"cvtsd2si", @"cvtsd2ss", @"cvtsi2sd", @"cvtsi2ss", @"cvtss2sd", @"cvtss2si", @"cvttpd2pi", _
	@"cvttpd2dq", @"cvttps2dq", @"cvttps2pi", @"cvttsd2si", @"cvttss2si", @"cwd", @"daa", @"das", @"dec", @"div", _
	@"divpd", @"divps", @"divss", @"emms", @"enter", @"f2xm1", @"fabs", @"fadd", @"faddp", @"fiadd", @"fbld", _
	@"fbstp", @"fchs", @"fclex", @"fnclex", @"fcmovb", @"fcmove", @"fcmovbe", @"fcmovu", @"fcmovnb", @"fcmovne", _
	@"fcmovnbe", @"fcmovnu", @"fcom", @"fcomp", @"fcompp", @"fcomi", @"fcomip", @"fucomi", @"fucomip", @"fcos", _
	@"fdecstp", @"fdiv", @"fdivp", @"fidiv", @"fdivr", @"fdivrp", @"fidivr", @"ffree", @"ficom", @"ficomp", _
	@"fild", @"fincstp", @"finit", @"fninit", @"fist", @"fistp", @"fld", @"fld1", @"fldl2t", @"fldl2e", @"fldpi", _
	@"fldlg2", @"fldln2", @"fldz", @"fldcw", @"fldenv", @"fmul", @"fmulp", @"fimul", @"fnop", @"fpatan", @"fprem", _
	@"fprem1", @"fptan", @"frndint", @"frstor", @"fsave", @"fnsave", @"fscale", @"fsin", @"fsincos", @"fsqrt", _
	@"fst", @"fstp", @"fstcw", @"fnstcw", @"fstenv", @"fnstenv", @"fstsw", @"fnstsw", @"fsub", @"fsubp", @"fisub", _
	@"fsubr", @"fsubrp", @"fisubr", @"ftst", @"fucom", @"fucomp", @"fucompp", @"fwait", @"fxam", @"fxch", @"fxrstor", _
	@"fxsave", @"fxtract", @"fyl2x", @"fyl2xp1", @"hlt", @"idiv", @"imul", @"in", @"inc", @"ins", @"insb", @"insw", _
	@"insd", @"int", @"into", @"invd", @"invlpg", @"iret", @"iretd", @"ja", @"jae", @"jb", @"jbe", @"jc", @"jcxz", _
	@"jecxz", @"je", @"jg", @"jge", @"jl", @"jle", @"jna", @"jnae", @"jnb", @"jnbe", @"jnc", @"jne", @"jng", @"jnge", _
	@"jnl", @"jnle", @"jno", @"jnp", @"jns", @"jnz", @"jo", @"jp", @"jpe", @"jpo", @"js", @"jz", @"jmp", @"lahf", @"lar", _
	@"ldmxcsr", @"lds", @"les", @"lfs", @"lgs", @"lss", @"lea", @"leave", @"lfence", @"lgdt", @"lidt", @"lldt", @"lmsw", _
	@"lock", @"lods", @"lodsb", @"lodsw", @"lodsd", @"loop", @"loope", @"loopz", @"loopne", @"loopnz", @"lsl", @"ltr", _
	@"maskmovdqu", @"maskmovq", @"maxpd", @"maxps", @"maxsd", @"maxss", @"mfence", @"minpd", @"minps", @"minsd", _
	@"minss", @"mov", @"movapd", @"movaps", @"movd", @"movdqa", @"movdqu", @"movdq2q", @"movhlps", @"movhpd", _
	@"movhps", @"movlhps", @"movlpd", @"movlps", @"movmskpd", @"movmskps", @"movntdq", @"movnti", @"movntpd", _
	@"movntps", @"movntq", @"movq", @"movq2dq", @"movs", @"movsb", @"movsw", @"movsd", @"movss", @"movsx", @"movupd", _
	@"movups", @"movzx", @"mul", @"mulpd", @"mulps", @"mulsd", @"mulss", @"neg", @"nop", @"not", @"or", @"orpd", _
	@"orps", @"out", @"outs", @"outsb", @"outsw", @"outsd", @"packsswb", @"packssdw", @"packuswb", @"paddb", _
	@"paddw", @"paddd", @"paddq", @"paddsb", @"paddsw", @"paddusb", @"paddusw", @"pand", @"pandn", @"pause", _
	@"pavgb", @"pavgw", @"pcmpeqb", @"pcmpeqw", @"pcmpeqd", @"pcmpgtb", @"pcmpgtw", @"pcmpgtd", @"pextrw", _
	@"pinsrw", @"pmaddwd", @"pmaxsw", @"pmaxub", @"pminsw", @"pminub", @"pmovmskb", @"pmulhuv", @"pmulhw", _
	@"pmullw", @"pmuludq", @"pop", @"popa", @"popad", @"popf", @"popfd", @"por", @"prefetcht0", @"prefetcht1", _
	@"prefetcht2", @"prefetchnta", @"psadbw", @"pshufd", @"pshufhw", @"pshuflw", @"pshufw", @"psllw", @"pslld", _
	@"psllq", @"psraw", @"psrad", @"psrldq", @"psrlw", @"psrld", @"psrlq", @"psubb", @"psubw", @"psubd", @"psubq", _
	@"psubsb", @"psubsw", @"psubusb", @"psubusw", @"punpckhbw", @"punpckhwd", @"punpckhdq", @"punpckhqdq", _
	@"punpcklbw", @"punpcklwd", @"punpckldq", @"punpcklqdq", @"push", @"pusha", @"pushad", @"pushf", @"pushfd", _
	@"pxor", @"rcl", @"rcr", @"rol", @"ror", @"rcpps", @"rcpss", @"rdmsr", @"rdpmc", @"rdtsc", @"rep", @"repe", _
	@"repz", @"repne", @"repnz", @"ret", @"rsm", @"rsqrtps", @"rsqrtss", @"sahf", @"sal", @"sar", @"shl", @"shr", _
	@"sbb", @"scas", @"scasb", @"scasw", @"scasd", @"seta", @"setae", @"setb", @"setbe", @"setc", @"sete", @"setg", _
	@"setge", @"setl", @"setle", @"setna", @"setnae", @"setnb", @"setnbe", @"setnc", @"setne", @"setng", @"setnge", _
	@"setnl", @"setnle", @"setno", @"setnp", @"setns", @"setnz", @"seto", @"setp", @"setpe", @"setpo", @"sets", _
	@"setz", @"sfence", @"sgdt", @"sidt", @"shld", @"shrd", @"shufpd", @"shufps", @"sldt", @"smsw", @"sqrtpd", _
	@"sqrtps", @"sqrtsd", @"sqrtss", @"stc", @"std", @"sti", @"stmxcsr", @"stos", @"stosb", @"stosw", @"stosd", _
	@"str", @"sub", @"subpd", @"subps", @"subsd", @"subss", @"sysenter", @"sysexit", @"test", @"ucomisd", _
	@"ucomiss", @"ud2", @"unpckhpd", @"unpckhps", @"unpcklpd", @"unpcklps", @"verr", @"verw", @"wait", @"wbinvd", _
	@"wrmsr", @"xadd", @"xchg", @"xlat", @"xlatb", @"xor", @"xorpd", @"xorps", _
	@"pavgusb", @"pfadd", @"pfsub", @"pfsubr", @"pfacc", @"pfcmpge", @"pfcmpgt", @"pfcmpeq", @"pfmin", @"pfmax", _
	@"pi2fw", @"pi2fd", @"pf2iw", @"pf2id", @"pfrcp", @"pfrsqrt", @"pfmul", @"pfrcpit1", @"pfrsqit1", @"pfrcpit2", _
	@"pmulhrw", @"pswapw", @"femms", @"prefetch", @"prefetchw", @"pfnacc", @"pfpnacc", @"pswapd", @"pmulhuw" _
}

type AsmKeywordsInfo
	inited as integer
	hash as THASH
end type

dim shared asmkeywords as AsmKeywordsInfo

private sub hInitAsmKeywords( )
	'' TODO: support x86_64, arm, aarch64; select keyword list based on compilation target
	hashInit( @asmkeywords.hash, 600 )
	for i as integer = 0 to ubound( asmKeywordsX86 )
		hashAdd( @asmkeywords.hash, asmKeywordsX86(i), cast( any ptr, INVALID ), INVALID )
	next
end sub

private function hIsAsmKeyword( byval text as zstring ptr ) as integer
	if( asmkeywords.inited = FALSE ) then
		hInitAsmKeywords( )
		asmkeywords.inited = TRUE
	end if
	function = (hashLookup( @asmkeywords.hash, text ) <> NULL)
end function

sub parserInlineAsmEnd( )
	if( asmkeywords.inited ) then
		hashEnd( @asmkeywords.hash )
		asmkeywords.inited = FALSE
	end if
end sub

const LEX_FLAGS = (LEXCHECK_NOWHITESPC or LEXCHECK_NOLETTERSUFFIX)

'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
sub cAsmCode()
	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr expr = any
	dim as ASTASMTOK ptr head = any, tail = any
	dim as integer doskip = any, thisTok = any

	head = NULL
	tail = NULL
	do
		'' !(END|Comment|NEWLINE)
		thisTok = lexGetToken( LEX_FLAGS )
		select case as const thisTok
		case FB_TK_END, FB_TK_EOL, FB_TK_COMMENT, FB_TK_REM, FB_TK_EOF
			exit do
		end select

		text = *lexGetText( )
		sym = NULL
		doskip = FALSE

		select case as const lexGetClass( LEX_FLAGS )

		'' id?
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD
			if thistok = FB_TK_SIZEOF then
				'' SIZEOF( valid expression )?
				expr = cMathFunct( thisTok, TRUE )
				if( expr ) then
					'' constant expression?
					if( astIsCONST( expr ) ) then
						'' text replacement
						text = astConstFlushToStr( expr )
					else
						errReport( FB_ERRMSG_EXPECTEDCONST )
						'' skip emission
						doskip = TRUE
					end if
				else
					errReport( FB_ERRMSG_SYNTAXERROR )
					'' skip emission
					doskip = TRUE
				end if

			elseif( hIsAsmKeyword( lcase(text) ) = FALSE ) then
				dim as FBSYMBOL ptr base_parent = any

				chain_ = cIdentifier( base_parent )
				do while( chain_ <> NULL )
					dim as FBSYMBOL ptr s = chain_->sym
					do
						select case symbGetClass( s )
						case FB_SYMBCLASS_PROC, FB_SYMBCLASS_LABEL
							sym = s
							exit do, do

						'' const?
						case FB_SYMBCLASS_CONST
							text = symbGetConstValueAsStr( s )
							exit do, do

						case FB_SYMBCLASS_VAR
							'' var?
							sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )

							if( sym <> NULL ) then
								symbSetIsAccessed( sym )
							end if
							exit do, do

						end select

						s = s->hash.next
					loop while( s <> NULL )

					chain_ = symbChainGetNext( chain_ )
				loop
            end if

		'' lit number?
		case FB_TKCLASS_NUMLITERAL
			 expr = cNumLiteral( FALSE )
			 if( expr <> NULL ) then
				text = astConstFlushToStr( expr )
			 end if

		'' lit string?
		case FB_TKCLASS_STRLITERAL
			 expr = cStrLiteral( FALSE )
			 if( expr <> NULL ) then
             	dim as FBSYMBOL ptr litsym = astGetStrLitSymbol( expr )
             	if( litsym <> NULL ) then
                    text = """"
                    if( symbGetType( litsym ) <> FB_DATATYPE_WCHAR ) then
             			text += *symbGetVarLitText( litsym )
             		else
             			text += *symbGetVarLitTextW( litsym )
             		end if
             		text += """"
			 	end if

			 	astDelTree( expr )
			 end if

		''
		case FB_TKCLASS_KEYWORD
			select case thisTok
			case FB_TK_FUNCTION
			'' FUNCTION?
    			sym = symbGetProcResult( parser.currproc )
    			if( sym = NULL ) then
					errReport( FB_ERRMSG_SYNTAXERROR )
					doskip = TRUE
    			else
    				symbSetIsAccessed( sym )
    			end if

			case FB_TK_CINT
				'' CINT( valid expression )?
				expr = cTypeConvExpr( thisTok, TRUE )
				if( expr <> NULL ) then
					'' constant expression?
					if( astIsCONST( expr ) ) then
						'' text replacement
						text = astConstFlushToStr( expr )
					else
						errReport( FB_ERRMSG_EXPECTEDCONST )
						'' skip emission
						doskip = TRUE
					end if
				else
					errReport( FB_ERRMSG_SYNTAXERROR )
					'' skip emission
					doskip = TRUE
				end if
			end select
		end select

		''
		if( doskip = FALSE ) then
			if( sym ) then
				tail = astAsmAppendSymb( tail, sym )
			else
				tail = astAsmAppendText( tail, text )
			end if
			if( head = NULL ) then
				head = tail
			end if
		end if

		lexSkipToken( LEX_FLAGS )
	loop

	'' One ASM node per line of asm, with as many asm tokens as needed each
	if( head <> NULL ) then
		astAdd( astNewASM( head ) )
	end if
end sub

'Ignore CHAR_SPACE and CHAR_TAB
function CheckFirstChar(byval pVS as ubyte ptr,byval KeyChar as ubyte) as integer
	function=false
	if pVS then
		do
			select case *pVS
				case KeyChar
					function=true
					exit do
				case CHAR_SPACE,CHAR_TAB'Ignore

				case else
					exit do
			End Select
			pVS+=1
		Loop
	EndIf
end function

function IgnoreDbg4AsmCode() as integer
	dim pS as ubyte ptr=any
	function=false
	pS=lexGetText()
	if pS then
		if CheckFirstChar(pS,asc(".")/'user defined data,section etc?'/) then
			function=true
		elseif CheckFirstChar(lex.ctx->buffptr,asc(":")/'user label?'/)  then
			function=true
		EndIf
	EndIf
end function

'':::::
''AsmBlock        =   ASM Comment? SttSeparator
''                        (AsmCode Comment? NewLine)+
''					  END ASM .
function cAsmBlock as integer
	dim as integer issingleline = any,isIgnoreline = any
	Dim As Integer IsFixDebug=fbGetOption( FB_COMPOPT_FIXDEBUGINFO ) 

	function = FALSE

	'' ASM?
	if( lexGetToken( ) <> FB_TK_ASM ) then
		exit function
	end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_ASM )
    	exit function
    end if

	lexSkipToken( )

	'' (Comment SttSeparator)?
	issingleline = FALSE
	isIgnoreline = FALSE
	if( cComment( ) ) then
		'' emit the current line in text form
		hEmitCurrLine( )

		if( cStmtSeparator( ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until next line
			hSkipUntil( FB_TK_EOL, TRUE )
		end if
	else
		if( cStmtSeparator( ) = FALSE ) then
			issingleline = TRUE
        end if
	end if

	'' (AsmCode Comment? NewLine)+
	Do
		If IsFixDebug Then
			isIgnoreline=IgnoreDbg4AsmCode()
		EndIf

		if( issingleline = FALSE and isIgnoreline=FALSE) then
			astAdd(astNewDBG(AST_OP_DBG_LINEINI, lexLineNum()))
		end if

		cAsmCode( )

		'' Comment?
		cComment( LEX_FLAGS )

		'' emit the current line in text form
		hEmitCurrLine( )

		'' NewLine
		select case lexGetToken( )
		case FB_TK_EOL
			if( issingleline ) then
				exit do
			end if

			lexSkipToken( )

		case FB_TK_EOF
			exit do

		case FB_TK_END
			exit do

		case else
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until next line
			hSkipUntil( FB_TK_EOL, TRUE )
		end select

		if( issingleline = FALSE  and isIgnoreline=FALSE) then
			astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )
		end if
	loop

	if( issingleline = FALSE ) then
		'' END ASM
		if( hMatch( FB_TK_END ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDENDASM )
		elseif( hMatch( FB_TK_ASM ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDENDASM )
		end if
	end if

	function = TRUE

end function
