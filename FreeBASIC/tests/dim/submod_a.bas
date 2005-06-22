'$dynamic

option explicit
option private

defint a-z

'$include once: "dim/submod_c.bi"

#ifdef FIXIT
dim shared ext_array(1 to 21, 1 to 2) as integer
#endif

declare function get_array_ptr as any ptr

color_data:
 data "11", "1"

dim ext_array_ptr as any ptr
ext_array_ptr = varptr(ext_array(1,1))
print "Ptr to array: ", ext_array_ptr, get_array_ptr()

print "Step 1"
read ext_array(1,1)
print "Step 2"
read ext_array(1,2)
print "Step 3"

end get_array_ptr() <> ext_array_ptr
