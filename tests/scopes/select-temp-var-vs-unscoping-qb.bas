' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

sub f( )
	dim s as string

	'' If the SELECT CASE's temp string is unscoped (-lang qb), then this
	'' would trigger a fb_StrDelete() call, requiring the temp string's
	'' initialization code to be unscoped too -- otherwise this could try
	'' to destroy an uninitialized string
	exit sub

	select case s + "a"
	case "a"
	end select
end sub


f( )
