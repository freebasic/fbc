' TEST_MODE : COMPILE_ONLY_FAIL
type aType
as integer n
ap as any ptr
end type

type bType
As String s
end type

sub c( aa as aType )
	
	' my typo causes "segmentation violation"
	dim as bType e = *(cPtr( bType Ptr, aa.s ))
	
End sub