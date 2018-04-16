'' Integer math expressions test case generator
''
'' This generates all possible combinations of:
'' BOPs:  + - *
'' Integer constants/variables
'' Parentheses (different evaluation order)
''
'' A tiny AST is used to represent the expression and precalculate the expected
'' result value.

'' #define this 1 or 2 to generate more or MASSIVELY more test cases
#define MORE_TESTS 0

#undef TRUE
#undef FALSE

const TRUE = -1
const FALSE = 0
const NULL = 0

type OPERANDDATA
	varname		as zstring * 32
	value		as longint
end type

'' We should various kinds of positive/negative constants/variables, but with
'' each additional one added the amount of generated tests jumps through the
'' roof, so only "useful" values should be given here to begin with.
'' (note that either way, astIsGoodTestCase() will remove lots of cases again)
#if MORE_TESTS = 2
	dim shared as OPERANDDATA possibleoperands(0 to ...) = _
	{ _
		( "a", -2 ), _  '' variables
		( "b", -1 ), _
		( "c",  0 ), _
		( "d",  1 ), _
		( "e",  2 ), _
		( "" , -2 ), _  '' constants
		( "" , -1 ), _
		( "" ,  0 ), _
		( "" ,  1 ), _
		( "" ,  2 ) _
	}
#elseif MORE_TESTS = 1
	dim shared as OPERANDDATA possibleoperands(0 to ...) = _
	{ _
		( "a",  2 ), _  '' variables
		( "b", -3 ), _
		( "" , -2 ), _  '' constants
		( "" , -1 ), _
		( "" ,  2 ) _
	}
#else
	dim shared as OPERANDDATA possibleoperands(0 to ...) = _
	{ _
		( "a",  1 ), _
		( "b",  2 ), _
		( "" , -2 ), _
		( "" , -1 ) _
	}
#endif

enum
	AST_VAR
	AST_CONST
	AST_BOP
end enum

enum
	ASTOP_ADD = 0
	ASTOP_SUB
	ASTOP_MUL
	ASTOP__COUNT
end enum

type ASTNODE
	id		as integer
	op		as integer
	varname		as string
	value		as longint

	l		as ASTNODE ptr
	r		as ASTNODE ptr
end type

function astNew( byval id as integer ) as ASTNODE ptr
	dim as ASTNODE ptr n = any
	n = callocate( sizeof( ASTNODE ) )
	n->id = id
	function = n
end function

function astNewCONST( byval value as longint ) as ASTNODE ptr
	dim as ASTNODE ptr n = any

	n = astNew( AST_CONST )
	n->value = value

	function = n
end function

