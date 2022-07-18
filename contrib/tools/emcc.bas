'' emcc.exe to call emcc.bat and pass all arguments
''
'' tested, but not well tested...
''
function EscapeArg( byref arg as const string ) as string
	dim ret as string = """"

	for i as integer = 1 to len(arg)
		select case mid( arg, i, 1 )
		case """"
			ret &= """"""
		case else
			ret &= mid( arg, i, 1 )
		end select
	next

	ret &= """"

	function = ret

end function

dim cmd as string = "emcc.bat"

dim i as integer = 1
while( command(i) > "" )
	cmd += " " & EscapeArg( command(i) )
	i += 1
wend

'' assumes 'emcc.bat' is on PATH

var result = shell( cmd )

end result
