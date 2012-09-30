' TEST_MODE : COMPILE_ONLY_FAIL

type foo as bar

'' Cannot interate on forward reference pointers, because the intention is to
'' do pointer arithmetic:
''    i += 1
'' also known as:
''    cptr( byte ptr, i ) += sizeof( foo )
'' but the size is unknown.
for i as foo ptr = 0 to 3
next
