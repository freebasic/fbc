' TEST_MODE : COMPILE_AND_RUN_OK

type TrueType : __ as integer : end type
type FalseType : __ as integer : end type

function IsUDT overload ( byval p as byte ptr ) as FalseType : end function
function IsUDT overload ( byval p as short ptr ) as FalseType : end function
function IsUDT overload ( byval p as integer ptr ) as FalseType : end function
function IsUDT overload ( byval p as any ptr ) as TrueType : end function

dim a as byte
dim b as short
dim c as integer
dim d as T

'' Before r5156:

' the following gives `error 88: Ambiguous call to overloaded function, ISUDT() in '# print typeof((IsUDT(@a)))'`
assert(IsUDT(@a) = 0)
assert(IsUDT(@b) = 0)
assert(IsUDT(@c) = 0)
assert(IsUDT(@d) = -1)
