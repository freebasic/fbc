Helper scripts
- to use the host fbc to pre-compile the src/compiler/*.bas sources
- into intermediate .asm (fbc -gen gas) or .c (fbc -gen gcc) files
- and making a package out of the resulting source tree
- resulting in a "source package with precompiled .bas files"
- from which we can later fully build FB, without needing a host fbc
- by creating the new compiler binary from the pre-compiled .asm or .c files

This is intended (only) to help bootstrapping fbc in Linux distro packaging
systems which usually won't allow importing an fbc binary, thus making it
necessary to pre-compile FB's .bas sources.

1. Pre-compiling the .bas sources into .asm or .c:
	make -f contrib/bootstrap/makefile prepare GEN=gas|gcc

2. Building the resulting FB source tree (without needing a host fbc):
	make -f contrib/bootstrap/makefile build GEN=gas|gcc

3. Clean up source tree completely:
	make -f contrib/bootstrap/makefile clean GEN=gas|gcc

build.mk has to do the assembling and linking steps manually, since no fbc is
available to do it. Care must be taken to use roughly the same options that
fbc itself would use.

Important: The FB rtlib will be built first, to have an fbrt0.o and libfb.a
to link the new compiler binary against. This means the fbc version used for
the pre-compilation step must exactly match the bootstrap source tree, to
ensure the pre-compiled .asm or .c files are ABI-compatible to the rtlib in
the source tree.

This is pretty much the opposite of what the normal FB makefile is doing,
where the new compiler binary is safely built using the host fbc only.

contrib/bootstrap/create-asm-tarball.sh is an example use case - it can be used
to create an FB source package with pre-compiled .asm files, which in turn can
be used as foundation for deb/rpm packaging.
