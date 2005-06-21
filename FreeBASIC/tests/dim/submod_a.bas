'$dynamic

option explicit
option private

defint a-z

'$include once: "dim/submod_c.bi"

#ifdef FIXIT
dim shared ext_array(1 to 21, 1 to 2) as integer
#endif

color_data:
 data "11", "1"

print "Ptr to array: ",varptr(ext_array(1,1))

print "Step 1"
read ext_array(1,1)
print "Step 2"
read ext_array(1,2)
print "Step 3"
