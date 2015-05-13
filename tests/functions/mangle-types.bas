' TEST_MODE : COMPILE_ONLY_OK

extern "c++"

sub f1( b as byte ) : end sub
sub f2( ub as ubyte ) : end sub
sub f3( z as zstring ) : end sub
sub f4( sh as short ) : end sub
sub f5( ush as ushort ) : end sub
sub f6( w as wstring ) : end sub
sub f7( i as integer ) : end sub
sub f8( ui as uinteger ) : end sub

enum ENUM1
	A = 1
end enum
sub f9( e as ENUM1 ) : end sub

sub f10( l as long ) : end sub
sub f11( ul as ulong ) : end sub
sub f12( ll as longint ) : end sub
sub f13( ull as ulongint ) : end sub
sub f14( f as single ) : end sub
sub f15( d as double ) : end sub
sub f16( s as string ) : end sub
'sub f17( fs as string * 31 ) : end sub

type UDT
	i as integer
end type
sub f18( x as UDT ) : end sub

sub f19( pi as integer ptr ) : end sub
type typedeffwdref as fwdref
sub f20( xfwdref as typedeffwdref ptr ) : end sub
sub f21( pany as any ptr ) : end sub
sub f22( psub as sub( ) ) : end sub

end extern
