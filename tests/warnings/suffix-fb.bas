'' parser-comment.bas
#print parser-comment.bas

'' parser-assignment.bas
#print parser-assignment.bas

	scope
		dim i as integer
		i and%= 1

	end scope

	namespace parser_assignment

		type T
			n as integer
		end type

		operator not%( byref x as T ) as T
			dim i as integer
			let%( i ) = x

			operator = x
		end operator

	end namespace


'' parser-compound-do.bas
#print parser-compound-do.bas

	scope
		do% while% 1
		loop%
		do
		loop% until% 1
	end scope


'' parser-compound-extern.bas
#print parser-compound-extern.bas

	extern% "c"
	end% extern%


'' parser-compound-for.bas
#print parser-compound-for.bas

	scope
		for% i as integer = 1 to% 2 step% 1
		next%
	end scope


'' parser-compound-if.bas
#print parser-compound-if.bas

	scope
		if% 1 then% print else% print end% if%
		if  1 then  print else  print endif%
		if% 1 then%
		elseif% 1 then%
		else%
		end% if%
		if 1 then
		endif%
	end scope


'' parser-compound-namespace.bas
#print parser-compound-namespace.bas

	namespace% parser_compound_namespace%
	end% namespace%
	using% parser_compound_namespace%


'' parser-compound-scope.bas
#print parser-compound-scope.bas
	scope%
	end% scope%


'' parser-compound-select-const.bas
#print parser-compound-select-const.bas

	scope
		select% case% as% const% 1
		case% 1 to% 2
		case% else%
		end% select%
	end scope


'' parser-compound-select.bas
#print parser-compound-select.bas

	scope
		select% case% 1
		case% 1 to% 2
		case is% > 3
		case else%
		end% select%
	end scope


'' parser-compound-while.bas
#print parser-compound-while.bas

	scope
		while% 1
		wend%
	end scope

'' parser-compound-with.bas
#print parser-compound-with.bas

	scope
		type A
			n as integer
		end type
		dim% t as% A
		with% t
		.n = 1
		end% with%
	end scope


'' parser-compound.bas
#print parser-compound.bas

	scope
		end%

		for i as integer = 1 to 2
			for j as integer = 1 to 2
				exit% for%, for%
				continue% for%, for%
			next
		next
		do
			do
				exit do%, do%
				continue% do%, do%
			loop
		loop
		while 1
			while 1
				exit while%, while%
				continue% while%, while%
			wend
		wend
		select case 1
		case 1 to 2
			select case 1
			case 1 to 2
				exit select%, select%
			end select
		end select
	end scope

	sub parser_compound_proc()
		exit sub%
	end sub
	function parser_compund_func() as integer
		function = 0
		exit function%
	end function


'' parser-decl-const.bas
#print parser-decl-const.bas

	scope
		const% i% as% integer = 1
	end scope


'' parser-decl-enum.bas
#print parser-decl-enum.bas

	scope
		enum% E% explicit%
			E_item1%
			E_item2% = E_item1%
		end% enum%
	end scope


'' parser-decl-proc-params.bas
#print parser-decl-proc-params.bas

	namespace parser_decl_proc_params
		sub PdeclPP_proc( byval% x% as% integer, byref% y as integer, a() as integer = any% )
		end sub 
	end namespace


'' parser-decl-proc.bas
#print parser-decl-proc.bas

	namespace parser_decl_proc

		declare% sub% PDP_proc()
		declare% function% F2() as integer
		type PDP_T
			x as integer
		end type
		declare operator% +( byref x as PDP_T, byref y as PDP_T ) as PDP_T
	end namespace

'' parser-decl-struct.bas
#print parser-decl-struct.bas

	namespace parser_decl_struct
		type% PdeclStruct_type field% = 1
			static% s as integer
			x as% integer = any%
			as% integer y
			dim% z as integer
			declare% sub% proc()
			public%:
			private%:
			protected%:
		end% type%

		union% PdeclStruct_union
			x as integer
			type%
				union% field% = 1
					a as integer
					b as single
				end union%
				d as double
			end% type%
		end% union%

		type PdeclStruct_type2 extends% PdeclStruct_type
		end type

	end namespace

