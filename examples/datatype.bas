'' Integer types
dim b as byte     '' 1 byte
dim sh as short   '' 2 bytes
dim i as integer  '' 4 bytes (32bit type)
dim l as long     '' 4 bytes on Windows, 4/8 bytes elsewhere depending on pointer size
dim ll as longint '' 8 bytes (64bit type)

'' Unsigned versions
dim ub as ubyte
dim ush as ushort
dim ui as uinteger
dim ul as ulong
dim ull as ulongint

'' Floating point types
dim f as single  '' 32bit float
dim d as double  '' 64bit float

'' Strings
dim s as string  '' variable-length single-byte string (up to 2 GB, may contain
                 '' nulls, implicitly null-terminated for C compatibility)

dim fixstr as string * 5  '' fixed-length string (implicitly null-terminated)

dim z as zstring * 5+1  '' null-terminated fixed-length string

dim w as wstring * 5+1  '' same, but for Unicode, depends on system:
                        '' UTF-16 on Windows: 2 byte units, 1 or 2 units (2 or 4 bytes) per Unicode character
                        '' UTF-32 on Linux: 4 bytes per Unicode character

'' User-defined types (UDTs): structures, classes
type Vector
	as single x, y
end type

dim v as Vector

type MyClass
	as integer i
	declare constructor(byval i as integer)
end type

constructor MyClass(byval i as integer)
	this.i = i
end constructor

dim myobject as MyClass = MyClass(1)
