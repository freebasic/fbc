# fbc - Fish completion for the FreeBASIC compiler
# Place this file in ~/.config/fish/completions/ or /usr/share/fish/completions/

set -l arch_types \
    native 32 64 x86 x86_64 amd64 \
    i386 i486 i586 i686 prescott \
    armv5 armeabi armeabi-v7a armv7 armv7a armv8-a aarch64

set -l lang_dialects fb deprecated fblite qb
set -l warn_opts all pedantic none param escape next signedness constness suffix error upcast
set -l z_opts gosub-setjmp valist-as-ptr no-thiscall no-fastcall fbrt nocmdline

complete -c fbc -f

complete -c fbc -s a -r -F -d 'Treat file as .o/.a input file'
complete -c fbc -l arch -r -d 'Set target architecture' -a "$arch_types"
complete -c fbc -l asm -r -d 'Set asm format (gas/gcc/llvm, x86/x86_64 only)' -a "att intel"
complete -c fbc -s b -r -F -d 'Treat file as .bas input file'
complete -c fbc -l buildprefix -r -d 'Specify prefix on tool names (as, ar, ld)'
complete -c fbc -s c -d 'Compile only, do not link'
complete -c fbc -s C -d 'Preserve temporary .o files'
complete -c fbc -s d -r -d 'Add a global #define'
complete -c fbc -l dll -d 'Same as -dylib'
complete -c fbc -l dylib -d 'Create a DLL (win32) or shared library (*nix/*BSD)'
complete -c fbc -s e -d 'Enable runtime error checking'
complete -c fbc -l earray -d 'Enable array bounds checking'
complete -c fbc -l eassert -d 'Enable assert() and assertwarn() checking'
complete -c fbc -l edebug -d 'Enable __FB_DEBUG__'
complete -c fbc -l edebuginfo -d 'Add debug info'
complete -c fbc -l elocation -d 'Enable error location reporting'
complete -c fbc -l enullptr -d 'Enable null-pointer checking'
complete -c fbc -l eunwind -d 'Enable call stack unwind information'
complete -c fbc -l entry -r -d 'Change the entry point of the program'
complete -c fbc -l ex -d '-e plus RESUME support'
complete -c fbc -l exx -d '-ex plus array bounds/null-pointer checking'
complete -c fbc -l export -d 'Export symbols for dynamic linkage'
complete -c fbc -l fbgfx -d 'Link to the appropriate libfbgfx variant'
complete -c fbc -l forcelang -r -d 'Override #lang statements in source code' -a "$lang_dialects"
complete -c fbc -l fpmode -r -d 'Select floating-point math accuracy/speed' -a "fast precise"
complete -c fbc -l fpu -r -d 'Set target FPU' -a "x87 sse"
complete -c fbc -s g -d 'Add debug info, enable __FB_DEBUG__, and enable assert()'
complete -c fbc -l gen -r -d 'Select code generation backend' -a "gas gas64 gcc llvm"
complete -c fbc -l help -d 'Show help output'
complete -c fbc -s i -r -F -d 'Add an include file search path'
complete -c fbc -l include -r -F -d 'Pre-#include a file for each input .bas'
complete -c fbc -s l -r -d 'Link in a library'
complete -c fbc -l lang -r -d 'Select FB dialect' -a "$lang_dialects"
complete -c fbc -l lib -d 'Create a static library'
complete -c fbc -s m -r -d 'Specify main module'
complete -c fbc -l map -r -F -d 'Save linking map to file'
complete -c fbc -l maxerr -r -d 'Only show n errors'
complete -c fbc -l mt -d 'Use thread-safe FB runtime'
complete -c fbc -l nodeflibs -d 'Do not include the default libraries when linking'
complete -c fbc -l noerrline -d 'Do not show source context in error messages'
complete -c fbc -l nolib -r -d 'Do not include the specified libraries (comma-separated)'
complete -c fbc -l noobjinfo -d 'Do not read/write compile-time info from/to .o and .a files'
complete -c fbc -l nostrip -d 'Do not strip symbol information from the output file'
complete -c fbc -s o -r -F -d 'Set .o (or -pp .bas) file name for prev/next input file'
complete -c fbc -s O -r -d 'Optimization level (default: 0)' -a "0 1 2 3"
complete -c fbc -s p -r -F -d 'Add a library search path'
complete -c fbc -l pic -d 'Generate position-independent code (non-x86 Unix shared libs)'
complete -c fbc -l pp -d 'Write out preprocessed input file (.pp.bas) only'
complete -c fbc -l prefix -r -F -d 'Set the compiler prefix path'
complete -c fbc -l print -r -d 'Display information' -a "host target fblibdir x sha-1"
complete -c fbc -l profile -d 'Enable function profiling'
complete -c fbc -s r -d 'Write out .asm/.c/.ll (-gen gas/gcc/llvm) only'
complete -c fbc -s R -d 'Preserve temporary .asm/.c/.ll/.def files'
complete -c fbc -l rr -d 'Write out the final .asm only'
complete -c fbc -l RR -d 'Preserve the final .asm file'
complete -c fbc -s s -r -d 'Select win32 subsystem' -a "console gui"
complete -c fbc -l showincludes -d 'Display a tree of file names of #included files'
complete -c fbc -l static -d 'Prefer static libraries over dynamic ones when linking'
complete -c fbc -l strip -d 'Omit all symbol information from the output file'
complete -c fbc -s t -r -d 'Set .exe stack size in kbytes (default: 1024, win32/dos)'
complete -c fbc -l target -r -d 'Set cross-compilation target'
complete -c fbc -l title -r -d 'Set XBE display title (xbox)'
complete -c fbc -s v -d 'Be verbose'
complete -c fbc -l vec -r -d 'Automatic vectorization level (default: 0)' -a "0 1 2"
complete -c fbc -l version -d 'Show compiler version'
complete -c fbc -s w -r -d 'Set min warning level' -a "$warn_opts"
complete -c fbc -l Wa -r -d "Pass options to 'as'"
complete -c fbc -l Wc -r -d "Pass options to 'gcc' (-gen gcc) or 'llc' (-gen llvm)"
complete -c fbc -l Wl -r -d "Pass options to 'ld'"
complete -c fbc -s x -r -F -d 'Set output executable/library file name'
complete -c fbc -s z -r -d 'Set miscellaneous option' -a "$z_opts"
