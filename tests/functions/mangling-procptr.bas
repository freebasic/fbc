' TEST_MODE : COMPILE_AND_RUN_OK

'' Different procedure pointers should be seen as different types. This requires
'' fbc's internal procedure pointer mangling mechanism to encode all the
'' relevant properties.

type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

type FWDREF1 as FWDREF1_
type FWDREF2 as FWDREF2_

'' Parameter dtype
sub f1 overload( byval p as sub( byref as any ) ) : end sub
sub f1 overload( byval p as sub( as byte      ) ) : end sub
sub f1 overload( byval p as sub( as ubyte     ) ) : end sub
sub f1 overload( byval p as sub( as short     ) ) : end sub
sub f1 overload( byval p as sub( as ushort    ) ) : end sub
sub f1 overload( byval p as sub( as long      ) ) : end sub
sub f1 overload( byval p as sub( as ulong     ) ) : end sub
sub f1 overload( byval p as sub( as longint   ) ) : end sub
sub f1 overload( byval p as sub( as ulongint  ) ) : end sub
sub f1 overload( byval p as sub( as integer   ) ) : end sub
sub f1 overload( byval p as sub( as uinteger  ) ) : end sub
sub f1 overload( byval p as sub( as single    ) ) : end sub
sub f1 overload( byval p as sub( as double    ) ) : end sub
sub f1 overload( byval p as sub( as string    ) ) : end sub
sub f1 overload( byval p as sub( as zstring   ) ) : end sub
sub f1 overload( byval p as sub( as wstring   ) ) : end sub
sub f1 overload( byval p as sub( as UDT1      ) ) : end sub
sub f1 overload( byval p as sub( as UDT2      ) ) : end sub
sub f1 overload( byval p as sub( as FWDREF1   ) ) : end sub
sub f1 overload( byval p as sub( as FWDREF2   ) ) : end sub
sub f1 overload( byval p as sub( as sub( )    ) ) : end sub
sub f1 overload( byval p as sub( as function( ) as integer ) ) : end sub
sub f1 overload( byval p as sub( as any      ptr ) ) : end sub
sub f1 overload( byval p as sub( as byte     ptr ) ) : end sub
sub f1 overload( byval p as sub( as ubyte    ptr ) ) : end sub
sub f1 overload( byval p as sub( as short    ptr ) ) : end sub
sub f1 overload( byval p as sub( as ushort   ptr ) ) : end sub
sub f1 overload( byval p as sub( as long     ptr ) ) : end sub
sub f1 overload( byval p as sub( as ulong    ptr ) ) : end sub
sub f1 overload( byval p as sub( as longint  ptr ) ) : end sub
sub f1 overload( byval p as sub( as ulongint ptr ) ) : end sub
sub f1 overload( byval p as sub( as integer  ptr ) ) : end sub
sub f1 overload( byval p as sub( as uinteger ptr ) ) : end sub
sub f1 overload( byval p as sub( as single   ptr ) ) : end sub
sub f1 overload( byval p as sub( as double   ptr ) ) : end sub
sub f1 overload( byval p as sub( as string   ptr ) ) : end sub
sub f1 overload( byval p as sub( as zstring  ptr ) ) : end sub
sub f1 overload( byval p as sub( as wstring  ptr ) ) : end sub
sub f1 overload( byval p as sub( as UDT1     ptr ) ) : end sub
sub f1 overload( byval p as sub( as UDT2     ptr ) ) : end sub
sub f1 overload( byval p as sub( as FWDREF1  ptr ) ) : end sub
sub f1 overload( byval p as sub( as FWDREF2  ptr ) ) : end sub
sub f1 overload( byval p as sub( as typeof( sub( ) ) ptr    ) ) : end sub
sub f1 overload( byval p as sub( as typeof( function( ) as integer ) ptr ) ) : end sub

'' Parameter CONSTness
'' A CONST BYVAL parameter is the same as a non-CONST BYVAL parameter.
'' Overloading cannot be allowed based on BYVAL parameter CONSTness - that only
'' makes sense for BYREF parameters or pointers to CONST. The CONST bit on
'' BYVAL parameters isn't even included in the C++ mangling.
sub f2 overload( byval p as sub( byval as integer                 ) ) : end sub
'sub f2 overload( byval p as sub( byval as const integer           ) ) : end sub
sub f2 overload( byval p as sub( byval as integer ptr             ) ) : end sub
'sub f2 overload( byval p as sub( byval as integer const ptr       ) ) : end sub
sub f2 overload( byval p as sub( byval as const integer ptr       ) ) : end sub
'sub f2 overload( byval p as sub( byval as const integer const ptr ) ) : end sub
sub f2 overload( byval p as sub( byref as integer                 ) ) : end sub
sub f2 overload( byval p as sub( byref as const integer           ) ) : end sub
sub f2 overload( byval p as sub( byref as integer ptr             ) ) : end sub
sub f2 overload( byval p as sub( byref as integer const ptr       ) ) : end sub
sub f2 overload( byval p as sub( byref as const integer ptr       ) ) : end sub
sub f2 overload( byval p as sub( byref as const integer const ptr ) ) : end sub

'' Parameter mode
sub f3 overload( byval p as sub cdecl( byval as integer, byval as integer ) ) : end sub
sub f3 overload( byval p as sub cdecl( byval as integer, byref as integer ) ) : end sub
sub f3 overload( byval p as sub cdecl( byval as integer, (any) as integer ) ) : end sub
sub f3 overload( byval p as sub cdecl( byval as integer, ...              ) ) : end sub

