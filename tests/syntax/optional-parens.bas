#print "---"

type T
	i as integer
	k as integer ptr
end type

declare sub      s1( a as integer = 0 )
declare sub      s4( a as integer ptr = 0 )
declare function f1( a as integer = 0 ) as T
declare function f2( a as integer = 0 ) as T ptr
declare function f3( a as integer = 0 ) byref as T
declare function f4( a as integer ptr ) as integer

dim x as T
dim xp as T ptr = @x
dim a as integer

'' Parenthesis are optional on procedures
'' and functions.  They are handled similarly for
'' consistency (I think). Many built-in fbc keywords are
'' implemented as a function even though the
'' result is typically discarded.

#print "-- no errors expected"
	s1( )       '' OK
	s1          '' OK
	s1(0)       '' OK
	s1 0        '' OK
	s1(x.i)     '' OK
	s1 x.i      '' OK
	s1((x).i)   '' OK

#print "-- 1 error expected"
	s1 (x).i
	            '' Error - type mismatch because
	            '' due to the leading left paranthesis

'' And functions are allowed to be called
'' like subroutines discarding the result

#print "-- no errors expected"
	f1( )       '' OK
	f1          '' OK
	f1(0)       '' OK
	f1 0        '' OK
	f1(x.i)     '' OK
	f1 x.i      '' OK
	f1((x).i)   '' OK

#print "-- 1 error expected"
	f1 (x).i
	            '' Error - type mismatch because
	            '' due to the leading left parenthesis

'' Quirk keywords like PRINT are different than a
'' user function in that parenthesis are never
'' allowed and therefore never considered optional.
'' So we see a difference here in how quirk keywords
'' will handle the expression, but user procedures will not


#print "-- no errors expected"
	print (x).i '' OK

#print "-- 2 errors expected"
	s1    (x).i
	f1    (x).i

'' We should expect the error because the call f1(a)
'' should take precedence because the call and member
'' access have the same precedence the order should be
'' left to right.

#print "-- no errors expected"
	a = f1(a).i   '' OK
	f2(a)->i = a  '' OK
	f3(a).i = a   '' OK

'' While it does seem inconsistent that the following is accepted
'' with the '+' operator at a lower precedence that the
'' call (), there is a bit of an explanation below:

	s1 (a) + a

'' the simple reason to allow it is that without this allowance
'' we would be forcing use of '()' on every procedure call and
'' well established syntax of optional parantheses would fail.

	locate (a + a) \ 2, 1

'' If there is no leading parenthesis, then there should be
'' no ambiguity that the procedure is being invoked without
'' the parenthesis; the parenthesis were optional but
'' determined that they weren't used.

	s1 0+(x).i
	f1 0+(x).i

	s4 @(x).i
	f4 @(x).i

	s1 *(x).k
	f1 *(x).k
