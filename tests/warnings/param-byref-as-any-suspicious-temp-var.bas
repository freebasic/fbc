'' When passing certain rvalue expressions to BYREF parameters,
'' the value will be stored in a temp var which is then passed.
'' fbc should show a warning for some such cases, but not for all.

dim local_i as integer
dim shared global_i as integer
declare function get_ptr() as integer ptr
declare function get_ref() byref as integer

declare sub user_defined_nonconst(byref ref as any)
declare sub user_defined_const(byref ref as const any)

'' CONST expressions are implicitly passed BYVAL for some reason, except in lang qb,
'' unlike the normal behaviour for BYREF AS <concrete_type> parameters.
'' Thus no temp var and no warning.
#print "no warnings for passing constants:"
clear 0, 0, 0
clear cptr(any ptr, 0), 0, 0
clear byval 0, 0, 0
clear byval cptr(any ptr, 0), 0, 0
user_defined_nonconst(0)
user_defined_nonconst(cptr(any ptr, 0))
user_defined_nonconst(byval 0)
user_defined_nonconst(byval cptr(any ptr, 0))
user_defined_const(0)
user_defined_const(cptr(any ptr, 0))
user_defined_const(byval 0)
user_defined_const(byval cptr(any ptr, 0))

'' Example of proper BYREF AS ANY usage (passing objects instead of addresses), so no warnings.
#print "---"
#print "no warnings for proper BYREF AS ANY usage:"
clear local_i, 0, sizeof(local_i)
clear global_i, 0, sizeof(global_i)
clear *get_ptr(), 0, sizeof(global_i)
clear get_ref(), 0, sizeof(global_i)
user_defined_nonconst(local_i)
user_defined_nonconst(global_i)
user_defined_nonconst(*get_ptr())
user_defined_nonconst(get_ref())
user_defined_const(local_i)
user_defined_const(global_i)
user_defined_const(*get_ptr())
user_defined_const(get_ref())

'' Example of proper BYREF AS ANY usage with explicit BYVAL, thus no temp vars and no warnings.
#print "---"
#print "no warnings for explicit BYVAL passed to BYREF AS ANY:"
clear byval @local_i, 0, sizeof(local_i)
clear byval @global_i, 0, sizeof(global_i)
clear byval get_ptr(), 0, sizeof(global_i)
'' (need to use varptr() instead of @, otherwise fbc treats it as address-of function, instead of address-of function call's result)
clear byval varptr(get_ref()), 0, sizeof(global_i)
user_defined_nonconst(byval @local_i)
user_defined_nonconst(byval @global_i)
user_defined_nonconst(byval get_ptr())
user_defined_nonconst(byval varptr(get_ref()))
user_defined_const(byval @local_i)
user_defined_const(byval @global_i)
user_defined_const(byval get_ptr())
user_defined_const(byval varptr(get_ref()))

'' Examples of suspicious cases passing address of a variable/object to BYREF AS ANY
'' and end up using a temp var, presumably unintentionally. They should trigger the warning.
#print "---"
#print "3 warnings (suspicious BYREF AS ANY argument):"
clear @local_i, 0, sizeof(local_i)
clear get_ptr(), 0, sizeof(global_i)
clear varptr(get_ref()), 0, sizeof(global_i)
#print "3 warnings (suspicious BYREF AS ANY argument):"
user_defined_nonconst(@local_i)
user_defined_nonconst(get_ptr())
user_defined_nonconst(varptr(get_ref()))
#print "3 warnings (suspicious BYREF AS ANY argument):"
user_defined_const(@local_i)
user_defined_const(get_ptr())
user_defined_const(varptr(get_ref()))

'' OFFSET expressions are also implicitly passed BYVAL, like CONSTs, for some reason (except in lang qb).
#print "no warnings for passing global var addrof (OFFSET nodes):"
clear @global_i, 0, sizeof(global_i)
user_defined_nonconst(@global_i)
user_defined_const(@global_i)
'' Function pointers are OFFSETs too
user_defined_nonconst(procptr(get_ptr))
user_defined_const(procptr(get_ptr))

'' Examples of similar potentially suspicious cases but with BYREF as <concrete_type> parameters as opposed to BYREF AS ANY.
'' These already result in type mismatch warnings (at least the ones using temp vars),
'' so there is no need for a specific check as for BYREF AS ANY.
#print "---"
#print "other warnings for similar situations with other parameter types:"
sub f1(byref i as integer)
end sub
sub f2(byref p as integer ptr)
end sub
dim p as double ptr
#print "no warning (correct usage):"
f1(0)
f1(local_i)
#print "4 warnings (passing pointer to scalar):"
f1(@local_i)
f1(@global_i)
f1(get_ptr())
f1(varptr(get_ref()))
'' Passing integer as address via explicit BYVAL. A bit awkward perhaps, since it's not a pointer type,
'' but currently fbc doesn't show any warning for this, and it doesn't use a temp var either,
'' so it shouldn't trigger a "suspicious temp var passed to BYREF" warning.
#print "no warning (explicit BYVAL passes value as address, even though it's not a pointer type):"
f1(byval local_i)
#print "no warning (correct usage):"
f1(byval @local_i)
#print "1 warning (mismatching pointer types):"
f2(p)
'' Passing pointer via explicit BYVAL. A bit awkward perhaps, since it's a different pointer type,
'' but currently fbc doesn't show any warning for this, and it doesn't use a temp var either,
'' so it shouldn't trigger a "suspicious temp var passed to BYREF" warning.
#print "no warning (explicit BYVAL passes ptr value as address, even if it's a different pointer type):"
f2(byval p)