'' Bydesc dimensions
'' also testing that array() and array(any * FB_MAXARRAYDIMS) are seen as different.
sub f4 overload( byval p as sub( array() as integer ) ) : end sub
sub f4 overload( byval p as sub( array(any) as integer ) ) : end sub
sub f4 overload( byval p as sub( array(any, any) as integer ) ) : end sub
sub f4 overload( byval p as sub( array(any, any, any, any, any, any, any, any) as integer ) ) : end sub

'' Function result dtype
sub f5 overload( byval p as function( ) as byte          ) : end sub
sub f5 overload( byval p as function( ) as ubyte         ) : end sub
sub f5 overload( byval p as function( ) as short         ) : end sub
sub f5 overload( byval p as function( ) as ushort        ) : end sub
sub f5 overload( byval p as function( ) as long          ) : end sub
sub f5 overload( byval p as function( ) as ulong         ) : end sub
sub f5 overload( byval p as function( ) as longint       ) : end sub
sub f5 overload( byval p as function( ) as ulongint      ) : end sub
sub f5 overload( byval p as function( ) as integer       ) : end sub
sub f5 overload( byval p as function( ) as uinteger      ) : end sub
sub f5 overload( byval p as function( ) as single        ) : end sub
sub f5 overload( byval p as function( ) as double        ) : end sub
sub f5 overload( byval p as function( ) as string        ) : end sub
sub f5 overload( byval p as function( ) byref as zstring ) : end sub
sub f5 overload( byval p as function( ) byref as wstring ) : end sub
sub f5 overload( byval p as function( ) as UDT1          ) : end sub
sub f5 overload( byval p as function( ) as UDT2          ) : end sub
sub f5 overload( byval p as function( ) byref as FWDREF1 ) : end sub
sub f5 overload( byval p as function( ) byref as FWDREF2 ) : end sub
sub f5 overload( byval p as function( ) as sub( )        ) : end sub
sub f5 overload( byval p as function( ) as function( ) as integer ) : end sub
sub f5 overload( byval p as function( ) as any      ptr  ) : end sub
sub f5 overload( byval p as function( ) as byte     ptr  ) : end sub
sub f5 overload( byval p as function( ) as ubyte    ptr  ) : end sub
sub f5 overload( byval p as function( ) as short    ptr  ) : end sub
sub f5 overload( byval p as function( ) as ushort   ptr  ) : end sub
sub f5 overload( byval p as function( ) as long     ptr  ) : end sub
sub f5 overload( byval p as function( ) as ulong    ptr  ) : end sub
sub f5 overload( byval p as function( ) as longint  ptr  ) : end sub
sub f5 overload( byval p as function( ) as ulongint ptr  ) : end sub
sub f5 overload( byval p as function( ) as integer  ptr  ) : end sub
sub f5 overload( byval p as function( ) as uinteger ptr  ) : end sub
sub f5 overload( byval p as function( ) as single   ptr  ) : end sub
sub f5 overload( byval p as function( ) as double   ptr  ) : end sub
sub f5 overload( byval p as function( ) as string   ptr  ) : end sub
sub f5 overload( byval p as function( ) as zstring  ptr  ) : end sub
sub f5 overload( byval p as function( ) as wstring  ptr  ) : end sub
sub f5 overload( byval p as function( ) as UDT1     ptr  ) : end sub
sub f5 overload( byval p as function( ) as UDT2     ptr  ) : end sub
sub f5 overload( byval p as function( ) as FWDREF1  ptr  ) : end sub
sub f5 overload( byval p as function( ) as FWDREF2  ptr  ) : end sub
sub f5 overload( byval p as function( ) as typeof( sub( )                 ) ptr ) : end sub
sub f5 overload( byval p as function( ) as typeof( function( ) as integer ) ptr ) : end sub

'' CONST/BYREF bits in function result
'' As opposed to BYVAL CONST on parameters, for function results it *is*
'' encoded into the C++ mangling (as in g++/clang++), and thus the function
'' pointers that differ only in BYVAL function result CONSTness are separate
'' types.
sub f6 overload( byval p as function( ) as integer             ) : end sub
sub f6 overload( byval p as function( ) as const integer       ) : end sub
sub f6 overload( byval p as function( ) byref as integer       ) : end sub
sub f6 overload( byval p as function( ) byref as const integer ) : end sub

'' again with UDTs (regression test)
sub f6 overload( byval p as function( ) as UDT1                ) : end sub
sub f6 overload( byval p as function( ) as const UDT1          ) : end sub
sub f6 overload( byval p as function( ) byref as UDT1          ) : end sub
sub f6 overload( byval p as function( ) byref as const UDT1    ) : end sub

'' Calling convention
''
'' These function pointers are different types from the compiler's point of view
'' in FB and also with gcc/clang, but the calling convention is not encoded in
'' the C++ mangling, so these procedures end up colliding in the generated .asm.
'' (same for gcc/clang)
''
sub f7 overload alias "F7_stdcall"( byval p as sub stdcall( ) ) : end sub
sub f7 overload alias "F7_cdecl"  ( byval p as sub cdecl  ( ) ) : end sub
sub f7 overload alias "F7_pascal" ( byval p as sub pascal ( ) ) : end sub

'' Namespaced UDTs
namespace ns1
	type UDT1
		i as integer
	end type
end namespace
sub f8 overload( byval p as sub( as UDT1     ) ) : end sub
sub f8 overload( byval p as sub( as ns1.UDT1 ) ) : end sub