function astNewVAR _
	( _
		byref varname as string, _
		byval value as longint _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astNew( AST_VAR )
	n->varname = varname
	n->value = value

	function = n
end function

function astNewOperand( byval i as integer ) as ASTNODE ptr
	if( len( possibleoperands(i).varname ) > 0 ) then
		function = astNewVAR( possibleoperands(i).varname, possibleoperands(i).value )
	else
		function = astNewCONST( possibleoperands(i).value )
	end if
end function

function astNewBOP _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astNew( AST_BOP )
	n->op = op
	n->l = l
	n->r = r

	select case( op )
	case ASTOP_ADD
		n->value = l->value + r->value
	case ASTOP_SUB
		n->value = l->value - r->value
	case ASTOP_MUL
		n->value = l->value * r->value
	case else
		assert( FALSE )
	end select

	function = n
end function

sub astDelete( byval n as ASTNODE ptr )
	if( n->l ) then
		astDelete( n->l )
	end if

	if( n->r ) then
		astDelete( n->r )
	end if

	n->varname = ""
	deallocate( n )
end sub

function astAsString( byval n as ASTNODE ptr ) as string
	static as zstring * 4 optext(0 to ASTOP__COUNT-1) = _
		{ " + ", " - ", " * " }

	dim as string s

	select case( n->id )
	case AST_VAR
		s += n->varname
	case AST_CONST
		s += str( n->value )
	case AST_BOP
		s += "("
		s += astAsString( n->l )
		s += optext(n->op)
		s += astAsString( n->r )
		s += ")"
	end select

	function = s
end function

'' count BOPs where both leafs are the same
function astCountPureBOPs _
	( _
		byval n as ASTNODE ptr, _
		byval leafid as integer _
	) as integer

	if( n->id = AST_BOP ) then
		if( (n->l->id = leafid) and (n->r->id = leafid) ) then
			function = 1
		else
			function = astCountPureBOPs( n->l, leafid ) + _
			           astCountPureBOPs( n->r, leafid )
		end if
	else
		function = 0
	end if

end function

function astCountVar _
	( _
		byval n as ASTNODE ptr, _
		byref varname as string _
	) as integer

	select case( n->id )
	case AST_VAR
		if( n->varname = varname ) then
			function = 1
		else
			function = 0
		end if

	case AST_BOP
		function = astCountVar( n->l, varname ) + _
		           astCountVar( n->r, varname )

	case else
		function = 0
	end select

end function

function astCountConst _
	( _
		byval n as ASTNODE ptr, _
		byval value as longint _
	) as integer

	select case( n->id )
	case AST_CONST
		if( n->value = value ) then
			function = 1
		else
			function = 0
		end if

	case AST_BOP
		function = astCountConst( n->l, value ) + _
		           astCountConst( n->r, value )

	case else
		function = 0
	end select

end function

'' Count dead-code, i.e. *1 or +0 BOPs
function astCountDeadBOPs( byval n as ASTNODE ptr ) as integer
	dim as integer count = any

	count = 0

	if( n->id = AST_BOP ) then
		select case( n->op )
		'' +0?
		case ASTOP_ADD
			if( n->r->id = AST_CONST ) then
				if( n->r->value = 0 ) then
					count += 1
				end if
			end if

		'' *1?
		case ASTOP_MUL
			if( n->r->id = AST_CONST ) then
				if( n->r->value = 1 ) then
					count += 1
				end if
			end if

		end select

		count += astCountDeadBOPs( n->l )
		count += astCountDeadBOPs( n->r )
	end if

	function = count
end function

function astIsGoodTestCase( byval ast as ASTNODE ptr ) as integer
	function = FALSE

	'' Ignore cases that would use constant folding, since then fbc would
	'' solve out the BOPs immediately, instead of running them through the
	'' associativity/distributivity or constant accumulation optimizations.
	if( astCountPureBOPs( ast, AST_CONST ) > 0 ) then
		exit function
	end if

	'' Also, BOPs where both leafs are variables are not very useful,
	'' since they won't be involved in constant optimizations either.
	if( astCountPureBOPs( ast, AST_VAR ) > 0 ) then
		exit function
	end if

	'' Dead code such as *1 or +0 will be dropped anyways, no need to test
	if( astCountDeadBOPs( ast ) > 0 ) then
		exit function
	end if

	'' Also, skip cases where one variable or constant is used too often
	for i as integer = lbound( possibleoperands ) to ubound( possibleoperands )
		if( len( possibleoperands(i).varname ) > 0 ) then
			if( astCountVar( ast, possibleoperands(i).varname ) > 1 ) then
				exit function
			end if
		else
			if( astCountConst( ast, possibleoperands(i).value ) > 2 ) then
				exit function
			end if
		end if
	next

	function = TRUE
end function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

type CTXSTUFF
	'' output file
	filename	as zstring * 256
	fnum		as integer

	indent		as integer  '' indentation level
	testcount	as integer  '' count of expressions emitted into the current file
	filecount	as integer  '' file name counter

	'' progress information:
	totalcount	as integer  '' pre-calculated total
	count		as integer  '' count of emitted operation/operand combinations
	percent		as integer  '' same in %
end type

dim shared as CTXSTUFF ctx

sub emitLine( byref s as string )
	print #ctx.fnum, string( ctx.indent, !"\t" ) + s
end sub

sub emitIndent( )
	ctx.indent += 1
end sub

sub emitUnindent( )
	ctx.indent -= 1
end sub

sub emitAssertEqual( byref expr as string, byval value as longint )
	emitLine( "t( " + expr + " = " + str( value ) + " )" )
end sub

sub emitBegin( )
	dim as string filename

	ctx.filename = "math-torture-" & ctx.filecount & ".bas"
	ctx.fnum = freefile( )

	print ctx.filename;

	filename = exepath( ) + "/../" + ctx.filename
	if( open( filename, for output, as #ctx.fnum ) ) then
		print "could not open file: '" + filename + "'"
		end 1
	end if

	emitLine( "'' Automatically generated by " + __FILE__ + ", " + __DATE_ISO__ )
	emitLine( "" )
	emitLine( "#include ""fbcunit.bi""" )
	emitLine( "" )
	emitLine( "SUITE( fbc_tests.optimizations.math_torture_" & ctx.filecount & " )" )
	emitLine( "" )
	emitIndent( )
	emitLine( "TEST( test" & ctx.filecount & " )" )
	emitIndent( )
	emitLine( "#define t( x ) CU_ASSERT( x )" )

	'' declare variables
	for i as integer = lbound( possibleoperands ) to ubound( possibleoperands )
		if( len( possibleoperands(i).varname ) > 0 ) then
			emitLine( "dim as integer " + possibleoperands(i).varname + " = " & possibleoperands(i).value )
		end if
	next
end sub

sub emitEnd( )
	emitUnindent( )
	emitLine( "END_TEST" )
	emitUnindent( )
	emitLine( "" )
	emitLine( "END_SUITE" )

	close #ctx.fnum
	ctx.filename = ""
	ctx.fnum = 0

	print , ctx.count & "/" & ctx.totalcount & " (" & ctx.percent & "%)"

	ctx.filecount += 1
	ctx.testcount = 0
end sub

sub emitTest( byval ast as ASTNODE ptr )
	dim as longint value = any

	if( astIsGoodTestCase( ast ) ) then
		'' Only a "few" test cases per file, better split it up a bit, than
		'' emit one giant file (fbc -g doesn't support line numbers > 65k)
		if( ctx.testcount >= (1024 * 2) ) then
			'' Close current file and open a new one with a new name
			emitEnd( )
			emitBegin( )
		end if

		value = ast->value
		emitAssertEqual( astAsString( ast ), ast->value )
		ctx.testcount += 1
	end if

	astDelete( ast )
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	'' We want to generate an expression of the form:
	''    Z + (A + B + C + D)
	'' where A/B/C/D can be variables or constants, '+' can be any of the
	'' allowed BOPs, and they're grouped in various evaluation orders.
	''
	'' The top-most BOP involving Z is "fixed", it's not involved in
	'' evaluation order combinations, it's just used to give
	'' astOptimizeTree() a good entry-point.

	ctx.totalcount = (ASTOP__COUNT ^ 4) * ((ubound( possibleoperands ) + 1) ^ 5)

	emitBegin( )

	'' Loop until all combinations of operations and operands were used:
	'' 1. Select 3 (or 4) operations
	'' 2. Select 4 (or 5) operands
	'' 3. Add test cases for the 5 possible evaluation orders of
	''    the A/B/C/D subtree using the given operations & operands
	for op1 as integer = 0 to ASTOP__COUNT-1
	for op2 as integer = 0 to ASTOP__COUNT-1
	for op3 as integer = 0 to ASTOP__COUNT-1
	for opz as integer = 0 to ASTOP__COUNT-1
		for operandA as integer = 0 to ubound( possibleoperands )
		for operandB as integer = 0 to ubound( possibleoperands )
		for operandC as integer = 0 to ubound( possibleoperands )
		for operandD as integer = 0 to ubound( possibleoperands )
		for operandZ as integer = 0 to ubound( possibleoperands )
			ctx.count += 1
			ctx.percent = int( (100 / ctx.totalcount) * ctx.count )

			#define A astNewOperand( operandA )
			#define B astNewOperand( operandB )
			#define C astNewOperand( operandC )
			#define D astNewOperand( operandD )

			#macro test( ast )
				emitTest( astNewBOP( opz, astNewOperand( operandZ ), ast ) )
			#endmacro

			'' ((A op1 B) op2 C) op3 D
			''       op3
			''       / \
			''     op2  D
			''     / \
			''   op1  C
			''   / \
			''  A   B
			test( astNewBOP( op3, astNewBOP( op2, astNewBOP( op1, A, B ), C ), D ) )

#if MORE_TESTS >= 1
			'' (A op1 (B op2 C)) op3 D
			''       op3
			''       / \
			''     op1  D
			''     / \
			''    A  op2
			''       / \
			''      B   C
			test( astNewBOP( op3, astNewBOP( op1, A, astNewBOP( op2, B, C ) ), D ) )

			'' (A op1 B) op2 (C op3 D)
			''       op2
			''       / \
			''    op1   op3
			''    / \   / \
			''   A   B C   D
			test( astNewBOP( op2, astNewBOP( op1, A, B ), astNewBOP( op3, C, D ) ) )

			'' A op1 ((B op2 C) op3 D)
			''   op1
			''   / \
			''  A  op3
			''     / \
			''   op2  D
			''   / \
			''  B   C
			test( astNewBOP( op1, A, astNewBOP( op3, astNewBOP( op2, B, C ), D ) ) )
#endif

			'' A op1 (B op2 (C op3 D))
			''   op1
			''   / \
			''  A  op2
			''     / \
			''    B  op3
			''       / \
			''      C   D
			test( astNewBOP( op1, A, astNewBOP( op2, B, astNewBOP( op3, C, D ) ) ) )
		next
		next
		next
		next
		next
	next
	next
	next
	next

	emitEnd( )
