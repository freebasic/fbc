'' check that single line comments are allowed (parsed and ignored) after
'' macros exapanding with optional parentheses

#macro foo?(_a, _c...)
    #if #_c=""
        #print "    A is " #_a
        #print "    C is " #_c
    #else
        #print "    A is " #_a
        #print "    C is " #_c
    #endif
#endmacro

#print "-----"
#print "foo 10"
foo 10

#print "-----"
#print "10 ', 100"
foo 10 ', 100

#print "-----"
#print "foo 10 ', "
foo 10 ',
 
#print "-----"
#print "foo 10 ', asdasd"
foo 10 ', asdasd

#print "-----"
#print "foo 10 ', foo"
foo 10 ', foo

#print "-----"
#print "foo 10 'foo"
foo 10 'foo
