#!/usr/bin/make -f
#
# This is fbc's toplevel makefile whopper, please enjoy it. It builds the
# compiler program (fbc) and the runtime libraries (libfb*) for each enabled
# target. Try 'make help' for some information on what you can configure.
#
# The runtime consists of libfb.a, libfbmt.a (libfb.a but with
# -DMULTITHREADED), libfbgfx.a and fbrt0.o. Many C modules, some assembly,
# many system-dependant parts.
# There are two special cases that require extra work:
#   1) libfbgfx's font/palette data files: they need to be compressed and
#      turned into a C array of bytes, so that they can be uncompressed and
#      used at runtime. The makedata.bas tool generates the libfb_gfx_data.h
#      header which is #included by libfb_gfx_data.c.
#   2) libfb's FB Windows port I/O driver (fbportio): it is compiled and then
#      also turned into a C array of bytes using the makedriver.bas tool,
#      so at runtime it can be written out and installed as a file. makedriver
#      generates the fbportio_driver.h header which is #included by
#      libfb_sys_ports_win32.c.
#

# Determine the srcdir (like the one normally given by configure),
# to allow building in a separate build directory.
VPATH := $(dir $(MAKEFILE_LIST))

# We don't want to use any of make's built-in suffixes/rules
.SUFFIXES:

AR := ar
BUILD_FBC := fbc
CC := gcc
CFLAGS := -g -O0 -DDEBUG
DLLTOOL := dlltool
FBC := fbc
FBFLAGS := -g -exx
PREFIX := /usr/local
WINDRES := windres

# config.mk can be used to define variables/settings, so we need to set the
# defaults before this #include.
-include config.mk

#
# System-specific configuration
# -----------------------------
#
# build system: where the build is taking place. (default: guessed from uname)
# host system: where the new compiler is going to run. (default: build)
# target system(s): target(s) the new compiler is going to support,
#                   system(s) to build the runtime for. (default: host)
#
# BUILD, HOST, and TARGETS are GNU system triplets (as known from autoconf):
#
# If BUILD is set then it will be used as the triplet prefix for BUILD_FBC,
# used as part of the runtime buil, and to determine how to set BUILD_EXEEXT.
#
# HOST defaults to BUILD, but can be set to something else to cross-compile an
# fbc that will run on that HOST system. It will be used as triplet prefix for
# FBC (and GCC when the C objinfo wrapper is used).
#
# TARGETS defaults to HOST, but can be set to a (space-separated) list of
# triplets of systems that the new compiler should support. The runtime will
# be build once for each target (allowing for a multi-target or multi-lib
# build).
#
# If BUILD is not specified, then by default all these three variables will
# be empty and native tools will be used. It's still ok to specify HOST (with
# or without TARGETS) or TARGETS only.
#
#

################################################################################
# GNU system triplet parsing
# It's nice to support the triplets for cross builds etc. just like autoconf,
# so the proper cross-tools can be invoked. In autoconf you'd use a shell case
# statement and check for *-*-mingw*, but here we convert the dashes in the
# triplets to spaces ('i686-pc-mingw32' -> 'i686 pc mingw32') and then use
# make's word/text processing functions to analyze it.

# os = {all the words 3..EOL | the last word if 3..EOL was empty}
# 'i686 pc linux gnu' -> 'linux gnu'
# 'mingw32'           -> 'mingw32'
extract-os = $(or $(wordlist 3,$(words $(1)),$(1)),$(lastword $(1)))

# cpu = iif(has >= 2 words, first word, unknown)
# 'i686 pc linux gnu' -> 'i686'
# 'mingw32'           -> 'unknown'
extract-cpu = $(if $(word 2,$(1)),$(firstword $(1)),unknown)

triplet-oops = \
  $(error Sorry, '$(1)' does not look like one of the known GNU triplets. \
          Maybe you mistyped, or the system is not yet supported by FB)

# Canonical name to FB's internal short name translation
parse-os = \
  $(or $(findstring cygwin,$(1)), \
       $(findstring darwin,$(1)), \
       $(findstring freebsd,$(1)), \
       $(findstring linux,$(1)), \
       $(findstring mingw,$(1)), \
       $(findstring djgpp,$(1)), \
       $(findstring netbsd,$(1)), \
       $(findstring openbsd,$(1)), \
       $(findstring solaris,$(1)), \
       $(findstring xbox,$(1)), \
       $(call triplet-oops,$(2)))

parse-cpu = \
  $(or $(and $(filter i386,$(1)),386), \
       $(and $(filter i486,$(1)),486), \
       $(and $(filter i586,$(1)),586), \
       $(and $(filter i686,$(1)),686), \
       $(filter x86_64 sparc sparc64 powerpc64,$(1)), \
       $(call triplet-oops,$(2)))

triplet-os  = $(call parse-os,$(call extract-os,$(subst -, ,$(1))),$(1))
triplet-cpu = $(call parse-cpu,$(call extract-cpu,$(subst -, ,$(1))),$(1))

################################################################################



ifneq ($(BUILD),)
  # The user set BUILD to something specific, so we're going to extract
  # BUILD_OS and BUILD_CPU from it.
  BUILD_OS := $(call triplet-os,$(BUILD))
  BUILD_CPU := $(call triplet-cpu,$(BUILD))
  BUILD_PREFIX := $(BUILD)-
endif

# If the BUILD_OS isn't already set from 
ifeq ($(BUILD_OS),)
	# Try to automatically figure out what the build system is, so we can
	# set BUILD_EXEEXT, HOST_OS and TARGET_OS automatically.
	# uname is available on every system we currently support, except on
	# Windows with MinGW but not MSYS, we try to detect that below.
	uname_s := $(shell uname -s 2>&1 || echo unknown)
	#uname_o := $(shell uname -o 2>&1 || echo unknown)
	uname_m := $(shell uname -m 2>&1 || echo unknown)

	ifneq ($(findstring CYGWIN,$(uname_s)),)
		BUILD_OS := cygwin
	else ifeq ($(uname_s),Darwin)
		BUILD_OS := darwin
	else ifeq ($(uname_s),FreeBSD)
		BUILD_OS := freebsd
	else ifeq ($(uname_s),Linux)
		BUILD_OS := linux
	else ifneq ($(findstring MINGW,$(uname_s)),)
		BUILD_OS := win32
	else ifeq ($(uname_s),NetBSD)
		BUILD_OS := netbsd
	else ifeq ($(uname_s),OpenBSD)
		BUILD_OS := openbsd
	else ifeq ($(uname_s),MS-DOS)
		BUILD_OS := dos
	else ifneq ($(COMSPEC),)
		# This check lets us support mingw32-make without MSYS.
		# TODO: any better way to check this?
		BUILD_OS := win32
	else
                $(error Sorry, the operating system could not be identified \
                        automatically. Please set BUILD_OS; see 'make help' for \
                        possible values. 'uname -s' returned: '$(uname_s)')
	endif
endif

# Build-system specific configuration
ifeq ($(BUILD_OS),dos)
	BUILD_EXEEXT := .exe
else ifeq ($(BUILD_OS),cygwin)
	BUILD_EXEEXT := .exe
else ifeq ($(BUILD_OS),darwin)
else ifeq ($(BUILD_OS),freebsd)
else ifeq ($(BUILD_OS),linux)
else ifeq ($(BUILD_OS),netbsd)
else ifeq ($(BUILD_OS),openbsd)
else ifeq ($(BUILD_OS),solaris)
else ifeq ($(BUILD_OS),win32)
	BUILD_EXEEXT := .exe
else ifeq ($(BUILD_OS),xbox)
else
        $(error Unexpected BUILD_OS: '$(BUILD_OS)', see 'make help' for \
                possible values)
endif

# Should we cross-compile to a specific host?
ifneq ($(HOST),)
	HOST_PREFIX := $(HOST)-

	# No target given? Then default to the host.
	ifeq ($(TARGETS),)
		TARGETS := $(HOST)
	endif
endif

ifneq ($(TARGETS),)
	TARGET_PREFIXES := $(patsubst %,%-,$(TARGETS))
endif

ifeq ($(HOST_OS),mingw)
	EXEEXT := .exe
endif


# We need to build the runtime once for each target the compiler is going to
# to support. If a specific compiler host was given, but no specific target(s),
# then the target defaults to the host, and we'll built one runtime for that
# system. By default (for native builds where build = host = target) we build
# one runtime for the host system, but without using the system prefixes.

