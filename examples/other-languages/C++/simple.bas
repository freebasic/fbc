'' A test using the libsimple.a library created from simple.cxx

extern "c++" lib "simple"
	namespace cpp
		declare function sum( byval a as integer, byval b as integer ) as integer        
	end namespace
end extern

print "1 + 2 ="; cpp.sum( 1, 2 )
