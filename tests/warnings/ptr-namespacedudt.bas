type UDT1
	i as integer
end type

namespace ns1
	type UDT1
		i as integer
	end type
end namespace

dim p1 as sub( as UDT1     )
dim p2 as sub( as ns1.UDT1 )

#print "2 warnings:"
p1 = p2
p2 = p1