'' parser-decl-symbtype.bas
#print parser-decl-symbtype.bas
	
	namespace parser_decl_symbtype
		type INNER_T
			n as integer
		end type
		enum INNER_E
			e
		end enum
		type INNER_DEF as integer ptr

		type T%
			aa as any alias% "char" ptr
			bb as typeof%( integer )
			uu as unsigned% integer
			b as boolean%
			s1 as byte%
			u1 as ubyte%
			s2 as short%
			u2 as ushort%
			s4 as long%
			u4 as ulong%
			sx as integer%
			ux as uinteger%
			s8 as longint%
			u8 as ulongint%
			s  as% single%
			d  as% double%
			a1 as string%
			a2 as string$
			z  as zstring% ptr
			w  as wstring% ptr
			cp as const% any% ptr%
			ccp as const% integer const% pointer%
			pp as sub%()
			fp as function%() as integer

			inner1 as INNER_T%
			inner2 as INNER_E%
			inner3 as INNER_DEF%
		end type

	end namespace


'' parser-decl-typedef.bas
#print parser-decl-typedef.bas
	
	namespace parser_decl_typedef
		type as FWD2 FWD0%
		type FWD1 as FWD2%
		type as% single real
		type PdeclT1 as% const% PdeclTX const% ptr%
		type PdeclT2 as% const% PdeclTX ptr%
	end namespace


'' parser-decl-var.bas
#print parser-decl-var.bas

	common% pdv3% as integer
	static% pdv4 as integer
	dim shared% pdv5 as integer
	extern% import% pdv6 alias% "pdv6" as integer
	var shared% pdv8 = 8

	scope
		dim% pdv1 as integer
		redim% preserve% pdv2() as integer

		var% pdv7 = 7
		var byref% pdv9 = pdv8

		dim byref% pdv10 as integer = pdv5
		dim byref% as% integer pdv11 = pdv5

		dim byref pdv12 as integer = pdv5, byref% pdv13 as integer = pdv5

		dim a1( 1 to% 3) as integer
		redim a2( any% ) as integer
	end scope

	namespace parser_decl_var
		sub PDV_proc()
			dim a as integer = any%
			dim byref% as integer b = a
		end sub
	end namespace


'' parser-decl.bas
#print parser-decl.bas

	namespace parser_decl
		public% sub PDV_proc1()
		end sub

		private% sub PDV_proc2()
		end sub
	end namespace


'' parser-expr-atom.bas
#print parser-expr-atom.bas

	namespace atom
		type A extends object
			n as integer
		end type
		type B extends A
			declare sub P()
		end type
		sub B.P()
			print base%.n
		end sub
	end namespace


'' parser-expr-binary.bas
#print parser-expr-binary.bas

	scope
		if% (1 andalso% 1 orelse% 1 ) then
		end if
		if( 1 and% 2 or% 3 xor% 4 imp% 5 eqv% 6 ) then
		end if
		print 1 mod% 2
		print 1 shl% 2
		print 1 shr% 2
	end scope

	namespace parser_expr_binary
		type B1 extends object
		end type
		type B2 extends B1
		end type
		sub code()
			if( B1 is% B2 ) then
			end if
		end sub
	end namespace


'' parser-expr-function.bas
#print parser-expr-function.bas

	type PEF_T
		n as integer
		declare function proc() as integer
	end type
	scope
		dim x as PEF_T
		print x.proc%()
	end scope
	

'' parser-expr-unary.bas
#print parser-expr-unary.bas

	#if defined%( A )
	#endif

	namespace parser_expr_unary
		sub code()
		end sub
	end namespace

	sub PEU
	end sub

	scope
		dim i as integer
		dim p as short ptr
		dim a as any ptr
		dim s as string
		if( not% i ) then
		end if
		i = cast%( short, i )
		p = cptr%( short ptr, @i )
		a = varptr%( i )
		a = procptr%( parser_expr_unary.code% )
		a = @PEU%
		a = strptr%( s )
	end scope


'' parser-expr-variable.bas
#print parser-expr-variable.bas

	namespace paser_exper_variable.bas
		type T0
			n as integer
		end type

		type T
			enum E
				I
			end enum
			const C as integer = 0
			static S as integer
			static TT as T0
			declare sub P() 
			F as integer
		end type

		sub proc
			dim x as T
			print x.C%
			print x.S%
			print x.F%
			print x.E%.I%
			'' print x.TT%.T0%.n% '' <<<<--- investigate this fbc bug
			print x.TT%.n%
		end sub
	end namespace


'' parser-inlineasm.bas
#print parser-inlineasm.bas

	asm% 
	end% asm%


