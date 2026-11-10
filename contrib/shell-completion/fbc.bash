# fbc - Bash completion for the FreeBASIC compiler
# Source this file or place it in /etc/bash_completion.d/fbc

_fbc() {
    local cur prev words cword
    _init_completion || return

    local arch_types="native 32 64 x86 x86_64 amd64 i386 i486 i586 i686 prescott
        armv5 armeabi armeabi-v7a armv7 armv7a armv8-a aarch64"
    local gen_backends="gas gas64 gcc llvm"
    local lang_dialects="fb deprecated fblite qb"
    local warn_opts="all pedantic none param escape next signedness constness suffix error upcast"
    local print_opts="host target fblibdir x sha-1"
    local z_opts="gosub-setjmp valist-as-ptr no-thiscall no-fastcall fbrt nocmdline"

    case "$prev" in
        -arch)
            COMPREPLY=($(compgen -W "$arch_types" -- "$cur"))
            return
            ;;
        -asm)
            COMPREPLY=($(compgen -W "att intel" -- "$cur"))
            return
            ;;
        -gen)
            COMPREPLY=($(compgen -W "$gen_backends" -- "$cur"))
            return
            ;;
        -lang|-forcelang)
            COMPREPLY=($(compgen -W "$lang_dialects" -- "$cur"))
            return
            ;;
        -s)
            COMPREPLY=($(compgen -W "console gui" -- "$cur"))
            return
            ;;
        -w)
            COMPREPLY=($(compgen -W "$warn_opts" -- "$cur"))
            return
            ;;
        -print)
            COMPREPLY=($(compgen -W "$print_opts" -- "$cur"))
            return
            ;;
        -fpmode)
            COMPREPLY=($(compgen -W "fast precise" -- "$cur"))
            return
            ;;
        -fpu)
            COMPREPLY=($(compgen -W "x87 sse" -- "$cur"))
            return
            ;;
        -z)
            COMPREPLY=($(compgen -W "$z_opts" -- "$cur"))
            return
            ;;
        -O)
            COMPREPLY=($(compgen -W "0 1 2 3" -- "$cur"))
            return
            ;;
        -vec)
            COMPREPLY=($(compgen -W "0 1 2" -- "$cur"))
            return
            ;;
        -a|-o|-x|-map|-include)
            _filedir
            return
            ;;
        -b|-m)
            _filedir 'bas'
            return
            ;;
        -i|-p|-prefix)
            _filedir -d
            return
            ;;
        -d|-l|-nolib|-maxerr|-t|-title|-target|-buildprefix|-Wa|-Wc|-Wl|-entry)
            return
            ;;
    esac

    if [[ "$cur" == -* ]]; then
        local opts="-a -arch -asm -b -buildprefix -c -C -d -dll -dylib
            -e -earray -eassert -edebug -edebuginfo -elocation -enullptr -eunwind
            -entry -ex -exx -export -fbgfx -forcelang -fpmode -fpu -g -gen
            --help -help -i -include -l -lang -lib -m -map -maxerr -mt
            -nodeflibs -noerrline -nolib -noobjinfo -nostrip -o -O -p -pic
            -pp -prefix -print -profile -r -rr -R -RR -s -showincludes
            -static -strip -t -target -title -v -vec --version -version
            -w -Wa -Wc -Wl -x -z"
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
        return
    fi

    _filedir '@(bas|a|o|rc|res|xpm)'
}

complete -F _fbc fbc