define runtime-rules
runtime's target-specific build rules...
endef

#ifeq ($(TARGET_PREFIXES),)
#$(eval $(foreach i,$(TARGET_PREFIXES),$(call runtime-rules,$(i))))


HOST_CPUFAMILY:=@HOST_CPUFAMILY@
HOST_OS:=@HOST_OS@
HOST_OSFAMILY:=@HOST_OSFAMILY@
host_cpu:=@host_cpu@

COMPILER_HEADERS :=
COMPILER_OBJECTS :=

COMPILER_HEADERS += compiler/ast.bi
COMPILER_HEADERS += compiler/ast-op.bi
COMPILER_HEADERS += compiler/clist.bi
COMPILER_HEADERS += compiler/dstr.bi
COMPILER_HEADERS += compiler/emit.bi
COMPILER_HEADERS += compiler/emitdbg.bi
COMPILER_HEADERS += compiler/error.bi
COMPILER_HEADERS += compiler/fb-bfd-bridge.bi
COMPILER_HEADERS += compiler/fb.bi
COMPILER_HEADERS += compiler/fbc.bi
COMPILER_HEADERS += compiler/fbint.bi
COMPILER_HEADERS += compiler/fb-obj.bi
COMPILER_HEADERS += compiler/flist.bi
COMPILER_HEADERS += compiler/hash.bi
COMPILER_HEADERS += compiler/hlp.bi
COMPILER_HEADERS += compiler/hlp-str.bi
COMPILER_HEADERS += compiler/ir.bi
COMPILER_HEADERS += compiler/lex.bi
COMPILER_HEADERS += compiler/list.bi
COMPILER_HEADERS += compiler/parser.bi
COMPILER_HEADERS += compiler/pool.bi
COMPILER_HEADERS += compiler/pp.bi
COMPILER_HEADERS += compiler/reg.bi
COMPILER_HEADERS += compiler/rtl.bi
COMPILER_HEADERS += compiler/stabs.bi
COMPILER_HEADERS += compiler/stack.bi
COMPILER_HEADERS += compiler/symb.bi

# Auto-generated from compiler/config.bi.in
COMPILER_HEADERS += compiler/config.bi

COMPILER_OBJECTS += compiler/ast.o
COMPILER_OBJECTS += compiler/ast-gosub.o
COMPILER_OBJECTS += compiler/ast-helper.o
COMPILER_OBJECTS += compiler/ast-misc.o
COMPILER_OBJECTS += compiler/ast-node-addr.o
COMPILER_OBJECTS += compiler/ast-node-arg.o
COMPILER_OBJECTS += compiler/ast-node-assign.o
COMPILER_OBJECTS += compiler/ast-node-bop.o
COMPILER_OBJECTS += compiler/ast-node-branch.o
COMPILER_OBJECTS += compiler/ast-node-call.o
COMPILER_OBJECTS += compiler/ast-node-check.o
COMPILER_OBJECTS += compiler/ast-node-const.o
COMPILER_OBJECTS += compiler/ast-node-conv.o
COMPILER_OBJECTS += compiler/ast-node-data.o
COMPILER_OBJECTS += compiler/ast-node-decl.o
COMPILER_OBJECTS += compiler/ast-node-enum.o
COMPILER_OBJECTS += compiler/ast-node-field.o
COMPILER_OBJECTS += compiler/ast-node-idx.o
COMPILER_OBJECTS += compiler/ast-node-iif.o
COMPILER_OBJECTS += compiler/ast-node-link.o
COMPILER_OBJECTS += compiler/ast-node-load.o
COMPILER_OBJECTS += compiler/ast-node-mem.o
COMPILER_OBJECTS += compiler/ast-node-misc.o
COMPILER_OBJECTS += compiler/ast-node-namespace.o
COMPILER_OBJECTS += compiler/ast-node-proc.o
COMPILER_OBJECTS += compiler/ast-node-ptr.o
COMPILER_OBJECTS += compiler/ast-node-scope.o
COMPILER_OBJECTS += compiler/ast-node-stack.o
COMPILER_OBJECTS += compiler/ast-node-typeini.o
COMPILER_OBJECTS += compiler/ast-node-uop.o
COMPILER_OBJECTS += compiler/ast-node-var.o
COMPILER_OBJECTS += compiler/ast-optimize.o
COMPILER_OBJECTS += compiler/ast-vectorize.o
COMPILER_OBJECTS += compiler/clist.o
COMPILER_OBJECTS += compiler/dstr.o
COMPILER_OBJECTS += compiler/edbg_stab.o
COMPILER_OBJECTS += compiler/emit.o
COMPILER_OBJECTS += compiler/emit_SSE.o
COMPILER_OBJECTS += compiler/emit_x86.o
COMPILER_OBJECTS += compiler/error.o
COMPILER_OBJECTS += compiler/fb.o
COMPILER_OBJECTS += compiler/fbc.o
COMPILER_OBJECTS += compiler/fbc_cyg.o
COMPILER_OBJECTS += compiler/fbc_darwin.o
COMPILER_OBJECTS += compiler/fbc_dos.o
COMPILER_OBJECTS += compiler/fbc_freebsd.o
COMPILER_OBJECTS += compiler/fbc_linux.o
COMPILER_OBJECTS += compiler/fbc_netbsd.o
COMPILER_OBJECTS += compiler/fbc_openbsd.o
COMPILER_OBJECTS += compiler/fbc_win32.o
COMPILER_OBJECTS += compiler/fbc_xbox.o
COMPILER_OBJECTS += compiler/fb-main.o
COMPILER_OBJECTS += compiler/fb-objinfo.o
COMPILER_OBJECTS += compiler/flist.o
COMPILER_OBJECTS += compiler/hash.o
COMPILER_OBJECTS += compiler/hlp.o
COMPILER_OBJECTS += compiler/hlp-str.o
COMPILER_OBJECTS += compiler/ir.o
COMPILER_OBJECTS += compiler/ir-hlc.o
COMPILER_OBJECTS += compiler/ir-tac.o
COMPILER_OBJECTS += compiler/lex.o
COMPILER_OBJECTS += compiler/lex-utf.o
COMPILER_OBJECTS += compiler/list.o
COMPILER_OBJECTS += compiler/parser-assignment.o
COMPILER_OBJECTS += compiler/parser-comment.o
COMPILER_OBJECTS += compiler/parser-compound.o
COMPILER_OBJECTS += compiler/parser-compound-do.o
COMPILER_OBJECTS += compiler/parser-compound-extern.o
COMPILER_OBJECTS += compiler/parser-compound-for.o
COMPILER_OBJECTS += compiler/parser-compound-if.o
COMPILER_OBJECTS += compiler/parser-compound-namespace.o
COMPILER_OBJECTS += compiler/parser-compound-scope.o
COMPILER_OBJECTS += compiler/parser-compound-select.o
COMPILER_OBJECTS += compiler/parser-compound-select-const.o
COMPILER_OBJECTS += compiler/parser-compound-while.o
COMPILER_OBJECTS += compiler/parser-compound-with.o
COMPILER_OBJECTS += compiler/parser-decl.o
COMPILER_OBJECTS += compiler/parser-decl-const.o
COMPILER_OBJECTS += compiler/parser-decl-def.o
COMPILER_OBJECTS += compiler/parser-decl-enum.o
COMPILER_OBJECTS += compiler/parser-decl-option.o
COMPILER_OBJECTS += compiler/parser-decl-proc.o
COMPILER_OBJECTS += compiler/parser-decl-proc-params.o
COMPILER_OBJECTS += compiler/parser-decl-struct.o
COMPILER_OBJECTS += compiler/parser-decl-symb-init.o
COMPILER_OBJECTS += compiler/parser-decl-symbtype.o
COMPILER_OBJECTS += compiler/parser-decl-typedef.o
COMPILER_OBJECTS += compiler/parser-decl-var.o
COMPILER_OBJECTS += compiler/parser-expr-atom.o
COMPILER_OBJECTS += compiler/parser-expr-binary.o
COMPILER_OBJECTS += compiler/parser-expr-constant.o
COMPILER_OBJECTS += compiler/parser-expr-function.o
COMPILER_OBJECTS += compiler/parser-expr-unary.o
COMPILER_OBJECTS += compiler/parser-expr-variable.o
COMPILER_OBJECTS += compiler/parser-identifier.o
COMPILER_OBJECTS += compiler/parser-inlineasm.o
COMPILER_OBJECTS += compiler/parser-label.o
COMPILER_OBJECTS += compiler/parser-proc.o
COMPILER_OBJECTS += compiler/parser-proccall-args.o
COMPILER_OBJECTS += compiler/parser-proccall.o
COMPILER_OBJECTS += compiler/parser-quirk-array.o
COMPILER_OBJECTS += compiler/parser-quirk.o
COMPILER_OBJECTS += compiler/parser-quirk-casting.o
COMPILER_OBJECTS += compiler/parser-quirk-console.o
COMPILER_OBJECTS += compiler/parser-quirk-data.o
COMPILER_OBJECTS += compiler/parser-quirk-error.o
COMPILER_OBJECTS += compiler/parser-quirk-file.o
COMPILER_OBJECTS += compiler/parser-quirk-gfx.o
COMPILER_OBJECTS += compiler/parser-quirk-goto-return.o
COMPILER_OBJECTS += compiler/parser-quirk-iif.o
COMPILER_OBJECTS += compiler/parser-quirk-math.o
COMPILER_OBJECTS += compiler/parser-quirk-mem.o
COMPILER_OBJECTS += compiler/parser-quirk-on.o
COMPILER_OBJECTS += compiler/parser-quirk-peekpoke.o
COMPILER_OBJECTS += compiler/parser-quirk-string.o
COMPILER_OBJECTS += compiler/parser-quirk-vafirst.o
COMPILER_OBJECTS += compiler/parser-statement.o
COMPILER_OBJECTS += compiler/parser-toplevel.o
COMPILER_OBJECTS += compiler/pool.o
COMPILER_OBJECTS += compiler/pp.o
COMPILER_OBJECTS += compiler/pp-cond.o
COMPILER_OBJECTS += compiler/pp-define.o
COMPILER_OBJECTS += compiler/pp-pragma.o
COMPILER_OBJECTS += compiler/reg.o
COMPILER_OBJECTS += compiler/rtl-array.o
COMPILER_OBJECTS += compiler/rtl.o
COMPILER_OBJECTS += compiler/rtl-console.o
COMPILER_OBJECTS += compiler/rtl-data.o
COMPILER_OBJECTS += compiler/rtl-error.o
COMPILER_OBJECTS += compiler/rtl-file.o
COMPILER_OBJECTS += compiler/rtl-gfx.o
COMPILER_OBJECTS += compiler/rtl-gosub.o
COMPILER_OBJECTS += compiler/rtl-macro.o
COMPILER_OBJECTS += compiler/rtl-math.o
COMPILER_OBJECTS += compiler/rtl-mem.o
COMPILER_OBJECTS += compiler/rtl-print.o
COMPILER_OBJECTS += compiler/rtl-profile.o
COMPILER_OBJECTS += compiler/rtl-string.o
COMPILER_OBJECTS += compiler/rtl-system.o
COMPILER_OBJECTS += compiler/stack.o
COMPILER_OBJECTS += compiler/symb.o
COMPILER_OBJECTS += compiler/symb-bitfield.o
COMPILER_OBJECTS += compiler/symb-comp.o
COMPILER_OBJECTS += compiler/symb-const.o
COMPILER_OBJECTS += compiler/symb-data.o
COMPILER_OBJECTS += compiler/symb-define.o
COMPILER_OBJECTS += compiler/symb-enum.o
COMPILER_OBJECTS += compiler/symb-keyword.o
COMPILER_OBJECTS += compiler/symb-label.o
COMPILER_OBJECTS += compiler/symb-lib.o
COMPILER_OBJECTS += compiler/symb-mangling.o
COMPILER_OBJECTS += compiler/symb-namespace.o
COMPILER_OBJECTS += compiler/symb-proc.o
COMPILER_OBJECTS += compiler/symb-scope.o
COMPILER_OBJECTS += compiler/symb-struct.o
COMPILER_OBJECTS += compiler/symb-typedef.o
COMPILER_OBJECTS += compiler/symb-var.o