'' parser-proc.bas
#print parser-proc.bas

	namespace parser_proc
		declare% sub% proc0 overload% lib% "lib" alias% "proc0" ()
		sub proc0() export%
		end	sub
		type T extends object
			declare static% sub stat()
			declare const% sub constant()
			declare abstract% sub a()
			declare virtual% sub v()
			declare constructor%()
			declare destructor%()
			declare function% f() as% double option%("fpu")
		end type
		type Q extends T
			declare virtual% sub v() override%
			declare function f2() byref% as integer
		end type
		declare sub p1 cdecl% ()
		declare sub p2 stdcall% ()
		declare sub p3 pascal% ()
		declare sub p4 naked% ()
		sub p1 cdecl() static%
		end sub
		constructor% T()
		end% constructor%
		sub gctor() constructor%
		end sub
		sub ggtor() destructor%
		end sub
		'' function f%() as integer
		'' end function
	end namespace


'' parser-proccall-args.bas
#print parser-proccall-args.bas

	namespace parser_proccall_args
		sub P( byref i as integer )
		end sub

		sub O overload( )
		end sub
		sub O overload( byref i as integer )
		end sub

		sub T()
			dim x as integer
			P( byval% x )
			P byval% x
			O( byval% x )
			O byval% x
		end sub
	end namespace

'' parser-quirk-array.bas
#print parser-quirk-array.bas

	scope
		dim a(10) as integer, b(10) as integer
		swap% a(1), b(1)
		print lbound%(a)
		print ubound%(a)
		erase% a
	end scope

'' parser-quirk-casting.bas
#print parser-quirk-casting.bas

	scope
		dim i as integer
		print cbool%(i)
		print cbyte%(i)
		print cubyte%(i)
		print cshort%(i)
		print cushort%(i)
		print cint%(i)
		print cuint%(i)
		print clng%(i)
		print culng%(i)
		print clngint%(i)
		print culngint%(i)
		print csng%(i)
		print cdbl%(i)
		print csign%(i)
		print cunsg%(i)
		
		type T
			n as integer
		end type
		dim a as T = type%<T>(1)
	end scope

'' parser-quirk-console.bas
#print parser-quirk-console.bas

	scope
		dim i as integer
		view% print% 1 to% 2
		width% 80
		color% 15, 1
		i = screen%( 0, 1 )
	end scope


'' parser-quirk-data.bas
#print '' parser-quirk-data.bas

startdata:
	data% 1,2,3
	sub parser_quirk_data()
		dim a as integer
		restore% startdata%
		read% a
	end sub
	


'' parser-quirk-error.bas
#print parser-quirk-error.bas


