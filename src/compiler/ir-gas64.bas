''-------------
''ir-gas64.bas
''-------------

'' asm 64bit backend
'' By SARG

/' ================== information ===============================

Windows ABI
-----------
params : rcx,rdx,r8,r9 + xmm0 to xmm3
Space for these registers also reserved on the stack to store them at the beginning of proc.

However if the first arg is an integer number (not a float) it is put in rcx and if the second one is a float it is put in xmm0. But if the third
one is an integer, r8 (not rdx) is used. And so on. So only four registers (rNN or xmmN) are used. Other parameters are put on the stack.

ex : integer, float,integer, float  ->  rcx,xmm1,r8,xmm3

rbp,rbx,rdi,rsi,r12,r13,r14,r15 belong to calling proc, if used by called need to be saved by called
rcx,rdx,r8,r9,rax,r10,r11       belong to called  proc, if used by calling need to be saved (before call)

Linux ABI
---------
params : rdi,rsi,rdx,rcx,r8,r9 + xmm0 to xmm7
Space for these registers also reserved on the stack to store them at the beginning of proc.

Differently from Windows ABI all the registers (rNN or xmmN) could be used for passing parameters. Other parameters are put on the stack.

rbx, r12 to r15  belong to calling proc, if used by called need to be saved by called
parameters + r10 r11 rax belong to called  proc, if used by calling need to be saved (before call)

Red zone : an area (128 bytes= 16 regs * 8) reserved on the stack, seems not often used



data organisation ''todo complete that information
-----------------
IRVREGTYPE_ENUM
	IR_VREGTYPE_IMM 0
	IR_VREGTYPE_VAR 1 '' VAR - var access
	 <varname> ofs static --> [rip+ofs]  / local --> ofs[rbp]
	IR_VREGTYPE_IDX 2 '' IDX - local array indexing
	 ofs1 vidx=<var <varname>ofs2    local
	 <varname> ofs vidx=<reg         local/static
	 ofs vidx=<reg
	 also several levels for vidx and could be VAR (local/global)
	IR_VREGTYPE_PTR 3 '' PTR - derefs
	 ofs vidx=reg
	IR_VREGTYPE_REG 4
	IR_VREGTYPE_OFS 5 '' OFS - global symbol access
	 <varname> ofs static

WINDOWS stack organization
--------------------------
rbp+xx         param x
rbp+56         param 6
rbp+48         param 5 if more than 4 parameters and up
rbp+40         param 4 also in registers (rcx or xmm)
rbp+32         param 3
rbp+24         param 2
rbp+16         param 1   calling --> rsp + x / called --> rbp + 16, 24,.. to 8+x*8
			   return addr (after call)
rbp            old rbp
rbp-8          rbx  7 saved registers (space arbitrary reserved even not used) --> rbp -8 to -56
-16            rdi
-24            rsi
-32            r12
-40            r13
-48            r14
-56            r15
rbp-56-x -->  local vars

			   param x space is reversed using argcountmax, even with variadic
			   .......
rsp+32 -->     param 5 if more than 4 parameters and up
			   param 4 also in registers (rcx or xmm)
			   param 3
			   param 2
rsp -->        param 1

0[rsp)=16[rbp]

Linux stack organization (Linux/BSD)
------------------------
rbp+32         param 3
rbp+24         param 2
rbp+16         FIRST param 1 on stack (no param in register)  calling --> rsp + x / called --> rbp + 16, 24,.. to 8+x*8
			   return addr (after call)
rbp            old rbp
rbp-8          rbx  5 saved registers (space arbitrary reserved even not used) --> rbp -8 to -40
-16            r12
-24            r13
-32            r14
-40            r15

if variadic register save area, only for parameters not defined
-152 rdi 0
-112 rsi 8
...
-104 r9  40
-176 xmm0 48
...
-48 xmm7 104

rbp-x      saved param passed in register
rbp-y -->  local vars
'/

#include once "fbint.bi"
#include once "flist.bi"
#include once "lex.bi"
#include once "ir-private.bi"
#include once "stabs.bi"

'' comment to not get basic data
'#define basicdata

#define KDOALL   0
#define KNOALL   1
#define KNOFREE  2
#define KNOOPTIM 3

#define asm_code(s,opt...) hWriteasm64(s,opt)
#macro cfi_asm_code(s, opt...)
	if( env.clopt.unwindinfo = true ) then
		hWriteasm64(s,opt)
	end if
#endmacro
declare sub cfi_windows_asm_code(byval statement as string)

'' Define __GAS64_DEBUG__ if it wasn't explicitly disabled
'' by '-d DISABLE_GAS64_DEBUG' passed as compiler option when
'' compiling fbc itself (or in the makefile).
'' Defining __GAS64_DEBUG__ will enable debug information to
'' be written to the asm file.  Disabling __GAS64_DEBUG__ but still
'' allowing __FB_DEBUG__ allows building a debug version of fbc but
'' not have asm files grow to very large sizes.
''
#ifndef DISABLE_GAS64_DEBUG
	'' not disabled? OK turn on debugging information in asm
	'' files by default if this is a debug version of fbc
	#if __FB_DEBUG__ <> 0
		#define __GAS64_DEBUG__
	#endif
#endif

#ifdef __GAS64_DEBUG__
	#define asm_info(s) hWriteasm64("# "+s)
#else
	#define asm_info(s) rem
	#ifndef typeDumpToStr
		#define typeDumpToStr(a,b) " "+str(a)
	#endif
#endif

#macro asm_error(s)
	hWriteasm64("")
	asm_info(String(len(s)+10,"*"))
	asm_info("* ERROR "+s+" *")
	asm_info(String(len(s)+10,"*"))
	asm_code("FOUND AN ERROR : "+s)
	hWriteasm64("")
#endmacro

#define NEWLINE2 NEWLINE+string( ctx.indent*3, 32 )
#define KUSE_MOV 0
#define KUSE_LEA 1
#define KUSE_JMP 2

#define KREGFREE  -2 ''register not free
#define KREGRSVD  -3 ''register reserved
#define KREGLOCK  -4 ''register locked (used as parameter)
#define KREGUPPER 15 ''registers 0 to 15 / 16=rip /17=dummy reg to avoid crash
#define KNOTFOUND -1
#define KSIZEPROCTXT 4000000 ''initial size of proc_txt used for speed up text adding

'' used by ASM64_REGROOM.status (TODO: use a named enum for readability???)
#define KROOMFREE -1
#define KROOMMARKED -2
#define KROOMUSED -3

#macro MPUSH(strg)
	pushnbstr+=1
	pushstr(pushnbstr)=strg
	asm_info("MPUSH="+str(pushnbstr)+" "+pushstr(pushnbstr))
#endmacro

enum KREG
	KREG_RAX
	KREG_RBX
	KREG_RCX
	KREG_RDX
	KREG_RSI
	KREG_RDI
	KREG_RBP
	KREG_RSP
	KREG_R8
	KREG_R9
	KREG_R10
	KREG_R11
	KREG_R12
	KREG_R13
	KREG_R14
	KREG_R15
	KREG_RIP
	''17 corresponding string * XXX to generate an error when assembling
	KREG_XXX
end enum
''parameter type
enum
	KPARAMR1
	KPARAMX1
	KPARAMRR
	KPARAMRX
	KPARAMXR
	KPARAMXX
	KPARAMSK0=10
	KPARAMSK1
	KPARAMSK2
	KPARAMSK3
end enum

''offset for saving registers before a call
#define KRCX_OFST -24
#define KRDX_OFST -32
#define KRSI_OFST -40
#define KRDI_OFST -48
#define KR8_OFST  -56
#define KR9_OFST  -64
#define KR10_OFST -72
#define KR11_OFST -80

enum
	'' every thing outside proc, global declarations
	SECTION_HEAD
	'' procedure bodies
	SECTION_BODY
	'' every thing outside proc,  debugging meta data
	SECTION_FOOT
	'' for each procedure, will be add to the section_body
	SECTION_PROLOG
	'' instructions, etc between prolog and epilog .....
	SECTION_PROC
	SECTION_EPILOG
end enum

'' type for tracking the spilled registers
type ASM64_SAVEDREG
	id as long           '' unique id for debugging messages only
	sdvreg as long       '' the id of the real register spilled??? KREGFREE = FREE
	sdoffset as long     '' offset into the spilled registers for current stackframe
	spilbranch1 as long  '' depends ctx.labelbranch2 for tracking spilled registers in second branch???
end type

type ASM64_CONTEXT
	'' current indentation used by hWriteam64()
	indent       as integer
	'' current section to write to
	section      as integer
	head_txt     as string
	body_txt     as string
	foot_txt     as string
	prolog_txt   as string
	proc_txt     as string
	epilog_txt   as string
	argcptmax    as integer
	arginteg     as integer
	argfloat     as integer
	ofs          as integer
	''stack necessary for each procedure,stkmax if structure passed byval
	''stkspil value stack at beginning of procedures to check no overflow for spilling
	''stkcopy stack pointer when copying byval parameter
	stk          as longint
	stkmax       as longint
	stkspil      as longint
	stkcopy      as longint
	usedreg      as long
	''to save register and virtuel register to be used with jmp reg after a cmp where reg is unmarked
	''happens when -exx is set   check pointer not null --> cmp r11,0 / je LT_0001 / jmp [r11]
	jmpreg       as long
	jmpvreg      as long
	jmppass      as long
	'ctors        as string  ''kept here if to be added
	'dtors        as string
	ctorcount    as integer
	dtorcount    as integer
	roundfloat   as boolean ''rounding float can use different ways
	''preparing arguments (hdocall)
	proccalling  as Boolean
	''for spilling registers
	spillvregs   as TFLIST  '' ASM64_SPILLVREG
	vreg_count   as long    '' required because TFLIST doesn't count allocated items
	''to handle iif case
	labelbranch2 as FBSYMBOL ptr
	labeljump    as FBSYMBOL ptr
	''for variadic parameters
	variadic     as boolean
	''target linux or win32
	target       as FB_COMPTARGET
	systemv      as boolean   ' linux / BSD
	''handling of vreg after a call
	opereg    as integer
	opepass   as integer
	maxstack  as integer
end type

type DBGCTX
	typecnt   as uinteger
	lnum      as integer
	prevfilename as string
	linefilename as string
	proc      as FBSYMBOL ptr
	strnb     as integer
	strmax    as integer
	stabnb    as integer
	stabmax   as integer
	offst     as longint
end type

union ustab
	full as longint
	type
		offst as long
		cod as short
		desc as short
	end type
end union

''for strings used in debugging data to avoid duplicate
type tdbgstr
	offst as longint
	txt   as string
end type
type tdbgstab
	stab  as longint
	value as string
end type
''=================== declares ==============================================
declare sub _emitdbg(byval op as integer,byval proc as FBSYMBOL ptr,byval lnum as Integer,ByVal filename as zstring Ptr = 0)
declare sub check_optim(byref code as string)
declare sub _emitconvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )
declare function hgetdatatype_asm64 (byval sym as FBSYMBOL ptr,byval arraydimensions as integer = 0) as string
declare sub hwriteasm64( byref ln as string,byval opt as integer=KDOALL)
declare sub _emitvariniend( byval sym as FBSYMBOL ptr )
declare sub _emitvarinipad( byval bytes as longint )
declare sub _emitvariniwstr(byval varlength as longint,byval literal as wstring ptr,byval litlength as longint)
declare sub _emitvariniscopebegin(byval sym as FBSYMBOL ptr,byval is_array as integer)
declare sub _emitvariniscopeend( )
declare sub _emitfbctinfbegin( )
declare sub _emitfbctinfend( )
declare sub _scopebegin( byval s as FBSYMBOL ptr )
declare sub _scopeend( byval s as FBSYMBOL ptr )
declare sub _emitspillregs( )
declare sub _emitload( byval v1 as IRVREG ptr )
declare sub _emitlabelnf(byval label as FBSYMBOL Ptr)
declare sub _emitscopebegin( byval s as FBSYMBOL ptr )
declare sub _emitscopeend( byval s as FBSYMBOL ptr )
declare sub _emitMacro( byval op as integer,byval v1 as IRVREG ptr, byval v2 as IRVREG ptr, byval vr as IRVREG ptr )
declare sub save_call(byref func as string,byval vr as IRVREG ptr,byval vrreg as integer)
declare function hGetMagicStructNumber( byval sym as FBSYMBOL ptr ) as integer
declare sub dbg_addstab(byref txt as string="",byval cod as ubyte,byval desc as short=0,byref value as string="0")
''===================== globals ===========================================
dim shared as DBGCTX        ctxdbg
dim shared as long          reghandle(KREGUPPER+2)

type ASM64_REGROOM
	status as long               '' KROOMFREE, KROOMMARKED, KROOMUSED
	vreg as ASM64_SAVEDREG ptr   '' pointer to the spilled vreg
end type

dim shared as ASM64_REGROOM regroom(KREGUPPER+2)
dim shared as ASM64_CONTEXT ctx
redim shared as tdbgstr  dbgstr()
redim shared as tdbgstab dbgstab()

'' same order as FB_DATATYPE
'' Mapping dtype => stabs type tag (t*) as declared in the strings in the stabsTb()
dim shared remapTB(0 to FB_DATATYPES-1) as integer = _
{ _
7, _                                    '' void
16, _                                   '' boolean
2, _                                   '' byte
3, _                                   '' ubyte
4, _                                   '' char
5, _                                   '' short
6, _                                   '' ushort
6, _                                   '' wchar
9, _                                   '' int
10, _                                  '' uint
9, _                                   '' enum
1, _                                   '' long
8, _                                   '' ulong
9, _                                   '' longint
10, _                                   '' ulongint
11, _                                   '' single
12, _                                   '' double
13, _                                   '' string
14, _                                   '' fix-len string
17  _                                   '' va_list
}

dim shared stabsTb(0 to ...) as const zstring ptr = _
{ _
@"integer:t1=-1", _
@"void:t7=-11", _
@"byte:t2=-6", _
@"ubyte:t3=-5", _
@"char:t4=-2", _
@"short:t5=-3", _
@"ushort:t6=-7", _
@"uinteger:t8=-8", _
@"longint:t9=-31", _
@"ulongint:t10=-32", _
@"single:t11=-12", _
@"double:t12=-13", _
@"string:t13=s12data:*2,0,64;len:1,64,64;size:1,128,64;;", _
@"fixstr:t14=-2", _
@"pchar:t15=*4;", _  '' used for the data ptr in the string:t13 declaration only
@"boolean:t16=@s8;-16", _
@"va_list:t17=-11" _
}

dim shared as const zstring ptr regstrq(17)=>{@"rax",@"rbx",@"rcx",@"rdx",@"rsi",@"rdi",@"rbp",@"rsp",@"r8",@"r9",@"r10",@"r11",@"r12",@"r13",@"r14",@"r15",@"rip",@"* X_Q"}
dim shared as const zstring ptr regstrd(17)={@"eax",@"ebx",@"ecx",@"edx",@"esi",@"edi",@"ebp",@"esp",@"r8d",@"r9d",@"r10d",@"r11d",@"r12d",@"r13d",@"r14d",@"r15d",@"",@"* X_D"}
dim shared as const zstring ptr regstrw(17)={@"ax",@"bx",@"cx",@"dx",@"si",@"di",@"bp",@"sp",@"r8w",@"r9w",@"r10w",@"r11w",@"r12w",@"r13w",@"r14w",@"r15w",@"",@"* X_W"}
dim shared as const zstring ptr regstrb(17)={@"al",@"bl",@"cl",@"dl",@"sil",@"dil",@"bpl",@"spl",@"r8b",@"r9b",@"r10b",@"r11b",@"r12b",@"r13b",@"r14b",@"r15b",@"",@"* X_B"}

''priority order (can easily be changed)
dim shared as const byte reg_prio(0 to ...)={KREG_R11,KREG_R10,KREG_R8,KREG_R9,KREG_RDX,KREG_RCX,KREG_R12,KREG_R13,KREG_R14,KREG_R15,KREG_RBX,KREG_RDI,KREG_RSI}
''registers used for parameters + R10/R11 for saving
dim shared as long listreg(any)
'' ================== for optimization =========================================================
private sub check_optim(byref code as string)

	dim as string part1,part2,instruc,newcode
	static as string prevpart1,prevpart2,previnstruc
	static as long prevwpos,flag
	dim as long poschar1,poschar2,writepos
	if len(code)=0 then
		prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV ''reinit statics
		exit sub
	end if

	if flag=KUSE_JMP then
		'asm_info("jmp found="+prevpart1)
		if instr(code,prevpart1+":") then
			mid(ctx.proc_txt,prevwpos)="#O9"
		end if
		prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV ''reinit
		exit sub
	end if

	select case left(code,3)
		case "mov"
			writepos=len(ctx.proc_txt)+1
			poschar1=instr(code," ")
			instruc=left(code,poschar1-1)
			poschar2=instr(code,",")
			part1=trim(mid(code,poschar1+1,poschar2-poschar1-1))
			poschar1=instr(code,"#")
			if poschar1=0 then
				poschar1=len(code) ''Add 1 as after removing 2
			else
				poschar1-=2
			end if
			part2=trim(Mid(code,poschar2+1,poschar1-poschar2))

			''cancel mov regx, regx
			if part1=part2 then
				code="#O0"+code
				prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV
				exit sub
			end if

		case "lea"
			writepos=len(ctx.proc_txt)+1
			poschar1=instr(code," ")
			instruc=left(code,poschar1-1)
			poschar2=instr(code,",")
			part1=trim(mid(code,poschar1+1,poschar2-poschar1-1))
			poschar1=instr(code,"#")
			if poschar1=0 then
				poschar1=len(code) ''Add 1 as after removing 2
			else
				poschar1-=2
			end if
			part2=trim(Mid(code,poschar2+1,poschar1-poschar2))

			if instr(code,"   add ") then
				prevpart1="":prevpart2=""
				exit sub ''case where an add xxx is associated with lea see store for example
			end if
			flag=KUSE_LEA
			prevpart1=part1
			prevpart2=part2
			prevwpos=writepos
			exit sub

		case "jmp"
			writepos=len(ctx.proc_txt)+1
			poschar1=instr(code," ")
			instruc=left(code,poschar1-1)
			poschar2=instr(code,",")
			part1=trim(mid(code,poschar1+1,poschar2-poschar1-1))
			poschar1=instr(code,"#")
			if poschar1=0 then
				poschar1=len(code) ''Add 1 as after removing 2
			else
				poschar1-=2
			end if
			part2=trim(Mid(code,poschar2+1,poschar1-poschar2))

			if part1=prevpart1 then
				''mov r11, rax  --> #10mov r11, rax
				''jmp r11       --> #10jmp r11
				''              --> jmp rax
				mid(ctx.proc_txt,prevwpos)="#10"
				code="#10"+code+newline+string( ctx.indent*3, 32 )+"jmp "+prevpart2+" #Optim 10"
				prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV
				exit sub
			else
				prevpart1=part1
				flag=KUSE_JMP
				prevwpos=writepos
				exit sub
			end if

		case "cmp"
			if len(prevpart1) then
				if flag<>KUSE_LEA then
					writepos=len(ctx.proc_txt)+1
					poschar1=instr(code," ")
					instruc=left(code,poschar1-1)
					poschar2=instr(code,",")
					part1=trim(mid(code,poschar1+1,poschar2-poschar1-1))
					poschar1=instr(code,"#")
					if poschar1=0 then
						poschar1=len(code) ''Add 1 as after removing 2
					else
						poschar1-=2
					end if
					part2=trim(Mid(code,poschar2+1,poschar1-poschar2))

					''mov r11, rax
					''cmp r11,xx    --> cmp rax, xx
					''or
					''mov r11, xx[rbp]
					''cmp r10, r11  --> cmp r10, xx[rbp]
					if part1[0]=asc("r") then
						if part1=prevpart1 and prevpart2[0]=asc("r") then
							mid(ctx.proc_txt,prevwpos)="#13"
							code="#13"+code+newline+string( ctx.indent*3, 32 )+"cmp "+prevpart2+", "+part2+" #Optim 13"
						elseif part2=prevpart1 and instr(prevpart2,"[") then
							mid(ctx.proc_txt,prevwpos)="#14"
							code="#14"+code+newline+string( ctx.indent*3, 32 )+"cmp "+part1+", "+prevpart2+" #Optim 14"
						end if
					end if
				end if
				prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV ''reinit
			end if
			exit sub
		case else

			select case left(code,4)
				case "adds","subs","muls","divs"

					writepos=len(ctx.proc_txt)+1
					poschar1=instr(code," ")
					instruc=left(code,poschar1-1)
					poschar2=instr(code,",")
					part1=trim(mid(code,poschar1+1,poschar2-poschar1-1))
					poschar1=instr(code,"#")
					if poschar1=0 then
						poschar1=len(code) ''Add 1 as after removing 2
					else
						poschar1-=2
					end if
					part2=trim(Mid(code,poschar2+1,poschar1-poschar2))

					if prevpart1=part2 then
						if instr(prevpart2,"[r") then
							mid(ctx.proc_txt,prevwpos)="#15"
							code="#15"+code+newline+string( ctx.indent*3, 32 )+instruc+" "+part1+", "+prevpart2+" #Optim 15"
						end if
					end if
			end select
			prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV ''reinit
			exit sub
	end select

	''todo reactivate but exclude if dest not a register
	if instruc="movsxd" then prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV :exit sub
	if instruc="movsx"  then prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV :exit sub
	if instruc="movzx"  then prevpart1="":prevpart2="":previnstruc="":flag=KUSE_MOV :exit sub

	if flag=KUSE_LEA then
		if instr(part1,"["+prevpart1+"]") then
			''check register or immediate
			if part2[0]=asc("r") Or part2[0]=asc("e") or (asc(Right(part2,1))>=48 and asc(right(part2,1))<=57) then
				'asm_info("OPTIMIZATION 4 (lea)")
				'asm_info("removed =lea "+prevpart1+", "+prevpart2)
				mid(ctx.proc_txt,prevwpos)="#O4"

				'asm_info("removed ="+mov+" "+part1+", "+part2)
				newcode=instruc+" "+mid(part1,1,instr(part1,"[")-1)+prevpart2+", "+part2
				'newcode="lea "+Mid(part1,1,instr(part1,"[")-1)+prevpart2+", "+part2
				'asm_info("proposed="+newcode)

				writepos=len(ctx.proc_txt)+len(code)+9
				code="#O4"+code+newline+string( ctx.indent*3, 32 )+newcode+" #Optim 4"
			end if
		else
			if part2=prevpart1 and part1[0]=asc("r") then
				'asm_info("OPTIMIZATION 5 (lea)")
				'asm_info("removed =lea "+prevpart1+", "+prevpart2)
				mid(ctx.proc_txt,prevwpos)="#O5"

				'asm_info("removed ="+mov+" "+part1+", "+part2)
				'newcode=mov+" "+part1+", "+prevpart2
				newcode="lea "+part1+", "+prevpart2
				'asm_info("proposed="+newcode)

				writepos=len(ctx.proc_txt)+len(code)+9
				code="#O5"+code+newline+string( ctx.indent*3, 32 )+newcode+" #Optim 5"
			else
				if part1[0]=asc("r") andalso part2="["+prevpart1+"]" then
					'asm_info("OPTIMIZATION 7 (lea)")
					mid(ctx.proc_txt,prevwpos)="#O7"
					newcode=instruc+" "+part1+", "+prevpart2
					writepos=len(ctx.proc_txt)+len(code)+9
					code="#O7"+code+newline+string( ctx.indent*3, 32 )+newcode+" #Optim 7"
				else
					prevpart1=part1
					prevpart2=part2
					previnstruc=instruc
					prevwpos=writepos
					flag=KUSE_MOV
					exit sub
				end if
			end if
		end if
		prevpart1="":prevpart2=""
		flag=KUSE_MOV
		exit sub
	end if

	if part2=prevpart1 then
		if part1=prevpart2 then
			'asm_info("OPTIMIZATION 1")
			code="#O1 "+code
		else
			if prevpart2="" then ''todo remove me after fixed
				asm_error("prev/part empty "+"part1="+part1+" part2="+part2+" prevpart1="+prevpart1+" prevpart2="+prevpart2)
				asm_info("code="+code)
				asm_info("part1="+part1+" part2="+part2+" prevpart1="+prevpart1+" prevpart2="+prevpart2)
				exit sub
			end if

			''direct simple register ?
			if prevpart2[0]=asc("r") and part1[3]<>asc("d") and part1[0]<>asc("e") then
				if instr(prevpart1,"[")<>0 then
					'asm_info("OPTIMIZATION 2-1")
					''skip comment
					if part1[0]=asc("x") then
						if instruc="movss" then
							previnstruc="movd"
						else
							previnstruc="movq"
						end if
					end if
				else
					'asm_info("OPTIMIZATION 2-2")
					mid(ctx.proc_txt,prevwpos)="#O2"
					if instruc="movq" or instruc="movd" then
						previnstruc=instruc
					elseif instruc="movsx" then
						previnstruc=instruc
					end if
				end if
				writepos=len(ctx.proc_txt)+len(code)+9
				code="#O2"+code+newline+string( ctx.indent*3, 32 )+previnstruc+" "+part1+", "+prevpart2+" #Optim 2"
				part2=prevpart2
			''xmm register ?
			elseif prevpart2[0]=asc("x") then
				if instr(prevpart1,"[")<>0 then
					'asm_info("OPTIMIZATION 3-1")
					''skip comment
					if previnstruc="movss" then
						instruc="movd"
					else
						instruc="movq"
					end if
				else
					'asm_info("OPTIMIZATION 3-2")
					mid(ctx.proc_txt,prevwpos)="#O3"

					if previnstruc="movq" then
						if instr(part2,"[") then
							instruc="movsd"
						else
							instruc="movq"
						end if
					elseif previnstruc="movd" then
						if part1[0]=asc("r") or part1[0]=asc("e") then
						   instruc="movd"
						else
						   instruc="movss"
						end if
					else
						asm_error("in check_optim 3-2 instruc unknown="+instruc)
					end if
				end if
				writepos=len(ctx.proc_txt)+len(code)+9
				code="#O3"+code+newline+string( ctx.indent*3, 32 )+instruc+" "+part1+", "+prevpart2+" #Optim 3"
				part2=prevpart2
			elseif ( part1[0]=asc("r") or part1[0]=asc("e") ) and prevpart1=part2 and instr(prevpart1,"[")=0 then
				'asm_info("OPTIMIZATION 6")
				mid(ctx.proc_txt,prevwpos)="#O6"
				'asm_info("part1="+part1+" part2="+part2+" prevpart1="+prevpart1+" prevpart2="+prevpart2)
				writepos=len(ctx.proc_txt)+len(code)+9
				code="#O6"+code+newline+string( ctx.indent*3, 32 )+previnstruc+" "+part1+", "+prevpart2+" #Optim 6"
				part2=prevpart2

			elseif ( prevpart2[0]=asc("r") or prevpart2[0]=asc("e") ) and prevpart1=part2 then 'and instr(part1,"[")=0
				'asm_info("OPTIMIZATION 16")
				if instr(prevpart1,"[")=0 then
					mid(ctx.proc_txt,prevwpos)="#16"
				end if
				'asm_info("part1="+part1+" part2="+part2+" prevpart1="+prevpart1+" prevpart2="+prevpart2)
				if part1[0]=asc("x") then
					if prevpart2[0]=asc("e") then '32bit -->xmmN
						instruc="movd"
					else
						instruc="movq"
					EndIf
				End If
				writepos=len(ctx.proc_txt)+len(code)+9
				code="#16"+code+newline+string( ctx.indent*3, 32 )+instruc+" "+part1+", "+prevpart2+" #Optim 16"
				part2=prevpart2

			end if
		end if
	end if

	prevpart1=part1
	prevpart2=part2
	previnstruc=instruc
	prevwpos=writepos
end sub
private sub reg_freeable(byref lineasm as string)

	dim as long regfound1,regfound2
	dim as string instruc

	instruc=left(Trim(lineasm),3)
	if instruc="inc" orelse instruc="dec" orelse instruc="not" orelse instruc="neg" then
		''inc r11 --> not freeable / inc qword ptr [r11] --> freeable
		if instr(lineasm,"[")=0 then
			''******** CHECK marked register for callee **********************************************************
			exit sub
		end if
	else
		if instr("mov lea cmp add sub imu idiv div shl shr sar and xor or call jmp push test cvt ",instruc)=0 then exit sub
	end if

	for ireg as long =1 To KREGUPPER
		if reghandle(ireg)=KREGRSVD then continue for ''excluding rbp and rsp
		regfound1=KNOTFOUND:regfound2=KNOTFOUND

		if instr(lineasm,*regstrq(ireg)+",") then
			regfound1=ireg
		elseif instr(lineasm,*regstrd(ireg)+",") then
			regfound1=ireg
		elseif instr(lineasm,*regstrw(ireg)+",") then
			regfound1=ireg
		elseif instr(lineasm,*regstrb(ireg)+",") then
			regfound1=ireg
		end if

		if regfound1<>KNOTFOUND then
			if instruc="add" orelse instruc="sub" orelse instruc="imu" then
				''already inuse and to be used later case 'add r11, xxx'  not 'add qword ptr [r11], xxx'
				continue for
			elseif instruc="cmp" then
				''already inuse but not to be used later except one case (at least) when null-pointer checking
				ctx.jmpreg=regfound1 ''see their defines
				ctx.jmpvreg=reghandle(regfound1)
				ctx.jmppass=2
				reghandle(regfound1)=KREGFREE
				continue for
			else
				if instr(lineasm,*regstrq(ireg)+", "+*regstrq(ireg)) then
					''case mov rzz, rzz in hdocall
					reghandle(regfound1)=KREGFREE
					exit sub
				end if
			end if
		end if

		if regfound1=KNOTFOUND then
			if instr(lineasm,*regstrq(ireg)) then
				regfound2=ireg
			elseif instr(lineasm,*regstrd(ireg)) then
				regfound2=ireg
			elseif instr(lineasm,*regstrw(ireg)) then
				regfound2=ireg
			elseif instr(lineasm,*regstrb(ireg)) then
				regfound2=ireg
			end if
		end if

		if regfound2<>KNOTFOUND then
			reghandle(regfound2)=KREGFREE
		end if
	next
end sub
''============== end of optim ====================================================
private function pw2(byval num as integer)as integer ''return the first power of 2 greater than a number ex 24 -->32
	dim as double a=log(num)/log(2)
	if frac(a)=0 then
		return 2^a
	else
		return 2^(int(a)+1)
	end if
end function
private sub asm_section(byref section as string)
	static section_current as string
	if section_current<>section then
		asm_code(".section "+section)
		section_current=section
	end if
end sub
private sub emitop3_op4(byref op as string)
	if right(op,3)="#NO" then
		asm_code(op,KNOOPTIM)
	else
		asm_code(op)
	end if
end sub
sub dbg_filename(byref filename as string)
	if filename <> ctxdbg.prevfilename then
		dbg_addstab(filename,STAB_TYPE_SOL )
		ctxdbg.prevfilename = filename
	end if
end sub
private sub hwriteasm64( byref ln2 as string,byval opt as integer=KDOALL)
dim as string ln,lname
#ifdef __GAS64_DEBUG__
	if ln2[0]=asc("#") then
		ln="           "+ln2
	else
#endif
		ln=ln2
		if ctx.opereg then
			if ctx.opepass=1 then
				ctx.opepass=2
			else
				ctx.opereg=0
			end if
		end if

		if ctx.jmppass then
			ctx.jmppass-=1
			if ctx.jmppass=0 then
				ctx.jmpvreg=KREGFREE
			end if
		end if

		if( env.clopt.debuginfo = true ) then
			if ctxdbg.lnum<>-1 then
				dbg_filename(ctxdbg.linefilename)
				lname = *symbUniqueLabel( )
				dbg_addstab(,STAB_TYPE_SLINE ,ctxdbg.lnum,lname+"-"+*symbGetMangledName( ctxdbg.proc ))
				ctxdbg.lnum=-1
				asm_code(lname+":")
			end if
		end if

		if opt<>KNOFREE and opt<>KNOALL then reg_freeable(ln)
		if opt=KNOOPTIM or opt=KNOALL then
			''just reinit some variables
			check_optim("")
		else
			check_optim(ln)
		end if
		ln = string( ctx.indent*3, 32 ) + ln
#ifdef __GAS64_DEBUG__
	end if
#endif
	''print ln ''used to display every line when compiler crashes....
	ln += NEWLINE

	'' Write it out to the current section
	select case as const( ctx.section )
		''body of procedure
		case SECTION_PROC
			ctx.proc_txt +=ln
		case SECTION_PROLOG
			ctx.prolog_txt += ln
		case SECTION_EPILOG
			ctx.epilog_txt += ln
		case SECTION_HEAD
			ctx.head_txt += ln
		case SECTION_FOOT
			ctx.foot_txt += ln
		case else
			''to avoid the lost of information if a section is not already selected
			ctx.head_txt += ln
	end select

end sub
private function hfloattohex_asm64(byval value as double,byval dtype as Integer,ByVal full as Byte=1) as string

	'' Emit the raw bytes that make up the float / x86 little-endian assumption
	dim as string rawbytes
	dim as single singlevalue = value

	if( typeGet( dtype ) = FB_DATATYPE_DOUBLE ) then
		rawbytes="0x"+hex( *cptr( ulongint ptr, @value ), 16 )+" # DBL="+str(value)
		if full then
			return ".quad " + rawbytes
		else
			return rawbytes
		end if
	else
		rawbytes="0x"+Hex( cuint( *cptr( ulong ptr, @singlevalue ) ), 8 )+" # SNG="+str(value)
		if full then
			return ".long " + rawbytes
		else
			return rawbytes
		end if
	end if