COMPILER_C_OBJECTS :=
ifndef DISABLE_OBJINFO
	ifndef ENABLE_FBBFD
		COMPILER_C_OBJECTS += c-objinfo.o
	endif
endif

RUNTIME_HEADERS :=
RUNTIME_OBJECTS :=
RUNTIME_S_OBJECTS :=

RUNTIME_HEADERS += runtime/config.h
RUNTIME_HEADERS += runtime/fb_array.h
RUNTIME_HEADERS += runtime/fb_colors.h
RUNTIME_HEADERS += runtime/fb_config.h
RUNTIME_HEADERS += runtime/fb_con.h
RUNTIME_HEADERS += runtime/fb_console.h
RUNTIME_HEADERS += runtime/fb_data.h
RUNTIME_HEADERS += runtime/fb_datetime.h
RUNTIME_HEADERS += runtime/fb_device.h
RUNTIME_HEADERS += runtime/fb_error.h
RUNTIME_HEADERS += runtime/fb_file.h
RUNTIME_HEADERS += runtime/fb.h
RUNTIME_HEADERS += runtime/fb_hook.h
RUNTIME_HEADERS += runtime/fb_intern.h
RUNTIME_HEADERS += runtime/fb_math.h
RUNTIME_HEADERS += runtime/fb_port.h
RUNTIME_HEADERS += runtime/fb_printer.h
RUNTIME_HEADERS += runtime/fb_scancodes.h
RUNTIME_HEADERS += runtime/fb_serial.h
RUNTIME_HEADERS += runtime/fb_string.h
RUNTIME_HEADERS += runtime/fb_system.h
RUNTIME_HEADERS += runtime/fb_thread.h
RUNTIME_HEADERS += runtime/fb_unicode.h
RUNTIME_HEADERS += runtime/libfb_con_print_raw_uni.h
RUNTIME_HEADERS += runtime/libfb_con_print_tty_uni.h

