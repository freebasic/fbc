option explicit

dim as ulongint lint

lint = ((&hffffffff00000000ull shr 32) And &hffffffffll) 

assert( lint = 4294967295ll )
