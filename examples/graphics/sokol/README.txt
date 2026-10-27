sokol_triangle - the smallest sokol program through inc/sokol/
================================================================

One window, one pipeline, one triangle.  sokol_app creates the window and the
event loop, sokol_gfx owns the GPU pipeline, and every call in the program goes
through the generated FreeBASIC binding in inc/sokol/.  The program closes
itself after 180 frames and prints the backend and frame count, so it can run
unattended:

    sokol: backend=4
    sokol: 180 frames

(4 is SG_BACKEND_METAL_MACOS; 0 is GLCORE, 2 is D3D11.)

Both lines come from the callbacks, not from after sapp_run(): on macOS
sapp_run() never returns, because sokol_app ends the process from its
NSApplication delegate.  The same program therefore prints the same thing on
every backend.


sokol is header-only
--------------------

There is no sokol library to link against.  The generated .bi files declare
the API; the application must compile the implementation once, in exactly one
translation unit:

    sokol_impl.m    macOS, Objective-C, SOKOL_METAL
    sokol_impl.c    Windows, C, SOKOL_D3D11; Linux, C, SOKOL_GLCORE

Both define SOKOL_NO_ENTRY, because the BASIC program calls sapp_run() itself
and sokol_app must not provide main().


macOS
-----

    ./build-macos.sh
    ./sokol_triangle

The script fetches the pinned sokol headers into ./sokol/ on first use and
checks their sha256 before compiling.  The pinned revisions are

    sokol_gfx.h, sokol_time.h, sokol_log.h
        79611ab0d5e90d838f048e60d99aeca0a1bd187a   (2024-05-11)
    sokol_app.h
        13554f665ebf32522b9e0323b35f08fb836b98b2   (2024-05-13)

Those are the headers inc/sokol/*.bi were generated from; the full hashes are
in the .bi headers.  Do not substitute current sokol
master: its resource API was redesigned after this snapshot and the binding
does not match it.

sokol_app needs Cocoa, QuartzCore, Metal and MetalKit (it hosts the layer in
an MTKView); the build passes them through fbc's -Wl option.  The Metal backend is Objective-C, which is why
sokol_impl.m exists instead of a .c file.


Linux
-----

Compile sokol_impl.c and link the X11 dependencies sokol_app requires:

    cc -c -O2 -o sokol_impl.o sokol_impl.c -Isokol
    fbc -i <repo>/inc sokol_triangle.bas sokol_impl.o \
        -l X11 -l Xi -l Xcursor -l GL -l dl -l pthread -l m

The program uses the GLSL shader source on the GL backends and the MSL source
on Metal; the choice is made from sg_query_backend().


Windows
-------

Compile sokol_impl.c with MSVC or clang-cl, and link d3d11, dxgi and the
usual system libraries:

    cl /c /O2 /DSOKOL_NO_ENTRY sokol_impl.c /Isokol
    fbc -i <repo>\inc sokol_triangle.bas sokol_impl.obj ^
        -l d3d11 -l dxgi

D3D11 is not covered by this example yet: sokol's D3D11 backend takes
precompiled shader bytecode (sg_shader_stage_desc.bytecode) and the program has
no HLSL source or fxc step, so it exits with "no shader source for backend 2".
The window, the event loop and the binding still run; only the shader stage is
missing.
