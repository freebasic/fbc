'' All FB functions are by default STDCALL on Windows (CDECL on Linux/DOS)

declare function AddNumbers alias "AddNumbers"( byval a as integer, byval b as integer ) as integer
