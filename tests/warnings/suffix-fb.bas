'' SUFFIX warnings

#lang "fb"

#macro WARN( W )
	#if (W=0)
		#print none expected
	#elseif (W=1)
		#print warning expected
	#elseif (W>1) and (W<10)
		#print W warnings expected
	#else
		#print argument must be 0 to 9
		#error
	#endif
#endmacro

#print ---- parser-comment.bas ----

#print ---- parser-assignment.bas ----

	scope
		dim i as integer
		WARN( 1 )
		i and%= 1

	end scope

	namespace parser_assignment

		type T
			n as integer
		end type

		WARN( 1 )
		operator not%( byref x as T ) as T
			dim i as integer
			WARN( 1 )
			let%( i ) = x

			operator = x
		end operator

	end namespace


#print ---- parser-compound-do.bas ----

	scope
		WARN( 2 )
		do% while% 1
		WARN( 1 )
		loop%
		do
		WARN( 2 )
		loop% until% 1
	end scope


#print ---- parser-compound-extern.bas ----

	WARN( 1 )
	extern% "c"
	WARN( 2 )
	end% extern%


#print ---- parser-compound-for.bas ----

	scope
		WARN( 3 )
		for% i as integer = 1 to% 2 step% 1
		WARN( 1 )
		next%
	end scope


#print ---- parser-compound-if.bas ----

	scope
		WARN( 5 )
		if% 1 then% print else% print end% if%
		WARN( 1 )
		if  1 then  print else  print endif%
		WARN( 2 )
		if% 1 then%
		WARN( 2 )
		elseif% 1 then%
		WARN( 1 )
		else%
		WARN( 2 )
		end% if%
		if 1 then
		WARN( 1 )
		endif%
	end scope


#print ---- parser-compound-namespace.bas ----

	WARN( 2 )
	namespace% parser_compound_namespace%
		WARN( 2 )
		namespace n2%.n3%
		end namespace
	WARN( 2 )
	end% namespace%
	WARN( 1 )
	using% parser_compound_namespace%


#print ---- parser-compound-scope.bas ----
	WARN( 1 )
	scope%
	WARN( 2 )
	end% scope%


#print ---- parser-compound-select-const.bas ----

	scope
		WARN( 4 )
		select% case% as% const% 1
		WARN( 2 )
		case% 1 to% 2
		WARN( 2 )
		case% else%
		WARN( 2 )
		end% select%
	end scope


#print ---- parser-compound-select.bas ----

	scope
		WARN( 2 )
		select% case% 1
		WARN( 2 )
		case% 1 to% 2
		WARN( 1 )
		case is% > 3
		WARN( 1 )
		case else%
		WARN( 2 )
		end% select%
	end scope


#print ---- parser-compound-while.bas ----

	scope
		WARN( 1 )
		while% 1
		WARN( 1 )
		wend%
	end scope

#print ---- parser-compound-with.bas ----

	scope
		type A
			n as integer
		end type
		WARN( 2 )
		dim% t as% A
		WARN( 1 )
		with% t
		.n = 1
		WARN( 2 )
		end% with%
	end scope


#print ---- parser-compound.bas ----

	scope
		WARN( 1 )
		end%

		for i as integer = 1 to 2
			for j as integer = 1 to 2
				WARN( 3 )
				exit% for%, for%
				WARN( 3 )
				continue% for%, for%
			next
		next
		do
			do
				WARN( 2 )
				exit do%, do%
				WARN( 3 )
				continue% do%, do%
			loop
		loop
		while 1
			while 1
				WARN( 2 )
				exit while%, while%
				WARN( 3 )
				continue% while%, while%
			wend
		wend
		select case 1
		case 1 to 2
			select case 1
			case 1 to 2
				WARN( 2 )
				exit select%, select%
			end select
		end select
	end scope

	sub parser_compound_proc()
		WARN( 1 )
		exit sub%
	end sub
	function parser_compund_func() as integer
		function = 0
		WARN( 1 )
		exit function%
	end function