'' parser-quirk-file.bas
#print parser-quirk-file.bas

	scope
		close% #1

		open cons% for append as #1
		open err% for append as #1
		open scrn% for append as #1
		open pipe% "" for append as #1
		open lpt% "" for append as #1
		open com% "" for append as #1
		open com% "" for append encoding% "" as #1

		open% "" for% binary% as% #1 len% = 128
		open% "" for% random% as% #1
		open% "" for% binary% as% #1
		open% "" for% output% as% #1
		open% "" for% append% as% #1

		open "" for% binary access% read% as #1
		open "" for% binary access% write% as #1
		open "" for% binary access% read% write% as #1

		open "" for% binary shared% as #1
		open "" for% binary lock% read% as #1
		open "" for% binary lock% write% as #1
		open "" for% binary lock% read% write% as #1

		dim b as integer, s as string

		print using% ""; b
		print spc%(1);
		print tab%(1);
		
		print% #1, b
		write% #1, b
		input% #1, b
		line% input% #1, s
		get% #1, , b
		put% #1, , b
		seek% #1, b
		lock% #1, 1 to% 2
		unlock% #1, 1 to% 2

		print seek%( 1 )
		print open%( "" for input as #1 )
		print close%( 1 )
		print input%( 1 )
		print winput%( 1 )
		print get%(1, 2, b )
		print put%(1, 2, b )
		print name%( "", "" )

		name% "" as% ""
	end scope

'' parser-quirk-gfx
#print parser-quirk-gfx

	declare function PQG_custom( byval as uinteger, byval as uinteger, byval as any ptr ) as uinteger
	scope

		pset% step%(1, 2), 1
		preset% step%(1, 2), 1
		line% step%(1,2)-step%(2,3), , b%
		line% step%(1,2)-step%(2,3), , bf%
		circle% step%(1,2),3,4,5,6,7,f%
		paint% step%(1,2),3
		draw% ""
		draw% string% step% (1,2), ""
		view% screen%
		window% screen% (1,2)-(3,4)

		dim c() as integer

		palette% 1,2
		palette% get% 1, c(0)
		palette% get% using% c

		dim a as any ptr

		get% step%(1,2)-step%(3,4), a
		put% step%(1,2), a, pset%
		put% step%(1,2),a, (3,4)-step%(5,6), pset%
		put% (1,2), a, preset%
		put% (1,2), a, xor%
		put% (1,2), a, or%
		put% (1,2), a, and%
		put% (1,2), a, trans%
		put% (1,2), a, add%
		put% (1,2), a, alpha%
		put% (1,2), a, custom%, procptr( PQG_custom )

		screen% 0, 1
		a = imagecreate%( 1, 2, 3 )
		c(0) = point%(1,2)

	end scope


'' parser-quirk-goto-return.bas
#print parser-quirk-goto-return.bas

	namespace parser_quirk_goto_return
		function proc() as integer
			return% 1
		end function
	end namespace

'' parser-quite-iif.bas
#print parser-quite-iif.bas

	scope
		dim b as integer
		b = iif%(b, b, b)
	end scope


'' parser-quirk-math.bas
#print parser-quirk-math.bas

	scope
		dim d as double
		print ABS%(d)
		print SGN%(d)
		print FIX%(d)
		print FRAC%(d)
		print INT%(d)
		print SIN%(d)
		print ASIN%(d)
		print COS%(d)
		print ACOS%(d)
		print TAN%(d)
		print ATN%(d)
		print SQR%(d)
		print LOG%(d)
		print EXP%(d)
		print ATAN2%(d,d)
		print sizeof%(d)
		print len%(d)
	end scope


'' parser-quirk-mem.bas
#print parser-quirk-mem.bas

	scope
		dim a as integer ptr = new% integer [2]{any%}
		delete% a
	end scope

	namespace parser_quirk_mem
		type T
			n as integer
		end type
		sub proc()
			dim as T ptr x = new T(any%)
		end sub
	end namespace

'' parser-quirk-on.bas
#print parser-quirk-on.bas


'' parser-quirk-peekpoke.bas
#print parser-quirk-peekpoke.bas

scope
	dim b as integer
	poke% b, b
	b = peek%(b)
end scope


'' parser-quirk-string.bas
#print parser-quirk-string.bas

scope
	dim b as integer
	dim s as string
	print mid%(s, b, 1)
	print left%(s, b)
	print right%(s, b)
	print trim%(s, any% "")
	print ltrim%(s, any% "")
	print rtrim%(s, any% "")
	print lcase%(s)
	print ucase%(s)
	print tab%(b);
	print space%(b)
	print string%(b, 32)
	print mki%(b)
	print mkl%(b)
	print mks%(b)
	print mkd%(b)
	mid%(s, b, 1) = " "

	print cvd%(s)
	print cvs%(s)
	print cvi%(s)
	print cvl%(s)
	print cvshort%(s)
	print cvlongint%(s)

	print str%(b)
	print chr%(b)
	print asc%("")
	print instr%( "", any% "" )
	print instr%( 1, "", any% "" )
	print instrrev%( "", any% "" )

	dim as string * 10 x, y
	scope
		lset% x, y
		rset% x, y
	end scope

end scope

'' parser-quirk-vafirst.bas
#print parser-quirk-vafirst.bas


'' pp-cond.bas
#print pp-cond.bas


'' pp-pragma.bas
#print pp-pragma.bas

#pragma% push%( msbitfields% )
#pragma% msbitfields% = 0
#pragma% pop%( msbitfields% )
#pragma% once%

'' pp.bas
#print pp.bas

#define% PP
#undef% PP
#ifdef% PP
#endif
#ifndef% PP
#endif
#if% 1
#elseif% 1
#else%
#endif%
#assert%(1)
#print% 1
#include% once% "suffix-inc.bi"
#inclib% ""
#libpath% ""
'' #error%

#macro% PP2
#endmacro
#print% typeof%( 1 )
#lang% "fb"
#line% 1000
#dump%(1)
#odump%(1)

'' other
#print other
scope
	dim b as boolean = false%
	b = true%
end scope
