'' examples/manual/libraries/ffi/helloworld.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'libffi'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibFfi
'' --------

#include "ffi.bi"

' Simple "puts" equivalent function
Function printer cdecl (ByVal s As ZString Ptr) As Integer
	Print *s
	Return 42
End Function

' Initialize the argument info vectors
Dim s As ZString Ptr
Dim args(0 To 0) As ffi_type Ptr = {@ffi_type_pointer}
Dim values(0 To 0) As Any Ptr = {@s}

' Initialize the cif
Dim cif As ffi_cif
Dim result As ffi_status
result = ffi_prep_cif( _
	@cif,              _ ' call interface object
	FFI_DEFAULT_ABI,   _ ' binary interface type
	1,                 _ ' number of arguments
	@ffi_type_uint,    _ ' return type
	@args(0)           _ ' arguments
)

' Call function
Dim return_value As Integer
If result = FFI_OK Then
	s = @"Hello world"
	ffi_call(@cif, FFI_FN(@printer), @return_value, @values(0))

	' values holds a pointer to the function's arg, so to
	' call puts() again all we need to do is change the
	' value of s */
	s = @"This is cool!"
	ffi_call(@cif, FFI_FN(@printer), @return_value, @values(0))
	Print Using "Function returned &"; return_value
End If
