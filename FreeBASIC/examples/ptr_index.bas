''
'' pointer indexing example
'' 

option explicit

type VECTOR
    x   as integer
    y   as integer
    z   as integer
end type

type FACE
    vtxtb as VECTOR ptr
end type

const MAXVTX = 100
    
    dim f as face
    dim v as VECTOR, pv as VECTOR ptr
    dim a as integer
    
    ''........
    f.vtxTB = callocate( MAXVTX * len( VECTOR ) )
    
    ''........
    a = 10
    
    f.vtxTB[a].x = 1
    f.vtxTB[a].y = 2
    f.vtxTB[a].z = 3
    
    ''........
    print f.vtxTB[a].x, f.vtxTB[a].y, f.vtxTB[a].z
    
    print *(f.vtxTB + a).x, *(f.vtxTB + a).y, *(f.vtxTB + a).z
    
    ''........
    v = f.vtxTB[a]
    
    print v.x, v.y, v.z
    
    print *(@v).x, *(@v).y, *(@v).z
    
    ''........
    pv = @f.vtxTB[a]
    
    print pv->x, pv->y, pv->z
    
    print *(pv).x, *(pv).y, *(pv).z
    
    ''........
    sleep
    
    ''........
    deallocate( f.vtxTB )
    