RUNTIME_OBJECTS += runtime/libfb_array_boundchk.o
RUNTIME_OBJECTS += runtime/libfb_array_clear.o
RUNTIME_OBJECTS += runtime/libfb_array_clear_obj.o
RUNTIME_OBJECTS += runtime/libfb_array_core.o
RUNTIME_OBJECTS += runtime/libfb_array_erase.o
RUNTIME_OBJECTS += runtime/libfb_array_erase_obj.o
RUNTIME_OBJECTS += runtime/libfb_array_erasestr.o
RUNTIME_OBJECTS += runtime/libfb_array_lbound.o
RUNTIME_OBJECTS += runtime/libfb_array_redim.o
RUNTIME_OBJECTS += runtime/libfb_array_redim_obj.o
RUNTIME_OBJECTS += runtime/libfb_array_redimpresv.o
RUNTIME_OBJECTS += runtime/libfb_array_redimpresv_obj.o
RUNTIME_OBJECTS += runtime/libfb_array_resetdesc.o
RUNTIME_OBJECTS += runtime/libfb_array_setdesc.o
RUNTIME_OBJECTS += runtime/libfb_array_tmpdesc.o
RUNTIME_OBJECTS += runtime/libfb_array_ubound.o
RUNTIME_OBJECTS += runtime/libfb_assert.o
RUNTIME_OBJECTS += runtime/libfb_assert_wstr.o
RUNTIME_OBJECTS += runtime/libfb_con_lineinp.o
RUNTIME_OBJECTS += runtime/libfb_con_lineinp_wstr.o
RUNTIME_OBJECTS += runtime/libfb_con_locate.o
RUNTIME_OBJECTS += runtime/libfb_con_pos.o
RUNTIME_OBJECTS += runtime/libfb_con_print_raw.o
RUNTIME_OBJECTS += runtime/libfb_con_print_raw_wstr.o
RUNTIME_OBJECTS += runtime/libfb_con_print_tty.o
RUNTIME_OBJECTS += runtime/libfb_con_print_tty_wstr.o
RUNTIME_OBJECTS += runtime/libfb_con_readline.o
RUNTIME_OBJECTS += runtime/libfb_data.o
RUNTIME_OBJECTS += runtime/libfb_data_readbyte.o
RUNTIME_OBJECTS += runtime/libfb_data_readdouble.o
RUNTIME_OBJECTS += runtime/libfb_data_readint.o
RUNTIME_OBJECTS += runtime/libfb_data_readlong.o
RUNTIME_OBJECTS += runtime/libfb_data_readshort.o
RUNTIME_OBJECTS += runtime/libfb_data_readsingle.o
RUNTIME_OBJECTS += runtime/libfb_data_readstr.o
RUNTIME_OBJECTS += runtime/libfb_data_readubyte.o
RUNTIME_OBJECTS += runtime/libfb_data_readuint.o
RUNTIME_OBJECTS += runtime/libfb_data_readulong.o
RUNTIME_OBJECTS += runtime/libfb_data_readushort.o
RUNTIME_OBJECTS += runtime/libfb_data_read_wstr.o
RUNTIME_OBJECTS += runtime/libfb_data_rest.o
RUNTIME_OBJECTS += runtime/libfb_dev_com.o
RUNTIME_OBJECTS += runtime/libfb_dev_com_test.o
RUNTIME_OBJECTS += runtime/libfb_dev_cons_open.o
RUNTIME_OBJECTS += runtime/libfb_dev_err_open.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_close.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_open.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_read.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_read_core.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_readline.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_readline_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_read_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_write.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_encod_write_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_eof.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_flush.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_lock.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_open.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_read.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_readline.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_readline_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_read_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_seek.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_size.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_tell.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_unlock.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_write.o
RUNTIME_OBJECTS += runtime/libfb_dev_file_write_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_lpt.o
RUNTIME_OBJECTS += runtime/libfb_dev_lpt_close.o
RUNTIME_OBJECTS += runtime/libfb_dev_lpt_test.o
RUNTIME_OBJECTS += runtime/libfb_dev_lpt_write.o
RUNTIME_OBJECTS += runtime/libfb_dev_lpt_write_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_close.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_eof.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_init.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_read.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_readline.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_readline_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_read_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_write.o
RUNTIME_OBJECTS += runtime/libfb_dev_scrn_write_wstr.o
RUNTIME_OBJECTS += runtime/libfb_dev_stdio_close.o
RUNTIME_OBJECTS += runtime/libfb_error.o
RUNTIME_OBJECTS += runtime/libfb_error_getset.o
RUNTIME_OBJECTS += runtime/libfb_error_ptrchk.o
RUNTIME_OBJECTS += runtime/libfb_exit.o
RUNTIME_OBJECTS += runtime/libfb_file_attr.o
RUNTIME_OBJECTS += runtime/libfb_file_close.o
RUNTIME_OBJECTS += runtime/libfb_file_copy.o
RUNTIME_OBJECTS += runtime/libfb_file_datetime.o
RUNTIME_OBJECTS += runtime/libfb_file_encod.o
RUNTIME_OBJECTS += runtime/libfb_file_eof.o
RUNTIME_OBJECTS += runtime/libfb_file_exists.o
RUNTIME_OBJECTS += runtime/libfb_file_free.o
RUNTIME_OBJECTS += runtime/libfb_file_getarray.o
RUNTIME_OBJECTS += runtime/libfb_file_get.o
RUNTIME_OBJECTS += runtime/libfb_file_getstr.o
RUNTIME_OBJECTS += runtime/libfb_file_get_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_input_byte.o
RUNTIME_OBJECTS += runtime/libfb_file_input_con.o
RUNTIME_OBJECTS += runtime/libfb_file_input_file.o
RUNTIME_OBJECTS += runtime/libfb_file_input_float.o
RUNTIME_OBJECTS += runtime/libfb_file_input_int.o
RUNTIME_OBJECTS += runtime/libfb_file_input_longint.o
RUNTIME_OBJECTS += runtime/libfb_file_input_short.o
RUNTIME_OBJECTS += runtime/libfb_file_input_str.o
RUNTIME_OBJECTS += runtime/libfb_file_inputstr.o
RUNTIME_OBJECTS += runtime/libfb_file_input_tok.o
RUNTIME_OBJECTS += runtime/libfb_file_input_tok_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_input_ubyte.o
RUNTIME_OBJECTS += runtime/libfb_file_input_uint.o
RUNTIME_OBJECTS += runtime/libfb_file_input_ulongint.o
RUNTIME_OBJECTS += runtime/libfb_file_input_ushort.o
RUNTIME_OBJECTS += runtime/libfb_file_input_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_kill.o
RUNTIME_OBJECTS += runtime/libfb_file_len.o
RUNTIME_OBJECTS += runtime/libfb_file_lineinp.o
RUNTIME_OBJECTS += runtime/libfb_file_lineinp_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_loc.o
RUNTIME_OBJECTS += runtime/libfb_file_lock.o
RUNTIME_OBJECTS += runtime/libfb_file_open.o
RUNTIME_OBJECTS += runtime/libfb_file_opencom.o
RUNTIME_OBJECTS += runtime/libfb_file_opencons.o
RUNTIME_OBJECTS += runtime/libfb_file_openencod.o
RUNTIME_OBJECTS += runtime/libfb_file_openerr.o
RUNTIME_OBJECTS += runtime/libfb_file_openlpt.o
RUNTIME_OBJECTS += runtime/libfb_file_openpipe.o
RUNTIME_OBJECTS += runtime/libfb_file_openscrn.o
RUNTIME_OBJECTS += runtime/libfb_file_openshort.o
RUNTIME_OBJECTS += runtime/libfb_file_print.o
RUNTIME_OBJECTS += runtime/libfb_file_print_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_putarray.o
RUNTIME_OBJECTS += runtime/libfb_file_putback.o
RUNTIME_OBJECTS += runtime/libfb_file_putback_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_put.o
RUNTIME_OBJECTS += runtime/libfb_file_putstr.o
RUNTIME_OBJECTS += runtime/libfb_file_put_wstr.o
RUNTIME_OBJECTS += runtime/libfb_file_reset.o
RUNTIME_OBJECTS += runtime/libfb_file_seek.o
RUNTIME_OBJECTS += runtime/libfb_file_size.o
RUNTIME_OBJECTS += runtime/libfb_file_tell.o
RUNTIME_OBJECTS += runtime/libfb_file_winputstr.o
RUNTIME_OBJECTS += runtime/libfb_gosub.o
RUNTIME_OBJECTS += runtime/libfb_hook_cls.o
RUNTIME_OBJECTS += runtime/libfb_hook_color.o
RUNTIME_OBJECTS += runtime/libfb_hook_getsize.o
RUNTIME_OBJECTS += runtime/libfb_hook_getx.o
RUNTIME_OBJECTS += runtime/libfb_hook_getxy.o
RUNTIME_OBJECTS += runtime/libfb_hook_gety.o
RUNTIME_OBJECTS += runtime/libfb_hook_inkey.o
RUNTIME_OBJECTS += runtime/libfb_hook_isredir.o
RUNTIME_OBJECTS += runtime/libfb_hook_lineinp.o
RUNTIME_OBJECTS += runtime/libfb_hook_lineinp_wstr.o
RUNTIME_OBJECTS += runtime/libfb_hook_locate_ex.o
RUNTIME_OBJECTS += runtime/libfb_hook_mouse.o
RUNTIME_OBJECTS += runtime/libfb_hook_multikey.o
RUNTIME_OBJECTS += runtime/libfb_hook_pageset.o
RUNTIME_OBJECTS += runtime/libfb_hook_pcopy.o
RUNTIME_OBJECTS += runtime/libfb_hook_ports.o
RUNTIME_OBJECTS += runtime/libfb_hook_printstr.o
RUNTIME_OBJECTS += runtime/libfb_hook_print_wstr.o
RUNTIME_OBJECTS += runtime/libfb_hook_readstr.o
RUNTIME_OBJECTS += runtime/libfb_hook_readxy.o
RUNTIME_OBJECTS += runtime/libfb_hook_sleep.o
RUNTIME_OBJECTS += runtime/libfb_hook_view_update.o
RUNTIME_OBJECTS += runtime/libfb_hook_width.o
RUNTIME_OBJECTS += runtime/libfb_init.o
RUNTIME_OBJECTS += runtime/libfb_intl_get.o
RUNTIME_OBJECTS += runtime/libfb_intl_getdateformat.o
RUNTIME_OBJECTS += runtime/libfb_intl_getmonthname.o
RUNTIME_OBJECTS += runtime/libfb_intl_getset.o
RUNTIME_OBJECTS += runtime/libfb_intl_gettimeformat.o
RUNTIME_OBJECTS += runtime/libfb_intl_getweekdayname.o
RUNTIME_OBJECTS += runtime/libfb_io_lpos.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_byte.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_fix.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_fp.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_int.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_longint.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_short.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_str.o
RUNTIME_OBJECTS += runtime/libfb_io_lprintusg.o
RUNTIME_OBJECTS += runtime/libfb_io_lprintvoid.o
RUNTIME_OBJECTS += runtime/libfb_io_lprint_wstr.o
RUNTIME_OBJECTS += runtime/libfb_io_print_byte.o
RUNTIME_OBJECTS += runtime/libfb_io_print.o
RUNTIME_OBJECTS += runtime/libfb_io_print_fix.o
RUNTIME_OBJECTS += runtime/libfb_io_print_fp.o
RUNTIME_OBJECTS += runtime/libfb_io_print_int.o
RUNTIME_OBJECTS += runtime/libfb_io_print_longint.o
RUNTIME_OBJECTS += runtime/libfb_io_printpad.o
RUNTIME_OBJECTS += runtime/libfb_io_printpad_wstr.o
RUNTIME_OBJECTS += runtime/libfb_io_print_short.o
RUNTIME_OBJECTS += runtime/libfb_io_printusg.o
RUNTIME_OBJECTS += runtime/libfb_io_printvoid.o
RUNTIME_OBJECTS += runtime/libfb_io_printvoid_wstr.o
RUNTIME_OBJECTS += runtime/libfb_io_print_wstr.o
RUNTIME_OBJECTS += runtime/libfb_io_setpos.o
RUNTIME_OBJECTS += runtime/libfb_io_spc.o
RUNTIME_OBJECTS += runtime/libfb_io_view.o
RUNTIME_OBJECTS += runtime/libfb_io_viewhlp.o
RUNTIME_OBJECTS += runtime/libfb_io_widthdev.o
RUNTIME_OBJECTS += runtime/libfb_io_widthfile.o
RUNTIME_OBJECTS += runtime/libfb_io_writebyte.o
RUNTIME_OBJECTS += runtime/libfb_io_writefloat.o
RUNTIME_OBJECTS += runtime/libfb_io_writeint.o
RUNTIME_OBJECTS += runtime/libfb_io_writelongint.o
RUNTIME_OBJECTS += runtime/libfb_io_writeshort.o
RUNTIME_OBJECTS += runtime/libfb_io_writestr.o
RUNTIME_OBJECTS += runtime/libfb_io_writevoid.o
RUNTIME_OBJECTS += runtime/libfb_io_write_wstr.o
RUNTIME_OBJECTS += runtime/libfb_list.o
RUNTIME_OBJECTS += runtime/libfb_listdyn.o
RUNTIME_OBJECTS += runtime/libfb_math_fix.o
RUNTIME_OBJECTS += runtime/libfb_math_frac.o
RUNTIME_OBJECTS += runtime/libfb_math_rnd.o
RUNTIME_OBJECTS += runtime/libfb_math_sgn.o
RUNTIME_OBJECTS += runtime/libfb_mem_copyclear.o
RUNTIME_OBJECTS += runtime/libfb_qb_file_open.o
RUNTIME_OBJECTS += runtime/libfb_qb_inkey.o
RUNTIME_OBJECTS += runtime/libfb_qb_sleep.o
RUNTIME_OBJECTS += runtime/libfb_qb_str_convto.o
RUNTIME_OBJECTS += runtime/libfb_qb_str_convto_flt.o
RUNTIME_OBJECTS += runtime/libfb_qb_str_convto_lng.o
RUNTIME_OBJECTS += runtime/libfb_signals.o
RUNTIME_OBJECTS += runtime/libfb_str_asc.o
RUNTIME_OBJECTS += runtime/libfb_str_assign.o
RUNTIME_OBJECTS += runtime/libfb_str_base.o
RUNTIME_OBJECTS += runtime/libfb_str_bin.o
RUNTIME_OBJECTS += runtime/libfb_str_bin_lng.o
RUNTIME_OBJECTS += runtime/libfb_str_chr.o
RUNTIME_OBJECTS += runtime/libfb_str_comp.o
RUNTIME_OBJECTS += runtime/libfb_str_concatassign.o
RUNTIME_OBJECTS += runtime/libfb_str_concat.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom_int.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom_lng.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom_rad.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom_radlng.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom_uint.o
RUNTIME_OBJECTS += runtime/libfb_str_convfrom_ulng.o
RUNTIME_OBJECTS += runtime/libfb_str_convto.o
RUNTIME_OBJECTS += runtime/libfb_str_convto_flt.o
RUNTIME_OBJECTS += runtime/libfb_str_convto_lng.o
RUNTIME_OBJECTS += runtime/libfb_str_core.o
RUNTIME_OBJECTS += runtime/libfb_str_cvmk.o
RUNTIME_OBJECTS += runtime/libfb_str_del.o
RUNTIME_OBJECTS += runtime/libfb_str_fill.o
RUNTIME_OBJECTS += runtime/libfb_str_format.o
RUNTIME_OBJECTS += runtime/libfb_str_ftoa.o
RUNTIME_OBJECTS += runtime/libfb_str_hex.o
RUNTIME_OBJECTS += runtime/libfb_str_hex_lng.o
RUNTIME_OBJECTS += runtime/libfb_str_instrany.o
RUNTIME_OBJECTS += runtime/libfb_str_instr.o
RUNTIME_OBJECTS += runtime/libfb_str_instrrevany.o
RUNTIME_OBJECTS += runtime/libfb_str_instrrev.o
RUNTIME_OBJECTS += runtime/libfb_str_lcase.o
RUNTIME_OBJECTS += runtime/libfb_str_left.o
RUNTIME_OBJECTS += runtime/libfb_str_len.o
RUNTIME_OBJECTS += runtime/libfb_str_ltrimany.o
RUNTIME_OBJECTS += runtime/libfb_str_ltrim.o
RUNTIME_OBJECTS += runtime/libfb_str_ltrimex.o
RUNTIME_OBJECTS += runtime/libfb_str_midassign.o
RUNTIME_OBJECTS += runtime/libfb_str_mid.o
RUNTIME_OBJECTS += runtime/libfb_str_misc.o
RUNTIME_OBJECTS += runtime/libfb_str_oct.o
RUNTIME_OBJECTS += runtime/libfb_str_oct_lng.o
RUNTIME_OBJECTS += runtime/libfb_str_right.o
RUNTIME_OBJECTS += runtime/libfb_str_rtrimany.o
RUNTIME_OBJECTS += runtime/libfb_str_rtrim.o
RUNTIME_OBJECTS += runtime/libfb_str_rtrimex.o
RUNTIME_OBJECTS += runtime/libfb_str_set.o
RUNTIME_OBJECTS += runtime/libfb_str_tempdescf.o
RUNTIME_OBJECTS += runtime/libfb_str_tempdescv.o
RUNTIME_OBJECTS += runtime/libfb_str_tempdescz.o
RUNTIME_OBJECTS += runtime/libfb_str_tempres.o
RUNTIME_OBJECTS += runtime/libfb_str_trimany.o
RUNTIME_OBJECTS += runtime/libfb_str_trim.o
RUNTIME_OBJECTS += runtime/libfb_str_trimex.o
RUNTIME_OBJECTS += runtime/libfb_str_ucase.o
RUNTIME_OBJECTS += runtime/libfb_strw_alloc.o
RUNTIME_OBJECTS += runtime/libfb_strw_asc.o
RUNTIME_OBJECTS += runtime/libfb_strw_assign.o
RUNTIME_OBJECTS += runtime/libfb_strw_bin.o
RUNTIME_OBJECTS += runtime/libfb_strw_bin_lng.o
RUNTIME_OBJECTS += runtime/libfb_strw_chr.o
RUNTIME_OBJECTS += runtime/libfb_strw_comp.o
RUNTIME_OBJECTS += runtime/libfb_strw_concatassign.o
RUNTIME_OBJECTS += runtime/libfb_strw_concat.o
RUNTIME_OBJECTS += runtime/libfb_strw_convassign.o
RUNTIME_OBJECTS += runtime/libfb_strw_convconcat.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_int.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_lng.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_rad.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_radlng.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_str.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_uint.o
RUNTIME_OBJECTS += runtime/libfb_strw_convfrom_ulng.o
RUNTIME_OBJECTS += runtime/libfb_strw_convto.o
RUNTIME_OBJECTS += runtime/libfb_strw_convto_flt.o
RUNTIME_OBJECTS += runtime/libfb_strw_convto_lng.o
RUNTIME_OBJECTS += runtime/libfb_strw_convto_str.o
RUNTIME_OBJECTS += runtime/libfb_strw_del.o
RUNTIME_OBJECTS += runtime/libfb_strw_fill.o
RUNTIME_OBJECTS += runtime/libfb_strw_ftoa.o
RUNTIME_OBJECTS += runtime/libfb_strw_hex.o
RUNTIME_OBJECTS += runtime/libfb_strw_hex_lng.o
RUNTIME_OBJECTS += runtime/libfb_strw_instrany.o
RUNTIME_OBJECTS += runtime/libfb_strw_instr.o
RUNTIME_OBJECTS += runtime/libfb_strw_instrrevany.o
RUNTIME_OBJECTS += runtime/libfb_strw_instrrev.o
RUNTIME_OBJECTS += runtime/libfb_strw_lcase.o
RUNTIME_OBJECTS += runtime/libfb_strw_left.o
RUNTIME_OBJECTS += runtime/libfb_strw_len.o
RUNTIME_OBJECTS += runtime/libfb_strw_ltrimany.o
RUNTIME_OBJECTS += runtime/libfb_strw_ltrim.o
RUNTIME_OBJECTS += runtime/libfb_strw_ltrimex.o
RUNTIME_OBJECTS += runtime/libfb_strw_midassign.o
RUNTIME_OBJECTS += runtime/libfb_strw_mid.o
RUNTIME_OBJECTS += runtime/libfb_strw_oct.o
RUNTIME_OBJECTS += runtime/libfb_strw_oct_lng.o
RUNTIME_OBJECTS += runtime/libfb_strw_right.o
RUNTIME_OBJECTS += runtime/libfb_strw_rtrimany.o
RUNTIME_OBJECTS += runtime/libfb_strw_rtrim.o
RUNTIME_OBJECTS += runtime/libfb_strw_rtrimex.o
RUNTIME_OBJECTS += runtime/libfb_strw_set.o
RUNTIME_OBJECTS += runtime/libfb_strw_space.o
RUNTIME_OBJECTS += runtime/libfb_strw_trimany.o
RUNTIME_OBJECTS += runtime/libfb_strw_trim.o
RUNTIME_OBJECTS += runtime/libfb_strw_trimex.o
RUNTIME_OBJECTS += runtime/libfb_strw_ucase.o
RUNTIME_OBJECTS += runtime/libfb_swap_mem.o
RUNTIME_OBJECTS += runtime/libfb_swap_str.o
RUNTIME_OBJECTS += runtime/libfb_swap_wstr.o
RUNTIME_OBJECTS += runtime/libfb_sys_beep.o
RUNTIME_OBJECTS += runtime/libfb_sys_cdir.o
RUNTIME_OBJECTS += runtime/libfb_sys_chain.o
RUNTIME_OBJECTS += runtime/libfb_sys_chdir.o
RUNTIME_OBJECTS += runtime/libfb_sys_cmd.o
RUNTIME_OBJECTS += runtime/libfb_sys_environ.o
RUNTIME_OBJECTS += runtime/libfb_sys_exec_core.o
RUNTIME_OBJECTS += runtime/libfb_sys_exepath.o
RUNTIME_OBJECTS += runtime/libfb_sys_mkdir.o
RUNTIME_OBJECTS += runtime/libfb_sys_rmdir.o
RUNTIME_OBJECTS += runtime/libfb_sys_run.o
RUNTIME_OBJECTS += runtime/libfb_thread_ctx.o
RUNTIME_OBJECTS += runtime/libfb_time_core.o
RUNTIME_OBJECTS += runtime/libfb_time_dateadd.o
RUNTIME_OBJECTS += runtime/libfb_time_date.o
RUNTIME_OBJECTS += runtime/libfb_time_datediff.o
RUNTIME_OBJECTS += runtime/libfb_time_datepart.o
RUNTIME_OBJECTS += runtime/libfb_time_dateserial.o
RUNTIME_OBJECTS += runtime/libfb_time_dateset.o
RUNTIME_OBJECTS += runtime/libfb_time_datevalue.o
RUNTIME_OBJECTS += runtime/libfb_time_decodeserdate.o
RUNTIME_OBJECTS += runtime/libfb_time_decodesertime.o
RUNTIME_OBJECTS += runtime/libfb_time_isdate.o
RUNTIME_OBJECTS += runtime/libfb_time_monthname.o
RUNTIME_OBJECTS += runtime/libfb_time_now.o
RUNTIME_OBJECTS += runtime/libfb_time_parsedate.o
RUNTIME_OBJECTS += runtime/libfb_time_parsedatetime.o
RUNTIME_OBJECTS += runtime/libfb_time_parsetime.o
RUNTIME_OBJECTS += runtime/libfb_time_sleepex.o
RUNTIME_OBJECTS += runtime/libfb_time_time.o
RUNTIME_OBJECTS += runtime/libfb_time_timeserial.o
RUNTIME_OBJECTS += runtime/libfb_time_timeset.o
RUNTIME_OBJECTS += runtime/libfb_time_timevalue.o
RUNTIME_OBJECTS += runtime/libfb_time_week.o
RUNTIME_OBJECTS += runtime/libfb_time_weekdayname.o
RUNTIME_OBJECTS += runtime/libfb_utf_convfrom_char.o
RUNTIME_OBJECTS += runtime/libfb_utf_convfrom_wchar.o
RUNTIME_OBJECTS += runtime/libfb_utf_convto_char.o
RUNTIME_OBJECTS += runtime/libfb_utf_convto_wchar.o
RUNTIME_OBJECTS += runtime/libfb_utf_core.o
RUNTIME_OBJECTS += runtime/libfb_vfs_open.o

