
namespace ns
	dim foo as integer = 1    
end namespace

	scope
    	using ns
		print "ns::foo ="; foo
	end scope

	dim foo as integer = 2

    print "ns::foo ="; ns.foo, "::foo ="; foo
