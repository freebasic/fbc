#print "---"

type UDT
	dim as integer I = 123
	dim as UDT ptr p
	static As UDT ptr p0
	declare sub printDereferencePointer ()
end type

type UDT2
	i as integer
end type

Dim As UDT Ptr UDT.p0

Sub UDT.printDereferencePointer ()

	#print "-- 5 errors expected"
	print *p.I
	print *(p).I
	print *This.p.I
	print *(This).p.I
	print *(This.p).I

	#print "-- 5 errors expected"
	print *p0.I
	print *(p0).I
	print *UDT.p0.I
	print *(UDT).p0.I
	print *(UDT.p0).I

	#print "-- no errors expected"
	print (*p).I
	print (*This.p).I
	print (*p0).I
	print (*UDT.p0).I

End Sub

dim As UDT u
u.p = @u
u.p0 = @u

#print "-- 5 errors expected"
print *UDT.p0.I
print *(UDT.p0).I
print *u.p.I
print *(u).p.I
print *(u.p).I

#print "-- no errors expected"
print *(UDT.p0).I
print (*u.p).I

dim x as UDT2 = (123)
var p = @x

#print "-- 2 errors expected"
print *p.i
print *(p).i

print "-- no errors expected"
print p->i
print (*p).i
