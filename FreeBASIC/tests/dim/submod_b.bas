option explicit
option private

'$include once: "dim/submod_c.bi"

defint a-z

#ifndef FIXIT
dim shared ext_array(1 to 21, 1 to 2) as integer
#endif

public function get_array_ptr as any ptr
    return varptr(ext_array(1,1))
end function
