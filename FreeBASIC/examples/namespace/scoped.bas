
namespace ns
	dim foo = 1    
end namespace

	scope
    	using ns
		print "ns::foo ="; foo
	end scope

	dim foo = 2

    print "ns::foo ="; ns.foo, "::foo ="; foo
