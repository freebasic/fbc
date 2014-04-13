'' Tool to generate const pointer tests

const TRUE = -1
const FALSE = 0
const NULL = 0

function hEmitType _
	( _
		byref dtype as string, _
		byval ptrcount as integer, _
		byval constmask as integer _
	) as string

	dim as string s

	if( constmask and (1 shl ptrcount) ) then
		s += "const "
	end if

	s += dtype

	for i as integer = ptrcount-1 to 0 step -1
		if( constmask and (1 shl i) ) then
			s += " const"
		end if
		s += " ptr"
	next

	function = s
end function

sub strSplit _
	( _
		byref origs as string, _
		byref delimiter as string, _
		byref l as string, _
		byref r as string _
	)

	var s = origs
	var leftlen = instr( s, delimiter ) - 1

	if( leftlen >= 0 ) then
		l = left( s, leftlen )
		r = right( s, len( s ) - leftlen - len( delimiter ) )
	else
		l = s
		r = ""
	end if

end sub

function strReplace _
	( _
		byref text as string, _
		byref a as string, _
		byref b as string _
	) as string

	var result = text

	var alen = len( a )
	var blen = len( b )

	var i = 0
	do
		'' Does result contain an occurence of a?
		i = instr( i + 1, result, a )
		if( i = 0 ) then
			exit do
		end if

		'' Cut out a and insert b in its place
		'' result  =  front  +  b  +  back
		var keep = right( result, len( result ) - ((i - 1) + alen) )
		result = left( result, i - 1 )
		result += b
		result += keep

		i += blen - 1
	loop

	function = result
end function

function strReplaceAtEnd _
	( _
		byref s as string, _
		byref a as string, _
		byref b as string _
	) as string

	if( right( s, len( a ) ) = a ) then
		function = left( s, len( s ) - len( a ) ) + b
	else
		function = s
	end if

end function

private sub hTestForBaseDtypes _
	( _
		byval fanswers as integer, _
		byref ldtype as string, _
		byref rdtype as string _
	)

	for lptrcount as integer = 1 to 2
	for rptrcount as integer = 1 to 2
	for lnontoplevelconstmask as integer = 0 to (2^lptrcount)-1
	for rnontoplevelconstmask as integer = 0 to (2^rptrcount)-1
		var lhs = hEmitType( ldtype, lptrcount, lnontoplevelconstmask shl 1 )
		var rhs = hEmitType( rdtype, rptrcount, rnontoplevelconstmask shl 1 )

		var answer = ""
		if( lhs = rhs ) then
			answer = "ok"
		elseif( lnontoplevelconstmask = rnontoplevelconstmask ) then
			answer = "ok"
		end if

		lhs += space( 30 - len( lhs ) )
		rhs += space( 30 - len( rhs ) )
		print #fanswers, lhs + " = " + rhs + " = " + answer
	next
	next
	next
	next

end sub

private sub hWriteAssignTest _
	( _
		byref lhs as string, _
		byref rhs as string, _
		byref answer as string _
	)

	assert( len( lhs ) > 0 )
	assert( len( rhs ) > 0 )
	assert( (answer = "ok") or (answer = "fail") )

	var filename = "generated/assign-" + strReplace( lhs, " ", "-" ) + "-from-" + strReplace( rhs, " ", "-" ) + ".bas"
	var ftest = freefile( )
	if( open( filename, for output, as #ftest ) ) then
		print "failed to create file '" + filename + "'"
		end 1
	end if
	print #ftest, "' TEST_MODE : COMPILE_ONLY_" + ucase( answer )
	print #ftest, ""
	print #ftest, "dim r as " + rhs + " = 0"
	print #ftest, "dim l as " + lhs + " = r"
	close #ftest

end sub

'' If the answers.txt exists, read that in and generate the final tests.
'' Otherwise, prepare the answers.txt, for a human to fill with answers...
var fanswers = freefile( )
if( open( "answers.txt", for input, as #fanswers ) = 0 ) then
	if( mkdir( "generated" ) ) then
	end if

	while( eof( fanswers ) = 0 )
		dim as string lhs, rhs, answer
		line input #fanswers, lhs
		strSplit( lhs, "=", lhs, rhs )
		strSplit( rhs, "=", rhs, answer )
		lhs    = trim( lhs    )
		rhs    = trim( rhs    )
		answer = trim( answer )
		assert( right( lhs, 3 ) = "ptr" )
		assert( right( rhs, 3 ) = "ptr" )

		var constlhs = strReplaceAtEnd( lhs, "ptr", "const ptr" )
		var constrhs = strReplaceAtEnd( rhs, "ptr", "const ptr" )

		hWriteAssignTest( lhs     , rhs     , answer )
		'hWriteAssignTest( constlhs, rhs     , answer )
		'hWriteAssignTest( lhs     , constrhs, answer )
		'hWriteAssignTest( constlhs, constrhs, answer )
	wend
	close #fanswers
else
	if( open( "answers.txt", for output, as #fanswers ) ) then
		print "failed to create file 'answers.txt'"
		end 1
	end if

	hTestForBaseDtypes( fanswers, "any", "any" )
	hTestForBaseDtypes( fanswers, "any", "ubyte" )
	hTestForBaseDtypes( fanswers, "ubyte", "any" )
	hTestForBaseDtypes( fanswers, "ubyte", "ubyte" )
	hTestForBaseDtypes( fanswers, "byte", "ubyte" )

	close #fanswers

	shell( "cat answers.txt | LC_ALL=C sort --unique > answers2.txt && mv answers2.txt answers.txt" )
end if