#print ---- parser-decl-const.bas ----

	scope
		WARN( 2 )
		const% i as% integer = 1
	end scope


#print ---- parser-decl-enum.bas ----

	scope
		WARN( 3 )
		enum% E% explicit%
			WARN( 1 )
			E_item1%
			WARN( 2 )
			E_item2% = E_item1%
		WARN( 2 )
		end% enum%
	end scope


#print ---- parser-decl-proc-params.bas ----

	namespace parser_decl_proc_params
		WARN( 4 )
		sub proc1( byval% x as% integer, byref% y as integer, a() as integer = any% )
		end sub 
	end namespace


#print ---- parser-decl-proc.bas ----

	namespace parser_decl_proc

		WARN( 2 )
		declare% sub% PDP_proc()
		WARN( 2 )
		declare% function% F2() as integer
		type PDP_T
			x as integer
		end type
		WARN( 1 )
		declare operator% +( byref x as PDP_T, byref y as PDP_T ) as PDP_T
	end namespace

#print ---- parser-decl-struct.bas ----

	namespace parser_decl_struct
		WARN( 2 )
		type% PdeclStruct_type field% = 1
			WARN( 1 )
			static% s as integer
			WARN( 2 )
			x as% integer = any%
			WARN( 1 )
			as% integer y
			WARN( 1 )
			dim% z as integer
			WARN( 2 )
			declare% sub% proc()
			WARN( 1 )
			public%:
			WARN( 1 )
			private%:
			WARN( 1 )
			protected%:
		WARN( 2 )
		end% type%

		WARN( 1 )
		union% PdeclStruct_union
			x as integer
			WARN( 1 )
			type%
				WARN( 2 )
				union% field% = 1
					a as integer
					b as single
				WARN( 2 )
				end% union%
				d as double
			WARN( 2 )
			end% type%
		WARN( 2 )
		end% union%

		WARN( 1 )
		type PdeclStruct_type2 extends% PdeclStruct_type
		end type

	end namespace

#print ---- parser-decl-symbtype.bas ----
	
	namespace parser_decl_symbtype
		type INNER_T
			n as integer
		end type
		enum INNER_E
			e
		end enum
		type INNER_DEF as integer ptr

		WARN( 0 )
		type T%
			WARN( 1 )
			aa as any alias% "char" ptr
			WARN( 1 )
			bb as typeof%( integer )
			WARN( 1 )
			uu as unsigned% integer
			WARN( 1 )
			b as boolean%
			WARN( 1 )
			s1 as byte%
			WARN( 1 )
			u1 as ubyte%
			WARN( 1 )
			s2 as short%
			WARN( 1 )
			u2 as ushort%
			WARN( 1 )
			s4 as long%
			WARN( 1 )
			u4 as ulong%
			WARN( 1 )
			sx as integer%
			WARN( 1 )
			ux as uinteger%
			WARN( 1 )
			s8 as longint%
			WARN( 1 )
			u8 as ulongint%
			WARN( 1 )
			s  as single%
			WARN( 1 )
			d  as double%
			WARN( 1 )
			a1 as string%
			WARN( 1 )
			a2 as string$
			WARN( 1 )
			z  as zstring% ptr
			WARN( 1 )
			w  as wstring% ptr
			WARN( 3 )
			cp as const% any% ptr%
			WARN( 3 )
			ccp as const% integer const% pointer%
			WARN( 1 )
			pp as sub%()
			WARN( 1 )
			fp as function%() as integer

			WARN( 1 )
			inner1 as INNER_T%
			WARN( 1 )
			inner2 as INNER_E%
			WARN( 1 )
			inner3 as INNER_DEF%
		end type

	end namespace


#print ---- parser-decl-typedef.bas ----
	
	namespace parser_decl_typedef
		WARN( 1 )
		type as FWD2 FWD0%
		WARN( 1 )
		type FWD1 as FWD2%
		WARN( 1 )
		type as% single real
		WARN( 4 )
		type PdeclT1 as% const% PdeclTX const% ptr%
		WARN( 2 )
		type PdeclT2 as const% PdeclTX ptr%
	end namespace


