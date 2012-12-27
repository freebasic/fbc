dim b   as byte
dim ub  as ubyte
dim sh  as short
dim ush as short
dim i   as integer
dim ui  as uinteger
dim l   as long
dim ul  as ulong
dim ll  as longint
dim ull as ulongint

#print typeof( b   )
#print typeof( ub  )
#print typeof( sh  )
#print typeof( ush )
#print typeof( i   )
#print typeof( ui  )
#print typeof( l   )
#print typeof( ul  )
#print typeof( ll  )
#print typeof( ull )

dim f   as single
dim d   as double

#print typeof( f )
#print typeof( d )

dim p   as any ptr
dim pi  as integer ptr

#print typeof( p  )
#print typeof( pi )

dim s   as string
dim fixstr as string * 31
dim z   as zstring * 32
dim w   as wstring * 32

#print typeof( "test" )
#print typeof( s )
#print typeof( fixstr )
#print typeof( z )
#print typeof( w )

type UDT1
	i as integer
end type

dim x1 as UDT1
#print typeof( UDT1 )
