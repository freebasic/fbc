dim null_value as integer

dim dyn_str_0 as string
dim const_str_0 as string

dim dyn_str_0123 as string
dim const_str_0123 as string

dim dyn_str_3210 as string
dim const_str_3210 as string

null_value = 0

dyn_str_0 = chr(null_value)
const_str_0 = chr(0)

dyn_str_0123 = chr(null_value, 1, 2, 3)
const_str_0123 = chr(0, 1, 2, 3)

dyn_str_3210 = chr(3, 2, 1, null_value)
const_str_3210 = chr(3, 2, 1, 0)

ASSERT( dyn_str_0 = const_str_0 )
ASSERT( dyn_str_0123 = const_str_0123 )
ASSERT( dyn_str_3210 = const_str_3210 )