#print ---- parser-decl-var.bas ----

	WARN( 1 )
	common% pdv3 as integer
	WARN( 1 )
	static% pdv4 as integer
	WARN( 1 )
	dim shared% pdv5 as integer
	WARN( 3 )
	extern% import% pdv6 alias% "pdv6" as integer
	WARN( 1 )
	var shared% pdv8 = 8

	scope
		WARN( 1 )
		dim% pdv1 as integer
		WARN( 2 )
		redim% preserve% pdv2() as integer

		WARN( 1 )
		var% pdv7 = 7
		WARN( 1 )
		var byref% pdv9 = pdv8

		WARN( 2 )
		dim byref% pdv10 as% integer = pdv5
		WARN( 2 )
		dim byref% as% integer pdv11 = pdv5

		WARN( 1 )
		dim byref pdv12 as integer = pdv5, byref% pdv13 as integer = pdv5

		WARN( 1 )
		dim a1( 1 to% 3) as integer
		WARN( 1 )
		redim a2( any% ) as integer
	end scope

	namespace parser_decl_var
		sub PDV_proc()
			WARN( 1 )
			dim a as integer = any%
			WARN( 1 )
			dim byref% as integer b = a
		end sub
	end namespace


#print ---- parser-decl.bas ----

	namespace parser_decl
		WARN( 1 )
		public% sub P1()
		end sub

		WARN( 1 )
		private% sub P2()
		end sub
	end namespace


#print ---- parser-expr-atom.bas ----

	namespace atom
		type A extends object
			n as integer
		end type
		type B extends A
			declare sub P()
		end type
		sub B.P()
			WARN( 1 )
			print base%.n
			WARN( 1 )
			print base.n%
		end sub

		type T
			n as integer
			declare constructor ()
		end type

		type T2 as T

		sub P()
			WARN( 1 )
			dim x as T = T%()
			WARN( 1 )
			dim y as T2 = T2%()
		end sub

	end namespace

#print ---- parser-expr-binary.bas ----

	scope
		WARN( 3 )
		if% (1 andalso% 1 orelse% 1 ) then
		end if
		WARN( 5 )
		if( 1 and% 2 or% 3 xor% 4 imp% 5 eqv% 6 ) then
		end if
		WARN( 1 )
		print 1 mod% 2
		WARN( 1 )
		print 1 shl% 2
		WARN( 1 )
		print 1 shr% 2
	end scope

	namespace parser_expr_binary
		type B1 extends object
		end type
		type B2 extends B1
		end type
		sub code()
			WARN( 1 )
			if( B1 is% B2 ) then
			end if
		end sub
	end namespace


#print ---- parser-expr-function.bas ----

	type PEF_T
		n as integer
		declare function proc() as integer
	end type
	scope
		dim x as PEF_T
		WARN( 1 )
		print x.proc%()
	end scope
	

#print ---- parser-expr-unary.bas ----

	WARN( 1 )
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
		WARN( 1 )
		if( not% i ) then
		end if
		WARN( 1 )
		i = cast%( short, i )
		WARN( 1 )
		p = cptr%( short ptr, @i )
		WARN( 1 )
		a = varptr%( i )
		WARN( 2 )
		a = procptr%( parser_expr_unary.code% )
		WARN( 1 )
		a = @PEU%
		WARN( 1 )
		a = strptr%( s )
	end scope


#print ---- parser-expr-variable.bas ----

	namespace paser_exper_variable
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
			WARN( 1 )
			print x.C%
			WARN( 1 )
			print x.S%
			WARN( 1 )
			print x.F%
			WARN( 2 )
			print x.E%.I%
			'' print x.TT%.T0%.n% '' <<<<--- investigate this fbc bug
			WARN( 2 )
			print x.TT%.n%
		end sub
	end namespace


