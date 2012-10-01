' TEST_MODE : COMPILE_ONLY_OK

'' this crashes the compiler before - should compile (only) ok now
sub arccot_thread(z as integer)
end sub

sub pi(digits as integer)
    dim as any ptr t1 = threadcall arccot_thread(0)
    threadwait(t1)
end sub

sub verify()
    dim as ubyte ptr test = callocate(1000000)
    open "pi" for binary as #1
end sub