end function
''======================= for writing debug data ==========================================
private function dbg_addstr(byref strg as string,byval nosearch as integer =1) as integer

	if nosearch=0 then
		for istr as integer = 0 to ctxdbg.strnb
			if strg=dbgstr(istr).txt then
				return dbgstr(istr).offst
			end if
		next
	end if
	ctxdbg.strnb+=1
	if ctxdbg.strnb>ctxdbg.strmax then
		ctxdbg.strmax*=1.3
		redim preserve dbgstr(ctxdbg.strmax)
	end if
	dbgstr(ctxdbg.strnb).txt=strg
	dbgstr(ctxdbg.strnb).offst=ctxdbg.offst
	function=ctxdbg.offst
	ctxdbg.offst+=len(strg)+1
end function
private sub dbg_addstab(byref txt as string="",byval cod as ubyte,byval desc as short=0,byref value as string="0")
	dim as longint offst
	dim as ustab stab
	if txt <>"" then
		if cod=STAB_TYPE_SO or cod=STAB_TYPE_SOL then ''could be duplicated
			offst=dbg_addstr(txt,0)
		else
			offst=dbg_addstr(txt)
		end if
	end if
	ctxdbg.stabnb+=1
	if ctxdbg.stabnb>ctxdbg.stabmax then
		ctxdbg.stabmax*=1.5
		redim preserve dbgstab(ctxdbg.stabmax)
	end if
	stab.offst=offst
	stab.cod=cod
	stab.desc=desc
	dbgstab(ctxdbg.stabnb).stab=stab.full
	dbgstab(ctxdbg.stabnb).value=value
