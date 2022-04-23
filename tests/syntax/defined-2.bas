namespace ns
	dim as integer value

	#if defined( value )
		#print "value defined"
	#else
		#print "value not defined - NOK"
	#endif

end namespace

sub proc
	#if defined( value )
		#print "value defined - NOK"
	#else
		#print "value not defined"
	#endif

	using ns

	#if defined( value )
		#print "value defined"
	#else
		#print "value not defined - NOK"
	#endif

	#if defined( ..value )
		#print "..value defined"
	#else
		#print "..value not defined - NOK"
	#endif

	#if defined( ns.value )
		#print "ns.value defined"
	#else
		#print "ns.value not defined - NOK"
	#endif

	#if defined( novalue )
		#print "novalue defined - NOK"
	#else
		#print "novalue not defined"
	#endif

	#if defined( ..novalue )
		#print "..novalue defined - NOK"
	#else
		#print "..novalue not defined"
	#endif

	#if defined( ns.novalue )
		#print "ns.novalue defined - NOK"
	#else
		#print "ns.novalue not defined"
	#endif

end sub