#print ---- parser-inlineasm.bas ----

	WARN( 1 )
	asm% 
	WARN( 2 )
	end% asm%


#print ---- parser-proc.bas ----

	namespace parser_proc
		WARN( 5 )
		declare% sub% proc0 overload% lib% "lib" alias% "proc0" ()
		WARN( 1 )
		sub proc0() export%
		end	sub
		type T extends object
			WARN( 1 )
			declare static% sub stat()
			WARN( 1 )
			declare const% sub constant()
			WARN( 1 )
			declare abstract% sub a()
			WARN( 1 )
			declare virtual% sub v()
			WARN( 1 )
			declare constructor%()
			WARN( 1 )
			declare destructor%()
			WARN( 3 )
			declare function% f() as% double option%("fpu")
		end type
		type Q extends T
			WARN( 2 )
			declare virtual% sub v() override%
			WARN( 1 )
			declare function f2() byref% as integer
		end type
		WARN( 1 )
		declare sub p1 cdecl% ()
		WARN( 1 )
		declare sub p2 stdcall% ()
		WARN( 1 )
		declare sub p3 pascal% ()
		WARN( 1 )
		declare sub p4 naked% ()
		WARN( 1 )
		sub p1 cdecl() static%
		end sub
		WARN( 1 )
		constructor% T()
		WARN( 2 )
		end% constructor%
		WARN( 1 )
		sub gctor() constructor%
		end sub
		WARN( 1 )
		sub ggtor() destructor%
		end sub
#if SHOW_ERROR
		function f%() as integer
		end function
#endif
	end namespace


#print ---- parser-proccall-args.bas ----

	namespace parser_proccall_args
		sub P( byref i as integer )
		end sub

		sub O overload( )
		end sub
		sub O overload( byref i as integer )
		end sub

		sub T()
			dim x as integer
			WARN( 1 )
			P( byval% x )
			WARN( 1 )
			P byval% x
			WARN( 1 )
			O( byval% x )
			WARN( 1 )
			O byval% x
		end sub
	end namespace

#print ---- parser-proccall.bas ----

	namespace parser_proccall
		type Q
			n as integer
			declare constructor()
		end type
		type T extends Q
			x as Q
			declare constructor()
			declare property P() as integer
			declare function F() as integer
		end type

		constructor Q()
			WARN( 1 )
			constructor%()
		end constructor

		constructor T()
			WARN( 1 )
			base%()
			WARN( 1 )
			x.constructor%()
			WARN( 2 )
			base%.constructor%()
		end constructor

		property T.P() as integer
			WARN( 1 )
			property% = 1
		end property

		function T.F() as integer
			WARN( 1 )
			function% = 1
		end function

		operator not( byref x as T ) as T
			WARN( 1 )
			operator% = x
		end operator

	end namespace


#print ---- parser-quirk-array.bas ----

	scope
		dim a(10) as integer, b(10) as integer
		WARN( 1 )
		swap% a(1), b(1)
		WARN( 1 )
		print lbound%(a)
		WARN( 1 )
		print ubound%(a)
		WARN( 1 )
		erase% a
	end scope


#print ---- parser-quirk-casting.bas ----

	scope
		dim i as integer
		WARN( 1 )
		print cbool%(i)
		WARN( 1 )
		print cbyte%(i)
		WARN( 1 )
		print cubyte%(i)
		WARN( 1 )
		print cshort%(i)
		WARN( 1 )
		print cushort%(i)
		WARN( 1 )
		print cint%(i)
		WARN( 1 )
		print cuint%(i)
		WARN( 1 )
		print clng%(i)
		WARN( 1 )
		print culng%(i)
		WARN( 1 )
		print clngint%(i)
		WARN( 1 )
		print culngint%(i)
		WARN( 1 )
		print csng%(i)
		WARN( 1 )
		print cdbl%(i)
		WARN( 1 )
		print csign%(i)
		WARN( 1 )
		print cunsg%(i)
		
		type T
			n as integer
		end type
		WARN( 1 )
		dim a as T = type%<T>(1)
	end scope