end sub
private sub dbg_emitstr()
	if ctx.systemv then
		asm_section(".dbgstr,""a""")
	else
		asm_section(".dbgstr,""dr""")
	end if
	asm_code(".byte 0")
	for istr as integer = 0 to ctxdbg.strnb
		asm_code(".ascii """+hReplace( dbgstr(istr).txt, "\", $"\\" )+$"\0""")
	next
end sub
private sub dbg_emitstab()
	dim as ustab stab
	if ctx.systemv then
		asm_section(".dbgdat,""a""")
	else
		asm_section(".dbgdat,""dr""")
	end if

	for istab as integer = 0 to ctxdbg.stabnb
		stab.full=dbgstab(istab).stab
		asm_code(".quad 0x"+hex(dbgstab(istab).stab)+" # "+str(stab.cod)+" "+str(stab.desc)+" "+str(stab.offst))
		asm_code(".quad "+dbgstab(istab).value)
	next
end sub
private sub edbgemitheader_asm64( byval filename as zstring ptr )
	dim as string lname

	ctxdbg.typecnt  = 1
	ctxdbg.strnb=-1
	ctxdbg.strmax=1000
	redim dbgstr(ctxdbg.strmax)
	ctxdbg.stabnb=-1
	ctxdbg.stabmax=1000
	redim dbgstab(ctxdbg.stabmax)
	ctxdbg.offst=1
	ctxdbg.lnum=-1

	'' emit source file name
	asm_code( ".file " + QUOTE + *hEscape( filename ) + QUOTE)
	lname = *symbUniqueLabel( )

	''Must always be the first stabs as skipped when loading debug data
	dbg_addstab ("DUMMY",0)

	''placeholder for information like compiler version, etc
	dbg_addstab (FB_SIGN,255)

	'' directory
	if( pathIsAbsolute( filename ) = FALSE ) then
		dbg_addstab (hCurDir( )+ FB_HOST_PATHDIV,STAB_TYPE_SO,,lname)
	end if

	'' file name
	dbg_addstab(*filename,STAB_TYPE_SO,,lname)
	asm_code(lname+":")

	'' (known) type definitions
	for i as integer = lbound( stabsTb ) to ubound( stabsTb )
		dim as string strg=*stabsTb(i) ''to be removed as useless ?
		dbg_addstab(strg,STAB_TYPE_LSYM)
		ctxdbg.typecnt += 1
	next

end sub
private sub edbgemitglobalvar_asm64 _
	( _
	byval sym as FBSYMBOL ptr, _
	byval section as integer _
	)
	dim as integer t = any, attrib = any
	dim as string desc

	'' Ignore static locals here (they are handled like other locals during
	'' edbgEmitProcFooter() -> hDeclLocalVars())
	if( symbIsLocal( sym ) ) then
		exit sub
	end if

	'' depends on section
	select case section
		case IR_SECTION_CONST
			t = STAB_TYPE_FUN
		case IR_SECTION_BSS
			t = STAB_TYPE_LCSYM
		case else
			assert( section = IR_SECTION_DATA )
			t = STAB_TYPE_STSYM
	end select

	desc = *symbGetDBGName( sym )

	'' allocation type (static, global, etc)
	if( symbIsPublic( sym ) or symbIsCommon( sym ) ) then
		desc += ":G"
	elseif( symbIsStatic( sym ) ) then
		desc += ":S"
	else
		desc += ":"
	end if

	'' data type
	desc += hGetDataType_asm64( sym )
	dbg_addstab(desc,t,,*symbGetMangledName( sym ))

end sub

private sub edbgemitlocalvar_asm64 _
	( _
	byval sym as FBSYMBOL ptr, _
	byval isstatic as integer _
	)

	dim as integer t = any
	dim as string desc, value

	desc = *symbGetName( sym )

	'' (no fake dynamic array symbols - the descriptor is emitted instead)
	assert( symbIsDynamic( sym ) = FALSE )

	if( isstatic ) then
		'' never referenced?
		if( symbGetIsAccessed( sym ) = FALSE ) then
			'' locals can't be public, don't check
			exit sub
		end if

		if( symbGetTypeIniTree( sym ) ) then
			t = STAB_TYPE_STSYM
		else
			t = STAB_TYPE_LCSYM
		end if
		desc += ":V"

		value = *symbGetMangledName( sym )
	else
		t = STAB_TYPE_LSYM
		desc += ":"
		value = str( symbGetOfs( sym ) )
	end if

	'' data type
	desc += hGetDataType_asm64( sym )
	dbg_addstab(desc,t,,value)

end sub
private sub edbgemitprocheader_asm64 _
	( _
	byval proc as FBSYMBOL ptr _
	) static

	dim as string desc, procname
	static as string filename
	filename=env.inf.name

	#if defined( __FB_WIN32__ )
		filename=ucase(filename)
	#endif
	dbg_filename(filename)

	'' main?
	if( symbGetIsMainProc( proc ) ) then
		'' main proc (the entry point)
		dbg_addstab(fbGetEntryPoint( ),STAB_TYPE_MAIN,1,*symbGetMangledName( proc ))
		'' set the entry line
		''not usefull  ??  hEmitSTABD( STAB_TYPE_SLINE, 0, 1 )

		'' also correct the end and start lines
		proc->proc.ext->dbg.iniline = 1
		proc->proc.ext->dbg.endline = lexLineNum( )

		desc = fbGetEntryPoint( )
	else
		desc = *symbGetDBGName( proc )
	end if

	''
	procname = *symbGetMangledName( proc )
	ctxdbg.proc=proc
	if( symbIsPublic( proc ) ) then
		desc += ":F"
	else
		desc += ":f"
	end if

	desc += hGetDataType_asm64( proc )
	dbg_addstab(desc,STAB_TYPE_FUN,proc->proc.ext->dbg.iniline,procname)
	dbg_addstab(,STAB_TYPE_SLINE,1)
end sub
private sub edbgemitprocarg_asm64( byval sym as FBSYMBOL ptr )
	dim as string desc

	desc = *symbGetName( sym ) + ":"

	if( symbIsParamVarByVal( sym ) ) then
		desc += "p"
	else
		desc += "v"
	end if

	'' data type
	desc += hGetDataType_asm64( sym )
	dbg_addstab(desc,STAB_TYPE_PSYM,,str( symbGetOfs( sym )))

end sub
private function hdeclpointer_asm64 _
	( _
	byref dtype as integer _
	) as string static

	dim as string desc

	desc = ""
	do while( typeIsPtr( dtype ) )
		dtype = typeDeref( dtype )
		desc += str( ctxdbg.typecnt ) + "=*"
		ctxdbg.typecnt += 1
	loop

	function = desc

end function
private sub hdecludt_asm64 _
	( _
	byval sym as FBSYMBOL ptr, _
	byval dimtbelements as integer _
	)

	dim as FBSYMBOL ptr fld = any
	dim as string desc

	assert( symbIsStruct( sym ) )

	sym->udt.dbg.typenum = ctxdbg.typecnt
	ctxdbg.typecnt += 1

	desc = *symbGetDBGName( sym )

	desc += ":Tt" + str( sym->udt.dbg.typenum ) + "=s" + str( symbGetlen( sym ) )

	fld = symbUdtGetFirstField( sym )
	while( fld )

		'' Skip fake dynamic array fields, only the descriptor is emitted
		if( symbIsDynamic( fld ) = FALSE ) then
			desc += *symbGetName( fld ) + ":" + hGetDataType_asm64( fld, dimtbelements )
			desc += "," + str( symbGetFieldBitOffset( fld ) )
			desc += "," + str( symbGetFieldBitLength( fld ) )
			desc += ";"
		end if

		fld = symbUdtGetnextField( fld )
	Wend

	desc += ";"
	dbg_addstab(desc,STAB_TYPE_LSYM)

end sub

private sub hdeclenum_asm64 _
	( _
	byval sym as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr e
	dim as string desc

	sym->enum_.dbg.typenum = ctxdbg.typecnt
	ctxdbg.typecnt += 1

	desc = *symbGetDBGName( sym )

	desc += ":T" + str( sym->enum_.dbg.typenum ) + "=e"

	e = symbGetENUMFirstElm( sym )
	do while( e <> NULL )
		desc += *symbGetName( e ) + ":" + str( symbGetConstInt( e ) ) + ","

		e = symbGetENUMnextElm( e )
	loop

	desc += ";"
	dbg_addstab(desc,STAB_TYPE_LSYM)

end sub
private function hgetdatatype_asm64 _
	( _
	byval sym as FBSYMBOL ptr, _
	byval requesteddimtbelements as integer _
	) as string

	dim as integer dtype = any, dimtbelements = any
	dim as FBSYMBOL ptr subtype = any
	dim as string desc

	if( sym = NULL ) then
		return str( remapTB(FB_DATATYPE_VOID) )
	end if

	''
	'' HACK: When emitting array descriptor types, we don't always emit the
	'' whole FBARRAYdim dimTB, but only the actually used dimensions.
	''
	'' This makes a difference (only) for arrays declared with unknown
	'' dimension count (array()), where the descriptor will have room for
	'' FB_MAXARRAYDIMS dimensions but not necessarily all of that are
	'' actually used.
	''
	'' However, we still emit the descriptor's full length in bytes - it's
	'' just that the memory at the end won't be visible as fields when
	'' inspecting with the debugger, just like padding bytes. Basically the
	'' whole unused part of the dimTB will be treated as padding, which is
	'' what it basically is, anyways.
	''
	dimtbelements = 0

	'' Shouldn't be a dynamic array - only the descriptor is emitted
	assert( symbIsDynamic( sym ) = FALSE )

	if( symbIsParamVarBydesc( sym ) ) then
		'' Bydesc parameter, need to emit as the real descriptor type
		'' (it's really a pointer/ref, but that's already handled by edbgEmitProcArg())
		dtype = FB_DATATYPE_STRUCT
		subtype = sym->var_.array.desctype
		dimtbelements = symbGetArrayDimensions( sym )
	else
		dtype = symbGetType( sym )
		subtype = symbGetSubtype( sym )

		'' TODO: handle byref functions?

		if( symbIsVar( sym ) or symbIsField( sym ) ) then
			'' Looks like reference vars need to be emitted as pointers;
			'' at least that's how g++ -gstabs seems to do it, and the gdb docs
			'' don't mention any way to encode references in STABS.
			'' Byref parameters on the other hand have a special "v" prefix,
			'' this is handled in edbgEmitProcArg().
			if( symbIsRef( sym ) ) then
				assert( symbIsParamVar( sym ) = FALSE )
				dtype = typeAddrOf( dtype )
			end if

			'' Fixed-size array?
			if( symbGetArrayDimensions( sym ) > 0 ) then
				desc += str( ctxdbg.typecnt ) + "="
				ctxdbg.typecnt += 1

				'' Normally we want to emit all fixed-size arrays with
				'' their proper dimensions & bounds - the only exception
				'' is the one-dimensional dimTB in array descriptor
				'' types (also see the above HACK).
				if( requesteddimtbelements > 0 ) then
					assert( symbGetArrayDimensions( sym ) = 1 )
					desc += "ar1;"
					desc += "0;"
					desc += str( requesteddimtbelements - 1 ) + ";"
				else
					for i as integer = 0 to symbGetArrayDimensions( sym ) - 1
						desc += "ar1;"
						desc += str( symbArrayLbound( sym, i ) ) + ";"
						desc += str( symbArrayUbound( sym, i ) ) + ";"
					next
				end if
			end if
			if( symbIsDescriptor( sym ) ) then
				dimtbelements = symbGetArrayDimensions( sym->var_.desc.array )
			end if
		end if
	end if

	'' if array dimensions still unknown, assume 1
	if( dimtbelements < 0 ) then
		dimtbelements = 1
	end if

	'' pointer?
	if( typeIsPtr( dtype ) ) then
		desc += hDeclPointer_asm64( dtype )
	end if

	'' the const qualifier isn't taken into account
	dtype = typeUnsetIsConst( dtype )

	select case as const dtype
		'' UDT?
		case FB_DATATYPE_STRUCT
			''to be checked hGetDataType_asm64 with direct subtype and not sym....
			if subtype then
				if( subtype->udt.dbg.typenum = INVALID ) then hDeclUDT_asm64( subtype, dimtbelements )
				desc += str( subtype->udt.dbg.typenum )
			else
				If( sym->udt.dbg.typenum = INVALID )     then hDeclUDT_asm64( sym, dimtbelements )
				desc += str( sym->udt.dbg.typenum )
			end if
			'' ENUM?
		case FB_DATATYPE_ENUM
			if( subtype->enum_.dbg.typenum = INVALID ) then
				hDeclENUM_asm64( subtype )
			end if

			desc += str( subtype->enum_.dbg.typenum )

			'' function pointer?
		case FB_DATATYPE_FUNCTION
			desc += str( ctxdbg.typecnt ) + "=f"
			ctxdbg.typecnt += 1
			desc += hGetDataType_asm64( subtype )

			'' forward reference?
		case FB_DATATYPE_FWDREF
			desc += str( remapTB(FB_DATATYPE_VOID) )

			'' ordinary type..
		case else
			desc += str( remapTB(dtype) )

	end select

	function = desc

end function
private sub _emitdbg(byval op as integer,byval proc as FBSYMBOL ptr,byval lnum as Integer,byval filename as zstring Ptr)

	if( op = AST_OP_DBG_LINEINI ) then
		ctxdbg.linefilename=*filename
		ctxdbg.lnum=lnum
	else
	if( op = AST_OP_DBG_LINEEND ) then
			''asm_info("AST_OP_DBG_LINEEND for line="+Str(lnum))
		elseif op=AST_OP_DBG_SCOPEINI then
		elseif op=AST_OP_DBG_SCOPEEND then
		else
			asm_error("Other emitdbg not handled="+Str(op)+"for ref AST_OP_DBG_LINEEND="+ Str(AST_OP_DBG_LINEEND) )
		end if
	end if

end sub
''================= end of proc for debugging =====================
#ifdef __GAS64_DEBUG__
private function vregdumpfull( byval v as IRVREG ptr ) as string
	return vregDumpToStr(v)+iif(v<>0," symbdump="+symbdumpToStr(v->sym),"")
end function
private function vregpretty( byval v as IRVREG ptr ) as string
	dim s as string
	select case( v->typ )
		case IR_VREGTYPE_IMM
			if( typeGetClass( v->dtype ) = FB_DATACLASS_FPOINT ) then
				s = str( v->value.f )
			else
				s = str( v->value.i )
			end if

		case IR_VREGTYPE_REG
			if( v->sym ) then
				s = *symbGetMangledName( v->sym )
			else
				s = "vr" & v->reg
			end if

		case else
			if( v->sym ) then
				s = *symbGetMangledName( v->sym )
			end if
	end select

	if( v->vidx ) then
		if( len( s ) > 0 ) then
			s += "+"
		end if
		s += vregPretty( v->vidx )
	end if
	if( v->ofs ) then
		s += "+" & v->ofs
	end if
	if( v->mult ) then
		s += " (mult) *" & v->mult
	end if

	s += " " + typedumpToStr( v->dtype, v->subtype )

	function = s
end function
#endif
''=======================================
'' if branch (test) marks registers inuse
''=======================================
private sub reg_mark(byval labelptr as FBSYMBOL ptr)
	dim as boolean flagmark=false
	asm_info("new branch ? "+*symbGetMangledName( labelptr ))
	for ireg as integer= 1 to KREGUPPER
		if reghandle(ireg)<>KREGFREE and reghandle(ireg)<>KREGRSVD then ''excluding also rbp and rsp
			regroom(ireg).status=KROOMMARKED
			flagmark=true
		end if
	next
	if flagmark then ctx.labelbranch2=labelptr
end sub

''===========================
''spilling registers on stack
''===========================
private function asm64_spillREG( byval regspilled as long ) as ASM64_SAVEDREG ptr

	dim as ASM64_SAVEDREG ptr v = any

	'' re-use an existing location?
	if( ctx.vreg_count > 0 ) then
		v = flistGetHead( @ctx.spillvregs )
		while( v <> NULL )
			if( v->sdvreg = KREGFREE ) then
				'' keep previous id
				'' keep previous sdoffset
				v->sdvreg = reghandle(regspilled)
				return v
			end if
			v = flistGetNext( v )
		wend
	end if

	'' store the spilled register to a new location
	ctx.stk+=8
	asm_info("stk20="+Str(ctx.stk))
	if ctx.stkspil<>0 then
		if ctx.stk=ctx.stkspil then
			''should not happen
			asm_error("Spilling overflow when proc calling")
		end if
	end if

	'' allocate a new item on the spilled vregs list
	v = flistNewItem( @ctx.spillvregs )

	'' unique id is per procedure and is reset at the end of each proc
	ctx.vreg_count += 1
	v->id = ctx.vreg_count

	'' store location and vreg spilled,
	v->sdoffset = -ctx.stk
	v->sdvreg = reghandle(regspilled)

	return v

end function


private sub reg_spilling(byval regspilled as long)

	dim as ASM64_SAVEDREG ptr v = asm64_spillREG( regspilled )
	assert( v )

	''store register
	asm_info("spilled register="+*regstrq(regspilled)+" saved vreg="+str(reghandle(regspilled))+" room="+str(v->id))
	asm_code("mov QWORD PTR "+str(v->sdoffset)+"[rbp], "+*regstrq(regspilled))
	reghandle(regspilled)=KREGFREE

	''need to keep a trace when handling second branch
	if( regroom(regspilled).status = KROOMMARKED ) then
		regroom(regspilled).vreg = v
		regroom(regspilled).status = KROOMUSED
	end if

	''track inside branch to restore registers later
	asm_info("spilled register spilbranch1 " & cbool(v->spilbranch1) )
	v->spilbranch1 = iif(ctx.labelbranch2,true,false)

end sub
''==============================================
''save calling registers before function calls
''==============================================
private sub reg_save
	for ireg as integer =1 to ubound(listreg)
		if reghandle(listreg(ireg))<>KREGFREE then
			reg_spilling(listreg(ireg))
		end if
	next
end sub
''====================================================
'' prevent the use of registers used as parameters
''====================================================
private sub reg_allowed(byval allowed as boolean)
	if allowed=false then
		''don't allow other registers used as parameters
		for ireg as integer =1 to ubound(listreg)-2
			if reghandle(listreg(ireg))=KREGFREE then
				reghandle(listreg(ireg))=KREGLOCK
			end if
		next
	else
		''allow again registers
		for ireg as integer =1 to ubound(listreg)-2
			if reghandle(listreg(ireg))=KREGLOCK then
				reghandle(listreg(ireg))=KREGFREE
			end if
		next
	end if
end sub
''===================================================
''searching a free reg if none available spilling one
''===================================================
private function reg_findfree(byval vreg as long,byval regparam as integer=-1) as long
	dim as long regfree=-1,numroom
	static as long regspill=-1

	''to avoid registers potentially used as param
	if ctx.proccalling then reg_allowed(false)

	for ireg as long =0 to ubound(reg_prio)
		if reghandle(reg_prio(ireg))=KREGFREE then regfree=reg_prio(ireg):exit for
	next

	if regfree=-1 then
		''take in the priority list
		if regparam=-1 then
			regspill+=1
			if regspill=6 then regspill=0
			''avoid spilling a param register
			while reghandle(regspill)=KREGLOCK
				regspill+=1
				if regspill=6 then regspill=0
			wend

			regfree=reg_prio(regspill)
		else
			''just spilling the register used for parameter but not free
			regfree=regparam
		end if
		asm_info("no free register so spilling one for vreg="+str(vreg))
		reg_spilling(regfree)
	end if
	if regparam<>regfree then
		reghandle(regfree)=vreg
		ctx.usedreg Or=(1 Shl regfree) ''used register
		asm_info("free register found="+*regstrq(regfree)+" vreg="+str(reghandle(regfree)))
	end if

	if ctx.proccalling then reg_allowed(true)

	return regfree
end function
''=====================================================================
'' in case of callptr avoid potential register used as parameter
'' eg op1=-1520[rdx] --> op1=-1520[r11] and 'mov r11, rdx'

'' note : it swaps all the POTENTIAL registers not only those laterly used
'' op1=-1520[r8] --> op1=-1520[r11] and 'mov r11, r8'  even if r8 will be not be used as parameter
''=====================================================================
private sub reg_callptr(byref op1 as string,byref op3 as string)
	dim as long regfree
	dim as integer p
	for ireg as integer = 1 to ubound(listreg)-2
		p=instr(op1,*regstrq(listreg(ireg)))
		if p=0 then continue for
		asm_info("Transfering value for freeing register / case callptr")
		regfree=reg_findfree(reghandle(listreg(ireg)))
		''transfering so it can be used for storing the parameter
		asm_code("mov "+*regstrq(regfree)+", "+*regstrq(listreg(ireg)),KNOOPTIM)
		reghandle(listreg(ireg))=KREGLOCK
		''replace in the string the previous register by the new one
		if len(*regstrq(regfree))=len(*regstrq(listreg(ireg))) then
			mid(op1,p)=*regstrq(regfree)
		else
			''case r8/r9 as other registers have a size of 3 characters
			op1=left(op1,p-1)+*regstrq(regfree)+mid(op1,p+2)
		end if
	next
	if op3<>"" then
		for ireg as integer = 1 to ubound(listreg)-2
			p=instr(op3,*regstrq(listreg(ireg)))
			if p=0 then continue for
			asm_info("Transfering value for freeing register / case callptr")
			regfree=reg_findfree(reghandle(listreg(ireg)))
			''transfering so it can be used for storing the parameter
			asm_code("mov "+*regstrq(regfree)+", "+*regstrq(listreg(ireg)),KNOOPTIM)
			reghandle(listreg(ireg))=KREGLOCK
			''replace in the string the previous register by the new one
			if len(*regstrq(regfree))=len(*regstrq(listreg(ireg))) then
				mid(op3,p)=*regstrq(regfree)
			else
				op3=left(op3,p-1)+*regstrq(regfree)+mid(op3,p+2)
			end if

		next
	end if

end sub
''=======================================================================
'' if begin of branch 2 spills registers as done in branch 1
'' if end of branch 2   restores spilled register not spilled in branch 1
''=======================================================================
private sub reg_branch(byval label as FBSYMBOL ptr )
	dim as integer regfree
	if label=ctx.labelbranch2 then
		''reaching the second branch
		'''''''ctx.labelbranch2=0
		asm_code(*symbGetMangledName( label )+":")
		''handling second branch after first one so spilling registers
		for ireg as integer = 1 to KREGUPPER
			if( regroom(ireg).status = KROOMUSED ) then
				''put in memory as in the branch 1
				asm_info("spilling register to mimic branch1="+*regstrq(ireg)+" already saved vreg="+str(regroom(ireg).vreg->id)+" from room="+str(regroom(ireg).vreg->id))
				asm_code("mov QWORD PTR "+str(regroom(ireg).vreg->sdoffset)+"[rbp], "+*regstrq(ireg))
				reghandle(ireg)=KREGFREE
				''marked to avoid an eventual restoring
				regroom(ireg).vreg->spilbranch1 = false
			end if
			''reset by default even if only one branch as regroom() could be = KROOMMARKED
			regroom(ireg).status=KROOMFREE
			regroom(ireg).vreg = NULL
		next
		if ctx.labeljump=0 then
			''not a double branch so no need to do spilling below
			ctx.labelbranch2=0
		end if
	elseif label=ctx.labeljump then
		if( ctx.vreg_count > 0 ) then
			''restoring registers spilled in the second branch
			dim v as ASM64_SAVEDREG ptr = any
			v = flistGetHead( @ctx.spillvregs )
			while( v <> NULL )
				if( v->spilbranch1 ) then
					regfree=reg_findfree(v->sdvreg)
					asm_info("SPILBRANCH1 restoring saved vreg="+str(v->id)+" in register="+*regstrq(regfree))
					v->sdvreg = KREGFREE
					asm_code("mov "+*regstrq(regfree)+", QWORD PTR "+str(v->sdoffset)+"[rbp]")
				end if
				v = flistGetNext( v )
			wend
		end if
		ctx.labeljump=0
		ctx.labelbranch2=0
		asm_code(*symbGetMangledName( label )+":")
	end if
end sub
function reg_findreal(byval vreg as long) as long
	dim as long realreg
	for ireg as long =0 To KREGUPPER
		if reghandle(ireg)=vreg then
			asm_info("virtual register ="+Str(vreg)+" real register="+*regstrq(ireg))
			return ireg
		end if
	next
	''searching in spilled register list
	'asm_info("virtual register not found extend to spilled register list")

	dim v as ASM64_SAVEDREG ptr = NULL
	if( ctx.vreg_count > 0 ) then
		v = flistGetHead( @ctx.spillvregs )
		while( v <> NULL )
			'asm_info("iroom="+str(v->id)+" "+str(v->sdvreg)+" "+str(vreg))
			if( v->sdvreg=vreg ) then
				exit while
			end if
			v = flistGetNext( v )
		wend
	end if
	if( v = NULL ) then
		''very annoying not found also in the list
		asm_error("virtual register="+Str(vreg)+" no real register corresponding, using KREG_XXX")
		return KREG_XXX
	end if
	''found so restoring in an available register
	realreg=reg_findfree(vreg)
	''restore the register value
	asm_info("virtual register not found extend to spilled register list="+str(vreg)+" "+str(v->id))
	asm_code("mov "+*regstrq(realreg)+", QWORD PTR "+str(v->sdoffset)+"[rbp]")
	v->sdvreg=KREGFREE
	return realreg
end function
''======================================
''return a register used temporary
''======================================
function reg_tempo() as const ZString Ptr
	dim as long reg
	static as long counter=9999999
	counter+=1
	reg=reg_findfree(counter)
	return regstrq(reg)
end function
''=====================================================================
'' transfer in another register if already in use (parameter register)
''=====================================================================
private sub reg_transfer(byval regtrans as long,byval regsource as long)
	dim as long regfree
	''not used or already transfered in reg_callptr so nothing to do
	if reghandle(regtrans)=KREGFREE or reghandle(regtrans)=KREGLOCK then exit sub
	''used in source of parameter
	if regtrans=regsource then
		''freeing the register
		asm_info("in reg_transfer release regtrans="+*regstrq(regtrans))
		reghandle(regtrans)=KREGFREE
		exit sub
	end if

	''find a free register for transfering or just spilling if no free register (returning same register)
	asm_info("Transfering register in other register otherwise spilling")
	regfree=reg_findfree(reghandle(regtrans),regtrans)
	if regfree<>regtrans then
		''transfering so it can be used for storing the parameter
		asm_code("mov "+*regstrq(regfree)+", "+*regstrq(regtrans),KNOOPTIM)
	else
		asm_info("register has been spilled")
	end if

end sub
''==============================================
'' MEMCLEAR size should be known at compile time
''==============================================
private sub memclear(byval bytestoclear as Integer,byref dst as string,byval dtyp as long=KUSE_MOV)

	dim as uinteger nbbytes=CUnsg(bytestoclear),nooptim
	dim as string lname,regdst
	dim as long nb8,rdst

	if instr("rcx rdx rbx rdi rsi r8 r9 r10 r11 r12 r13 r14 r15",dst) then
		regdst=dst
	else
		rdst=reg_findfree(999997)
		regdst=*regstrq(rdst)
		if dtyp=KUSE_LEA then
			asm_code("lea "+regdst+", "+dst)
		else
			asm_code("mov "+regdst+", "+dst) ''always mov ???
		end if
		reghandle(rdst)=KREGFREE ''can be reset here as limited use
	end if

	if nbbytes<>1 and nbbytes<>2 and nbbytes<>4 and nbbytes<>8 then
		nooptim=KNOOPTIM
	else
		nooptim=KDOALL
	end if

	if nbbytes>7 then  ''clear by 8 bytes step
		nb8=nbbytes\8
		if nb8>7 then ''more than 7 times 64+
			asm_code("mov rax, "+Str(nb8))
			lname=*symbUniqueLabel( )
			asm_code(lname+":")
			asm_code("mov QWORD PTR ["+regdst+"], 0")
			asm_code("add "+regdst+", 8")
			asm_code("dec rax")
			asm_code("jnz "+lname)
			nbbytes-=nb8*8
		else
			for inb8 as long = 0 To nb8-1
				asm_code("mov QWORD PTR "+Str(inb8*8)+"["+regdst+"], 0",nooptim)
			next
			nbbytes-=nb8*8
			if nbbytes<>0 then
				asm_code("add "+regdst+", "+str(nb8*8))
			end if
		end if
	end if
	if nbbytes>3 then
		''clear 7/6/5/4 bytes
		asm_code("mov dword ptr ["+regdst+"], 0",nooptim)
		nbbytes-=4
		if nbbytes>1 then
			asm_code("mov word ptr 4["+regdst+"], 0",nooptim)
			nbbytes-=2
			if nbbytes>0 then
				asm_code("mov byte ptr 6["+regdst+"], 0",nooptim)
			end if
		elseif nbbytes>0 then
			asm_code("mov byte ptr 4["+regdst+"], 0",nooptim)
		end if
	elseif nbbytes>1 then
		''clear 2/3 bytes
		asm_code("mov word ptr ["+regdst+"], 0",nooptim)
		nbbytes-=2
		if nbbytes>0 then
			asm_code("mov byte ptr 2["+regdst+"], 0",nooptim)
		end if
	elseif nbbytes>0 then
		 ''clear 1 byte
		asm_code("mov byte ptr ["+regdst+"], 0")
	end if
end sub
''=============================================
'' MEMCOPY size should be known at compile time
''=============================================
private sub memcopy(byval bytestoclear as Integer,byref src as string, byref dst as string,byval styp as long=KUSE_MOV,byval dtyp as long=KUSE_MOV)

	dim as uinteger nbbytes=CUnsg(bytestoclear)
	dim as string lname,regsrc,regdst,regnbb
	dim as long nb8,rsrc,rdst,rnbb

	if( bytestoclear = 0 ) then
		exit sub
	end if
	asm_info("memcopy="+src+" "+dst)
	if instr("rcx rdx rbx rdi rsi r8 r9 r10 r11 r12 r13 r14 r15",src) then
		regsrc=src
	else
		rsrc=reg_findfree(999998)
		regsrc=*regstrq(rsrc)
		if styp=KUSE_LEA then
			asm_code("lea "+regsrc+", "+src)
		else
			asm_code("mov "+regsrc+", "+src)
		end if
	end if

	if instr("rcx rdx rbx rdi rsi r8 r9 r10 r11 r12 r13 r14 r15",dst) then
		regdst=dst
	else
		rdst=reg_findfree(999997)
		regdst=*regstrq(rdst)
		if dtyp=KUSE_LEA then
			asm_code("lea "+regdst+", "+dst)
		else
			asm_code("mov "+regdst+", "+dst)
		end if
	end if

	nb8=nbbytes\8

	''copy by 8 bytes step
	if nb8>7 then ''greater than 7 times * 8 bytes
		rnbb=reg_findfree(999996)
		regnbb=*regstrq(rnbb)
		reghandle(rnbb)=KREGFREE:asm_info("hidden freeing register="+*regstrq(rnbb))
		asm_code("mov "+regnbb+", "+Str(nb8))

		lname=*symbUniqueLabel( )
		asm_code(lname+":")
		asm_code("mov rax, ["+regsrc+"]")
		asm_code("mov ["+regdst+"], rax")
		asm_code("add "+regsrc+", 8")
		asm_code("add "+regdst+", 8")
		asm_code("dec "+regnbb)
		asm_code("jnz "+lname)
		nbbytes-=nb8*8
	elseif nb8>0 then ''lesser than 8 times
		for inb8 as long = 0 To nb8-1
			asm_code("mov rax, "+Str(inb8*8)+"["+regsrc+"]")
			asm_code("mov "+Str(inb8*8)+"["+regdst+"], rax")
		next
		nbbytes-=nb8*8
		if nbbytes<>0 then ''otherwise not usefull
			asm_code("add "+regsrc+", "+Str(nb8*8))
			asm_code("add "+regdst+", "+Str(nb8*8))
		end if
	end if

	if nbbytes>3 then
		''copy 7/6/5/4 bytes
		asm_code("mov eax, dword ptr ["+regsrc+"]")
		asm_code("mov dword ptr ["+regdst+"], eax")
		nbbytes-=4
		if nbbytes>1 then
			''copy 3/2 bytes
			asm_code("mov ax, word ptr 4["+regsrc+"]")
			asm_code("mov word ptr 4["+regdst+"], ax")
			nbbytes-=2
			if nbbytes>0 then
				asm_code("mov al, byte ptr 6["+regsrc+"]")
				asm_code("mov byte ptr 6["+regdst+"], al")
			end if
		elseif nbbytes>0 then
				asm_code("mov al, byte ptr 4["+regsrc+"]")
				asm_code("mov byte ptr 4["+regdst+"], al")
		end if
	elseif nbbytes>1 then
	''copy 3/2 bytes
		asm_code("mov ax, word ptr ["+regsrc+"]")
		asm_code("mov word ptr ["+regdst+"], ax")
		nbbytes-=2
		if nbbytes>0 then
			asm_code("mov al, byte ptr 2["+regsrc+"]")
			asm_code("mov byte ptr 2["+regdst+"], al")
		end if
	elseif nbbytes>0 then
		asm_code("mov al, byte ptr ["+regsrc+"]")
		asm_code("mov byte ptr ["+regdst+"], al")
	end if

	if regsrc<>src then reghandle(rsrc)=KREGFREE :asm_info("hidden freeing register="+*regstrq(rsrc))''free registers
	if regdst<>dst then reghandle(rdst)=KREGFREE :asm_info("hidden freeing register="+*regstrq(rdst))

end sub

private sub _init( )

	'' allocate space for 256 spilled registers - the size
	'' will automatically grow if needed.  If there are many spilled
	'' registers, then either the procedure is extremely complex, or
	'' more likely there is an opportunity to optimize the AST so
	'' that results are not saved unecessarily.

	flistInit( @ctx.spillvregs, 256, sizeof( ASM64_SAVEDREG ) )

	irhlInit( )
	'' IR_OPT_CPUSELFBOPS disabled, to prevent AST from producing self-ops.
	irSetOption(IR_OPT_CPUBOPFLAGS or IR_OPT_MISSINGOPS or IR_OPT_CPUSELFBOPS)'  or IR_OPT_ADDRCISC)'

	' dtypeName(FB_DATATYPE_INTEGER) = dtypeName(FB_DATATYPE_LONGINT)
	'dtypeName(FB_DATATYPE_UINT   ) = dtypeName(FB_DATATYPE_ULONGINT)

end sub

private sub _end( )
	asm_info("_end")
	irhlEnd( ) ''clear some lists

	flistEnd( @ctx.spillvregs )
end sub

#ifdef __GAS64_DEBUG__
	private function hemitprocheader(byval proc as FBSYMBOL ptr) as string

		dim as string ln
		dim as integer dtype = any
		dim as FBSYMBOL ptr subtype = Any



		'' function result type (is 'void' for subs)
		ln=typedumpToStr(typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ), symbGetProcRealSubtype( proc ) )
		ln += " "+*symbGetMangledName( proc )

		'' Parameter list
		ln += " ( "

		'' if returning a struct, there's an extra parameter
		dim as FBSYMBOL ptr hidden = NULL
		if( symbProcreturnsOnStack( proc ) ) then
			hidden = proc->proc.ext->res
			asm_info("hidden")
			if hidden<>0 then
				ln+=" "+typedumpToStr( typeAddrOf( symbGetType( hidden ) ), symbGetSubtype( hidden ))
				ln += " " + *symbGetMangledName( hidden )
			end if

			if( symbGetProcParams( proc ) > 0 ) then
				ln += ", "
			end if
		end if

		var param = symbGetProcLastParam( proc )
		while( param )
			if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
				ln += "..."
			else
				symbGetRealParamDtype( param, dtype, subtype )
				ln+=typedumpToStr( dtype, subtype )
				''with naked no parameter name
				if symbIsNaked(proc)=false then
					if symbGetParamVar( param )<>0 then ln+=" "+*symbGetMangledName(symbGetParamVar( param ))
				end if
			end if

			param = symbGetProcPrevParam( proc, param )
			if( param ) then
				ln += ", "
			end if

		wend

		ln += " )"
		ln+=" "+symbdumpToStr(proc)

		if( symbIsExport( proc ) ) then
			ln += " / dllexport"
		elseif( symbIsPrivate( proc ) ) then
			ln += " / private"
		end if


		if symbGetIsFuncPtr( proc ) then ln+=" / Accessed by funcptr"
		if (Not symbGetIsAccessed( proc )) then ln+=" / Not accessed --> not used ??"
		if  symbIsNaked(proc) then ln+=" / Naked proc"

		function = ln
	end function
#endif

private sub hemitvariable( byval sym as FBSYMBOL ptr )
	dim as integer is_global = any, length = any,lgt=any,align=any
	dim as string strg,newstrg
	dim as long pnew,pold,lenstrg
	asm_info(*symbgetname(sym)+ " "+*symbGetMangledName(sym))
	asm_info("symbdump="+symbdumpToStr(sym))
	if symbisarray(sym) then
		asm_info("Is an array")
	end if

	'' literal?
	if( symbGetIsLiteral( sym ) ) then
		if( symbGetIsAccessed( sym ) = FALSE ) then
			asm_info("Not accessed")
			exit sub
		end if
		select case( symbGetType( sym ) )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				asm_section(".data")
				asm_code(".align 8")
				if symbIsPublic( sym ) then
					asm_code(".globl "+*symbGetMangledName( sym ))
				end if
				asm_code(*symbGetMangledName( sym )+":")

				if( symbGetType( sym ) = FB_DATATYPE_WCHAR ) then
					strg=*hescapew(symbGetVarLitTextW( sym ))
					asm_code(".ascii """+strg+ left($"\0\0\0\0",typeGetSize( FB_DATATYPE_WCHAR )*2)+"""")
				else
					strg=*hescape(symbGetVarLitText( sym ))
					asm_code(".ascii """+strg+$"\0""")
				end if
		end select
		exit sub
	end if

	'' initialized? only if not local or local and static
	if( (symbGetTypeIniTree( sym ) <> NULL) and (symbIsLocal( sym ) = FALSE or symbIsStatic( sym )) ) then
		'' never referenced?
		'if( symbIsLocal( sym ) = FALSE ) then
		if( symbGetIsAccessed( sym ) = FALSE ) then
			asm_info("Not accessed")
			'' not public?
			if( symbIsPublic( sym ) = FALSE ) then
				exit sub
			end if
		end if
		'end if
		irhlFlushStaticInitializer( sym )
		exit sub
	end if
	'' dynamic? only the array descriptor is emitted
	if( symbGetIsDynamic( sym ) ) then
		exit sub
	end if

	is_global = symbGetAttrib( sym ) and _
		(FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or _
		FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_STATIC or _
		FB_SYMBATTRIB_SHARED)

	if( is_global ) then
		' asm_section(".data")
		if( symbIsExtern( sym ) or symbIsDynamic( sym ) ) then
			if symbIsExtern( sym ) then
				asm_info("Is extern")
				exit sub
			end if
		else
			if( env.clopt.debuginfo = true ) then edbgemitglobalvar_asm64(sym,IR_SECTION_BSS)
		end if

	else
		if symbGetAttrib( sym ) and FB_SYMBATTRIB_REF then
			''byref local
			lgt=typeGetSize( FB_DATATYPE_LONGINT )
		else
			lgt=sym->lgt
		end if

		asm_info("lgt="+Str(lgt)+" real="+Str(symbGetRealSize( sym )))

		select case( symbGetClass( sym ) )
			case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
				'' Fixed-size array vars/fields
				Var nbelements=1 ''todo use symbisarray
				for i as integer = symbGetArrayDimensions( sym ) - 1 to 0 step -1
					nbelements *= (symbArrayUbound( sym, i ) - symbArrayLbound( sym, i ) + 1)
				next
				length=lgt*nbelements
				asm_info("var total size="+Str(length))
				asm_info("stk="+Str(ctx.stk))
				if  symbGetType( sym )=FB_DATATYPE_STRUCT then
					align=sym->subtype->udt.natalign
					asm_info("length udt="+Str(sym->lgt)+" natalign="+Str(align)+" unpadlgt="+Str(sym->subtype->udt.unpadlgt))
					if align<4 then
						asm_info("Natalign= changed for 4")
						align=4 ''alignment at least 4"
					end if
					ctx.stk=(length+ctx.stk+align-1) And (Not(align-1))
				else
					ctx.stk=(length+ctx.stk+lgt-1) And (Not(lgt-1))
				end if
				asm_info("stk1="+Str(ctx.stk))
				sym->ofs=-ctx.stk
		end select
		if( env.clopt.debuginfo = true ) then edbgemitlocalvar_asm64( sym, symbIsStatic( sym ) )
	end if

	if( is_global ) then
		'' Globals without initializer are zeroed in FB
		ctx.section = SECTION_FOOT
		asm_section(".bss")
		dim as integer size,align,nbelements

		nbelements=1
		for i as integer = symbGetArrayDimensions( sym ) - 1 to 0 step -1
			nbelements *= (symbArrayUbound( sym, i ) - symbArrayLbound( sym, i ) + 1)
		next
		length=sym->lgt*nbelements
		 ''todo use symbisarray
		if (symbgettype(sym) = FB_DATATYPE_STRUCT) then
			align=sym->subtype->udt.natalign
			asm_info(*symbGetMangledName(sym))
		else
			align=sym->lgt
		end if
		asm_info("var total size="+Str(length)+"align="+str(align))
		align=pw2(align) ''must be a power of 2
		if align>8 then align=8
		'if symbIsPublic( sym ) then
		'    asm_info("Not for variable report please : .globl "+*symbGetMangledName( sym ))
		'end if
		if (symbIsCommon(sym)) or ( symbIsPublic( sym ) ) then
			asm_code(".comm "+*symbGetMangledName( sym )+","+Str(length)+","+Str(align))
		else
			if ctx.systemv then
				''lcomm without aligment in linux
				asm_code(".local "+*symbGetMangledName( sym ))
				asm_code(".comm "+*symbGetMangledName( sym )+","+Str(length)+","+Str(align))
			else
				asm_code(".lcomm "+*symbGetMangledName( sym )+","+Str(length)+","+Str(align))
			end if
		end if
		asm_info(">>"+typedumpToStr(symbGetType( sym ),sym->subtype) )
	end if
end sub

private sub hmaybeemitglobalvar( byval sym as FBSYMBOL ptr )
	'' Skip DATA descriptor arrays here, they're handled by irForEachDataStmt()
	ctx.indent +=1
	asm_info("global var="+*symbGetMangledName(sym))
	if( symbIsDataDesc( sym ) = FALSE ) then
		hEmitVariable( sym )
	end if
	ctx.indent -=1
end sub
private sub no_roundsd(byval size as zstring ptr)
	''when the CPU doesn't provide roundsd/roundss (needs see41)
	asm_code("stmxcsr $mxcsr[rip]")
	asm_code("push $mxcsr[rip]")
	asm_code("and dword ptr $mxcsr[rip], 0xFFFF9FFF")
	asm_code("ldmxcsr $mxcsr[rip]")
	asm_code("cvts"+*size+"2si rax, xmm0")
	asm_code("pop $mxcsr[rip]")
	asm_code("ldmxcsr $mxcsr[rip]")
end sub
private function _emitbegin( ) as integer

	if( hFileExists( env.outf.name ) ) then
		kill env.outf.name
	end if

	env.outf.num = freefile
	if( open( env.outf.name, for binary, access read write, as #env.outf.num ) <> 0 ) then
		return FALSE
	end if

	'
	ctx.indent = 0
	ctx.head_txt = ""
	ctx.body_txt = ""
	ctx.foot_txt = ""
	ctx.section = SECTION_HEAD
	'ctx.ctors = "" ''kept if to be added
	'ctx.dtors = ""
	ctx.ctorcount = 0
	ctx.dtorcount = 0
	ctx.roundfloat=false
	ctx.target=fbgetoption(FB_COMPOPT_TARGET) ''linux or windows
	select case ctx.target
	case FB_COMPTARGET_LINUX, FB_COMPTARGET_FREEBSD
		ctx.systemv = true
	case else
		ctx.systemv = false
	end select
	ctx.opereg=0

	for ireg as integer = 0 to KREGUPPER
		reghandle(ireg)=KREGFREE
		regroom(ireg).status=KROOMFREE
		regroom(ireg).vreg = NULL
	next

	reghandle(KREG_RBP)=KREGRSVD ''rbp ''reserved, don't use -1 as vreg could be = -1 when not a reg (var, idx, etc)
	reghandle(KREG_RSP)=KREGRSVD ''rsp

	if ctx.systemv then
		ctx.maxstack=8388608 ''Linux default stack size 8MB for 64bit
		redim listreg(1 to 8)
		listreg(1)=KREG_RDI:listreg(2)=KREG_RSI:listreg(3)=KREG_RDX:listreg(4)=KREG_RCX:listreg(5)=KREG_R8:listreg(6)=KREG_R9:listreg(7)=KREG_R10:listreg(8)=KREG_R11
	else
		ctx.maxstack=env.clopt.stacksize
		redim listreg(1 to 6)
		listreg(1)=KREG_RCX:listreg(2)=KREG_RDX:listreg(3)=KREG_R8:listreg(4)=KREG_R9:listreg(5)=KREG_R10:listreg(6)=KREG_R11
	end if
	ctx.indent+=1

	if( env.clopt.debuginfo = true ) then
		edbgemitheader_asm64( env.inf.name )
	else
		'' just in case we get a #cmdline that affects debug info code gen
		'' go ahead and ctxdbg / dbgstr / dbgstab
		ctxdbg.typecnt  = 1
		ctxdbg.strnb=-1
		ctxdbg.strmax=4
		redim dbgstr(ctxdbg.strmax)
		ctxdbg.stabnb=-1
		ctxdbg.stabmax=4
		redim dbgstab(ctxdbg.stabmax)
		ctxdbg.offst=1
		ctxdbg.lnum=-1
	end if

	asm_code( ".intel_syntax noprefix")
	cfi_windows_asm_code( ".cfi_sections .debug_frame")
	asm_section(".text")
	if env.clopt.nullptrchk=true then
		asm_code("mov qword ptr $totalstacksize[rip], 0")
	end if
	ctx.indent-=1
	function = TRUE
end function
private sub hAddGlobalCtorDtor( byval proc as FBSYMBOL ptr )

	if( symbGetIsFuncPtr( proc ) ) then
		exit sub
	end if

	if( symbGetIsGlobalCtor( proc ) ) then
		if symbGetProcIsEmitted(proc) then
			ctx.ctorcount += 1
			'hEmitCtorDtorArrayElement( proc, ctx.ctors )
			asm_info("Constructor name/prio="+*symbGetMangledName( proc )+" / "+str( symbGetProcPriority( proc ) ))
			if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
				asm_section(".init_array")
			else
				asm_section(".ctors")
			end if
			asm_code(".align 8")
			asm_code(".quad "+*symbGetMangledName( proc ))
			asm_section(".text")
		end if
	elseif( symbGetIsGlobalDtor( proc ) ) then
		ctx.dtorcount += 1
		'hEmitCtorDtorArrayElement( proc, ctx.dtors )
		asm_info("Destructor name/prio="+*symbGetMangledName( proc )+" / "+str( symbGetProcPriority( proc ) ))
		if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
			asm_section(".fini_array")
		else
			asm_section(".dtors")
		end if
		asm_code(".align 8")
		asm_code(".quad "+*symbGetMangledName( proc ))
		asm_section(".text")

	end if
end sub
private sub _emitend( )
	ctx.indent +=1
	ctx.section = SECTION_FOOT

	'' the variables
	ctx.indent -=1 ''+1/-1 also done in hMaybeEmitGlobalVar
	symbForEachGlobal( FB_SYMBCLASS_VAR, @hMaybeEmitGlobalVar )
	ctx.indent +=1
	'' DATA array initializers can reference globals by taking their address,
	'' so they must be emitted after the other global declarations.
	irForEachDataStmt( @hEmitVariable )
	'' Global arrays for global ctors/dtors
	symbForEachGlobal( FB_SYMBCLASS_PROC, @hAddGlobalCtorDtor )

	''for checking stack overflow
	if env.clopt.nullptrchk=true then
		asm_section(".bss")
		if ctx.systemv then
			asm_code(".local $totalstacksize")
			asm_code(".comm $totalstacksize,8,8")
		else
			asm_code(".lcomm $totalstacksize,8,8")
		end if
	EndIf

	''if float rounding is used check sse4_1 for using roundsd/roundss
	if ctx.roundfloat=true then
		'ctx.section = SECTION_HEAD
		asm_section(".bss")
		''as float rounding is used needs global variables
		if ctx.systemv then
			asm_code(".local $mxcsr")
			asm_code(".comm $mxcsr,8,8")
			asm_code(".local $sse41")
			asm_code(".comm $sse41,4,8")
		else
			asm_code(".lcomm $mxcsr,8,8")
			asm_code(".lcomm $sse41,4,8")
		end if

		''must be executed before the constructors and main
		if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
			asm_section(".init_array")
		else
			asm_section(".ctors")
		end if
		asm_code(".align 8")
		asm_code(".quad $sse41_test")

		asm_section(".text")
		''is the processor having SSE4_1 feature ?
		asm_code("$sse41_test:")
		asm_code("push rbx")
		asm_code("push rcx")
		asm_code("push rdx")
		asm_code("mov  eax, 1")
		asm_code("cpuid")
		asm_code("and ecx, 0b10000000000000000000")
		asm_code("mov $sse41[rip], ecx")
		asm_code("pop rdx")
		asm_code("pop rcx")
		asm_code("pop rbx")
		asm_code("ret")
	end if
	''write dbg data
	if( env.clopt.debuginfo = true ) then
		dim as string lname = *symbUniqueLabel( )
		dbg_addstab(,STAB_TYPE_SO,,lname)
		asm_code(".text")
		asm_code(lname+":")
		dbg_emitstab()
		dbg_emitstr()
	end if

	' flush all sections to file
	if( put( #env.outf.num, , ctx.head_txt ) <> 0 ) then
	end if
	if( put( #env.outf.num, , ctx.body_txt ) <> 0 ) then
	end if
	if( put( #env.outf.num, , ctx.foot_txt ) <> 0 ) then
	end if

	if( close( #env.outf.num ) <> 0 ) then
		'' ...
	end if

	env.outf.num = 0
end sub

private function _getoptionvalue( byval opt as IR_OPTIONVALUE ) as integer
	select case opt
		case IR_OPTIONVALUE_MAXMEMBLOCKLEN
			return 0
		case else
			errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
	end select
end function

private function _supportsop(byval op as integer,byval dtype as Integer) as integer
	''return true if the function is availiable directly in the backend
	'asm_info("_supportsop="+astdumpopToStr( op )+" "+typedumpToStr(dtype,0))
	select case as const( op )
		'case AST_OP_SGN, AST_OP_FIX, AST_OP_FRAC, _
		'    AST_OP_ASIN, AST_OP_ACOS, AST_OP_TAN, AST_OP_ATAN, _
		case AST_OP_SGN
			if typeGetClass( dtype ) = FB_DATACLASS_FPOINT then
				return false
			else
				''sgn available only for integer
				return true
			end if
		case AST_OP_RSQRT, AST_OP_RCP
			return FALSE
		case AST_OP_ABS,AST_OP_NEG,AST_OP_NOT,AST_OP_SQRT

			'function = (typeGetClass( dtype ) = FB_DATACLASS_FPOINT)
			return TRUE
		case else
			function = TRUE
	end select
end function
private sub _procbegin( byval proc as FBSYMBOL ptr )
	proc->proc.ext->dbg.iniline = lexLineNum( )
end sub

private sub _procend( byval proc as FBSYMBOL ptr )
	proc->proc.ext->dbg.endline = lexLineNum( )
end sub

private function param_analyze(byval dtype as FB_DATATYPE,byval struc as FBSYMBOL ptr _
	,byref cptarg as integer=0,byref cptint as integer=0,byref cptfloat as integer=0) as integer
	''used in hdocall and also in procallocarg but here do not update cptarg/cptint/cptfloat.....
	dim as FBSYMBOL ptr fld = any
	dim as integer lgt,intcpt,floatcpt

	if ctx.systemv then
		'' LNX =================================================================================
		if dtype<>FB_DATATYPE_STRUCT then
			if typeGetClass( dtype ) = FB_DATACLASS_FPOINT then
				if cptfloat<8 then
					cptfloat+=1
					return KPARAMX1
				else
					cptarg+=1
					return KPARAMSK0
				end if
			else
				if cptint<6 then
					cptint+=1
					return KPARAMR1
				else
					cptarg+=1
					return KPARAMSK0
				end if
			end if
		else
			''handling structure
			lgt=struc->lgt
			asm_info("subtype/lgt="+*symbGetMangledName(struc)+" "+str(lgt))
			if lgt<=typeGetSize( FB_DATATYPE_LONGINT )*2 then
				select case as const hGetMagicStructNumber( struc )
					case KSTRUCT_R
						if cptint <6 then
							cptint+=1
							return KPARAMR1
						end if
					case KSTRUCT_X
						if cptfloat <8 then
							cptfloat+=1
							return KPARAMX1
						end if
					case KSTRUCT_RR
						if cptint <5 then
							cptint+=2
							return KPARAMRR
						end if
					case KSTRUCT_RX
						if cptint <6 and cptfloat <8 then
							cptint+=1
							cptfloat+=1
							return KPARAMRX
						end if
					case KSTRUCT_XR
						if cptint <6 and cptfloat <8 then
							cptfloat+=1
							cptint+=1
							return KPARAMXR
						end if
					case KSTRUCT_XX
						if cptfloat <7 then
							cptfloat+=2
							return KPARAMXX
						end if
				end select
			end if
			''can't put the structure in register(s) size>16 or not enough register(s) possibly mix Rexx/XMM
			return KPARAMSK0 ''copy structure on stack
		end if
	else
''WDS ========================================================================
		cptarg+=1
		''to have the same code for WDS/LNX
		cptint=cptarg:cptfloat=cptarg


		if dtype<>FB_DATATYPE_STRUCT then
			if cptarg>4 then return KPARAMSK0  ''value on stack
			if typeGetClass( dtype ) = FB_DATACLASS_FPOINT then
				return KPARAMX1 ''value in XMM register
			else
				return KPARAMR1 ''value in Rxx register
			end if
		else
			lgt=struc->lgt
			asm_info("subtype/lgt="+*symbGetMangledName(struc)+" "+str(lgt))
			if lgt>typeGetSize( FB_DATATYPE_LONGINT ) or lgt=3 or lgt= 5 or lgt=6 or lgt=7 then
				if cptarg>4 then
					return KPARAMSK3 ''copy structure on stack and pointer on stack
				else
					return KPARAMSK2 ''copy structure on stack and pointer in register
				end if
			end if
			fld = symbUdtGetFirstField( struc)
			while fld
				if typegetclass(fld->typ)=FB_DATACLASS_FPOINT then
					floatcpt+=1
				else
					intcpt+=1
				end if
				fld=symbUdtGetNextField(fld)
			wend

			if floatcpt=1 and intcpt=0 then
				''only 1 single or 1 double
				if cptarg>4 then
					return KPARAMSK1 ''value on stack no pointer
				else
					return KPARAMX1  ''-->XMM
				end if
			else
				'' only integers or a mix
				if cptarg>4 then
					return KPARAMSK1 ''value on stack no pointer
				else
					return KPARAMR1  ''--> Rxx
				end if
			end if
		end if
	end if
end function
private sub reg_fillm(byval ofs as integer,listreg() as long,byval lgt as integer,byval prev as integer=0,byval offst as integer=0)
	select case as const lgt-offst
		case 1
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrb(listreg(ctx.arginteg-prev)))
		case 2
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrw(listreg(ctx.arginteg-prev)))
		case 3
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrw(listreg(ctx.arginteg-prev)))
			asm_code("shr "+*regstrq(listreg(ctx.arginteg-prev))+", 16")
			asm_code("mov "+Str(ofs+offst+2)+"[rbp], "+*regstrb(listreg(ctx.arginteg-prev)))
		case 4
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrd(listreg(ctx.arginteg-prev)))
		case 5
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrd(listreg(ctx.arginteg-prev)))
			asm_code("shr "+*regstrq(listreg(ctx.arginteg-prev))+", 32")
			asm_code("mov "+Str(ofs+offst+4)+"[rbp], "+*regstrb(listreg(ctx.arginteg-prev)))
		case 6
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrd(listreg(ctx.arginteg-prev)))
			asm_code("shr "+*regstrq(listreg(ctx.arginteg-prev))+", 32")
			asm_code("mov "+Str(ofs+offst+4)+"[rbp], "+*regstrw(listreg(ctx.arginteg-prev)))
		case 7
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrd(listreg(ctx.arginteg-prev)))
			asm_code("shr "+*regstrq(listreg(ctx.arginteg-prev))+", 32")
			asm_code("mov "+Str(ofs+offst+4)+"[rbp], "+*regstrw(listreg(ctx.arginteg-prev)))
			asm_code("shr "+*regstrq(listreg(ctx.arginteg-prev))+", 16")
			asm_code("mov "+Str(ofs+offst+6)+"[rbp], "+*regstrb(listreg(ctx.arginteg-prev)))
		case 8
			asm_code("mov "+Str(ofs+offst)+"[rbp], "+*regstrq(listreg(ctx.arginteg-prev)))
	end select
end sub
private sub reg_fillr(byval lgt as integer,byref src as string,byval cptint as integer,listreg() as long,byval reg2 as long)

	dim as const zstring ptr regsrc
	dim as string regdst=*regstrq(listreg(cptint))

	if lgt>8 then
		lgt-=8
		if src[0]=asc("-") then
			''shortcut for move at address -xxx[rbp] + 8
			src=str(valint(left(src,instr(src,"[rbp]")-1))+8)+"[rbp]"
		else
			asm_code("lea rax, "+src)
			asm_code("add rax, 8")
			src="[rax]"
		end if
	end if

	if lgt<>1 and lgt<>2 and lgt<>4 and lgt<>8 then
		regsrc=reg_tempo
	end if

	reg_transfer(listreg(cptint),reg2)''is the reg free ?

	select case as const lgt
		case 1
			asm_code("movzx "+regdst+", BYTE PTR "+src)
		case 2
			asm_code("movzx "+regdst+", WORD PTR "+src)
		case 3
			asm_code("lea "+*regsrc+", "+src)
			asm_code("movzx "+regdst+", WORD PTR ["+*regsrc+"]")
			asm_code("movzx eax, BYTE PTR 2["+*regsrc+"]")
			asm_code("shl rax, 16")
			asm_code("or "+regdst+", rax")
		case 4
			asm_code("mov "+*regstrd(listreg(cptint))+", DWORD PTR "+src)
		case 5
			asm_code("lea "+*regsrc+", "+src)
			asm_code("mov "+*regstrd(listreg(cptint))+", DWORD PTR ["+*regsrc+"]")
			asm_code("movzx eax, BYTE PTR 4["+*regsrc+"]")
			asm_code("shl rax, 32")
			asm_code("or "+regdst+", rax")
		case 6
			asm_code("lea "+*regsrc+", "+src)
			asm_code("mov "+*regstrd(listreg(cptint))+", DWORD PTR ["+*regsrc+"]")
			asm_code("movzx eax, WORD PTR 4["+*regsrc+"]")
			asm_code("shl rax, 32")
			asm_code("or "+regdst+", rax")
		case 7
			asm_code("lea "+*regsrc+", "+src)
			asm_code("mov "+*regstrd(listreg(cptint))+", DWORD PTR ["+*regsrc+"]")
			asm_code("movzx eax, WORD PTR 4["+*regsrc+"]")
			asm_code("shl rax, 32")
			asm_code("or "+regdst+", rax")
			asm_code("movzx eax, BYTE PTR 6["+*regsrc+"]")
			asm_code("shl rax, 48")
			asm_code("or "+regdst+", rax")
		case 8
			asm_code("mov "+regdst+", QWORD PTR "+src)
	end select
end sub
private sub reg_fillx(byval lgt as integer,byref src as string,byval cptfloat as integer)
	if lgt>8 then
		lgt-=8
		if src[0]=asc("-") then
			''shortcut for move at address -xxx[rbp] + 8
			src=str(valint(left(src,instr(src,"[rbp]")-1))+8)+"[rbp]"
		else
			asm_code("lea rax, "+src)
			asm_code("add rax, 8")
			src="[rax]"
		end if
	end if

	if lgt=4 then
		asm_code("movd xmm"+Str(cptfloat-1)+", "+src)
	else
		asm_code("movq xmm"+Str(cptfloat-1)+", "+src)
	end if
end sub
private sub _procallocarg( byval proc as FBSYMBOL ptr, byval sym as FBSYMBOL ptr )

	dim as long lgt,reg
	dim as integer dtype,paramtype
	dim subtype as FBSYMBOL Ptr
	dim as string regstr,regx

	symbGetRealType( sym, dtype, subtype )

	asm_info("paramvar="+*symbGetMangledName( sym )+" real typ="+ typedumpToStr( dtype, subtype )+" symbgetlen="+Str(symbGetlen( sym )))
	asm_info(symbdumpToStr(sym))

	asm_info("lgt="+Str(sym->lgt)+" real="+Str(symbGetRealSize( sym )))

	if ctx.systemv then
	''===============================
	''=========== LINUX =============
	''===============================

		if typeisptr(dtype)=false and symbisvaliststructarray( dtype,subtype)then
			asm_info("Canceling byval and forcing byref for CVA_GCC")
			sym->attrib xor = FB_SYMBATTRIB_PARAMVARBYVAL
			sym->attrib or  = FB_SYMBATTRIB_PARAMVARBYREF
			'sym->typ or = 32 ''pointer
		end if

		If( symbIsParamVarByVal( sym ) ) then
			''byval
		'asm_info("dt="+str(dtype))
		'asm_info("dtonly="+str(typeGetDtOnly(dtype)))
		'asm_info("dtdtand ptr="+str(typeGetDtAndPtrOnly(dtype)))
			if typeGetDtAndPtrOnly(dtype)= FB_DATATYPE_STRUCT then
				''byval structure
				paramtype=param_analyze(FB_DATATYPE_STRUCT,sym->subtype,,ctx.arginteg,ctx.argfloat )
				asm_info("KPARAM="+str(paramtype))
				if paramtype=KPARAMSK0 then
					''byval structure passed by copy
					''''''asm_info("copying byval parameter from pointer data")
					''''''asm_info("stk="+Str(ctx.stk))
					''''''ctx.stk=(sym->lgt+ctx.stk+sym->lgt-1) And (Not(sym->lgt-1))
					'''''''ctx.stk+=8-(ctx.stk mod 8)
					''''''asm_info("stk3="+Str(ctx.stk))
					''''''sym->ofs=-ctx.stk
					''''''if paramtype=KPARAMSK3  then
					''''''    ''byval structure passed by pointer in register
					''''''    regstr=*regstrq(listreg(ctx.arginteg))
					''''''    memcopy(symbGetRealSize( sym ),regstr,Str(sym->ofs)+"[rbp]",KUSE_MOV,KUSE_LEA)
					''''''else
					''''''    ctx.ofs+=8
					''''''    memcopy(symbGetRealSize( sym ),Str(ctx.ofs)+"[rbp]",Str(sym->ofs)+"[rbp]",KUSE_MOV,KUSE_LEA)
					''''''end if
					asm_info("ctx.ofs="+Str(ctx.ofs))
					sym->ofs=ctx.ofs
					ctx.ofs+=sym->lgt
					asm_info("Linux stack ctx.ofs="+Str(ctx.ofs))
				'elseif paramtype=KPARAMSK then
				' not sure is this case can happen ?
				'    ctx.ofs+=8
				'    sym->ofs=ctx.ofs
				else
					''byval structure passed directly in a register
					asm_info("Copying byval parameter directly from register")
					lgt = symbGetlen( sym )
					asm_info("stk="+Str(ctx.stk))
					ctx.stk=(lgt+ctx.stk+lgt-1) And (Not(lgt-1))
					'ctx.stk+=8-(ctx.stk mod 8)
					asm_info("stk91="+Str(ctx.stk))
					sym->ofs=-ctx.stk
					select case as const paramtype
						case KPARAMR1
							reg_fillm(sym->ofs,listreg(),lgt)
						case KPARAMRR
							reg_fillm(sym->ofs,listreg(),8,1)
							reg_fillm(sym->ofs,listreg(),lgt,0,8)
						case KPARAMRX
						   reg_fillm(sym->ofs,listreg(),8)
							if lgt<13 then
								asm_code("movd "+Str(sym->ofs+8)+"[rbp], xmm"+str(ctx.argfloat-1))
							else
								asm_code("movq "+Str(sym->ofs+8)+"[rbp], xmm"+str(ctx.argfloat-1))
							end if
						case KPARAMXR
							if lgt=4 then
								asm_code("movd "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-1))
							else
								asm_code("movq "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-1))
							end if
							reg_fillm(sym->ofs,listreg(),lgt,,8)
						case KPARAMX1
							if lgt=4 then
								asm_code("movd "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-1))
							else
								asm_code("movq "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-1))
							end if
						case KPARAMXX
							asm_code("movq "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-2))
							if lgt<13 then
								asm_code("movd "+Str(sym->ofs+8)+"[rbp], xmm"+str(ctx.argfloat-1))
							else
								asm_code("movq "+Str(sym->ofs+8)+"[rbp], xmm"+str(ctx.argfloat-1))
							end if
					end select
				end if
			else
				''byval simple datatype
				lgt = symbGetlen( sym )
				if typegetclass(dtype)=FB_DATACLASS_FPOINT then
					ctx.argfloat+=1
					if ctx.argfloat<=8 then
						''otherwise already in memory
						asm_info("stk="+Str(ctx.stk))
						ctx.stk=(lgt+ctx.stk+lgt-1) And (Not(lgt-1))
						'ctx.stk+=8-(ctx.stk mod 8)
						asm_info("stk93="+Str(ctx.stk))
						sym->ofs=-ctx.stk
						if lgt=4 then
							asm_code("movd "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-1))
						else
							asm_code("movq "+Str(sym->ofs)+"[rbp], xmm"+str(ctx.argfloat-1))
						end if
					else
						asm_info("Linux stack ctx.ofs2="+Str(ctx.ofs))
						sym->ofs=ctx.ofs
						ctx.ofs+=8
					end if
				else
					ctx.arginteg+=1
					if ctx.arginteg<=6 then
						asm_info("stk="+Str(ctx.stk))
						ctx.stk=(lgt+ctx.stk+lgt-1) And (Not(lgt-1))
						'ctx.stk+=8-(ctx.stk mod 8)
						asm_info("stk94="+Str(ctx.stk))
						sym->ofs=-ctx.stk
						select case as const lgt
							case 1
								asm_code("mov BYTE PTR "+Str(sym->ofs)+"[rbp], "+*regstrb(listreg(ctx.arginteg)))
							case 2
								asm_code("mov WORD PTR "+Str(sym->ofs)+"[rbp], "+*regstrw(listreg(ctx.arginteg)))
							case 4
								asm_code("mov DWORD PTR "+Str(sym->ofs)+"[rbp], "+*regstrd(listreg(ctx.arginteg)))
							case 8
								asm_code("mov QWORD PTR "+Str(sym->ofs)+"[rbp], "+*regstrq(listreg(ctx.arginteg)))
						end select
					else
						asm_info("Linux stack ctx.ofs3="+Str(ctx.ofs))
						sym->ofs=ctx.ofs
						ctx.ofs+=8
					end if
				end if
			end if
		else
			''byref
			ctx.arginteg+=1
			lgt=8
			if ctx.arginteg<=6 then
				asm_info("stk="+Str(ctx.stk))
				ctx.stk=(lgt+ctx.stk+lgt-1) And (Not(lgt-1))
				'ctx.stk+=8-(ctx.stk mod 8)
				asm_info("stk95="+Str(ctx.stk))
				sym->ofs=-ctx.stk
				asm_code("mov QWORD PTR "+Str(sym->ofs)+"[rbp], "+*regstrq(listreg(ctx.arginteg)))
			else
				asm_info("Linux stack ctx.ofs4="+Str(ctx.ofs))
				sym->ofs=ctx.ofs
				ctx.ofs+=8
			end if
		end if
	else
		''===============================
		''========= windows =============
		''===============================
		ctx.ofs+=8
		if( symbIsParamVarByVal( sym ) ) then
			''byval
			if typeGetDtAndPtrOnly(dtype)= FB_DATATYPE_STRUCT then
				''byval structure
				paramtype=param_analyze(FB_DATATYPE_STRUCT,sym->subtype,ctx.arginteg)
				asm_info("KPARAM="+str(paramtype))
				select case as const paramtype
					case KPARAMSK2,KPARAMSK3
						''byval structure passed by pointer
						asm_info("copying byval parameter from pointer data")
						asm_info("stk="+Str(ctx.stk))
						ctx.stk=(sym->lgt+ctx.stk+sym->lgt-1) And (Not(sym->lgt-1))
						'ctx.stk+=8-(ctx.stk mod 8)
						asm_info("stk3="+Str(ctx.stk))
						sym->ofs=-ctx.stk
						if paramtype=KPARAMSK2 then
							''byval structure passed by pointer in register
							regstr=*regstrq(listreg(ctx.arginteg))
							memcopy(symbGetRealSize( sym ),regstr,Str(sym->ofs)+"[rbp]",KUSE_MOV,KUSE_LEA)
						else
							''byval structure passed by pointer in memory
							memcopy(symbGetRealSize( sym ),Str(ctx.ofs)+"[rbp]",Str(sym->ofs)+"[rbp]",KUSE_MOV,KUSE_LEA)
						end if
					case KPARAMR1,KPARAMX1
						''byval structure passed directly in a register
						asm_info("Copying byval parameter directly from register")
						sym->ofs=ctx.ofs
						'if ctx.arginteg<=4 and ctx.variadic=false then
						if ctx.variadic=false then
							lgt = symbGetlen( sym )
							''otherwise already in memory
							if paramtype=KPARAMX1 then
								if lgt=4 then
									asm_code("movd "+Str(ctx.ofs)+"[rbp], xmm"+str(ctx.arginteg-1))
								else
									asm_code("movq "+Str(ctx.ofs)+"[rbp], xmm"+str(ctx.arginteg-1))
								end if
							else
								select case as const lgt
									case 1
										asm_code("mov BYTE PTR "+Str(ctx.ofs)+"[rbp], "+*regstrb(listreg(ctx.arginteg)))
									case 2
										asm_code("mov WORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrw(listreg(ctx.arginteg)))
									case 4
										asm_code("mov DWORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrd(listreg(ctx.arginteg)))
									case 8
										asm_code("mov QWORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrq(listreg(ctx.arginteg)))
								end select
							end if
						end if
					case else
						sym->ofs=ctx.ofs
				end select
			else
				''byval simple datatype
				lgt = symbGetlen( sym )
				sym->ofs=ctx.ofs
				ctx.arginteg+=1
				if ctx.arginteg<=4 and ctx.variadic=false then
					if typegetclass(dtype)=FB_DATACLASS_FPOINT then
						''otherwise already in memory
						if lgt=4 then
							asm_code("movd "+Str(ctx.ofs)+"[rbp], xmm"+str(ctx.arginteg-1))
						else
							asm_code("movq "+Str(ctx.ofs)+"[rbp], xmm"+str(ctx.arginteg-1))
						end if
					else
						select case as const lgt
							case 1
								asm_code("mov BYTE PTR "+Str(ctx.ofs)+"[rbp], "+*regstrb(listreg(ctx.arginteg)))
							case 2
								asm_code("mov WORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrw(listreg(ctx.arginteg)))
							case 4
								asm_code("mov DWORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrd(listreg(ctx.arginteg)))
							case 8
								asm_code("mov QWORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrq(listreg(ctx.arginteg)))
						end select
					end if
				end if
			end if
		else
			''byref
			ctx.arginteg+=1
			sym->ofs = ctx.ofs
			if ctx.arginteg<=4 and ctx.variadic=false then
				asm_code("mov QWORD PTR "+Str(ctx.ofs)+"[rbp], "+*regstrq(listreg(ctx.arginteg)))
			end if
		end if
	end if

	if( env.clopt.debuginfo = true ) then edbgemitprocarg_asm64(sym)

end sub

private sub _procalloclocal( byval proc as FBSYMBOL ptr, byval sym as FBSYMBOL ptr )
	asm_info( "localvar " + *symbGetMangledName( sym ) )
	hEmitVariable( sym )
end sub

private sub _procAllocStaticVars( byval sym as FBSYMBOL ptr )
	ctx.section=SECTION_FOOT
	while( sym )
		select case( symbGetClass( sym ) )
		'' scope block? recursion..
			case FB_SYMBCLASS_SCOPE
			 'asm_info("SCOPE var1="+*symbGetMangledName(sym))
			_procallocstaticvars( symbGetScopeSymbTbHead( sym ) )
		case FB_SYMBCLASS_VAR
			''  variable static
			if( symbIsStatic( sym ) ) then
				hMaybeEmitGlobalVar(sym)
			end if
		end select

		sym = symbGetNext( sym )
	wend
	'ctx.section=SECTION_HEAD
end sub

''=================================================
''KEEP THIS PROCEDURE as IT'S USED TO CALL CONVERT
''=================================================
private sub _setvregdatatype(byval v as IRVREG ptr,byval dtype as integer,byval subtype as FBSYMBOL Ptr)

	asm_info("in _setVregDataType v="+vregdumpfull(v))
	asm_info("dtype/subtype="+typedumpToStr(dtype,subtype))
	asm_info("dtype/subtype="+typedumpToStr(v->dtype,v->subtype))
	dim as IRVREG ptr temp0 = Any
	if( (v->dtype <> dtype) or (v->subtype <> subtype) ) then
		temp0 = irhlAllocVreg( dtype, subtype )
		_EmitConvert( temp0, v )
		*v = *temp0
	end if

end sub

private sub _emitlabel( byval label as FBSYMBOL ptr )
	if ctx.labelbranch2=label or ctx.labeljump=label then
		reg_branch(label)
	else
		asm_code(*symbGetMangledName( label )+":")
	end if

	if label->lbl.gosub then
		asm_code("sub rsp, 88 #stack for gosub") ''8 parameters max and need to be 16byte aligned
	end if
end sub
private sub prepare_idx(byval v1 as IRVREG ptr, byref op1 as string, byref op3 as string)

	dim as string regtempo
	'asm_info("prepare_op v1->sym="+str(v1->sym)+" "+str(v1->vidx->sym))
	if v1->sym=0 then
		 ''format  (ofs= )[datatype]  vidx=<reg>  /// vidx=<var varname ofs
		if v1->vidx->sym=0 then
			''with vidx=<reg>
			' asm_info("vidx->reg="+str(v1->vidx->reg))
			if v1->vidx->reg<>-1 then
				op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"
				return
			else
				''2 levels of deref
				regtempo=*regstrq(reg_findreal(v1->vidx->vidx->reg))
				op3="mov "+regtempo+", "+"["+regtempo+"]"
				op1=Str(v1->ofs)+"["+regtempo+"]"
				return
			end if
		else
			''with vidx=<var varname ofs
			regtempo=*reg_tempo()
			if symbIsStatic(v1->vidx->sym) Or symbisshared(v1->vidx->sym) then
				op3="lea "+regtempo+", "+*symbGetMangledName(v1->vidx->sym)+"[rip+"+Str(v1->vidx->ofs)+"]"
				op3+=newline2+"mov "+regtempo+", "+"["+regtempo+"] #NO"
				op1=Str(v1->ofs)+"["+regtempo+"]"
				return
			else
				op3="mov "+regtempo+", "+Str(v1->vidx->ofs)+"[rbp]"
				op1=Str(v1->ofs)+"["+regtempo+"]"
				return
			end if
		end if

	else
		''format  varname ofs1= [dt] vidx=<reg>  /// vidx=<var varname ofs
		regtempo=*reg_tempo()
		if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
			op3="lea "+regtempo+", "+*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"] #NO"
		else
			op3="lea "+regtempo+", "+Str(v1->ofs)+"[rbp]"
		end if
		if v1->vidx->typ=IR_VREGTYPE_REG then
			op1="["+regtempo+"+"+*regstrq(reg_findreal(v1->vidx->reg))+"]"
			return
		elseif v1->vidx->typ=IR_VREGTYPE_VAR then
			if symbIsStatic(v1->vidx->sym) Or symbisshared(v1->vidx->sym) then
				op3+=newline2+"add "+regtempo+", "+*symbGetMangledName(v1->vidx->sym)+"[rip+"+Str(v1->vidx->ofs)+"]"
			else
				op3+=newline2+"add "+regtempo+","+Str(v1->vidx->ofs)+"[rbp]"
			end if
			op1="["+regtempo+"]"
			return
		end if
	end if
	asm_error("prepare_IDX case not handled 01")
	if op1="" then op1="X X" '''to avoid crashes
end sub
private function hgetbopcode(byval op as Integer) as zstring ptr

	select case as const( op )
		case AST_OP_ADD
			function = @"add"
		case AST_OP_SUB
			function = @"sub"
		case AST_OP_MUL
			function = @"mul"
		case AST_OP_DIV
			function = @"div"
		case AST_OP_INTDIV
			function = @"intdiv"
		case AST_OP_MOD
			function = @"mod"
		case AST_OP_SHL
			function = @"shl"
		case AST_OP_SHR
			function = @"ashr"
		case AST_OP_AND
			function = @"and"
		case AST_OP_OR
			function = @"or"
		case AST_OP_XOR
			function = @"xor"
		case AST_OP_EQ
			function = @"icmp eq"
		case AST_OP_NE
			function = @"icmp ne"
		case AST_OP_GT
			function = @"icmp sgt"
		case AST_OP_LT
			function = @"icmp slt"
		case AST_OP_GE
			function = @"icmp sge"
		case AST_OP_LE
			function = @"icmp sle"
		case AST_OP_EQV
			function = @"eqv"
		case AST_OP_IMP
			function = @"imp"
		case AST_OP_JMP
			function = @"jmp"
		case AST_OP_JEQ
			function = @"je"
		case AST_OP_JGT
			function = @"jgt"
		case AST_OP_JLT
			function = @"jlt"
		case AST_OP_JNE
			function = @"jne"
		case AST_OP_JGE
			function = @"jge"
		case AST_OP_JLE
			function = @"jle"
		case AST_OP_CALL
			function = @"call"
		case else
			function =@"bop unknown"
	end select

end function
private sub restore_vrreg(byval vr as IRVREG ptr, byval vrreg as integer)
	ctx.opereg=vrreg
	ctx.opepass=1
	if reghandle(vrreg)=KREGFREE then
		reghandle(vrreg)=vr->reg
		asm_info("reghandle reset so "+*regstrq(vrreg)+" forced again to vreg="+Str(vr->reg))
	end if
end sub
private sub bop_float( _
	byval op as integer, _
	byval v1 as IRVREG ptr, _
	byval v2 as IRVREG ptr, _
	byval vr as IRVREG ptr, _
	byref op1 as string, _
	byref op2 as string, _
	byref op3 as string, _
	byref op4 as string, _
	byref prefix as string, _
	byval label as FBSYMBOL ptr  _
	)

	dim as string lname1,lname2,movreg,movmem,compreg,immreg,addreg,subreg,mulreg,divreg
	dim as long vrreg
	dim as FB_DATATYPE v1dtype
	dim as zstring ptr jmpcode

	if vr<>0 then
		vrreg=reg_findfree(vr->reg)
	end if
	v1dtype=typeGetDtAndPtrOnly( v1->dtype )''2019/10/28 typeGetDtAndPtrOnly adding for const case
	if v1dtype=FB_DATATYPE_DOUBLE then
		movreg="movq ":movmem="movsd ":compreg="ucomisd ":immreg="rax"
		addreg="addsd ":subreg="subsd ":mulreg="mulsd ":divreg="divsd "
	else
		movreg="movd ":movmem="movss ":compreg="ucomiss ":immreg="eax"
		addreg="addss ":subreg="subss ":mulreg="mulss ":divreg="divss "
	end if

	if v1->typ=IR_VREGTYPE_REG then
		asm_code(movreg+"xmm0, "+op1)
	elseif v1->typ=IR_VREGTYPE_IMM then
		asm_code("mov "+immreg+", "+op1)
		asm_code(movreg+"xmm0, "+immreg)
	else
		asm_code(movmem+"xmm0, "+op1)
	end if

	if v2->typ=IR_VREGTYPE_REG then
		asm_code(movreg+"xmm1, "+op2)
	elseif v2->typ=IR_VREGTYPE_IMM then
		asm_code("mov "+immreg+", "+op2)
		asm_code(movreg+"xmm1, "+immreg)
	else
		asm_code(movmem+"xmm1, "+op2)
	end if

	select case op
		case AST_OP_EQ,AST_OP_NE,AST_OP_LT,AST_OP_LE,AST_OP_GT,AST_OP_GE
			if label=0 then
				lname1 = *symbUniqueLabel( )
				asm_code("mov "+*regstrq(vrreg)+", -1")
			end if

			asm_code(compreg+"xmm0, xmm1")

			if op=AST_OP_EQ then
				lname2 = *symbUniqueLabel( )
				asm_code("jp "+lname2) ''different true very big (or very small value)
			elseif op=AST_OP_NE then
				if label=0 then
					asm_code("jp "+lname1)
				else
					asm_code("jp "+*symbGetMangledName( label ))''different true
				end if
			end if

			select case op
				case AST_OP_EQ
					jmpcode=@"je " ''different not true
				case AST_OP_NE
					jmpcode=@"jne " ''different true
				case AST_OP_LT ''todo optimise xmm1 if memory do directly
					jmpcode=@"jb "''above true
				case AST_OP_LE
					jmpcode=@"jbe " ''above or equal true
				case AST_OP_GT
					jmpcode=@"ja "''below true
				case AST_OP_GE
					jmpcode=@"jae "''below or equal true
			end select

			if label=0 then
				asm_code(*jmpcode+lname1)
			else
				asm_code(*jmpcode+*symbGetMangledName( label ))
				reg_mark(label)
			end if
			if op=AST_OP_EQ then asm_code(lname2+":") ''label when different

			if label=0 then
				asm_code("xor "+*regstrq(vrreg)+", "+*regstrq(vrreg))
				restore_vrreg(vr,vrreg)
				asm_code(lname1+":")
			end if

		case AST_OP_ADD,AST_OP_SUB,AST_OP_MUL,AST_OP_DIV ''todo optimize xmm1 if memory
			select case op
				case AST_OP_ADD
					asm_code(addreg+"xmm0, xmm1")
				case AST_OP_SUB
					asm_code(subreg+"xmm0, xmm1")
				case AST_OP_MUL
					asm_code(mulreg+"xmm0, xmm1")
				case AST_OP_DIV
					asm_code(divreg+"xmm0, xmm1")
			end select
			if vr->dtype=FB_DATATYPE_DOUBLE then
				if v1dtype=FB_DATATYPE_SINGLE then
					asm_code("cvtss2sd xmm0, xmm0")
				end if
				asm_code("movq "+*regstrq(vrreg)+", xmm0")
			else
				asm_code("movd "+*regstrd(vrreg)+", xmm0")
			end if
			restore_vrreg(vr,vrreg)
		case AST_OP_ATAN2
			if v1dtype=FB_DATATYPE_DOUBLE then
				save_call("atan2",vr,vrreg)
				asm_code("movq "+*regstrq(vrreg)+", xmm0")
			else
				save_call("atan2f",vr,vrreg)
				asm_code("movd "+*regstrq(vrreg)+", xmm0")
			end if
		case else
			asm_error("in bop float needs to be coded : "+ *hGetBopCode(op))
	end select

end sub
private sub hloadoperandsandwritebop(byval op as integer,byval v1 as IRVREG ptr,byval v2 as IRVREG ptr,byval vr as IRVREG ptr,byval label as FBSYMBOL ptr =0)

	dim as string op1,op2,op3,op4,prefix1,prefix2,suffix,op1prev,regtempo,op1bis
	dim as FB_DATATYPE tempodtype,tempo2dtype
	dim as integer vrreg,vrreg2,tempo
	dim as IRVREG ptr vrtempo
	''========================= FIRST OPERAND ======================
	tempodtype=typeGetDtAndPtrOnly( v1->dtype )
	if typeisptr(tempodtype) then tempodtype=FB_DATATYPE_INTEGER
	select case tempodtype
		case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM,FB_DATATYPE_DOUBLE
			prefix1="QWORD PTR "
		case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
			prefix1="DWORD PTR "
		case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
			prefix1="WORD PTR "
		case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
			prefix1="BYTE PTR "
		case else
			asm_error("BOP datatype not handled 01 ="+typedumpToStr(v1->dtype,0))
	end select
	prefix2=prefix1
	select case v1->typ
		case IR_VREGTYPE_REG
			vrreg=reg_findreal(v1->reg)
			'op1=*regstrq(vrreg)
			'===
			select case tempodtype
				case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM,FB_DATATYPE_DOUBLE
					op1=*regstrq(vrreg)
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
					op1=*regstrd(vrreg)
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					op1=*regstrw(vrreg)
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					op1=*regstrb(vrreg)
				case else
					asm_error("BOP datatype not handled 010"+typedumpToStr(v1->dtype,0))
			end select
			'===
			prefix1=""
		case IR_VREGTYPE_IDX
			prepare_idx(v1,op1,op3)

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"

		case IR_VREGTYPE_IMM         ''rare case
			if ( typeGetClass( v1->dtype ) = FB_DATACLASS_FPOINT)  then
				op1=hFloatToHex_asm64(v1->value.f,v1->dtype,0)
			else
				if tempodtype=FB_DATATYPE_BOOLEAN then
					if v1->value.i<>0 then
						''force the value to 1
						v1->value.i=1
					end if
				end if
				op1=Str(v1->value.i)
			end if
			prefix1=""
		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero

			if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB andalso (symbIsCommon(v1->sym)) then ''linux dll common shared
				tempo=reg_findfree(999994)
				regtempo=*regstrq(tempo)
				op3="mov "+regtempo+", "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]"
				op1="["+regtempo+"]"
			else
				if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
					op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
				else
					op1=Str(v1->ofs)+"[rbp]"
				end if
			end if

		case else
			asm_error("in loadoperand typ not handled v1")
	end select
	''========================= SECOND OPERAND ======================
	select case v2->typ
		case IR_VREGTYPE_REG
			tempo=reg_findreal(v2->reg)
			select case tempodtype
				case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM,FB_DATATYPE_DOUBLE
					op2=*regstrq(tempo)
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
					op2=*regstrd(tempo)
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					op2=*regstrw(tempo)
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					op2=*regstrb(tempo)
				case else
					asm_error("BOP datatype not handled 012"+typedumpToStr(v1->dtype,0))
			end select

			prefix2=""
		case IR_VREGTYPE_IMM
			prefix2=""
			if ( typeGetClass( v2->dtype ) = FB_DATACLASS_FPOINT)  then
				op2=hFloatToHex_asm64(v2->value.f,v2->dtype,0)
			else
				if v2->dtype=FB_DATATYPE_BOOLEAN then
					if v2->value.i<>0 then
						''force the value to 1
						v2->value.i=1
					end if
				end if
				op2=Str(v2->value.i)
			end if

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			op2=Str(v2->ofs)+"["+*regstrq(reg_findreal(v2->vidx->reg))+"]"

		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op2=*symbGetMangledName(v2->sym)+"[rip+"+str(v2->ofs)+"]"

		case IR_VREGTYPE_IDX
			prepare_idx(v2,op2,op4)

		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero

			if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB andalso (symbIsCommon(v1->sym)) then

				tempo=reg_findfree(999993)
				regtempo=*regstrq(tempo)
				op4="mov "+regtempo+", "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]"
				op2="["+regtempo+"]"

			else

				if symbIsStatic(v2->sym) Or symbisshared(v2->sym) then
					op2=*symbGetMangledName(v2->sym)+"[rip+"+Str(v2->ofs)+"]"
				else
					op2=Str(v2->ofs)+"[rbp]"
				end if
			end if

		case else
			asm_error("in loadoperand typ not handled v2")
	end select

	''================ WRITING CODE =============

	if op3<>"" then emitop3_op4(op3)
	if op4<>"" then emitop3_op4(op4)

	If( typeGetClass( v1->dtype ) = FB_DATACLASS_FPOINT) Or ( typeGetClass( v2->dtype ) = FB_DATACLASS_FPOINT) then
		asm_info("Bop with float")
		bop_float(op,v1,v2,vr,op1,op2,op3,op4,prefix1,label)
		exit sub
	end if

	op1=prefix1+op1
	op2=prefix2+op2
	if vr<>0 then
		if v1->typ=IR_VREGTYPE_REG then ''use v1 for the result
			vr->reg=v1->reg
		else ''otherwise keep vr but move before op1
			vrreg=reg_findfree(vr->reg)
			if v1->typ=IR_VREGTYPE_OFS then
				asm_code("lea "+*regstrq(vrreg)+", "+op1)
				op1=*regstrq(vrreg)
			else
				select case tempodtype
					case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
						asm_code("mov "+*regstrq(vrreg)+", "+op1)
						op1=*regstrq(vrreg)
					case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
						asm_code("mov "+*regstrd(vrreg)+", "+op1)
						op1=*regstrd(vrreg)
					case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
						asm_code("mov "+*regstrw(vrreg)+", "+op1)
						op1=*regstrw(vrreg)
					case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
						asm_code("mov "+*regstrb(vrreg)+", "+op1)
						op1=*regstrb(vrreg)
					case else
						asm_error("BOP datatype not handled 011 ="+typedumpToStr(v1->dtype,0))
				end select
			end if
			prefix1=""
		end if
		if v2->typ=IR_VREGTYPE_OFS then
			vrreg2=reg_findfree(99999)
			asm_code("lea "+*regstrq(vrreg2)+", "+op2)
			op2=*regstrq(vrreg2)
		end if
	else
		if v1->typ=IR_VREGTYPE_OFS then
			vrreg2=reg_findfree(99999)
			asm_code("lea "+*regstrq(vrreg2)+", "+op1)
			op1=*regstrq(vrreg2)
		end if
		if op=AST_OP_MUL then ''dest and first operand MUST be a register
			if v1->typ<>IR_VREGTYPE_REG then
				vr = irhlAllocVreg( FB_DATATYPE_INTEGER, NULL )
				vrreg=reg_findfree(vr->reg)
				op1prev=op1
				asm_code("mov "+*regstrq(vrreg)+", "+op1)
				op1=*regstrq(vrreg)
			end if
		else
			if v2->typ<>IR_VREGTYPE_REG And v2->typ<>IR_VREGTYPE_IMM then
				''create a vreg for storing value op2 to avoid an operation with 2 not reg operands
				vrtempo = irhlAllocVreg(tempodtype, NULL )
				vrreg=reg_findfree(vrtempo->reg)
				if v2->typ=IR_VREGTYPE_OFS then
					asm_code("lea "+*regstrq(vrreg)+", "+op2)
					op2=*regstrq(vrreg)
				else
					select case tempodtype
						case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
							asm_code("mov "+*regstrq(vrreg)+", "+op2)
							op2=*regstrq(vrreg)
						case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
							asm_code("mov "+*regstrd(vrreg)+", "+op2)
							op2=*regstrd(vrreg)
						case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
							asm_code("mov "+*regstrw(vrreg)+", "+op2)
							op2=*regstrw(vrreg)
						case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
							asm_code("mov "+*regstrb(vrreg)+", "+op2)
							op2=*regstrb(vrreg)
						case else
							asm_error("BOP datatype not handled 012 ="+typedumpToStr(v1->dtype,0))
					end select
				end if
				'prefix=""
			end if
		end if
	end if

	if v2->typ=IR_VREGTYPE_IMM then
		if v2->value.i<-2147483648 or v2->value.i>=2147483648 then
			if v2->value.i<-2147483648 or v2->value.i>4294967295 then
				asm_code("mov rax, "+Str(v2->value.i))
			else
				asm_code("mov eax, "+Str(v2->value.i))
			end if
			op2="rax"
			select case tempodtype
				case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM,FB_DATATYPE_DOUBLE
					'op2="rax" ''already done
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
					op2="eax"
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					op2="ax"
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					op2="al"
				case else
					asm_error("BOP datatype not handled 0100 ="+typedumpToStr(v1->dtype,0))
			end select
		end if
	end if

	select case as const( op )
		case AST_OP_ADD
			if op2="1" then
				asm_code("inc "+op1)
			elseif op2="-1" then
				asm_code("dec "+op1)
			else
				asm_code("add "+op1+", "+op2)
			end if
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_AND
			asm_code("and "+op1+", "+op2)
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_OR
			asm_code("or "+op1+", "+op2)
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_IMP
			'===
			if vr<>0 then
				''op1 is already a register

				if tempodtype=FB_DATATYPE_BOOLEAN then
					asm_code("xor "+op1+", 1")
				else
					asm_code("not "+op1)
				end if

				select case tempodtype
					case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
						asm_code("mov "+*regstrq(KREG_RAX)+", "+op2)
						op2=*regstrq(KREG_RAX)
					case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
						asm_code("mov "+*regstrd(KREG_RAX)+", "+op2)
						op2=*regstrd(KREG_RAX)
					case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
						asm_code("mov "+*regstrw(KREG_RAX)+", "+op2)
						op2=*regstrw(KREG_RAX)
					case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
						asm_code("mov "+*regstrb(KREG_RAX)+", "+op2)
						op2=*regstrb(KREG_RAX)
					case else
						asm_error("BOP datatype not handled 012 ="+typedumpToStr(v1->dtype,0))
				end select
				asm_code("or "+op1+", "+op2)
				'asm_code("mov "+op1+", "+op2)
			else
				select case tempodtype
					case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
						asm_code("mov "+*regstrq(KREG_RAX)+", "+op1)
						op1bis=*regstrq(KREG_RAX)
					case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
						asm_code("mov "+*regstrd(KREG_RAX)+", "+op1)
						op1bis=*regstrd(KREG_RAX)
					case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
						asm_code("mov "+*regstrw(KREG_RAX)+", "+op1)
						op1bis=*regstrw(KREG_RAX)
					case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
						asm_code("mov "+*regstrb(KREG_RAX)+", "+op1)
						op1bis=*regstrb(KREG_RAX)
					case else
						asm_error("BOP datatype not handled 012 ="+typedumpToStr(v1->dtype,0))
				end select

				if tempodtype=FB_DATATYPE_BOOLEAN then
					asm_code("xor "+op1bis+", 1")
				else
					asm_code("not "+op1bis)
				end if
				''op2 is a register
				asm_code("or "+op1bis+", "+op2)
				asm_code("mov "+op1+", "+op1bis)
			end if
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_XOR
			asm_code("xor "+op1+", "+op2)
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_EQV
			'===
			select case tempodtype
				case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
					asm_code("mov "+*regstrq(KREG_RAX)+", "+op2)
					op2=*regstrq(KREG_RAX)
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
					asm_code("mov "+*regstrd(KREG_RAX)+", "+op2)
					op2=*regstrd(KREG_RAX)
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					asm_code("mov "+*regstrw(KREG_RAX)+", "+op2)
					op2=*regstrw(KREG_RAX)
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					asm_code("mov "+*regstrb(KREG_RAX)+", "+op2)
					op2=*regstrb(KREG_RAX)
				case else
					asm_error("BOP datatype not handled 012 ="+typedumpToStr(v1->dtype,0))
			end select
			asm_code("xor "+op2+", "+op1)
			if tempodtype=FB_DATATYPE_BOOLEAN then
				asm_code("xor "+op2+", 1")
			else
				asm_code("not "+op2)
			end if

			asm_code("mov "+op1+", "+op2)
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_SUB
			if op2="1" then
				asm_code("dec "+op1)
			elseif op2="-1" then
				asm_code("inc "+op1)
			else
				asm_code("sub "+op1+", "+op2)
			end if
			if vr<>0 then restore_vrreg(vr,vrreg)
		case AST_OP_MUL
			'if v1->typ<>IR_VREGTYPE_REG then
			'   'asm_code("mov rax, "+op1)
			'   asm_code("imul "+op2+", "+op1) ''op2 should be a register
			'   asm_code("mov "+op1+", rax")
			'else
			asm_code("imul "+op1+", "+op2)
			'end if
			if op1prev<>"" then asm_code("mov "+op1prev+", "+op1)
		case AST_OP_LE,AST_OP_LT,AST_OP_NE,AST_OP_GE,AST_OP_GT,AST_OP_EQ
			if v1->dtype=FB_DATATYPE_UINT Or v1->dtype=FB_DATATYPE_ULONGINT Or _
				v2->dtype=FB_DATATYPE_UINT Or v2->dtype=FB_DATATYPE_ULONGINT then ''for uinteger or ulongint usigned test
				select case as const( op )
					case AST_OP_LE
						suffix="be"
					case AST_OP_LT
						suffix="b"
					case AST_OP_NE
						suffix="ne"
					case AST_OP_GE
						suffix="nb"
					case AST_OP_GT
						suffix="a"
					case AST_OP_EQ
						suffix="e"
				end select
			else
				select case as const( op )
					case AST_OP_LE
						suffix="le"
					case AST_OP_LT
						suffix="l"
					case AST_OP_NE
						suffix="ne"
					case AST_OP_GE
						suffix="ge"
					case AST_OP_GT
						suffix="g"
					case AST_OP_EQ
						suffix="e"
				end select
			end if

			asm_code("cmp "+op1+", "+op2)

			if label=0 then
				asm_code("set"+suffix+" al")
				asm_code("movzx "+*regstrq(vrreg)+", al")

				if tempodtype<>FB_DATATYPE_BOOLEAN then
					asm_code("neg "+*regstrq(vrreg))
				end if
				restore_vrreg(vr,vrreg)
			else
				asm_code("j"+suffix+" "+*symbGetMangledName( label ))
				reg_mark(label)
			end if

		case AST_OP_SHL,AST_OP_SHR
			if v2->typ<>IR_VREGTYPE_IMM then
				if op2<>*regstrq(KREG_RCX) then
					if reghandle(KREG_RCX)<>KREGFREE then ''as rcx is used need to transfer its contain to another register
						tempo=reghandle(KREG_RCX)
						reg_findfree(tempo)
						reghandle(KREG_RCX)=KREGFREE
						asm_info("rcx used so transfer to other register")
						asm_code("mov "+*regstrq(reg_findreal(tempo))+", "+*regstrq(KREG_RCX))
						if vrreg=KREG_RCX then vrreg=reg_findreal(tempo)
					else
						ctx.usedreg Or=(1 Shl KREG_RCX)
					end if
					asm_code("mov rcx, "+op2)
				end if
				op2="cl"
			end if
			if op=AST_OP_SHL then
				asm_code("shl "+op1+", "+op2)
			else
				if tempodtype=FB_DATATYPE_INTEGER or tempodtype=FB_DATATYPE_LONGINT then
					asm_code("sar "+op1+", "+op2)
			else
					asm_code("shr "+op1+", "+op2)
				end if
			end if
		case AST_OP_INTDIV '' idiv instruction uses rax and rdx
			if reghandle(KREG_RDX)<>KREGFREE then ''as rdx is used need to transfer its contain to another register
				'if op1<>*regstrq(KREG_RDX) And op2<>*regstrq(KREG_RDX) then ''except when <> op1 and op2
				if op1<>*regstrq(KREG_RDX) then ''if op1=rdx do nothing as it's transfered in rax
					tempo=reghandle(KREG_RDX)
					reg_findfree(tempo)
					reghandle(KREG_RDX)=KREGFREE
					asm_info("rdx used so transfer to other register="+*regstrq(reg_findreal(tempo)))
					asm_code("mov "+*regstrq(reg_findreal(tempo))+", "+*regstrq(KREG_RDX))
					if op2=*regstrq(KREG_RDX) then
						op2=*regstrq(reg_findreal(tempo))
					end if
					if vrreg=KREG_RDX then vrreg=reg_findreal(tempo)
				end if
			else
				ctx.usedreg Or=(1 Shl KREG_RDX)
			end if

			if v2->typ=IR_VREGTYPE_IMM then
				''can't use directly immediat value so transfering in a free register but not in RDX.....
				if reghandle(KREG_RDX)=KREGFREE then reghandle(KREG_RDX)=KREGRSVD
				regtempo=*reg_tempo()
				if reghandle(KREG_RDX)=KREGRSVD then reghandle(KREG_RDX)=KREGFREE
				asm_code("mov "+regtempo+", "+op2)
				op2=regtempo
			end if

			asm_code("mov rax, "+op1)

			tempo2dtype=v2->dtype
			if typeisptr(tempo2dtype) then tempo2dtype=FB_DATATYPE_INTEGER

			if tempodtype=FB_DATATYPE_UINT or tempodtype=FB_DATATYPE_ULONGINT or tempo2dtype=FB_DATATYPE_UINT or tempo2dtype=FB_DATATYPE_ULONGINT then
				asm_code("mov edx, 0")
				asm_code("div "+op2)
			else
				asm_code("cqo")
				asm_code("idiv "+op2)
			end if

			if vr=0 then
				asm_code("mov "+op1+", rax")
			else
				asm_code("mov "+*regstrq(vrreg)+", rax")
				restore_vrreg(vr,vrreg)
			end if

		case AST_OP_MOD ''mod instruction uses rax and rdx, to be checked carefully
			if reghandle(KREG_RDX)<>KREGFREE then ''as rdx is used need to transfer its contain to another register
				'if op1<>*regstrq(KREG_RDX) And op2<>*regstrq(KREG_RDX) then ''except when <> op1 and op2
				if op1<>*regstrq(KREG_RDX) then ''if op1=rdx do nothing as it's transfered in rax
					tempo=reghandle(KREG_RDX)
					reg_findfree(tempo)
					reghandle(KREG_RDX)=KREGFREE
					asm_info("rdx used so transfer to other register="+*regstrq(reg_findreal(tempo)))
					asm_code("mov "+*regstrq(reg_findreal(tempo))+", "+*regstrq(KREG_RDX))
					if op2=*regstrq(KREG_RDX) then
						op2=*regstrq(reg_findreal(tempo))
					end if
					if vrreg=KREG_RDX then vrreg=reg_findreal(tempo)
				end if
			else
				ctx.usedreg Or=(1 Shl KREG_RDX)
			end if

			if v2->typ=IR_VREGTYPE_IMM then
				''can't use directly immediat value so transfering in a free register but not in RDX.....
				if reghandle(KREG_RDX)=KREGFREE then reghandle(KREG_RDX)=KREGRSVD
				regtempo=*reg_tempo()
				if reghandle(KREG_RDX)=KREGRSVD then reghandle(KREG_RDX)=KREGFREE
				asm_code("mov "+regtempo+", "+op2)
				op2=regtempo
			end if

			asm_code("mov rax, "+op1)

			tempo2dtype=v2->dtype
			if typeisptr(tempo2dtype) then tempo2dtype=FB_DATATYPE_INTEGER

			if tempodtype=FB_DATATYPE_UINT or tempodtype=FB_DATATYPE_ULONGINT or tempo2dtype=FB_DATATYPE_UINT or tempo2dtype=FB_DATATYPE_ULONGINT then
				asm_code("mov edx, 0")
				asm_code("div "+op2)
			else
				asm_code("cqo")
				asm_code("idiv "+op2)
			end if

			if vr=0 then
				asm_code("mov "+op1+", rdx")
			else
				asm_code("mov "+*regstrq(vrreg)+", rdx")
				restore_vrreg(vr,vrreg)
			end if

		case else
			asm_error("op int needs to be coded : "+ *hGetBopCode(op))
	end select

end sub
private sub _emitbop(byval op as integer,byval v1 as IRVREG ptr,byval v2 as IRVREG ptr,byval vr as IRVREG ptr,byval label as FBSYMBOL ptr)
	dim as FB_DATATYPE dtype
	#ifdef __GAS64_DEBUG__
		var bopdump = vregPretty( v1 ) + " " + astdumpopToStr( op ) + " " + vregPretty( v2 )
	#endif

	if( label ) then
		asm_info("branchbop " + bopdump +" "+*symbGetMangledName( label ))
	elseif( vr = NULL ) then
		asm_info("selfbop " + bopdump )
	else
		asm_info("bop " + bopdump )
	end if
	asm_info("v1="+vregdumpfull(v1))
	asm_info("v2="+vregdumpfull(v2))

	if vr=0 then
		asm_info("Vr=0 op =>"+*hGetBopCode(op))
	else
		asm_info("vr="+vregdumpfull(vr))
		asm_info("Vr<>0 op =>"+*hGetBopCode(op))
	end if
	if v1->sym <>0 andalso v1->dtype<>v1->sym->typ and (typeGetClass( v1->sym->typ)) = FB_DATACLASS_INTEGER _
		and typeGetSize( v1->dtype ) <> typeGetSize( v1->sym->typ )  then
		asm_info("STRANGE CASE v1->dtype <> v1->sym->typ")
		asm_info("v1 type="+str(v1->dtype)+" "+"v1 sym type="+str(v1->sym->typ))
		asm_info("size v1="+str(typeGetSize( v1->dtype ))+" size sym="+str( typeGetSize( v1->sym->typ ) ) )
		dtype=v1->dtype
		if typeisptr(v1->dtype) then
			asm_info("STRANGE CASE but as ptr type do nothing")
		else
			v1->dtype=v1->sym->typ
			_setvregdatatype(v1,dtype,0)
		end if
	end if
	hLoadOperandsAndWriteBop( op, v1, v2, vr,label )

end sub
private sub _emituop(byval op as integer,byval v1 as IRVREG ptr,byval vr as IRVREG Ptr)
	dim as string op1,op3,prefix
	dim as long vrreg,tempo
	dim as FB_DATATYPE tempodtype

	#ifdef __GAS64_DEBUG__
		var uopdump = astdumpopToStr( op ) + " " + vregPretty( v1 )
	#endif

	asm_info("v1="+vregdumpfull(v1))
	if( vr = NULL ) then
		asm_info( "selfuop " + uopdump )
	else
		asm_info( "uop " + uopdump )
		asm_info("vr="+vregdumpfull(vr))
	end if


	if vr<>0 then
		if v1->typ<>IR_VREGTYPE_REG then
			select case vr->typ
				case IR_VREGTYPE_REG
					vrreg=reg_findfree(vr->reg)
				case else
					asm_error("in emituop typ not handled vr")
			end select
		else
			asm_info("changing uop virtual register vr->reg=v1->reg")
			vr->reg=v1->reg
			vrreg=reg_findreal(v1->reg)
		end if
	end if

	tempodtype=typeGetDtAndPtrOnly( v1->dtype )
	if typeisptr(tempodtype) then tempodtype=FB_DATATYPE_INTEGER
	select case tempodtype
		case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_ENUM
			prefix="QWORD PTR "
		case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
			prefix="DWORD PTR "
		case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
			prefix="WORD PTR "
		case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
			prefix="BYTE PTR "
		case else
			asm_error("UOP datatype not handled 01 ="+typedumpToStr(v1->dtype,0))
	end select

	select case v1->typ
		case IR_VREGTYPE_REG

			if tempodtype=FB_DATATYPE_BOOLEAN then
				op1=*regstrb(reg_findreal(v1->reg))
			else
				op1=*regstrq(reg_findreal(v1->reg))
			end if

			prefix=""

		case IR_VREGTYPE_IDX
			prepare_idx(v1,op1,op3)
		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"

		case IR_VREGTYPE_IMM

		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
			if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
				op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
			else
				op1=Str(v1->ofs)+"[rbp]"
			end if
		case else
			asm_error("in uop typ not handled v1")
	end select

	if op3<>"" then emitop3_op4(op3)

	op1=prefix+op1

	if op=AST_OP_NOT then
		if vr<>0 and v1->typ<>IR_VREGTYPE_REG then
			'vrreg=reg_findfree(vr->reg)
			select case tempodtype
				case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
					asm_code("mov "+*regstrq(vrreg)+", "+op1)
					op1=*regstrq(vrreg)
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
					asm_code("mov "+*regstrd(vrreg)+", "+op1)
					op1=*regstrd(vrreg)
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					asm_code("mov "+*regstrw(vrreg)+", "+op1)
					op1=*regstrw(vrreg)
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					asm_code("mov "+*regstrb(vrreg)+", "+op1)
					op1=*regstrb(vrreg)
				case else
					asm_error("UOP datatype not handled 011 ="+typedumpToStr(v1->dtype,0))
			end select
			'===
		end if

		if tempodtype=FB_DATATYPE_BOOLEAN then
			asm_code("test "+op1+", "+op1)
			asm_code("sete "+op1)
		else
			asm_code("not "+op1)
		end if

		return
	end if

	if tempodtype = FB_DATATYPE_SINGLE then
		if v1->typ=IR_VREGTYPE_REG then
			asm_code("movd xmm0, "+op1)
		else
			asm_code("movss xmm0, "+op1)
		end if

		select case op
			case AST_OP_COS
				save_call("cosf",vr,vrreg)
			case AST_OP_SIN
				save_call("sinf",vr,vrreg)
			case AST_OP_EXP
				save_call("expf",vr,vrreg)
			case AST_OP_LOG
				save_call("logf",vr,vrreg)
			case AST_OP_ACOS
				save_call("acosf",vr,vrreg)
			case AST_OP_ASIN
				save_call("asinf",vr,vrreg)
			case AST_OP_TAN
				save_call("tanf",vr,vrreg)
			case AST_OP_ATAN
				save_call("atanf",vr,vrreg)
			case AST_OP_SQRT
				asm_code("sqrtss    xmm0, xmm0") ''todo could do directly with op1
				restore_vrreg(vr,vrreg)
			case AST_OP_ABS
				asm_code("mov eax, 0x7FFFFFFF")
				asm_code("movd xmm1, eax")
				asm_code("andps xmm1, xmm0") ''result xmm1
				asm_code("movd xmm0, xmm1")''just to keep a standard way after
				restore_vrreg(vr,vrreg)
			case AST_OP_SGN
				save_call("fb_SGNSingle",vr,vrreg)
			case AST_OP_FRAC
				save_call("fb_FRACf",vr,vrreg)
			case AST_OP_FIX
				save_call("fb_FIXSingle",vr,vrreg)
			case AST_OP_FLOOR
				save_call("floorf",vr,vrreg)
			case AST_OP_NEG
				asm_code("mov eax, "+"0x80000000") ''todo check and exchange if error
				asm_code("movd xmm1, eax")
				asm_code("xorps xmm0, xmm1") ''result in xmm0
				restore_vrreg(vr,vrreg)
			case else
				asm_error("in uop not handled for single")
		end select
		if op=AST_OP_SGN then
			''returning value is in eax
			asm_code("mov "+*regstrd(vrreg)+", eax")
		else
			asm_code("movd "+*regstrd(vrreg)+", xmm0")
		end if
		return
	end if
	''some case for integer
	if op=AST_OP_ABS And tempodtype <> FB_DATATYPE_DOUBLE then
		asm_code("mov rax, "+op1)

		if reghandle(KREG_RDX)<>KREGFREE then ''as rdx is used need to transfer its contain to another register
			tempo=reghandle(KREG_RDX)
			reg_findfree(tempo)
			reghandle(KREG_RDX)=KREGFREE
			asm_info("rdx used so transfer to other register")
			asm_code("mov "+*regstrq(reg_findreal(tempo))+", "+*regstrq(KREG_RDX))
			if vrreg=KREG_RDX then vrreg=reg_findreal(tempo)
		else
			ctx.usedreg Or=(1 Shl KREG_RDX)
		end if

		asm_code("cqo")
		asm_code("xor rax, rdx")
		asm_code("sub rax, rdx") ''result in rax
		if vr=0 then
			asm_code("mov "+op1+", rax")
		else
			asm_code("mov "+*regstrq(vrreg)+", rax")
			restore_vrreg(vr,vrreg)
		end if
		return
	end if

	if op=AST_OP_NEG And tempodtype <> FB_DATATYPE_DOUBLE then

		if vr<>0 and v1->typ<>IR_VREGTYPE_REG then
			asm_code("mov "+*regstrq(vrreg)+", "+op1)
			op1=*regstrq(vrreg)
		end if

		asm_code("neg "+op1)
		if vr<>0 then restore_vrreg(vr,vrreg)
		return
	end if

	if op=AST_OP_SGN And tempodtype <> FB_DATATYPE_DOUBLE then
		var lname = *symbUniqueLabel( )
		if v1->typ=IR_VREGTYPE_REG then
			asm_code("cmp "+op1+", 0")
			asm_code("je "+lname)
			asm_code("mov "+op1+", 1")
			asm_code("jg "+lname)
			asm_code("mov "+op1+", -1")
			asm_code(lname+":")
			''as same register used need to forced
			restore_vrreg(vr,vrreg)
			''result in a 64bit register but doesn't matter
		else
			asm_code("mov rax, "+op1)
			asm_code("cmp rax, 0")
			asm_code("je "+lname)
			asm_code("mov eax, 1")
			asm_code("jg "+lname)
			asm_code("mov rax, -1")
			asm_code(lname+":")
			if vr=0 then
				asm_code("mov "+op1+", rax")
			else
				asm_code("mov "+*regstrq(vrreg)+", rax")
			end if
		end if
		return
	end if
	''for double , integer must have been converted before
	if v1->typ=IR_VREGTYPE_REG then
		asm_code("movq xmm0, "+op1)
	else
		asm_code("movsd xmm0, "+op1)
	end if
	select case op
		case AST_OP_COS
			save_call("cos",vr,vrreg)
		case AST_OP_SIN
			save_call("sin",vr,vrreg)
		case AST_OP_EXP
			save_call("exp",vr,vrreg)
		case AST_OP_LOG
			save_call("log",vr,vrreg)
		case AST_OP_ACOS
			save_call("acos",vr,vrreg)
		case AST_OP_ASIN
			save_call("asin",vr,vrreg)
		case AST_OP_TAN
			save_call("tan",vr,vrreg)
		case AST_OP_ATAN
			save_call("atan",vr,vrreg)
		case AST_OP_ABS
			asm_code("mov rax, 0x7FFFFFFFFFFFFFFF")
			asm_code("movq xmm1, rax")
			asm_code("andpd xmm1, xmm0") ''result xmm1
			asm_code("movq xmm0, xmm1") ''just to keep a standard way after
			restore_vrreg(vr,vrreg)
		case AST_OP_SQRT
			asm_code("sqrtsd    xmm0, xmm0") ''todo could do directly with op1
			restore_vrreg(vr,vrreg)
		case AST_OP_SGN
			save_call("fb_SGNDouble",vr,vrreg)
		case AST_OP_FRAC
			save_call("fb_FRACd",vr,vrreg)
		case AST_OP_FIX
			save_call("fb_FIXDouble",vr,vrreg)
		case AST_OP_FLOOR
			save_call("floor",vr,vrreg)
		case AST_OP_NEG
			asm_code("mov rax, "+"0x8000000000000000") ''todo check and exchange if error
			asm_code("movq xmm1, rax")
			asm_code("xorpd xmm0, xmm1") ''result in xmm0
			restore_vrreg(vr,vrreg)
		case else
			asm_error("in uop not handled for double")
	end select
	if op=AST_OP_SGN then
		''returning a long
		asm_code("movsxd "+*regstrq(vrreg)+", eax")
	else
		asm_code("movq "+*regstrq(vrreg)+", xmm0")
	end if
end sub
private sub hEmitRoundFloat(byval dtype1 as FB_DATATYPE,byval dtype2 as FB_DATATYPE = FB_DATATYPE_INVALID)
	dim as string lname1,lname2
	'' Puts ctx.roundfloat to true for later adding of the code filling $sse41[rip]
	ctx.roundfloat=true
	asm_code("test DWORD PTR $sse41[rip], 0b10000000000000000000")
	lname1 = *symbUniqueLabel( )
	asm_code("je "+lname1)

	if dtype1=FB_DATATYPE_DOUBLE then
		asm_code("roundsd xmm0,xmm0,4")
		if dtype2<>FB_DATATYPE_ULONGINT then
			asm_code("cvttsd2si rax, xmm0")
		end if
	else
	''single
		asm_code("roundss xmm0,xmm0,4")
		if dtype2<>FB_DATATYPE_ULONGINT then
			asm_code("cvttss2si rax, xmm0")
		end if
	endif

	lname2 = *symbUniqueLabel( )
	asm_code("jmp "+lname2)
	asm_code(lname1+":")

	if dtype1=FB_DATATYPE_DOUBLE then
		if dtype2<>FB_DATATYPE_ULONGINT then
			no_roundsd(@"d")
		else
			asm_code("call nearbyint")
		end if
	else
	''single
		if dtype2<>FB_DATATYPE_ULONGINT then
			no_roundsd(@"s")
		else
			asm_code("call nearbyintf")
		end if
	endif

	asm_code(lname2+":")
end sub
private sub _emitconvert( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )

	dim as FB_DATATYPE v1dtype,v2dtype,v1old
	dim as string lname1,lname2,regtempo
	dim as string op1,op2,op3,op4,prefix1,prefix2
	dim as long regresult,srcreg,reg

	asm_info("CONVERTING " + vregPretty( v1 ) + " := " + vregPretty( v2 ))
	asm_info("v1="+vregdumpfull(v1)+" xx "+Str(v1->reg))
	asm_info("v2="+vregdumpfull(v2)+" xx "+Str(v2->reg))

	if v1->typ<>IR_VREGTYPE_REG then
		asm_error("v1 in converting not a reg")
	end if

	v1dtype=typeGetDtAndPtrOnly( v1->dtype )''2019/10/28 typeGetDtAndPtrOnly adding for const case
	v2dtype=typeGetDtAndPtrOnly( v2->dtype )

	if( typeIsPtr( v1dtype ) and  typeIsPtr( v2dtype ) ) then
		asm_info("pointer2 -> pointer1")
		*v1=*v2
		exit sub
	end if

	if typeisptr(v1dtype) then v1dtype=FB_DATATYPE_LONGINT
	if typeisptr(v2dtype) then v2dtype=FB_DATATYPE_LONGINT

	if v1dtype=FB_DATATYPE_INTEGER then
		v1dtype=FB_DATATYPE_LONGINT
	elseif v1dtype=FB_DATATYPE_ENUM then
		v1dtype=FB_DATATYPE_LONGINT
	elseif v1dtype=FB_DATATYPE_UINT then
		v1dtype=FB_DATATYPE_ULONGINT
	end if
	if v2dtype=FB_DATATYPE_INTEGER then
		v2dtype=FB_DATATYPE_LONGINT
	elseif v2dtype=FB_DATATYPE_ENUM then
		v2dtype=FB_DATATYPE_LONGINT
	elseif v2dtype=FB_DATATYPE_UINT then
		v2dtype=FB_DATATYPE_ULONGINT
	end if

	if v1->typ=IR_VREGTYPE_REG and v2->typ=IR_VREGTYPE_REG and (typeGetSize( v1dtype )  = typeGetSize( v2dtype )) and _
	   (typeGetClass( v1dtype )=typeGetClass( v2dtype ) ) then
	   asm_info("no move as exactly same size, vreg changed"+Str(v1->reg)+" becomes "+Str(v2->reg))
	   v1->reg=v2->reg
	   exit sub
	end if

	if (v1dtype=FB_DATATYPE_LONGINT and v2dtype=FB_DATATYPE_LONGINT) or (v1dtype=FB_DATATYPE_ULONGINT and v2dtype=FB_DATATYPE_ULONGINT) then
		asm_info("no convert as exactly same datatype")
		*v1=*v2
		exit sub
	end if

	'' prbm with for/next
	if (v1dtype=FB_DATATYPE_LONGINT and v2dtype=FB_DATATYPE_ULONGINT) Or (v2dtype=FB_DATATYPE_LONGINT and v1dtype=FB_DATATYPE_ULONGINT) then
		asm_info("no convert as INTEGER/UINT")
		v1old=v1->dtype
		*v1=*v2
		v1->dtype=v1old
		exit sub
	end if

	if (v1dtype=FB_DATATYPE_STRING and v2dtype=FB_DATATYPE_STRUCT) then
		asm_info("no convert as STRUCT -> STRING")
		*v1=*v2
		exit sub
	end if

	if (v1dtype=FB_DATATYPE_STRUCT and v2dtype=FB_DATATYPE_STRUCT) then
		asm_info("converting STRUCT -> STRUCT")
		dim as FBSYMBOL ptr v1subtype=v1->subtype
		*v1=*v2
		v1->subtype=v1subtype ''forcing the subtype of the desired structure
		asm_info("v1="+vregdumpfull(v1)+" xx "+Str(v1->reg))
		exit sub
	end if

	reg_findfree(v1->reg)
	regresult=reg_findreal(v1->reg)

	if v1dtype=FB_DATATYPE_STRING then v1dtype=FB_DATATYPE_LONGINT
	select case v1dtype
		case FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_STRUCT
			prefix1="QWORD PTR "
			op1=*regstrq(regresult)
		case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
			prefix1="DWORD PTR "
			op1=*regstrd(regresult)
		case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
			prefix1="WORD PTR "
			op1=*regstrw(regresult)
		case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
			prefix1="BYTE PTR "
			op1=*regstrb(regresult)
		case else
			asm_error("converting datatype not handled 01 ="+typedumpToStr(v1->dtype,0))
	end select

	''SOURCE

	select case v2dtype
		case FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_STRUCT
			prefix2="QWORD PTR "
		case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
			prefix2="DWORD PTR "
		case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
			prefix2="WORD PTR "
		case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
			prefix2="BYTE PTR "
		case FB_DATATYPE_WCHAR ''windows 2 bytes / linux 4 bytes or less !!!! todo no coding lenght like that use existing function
			if typeGetSize( FB_DATATYPE_WCHAR )=2 then
				prefix2="WORD PTR "
				v2dtype=FB_DATATYPE_USHORT
			elseif typeGetSize( FB_DATATYPE_WCHAR )=4 then
				prefix2="DWORD PTR "
				v2dtype=FB_DATATYPE_ULONG
			else
				asm_error("converting datatype WCHAR not handled")
			end if
		case else
			asm_error("converting datatype not handled 02 ="+typedumpToStr(v2->dtype,0))
	end select

	select case v2->typ ''source

		case IR_VREGTYPE_IDX
			prepare_idx(v2,op2,op4)

		case IR_VREGTYPE_REG
			prefix2=""
			srcreg=reg_findreal(v2->reg)
			if typeisptr(v2dtype) then v2dtype=FB_DATATYPE_LONGINT
			select case v2dtype
				case FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE
					op2=*regstrq(srcreg)
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
					op2=*regstrd(srcreg)
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					op2=*regstrw(srcreg)
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					op2=*regstrb(srcreg)
				case else
					asm_error("Converting datatype not handled 03 ="+typedumpToStr(v2->dtype,0))
			end select

		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
			if symbIsStatic(v2->sym) Or symbisshared(v2->sym) then
				if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
					op2=*symbGetMangledName(v2->sym)+"@GOTPCREL[rip]" '[rip+"+Str(v2->ofs)+"]"
				else
					op2=*symbGetMangledName(v2->sym)+"[rip+"+Str(v2->ofs)+"]"
				end if
			else
				op2=Str(v2->ofs)+"[rbp]"
			end if

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			op2=Str(v2->ofs)+"["+*regstrq(reg_findreal(v2->vidx->reg))+"]"

		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op2=*symbGetMangledName(v2->sym)+"[rip+"+str(v2->ofs)+"]"
			if typeGetDtOnly( v2->dtype )=FB_DATATYPE_FUNCTION andalso ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
				asm_code("mov rax, QWORD PTR "+left(op2,instr(op2,"[")-1)+"@GOTPCREL[rip]")
				asm_code("mov "+op1+", rax",KNOOPTIM)
			else
				asm_code("lea "+op1+", "+op2,KNOOPTIM)
			end if
			exit sub
		case IR_VREGTYPE_IMM
			prefix1=""
			if typeGetClass( v2->dtype ) = FB_DATACLASS_FPOINT then
				op2=hFloatToHex_asm64(v2->value.f,v2->dtype,0)
			else
				op2=str(v2->value.i)
			end if

		case else
			asm_error("store 02 ??")
	end select
	''====================  writing code ===============================
	if op4<>"" then emitop3_op4(op4)
	If( typeGetClass( v1dtype ) = FB_DATACLASS_FPOINT ) then ''convert to float
		if( typeGetClass( v2dtype ) = FB_DATACLASS_FPOINT ) then  '' float to float (single <-> double)

			if v1dtype=FB_DATATYPE_DOUBLE then  'Single to double
				asm_info("single to double")
				if v2->typ=IR_VREGTYPE_REG then
					asm_code("movd xmm0, "+op2)
					op2="xmm0"
				end if
				asm_code("cvtss2sd xmm0, "+op2)
				asm_code("movq "+op1+", xmm0")
			else 'Double to single
				asm_info("double to single")
				if v2->typ=IR_VREGTYPE_REG then
					asm_code("movq xmm1, "+op2)
					op2="xmm1"
				end if
				asm_code("cvtsd2ss xmm0, "+op2)
				asm_code("movd "+op1+", xmm0")
			end if
		else
			''int to float
			asm_info("int to float")
			asm_code("pxor xmm0,xmm0")
			select case v2dtype
				case FB_DATATYPE_ULONGINT
					if v1dtype=FB_DATATYPE_DOUBLE then
						asm_code("mov rax, "+op2)
						asm_code("test  rax, rax")
						lname1 = *symbUniqueLabel( )
						asm_code("js "+lname1)
						asm_code("cvtsi2sd xmm0, rax")
						lname2 = *symbUniqueLabel( )
						asm_code("jmp "+lname2)
						asm_code(lname1+":")

						reg=reg_findfree(999999)
						regtempo=*regstrq(reg)
						reghandle(reg)=KREGFREE

						asm_code("mov "+regtempo+", rax")
						asm_code("shr "+regtempo)
						asm_code("and eax, 1")
						asm_code("or "+regtempo+", rax")
						asm_code("cvtsi2sd xmm0, "+regtempo)
						asm_code("addsd xmm0, xmm0")
						asm_code(lname2+":")
						asm_code("movq "+op1+", xmm0")
					else''single
						asm_code("mov rax, "+op2)
						asm_code("test rax, rax")
						lname1 = *symbUniqueLabel( )
						asm_code("js "+lname1)
						asm_code("cvtsi2ss  xmm0, rax")
						lname2 = *symbUniqueLabel( )
						asm_code("jmp "+lname2)
						asm_code(lname1+":")

						reg=reg_findfree(999999)
						regtempo=*regstrq(reg)
						reghandle(reg)=KREGFREE

						asm_code("mov "+regtempo+", rax")
						asm_code("shr "+regtempo)
						asm_code("and eax, 1")
						asm_code("or "+regtempo+", rax")
						asm_code("cvtsi2ss xmm0, "+regtempo)
						asm_code("addss xmm0, xmm0")
						asm_code(lname2+":")
						asm_code("movd "+op1+", xmm0")
					end if
				case FB_DATATYPE_LONGINT''todo regroup ?
					if v1dtype=FB_DATATYPE_DOUBLE then
						asm_code("cvtsi2sd xmm0, "+prefix2+op2)
						asm_code("movq "+op1+", xmm0")
					else
						asm_code("cvtsi2ss xmm0, "+prefix2+op2)
						asm_code("movd "+op1+", xmm0")
					end if

				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
					if v1dtype=FB_DATATYPE_DOUBLE then
						asm_code("cvtsi2sd xmm0, "+prefix2+op2)
						asm_code("movq "+op1+", xmm0")
					else
						asm_code("cvtsi2ss xmm0, "+prefix2+op2)
						asm_code("movd "+op1+", xmm0")
					end if

				case FB_DATATYPE_BYTE,FB_DATATYPE_SHORT,FB_DATATYPE_UBYTE,FB_DATATYPE_USHORT,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR',FB_DATATYPE_WCHAR
					if v2dtype=FB_DATATYPE_BYTE Or v2dtype=FB_DATATYPE_SHORT then
						asm_code("movsx eax, "+prefix2+op2)
					elseif v2dtype=FB_DATATYPE_BOOLEAN then
						asm_code("cmp "+prefix2+op2+", 0")
						asm_code("setne al")
						asm_code("neg al")
						asm_code("movsx eax, al")
					else
						asm_code("movzx eax, "+prefix2+op2)
					end if
					if v1dtype=FB_DATATYPE_DOUBLE then
						asm_code("cvtsi2sd xmm0, eax")
						asm_code("movq "+op1+", xmm0")
					else
						asm_code("cvtsi2ss xmm0, eax")
						asm_code("movd "+op1+", xmm0")
					end if
				case else
					asm_error("Converting datatype not handled 04")
			end select
		end if
		exit sub
	end if
	'' Converting float to int
	If( (typeGetClass( v2dtype ) = FB_DATACLASS_FPOINT) and (typeGetClass( v1dtype ) = FB_DATACLASS_INTEGER) ) then
		asm_info("float to int")
		'' double to int
		if v2dtype=FB_DATATYPE_DOUBLE then

			if v1dtype=FB_DATATYPE_ULONGINT then
				asm_code("mov rax, 4890909195324358656")
				asm_code("movq xmm2, rax")
				asm_code("mov rax, "+op2)
				asm_code("movq xmm0, rax")

				hEmitRoundFloat(FB_DATATYPE_DOUBLE,FB_DATATYPE_ULONGINT)

				asm_code("ucomisd xmm0, xmm2")
				lname1 = *symbUniqueLabel( )
				asm_code("jnb "+lname1)
				asm_code("cvttsd2si rax, xmm0")
				lname2 = *symbUniqueLabel( )
				asm_code("jmp "+lname2)
				asm_code(lname1+":")
				asm_code("movsd xmm1, xmm2")
				asm_code("subsd xmm0, xmm1")
				asm_code("cvttsd2si rax, xmm0")

				reg=reg_findfree(999999)
				regtempo=*regstrq(reg)
				reghandle(reg)=KREGFREE

				asm_code("movabs "+regtempo+", -9223372036854775808")
				asm_code("xor rax,"+regtempo)
				asm_code(lname2+":")
				asm_code("mov "+op1+", rax")

			elseif v1dtype=FB_DATATYPE_LONGINT _
				Or  v1dtype=FB_DATATYPE_LONG Or v1dtype=FB_DATATYPE_ULONG _
				Or  v1dtype=FB_DATATYPE_SHORT Or v1dtype=FB_DATATYPE_USHORT _
				Or  v1dtype=FB_DATATYPE_BYTE Or v1dtype=FB_DATATYPE_UBYTE _
				Or  v1dtype=FB_DATATYPE_BOOLEAN Or v1dtype=FB_DATATYPE_CHAR then

				if v2->Typ=IR_VREGTYPE_REG then
					asm_code("movq xmm0, "+op2)
				else
					asm_code("movsd xmm0, "+op2)
				end if

				hEmitRoundFloat(FB_DATATYPE_DOUBLE)

				if v1dtype=FB_DATATYPE_LONGINT then
					asm_code("mov "+op1+", rax")
				elseif v1dtype=FB_DATATYPE_LONG Or v1dtype=FB_DATATYPE_ULONG then
					asm_code("mov "+op1+", eax")
				elseif v1dtype=FB_DATATYPE_SHORT Or v1dtype=FB_DATATYPE_USHORT then
					asm_code("mov "+op1+", ax")
				else
					if v1dtype=FB_DATATYPE_BOOLEAN then
						asm_info("Double to boolean, <>0 --> 1")
						asm_code("cmp rax, 0")
						asm_code("setne al")
						'asm_code("neg al")
					end if
					asm_code("mov "+op1+", al")
				end if
			else
				asm_error("Converting float to int 01")
			end if
		else
			 ''single to int
			if v1dtype=FB_DATATYPE_ULONGINT then
				asm_code("mov rax, 1593835520")
				asm_code("movq xmm2, rax")
				asm_code("mov eax, "+op2)
				asm_code("movd xmm0, eax")

				hEmitRoundFloat(FB_DATATYPE_SINGLE,FB_DATATYPE_ULONGINT)

				asm_code("ucomiss xmm0, xmm2")
				lname1 = *symbUniqueLabel( )
				asm_code("jnb "+lname1)
				asm_code("cvttss2si rax, xmm0")
				lname2 = *symbUniqueLabel( )
				asm_code("jmp "+lname2)
				asm_code(lname1+":")
				asm_code("movss xmm1, xmm2")
				asm_code("subss xmm0, xmm1")
				asm_code("cvttss2si rax, xmm0")

				reg=reg_findfree(999999)
				regtempo=*regstrq(reg)
				reghandle(reg)=KREGFREE

				asm_code("movabs "+regtempo+", -9223372036854775808")
				asm_code("xor rax,"+regtempo)
				asm_code(lname2+":")
				asm_code("mov "+op1+", rax")

			elseif v1dtype=FB_DATATYPE_LONGINT _
				Or  v1dtype=FB_DATATYPE_LONG Or v1dtype=FB_DATATYPE_ULONG _
				Or  v1dtype=FB_DATATYPE_SHORT Or v1dtype=FB_DATATYPE_USHORT _
				Or  v1dtype=FB_DATATYPE_BYTE Or v1dtype=FB_DATATYPE_UBYTE _
				Or  v1dtype=FB_DATATYPE_BOOLEAN Or v1dtype=FB_DATATYPE_CHAR then

				if v2->Typ=IR_VREGTYPE_REG then
					asm_code("movd xmm0, "+op2)
				else
					asm_code("movss xmm0, "+op2)
				end if

				hEmitRoundFloat(FB_DATATYPE_SINGLE)

				if v1dtype=FB_DATATYPE_LONGINT then
					asm_code("mov "+op1+", rax")
				elseif v1dtype=FB_DATATYPE_LONG Or v1dtype=FB_DATATYPE_ULONG then
					asm_code("mov "+op1+", eax")
				elseif v1dtype=FB_DATATYPE_SHORT Or v1dtype=FB_DATATYPE_USHORT then
					asm_code("mov "+op1+", ax")
				else
					if v1dtype=FB_DATATYPE_BOOLEAN then
						asm_info("Single to boolean, <>0 --> 1")
						asm_code("cmp rax, 0")
						asm_code("setne al")
						'asm_code("neg al")
					end if
					asm_code("mov "+op1+", al")
				end if
			else
				asm_error("Converting float to int 02")
			end if
		end if
		exit sub
	end if

	if v1dtype=FB_DATATYPE_STRUCT or v2dtype=FB_DATATYPE_STRUCT then ''2019/11/21
		if v2dtype=FB_DATATYPE_STRUCT then
			asm_code("lea "+op1+", "+op2)
			if v1dtype=FB_DATATYPE_LONGINT then
				asm_code("mov "+op1+", QWORD PTR ["+op1+"]") ''op1 must be a register
			elseif v1dtype<>FB_DATATYPE_STRUCT then
				asm_error("Converting struct to datatype not handled 01")
			end if
		else
			asm_error("Converting to struct not handled 02")
		end if
		exit sub
	end if

	if v1dtype=FB_DATATYPE_BOOLEAN then
		asm_info("To boolean, <>0 --> 1")
		if v2->typ=IR_VREGTYPE_IMM then
			if op2="0" or op2="0x0000000000000000" or op2="0x00000000" then
				asm_code("mov "+op1+", 0")
			else
				asm_code("mov "+op1+", 1")
			end if
		else
			asm_code("cmp "+prefix2+op2+", 0")
			asm_code("setne al")
			asm_code("mov "+op1+", al")
		end if
		exit sub
	end if

	if v2dtype=FB_DATATYPE_BOOLEAN then
		asm_info("From boolean, 0 or -1")
		asm_code("cmp "+prefix2+op2+", 0")
		asm_code("setne al")
		asm_code("neg al")

		if typeGetSize( v1dtype )=1 then
			''byte/ubyte
			asm_code("mov "+op1+", al")
		else
			''2/4/8 byte size datatypes
			asm_code("movsx "+op1+", al")
		end if
		exit sub
	end if

	''size dst<=src
	if( typeGetSize( v1dtype ) <= typeGetSize( v2dtype ) ) then
		if v2->typ=IR_VREGTYPE_REG then ''changing register size as source > destination
			prefix1=""
			select case v1dtype
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
					op2=*regstrd(srcreg)
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					op2=*regstrw(srcreg)
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_CHAR
					op2=*regstrb(srcreg)
				case FB_DATATYPE_BOOLEAN
					''do nothing as comparison is on the whole value
				case FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE
					 ''should not be possible cases
					op2=*regstrq(srcreg)
				case else
					asm_error("Converting datatype not handled 03 ="+typedumpToStr(v2->dtype,0))
			end select
		end if
		asm_info("size dst <= size src  changing src dtype by dst dtype")
		asm_info("initial dtype src="+typedumpToStr(v2dtype,0)+" dst="+typedumpToStr(v1dtype,0))
		asm_code("mov "+op1+", "+prefix1+op2)
		exit sub
	end if

	''size dst>src
	asm_info("size dst > size src  changing src dtype by dst dtype")

	if typeIsSigned( v2dtype ) then
		select case typeGetSize( v2dtype )
			case 1,2 ''byte/short
				asm_code("movsx "+op1+", "+prefix2+op2)
			case 4 ''long
				asm_code("movsxd "+op1+", "+prefix2+op2)
			case else
				Asm_error("in conv something missing 01")
		end select
	else
		select case typeGetSize( v2dtype )
			case 1,2 ''ubyte/ushort
				asm_code("movzx "+op1+", "+prefix2+op2)

			case 4 ''ulong
				'' in case of register the higher 32bit are already zeroed
				if v2->typ = IR_VREGTYPE_REG then
					asm_info("changing register v1->reg by "+str(v2->reg)+" / "+str(srcreg)+" and "+str(regresult)+" freed")
					reghandle(regresult)=KREGFREE
					regresult=srcreg
					v1->reg=v2->reg
				else
					asm_code("mov "+*regstrd(regresult)+", "+op2)',KNOOPTIM)
				end if

			case else
				Asm_error("in conv something missing 02")
		end select
	end if

end sub
private sub emitStoreStruct(byval v1 as IRVREG ptr, byval v2 as IRVREG ptr,byref op1 as string,byref op3 as string)
	dim as string dest
	dim as integer lgtv1=v1->sym->lgt ,ofsv2=v2->ofs
	dim as FB_STRUCT_INREG retin2regs=v2->subtype->udt.retin2regs

	if op3<>"" then emitop3_op4(op3)

	''the data is already in either rax/rdx or xmm0/xmm1 or the 2 other combinations
	''moving 8 first bytes
	select case retin2regs
	case FB_STRUCT_RR
		asm_code("mov "+op1+", rax")
	case FB_STRUCT_RX
		asm_code("mov "+op1+", rax")
		asm_code("movq rdx, xmm0")
	case FB_STRUCT_XX
		asm_code("movq "+op1+", xmm0")
		asm_code("movq rdx, xmm1")
	case FB_STRUCT_XR
		asm_code("movq "+op1+", xmm0")
		asm_code("movq rdx, rax")
	case else
		'' should never happen because hGetReturnTypeGas64Linux() shouldn't
		'' return FB_DATATYPE_STRUCT unless struct is actually returned in
		'' 2 registers and _emitstore() checks hIsStructIn2Regs() before
		'' calling emitStoreStruct() even though udt.retin2regs may contain
		'' FB_STRUCT_X or FB_STRUCT_R.
		assert( 0 )
	end select

	''moving the rest (1 to 8 bytes), assuming rdx not already used
	if op1[0]=asc("-") and (lgtv1=9 or lgtv1= 10 or lgtv1=12 or lgtv1=16) then
		''shortcut for move at address -xxx[rbp] + 8
		op1=str(valint(left(op1,instr(op1,"[rbp]")-1))+8)+"[rbp]"

		select case as const lgtv1
			case 9
				dest="dl"
			case 10
				dest="dx"
			case 12
				dest="edx"
			case 16
				dest="rdx"
		end select

		asm_code("mov "+op1+", "+dest)
		exit sub
	end if

	asm_code("lea rax, "+op1)
	asm_code("add rax, 8")

	select case as const lgtv1
		case 9
			asm_code("mov [rax], dl")
		case 10
			asm_code("mov [rax], dx")
		case 11
			asm_code("mov [rax], dx")
			asm_code("shr rdx, 2")
			asm_code("mov [rax+2], dl")
		case 12
			asm_code("mov [rax], edx")
		case 13
			asm_code("mov [rax], edx")
			asm_code("shr rdx, 4")
			asm_code("mov [rax+4], dl")
		case 14
			asm_code("mov [rax], edx")
			asm_code("shr rdx, 4")
			asm_code("mov [rax+4], dx")
		case 15
			asm_code("mov [rax], edx")
			asm_code("shr rdx, 4")
			asm_code("mov [rax+4], dx")
			asm_code("shr rdx, 2")
			asm_code("mov [rax+6], dl")
		case 16
			asm_code("mov [rax], rdx")
	end select
end sub
private function hIsStructIn2Regs( byval v1 as IRVREG ptr ) as integer
	'' test if the VREG is for a struct that would be returned in 2 registers
	'' sym->udt.retin2regs is set by symbStructEnd() and the udt should become
	'' the subtype of the vreg.

	'' only if the type is a UDT
	if( typeGetDtAndPtrOnly( v1->dtype ) = FB_DATATYPE_STRUCT ) then

		'' only if the UDT was analyzed to return in 2 registers
		return ( v1->subtype->udt.retin2regs <> FB_STRUCT_NONE )
	end if
	return FALSE
end function
private sub _emitstore( byval v1 as IRVREG ptr, byval v2 as IRVREG ptr )

	dim as string op1,op2,op3,op4,prefix,code1,code2,regtempo
	dim as long tempo
	dim as FB_DATATYPE dtype

	asm_info("store " + vregPretty( v1 ) + " := " + vregPretty( v2 ) )
	asm_info("v1="+vregdumpfull(v1))
	asm_info("v2="+vregdumpfull(v2))


	if( typeGetSize( v1->dtype ) < typeGetSize( v2->dtype ) ) then
		dim as IRVREG ptr temp0 = any
		temp0 = irhlAllocVreg( v1->dtype, 0 )
		_EmitConvert( temp0, v2 )
		*v2 = *temp0
	end if

	''DESTINATION

	select case v1->typ
		case IR_VREGTYPE_IDX
			prepare_idx(v1,op1,op3)

		case IR_VREGTYPE_REG
			if v2->typ=IR_VREGTYPE_IMM then ''used ?
			asm_error("In emitstore used to be sure that case IMM to REG may happen.... report to dev")
				if v2->value.i>=0 and v2->value.i<=2147483647 then
					op1=*regstrd(reg_findreal(v1->reg))
				else
					op1=*regstrq(reg_findreal(v1->reg))
				end if
			else
				dtype=typeGetDtAndPtrOnly(v1->dtype)''typeGetDtAndPtrOnly adding for const case
				if typeisptr(dtype) then dtype=FB_DATATYPE_INTEGER
				select case dtype
					case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_ENUM
						op1=*regstrq(reg_findreal(v1->reg))
					case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
						op1=*regstrd(reg_findreal(v1->reg))
					case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
						op1=*regstrw(reg_findreal(v1->reg))
					case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
						op1=*regstrb(reg_findreal(v1->reg))
					case else
						asm_error("Storing datatype not handled 01 ="+typedumpToStr(v2->dtype,0))
				end select
			end if

		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
			if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
				op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
			else
				op1=Str(v1->ofs)+"[rbp]"
			end if

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			if v1->ofs<>0 then
				asm_info("v1->ofs not null  --> maybe prbm if not a register") ''2019/11/25 v1->ofs has been removed but maybe it matters
				if v1->vidx=0 then
					if v1->ofs<-2147483648 or v1->ofs>4294967295 then
						op3="mov rax, "+str(v1->ofs)
					else
						op3="mov eax, "+str(v1->ofs)
					end if
					op1="[rax]"
				else
					op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"
				end if
			else
				op1="["+*regstrq(reg_findreal(v1->vidx->reg))+"]"
			end if
		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"

		case else
			asm_error("store 01")
	end select

	if( hIsStructIn2Regs( v2 ) ) then
		'' for Linux structures can be returned in 2 registers so needs a special handling
		if ( v1->sym->stats and FB_SYMBSTATS_IMPLICIT ) then
			asm_info("Replacing  "+str(v1->sym->ofs)+" by "+str(v2->ofs))
			v1->sym->ofs=v2->ofs
			asm_info("v1="+vregdumpfull(v1))
		else
			emitStoreStruct(v1,v2,op1,op3)
		end if
		exit sub
	end if

	''SOURCE
	select case v2->typ ''source

		case IR_VREGTYPE_IDX
			prepare_idx(v2,op2,op4)

		case IR_VREGTYPE_REG
			dtype=typeGetDtAndPtrOnly(v2->dtype)''typeGetDtAndPtrOnly adding for const case
			if typeisptr(dtype) then dtype=FB_DATATYPE_INTEGER
			select case dtype
				case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_ENUM
					op2=*regstrq(reg_findreal(v2->reg))
				case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
					op2=*regstrd(reg_findreal(v2->reg))
				case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
					op2=*regstrw(reg_findreal(v2->reg))
				case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
					op2=*regstrb(reg_findreal(v2->reg))
				case else
					asm_error("Storing datatype not handled 02 ="+typedumpToStr(v2->dtype,0))
			end select

		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
			if v2->sym<>0 andalso ( symbIsStatic(v2->sym) Or symbisshared(v2->sym) ) then
				op2=*symbGetMangledName(v2->sym)+"[rip+"+Str(v2->ofs)+"]"
			else
				op2=Str(v2->ofs)+"[rbp]"
			end if

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			if v2->vidx then
				op2=Str(v2->ofs)+"["+*regstrq(reg_findreal(v2->vidx->reg))+"]"
			else
				''numeric value
				op2="["+str(v2->ofs)+"]"
			end if
		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op2=*symbGetMangledName(v2->sym)+"[rip+"+str(v2->ofs)+"]" ''used with lea

		case IR_VREGTYPE_IMM
			if v1->dtype=FB_DATATYPE_BOOLEAN and v2->value.i<>0 then
				v2->value.i=1
			end if
			if typeGetClass( v2->dtype ) = FB_DATACLASS_FPOINT then
				op2=hFloatToHex_asm64(v2->value.f,v2->dtype,0)
			else
				op2=str(v2->value.i)
			end if

		case else
			asm_error("store 02 ??")
	end select
	''================ writing code ==================================
	dtype=typeGetDtAndPtrOnly( v1->dtype )''typeGetDtAndPtrOnly adding for const case
	if typeisptr(dtype) then dtype=FB_DATATYPE_INTEGER
	select case dtype
		case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_ENUM
			prefix="QWORD PTR "
			code1="mov rax, "
			code2=", rax"
		case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
			prefix="DWORD PTR "
			code1="mov eax, "
			code2=", eax"
		case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
			prefix="WORD PTR "
			code1="movzx eax, "
			code2=", ax"
		case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
			prefix="BYTE PTR "
			code1="mov al, "
			code2=", al"
		case FB_DATATYPE_WCHAR ''windows 2 bytes / linux 4 bytes

			if typeGetSize( FB_DATATYPE_WCHAR )=2 then
				prefix="WORD PTR "
				code1="movzx eax, "
				code2=", ax"
			elseif typeGetSize( FB_DATATYPE_WCHAR )=4 then
				prefix="DWORD PTR "
				code1="mov eax, "
				code2=", eax"
			else
				asm_error("emitstore datatype WCHAR not handled")
			end if
		case else
			asm_error("emitstore datatype not handled 03="+typedumpToStr(dtype,0))
	end select

	if v1->typ=IR_VREGTYPE_VAR And v2->typ=IR_VREGTYPE_VAR then

		if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
			if symbIsCommon(v1->sym) then

				tempo=reg_findfree(999998)
				regtempo=*regstrq(tempo)
				reghandle(tempo)=KREGFREE
				asm_code("mov "+regtempo+", "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]")
				op1="["+regtempo+"]"
				'~ if v2->sym<>0 andalso (symbIsCommon(v2->sym)) then
					'~ asm_code("mov rax, "+*symbGetMangledName(v2->sym)+"@GOTPCREL[rip]")
					'~ 'asm_code(code1+prefix+"[rax]")
					'~ op2="[rax]"
				'~ 'else
					'~ 'asm_code("mov [rax],"+prefix+op2)
			end if
			if symbIsCommon(v2->sym) then
				asm_code("mov rax, "+*symbGetMangledName(v2->sym)+"@GOTPCREL[rip]")
				'asm_code("mov rax, [rax]")
				'asm_code(code1+prefix+"[rax]")
				'asm_code("mov "+prefix+op1+code2)
				op2="[rax]"
			end if

		'else
			'asm_code(code1+prefix+op2)
		end if
		asm_code(code1+prefix+op2)
		asm_code("mov "+prefix+op1+code2)
	elseif v1->typ=IR_VREGTYPE_IDX And v2->typ=IR_VREGTYPE_IDX then
		if op4<>"" then emitop3_op4(op4)
		asm_code(code1+prefix+op2)
		if op3<>"" then emitop3_op4(op3)
		Asm_code("mov "+prefix+op1+code2)

	elseif  (v1->typ=IR_VREGTYPE_VAR And v2->typ=IR_VREGTYPE_PTR) _
		Or (v1->typ=IR_VREGTYPE_PTR And v2->typ=IR_VREGTYPE_VAR) then
		asm_code(code1+prefix+op2)
		Asm_code("mov "+prefix+op1+code2)

	elseif  (v1->typ=IR_VREGTYPE_VAR And v2->typ=IR_VREGTYPE_IDX) _
		Or (v1->typ=IR_VREGTYPE_IDX And v2->typ=IR_VREGTYPE_VAR) then
		if op4<>"" then emitop3_op4(op4)
		asm_code(code1+prefix+op2)
		if op3<>"" then emitop3_op4(op3)
		Asm_code("mov "+prefix+op1+code2)

	elseif  (v1->typ=IR_VREGTYPE_PTR And v2->typ=IR_VREGTYPE_IDX) _
		Or (v1->typ=IR_VREGTYPE_IDX And v2->typ=IR_VREGTYPE_PTR) then
		asm_info("PTR <--> IDX")
		if op4<>"" then emitop3_op4(op4)
		asm_code(code1+prefix+op2)
		if op3<>"" then emitop3_op4(op3)
		Asm_code("mov "+prefix+op1+code2)

	elseif v1->typ=IR_VREGTYPE_PTR And v2->typ=IR_VREGTYPE_PTR then
		asm_code(code1+prefix+op2)
		Asm_code("mov "+prefix+op1+code2)

	else
		if op3<>"" then emitop3_op4(op3)
		if op4<>"" then emitop3_op4(op4)
		if v2->typ=IR_VREGTYPE_IMM then
			select case v1->typ
				case IR_VREGTYPE_REG
					asm_code("movNOTUSED? "+prefix+op1+", "+op2)
				case IR_VREGTYPE_VAR,IR_VREGTYPE_IDX,IR_VREGTYPE_PTR

					if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
						if v1->sym<>0 andalso (symbIsCommon(v1->sym)) then
							tempo=reg_findfree(999998)
							regtempo=*regstrq(tempo)
							reghandle(tempo)=KREGFREE
							asm_code("mov "+regtempo+", "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]")
							op1="["+regtempo+"]"
						end if
					end if

					select case dtype
						case FB_DATATYPE_SINGLE
							asm_code("mov "+prefix+op1+", "+op2)
						case FB_DATATYPE_DOUBLE
							asm_code("mov rax, "+op2)
							asm_code("mov "+prefix+op1+", rax")
						case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
							if v2->value.i<-2147483648 or v2->value.i>4294967295 then
								asm_code("mov rax, "+op2)
								asm_code("mov "+prefix+op1+", rax")
							elseif v2->value.i>=2147483648 then  '' And v2->value.i<=4294967295 tested in case above
								asm_code("mov eax, "+op2)
								asm_code("mov "+prefix+op1+", rax")
							else
								asm_code("mov "+prefix+op1+", "+op2)
							end if
						case else
							asm_code("mov "+prefix+op1+", "+op2)
					end select
				case else
					asm_error("in store perhaps OFS not handled")
			end select
		elseif v2->typ=IR_VREGTYPE_OFS then
			'asm_info("datatype="+str(typeGetDtOnly( v2->dtype ))+" "+str(FB_DATATYPE_FUNCTION))
			'asm_info("DLL="+str(fbGetOption( FB_COMPOPT_OUTTYPE ))+" "+str(FB_OUTTYPE_DYNAMICLIB))
			if typeGetDtOnly( v2->dtype )=FB_DATATYPE_FUNCTION andalso ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
				asm_code("mov rax, QWORD PTR "+left(op2,instr(op2,"[")-1)+"@GOTPCREL[rip]")
			else
				asm_code("lea rax, "+op2)
			end if

			if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
				if v1->sym<>0 andalso (symbIsCommon(v1->sym)) then
					tempo=reg_findfree(999998)
					regtempo=*regstrq(tempo)
					reghandle(tempo)=KREGFREE
					asm_code("mov "+regtempo+", "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]")
					op1="["+regtempo+"]"
				end if
			end if

			asm_code("mov "+op1+", rax")
		else

			if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
				if v1->sym<>0 andalso (symbIsCommon(v1->sym)) then
					'tempo=reg_findfree(999998)
					'regtempo=*regstrq(tempo)
					'reghandle(tempo)=KREGFREE
					'asm_code("mov "+regtempo+", "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]")
					asm_code("mov rax, "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]")
					op1="[rax]"
				end if
			end if

			asm_code("mov "+op1+", "+op2)
		end if
	end if
end sub
private sub _emitloadres(byval v1 as IRVREG ptr,byval vr as IRVREG Ptr)

	dim as string op1,op2,op3
	dim as FB_DATATYPE dtype=typeGetDtAndPtrOnly(v1->dtype)
	dim as integer lgt

	asm_info( "loadres " + vregPretty( v1 ) )
	asm_info("v1="+vregdumpfull(v1))
	asm_info("vr="+vregdumpfull(vr)) ''always not be used replaced by rax/eax/xmm0/etc

	select case v1->typ ''source

		case IR_VREGTYPE_IDX
			prepare_idx(v1,op1,op3)

		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
			if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
				op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
			else
				op1=Str(v1->ofs)+"[rbp]"
			end if

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

			'case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero  ''kept as could be used
			'op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"    ''never happens
			asm_error("in loadres OFS not handled")

		case IR_VREGTYPE_REG
			op1=*regstrq(reg_findreal(v1->reg))

		case else
			asm_error("in loadres typ not handled")
	end select

	if( hIsStructIn2Regs( v1 ) ) then
		''Structure returned in 2 registers, linux only
		''assuming in this case fb$result is always defined like xxx[rbp]
		if v1->typ<>IR_VREGTYPE_VAR orelse ( symbIsStatic(v1->sym) Or symbisshared(v1->sym) )then
			asm_error("IR_VREGTYPE not handled in emitloadres (linux)")
		end if
		lgt=v1->sym->lgt
		op2=Str(v1->ofs+8)+"[rbp]"
		select case as const v1->sym->subtype->udt.retin2regs
			case FB_STRUCT_RR ''only integers in RAX and RDX
				asm_code("mov rax, "+op1)
				asm_code("mov rdx, "+op2)
			case FB_STRUCT_RX ''first part in RAX then in XMMO
				asm_code("mov rax, "+op1)
				if lgt=12 then
					asm_code("movss xmm0, "+op2)
				else
					asm_code("movsd xmm0, "+op2)
				end if
			case FB_STRUCT_XR ''first part in XMMO then in RAX
				asm_code("movsd xmm0, "+op1)
				asm_code("mov "+*regstrq(KREG_RAX)+", "+op2)
			case FB_STRUCT_XX ''only floats in XMM0 and XMM1
				asm_code("movsd xmm0, "+op1)
				if lgt=12 then
					asm_code("movss xmm1, "+op2)
				else
					asm_code("movsd xmm1, "+op2)
				end if
		end select
	else
		if typeget(dtype)=FB_DATATYPE_POINTER then dtype=FB_DATATYPE_INTEGER
		if op3<>"" then emitop3_op4(op3)
		select case dtype
			case FB_DATATYPE_DOUBLE
				''
				''                                    return   return
				''                                      in       in
				''            struct    not-struct     regs    floats
				'' winlibs     rax        xmm0           1       0
				'' mingw-w64   xmm0       xmm0           1       1
				'' linux       xmm0       xmm0           0       0
				'' freebsd     xmm0       xmm0           1       1
				''
				if symbGetType( v1->sym)<>FB_DATATYPE_STRUCT then
					asm_code("movq xmm0, "+op1)
				else
					if( (env.target.options and FB_TARGETOPT_RETURNINREGS) <> 0 ) then
						if( (env.target.options and FB_TARGETOPT_RETURNINFLTS) <> 0 ) then
							asm_code("movq xmm0, "+op1)
						else
							asm_code("mov rax, "+op1)
						end if
					else
						asm_code("movq xmm0, "+op1)
					end if
				end if
			case FB_DATATYPE_SINGLE
				if symbGetType( v1->sym)<>FB_DATATYPE_STRUCT then
					asm_code("movd xmm0, "+op1)
				else
					if( (env.target.options and FB_TARGETOPT_RETURNINREGS) <> 0 ) then
						if( (env.target.options and FB_TARGETOPT_RETURNINFLTS) <> 0 ) then
							asm_code("movd xmm0, "+op1)
						else
							asm_code("mov eax, "+op1)
						end if
					else
						asm_code("movd xmm0, "+op1)
					end if
				end if
			case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
				asm_code("mov "+*regstrq(KREG_RAX)+", "+op1)
			case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
				asm_code("mov "+*regstrd(KREG_RAX)+", DWORD PTR "+op1)
			case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
				asm_code("movzx "+*regstrq(KREG_RAX)+", WORD PTR "+op1)
			case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
				asm_code("movzx "+*regstrq(KREG_RAX)+", BYTE PTR "+op1)
			case else
				asm_error("in loadres datatype not handled ="+typedumpToStr(v1->dtype,0))
		end select
	end if

end sub
private sub _emitaddr(byval op as integer,byval v1 as IRVREG ptr,byval vr as IRVREG Ptr)

	dim as string op1,op3

	asm_info( IIf(op=AST_OP_ADDROF,"addrof ","deref ") + vregPretty( v1 ) )
	asm_info("v1="+vregdumpfull(v1))
	asm_info("vr="+vregdumpfull(vr))

	if vr->typ<>IR_VREGTYPE_REG then
		asm_error("vr in addrof/deref not a reg")
		exit sub
	end if

	if v1->sym andalso symbisvaliststructarray( v1->sym->typ,v1->sym->subtype)and symbIsParamVarByRef(v1->sym) then
		asm_info("CVA_GCC changing addrof by deref")
		if op=AST_OP_ADDROF then
			op=AST_OP_DEREF
		end if
	end if

	reg_findfree(vr->reg)

	select case( op )
		case AST_OP_ADDROF '' ====== ADDROF =======================================================

			select case v1->typ ''source

				case IR_VREGTYPE_IDX
					prepare_idx(v1,op1,op3)

				case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
					if symbIsStatic(v1->sym) Or symbisshared(v1->sym) or symbIsLabel(v1->sym) then
						op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
					else
						op1=Str(v1->ofs)+"[rbp]"
					end if

				case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
					op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

				case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero  ''kept as could be used
					op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"    ''never happens
					asm_error("in emitaddr OFS not handled")

				case else
					asm_error("typ in addrof not handled")
			end select
			if op3<>"" then emitop3_op4(op3)
			'if v1->typ=IR_VREGTYPE_PTR and instr(vregPretty( v1 ),"FBARRAY1<12PARTICLETAIL>")then' and *symbGetMangledName(v1->sym)=then
				'asm_info("CANCEL addrof ptr=")
				'asm_code("mov "+*regstrq(reg_findreal(vr->reg))+", "+*regstrq(reg_findreal(v1->vidx->reg)))
			'else
				asm_code("lea "+*regstrq(reg_findreal(vr->reg))+", "+op1)
			'end if
		case AST_OP_DEREF '' ====== DEREF =========================================================
			select case v1->typ ''source
				case IR_VREGTYPE_IDX
					prepare_idx(v1,op1,op3)
					if op3<>"" then emitop3_op4(op3)

				case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
					if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
						if (symbIsCommon(v1->sym)) andalso ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
							asm_code("mov rax, "+*symbGetMangledName(v1->sym)+"@GOTPCREL[rip]")
							op1="[rax]"
						else
							op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
						end if
					else
						op1=Str(v1->ofs)+"[rbp]"
					end if

				case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
					op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

				case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
					op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"

				case IR_VREGTYPE_REG
					op1="["+*regstrq(reg_findreal(v1->reg))+"]"
				case else
					asm_error("typ in deref not handled")
			end select

			if v1->typ = IR_VREGTYPE_OFS then
				asm_code("lea "+*regstrq(reg_findreal(vr->reg))+", "+op1)
			else
				asm_code("mov "+*regstrq(reg_findreal(vr->reg))+", "+op1)
			end if
			asm_info("vr type="+Str(vr->reg)+" / "+ Str(vr->typ))
	end select

end sub
sub save_call(byref func as string,byval vr as IRVREG ptr,byval vrreg as integer)

	''vrreg not yet really used so don't need to be spilled and will be forced after by restore_vrreg
	if vr<>0 then reghandle(vrreg)=KREGFREE
	''saving registers if needed
	reg_save

	''proceeding different but need to count the argument otherwise could generate problem if no at least one standard call.
	if ctx.argcptmax=0 then
		ctx.argcptmax=1
	end if

	if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
		asm_code("call "+func+"@PLT")
	else
		asm_code("call "+func)
	end if

	if vr<>0 then reghandle(vrreg)=vr->reg
end sub
private sub hdocall(byval proc as FBSYMBOL ptr,byref pname as string,byref firstmov as string="",byval vr as IRVREG ptr,byval level as integer _
	, byval variadic as boolean=false, byval callptr as boolean)
	''in case of callptr pname contains the address of the proc and firstmov an eventual move (like op3)
	''otherwise pname (proc name) and firstmov are empty

	''cptarg counts the number of arguments on stack for linux / total for windows
	dim as integer reg2,cptarg,cptint,cptfloat
	dim as FB_DATATYPE dtype
	dim as IRCALLARG ptr arg = any, prev = any
	dim as IRVREG ptr v2 = any
	dim as string op1,op3,regtempo
	dim as boolean tostack
	dim as integer paramtype,lgt,ofst
	dim as string pushstr(300)
	dim as integer pushnbstr,pushsize
	dim as IRVREG ptr tempo1
	dim as FB_STRUCT_INREG retin2regs

	asm_info("variadic="+str(variadic)+" level="+Str(level))

	ctx.proccalling=true
	if callptr then reg_callptr(pname,firstmov)

	''reserving space for saving 13 registers
	''space for copying byval parameter could be retrieved after the calling
	''ctk.spil is used as a security if more than 13 registers would be saved
	ctx.stkcopy=ctx.stk+13*8
	ctx.stkspil=ctx.stkcopy
	asm_info("stkcopy="+str(ctx.stkcopy)) ''remove
	'' args
	arg = listGetTail( @irhl.callargs )
	while( arg andalso (arg->level = level) )
		prev = listGetPrev( arg )
		v2 = arg->vr
		op3=""
		reg2=-1
		asm_info("arg " + vregPretty( v2 ) )
		asm_info("arg="+vregdumpfull(v2)+" "+"vreg="+Str(v2->reg))

		if typeisptr(v2->dtype)=false and symbisvaliststructarray( v2->dtype,v2->subtype)then
			asm_info("CVA_GCC so use the addr and not the value")
			tempo1 = irhlAllocVreg( FB_DATATYPE_INTEGER, 0 )
			_emitaddr(AST_OP_ADDROF,v2,tempo1)
			*v2=*tempo1
		end if
		dtype=typeGetDtAndPtrOnly( v2->dtype )''adding for const case
		''SOURCE
		select case v2->typ ''source
			case IR_VREGTYPE_IDX
				if v2->sym=0 then
					if v2->vidx->sym=0 then
						if v2->vidx->reg<>-1 then
							reg2=reg_findreal(v2->vidx->reg)
							op1=Str(v2->ofs)+"["+*regstrq(reg2)+"]"
						else
							''2 levels
							reg2=reg_findreal(v2->vidx->vidx->reg)
							op3="mov "+*regstrq(reg2)+", "+"["+*regstrq(reg2)+"]"
							op1=Str(v2->ofs)+"["+*regstrq(reg2)+"]"
						end if
					else
						regtempo=*reg_tempo()
						if symbIsStatic(v2->vidx->sym) Or symbisshared(v2->vidx->sym) then
							op3="lea "+regtempo+", "+*symbGetMangledName(v2->vidx->sym)+"[rip+"+Str(v2->vidx->ofs)+"]"
							op3+=newline2+"mov "+regtempo+", "+"["+regtempo+"]"+" #NO"
							op1=Str(v2->ofs)+"["+regtempo+"]"
						else
							op3="mov "+regtempo+", "+Str(v2->vidx->ofs)+"[rbp]"
							op1=Str(v2->ofs)+"["+regtempo+"]"
						end if
					end if
				else ''format  varname ofs= [dt] vidx=<reg> /// vidx=<var varname
					regtempo=*reg_tempo()
					if symbIsStatic(v2->sym) Or symbisshared(v2->sym) then
						op3="lea "+regtempo+", "+*symbGetMangledName(v2->sym)+"[rip+"+Str(v2->ofs)+"]"
					else
						op3="lea "+regtempo+", "+Str(v2->ofs)+"[rbp]"

					end if

					if v2->vidx->typ=IR_VREGTYPE_REG then
						reg2=reg_findreal(v2->vidx->reg)
						op1="["+regtempo+"+"+*regstrq(reg2)+"]"
					elseif v2->vidx->typ=IR_VREGTYPE_VAR then
						if symbIsStatic(v2->vidx->sym) Or symbisshared(v2->vidx->sym) then
							op3+=newline2+"add "+regtempo+", "+*symbGetMangledName(v2->vidx->sym)+"[rip+"+Str(v2->vidx->ofs)+"]"
						else
							op3+=newline2+"add "+regtempo+","+Str(v2->vidx->ofs)+"[rbp]"
						end if
						op1="["+regtempo+"]"
					else
						asm_error("hdocall error with idx")
					end if
				end if

			case IR_VREGTYPE_REG
				if typeget(dtype)=FB_DATATYPE_POINTER then dtype=FB_DATATYPE_INTEGER
				reg2=reg_findreal(v2->reg)
				select case dtype
					case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_ENUM,FB_DATATYPE_STRUCT
						op1=*regstrq(reg2)
					case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
						op1=*regstrd(reg2)
					case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
						op1=*regstrw(reg2)
					case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
						op1=*regstrb(reg2)
					case else
						asm_error("in hdocall datatype not handled 01 ="+typedumpToStr(dtype,0))
				end select


			case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
				if v2->sym<>0 andalso (symbIsStatic(v2->sym) Or symbisshared(v2->sym) ) then ''for gas64
					op1=*symbGetMangledName(v2->sym)+"[rip+"+Str(v2->ofs)+"]"
				else
					op1=Str(v2->ofs)+"[rbp]"
				end if

			case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
				reg2=reg_findreal(v2->vidx->reg)
				op1=Str(v2->ofs)+"["+*regstrq(reg2)+"]"

			case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
				op1=*symbGetMangledName(v2->sym)+"[rip+"+str(v2->ofs)+"]"

			case IR_VREGTYPE_IMM
				if typeGetClass( dtype ) = FB_DATACLASS_FPOINT then
					op1=hFloatToHex_asm64(v2->value.f,dtype,0)
				else
					if dtype=FB_DATATYPE_BOOLEAN then
						if v2->value.i<>0 then
							''force the value to 1
							v2->value.i=1
						end if
					end if
					op1=str(v2->value.i)
				end if

			case else
				asm_error("in hdocall typ not handled ")
		end select
''======================
		''============
		''writing code
		''============

		if typeget(dtype)=FB_DATATYPE_POINTER then dtype=FB_DATATYPE_INTEGER
		paramtype=param_analyze(dtype,v2->subtype,cptarg,cptint,cptfloat)
		asm_info("KPARAM="+str(paramtype))

		if paramtype>=KPARAMSK0 then
			''=================
			''writing ON STACK
			''=================
			if ctx.systemv then
				''=================================
				''LNX parameter on stack using push
				''=================================
				if v2->typ=IR_VREGTYPE_IMM then
					pushsize+=8
					asm_info("typeclass="+str(typeGetClass( dtype ))+" "+str(FB_DATACLASS_FPOINT))
					if typeGetClass( dtype ) = FB_DATACLASS_FPOINT then
						if dtype=FB_DATATYPE_SINGLE then
							MPUSH("push "+op1)
						else
							MPUSH("push rax")
							MPUSH("mov rax, "+op1)
						end if
					elseif v2->value.i>=-2147483648 and v2->value.i<2147483648 then
						MPUSH("push "+op1)
					else
						MPUSH("push rax")
						MPUSH("mov rax, "+op1)
					end if
				else
					if dtype=FB_DATATYPE_STRUCT then
						lgt=v2->subtype->lgt
						pushsize+=lgt
						if lgt>8 then
							ofst=lgt mod 8
							if  ofst=0 then ofst=8
							 ''todo if lgt > ??? then copy on stack using memcopy and rsp and also sub rsp, 8 if needed
							while lgt>0
								MPUSH("push [rax]")
								if lgt>8 then
									MPUSH("sub rax, 8")
								end if
								lgt-=8
							wend
							MPUSH("add rax, "+str(v2->subtype->lgt-ofst))
							if v2->typ=IR_VREGTYPE_REG then
								MPUSH("mov rax, "+op1)
							else
								MPUSH("lea rax, "+op1)
							end if
						else
							MPUSH("push "+op1)
						end if
					else
						''not a structure
						pushsize+=8
						if v2->typ=IR_VREGTYPE_OFS then
							if typeGetDtOnly( v2->dtype )=FB_DATATYPE_FUNCTION andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
								MPUSH("push rax")
								MPUSH("mov rax, QWORD PTR "+left(op1,instr(op1,"[")-1)+"@GOTPCREL[rip]")
							else
								MPUSH("push rax")
								MPUSH("lea rax, "+op1)
							end if
						else
							if v2->typ=IR_VREGTYPE_REG then
								'MPUSH("mov rax, "+op1)
								''forcing type for avoiding 'push 8bit register' not allowed
								op1=*regstrq(reg2)
								MPUSH("push "+op1)
							'elseif dtype=FB_DATATYPE_STRUCT then  ''incoherent test not a strucure before
								'MPUSH("lea rax, "+op1)
							else
								'MPUSH("mov rax, "+op1)
								MPUSH("push "+op1)
							end if
						end if
					end if
					if op3<>"" then
						MPUSH(op3) ''todo first ????
					end if
				end if
			''end of LNX
			else
				''======
				'' WDS
				''======

				if op3<>"" then emitop3_op4(op3)
				if paramtype=KPARAMSK1 then

					if dtype=FB_DATATYPE_STRUCT then
						lgt=v2->subtype->lgt
					else
						lgt=symb_dtypeTB(dtype).size
					end if

					if v2->typ=IR_VREGTYPE_REG then
						select case as const lgt
							case 1
								asm_code("mov byte PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
							case 2
								asm_code("mov WORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
							case 4
								asm_code("mov DWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
							case 8
								asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
						end select
					else
						select case as const lgt
							case 1
								asm_code("mov al, "+op1)
								asm_code("mov byte PTR "+Str((cptarg-1)*8)+"[rsp], al")
							case 2
								asm_code("mov ax, "+op1)
								asm_code("mov WORD PTR "+Str((cptarg-1)*8)+"[rsp], ax")
							case 4
								asm_code("mov eax, "+op1)
								asm_code("mov DWORD PTR "+Str((cptarg-1)*8)+"[rsp], eax")
							case 8
								asm_code("mov rax, "+op1)
								asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
						end select
					end if
				elseif paramtype=KPARAMSK2 then
					''structure passed byval with ptr in a register
					''reg2 contains possibly the register if IR_VREGTYPE_REG
					reg_transfer(listreg(cptint),reg2)''is the reg free ?
					'asm_info("datatype="+str(typeGetDtOnly( v2->dtype ))+" "+str(FB_DATATYPE_FUNCTION))
					'asm_info("DLL="+str(fbGetOption( FB_COMPOPT_OUTTYPE ))+" "+str(FB_OUTTYPE_DYNAMICLIB))

					asm_code("lea "+*regstrq(listreg(cptint))+", "+op1)

					''byval structure passed by pointer
					asm_info("copying byval parameter on stack")
					asm_info("stk="+Str(ctx.stkcopy))
					'ctx.stkcopy=(symbGetRealSize( v2->subtype )+ctx.stkcopy+v2->subtype->lgt-1) And (Not(v2->subtype->lgt-1))
					ctx.stkcopy=(v2->subtype->lgt +ctx.stkcopy+v2->subtype->lgt-1) And (Not(v2->subtype->lgt-1))
					ctx.stkcopy+=8-(ctx.stkcopy mod 8)
					asm_info("stk12="+Str(ctx.stkcopy))
					regtempo=*regstrq(listreg(cptint))
					memcopy(v2->subtype->lgt,regtempo,str(-ctx.stkcopy)+"[rbp]",KUSE_LEA,KUSE_LEA)
					asm_code("lea "+*regstrq(listreg(cptint))+", "+str(-ctx.stkcopy)+"[rbp]")

					if variadic=true and ctx.target=FB_COMPTARGET_WIN32 then
						asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+*regstrq(listreg(cptint)),KNOOPTIM)
					end if
				else
					''KPARAMSK3
					if v2->typ=IR_VREGTYPE_IMM then
						''Immediat
						if dtype=FB_DATATYPE_SINGLE then
							if v2->value.f=0 then
								asm_code("xor eax, eax")
							else
								asm_code("mov eax, "+op1)
							end if
							asm_code("mov DWORD PTR "+Str((cptarg-1)*8)+"[rsp], eax")
						elseif dtype=FB_DATATYPE_DOUBLE then
							if v2->value.f=0 then
								asm_code("xor rax, rax")
							else
								asm_code("mov rax, "+op1)
							end if
							asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
						else
							if v2->value.i<-2147483648 or v2->value.i>4294967295 then
									asm_code("mov rax, "+op1)
									asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
							elseif v2->value.i>=2147483648 then  '' And v2->value.i<=4294967295 tested in case above
								asm_code("mov eax, "+op1)
								asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
							else
								asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
							end if
						end if
					else
						''not immediat
						if v2->typ=IR_VREGTYPE_REG then
							if dtype=FB_DATATYPE_STRUCT then
								''byval structure passed by pointer copy on stack
								asm_info("copying byval parameter on stack")
								asm_info("stk="+Str(ctx.stkcopy))
								ctx.stkcopy=(v2->subtype->lgt+ctx.stkcopy+v2->subtype->lgt-1) And (Not(v2->subtype->lgt-1))
								ctx.stkcopy+=8-(ctx.stkcopy mod 8)
								asm_info("stk10="+Str(ctx.stkcopy))
								memcopy(v2->subtype->lgt,op1,str(-ctx.stkcopy)+"[rbp]",KUSE_MOV,KUSE_LEA)
								asm_code("mov rax, "+Str(-ctx.stkcopy)+"[rbp]")
								asm_code("mov "+Str((cptarg-1)*8)+"[rsp], rax")
							else
								asm_code("mov "+Str((cptarg-1)*8)+"[rsp], "+op1)
							end if
						else
							if v2->typ=IR_VREGTYPE_OFS or (dtype=FB_DATATYPE_STRUCT) then
								if typeGetDtOnly( v2->dtype )=FB_DATATYPE_FUNCTION andalso ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
									asm_code("mov rax, QWORD PTR "+left(op1,instr(op1,"[")-1)+"@GOTPCREL[rip]")
								else
									asm_code("lea rax, "+op1)
								end if
							else
								asm_code("mov rax, "+op1)
							end if

							if dtype=FB_DATATYPE_STRUCT then
								 ''byval structure passed by pointer copy on stack
								asm_info("copying byval parameter on stack")
								asm_info("stk="+Str(ctx.stkcopy))
								ctx.stkcopy=(v2->subtype->lgt +ctx.stkcopy+v2->subtype->lgt-1) And (Not(v2->subtype->lgt-1))
								ctx.stkcopy+=8-(ctx.stkcopy mod 8)
								asm_info("stk11="+Str(ctx.stkcopy))
								memcopy(v2->subtype->lgt,"rax",Str(-ctx.stkcopy)+"[rbp]",KUSE_MOV,KUSE_LEA)
								asm_code("lea rax, "+Str(-ctx.stkcopy)+"[rbp]")
								asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
							else
								asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
							end if
						end if
					end if
				end if
			end if
		''end of param on stack
		else
			''===================
			''writing TO REGISTER
			''===================

			if op3<>"" then emitop3_op4(op3)

			if v2->typ=IR_VREGTYPE_IMM then
				''Immediat
				if dtype=FB_DATATYPE_SINGLE then
					if v2->value.f=0 then
						asm_code("xor eax, eax")
					else
						asm_code("mov eax, "+op1)
					end if
					asm_code("movd xmm"+Str(cptfloat-1)+", eax")
				elseif dtype=FB_DATATYPE_DOUBLE then
					if v2->value.f=0 then
						asm_code("xor eax, eax") ''whole rax zeroed
					else
						asm_code("mov rax, "+op1)
					end if
					asm_code("movq xmm"+Str(cptfloat-1)+", rax")
					if variadic=true and ctx.target=FB_COMPTARGET_WIN32 then
						''move also directly on stack only for win32
						asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax",KNOOPTIM)
					end if
				else
					''whole number
					reg_transfer(listreg(cptint),reg2)''is the reg free ?
					if v2->value.i=0 then
						asm_code("xor "+*regstrd(listreg(cptint))+", "+*regstrd(listreg(cptint)))
					elseif v2->value.i>0 and v2->value.i<=+2147483647 then
						asm_code("mov "+*regstrd(listreg(cptint))+", "+op1)
					else
						select case dtype
							case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
								asm_code("mov "+*regstrq(listreg(cptint))+", "+op1)
							case Else
								asm_code("mov "+*regstrd(listreg(cptint))+", "+op1)
						end select
					end if
					if variadic=true and ctx.target=FB_COMPTARGET_WIN32 then
						asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+*regstrq(listreg(cptint)),KNOOPTIM)
					end if
				end if
			''=======================================
			''   Not immediat
			''=======================================
			elseif dtype=FB_DATATYPE_STRUCT then
				lgt=v2->subtype->lgt
				''structure passed byval directly in register
				if v2->typ=IR_VREGTYPE_REG then
					op1="["+op1+"]"
				end if

				if ctx.systemv then
					select case as const paramtype
						case KPARAMR1
							reg_fillr(lgt,op1,cptint,listreg(),reg2)
						case KPARAMRR
							reg_fillr(8,op1,cptint-1,listreg(),reg2)
							reg_fillr(lgt,op1,cptint,listreg(),reg2)
						case KPARAMRX
							reg_fillr(8,op1,cptint,listreg(),reg2)
							reg_fillx(lgt,op1,cptfloat)
						case KPARAMX1
							reg_fillx(lgt,op1,cptfloat)
						case KPARAMXR
							reg_fillx(8,op1,cptfloat)
							reg_fillr(lgt,op1,cptint,listreg(),reg2)
						case KPARAMXX
							reg_fillx(8,op1,cptfloat-1)
							reg_fillx(lgt,op1,cptfloat)
					end select
				else
					'' WDS
					if paramtype=KPARAMR1 then
						reg_fillr(lgt,op1,cptint,listreg(),reg2)
					elseif paramtype=KPARAMX1 then
						reg_fillx(lgt,op1,cptfloat)
					else
						''KPARAMSK1
						if v2->typ=IR_VREGTYPE_REG then
							select case as const lgt
								case 1
									asm_code("mov byte PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
								case 2
									asm_code("mov WORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
								case 4
									asm_code("mov DWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
								case 8
									asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+op1)
							end select
						else
							select case as const lgt
								case 1
									asm_code("mov al, "+op1)
									asm_code("mov byte PTR "+Str((cptarg-1)*8)+"[rsp], al")
								case 2
									asm_code("mov ax, "+op1)
									asm_code("mov WORD PTR "+Str((cptarg-1)*8)+"[rsp], ax")
								case 4
									asm_code("mov eax, "+op1)
									asm_code("mov DWORD PTR "+Str((cptarg-1)*8)+"[rsp], eax")
								case 8
									asm_code("mov rax, "+op1)
									asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], rax")
							end select
						end if
					end if
				end if
			else
				if v2->typ=IR_VREGTYPE_OFS then
					reg_transfer(listreg(cptint),reg2)''is the reg free ?
					if typeGetDtOnly( v2->dtype )=FB_DATATYPE_FUNCTION andalso ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
						asm_code("mov "+*regstrq(listreg(cptint))+", QWORD PTR "+left(op1,instr(op1,"[")-1)+"@GOTPCREL[rip]")
					else
						asm_code("lea "+*regstrq(listreg(cptint))+", "+op1)
					end if
					if variadic=true and ctx.target=FB_COMPTARGET_WIN32 then
						asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+*regstrq(listreg(cptint)),KNOOPTIM)
					end if
				else
					''====   not byval nor OFS
					if( typeGetClass( dtype ) = FB_DATACLASS_FPOINT ) then
						if dtype=FB_DATATYPE_DOUBLE then
							if v2->typ=IR_VREGTYPE_REG then
								asm_code("movq xmm"+Str(cptfloat-1)+", "+op1)
							else
								asm_code("movsd xmm"+Str(cptfloat-1)+", "+op1)
							end if
						else '' FB_DATATYPE_SINGLE
							if v2->typ=IR_VREGTYPE_REG then
								asm_code("movd xmm"+Str(cptfloat-1)+", "+op1)
							else
								asm_code("movss xmm"+Str(cptfloat-1)+", "+op1)
							end if
						end if
						if variadic=true and ctx.target=FB_COMPTARGET_WIN32 then
							asm_code("movsd QWORD PTR "+Str((cptarg-1)*8)+"[rsp], xmm"+Str(cptfloat-1),KNOOPTIM)
							asm_code("movq "+*regstrq(listreg(cptint))+", xmm"+Str(cptfloat-1))
						end if
					else
						reg_transfer(listreg(cptint),reg2)''is the reg free ?
						if dtype=FB_DATATYPE_VA_LIST then
							if ctx.systemv then
								asm_error("in hdocall Va_list and target linux could be a problem")
							else
								dtype = FB_DATATYPE_INTEGER ''forcing type to avoid type va_list
							end if
						end if

						if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
							if v2->sym<>0 andalso (symbIsCommon(v2->sym)) then
								asm_code("mov rax, "+*symbGetMangledName(v2->sym)+"@GOTPCREL[rip]")
								op1="[rax]"
							end if
						end if

						select case dtype
							case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_ENUM
								asm_code("mov "+*regstrq(listreg(cptint))+", "+op1)
							case FB_DATATYPE_LONG,FB_DATATYPE_ULONG
								asm_code("mov "+*regstrd(listreg(cptint))+", "+op1)
							case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
								asm_code("mov "+*regstrw(listreg(cptint))+", "+op1)
							case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
								asm_code("mov "+*regstrb(listreg(cptint))+", "+op1)
							case else
								asm_error("in hdocall datatype not handled 03 ="+typedumpToStr(dtype,0))
						end select
						if variadic=true and ctx.target=FB_COMPTARGET_WIN32 then
							asm_code("mov QWORD PTR "+Str((cptarg-1)*8)+"[rsp], "+*regstrq(listreg(cptint)),KNOOPTIM)
						end if
					end if
				end if
			end if
		end if

		listDelNode( @irhl.callargs, arg )

		arg = prev

	Wend

	if cptarg>ctx.argcptmax then ctx.argcptmax=cptarg ''used later to calculate stack needed

	if firstmov<>"" then asm_code(firstmov)

	''trick to free registers used in pname and avoid an unusefull save/restore
	''but do not check if call <name>
	if callptr then reg_freeable("call "+pname)

	''for linux only, pushing parameters
	if pushsize then
		if pushsize mod 16 then
			''should be a multiple of 16
			pushsize=(pushsize\16+1)*16
			asm_code("sub rsp, 8")
		end if
		for istr as integer =pushnbstr to 1 step -1
			if right(pushstr(istr),3)="#NO" then
				asm_code(pushstr(istr),KNOOPTIM)
			else
				asm_code(pushstr(istr))
			end if
		next
	end if
	''unlock registers to avoid save just below
	if callptr then reg_allowed(true)
	''preparing the save of registers in use by the calling and that can be used by the called
	reg_save

	if variadic=true then
		if ctx.systemv then
			''eax indicates if there is at least a float parameter
			asm_code("mov eax, "+str(iif(cptfloat<=8,cptfloat,8)))
		end if
	end if

	if ctx.systemv=true andalso fbGetOption( FB_COMPOPT_OUTTYPE ) = FB_OUTTYPE_DYNAMICLIB then
		asm_code("call " +pname+"@PLT",KNOALL)
	else
		asm_code("call " +pname,KNOALL)
	end if

	''for linux restoring the previous value of rsp in case of parameter put on the stack
	if pushsize then
		asm_code("add rsp, "+str(pushsize))
		pushsize=0
		pushnbstr=0
	end if

	''in case of byval structure copy allocates max space
	if ctx.stkcopy>ctx.stkmax then ctx.stkmax=ctx.stkcopy
	ctx.stkspil=0

	ctx.proccalling=false

	if( vr ) then ''return value

		if( hIsStructIn2Regs( vr ) ) then
			''Structure returned in 2 registers
			vr->typ=IR_VREGTYPE_VAR ''for use when argument
			ctx.stk+=typeGetSize( FB_DATATYPE_LONGINT )*2 ''reserving 16 bytes
			vr->ofs=-ctx.stk
			asm_info("new vr="+vregdumpfull(vr))
			select case as const vr->subtype->udt.retin2regs
				case FB_STRUCT_RR
					asm_code("mov "+str(vr->ofs)+  "[rbp], rax")
					asm_code("mov "+str(vr->ofs+8)+"[rbp], rdx")
				case FB_STRUCT_RX
					asm_code("mov "+str(vr->ofs)+   "[rbp], rax")
					asm_code("movq "+str(vr->ofs+8)+"[rbp], xmm0")
				case FB_STRUCT_XR
					asm_code("movq "+str(vr->ofs)+ "[rbp], xmm0")
					asm_code("mov "+str(vr->ofs+8)+"[rbp], rax")
				case FB_STRUCT_XX
					asm_code("movq "+str(vr->ofs)+  "[rbp], xmm0")
					asm_code("movq "+str(vr->ofs+8)+"[rbp], xmm1")
			end select
			exit sub
		end if

		dtype=typeGetDtAndPtrOnly(vr->dtype)
		if typeget(dtype)=FB_DATATYPE_POINTER then dtype=FB_DATATYPE_INTEGER
		if dtype=FB_DATATYPE_DOUBLE then
			''
			''                                    return   return
			''                                      in       in
			''            struct    not-struct     regs    floats
			'' winlibs     n/a        xmm0           1       0
			'' mingw-w64   xmm0       xmm0           1       1
			'' linux       xmm0       xmm0           0       0
			'' freebsd     xmm0       xmm0           1       1
			''
			if symbGetType( proc )<>FB_DATATYPE_STRUCT then
				asm_code("movq rax, xmm0")
			else
				if( (env.target.options and FB_TARGETOPT_RETURNINREGS) <> 0 ) then
					if( (env.target.options and FB_TARGETOPT_RETURNINFLTS) <> 0 ) then
						asm_code("movq rax, xmm0")
					end if
				else
					asm_code("movq rax, xmm0")
				end if
			end if
		elseif dtype=FB_DATATYPE_SINGLE then
			if symbGetType( proc )<>FB_DATATYPE_STRUCT then
				asm_code("movd eax, xmm0")
			else
				if( (env.target.options and FB_TARGETOPT_RETURNINREGS) <> 0 ) then
					if( (env.target.options and FB_TARGETOPT_RETURNINFLTS) <> 0 ) then
						asm_code("movd eax, xmm0")
					end if
				else
					asm_code("movd eax, xmm0")
				end if
			end if
		end if

		reg_findfree(vr->reg)

		select case vr->typ ''destination
			case IR_VREGTYPE_REG
				asm_info("in hdocall vr->type limited to IR_VREGTYPE_REG")
				select case dtype
					case FB_DATATYPE_INTEGER,FB_DATATYPE_UINT,FB_DATATYPE_LONGINT,FB_DATATYPE_ULONGINT,FB_DATATYPE_DOUBLE,FB_DATATYPE_ENUM
						op1=*regstrq(reg_findreal(vr->reg))
						asm_code("mov "+op1+", "+*regstrq(KREG_RAX))
					case FB_DATATYPE_LONG,FB_DATATYPE_ULONG,FB_DATATYPE_SINGLE
						op1=*regstrd(reg_findreal(vr->reg))
						asm_code("mov "+op1+", "+*regstrd(KREG_RAX))
					case FB_DATATYPE_SHORT,FB_DATATYPE_USHORT
						op1=*regstrw(reg_findreal(vr->reg))
						asm_code("mov "+op1+", "+*regstrw(KREG_RAX))
					case FB_DATATYPE_BYTE,FB_DATATYPE_UBYTE,FB_DATATYPE_BOOLEAN,FB_DATATYPE_CHAR
						op1=*regstrb(reg_findreal(vr->reg))
						asm_code("mov "+op1+", "+*regstrb(KREG_RAX))
					case else
						asm_error("in hdocall datatype not handled 04 ="+typedumpToStr(dtype,0))
						op1=*regstrq(KREG_XXX)
				end select
			case else
				asm_error("in hdocall vr->type not handled (test optim)")
		end select
	end if
end sub
private sub _emitcall _
	( _
	byval proc as FBSYMBOL ptr, _
	byval bytestopop as integer, _
	byval vr as IRVREG ptr, _
	byval level as integer _
	)
	asm_info("call " + *symbGetMangledName( proc ) +" / mang="+ * symbGetMangledName( proc ))
	asm_info("symbdump="+symbdumpToStr(proc))
	asm_info("vr="+vregdumpfull(vr))
	dim as boolean variadic
	var param = symbGetProctailParam(proc)
	if param then
		if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then '' "..."
			variadic=true ''need to mov also the float parameter into register
		end if
	end if
	hDoCall(proc,*symbGetMangledName( proc ),,vr, level,variadic,false)
end sub
private sub _emitcallptr _
	( _
	byval proc as FBSYMBOL ptr, _
	byval v1 as IRVREG ptr, _
	byval vr as IRVREG ptr, _
	byval bytestopop as integer, _
	byval level as integer _
	)

	dim as string op1,op3
	dim as boolean variadic
	dim as FBSYMBOL ptr param

	asm_info("callptr " + *symbGetMangledName( proc ) +" / mang="+ * symbGetMangledName( proc ))
	asm_info("v1="+vregdumpfull(v1))
	asm_info("vr="+vregdumpfull(vr))

	select case v1->typ
		case IR_VREGTYPE_REG
			op1=*regstrq(reg_findreal(v1->reg))

		case IR_VREGTYPE_IDX
			prepare_idx(v1,op1,op3)

		case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
			op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

		case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
			op1=*symbGetMangledName(v1->sym)'+"[rip+"+str(v1->ofs)+"]"
			'asm_error("in emitCallPtr OFS not handled")

		case IR_VREGTYPE_IMM
			asm_error("Never IMM as first operand")
		case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
			if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
				op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
			else
				op1=Str(v1->ofs)+"[rbp]"
			end if
		case else
			asm_error("in loadoperand typ not handled v1")
	end select


	param = symbGetProctailParam(proc)
	if param then
		if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then '' "..."
			variadic=true ''need to mov also the float parameter into register
		end if
	end if

	hDoCall(proc,op1,op3,vr,level,variadic,true)
end sub
private sub _emitjumpptr( byval v1 as IRVREG ptr )
	dim as integer reg
	asm_info("jumpptr vrdump="+vregdumpfull(v1))
	if v1->reg=ctx.jmpvreg then
		reg=ctx.jmpreg
		ctx.jmppass=0
		ctx.jmpvreg=KREGFREE
	else
		reg=reg_findreal(v1->reg)
	end if
	'asm_code("jmp ["+*regstrq(reg)+"]")
	asm_code("jmp "+*regstrq(reg))
end sub
private sub _emitbranch( byval op as integer, byval label as FBSYMBOL ptr )
	asm_info("emit branch = jmp/call (gosub) to "+*symbGetMangledName( label )+" "+Str(op)+" "+*hGetBopCode(op))
	asm_code(*hGetBopCode(op)+" "+*symbGetMangledName( label ))
	if ctx.opereg then
		''useless ? if op<>AST_OP_JUMP and op<>AST_OP_CALL then
		asm_info("emitbranch opereg="+*regstrq(ctx.opereg))
		reghandle(ctx.opereg)=KREGFREE
		ctx.opereg=0
	end if
	if ctx.labelbranch2 then
		ctx.labeljump=label
	end if
	if op<>AST_OP_JMP then
		reg_mark(label)
	end if
end sub
private sub _emitreturn( byval bytestopop as integer )
	asm_info("return for gosub="+str(bytestopop))
	asm_code("add rsp, 88 # restore stack for gosub")
	asm_code("ret")
end sub
private sub _emitjmptb _
	( _
	byval v1 as IRVREG ptr, _
	byval tbsym as FBSYMBOL ptr, _
	byval values as ulongint ptr, _
	byval labels as FBSYMBOL ptr ptr, _
	byval labelcount as integer, _
	byval deflabel as FBSYMBOL ptr, _
	byval bias as ulongint, _
	byval span as ulongint _
	)
	dim as string lname,op1=Str(v1->ofs)+"[rbp]",op2
	dim as long idx,regtempo
	asm_info("jmptb " + vregPretty( v1 ) )
	asm_info("v1="+vregdumpfull(v1))
	asm_info("labelcount="+Str(labelcount)+" bias="+Str(bias)+" span="+Str(span))

	if labelcount=0 then
		asm_code("jmp "+*symbGetMangledName(deflabel))
	else
		lname = *symbUniqueLabel( )

		'' if( expr < minval or expr > maxval ) then goto deflabel
		'' optimised to:
		'' if( cunsg(expr - bias) > (span) ) then goto deflabel

		asm_code("mov rax, "+op1)

		if bias>2147483647 and bias<18446744071562067968 then
			op2=*regstrq(reg_findfree(999998))
			asm_code("mov "+op2+", "+Str(bias))
			asm_code("sub rax, "+op2)
		else
			asm_code("sub rax, "+Str(bias))
		end if

		asm_code("cmp rax, "+Str(span))''check limits inf/sup
		asm_code("ja "+*symbGetMangledName(deflabel))
		'asm_code("jmp QWORD PTR ["+lname+"+rax*8]")  ''issue with ld 2.36 so replaced by the 3 lines below
		regtempo=reg_findfree(999997)
		reghandle(regtempo)=KREGFREE ''can be reset here as limited use
		asm_code("lea "+*regstrq(regtempo)+", "+lname+"[rip]")
		asm_code("jmp QWORD PTR [rax*8+"+*regstrq(regtempo)+"]")
		asm_section(".data")
		asm_code(".align 8")
		asm_code(lname+":")
		for isel as integer = 0 to span
			''asm_info("values="+str(isel)+" "+str(idx)+" "+str(values[idx]))
			if isel=values[idx] then
				asm_code(".quad "+*symbGetMangledName( labels[idx]))
				idx+=1
			else
				asm_code(".quad "+*symbGetMangledName(deflabel))
			end if
		next
		asm_section(".text")
	end if

end sub
private sub _emitmem(byval op as integer,byval v1 as IRVREG ptr,byval v2 as IRVREG ptr, byval bytes as longint)

	dim as string op1,op2,op3,lname1,lname2,instruc="mov "
	dim as const zstring ptr regtempo
	dim as long desttyp=KUSE_MOV,srctyp=KUSE_MOV,regsrc

	select case( op )
		case AST_OP_MEMCLEAR ''========================== MEMCLEAR ===========================
			asm_info("memclear " + vregPretty( v1 ))
			asm_info("v1="+vregdumpfull(v1))
			asm_info("v2="+vregdumpfull(v2))

			if v1->typ=IR_VREGTYPE_REG then
				regsrc=reg_findreal(v1->reg)
				op1=*regstrq(regsrc)
				srctyp=KUSE_LEA ''doesn't mean something just to be different from VAR case
			elseif v1->typ=IR_VREGTYPE_VAR then
				if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
					op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
				else
					op1=Str(v1->ofs)+"[rbp]"
				end if
				srctyp=KUSE_MOV
			elseif v1->typ=IR_VREGTYPE_OFS then  ''format varname ofs1   static  ofs1 could be zero
				op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"
				srctyp=KUSE_LEA
				instruc="lea "
			else
				asm_error("Memclear v1 not a reg nor a var")
				exit sub
			end if

			if v2->typ=IR_VREGTYPE_REG then ''todo to be replace by repsto
				op2=*regstrq(reg_findreal(v2->reg))
				asm_code("test "+op2+", "+op2)
				lname2=*symbUniqueLabel( )
				''zero byte to clear so skip
				asm_code("jz "+lname2)
				asm_code("mov rax, "+op1)
				lname1=*symbUniqueLabel( )
				asm_code(lname1+":")
				asm_code("mov BYTE PTR [rax], 0")
				asm_code("inc rax")
				asm_code("dec "+op2)
				asm_code("jnz "+lname1)
				asm_code(lname2+":")
				exit sub
			end if

			if v2->typ<>IR_VREGTYPE_IMM then
				asm_error("Memclear without an immediat as size")
				exit sub
			end if

			if v2->value.i=0 then exit sub ''no need ....

			select case v2->value.i
				case is>8,3,5,6,7
					memclear(v2->value.i,op1,srctyp)
				case 1
					if v1->typ=IR_VREGTYPE_REG then
						asm_code("mov BYTE PTR ["+op1+"], 0")
					else
						asm_code(instruc+"rax, "+op1)
						asm_code("mov BYTE PTR [rax], 0")
					end if
				case 2
					if v1->typ=IR_VREGTYPE_REG then
						asm_code("mov WORD PTR ["+op1+"], 0")
					else
						asm_code(instruc+"rax, "+op1)
						asm_code("mov WORD PTR [rax], 0")
					end if
				case 4
					if v1->typ=IR_VREGTYPE_REG then
						asm_code("mov DWORD PTR ["+op1+"], 0")
					else
						asm_code(instruc+"rax, "+op1)
						asm_code("mov DWORD PTR [rax], 0")
					end if
				case 8
					if v1->typ=IR_VREGTYPE_REG then
						asm_code("mov QWORD PTR ["+op1+"], 0")
					else
						asm_code(instruc+"rax, "+op1)
						asm_code("mov QWORD PTR [rax], 0")
					end if
			end select

		case AST_OP_MEMMOVE ''========================== MEMCOPY (MEMMOVE) ===========================

			asm_info("memcopy " + vregPretty( v1 ) + " <= " + vregPretty( v2 ) )
			asm_info("v1="+vregdumpfull(v1))
			asm_info("v2="+vregdumpfull(v2))
			asm_info("nb bytes="+Str(bytes)) ''only filled in for memcopy

			if bytes=0 then
				asm_info("0 bytes to move.....")
				exit sub
			end if

			'      ''DESTINATION

			select case v1->typ
				case IR_VREGTYPE_IDX
					prepare_idx(v1,op1,op3)

				case IR_VREGTYPE_REG
					op1=*regstrq(reg_findreal(v1->reg))

				case IR_VREGTYPE_VAR ''format varname ofs1   local/static  ofs1 could be zero
					if symbIsStatic(v1->sym) Or symbisshared(v1->sym) then
						op1=*symbGetMangledName(v1->sym)+"[rip+"+Str(v1->ofs)+"]"
					else
						op1=Str(v1->ofs)+"[rbp]"
					end if

				case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
					op1=Str(v1->ofs)+"["+*regstrq(reg_findreal(v1->vidx->reg))+"]"

				case IR_VREGTYPE_OFS ''format varname ofs1   static  ofs1 could be zero
					op1=*symbGetMangledName(v1->sym)+"[rip+"+str(v1->ofs)+"]"
					desttyp=KUSE_LEA
					asm_info("copy use LEA")

				case IR_VREGTYPE_IMM
					op1="["+str(v1->value.i)+"]"
				case else
					asm_error("memcopy 01 type not handled")
			end select
			''source
			select case v2->typ
				case IR_VREGTYPE_REG
					regsrc=reg_findreal(v2->reg)
					op2=*regstrq(regsrc)
				case IR_VREGTYPE_VAR
					if symbIsStatic(v2->sym) Or symbisshared(v2->sym) then
						op2=*symbGetMangledName(v2->sym)+"[rip+"+Str(v2->ofs)+"]"
					else
						op2=Str(v2->ofs)+"[rbp]"
					end if
					'srctyp=KUSE_LEA ''used with memcopy
				case IR_VREGTYPE_OFS
					op2=*symbGetMangledName(v2->sym)+"[rip+"+str(v2->ofs)+"]"
					srctyp=KUSE_LEA
				case IR_VREGTYPE_PTR ''format ofs1 <vidx=reg>
					op2=Str(v2->ofs)+"["+*regstrq(reg_findreal(v2->vidx->reg))+"]"
				case else
					asm_error("Memcopy v2 not a reg nor a var nor ofs nor ptr")
			end select

			if op3<>"" then emitop3_op4(op3)
			select case bytes
				case is>8,3,5,6,7
					memcopy(bytes,op2,op1,srctyp,desttyp)
				case else
					if v2->typ=IR_VREGTYPE_VAR then
						asm_info("copy to VAR2 use mov")
						asm_code("mov rax, "+op2)
						op2="["+*regtempo+"]"
					elseif v2->typ<>IR_VREGTYPE_REG then
						asm_code("lea rax, "+op2)
						regsrc=KREG_RAX
					end if
					if v1->typ=IR_VREGTYPE_VAR then
						asm_info("copy to VAR1 use mov")
						regtempo=reg_tempo
						asm_code("mov "+*regtempo+", "+op1)
						op1="["+*regtempo+"]"
					end if
					select case bytes
						case 1
							asm_code("mov al, ["+*regstrq(regsrc)+"]")
							if v1->typ=IR_VREGTYPE_REG then
								asm_code("mov BYTE PTR ["+op1+"], al")
							else
								asm_code("mov "+op1+", al")
							end if
						case 2
							asm_code("mov ax, ["+*regstrq(regsrc)+"]")
							if v1->typ=IR_VREGTYPE_REG then
								asm_code("mov WORD PTR ["+op1+"], ax")
							else
								asm_code("mov "+op1+", ax")
							end if
						case 4
							asm_code("mov eax, ["+*regstrq(regsrc)+"]")
							if v1->typ=IR_VREGTYPE_REG then
								asm_code("mov DWORD PTR ["+op1+"], eax")
							else
								asm_code("mov "+op1+", eax")
							end if
						case 8
							asm_code("mov rax, ["+*regstrq(regsrc)+"]")
							if v1->typ=IR_VREGTYPE_REG then
								asm_code("mov QWORD PTR ["+op1+"], rax")
							else
								asm_code("mov "+op1+", rax")
							end if
					end select
			end select
	end select

end sub
private sub _emitcomment( byval text as zstring ptr )
	#ifdef basicdata
		if text=0 Or LTrim(*text)="" Or left(ltrim(*text, Any Chr(32)+Chr(9)),1)="'" then exit sub

		hWriteasm64 ( "# -----------------------------------------")
		hWriteasm64 ( "# basic --> " + Trim(*text, Any " "+Chr(9)) )
		hWriteasm64 ( "# -----------------------------------------")
	#endif
end sub
private sub _emitasmline( byval asmtokenhead as ASTASMTOK ptr )
	dim asmline as string
	asm_info("_emitasmline")
	var n = asmtokenhead
	while( n )

		select case( n->type )
			case AST_ASMTOK_TEXT
				asmline += *n->text
				'asm_info("asm text="+*n->text)
			case AST_ASMTOK_SYMB

				Var ofs = symbGetOfs( n->sym )
				if( ofs <> 0 ) then
					asmline+= str( ofs )+"[rbp]"
				else
					asmline+= *symbGetMangledName( n->sym )'*symbGetMangledName( n->sym )
				end if
				'asm_info("asm symb="+*symbGetMangledName( n->sym )+" ofs="+Str(symbGetOfs( n->sym )))
			case else
				asm_error("in emitasm token unknown")
		end select

		n = n->next
	wend
	ctxdbg.lnum=-1 ''to avoid generation of label when debug on
	asm_code(asmline)
end sub
private sub _emitvarinibegin( byval sym as FBSYMBOL ptr )
	dim as integer align

	''todo add array case but dynamic not defined ???
	if (symbgettype(sym) = FB_DATATYPE_STRUCT) then
		align=sym->subtype->udt.natalign
		asm_info("length udt="+Str(sym->lgt)+" natalign="+Str(sym->subtype->udt.natalign)+" unpadlgt="+Str(sym->subtype->udt.unpadlgt))
	else
		if symbIsRef(sym) then
			''byref variable, as getsize is wrong
			align=typeGetSize( FB_DATATYPE_LONGINT )
		else
			align=typeGetSize(symbGetType( sym ))
		end if
	end if
	asm_section(".data")
	if symbIsPublic( sym ) then
		asm_code(".globl "+*symbGetMangledName( sym ))
	end if
	asm_code(".align "+Str(align))
	asm_code(*symbGetMangledName( sym )+":")
	if( symbIsExtern( sym ) or symbIsDynamic( sym ) ) then
	else
		if( env.clopt.debuginfo = true ) then edbgemitglobalvar_asm64(sym,IR_SECTION_DATA)
	end if
end sub
private sub _emitvarinii( byval sym as FBSYMBOL ptr, byval value as longint )
	dim as string siz
	dim as long lgt
	'var dtype = typeGetDtOnly(symbGetType( sym ))
	var dtype = symbGetType( sym )

	if typeisptr(dtype) then dtype=FB_DATATYPE_INTEGER


	'' AST stores boolean true as -1, but we emit it as 1 for gcc compatibility
	if( (dtype = FB_DATATYPE_BOOLEAN) and (value <> 0) ) then
		value = 1
	end if

	select case as const typeGetSize( dtype )
		case 1
			siz=".byte"
			lgt=2
		case 2
			siz=".word"
			lgt=4
		case 4
			siz=".long"
			lgt=8
		case 8
			siz=".quad"
			lgt=16
		case else
			asm_info("siz=unknown"+" dtype="+Str(dtype)+" size="+Str(typeGetSize( dtype ))+ "--> default siz=quad 8")
			siz=".quad"
			lgt=8
	end select
	asm_code(siz+" 0x" + right(hex( value ),lgt)+" # "+Str(value))

end sub
private sub _emitvarinif( byval sym as FBSYMBOL ptr, byval value as double )
	asm_code(hFloatToHex_asm64(value,symbGetType( sym )))
end sub
private sub _emitprocbegin(byval proc as FBSYMBOL ptr,byval initlabel as FBSYMBOL ptr)

	irhlEmitProcBegin( ) ''just : irhl.regcount = 0

	ctx.prolog_txt=""
	ctx.epilog_txt=""

	''useful ?
	ctx.labelbranch2=0
	ctx.labeljump=0
	ctx.jmpvreg=KREGFREE
	ctx.jmppass=0
	ctx.opepass=0

	ctx.variadic=false
	ctx.proc_txt=""
	ctx.section=SECTION_PROLOG
	ctx.proccalling=false
	ctxdbg.lnum=-1
	asm_info("=============================================================================")
	asm_info("===== Proc begin : "+ *symbGetMangledName( proc )+" =====")
	asm_info("=============================================================================")
	ctx.indent+=1

	ctx.arginteg=0 ''nb arg integer
	ctx.argfloat=0 ''nb arg float
	if ctx.systemv then
		ctx.ofs=16    ''parameter offset on stack
		ctx.stk=40    ''see stack organization
	else
		ctx.ofs=8      ''parameter offset
		ctx.stk=56    ''see stack organization
	end if

	ctx.argcptmax=0
	ctx.usedreg=0 ''registers used
	ctx.stkmax=0
	if( symbIsExport( proc ) ) then
		asm_section(".drectve")
		asm_code(".ascii "" -export:"+*symbGetMangledName( proc )+"""")
		asm_section(".text")
	end if

	asm_info( hEmitProcHeader( proc)  )

	''variadic ?
	var param = symbGetProcTailParam( proc )
	if param then
		if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
			ctx.variadic=true
			if ctx.systemv then
				''14 registers (6 rxx and 8 xmmn) could be used for arguments, the others are on stack
				ctx.stk+=14*8
			end if
		end if
	end if

	asm_code(".text")
	if symbisprivate(proc)=FALSE then
		asm_code(".globl "+*symbGetMangledName( proc ))
	end if
	cfi_windows_asm_code(".seh_proc "+*symbGetMangledName( proc ))
	ctx.indent-=1
	asm_code(*symbGetMangledName( proc )+":")
	cfi_asm_code(".cfi_startproc")
	ctx.indent+=1

	asm_info("stk4="+Str(ctx.stk)+" reserved space for saving registers when proc calls")

	if( env.clopt.debuginfo = true ) then edbgEmitProcHeader_asm64(proc)

	ctx.section=SECTION_PROC

end sub
private sub _emitprocend _
	( _
	byval proc as FBSYMBOL ptr, _
	byval initlabel as FBSYMBOL ptr, _
	byval exitlabel as FBSYMBOL ptr _
	)
	dim as long idx
	dim as string restreg,lname
	asm_info("stk="+Str(ctx.stk))
	if ctx.stkmax>ctx.stk then ctx.stk=ctx.stkmax

	if ctx.target=FB_COMPTARGET_WIN32 then
		''if there is at least one argument then 32
		if ctx.argcptmax then ctx.stk+=IIf(ctx.argcptmax>4,ctx.argcptmax*8,32)
	else
		ctx.stk+=ctx.argcptmax*8
	end if

	ctx.stk=((ctx.stk+15) and (Not 15))

	asm_info("stk5="+Str(ctx.stk))
	''--> PROLOG code select special area before writing
	ctx.section=SECTION_PROLOG

	if symbIsNaked(proc)=false then

		asm_code("push rbp")
		'' the locations of the cfi/seh statements are important
		'' so they do have to split the two prologue instructions
		cfi_windows_asm_code(".seh_pushreg rbp")
		cfi_asm_code(".cfi_def_cfa_offset 16") '' 16 = return address + this push
		cfi_asm_code(".cfi_offset 6, -16") '' register 6 = rbp
		asm_code("mov  rbp,rsp")
		cfi_windows_asm_code(".seh_setframe rbp, 0") '' 0 = offset into this function's stack alloocation
		cfi_asm_code(".cfi_def_cfa_register 6")

		if env.clopt.nullptrchk=true then
			asm_code("add qword ptr $totalstacksize[rip], "+str(ctx.stk))
			asm_code("cmp qword ptr $totalstacksize[rip], "+str(ctx.maxstack))

			asm_code(".section .data")
			asm_code(".align 8")
			var lname1 = *symbUniqueLabel( )
			asm_code(lname1+":")
			'asm_code(".ascii """+*s+$"\0""")
			asm_code(".ascii ""Aborting : stack overflow "+env.inf.name+" "+*symbGetMangledName( proc )+$"\0""")

			asm_code(".text")
			var lname = *symbUniqueLabel( )
			asm_code("jl "+lname)

			if ctx.systemv then
				asm_code("lea rdi, "+lname1+"[rip]")
				asm_code("call fb_StrAllocTempDescZ")

				asm_code("xor edi, edi")
				asm_code("mov rsi, rax")
				asm_code("mov rdx, 1")
				asm_code("call fb_PrintString")

				asm_code("mov rdi, 4")
			else
				asm_code("lea rcx, "+lname1+"[rip]")
				asm_code("call fb_StrAllocTempDescZ")

				asm_code("xor ecx, ecx")
				asm_code("mov rdx, rax")
				asm_code("mov r8d, 1")
				asm_code("call fb_PrintString")

				asm_code("mov rcx, 4")
			end if
			asm_code("call fb_End")
			asm_code(lname+":")
		end if


		if ctx.stk>=2147483648 then
			asm_code("mov rax, "+Str(ctx.stk))
			asm_code("sub rsp, rax")
		else
			asm_code("sub rsp, "+Str(ctx.stk))
		end if
		cfi_windows_asm_code(".seh_stackalloc " + Str(ctx.stk))
		cfi_windows_asm_code(".seh_endprologue")

		if ctx.stk>=culngint( ctx.maxstack ) then
			dim as string msgex=" proc="+*symbGetMangledName( proc )+" STACK OVERFLOW, review array size, use redim/shared or increase stack size"
			errReportWarnex(FB_WARNINGMSG_HUGEVARONSTACK,0,-1,,strptr(msgex) )
		end if
		'inside prolog/epilog
		'--------------------
		''reg used in called
		if ctx.usedreg And (1 Shl KREG_RBX) then asm_code("mov QWORD PTR -8[rbp], rbx")  :restreg+="mov  rbx, QWORD PTR -8[rbp]"+NEWLINE2
		if ctx.target=FB_COMPTARGET_WIN32 then
			if ctx.usedreg And (1 Shl KREG_RDI) then asm_code("mov QWORD PTR -16[rbp], rdi") :restreg+="mov  rdi, QWORD PTR -16[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_RSI) then asm_code("mov QWORD PTR -24[rbp], rsi") :restreg+="mov  rsi, QWORD PTR -24[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R12) then asm_code("mov QWORD PTR -32[rbp], r12") :restreg+="mov  r12, QWORD PTR -32[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R13) then asm_code("mov QWORD PTR -40[rbp], r13") :restreg+="mov  r13, QWORD PTR -40[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R14) then asm_code("mov QWORD PTR -48[rbp], r14") :restreg+="mov  r14, QWORD PTR -48[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R15) then asm_code("mov QWORD PTR -56[rbp], r15") :restreg+="mov  r15, QWORD PTR -56[rbp]"+NEWLINE2
		else
			if ctx.usedreg And (1 Shl KREG_R12) then asm_code("mov QWORD PTR -16[rbp], r12") :restreg+="mov  r12, QWORD PTR -16[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R13) then asm_code("mov QWORD PTR -24[rbp], r13") :restreg+="mov  r13, QWORD PTR -24[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R14) then asm_code("mov QWORD PTR -32[rbp], r14") :restreg+="mov  r14, QWORD PTR -32[rbp]"+NEWLINE2
			if ctx.usedreg And (1 Shl KREG_R15) then asm_code("mov QWORD PTR -40[rbp], r15") :restreg+="mov  r15, QWORD PTR -40[rbp]"+NEWLINE2
		end if
		if restreg<>"" then restreg=rtrim(restreg)
	end if

	if ctx.systemv then
		if ctx.variadic then
			if ctx.arginteg <1 then asm_code("mov QWORD PTR -152[rbp], rdi")
			if ctx.arginteg <2 then asm_code("mov QWORD PTR -144[rbp], rsi")
			if ctx.arginteg <3 then asm_code("mov QWORD PTR -136[rbp], rdx")
			if ctx.arginteg <4 then asm_code("mov QWORD PTR -128[rbp], rcx")
			if ctx.arginteg <5 then asm_code("mov QWORD PTR -120[rbp], r8")
			if ctx.arginteg <6 then asm_code("mov QWORD PTR -112[rbp], r9")
			''if eax is null no float argument so need to save them
			lname = *symbUniqueLabel( )
			asm_code("test eax, eax")
			asm_code("jz "+lname)
			if ctx.argfloat <1 then asm_code("movq QWORD PTR -104[rbp], xmm0")
			if ctx.argfloat <2 then asm_code("movq QWORD PTR -96[rbp], xmm1")
			if ctx.argfloat <3 then asm_code("movq QWORD PTR -88[rbp], xmm2")
			if ctx.argfloat <4 then asm_code("movq QWORD PTR -80[rbp], xmm3")
			if ctx.argfloat <5 then asm_code("movq QWORD PTR -72[rbp], xmm4")
			if ctx.argfloat <6 then asm_code("movq QWORD PTR -64[rbp], xmm5")
			if ctx.argfloat <7 then asm_code("movq QWORD PTR -56[rbp], xmm6")
			if ctx.argfloat <8 then asm_code("movq QWORD PTR -48[rbp], xmm7")
			asm_code(lname+":")
		end if
	end if

	''--> EPILOG code
	ctx.section=SECTION_EPILOG

	if env.clopt.nullptrchk=true then
		asm_code("sub qword ptr $totalstacksize[rip], "+str(ctx.stk))
	EndIf

	if( env.clopt.debuginfo = true ) then
		lname = *symbUniqueLabel( )
		dbg_addstab(,STAB_TYPE_RBRAC,,lname+"-"+*symbGetMangledName( ctxdbg.proc ))
		asm_code(lname+":")
	end if

	if symbIsNaked(proc)=false then
		if restreg<>"" then asm_code(restreg)
		''not usefull Asm_code("add rsp,XXXXX") as moving rbp to rsp restore the value just after the call and the push rbp
		asm_code("mov rsp,rbp")
		asm_code("pop rbp")
		cfi_asm_code(".cfi_restore 6") '' rbp now back to what it was
		cfi_asm_code(".cfi_def_cfa 7, 8") '' and the stack frame is back to rsp+8
	end if
	asm_code("ret")
	cfi_asm_code(".cfi_endproc")
	cfi_windows_asm_code(".seh_endproc")

	if( env.clopt.debuginfo = true ) then
		dim as string lname = *symbUniqueLabel( )
		dbg_addstab(,STAB_TYPE_FUN,,lname+"-"+*symbGetMangledName( ctxdbg.proc ))
		asm_code(lname+":")
	end if

	ctx.indent -= 1
	asm_info("===== End of proc =====")

	flistReset( @ctx.spillvregs )
	ctx.vreg_count = 0

	irhlEmitProcEnd( ) ''just flistReset( @irhl.vregs )

	ctx.body_txt+=ctx.prolog_txt+ctx.proc_txt+ctx.epilog_txt ''assembling all the parts
	ctx.section=SECTION_HEAD ''to keep information that could be send after as ctx.epilog_txt will be erased

end sub
private sub _emitvariniofs(byval sym as FBSYMBOL ptr,byval rhs as FBSYMBOL ptr,byval ofs as longint)

	asm_info("in _emitVarIniOfs  sym="+*symbGetMangledName(sym))
	asm_info("rhs="+*symbGetMangledName(rhs)+" / "+*symbGetMangledName( rhs ))
	asm_info("ofs="+Str(ofs))

	var s = *symbGetMangledName( rhs )
	var symdtype = symbGetType( sym )
	var ptrdtype = typeAddrOf( symbGetType( rhs ) )

	asm_info("symdtype="+typedumpToStr(symdtype,0))
	asm_info("ptrdtype="+typedumpToStr(ptrdtype,0))

	if( ofs <> 0 ) then
		asm_info("_emitVarIniOfs s="+s+" if ofs <>0 should be added ")
		asm_code(".quad "+s+"+"+Str(ofs))
	else
		asm_code(".quad "+s)
	end if
end sub
private sub _emitvarinipad( byval bytes as longint )
	asm_info("_emitvarinipad="+Str(bytes))
	asm_code(".zero "+Str(bytes))
end sub
private sub _emitfbctinfstring( byval s as const zstring ptr )
	asm_info("_emitfbctinfstring="+*s)
	asm_section("."+FB_INFOSEC_NAME)
	asm_code(".ascii """+*s+$"\0""")
end sub
private sub _emitvarinistr(byval varlength as longint,byval literal as zstring ptr,byval litlength as longint)
	dim as const zstring ptr s

	asm_info("emitVarIniStr="+*literal)
	'asm_code(".align 8")
	if varlength=0 then
		asm_code(".byte 0 # 0")
		exit sub
	end if
	if varlength<litlength then ''too big for planned space ?
		errReportWarn( FB_WARNINGMSG_LITSTRINGTOOBIG )
		s = hEscape( left( *literal, varlength ) )
	else
		s = hEscape( literal )
	end if
	asm_code(".ascii """+*s+$"\0""")
	If( litlength < varlength ) then ''skip the exceding space
		asm_code(".zero "+Str( varlength - litlength ))
	end if
end sub

private sub _emitVarIniWstr (byval totlgt as longint,byval litstr as wstring ptr,byval litlgt as longint)

	dim as zstring ptr s
	dim as string ostr
	dim as integer wclen=typeGetSize( FB_DATATYPE_WCHAR )
	asm_info("MYWSTR="+str(litlgt))
	'asm_code(".align 8")
	if( totlgt = 0 ) then
		if wclen=2 then
			asm_code(".word "+str(0))
		else
			asm_code(".long "+str(0))
		end if
		exit sub
	end if

	''
	if( litlgt > totlgt ) then
		errReportWarn( FB_WARNINGMSG_LITSTRINGTOOBIG )
		'' !!!FIXME!!! truncate will fail if it lies on an escape seq
		s = hEscapeW( left( *litstr, totlgt ) )
	else
		s = hEscapeW( litstr )
	end if
	ostr = ".ascii " + QUOTE + *s + left($"\0\0\0\0",typeGetSize( FB_DATATYPE_WCHAR )*2) + QUOTE
	asm_code( ostr )

	if( litlgt < totlgt ) then
		'emitVARINIPAD( (totlgt - litlgt) * wclen )
		asm_code(".zero "+Str((totlgt - litlgt) * wclen))
	end if
'
end sub

private sub _emitMacro( byval op as integer,byval v1 as IRVREG ptr, byval v2 as IRVREG ptr, byval vr as IRVREG ptr )
	dim as IRVREG ptr tempo1,tempo2
	dim as long savereg,startarg,vreg
	dim as string regvalist,lname1,lname2
	asm_info( "Macro op=" + astdumpopToStr( op ))
	asm_info("v1="+vregdumpfull(v1))
	asm_info("v2="+vregdumpfull(v2))
	asm_info("vr="+vregdumpfull(vr))

	if ctx.target=FB_COMPTARGET_WIN32 then
		v1->dtype= FB_DATATYPE_INTEGER ''forcing type to avoid type va_list
	end if
	select case op
		case AST_OP_VA_START

'# Info --> Macro op=VA_START
'# Info --> v1=var ARGS ofs=-144 [va_list alias "va_list"] symbdump=var local accessed declared ARGS [any alias "va_list" ptr]
'# Info --> v2=var PAD4 ofs=48 [integer] symbdump=var local parambyval accessed declared PAD4 [integer]
'# Info --> vr=<NULL>
			tempo1 = irhlAllocVreg( FB_DATATYPE_INTEGER, 0 )
			reg_findfree(tempo1->reg)
			''gp_offset
			''fp_offset
			''overflow_arg_area
			''reg_save_area

			if ctx.systemv then
				_emitaddr(AST_OP_ADDROF,v1,tempo1)
				regvalist=*regstrq(reg_findreal(tempo1->reg))
				asm_code("mov DWORD PTR ["+regvalist+"], "+str(ctx.arginteg*8),KNOALL)  ''offset reg size 4
				asm_code("mov DWORD PTR 4["+regvalist+"], "+str(ctx.argfloat*8+48)) ''offset float 4
				startarg=(iif(ctx.arginteg<=6,0,ctx.arginteg-6)+iif(ctx.argfloat<=8,0,ctx.argfloat-8))*8+16
				asm_code("lea rax,"+str(startarg)+"[rbp]")   ''ad stack
				asm_code("mov QWORD PTR 8["+regvalist+"], rax")
				asm_code("lea rax, -152[rbp]") ''ad reg see stack organization
				asm_code("mov QWORD PTR 16["+regvalist+"], rax")

			else
				asm_code("lea "+*regstrq(reg_findreal(tempo1->reg))+", "+str(ctx.arginteg*8+16)+"[rbp]")
				_emitstore(v1,tempo1)
			end if

			if v2->typ=IR_VREGTYPE_PTR then
				''removal of useless register as v2 not used / PTR -> ofs1 <vidx=reg>
				vreg=v2->vidx->reg
				for ireg as integer =1 to KREGUPPER
					if reghandle(ireg)=vreg then
						asm_info("VA_START release for PTR reg not used="+str(vreg))
						reghandle(ireg)=KREGFREE
						exit for
					end if
				next
			end if

		case AST_OP_VA_ARG

'# -----------------------------------------
'# basic --> sum += Cva_Arg(args,byte)
'# -----------------------------------------
'# Info --> Macro op=VA_ARG
'# Info --> v1=var ARGS ofs=-144 [va_list alias "va_list"] symbdump=var local accessed declared ARGS [any alias "va_list" ptr]
'# Info --> v2=<NULL>
'# Info --> vr=reg 3 [integer] or double if single/double


			if ctx.systemv then
				''linux
				tempo1 = irhlAllocVreg( FB_DATATYPE_INTEGER, 0 )
				reg_findfree(vr->reg)
				_emitaddr(AST_OP_ADDROF,v1,tempo1)
				regvalist=*regstrq(reg_findreal(tempo1->reg))
				lname1 = *symbUniqueLabel( )
				lname2 = *symbUniqueLabel( )
				if vr->dtype=FB_DATATYPE_DOUBLE or vr->dtype=FB_DATATYPE_SINGLE then
					''double/single
					asm_code("cmp DWORD PTR 4["+regvalist+"], 104")
					asm_code("jg "+lname1)
					''in a register
					asm_code("mov eax, DWORD PTR 4["+regvalist+"]")
					asm_code("add DWORD PTR 4["+regvalist+"], 8")
					'asm_code("neg rax")
					asm_code("add rax, QWORD PTR 16["+regvalist+"]")
					asm_code("jmp "+lname2)
					asm_code(lname1+":")
					''should be on stack
					asm_code("mov rax, QWORD PTR 8["+regvalist+"]")
					asm_code("add QWORD PTR 8["+regvalist+"], 8")
					asm_code(lname2+":")
					asm_code("mov "+*regstrq(reg_findreal(vr->reg))+", [rax]")
				else
					''others
					asm_code("cmp DWORD PTR ["+regvalist+"], 40")
					asm_code("jg "+lname1)
					''in a register
					asm_code("mov eax, DWORD PTR ["+regvalist+"]")
					asm_code("add DWORD PTR ["+regvalist+"], 8")
					'asm_code("neg rax")
					asm_code("add rax, QWORD PTR 16["+regvalist+"]")
					asm_code("jmp "+lname2)
					asm_code(lname1+":")
					''should be on stack
					asm_code("mov rax, QWORD PTR 8["+regvalist+"]")
					asm_code("add QWORD PTR 8["+regvalist+"], 8")
					asm_code(lname2+":")
					asm_code("mov "+*regstrq(reg_findreal(vr->reg))+", [rax]")
				end if
			else
				''windows
				if v1->typ=IR_VREGTYPE_PTR then
					savereg=reg_findreal(v1->vidx->reg)
				elseif v1->typ=IR_VREGTYPE_REG then
					savereg=reg_findreal(v1->reg)
				end if

				if v1->typ<>IR_VREGTYPE_REG or typeIsPtr( v1->dtype )=true then
					_emitaddr(AST_OP_DEREF,v1,vr)

					if v1->typ=IR_VREGTYPE_PTR then
						reghandle(savereg)=v1->vidx->reg
					elseif v1->typ=IR_VREGTYPE_REG then
						reghandle(savereg)=v1->reg
					end if
					tempo1=irhlAllocVrImm(FB_DATATYPE_INTEGER,0,8)
					_emitbop(AST_OP_ADD,v1,tempo1,0,0)''add 8 for next arg
				else
					vr->reg=v1->reg
				end if

				asm_code("mov "+*regstrq(reg_findreal(vr->reg))+", ["+*regstrq(reg_findreal(vr->reg))+"]")

			end if

		case AST_OP_VA_END
			asm_info("Call emit macro END  nothing to do ?")
			if v1->typ=IR_VREGTYPE_PTR then
				''removal of useless register as v1 not used / PTR -> ofs1 <vidx=reg>
				vreg=v1->vidx->reg
				for ireg as integer =1 to KREGUPPER
					if reghandle(ireg)=vreg then
						asm_info("VA_END release for PTR reg not used="+str(vreg))
						reghandle(ireg)=KREGFREE
						exit for
					end if
				next
			end if
		case AST_OP_VA_COPY
			if ctx.systemv then
				''linux
				tempo1 = irhlAllocVreg( FB_DATATYPE_INTEGER, 0 )
				_emitaddr(AST_OP_ADDROF,v1,tempo1)
				tempo2 = irhlAllocVreg( FB_DATATYPE_INTEGER, 0 )
				_emitaddr(AST_OP_ADDROF,v2,tempo2)
				_emitmem(AST_OP_MEMMOVE,tempo1,tempo2,v1->sym->lgt)
			else
				''windows
				_emitstore(v1,v2)
			end if
	end select
end sub

''===============================
''keep it otherwise bad behaviour
''===============================
private sub _emitdecl( byval sym as FBSYMBOL ptr )
	'asm_info("_emitdecl="+*symbGetMangledName(sym))
end sub

static as IR_VTBL irgas64_vtbl = _
( _
@_init, _
@_end, _
@_emitBegin, _
@_emitEnd, _
@_getOptionValue, _
@_supportsOp, _
@_procBegin, _
@_procEnd, _
@_procAllocArg, _
@_procAllocLocal, _
NULL, _ /'_procGetFrameRegName '/
@_scopeBegin, _
@_scopeEnd, _
@_procAllocStaticVars, _
@_emitConvert, _
@_emitLabel, _
@_emitLabel,_ 'lNF, _ 'NULL, _ /' _emitLabelNF, '/
@_emitreturn, _
@_emitProcBegin, _
@_emitProcEnd, _
@irhlEmitPushArg, _
@_emitAsmLine, _
@_emitComment, _
@_emitBop, _
@_emitUop, _
@_emitStore, _
@_emitSpillRegs, _
@_emitLoad, _
@_emitLoadRes, _
NULL, _ /' _emitStack '/
@_emitAddr, _
@_emitCall, _
@_emitCallPtr, _
NULL, _ /' _emitStackAlign '/
@_emitJumpPtr, _
@_emitBranch, _
@_emitJmpTb, _
@_emitMem, _
@_emitMacro, _
@_emitScopeBegin, _
@_emitScopeEnd, _
@_emitDECL, _
@_emitDBG, _
@_emitVarIniBegin, _
@_emitVarIniEnd, _
@_emitVarIniI, _
@_emitVarIniF, _
@_emitVarIniOfs, _
@_emitVarIniStr, _
@_emitVarIniWstr, _
@_emitVarIniPad, _
@_emitVarIniScopeBegin, _
@_emitVarIniScopeEnd, _
@_emitFbctinfBegin, _
@_emitFbctinfString, _
@_emitFbctinfEnd, _
@irhlAllocVreg, _
@irhlAllocVrImm, _
@irhlAllocVrImmF, _
@irhlAllocVrVar, _
@irhlAllocVrIdx, _
@irhlAllocVrPtr, _
@irhlAllocVrOfs, _
@_setVregDataType, _
NULL, _ '/ _getDistance '/
NULL, _ '/ _loadVr '/
NULL, _ '/ _storeVr '/
NULL _ '/ _xchgTOS '/
)
''=============================================================
'' PROCS NOT USED for NOW =====================================
''=============================================================
private sub _emitscopebegin( byval s as FBSYMBOL ptr )
	'asm_info("_emitscopebegin="+*symbGetMangledName(s))
end sub
private sub _emitscopeend( byval s as FBSYMBOL ptr )
	'asm_info("_emitscopeend="+*symbGetMangledName(s))
end sub
private sub _emitvariniend( byval sym as FBSYMBOL ptr )
	'asm_info("in _emitVarIniend="+ctx.varini)
end sub
private sub _emitvariniscopebegin( byval sym as FBSYMBOL ptr, byval is_array as integer ) ''keep it but not used
	'asm_info("in _emitVarIniScopeBegin="+hEmitSymType(sym))
end sub
private sub _scopebegin( byval s as FBSYMBOL ptr ) ''keep it but not used
	'asm_info("_scopebegin="+*symbGetMangledName(s))
end sub
private sub _scopeend( byval s as FBSYMBOL ptr ) ''keep it but not used
	'asm_info("_scopeend="+*symbGetMangledName(s))
end sub
private sub _emitvariniscopeend( ) ''keep it but not used
	'asm_info("_emitVarIniScopeEnd")
end sub
private sub _emitfbctinfbegin( )
	''asm_error("_emitfbctinfbegin") ''just empty line
end sub
private sub _emitfbctinfend( )
	''asm_info("_emitfbctinfend")
end sub
private sub _emitspillregs( )
	/' do nothing '/
	'asm_error("emitSpillRegs used ???? = ")
end sub
private sub _emitload( byval v1 as IRVREG ptr )
	''asm_info("emitload used ???? v1="+vregdumpfull(v1))
end sub
private sub _emitlabelnf(byval label as FBSYMBOL Ptr)
	'_emit( AST_OP_LABEL, NULL, NULL, NULL, label )
	asm_error("emitlabelINF used ???? = "+ *symbGetMangledName( label ) )
end sub
private sub cfi_windows_asm_code(byval statement as string)
	if( env.clopt.unwindinfo = true ) then
		if ctx.target = FB_COMPTARGET_WIN32 then
			hWriteasm64(statement)
		end if
	end if
end sub
