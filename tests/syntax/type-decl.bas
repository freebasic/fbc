'' ------------------------------------
#print "---"
#print "2 errors for field members as parent type"

namespace n1
	type T1
		__ as integer
		type T2
			member1 as T1
			as T1 member2
		end type
	end type
end namespace

'' ------------------------------------
#print "---"
#print "2 errors for named type/union in an anonymous type/union"

namespace n2
	type T1
		a as integer
		union
			b as integer
			type NAMED1
		end union
	end type
	union U1
		a as integer
		type
			b as integer
			union NAMED2
		end type
	end union
end namespace
