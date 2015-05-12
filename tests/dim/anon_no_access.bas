' TEST_MODE : COMPILE_ONLY_FAIL

type Rational
	declare operator cast () as double
	private:
		as integer num, den
end type

operator Rational.cast () as double
	return iif (0 = den, cast(double, 0), num / den)
end operator

sub anon_no_access cdecl ()
	
	'' can't access these members...
	dim x as Rational = (3, 4)

end sub