ifndef DISABLE_GFX
	RUNTIME_HEADERS += runtime/fb_gfx_data.h
	RUNTIME_HEADERS += runtime/fb_gfx_gl.h
	RUNTIME_HEADERS += runtime/fb_gfx.h
	RUNTIME_HEADERS += runtime/fb_gfx_lzw.h
	RUNTIME_HEADERS += runtime/libfb_gfx_data.h

	RUNTIME_OBJECTS += runtime/libfb_gfx_access.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_blitter.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_bload.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_box.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_bsave.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_circle.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_cls.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_color.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_control.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_core.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_data.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_draw.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_drawstring.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_null.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_event.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_get.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_getmouse.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_image.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_image_convert.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_image_info.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_inkey.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_line.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_lineinp.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_lineinp_wstr.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_lzw.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_lzw_enc.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_multikey.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_page.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_paint.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_palette.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_paletteget.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_pmap.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_point.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_print.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_print_wstr.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_pset.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_add.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_alpha.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_and.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_blend.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_custom.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_or.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_preset.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_pset.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_trans.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_put_xor.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_readstr.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_readxy.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_screen.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_screeninfo.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_screenlist.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_setmouse.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_sleep.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_softcursor.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_stick.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_vars.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_vgaemu.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_view.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_vsync.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_width.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_window.o
