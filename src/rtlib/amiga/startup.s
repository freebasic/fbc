| FreeBASIC AmigaOS startup - opens dos.library, calls _main, cleans up
    .text
    .globl _start
_start:
    move.l  a0,_cmdline     | Save command line pointer
    move.l  d0,_cmdlen      | Save command line length
    move.l  4.w,a6
    move.l  a6,_SysBase

    lea     dosname(pc),a1
    moveq   #36,d0
    jsr     -552(a6)
    move.l  d0,_DOSBase
    beq.s   .fail

    | Run global constructors
    jsr     ___fb_ctor_run

    | Call main(argc, argv)
    | FreeBASIC runtime reads _cmdline/_cmdlen directly via fb_hParseArgs,
    | so we pass argc=0, argv=NULL here. The runtime handles arg parsing.
    pea     0
    pea     0
    jsr     _main
    addq.l  #8,sp
    move.l  d0,d2

    | Run global destructors
    jsr     ___fb_dtor_run

    | CloseLibrary(DOSBase)
    move.l  _SysBase,a6
    move.l  _DOSBase,a1
    jsr     -414(a6)

    move.l  d2,d0
    rts

.fail:
    moveq   #20,d0
    rts

dosname: .asciz "dos.library"
    .align 2

    .globl _SysBase
    .globl _DOSBase
    .globl _LocaleBase
    .bss
_SysBase:    .long 0
_cmdline:    .long 0
_cmdlen:     .long 0
    .globl _cmdline
    .globl _cmdlen
_DOSBase:    .long 0
_LocaleBase: .long 0
| __impure_ptr: newlib reentrancy pointer. Initialized by crt0 if using newlib.
| Set to 0 here; newlib's startup will override if linked.
__impure_ptr: .long 0
    .globl __impure_ptr

| Constructor/destructor list runners
| GCC puts function pointers in .ctors/.dtors sections
    .weak ___CTOR_LIST__
    .weak ___CTOR_END__
    .weak ___DTOR_LIST__
    .weak ___DTOR_END__

    .text
    .globl ___fb_ctor_run
___fb_ctor_run:
    lea     ___CTOR_LIST__,a0
    lea     ___CTOR_END__,a1
    bra.s   .ctor_check
.ctor_loop:
    move.l  (a0)+,a2
    jsr     (a2)
.ctor_check:
    cmp.l   a0,a1
    bne.s   .ctor_loop
    rts

    .globl ___fb_dtor_run
___fb_dtor_run:
    lea     ___DTOR_LIST__,a0
    lea     ___DTOR_END__,a1
    bra.s   .dtor_check
.dtor_loop:
    move.l  (a0)+,a2
    jsr     (a2)
.dtor_check:
    cmp.l   a0,a1
    bne.s   .dtor_loop
    rts
