' TEST_MODE : COMPILE_AND_RUN_OK

#lang "fblite"

sub f( )
	dim s as string

	'' same, but in -lang fblite
	exit sub

	select case s + "a"
	case "a"
	end select
end sub


f( )
