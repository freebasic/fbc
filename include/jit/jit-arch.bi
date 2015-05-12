''
''
'' jit-arch -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_arch_bi__
#define __jit_arch_bi__

    ' If defined _JIT_ARCH_GET_CURRENT_FRAME() macro assigns the current frame
    ' pointer to the supplied argument that has to be a void pointer.
    #define	_JIT_ARCH_GET_CURRENT_FRAME(f)		_
        do                                      _
            asm                                 _
                mov dword ptr [f], ebp          _
            end asm                             _
        loop while 0                            

#endif
