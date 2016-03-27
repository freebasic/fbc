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
dim ps  as string ptr
dim pz  as zstring ptr
dim pw  as wstring ptr

#print typeof( p  )
#print typeof( pi )
#print typeof( ps )
#print typeof( pz )
#print typeof( pw )

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

#print "Zstring vs Zstring * N"
scope
	dim byref rz as zstring = "foo"
	dim pz as zstring ptr
	dim z1 as zstring * 1
	dim z32 as zstring * 32

	type tz as zstring
	type tz1 as zstring * 1
	type tz32 as zstring * 32

	#print typeof(rz)
	#print typeof(*pz)
	#print typeof(z1)
	#print typeof(z32)

	#print typeof(zstring)
	#print typeof(zstring * 1)
	#print typeof(zstring * 32)

	#print typeof(tz)
	#print typeof(tz1)
	#print typeof(tz32)
end scope

#print
#print "procptr parameter types:"
#print typeof( sub( ) )
#print typeof( sub( as byte     ) )
#print typeof( sub( as ubyte    ) )
#print typeof( sub( as zstring  ) )
#print typeof( sub( as short    ) )
#print typeof( sub( as ushort   ) )
#print typeof( sub( as wstring  ) )
#print typeof( sub( as integer  ) )
#print typeof( sub( as uinteger ) )
#print typeof( sub( as long     ) )
#print typeof( sub( as ulong    ) )
#print typeof( sub( as longint  ) )
#print typeof( sub( as ulongint ) )
#print typeof( sub( as string   ) )
#print typeof( sub( as any ptr  ) )
#print typeof( sub( as integer ptr ptr ptr ) )
#print typeof( sub( as sub( )   ) )
#print typeof( sub( as function( as byte ) as short ) )
#print typeof( sub( as UDT1     ) )

#print
#print "procptr parameter modes:"
#print typeof( sub( byref as any ) )
#print typeof( sub( as integer ) )
#print typeof( sub( byval as integer ) )
#print typeof( sub( byref as integer ) )
#print typeof( sub( () as integer ) )
'' Vararg functions must be CDECL, but those will currently be printed
'' differently by #print typeof() on Linux vs. Win32, because CDECL is the
'' default on Linux, but not on Win32.
''#print typeof( sub cdecl( as integer, ... ) )

#print
#print "procptr function results:"
#print typeof( function( ) as byte     )
#print typeof( function( ) as ubyte    )
#print typeof( function( ) as short    )
#print typeof( function( ) as ushort   )
#print typeof( function( ) as integer  )
#print typeof( function( ) as uinteger )
#print typeof( function( ) as long     )
#print typeof( function( ) as ulong    )
#print typeof( function( ) as longint  )
#print typeof( function( ) as ulongint )
#print typeof( function( ) as string   )
#print typeof( function( ) as any ptr  )
#print typeof( function( ) as integer ptr ptr ptr )
#print typeof( function( ) as sub( )   )
#print typeof( function( ) as function( as byte ) as short )
#print typeof( function( ) as UDT1     )

#print
#print "procptr return byref:"
#print typeof( function( ) byref as byte     )
#print typeof( function( ) byref as ubyte    )
#print typeof( function( ) byref as zstring  )
#print typeof( function( ) byref as short    )
#print typeof( function( ) byref as ushort   )
#print typeof( function( ) byref as wstring  )
#print typeof( function( ) byref as integer  )
#print typeof( function( ) byref as uinteger )
#print typeof( function( ) byref as long     )
#print typeof( function( ) byref as ulong    )
#print typeof( function( ) byref as longint  )
#print typeof( function( ) byref as ulongint )
#print typeof( function( ) byref as string   )
#print typeof( function( ) byref as any ptr  )
#print typeof( function( ) byref as integer ptr ptr ptr )
#print typeof( function( ) byref as sub( )   )
#print typeof( function( ) byref as function( as byte ) as short )
#print typeof( function( ) byref as UDT1     )

#print
#print "CONST bits, 0 PTRs:"
#print typeof(       integer )
#print typeof( const integer )

#print
#print "CONST bits, 1 PTR:"
#print typeof(       integer       ptr )
#print typeof(       integer const ptr )
#print typeof( const integer       ptr )
#print typeof( const integer const ptr )

#print
#print "CONST bits, 2 PTRs:"
#print typeof(       integer       ptr       ptr )
#print typeof(       integer       ptr const ptr )
#print typeof(       integer const ptr       ptr )
#print typeof(       integer const ptr const ptr )
#print typeof( const integer       ptr       ptr )
#print typeof( const integer       ptr const ptr )
#print typeof( const integer const ptr       ptr )
#print typeof( const integer const ptr const ptr )
