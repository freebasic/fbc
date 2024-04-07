' TEST_MODE : COMPILE_ONLY_OK

#if 0
  #macro f(x)
    print _
      #x  '' no error on invalid directives
  #endmacro
#endif

'' no error on invalid directives while skipping
#if 0
#invalid
#endif

'' ignore line continuations while skipping
#if 0
	print _
#endif

'' preserve multiline comment parsing while skipping
#if 0
/' comment
	print _
	#endif
	_
'/
#endif

'' line contiuation on if/elseif statements accepted
#if _
  0
    ignore_this_invalid_statement
#elseif _
  0
    ignore_this_invalid_statement
#endif