endif

ifeq ($(HOST_OS),dos)
	RUNTIME_HEADERS += runtime/fb_dos.h
	RUNTIME_HEADERS += runtime/fb_gfx_dos.h
	RUNTIME_HEADERS += runtime/fb_unicode_dos.h
	RUNTIME_HEADERS += runtime/vesa_dos.h
	RUNTIME_HEADERS += runtime/vga_dos.h
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_close_dos.o
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_open_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_file_copy_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_data_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_get_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getdateformat_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getmonthname_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_gettimeformat_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getweekdayname_dos.o
	RUNTIME_OBJECTS += runtime/libfb_drv_isr_dos.s
	RUNTIME_OBJECTS += runtime/libfb_farmemset_dos.o
	RUNTIME_OBJECTS += runtime/libfb_file_dir_dos.o
	RUNTIME_OBJECTS += runtime/libfb_file_hconvpath_dos.o
	RUNTIME_OBJECTS += runtime/libfb_file_hlock_dos.o
	RUNTIME_OBJECTS += runtime/libfb_file_resetex_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_dos_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_bios_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_modex_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_vesa_bnk_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_vesa_lin_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_vga_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_joystick_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_mouse_dos.s
	RUNTIME_OBJECTS += runtime/libfb_gfx_vesa_core_dos.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_vesa_dos.s
	RUNTIME_OBJECTS += runtime/libfb_hexit_dos.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_dos.o
	RUNTIME_OBJECTS += runtime/libfb_hsignals_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_cls_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_color_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_getsize_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_inkey_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_isredir_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_locate_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_maxrow_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_pageset_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_pcopy_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_wstr_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_printer_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_readstr_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_scroll_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_serial_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_viewupdate_dos.o
	RUNTIME_OBJECTS += runtime/libfb_io_width_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_beep_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_exec_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getcwd_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getshortpath_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_isr_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_ports_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_shell_dos.o
	RUNTIME_OBJECTS += runtime/libfb_sys_sleep_dos.o
	RUNTIME_OBJECTS += runtime/libfb_thread_cond_dos.o
	RUNTIME_OBJECTS += runtime/libfb_thread_core_dos.o
	RUNTIME_OBJECTS += runtime/libfb_thread_mutex_dos.o
	RUNTIME_OBJECTS += runtime/libfb_time_setdate_dos.o
	RUNTIME_OBJECTS += runtime/libfb_time_settime_dos.o
	RUNTIME_OBJECTS += runtime/libfb_time_sleep_dos.o
	RUNTIME_OBJECTS += runtime/libfb_time_tmr_dos.o