#print ---- parser-quirk-console.bas ----

	scope
		dim i as integer
		WARN( 3 )
		view% print% 1 to% 2
		WARN( 1 )
		width% 80
		WARN( 1 )
		color% 15, 1
		WARN( 1 )
		i = screen%( 0, 1 )
	end scope


#print ---- parser-quirk-data.bas ----

startdata:
	WARN( 1 )
	data% 1,2,3
	sub parser_quirk_data()
		dim a as integer
		WARN( 2 )
		restore% startdata%
		WARN( 1 )
		read% a
	end sub
	


#print ---- parser-quirk-error.bas ----

	scope
		WARN( 1 )
		error% 1
		WARN( 1 )
		err% = 1
		WARN( 1 )
		dim e as integer = err%
	end scope


#print ---- parser-quirk-file.bas ----

	scope
		WARN( 1 )
		close% #1

		WARN( 1 )
		open cons% for append as #1
		WARN( 1 )
		open err% for append as #1
		WARN( 1 )
		open scrn% for append as #1
		WARN( 1 )
		open pipe% "" for append as #1
		WARN( 1 )
		open lpt% "" for append as #1
		WARN( 1 )
		open com% "" for append as #1
		WARN( 1 )
		open com% "" for append as #1
		WARN( 1 )
		open "" for output encoding% "" as #1

		WARN( 5 )
		open% "" for% binary% as% #1 len% = 128
		WARN( 4 )
		open% "" for% random% as% #1
		WARN( 4 )
		open% "" for% binary% as% #1
		WARN( 4 )
		open% "" for% output% as% #1
		WARN( 4 )
		open% "" for% append% as% #1

		WARN( 3 )
		open "" for% binary access% read% as #1
		WARN( 3 )
		open "" for% binary access% write% as #1
		WARN( 3 )
		open "" for% binary access% read% write% as #1

		WARN( 2 )
		open "" for% binary shared% as #1
		WARN( 3 )
		open "" for% binary lock% read% as #1
		WARN( 3 )
		open "" for% binary lock% write% as #1
		WARN( 4 )
		open "" for% binary lock% read% write% as #1

		dim b as integer, s as string

		WARN( 1 )
		print using% ""; b
		WARN( 1 )
		print spc%(1);
		WARN( 1 )
		print tab%(1);
		
		WARN( 1 )
		print% #1, b
		WARN( 1 )
		write% #1, b
		WARN( 1 )
		input% #1, b
		WARN( 2 )
		line% input% #1, s
		WARN( 1 )
		get% #1, , b
		WARN( 1 )
		put% #1, , b
		WARN( 1 )
		seek% #1, b
		WARN( 2 )
		lock% #1, 1 to% 2
		WARN( 2 )
		unlock% #1, 1 to% 2

		WARN( 1 )
		print seek%( 1 )
		WARN( 1 )
		print open%( "" for input as #1 )
		WARN( 1 )
		print close%( 1 )
		WARN( 1 )
		print input%( 1 )
		WARN( 1 )
		print winput%( 1 )
		WARN( 1 )
		print get%(1, 2, b )
		WARN( 1 )
		print put%(1, 2, b )
		WARN( 1 )
		print name%( "", "" )

		WARN( 2 )
		name% "" as% ""
	end scope


#print ---- parser-quirk-gfx

	declare function PQG_custom( byval as ulong, byval as ulong, byval as any ptr ) as ulong
	scope
		WARN( 2 )
		pset% step%(1, 2), 1
		WARN( 2 )
		preset% step%(1, 2), 1
		WARN( 4 )
		line% step%(1,2)-step%(2,3), , b%
		WARN( 4 )
		line% step%(1,2)-step%(2,3), , bf%
		WARN( 3 )
		circle% step%(1,2),3,4,5,6,7,f%
		WARN( 2 )
		paint% step%(1,2),3
		WARN( 1 )
		draw% ""
		WARN( 3 )
		draw% string% step% (1,2), ""
		WARN( 2 )
		view% screen%
		WARN( 2 )
		window% screen% (1,2)-(3,4)

		dim c() as integer

		WARN( 1 )
		palette% 1,2
		WARN( 2 )
		palette% get% 1, c(0)
		WARN( 3 )
		palette% get% using% c

		dim a as any ptr

		WARN( 3 )
		get% step%(1,2)-step%(3,4), a
		WARN( 3 )
		put% step%(1,2), a, pset%
		WARN( 4 )
		put% step%(1,2),a, (3,4)-step%(5,6), pset%
		WARN( 2 )
		put% (1,2), a, preset%
		WARN( 2 )
		put% (1,2), a, xor%
		WARN( 2 )
		put% (1,2), a, or%
		WARN( 2 )
		put% (1,2), a, and%
		WARN( 2 )
		put% (1,2), a, trans%
		WARN( 2 )
		put% (1,2), a, add%
		WARN( 2 )
		put% (1,2), a, alpha%
		WARN( 2 )
		put% (1,2), a, custom%, procptr( PQG_custom )

		WARN( 1 )
		screen% 0, 1
		WARN( 1 )
		a = imagecreate%( 1, 2, 3 )
		WARN( 1 )
		c(0) = point%(1,2)

	end scope


#print ---- parser-quirk-goto-return.bas ----

	namespace parser_quirk_goto_return
		function proc() as integer
			WARN( 1 )
			return% 1
		end function
	end namespace


#print ---- parser-quite-iif.bas ----

	scope
		dim b as integer
		WARN( 1 )
		b = iif%(b, b, b)
	end scope


#print ---- parser-quirk-math.bas ----

	scope
		dim d as double
		WARN( 1 )
		print ABS%(d)
		WARN( 1 )
		print SGN%(d)
		WARN( 1 )
		print FIX%(d)
		WARN( 1 )
		print FRAC%(d)
		WARN( 1 )
		print INT%(d)
		WARN( 1 )
		print SIN%(d)
		WARN( 1 )
		print ASIN%(d)
		WARN( 1 )
		print COS%(d)
		WARN( 1 )
		print ACOS%(d)
		WARN( 1 )
		print TAN%(d)
		WARN( 1 )
		print ATN%(d)
		WARN( 1 )
		print SQR%(d)
		WARN( 1 )
		print LOG%(d)
		WARN( 1 )
		print EXP%(d)
		WARN( 1 )
		print ATAN2%(d,d)
		WARN( 1 )
		print sizeof%(d)
		WARN( 1 )
		print len%(d)
	end scope


#print ---- parser-quirk-mem.bas ----

	scope
		WARN( 2 )
		dim a as integer ptr = new% integer [2]{any%}
		WARN( 1 )
		delete% a
	end scope

	namespace parser_quirk_mem
		type T
			n as integer
		end type
		sub proc()
			WARN( 1 )
			dim as T ptr x = new T(any%)
		end sub
	end namespace


#print ---- parser-quirk-on.bas ----


#print ---- parser-quirk-peekpoke.bas ----

scope
	dim b as integer
	WARN( 1 )
	poke% b, b
	WARN( 1 )
	b = peek%(b)
end scope


#print ---- parser-quirk-string.bas ----

scope
	dim b as integer
	dim s as string
	WARN( 1 )
	print mid%(s, b, 1)
	WARN( 1 )
	print left%(s, b)
	WARN( 1 )
	print right%(s, b)
	WARN( 2 )
	print trim%(s, any% "")
	WARN( 2 )
	print ltrim%(s, any% "")
	WARN( 2 )
	print rtrim%(s, any% "")
	WARN( 1 )
	print lcase%(s)
	WARN( 1 )
	print ucase%(s)
	WARN( 1 )
	print tab%(b);
	WARN( 1 )
	print space%(b)
	WARN( 1 )
	print string%(b, 32)
	WARN( 1 )
	print mki%(b)
	WARN( 1 )
	print mkl%(b)
	WARN( 1 )
	print mks%(b)
	WARN( 1 )
	print mkd%(b)
	WARN( 1 )
	mid%(s, b, 1) = " "

	WARN( 1 )
	print cvd%(s)
	WARN( 1 )
	print cvs%(s)
	WARN( 1 )
	print cvi%(s)
	WARN( 1 )
	print cvl%(s)
	WARN( 1 )
	print cvshort%(s)
	WARN( 1 )
	print cvlongint%(s)

	WARN( 1 )
	print str%(b)
	WARN( 1 )
	print chr%(b)
	WARN( 1 )
	print asc%("")
	WARN( 2 )
	print instr%( "", any% "" )
	WARN( 2 )
	print instr%( 1, "", any% "" )
	WARN( 2 )
	print instrrev%( "", any% "" )

	dim as string * 10 x, y
	scope
		WARN( 1 )
		lset% x, y
		WARN( 1 )
		rset% x, y
	end scope

end scope


#print ---- parser-quirk-thread.bas ----

' Threading using "ThreadCall"

	WARN( 0 )
	sub thread( )
	end sub
	WARN( 2 )
	dim thrptr as any ptr = threadcall% thread%()

#print ---- parser-quirk-vafirst.bas ----

	namespace parser_quirk_vafirst
		sub proc cdecl ( byval n as integer, ... )
			dim a as cva_list
			dim b as cva_list
			WARN( 1 )
			cva_start%( a, n )
			WARN( 1 )
			cva_copy%( a, b )
			WARN( 1 )
			print cva_arg%( a, integer )
			WARN( 2 )
			cva_end%( a )
			cva_end%( b )
		end sub
	end namespace


#print ---- pp-cond.bas ----


#print ---- pp-pragma.bas ----

WARN( 3 )
#pragma% push%( msbitfields% )
WARN( 2 )
#pragma% msbitfields% = 0
WARN( 3 )
#pragma% pop%( msbitfields% )
WARN( 2 )
#pragma% once%


#print ---- pp.bas ----

WARN( 1 )
#define% PP
WARN( 1 )
#undef% PP
WARN( 1 )
#ifdef% PP
#endif
WARN( 1 )
#ifndef% PP
#endif
WARN( 4 )
#if% 1
#elseif% 1
#else%
#endif%
WARN( 1 )
#assert%(1)
WARN( 1 )
#print% 1
WARN( 2 )
#include% once% "suffix-inc.bi"
WARN( 1 )
#inclib% ""
WARN( 1 )
#libpath% ""
'' #error%

WARN( 1 )
#macro% PP2
#endmacro
WARN( 2 )
#print% typeof%( 1 )
WARN( 1 )
#lang% "fb"
WARN( 1 )
#line% 1000

/'
	DON'T INCLUDE DEBUG PP STUFF - IT CAN CHANGE OFTEN
	WARN( 1 )
	#dump%( 0 )
	WARN( 1 )
	#odump%( 0 )
'/


#print ---- Intrinsics ----
scope
	WARN( 1 )
	dim b as boolean = false%
	WARN( 1 )
	b = true%
	WARN( 1 )
	b = false%
end scope

WARN( 0 )
print chr$(0)
print inkey$
print str$(0)
print space$(0)
print string$(0,0)
print oct$(0)
print hex$(0)
print mks$(0)
print mkd$(0)
print mkl$(0)
print mki$(0)
print mkshort$(0)
print mklongint$(0)
print ltrim$("")
print rtrim$("")
print mid$("",0,0)
print left$("",0)
print right$("",0)
print lcase$("")
print ucase$("")
print time$
print date$
print environ$("")
print trim$("")
print input$(0)
print command$(0)

WARN( 4 )
print wchr$(0)
print wstr$(0)
print wstring$(0,0)
print bin$(0)
