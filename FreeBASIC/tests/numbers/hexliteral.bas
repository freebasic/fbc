option explicit

dim as longint lint

lint = ((&hffffffff00000000ll shr 32) And &hffffffffll) 

assert( lint = 4294967295ll )