endif

ifeq ($(HOST_OS),freebsd)
	RUNTIME_OBJECTS += runtime/libfb_gfx_freebsd_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_joystick_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_hexit_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_freebsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_freebsd.o
endif

ifeq ($(HOST_OS),linux)
	RUNTIME_HEADERS += runtime/fb_gfx_linux.h
	RUNTIME_HEADERS += runtime/fb_linux.h
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_fbdev_linux.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_joystick_linux.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_linux_linux.o
	RUNTIME_OBJECTS += runtime/libfb_hexit_linux.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_linux.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_linux.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_linux.o
	RUNTIME_OBJECTS += runtime/libfb_io_serial_linux.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_linux.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_linux.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_linux.o
	RUNTIME_OBJECTS += runtime/libfb_sys_ports_linux.o
endif

ifeq ($(HOST_OS),netbsd)
	RUNTIME_OBJECTS += runtime/libfb_hexit_netbsd.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_netbsd.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_netbsd.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_netbsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_netbsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_netbsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_netbsd.o
endif

ifeq ($(HOST_OS),openbsd)
	RUNTIME_OBJECTS += runtime/libfb_gfx_joystick_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_openbsd_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_hexit_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_openbsd.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_openbsd.o
	RUNTIME_OBJECTS += runtime/swprintf_hack_openbsd.o
endif

ifeq ($(ENABLE_OPENGL),yes)
	RUNTIME_OBJECTS += runtime/libfb_gfx_opengl.o
	ifeq ($(HOST_GFXFAMILY),win32)
		RUNTIME_OBJECTS += runtime/libfb_gfx_driver_opengl_win32.o
	else ifeq ($(HOST_GFXFAMILY),x11)
		ifndef DISABLE_X
			RUNTIME_OBJECTS += runtime/libfb_gfx_driver_opengl_x11.o
		endif
	endif
endif

ifeq ($(HOST_OSFAMILY),unix)
	RUNTIME_HEADERS += fb_unix.h
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_close_unix.o
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_open_unix.o
	RUNTIME_OBJECTS += runtime/libfb_drv_file_copy_unix.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_get_unix.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getdateformat_unix.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getmonthname_unix.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_gettimeformat_unix.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getweekdayname_unix.o
	RUNTIME_OBJECTS += runtime/libfb_file_dir_unix.o
	RUNTIME_OBJECTS += runtime/libfb_file_hconvpath_unix.o
	RUNTIME_OBJECTS += runtime/libfb_file_hlock_unix.o
	RUNTIME_OBJECTS += runtime/libfb_file_resetex_unix.o
	RUNTIME_OBJECTS += runtime/libfb_hdynload_unix.o
	RUNTIME_OBJECTS += runtime/libfb_hsignals_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_cls_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_color_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_getsize_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_inkey_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_isredir_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_locate_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_maxrow_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_pageset_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_pcopy_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_wstr_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_printer_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_readstr_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_scroll_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_viewupdate_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_width_unix.o
	RUNTIME_OBJECTS += runtime/libfb_io_xfocus_unix.o
	RUNTIME_OBJECTS += runtime/libfb_scancodes_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_beep_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_delay_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_dylib_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_exec_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getcwd_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getshortpath_unix.o
	RUNTIME_OBJECTS += runtime/libfb_sys_shell_unix.o
	RUNTIME_OBJECTS += runtime/libfb_thread_cond_unix.o
	RUNTIME_OBJECTS += runtime/libfb_thread_core_unix.o
	RUNTIME_OBJECTS += runtime/libfb_thread_mutex_unix.o
	RUNTIME_OBJECTS += runtime/libfb_time_setdate_unix.o
	RUNTIME_OBJECTS += runtime/libfb_time_settime_unix.o
	RUNTIME_OBJECTS += runtime/libfb_time_sleep_unix.o
	RUNTIME_OBJECTS += runtime/libfb_time_tmr_unix.o
	RUNTIME_OBJECTS += runtime/libfb_unix_hexit_unix.o
	RUNTIME_OBJECTS += runtime/libfb_unix_hinit_unix.o
endif

# TODO: The win32 rtlib parts are also used for cygwin, just with different #defines
ifeq ($(HOST_OS),mingw)
	RUNTIME_HEADERS += runtime/fb_gfx_win32.h
	RUNTIME_HEADERS += runtime/fb_unicode_win32.h
	RUNTIME_HEADERS += runtime/fb_win32.h
	RUNTIME_HEADERS += runtime/fbportio_driver.h
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_close_win32.o
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_open_win32.o
	RUNTIME_OBJECTS += runtime/libfb_drv_file_copy_win32.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_get_win32.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getdateformat_win32.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getmonthname_win32.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_gettimeformat_win32.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getweekdayname_win32.o
	RUNTIME_OBJECTS += runtime/libfb_file_dir_win32.o
	RUNTIME_OBJECTS += runtime/libfb_file_hconvpath_win32.o
	RUNTIME_OBJECTS += runtime/libfb_file_hlock_win32.o
	RUNTIME_OBJECTS += runtime/libfb_file_resetex_win32.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_ddraw_win32.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_gdi_win32.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_joystick_win32.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_win32_win32.o
	RUNTIME_OBJECTS += runtime/libfb_hdynload_win32.o
	RUNTIME_OBJECTS += runtime/libfb_hexit_win32.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_win32.o
	RUNTIME_OBJECTS += runtime/libfb_hsignals_win32.o
	RUNTIME_OBJECTS += runtime/libfb_intl_conv_win32.o
	RUNTIME_OBJECTS += runtime/libfb_intl_w32_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_cls_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_clsex_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_color_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_colorget_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_gethnd_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_getsize_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_getwindow_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_getwindowex_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_getx_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_getxy_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_gety_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_inkey_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_input_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_isredir_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_locate_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_locateex_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_maxrow_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_pageset_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_pcopy_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_wstr_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_printer_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_readstr_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_readxy_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_screensize_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_scroll_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_scrollex_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_serial_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_viewupdate_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_width_win32.o
	RUNTIME_OBJECTS += runtime/libfb_io_window_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_dylib_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_exec_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getcwd_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getshortpath_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_ports_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_shell_win32.o
	RUNTIME_OBJECTS += runtime/libfb_sys_sleep_win32.o
	RUNTIME_OBJECTS += runtime/libfb_thread_cond_win32.o
	RUNTIME_OBJECTS += runtime/libfb_thread_core_win32.o
	RUNTIME_OBJECTS += runtime/libfb_thread_mutex_win32.o
	RUNTIME_OBJECTS += runtime/libfb_time_setdate_win32.o
	RUNTIME_OBJECTS += runtime/libfb_time_settime_win32.o
	RUNTIME_OBJECTS += runtime/libfb_time_sleep_win32.o
	RUNTIME_OBJECTS += runtime/libfb_time_tmr_win32.o
	RUNTIME_S_OBJECTS += runtime/libfb_alloca.o
endif

ifeq ($(HOST_GFXFAMILY),x11)
	ifndef DISABLE_X
		RUNTIME_HEADERS += fb_gfx_x11.h
		RUNTIME_OBJECTS += runtime/libfb_gfx_driver_x11.o
		RUNTIME_OBJECTS += runtime/libfb_gfx_x11.o
	endif
