#include "ffi.bi"

' Acts like puts with the file given at time of enclosure.
Sub Printer cdecl(ByVal cif As ffi_cif Ptr, ByVal ret As Any Ptr, ByVal args As Any Ptr Ptr, ByVal File As Any Ptr)
    Write #*CPtr(Integer Ptr, file), **CPtr(ZString Ptr Ptr, args[0])
    *CPtr(UInteger Ptr, ret) = 42
End Sub

' Allocate the closure and function binding
Dim PrinterBinding As Function(ByVal s As ZString Ptr) As Integer
Dim closure As ffi_closure Ptr
closure = ffi_closure_alloc(SizeOf(ffi_closure), @PrinterBinding)

If closure <> 0 Then
    ' Initialize the argument info vector
    Dim args(0 To 0) As ffi_type Ptr = {@ffi_type_pointer}
   
    ' Initialize the call interface
    Dim cif As ffi_cif
    Dim prep_result As ffi_status = ffi_prep_cif( _
        @cif,            _ ' call interface object
        FFI_DEFAULT_ABI, _ ' binary interface type
        1,               _ ' number of arguments
        @ffi_type_uint,  _ ' return type
        @args(0)         _ ' arguments
    )
    If prep_result = FFI_OK Then
        ' Open console file to send to PrinterBinding as user data
        Dim ConsoleFile As Integer = FreeFile()
        Open Cons For Output As ConsoleFile
       
        ' Initialize the closure, setting user data to the console file
        prep_result = ffi_prep_closure_loc( _
            closure,         _ ' closure object
            @cif,            _ ' call interface object
            @Printer,        _ ' actual closure function
            @ConsoleFile,    _ ' user data, our console file #
            PrinterBinding   _ ' pointer to binding
        )
        If prep_result = FFI_OK Then
            ' Call binding as a natural function call
            Dim Result As Integer
            Result = PrinterBinding("Hello World!")
            Print Using "Returned &"; Result
        End If
       
        Close ConsoleFile
    End If
End If

' Clean up
ffi_closure_free(closure)