endif

ifeq ($(HOST_CPUFAMILY),x86)
	RUNTIME_HEADERS += runtime/fb_gfx_mmx_x86.h
	RUNTIME_HEADERS += runtime/fb_x86.h
	RUNTIME_S_OBJECTS += runtime/libfb_cpudetect_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_blitter_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_add_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_alpha_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_and_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_blend_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_or_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_preset_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_pset_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_trans_mmx_x86.o
	RUNTIME_S_OBJECTS += runtime/libfb_gfx_put_xor_mmx_x86.o
endif

ifeq ($(HOST_OSFAMILY),xbox)
	RUNTIME_HEADERS += fb_xbox.h
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_close_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_dev_pipe_open_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_drv_file_copy_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_get_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getdateformat_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getmonthname_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_gettimeformat_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_drv_intl_getweekdayname_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_file_dir_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_file_hconvpath_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_file_hlock_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_gfx_driver_xbox_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_hexit_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_hinit_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_cls_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_color_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_getsize_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_inkey_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_isredir_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_locate_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_maxrow_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_mouse_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_multikey_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_pageset_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_pcopy_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_printbuff_wstr_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_printer_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_readstr_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_scroll_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_serial_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_viewupdate_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_io_width_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_dylib_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_exec_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_fmem_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getcwd_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexename_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getexepath_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_getshortpath_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_shell_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_sys_sleep_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_thread_cond_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_thread_core_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_thread_mutex_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_time_setdate_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_time_settime_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_time_sleep_xbox.o
	RUNTIME_OBJECTS += runtime/libfb_time_tmr_xbox.o
	RUNTIME_S_OBJECTS += runtime/libfb_alloca.o
endif

GFX_DATA_FILES := runtime/data/fnt08x08.fnt
GFX_DATA_FILES += runtime/data/fnt08x14.fnt
GFX_DATA_FILES += runtime/data/fnt08x16.fnt
GFX_DATA_FILES += runtime/data/pal002.pal
GFX_DATA_FILES += runtime/data/pal016.pal
GFX_DATA_FILES += runtime/data/pal064.pal
GFX_DATA_FILES += runtime/data/pal256.pal

FBCNEW := fbc$(EXEEXT)

ifeq ($(HOST_OSFAMILY),windows)
	FBCLFLAGS += -t 2048
endif

ifeq ($(ENABLE_OBJINFO),yes)
	FBLFLAGS += -l bfd -l iberty
	ifeq ($(HOST_OS),cygwin)
		FBLFLAGS += -l intl
	else ifeq ($(HOST_OS),djgpp)
		FBLFLAGS += -l intl -l z
	else ifeq ($(HOST_OS),freebsd)
		FBLFLAGS += -l intl
	else ifeq ($(HOST_OS),openbsd)
		FBLFLAGS += -l intl
	else ifeq ($(HOST_OS),mingw)
		FBLFLAGS += -l user32
	endif
endif

# Some special treatment for xbox.
# TODO: Test me, update me!
#ifeq ($(HOST_OS),xbox)
#	CFLAGS += -DENABLE_XBOX -DDISABLE_CDROM
#	CFLAGS += -std=gnu99 -mno-cygwin -nostdlib -nostdinc
#	CFLAGS += -ffreestanding -fno-builtin -fno-exceptions
#	CFLAGS += -I$(OPENXDK)/i386-pc-xbox/include
#	CFLAGS += -I$(OPENXDK)/include
#	CFLAGS += -I$(OPENXDK)/include/SDL
#endif

ifndef V
	QUIET_FBC  = @echo "FBC $@";
	QUIET_CC   = @echo "CC $@";
	QUIET_AR   = @echo "AR $@";
	QUIET_LINK = @echo "LINK $@";
endif

.PHONY: all
all: $(FBCNEW)
all: libfb.a fbrt0.o
#ifneq ($(HOST_OSFAMILY),dos)
#all: libfbmt.a
#endif

$(FBCNEW): $(COMPILER_OBJECTS) $(COMPILER_C_OBJECTS)
	$(FBC) $(FBFLAGS) $^ -x $@

$(COMPILER_OBJECTS): %.o: %.bas $(COMPILER_HEADERS)
	$(FBC) -w pedantic -m fbc -include config.bi -c $< -o $@

$(COMPILER_C_OBJECTS): %.o: %.c
	$(CC) -Wall $(CFLAGS) -c $< -o $@

compiler/config.bi: compiler/config.bi.in
	cp $< $@
ifndef DISABLE_OBJINFO
	echo "#define ENABLE_OBJINFO" >> $@
endif
ifdef ENABLE_FBBFD
	echo "#define ENABLE_FBBFD $(ENABLE_FBBFD)" >> $@
endif

# runtime compilation rules
# $(1) = The target prefix, if any
define runtime-rules
runtime/$(1)
endef


libfb.a: $(RUNTIME_OBJECTS) $(RUNTIME_S_OBJECTS)
	$(AR) rcs $@ $^

#libfbmt.a: $(MTCOBJECTS) $(MTSOBJECTS)
#	$(AR) rcs $@ $^

$(RUNTIME_OBJECTS) fbrt0.o: %.o: %.c $(RUNTIME_HEADERS)
	$(CC) -Wall $(CFLAGS) -c $< -o $@

$(RUNTIME_S_OBJECTS): %.o: %.s $(RUNTIME_HEADERS)
	$(CC) -Wall $(CFLAGS) -x assembler-with-cpp -c $< -o $@

#$(MTCOBJECTS): %.mt.o: %.c $(RUNTIME_HEADERS)
#	$(CC) -DMULTITHREADED $(CFLAGS) -c $< -o $@

#$(MTSOBJECTS): %.mt.o: %.s $(RUNTIME_HEADERS)
#	$(CC) -DMULTITHREADED $(CFLAGS) -x assembler-with-cpp -c $< -o $@









.PHONY: install
install: $(FBCNEW)
	mkdir -p $(PREFIX)/bin
	cp $(FBCNEW) $(PREFIX)/bin

.PHONY: uninstall
uninstall:
	rm -f $(PREFIX)/bin/$(FBCNEW)

.PHONY: clean
clean:
	rm -f $(COMPILER_OBJECTS) $(COMPILER_C_OBJECTS) $(FBCNEW)
	rm -f $(RUNTIME_OBJECTS) $(RUNTIME_S_OBJECTS) libfb.a
#ifneq ($(HOST_OSFAMILY),dos)
#	rm -f $(OBJSMT) libfbmt.a
#endif
ifndef DISABLE_GFX
	rm -f libfb_gfx_data.h $(MAKEDATA)
endif
ifeq ($(HOST_OSFAMILY),windows)
	rm -f fbportio_driver.h fbportio.sys fbportio_rc.o libntoskrnl_missing.a $(MAKEDRIVER)
endif

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  <none>|all    to compile fbc and libfb."
	@echo "  install       to install into PREFIX."
	@echo "  uninstall     to remove from PREFIX."
	@echo "  clean         to remove built files from the source tree."
	@echo "You can set the following variables:"
	@echo "  V             to see more verbose command lines."
	@echo "  FBFLAGS       to override the default '-g -exx'."
	@echo "  CFLAGS        to override the default '-g -O0 -DDEBUG'."
	@echo "  PREFIX        to override the default /usr/local prefix."
	@echo "You can set/define the following configuration options:"
	@echo "  ENABLE_FBBFD=217  (or similar) to use the FB headers for this exact libbfd,"
	@echo "                    instead of using the system's bfd.h via a C wrapper."
	@echo "  DISABLE_OBJINFO   to disable fbc's objinfo feature, to avoid using libbfd."
	@echo "  DISABLE_GFX       to build libfb without its graphics part."
	@echo "  DISABLE_OPENGL    to omit the OpenGL backend from libfb's graphics part."
	@echo "  DISABLE_X         to build libfbgfx without X11 support on Linux & co."
	@echo "This makefile will also #include a config.mk file if it exists;"
	@echo "you may put configuration in there too."
	@echo "Special variables:"
	@echo "  BUILD_OS"
	@echo "FreeBASIC system names (for BUILD_OS):"
	@echo "  dos|cygwin|darwin|freebsd|linux|netbsd|openbsd|solaris|win32|xbox"
