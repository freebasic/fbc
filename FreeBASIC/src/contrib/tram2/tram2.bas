#include once "dir.bi"
#include once "misc.bi"

enum
    TARGET_DOS = 0
    TARGET_LINUX
    TARGET_WIN32
end enum

type TRAMCTX
    as integer target
    as string target_name
    as string exeext

    as string sys_fbc   '' Path to stable native FreeBASIC
    as string sys_prev  '' Path to previous FreeBASIC release
    as string sys_gcc   '' Path to MinGW/DJGPP
    as string sys_shell '' Path to MSYS

    as string conf_compiler
    as string conf_rtlib
    as string conf_gfxlib2

    as string fbc
    as string gcc
    as string ar
    as string ranlib

    as string manifest

    as bool pullbin     '': 1
    as bool compiler    '': 1
    as bool rtlib       '': 1
    as bool gfxlib2     '': 1
    as bool clean       '': 1
    as bool configure   '': 1
    as bool make        '': 1
    as bool remake      '': 1
    as bool genlist     '': 1
    as bool testlist    '': 1
    as bool package     '': 1
    as bool setup       '': 1

    as bool had_error   '': 1
end type

dim shared as TRAMCTX tram

sub sh(byref cmd as string, byval max_good_exitcode as integer = 0)
    print "    $ ";cmd
    dim as integer result = shell(cmd)
    if (result > max_good_exitcode) then
        print "Error: exit code " + str(result)
        tram.had_error = TRUE
    end if
end sub

function getFullShellPath(byref tool as string) as string
    return tram.sys_shell + "/bin/" + tool + tram.exeext
end function

sub mkdir_(byref folder as string)
    if (tram.had_error) then return
    print "    $ mkdir ";folder
    mkdir(folder)
end sub

sub cd(byref folder as string)
    if (tram.had_error) then return
    print "    $ cd ";folder
    if (chdir(folder)) then
        print "Error: failed to change to [";folder;"]"
        tram.had_error = TRUE
    end if
end sub

sub cp(byref source as string, byref dest as string)
    sh("cp " + source + " " + dest)
end sub

sub rm(byref file as string)
    sh("rm -f " + file)
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#macro STEP_BEGIN()
    do
#endmacro

#macro STEP_END()
        if (tram.had_error = FALSE) then
            exit do
        end if

        print "Please fix this, then press SPACE to retry or CTRL+C to abort. "
        print "Waiting...";
        sleep
        tram.had_error = FALSE
        print " retrying."
    loop
#endmacro

sub checkForTarget(byval argc as integer, byval argv as zstring ptr ptr)
    dim as string arg = ""
    for i as integer = 1 to (argc-1)
        arg = *argv[i]
        select case (arg)
        case "dos"
            tram.target = TARGET_DOS
        case "linux"
            tram.target = TARGET_LINUX
        case "win32"
            tram.target = TARGET_WIN32
        end select
    next
end sub

sub parseArgs(byval argc as integer, byval argv as zstring ptr ptr)
    dim as string arg = ""
    dim as string variable = ""
    dim as string value = ""

    for i as integer = 1 to (argc-1)
        arg = *argv[i]

        select case (arg)
        case "dos", "linux", "win32"

        case "clean"
            tram.clean = TRUE

        case "pullbin"
            tram.pullbin = TRUE

        case "compiler"
            tram.compiler = TRUE

        case "rtlib"
            tram.rtlib = TRUE

        case "gfxlib2"
            tram.gfxlib2 = TRUE

        case "configure"
            tram.configure = TRUE

        case "make"
            tram.make = TRUE

        case "remake"
            tram.remake = TRUE

        case "genlist"
            tram.genlist = TRUE

        case "testlist"
            tram.testlist = TRUE

        case "package"
            tram.package = TRUE

        case "setup"
            tram.setup = TRUE

        case else

            strSplit(arg, "=", variable, value)

            select case (variable)
            case "manifest"
                tram.manifest = value

            case else
                print "Warning: unexpected command-line option: '";arg;"'"

            end select

        end select
    next
end sub

sub replacePathVars(byref path as string)
    path = strReplace(path, "<gcc>", tram.sys_gcc)
    path = strReplace(path, "<prev>", tram.sys_prev)
end sub

sub pullBinaries()
    dim as string binariesfile = "src/contrib/tram2/binaries-" + tram.target_name + ".ini"

    if (tram.clean) then
        print "Deleting";
    else
        print "Copying in";
    end if
    print " binaries/libraries listed in [";binariesfile;"]."

    dim as integer f = freefile()
    if (open(binariesfile, for input, as #f)) then
        print "Can't access " + binariesfile
        tram.had_error = TRUE
        return
    end if

    dim as string ln = ""
    dim as string source = ""
    dim as string dest = ""

    while (eof(f) = FALSE)
        line input #f, ln
        ln = trim(ln)

        if (len(ln) > 0) then
            select case (ln[0])
            case asc(";")
                '' Ignore comment

            case asc("[")
                '' [source -> destination] ?
                if (right(ln, 1) = "]") then
                    ln = trim(mid(ln, 2, len(ln)-2))

                    strSplit(ln, " -> ", source, dest)

                    replacePathVars(source)
                    replacePathVars(dest)
                end if

            case else
                STEP_BEGIN()
                    if (tram.clean) then
                        '' Delete the file in our tree.
                        rm(dest + "/" + ln)
                    else
                        '' Copy the file into our tree.
                        cp(source + "/" + ln, dest)
                    end if
                STEP_END()

            end select
        end if
    wend

    close #f
end sub

sub makeImportLibraries()
    if (tram.target <> TARGET_WIN32) then return

    if (tram.clean) then
        print "Removing import libraries..."
        sh("rm -f lib/win32/*.dll.a")
    else
        print "Generating import libraries..."
        cd("src/contrib/genimplibs")
        STEP_BEGIN()
            sh("make")
            sh("genimplibs -f -a")
        STEP_END()
        cd("../../..")
    end if
end sub

sub configure(byref tree as string, byref options as string)
    cd("src/" + tree + "/obj/" + tram.target_name)
    sh("sh ../../configure" + options)
    cd("../../../..")
end sub

sub configureRtlib()
    if (tram.clean) then return

    print "Configuring rtlib..."
    configure("rtlib", " CC=" + tram.gcc + _
                       " AR=" + tram.ar + _
                       " RANLIB=" + tram.ranlib + _
                       tram.conf_rtlib)
end sub

sub configureGfxlib2()
    if (tram.clean) then return

    print "Configuring gfxlib2..."
    configure("gfxlib2", " CC=" + tram.gcc + _
                         " AR=" + tram.ar + _
                         " RANLIB=" + tram.ranlib + _
                         tram.conf_gfxlib2)
end sub

sub configureCompiler()
    if (tram.clean) then return

    print "Configuring compiler..."
    configure("compiler", " FBC=" + tram.fbc + _
                          " CC=" + tram.gcc + _
                          tram.conf_compiler)
end sub

sub cpToLib(byref file as string)
    cp(file, "../../../../lib/" + tram.target_name + "/" + file)
end sub

sub rmLib(byref file as string)
    rm("../../../../lib/" + tram.target_name + "/" + file)
end sub

sub makeRtlib()
    cd("src/rtlib/obj/" + tram.target_name)

    STEP_BEGIN()
        if (tram.clean) then
            sh("make clean")
            rmLib("libfb.a")
            rmLib("fbrt0.a")
        else
            print "Compiling rtlib..."
            sh("make")
            cpToLib("libfb.a")
            cpToLib("fbrt0.o")
        end if
    STEP_END()

    if (tram.target <> TARGET_DOS) then
        STEP_BEGIN()
            if (tram.clean) then
                sh("make clean MULTITHREADED=1")
                rmLib("libfbmt.a")
            else
                print "Compiling multi-threaded rtlib..."
                sh("make MULTITHREADED=1")
                cpToLib("libfbmt.a")
            end if
        STEP_END()
    end if

    cd("../../../..")
end sub

sub makeGfxlib2()
    cd("src/gfxlib2/obj/" + tram.target_name)

    STEP_BEGIN()
        if (tram.clean) then
            sh("make clean")
            rmLib("libfbgfx.a")
        else
            print "Compiling gfxlib2..."
            sh("make")
            cpToLib("libfbgfx.a")
        end if
    STEP_END()

    cd("../../../..")
end sub

sub makeCompiler()
    cd("src/compiler/obj/" + tram.target_name)

    STEP_BEGIN()
        dim as string fbc = "../../../../fbc" + tram.exeext
        if (tram.clean) then
            sh("make clean")
            rm(fbc)
        else
            print "Compiling compiler..."
            sh("make")
            cp("fbc_new" + tram.exeext, fbc)
        end if
    STEP_END()

    cd("../../../..")
end sub

sub remakeCompiler()
    if (tram.clean) then return

    '' Rebuild fbc with the one that was built before, this fbc will be
    '' built with the tools in the root tree, and linked against the libs
    '' in the root tree.

    dim as string fbc = "../../../../fbc" + tram.exeext

    STEP_BEGIN()
        print "Re-configuring compiler..."
        configure("compiler", " FBC=" + fbc + _
                              " CC=" + tram.gcc + _
                              tram.conf_compiler)
    STEP_END()

    cd("src/compiler/obj/" + tram.target_name)

    STEP_BEGIN()
        print "Re-compiling compiler..."
        sh("make clean")
        sh("make")
    STEP_END()

    cp("fbc_new" + tram.exeext, fbc)

    cd("../../../..")
end sub

sub generateManifest()
    if (tram.clean) then return

    print "Generating manifest..."

    '' Note: creating temp files outside the tree, otherwise they'd be listed too...
    dim as string files = "../files.tmp"            '' Temp file holding the full list of files
    dim as string manifest = "../manifest1.tmp"     '' Main temp file holding the current result
    dim as string manifest2 = "../manifest2.tmp"    '' Temp file used when excluding

    '' Find files (files only, no directories), and remove leading ./, because
    '' find's output looks like:
    ''  ./file.a
    ''  ./dir/file.bas
    '' but we want:
    ''  file.a
    ''  dir/file.bas
    STEP_BEGIN()
        print "Generating list of all files..."
        sh("find . -type f | sed 's/^\.\///' > " + files)
    STEP_END()

    '' Read in & apply the regexps
    dim as string patternfile = "src/contrib/tram2/manifest-pattern.ini"
    dim as integer f = freefile()
    if (open(patternfile, for input, as #f)) then
        print "Can't access " + patternfile
        tram.had_error = TRUE
        return
    end if

    dim as string ln = ""
    dim as string cmd = ""
    dim as bool skipping = FALSE

    while (eof(f) = FALSE)
        line input #f, ln
        ln = trim(ln)

        if (len(ln) > 0) then
            select case (ln[0])
            case asc("+"), asc("-")
                dim as bool exclude = (ln[0] = asc("-"))

                if (skipping = FALSE) then
                    ln = trim(right(ln, len(ln) - 1))

                    ln = strReplace(ln, "<target>", tram.target_name)

                    print "Applying rule [";ln;"]..."

                    '' Run the files list through the pattern.
                    '' Note: using double quotes to prevent quirks with the
                    '' cmd.exe escape character '^'.
                    cmd = "grep -E """ + ln + """ "

                    if (exclude) then
                        '' Excluding: Apply the inversed pattern to
                        '' the current manifest (removing from what was gathered
                        '' already), and overwrite the current manifest.
                        cmd += "-v " + manifest + " > " + manifest2
                    else
                        '' Including: Apply the pattern to the whole file list,
                        '' append the result to the manifest (duplicates are
                        '' removed later).
                        cmd += files + " >> " + manifest
                    end if

                    '' grep will return exit code '1' if no matches were found,
                    '' so handle this special case as not-an-error. 
                    sh(cmd, 1)

                    if (exclude) then
                        cp(manifest2, manifest)
                    end if
                end if

            case asc("[")
                if (right(ln, 1) = "]") then
                    ln = trim(mid(ln, 2, len(ln)-2))
                    skipping = ((len(ln) > 0) and (ln <> tram.target_name))
                end if

            end select
        end if
    wend

    close #f

    STEP_BEGIN()
        print "Sorting & removing duplicates..."
        '' Sort: case-insensitive, removing duplicates.
        sh("sort -f -u " + manifest + " > " + tram.manifest)
    STEP_END()

    STEP_BEGIN()
        sh("dos2unix --dos2unix " + tram.manifest)
    STEP_END()

    rm(manifest2)
    rm(manifest)
    rm(files)
end sub

sub testManifest()
    if (tram.clean) then return

    print "Testing file tree against manifest [";tram.manifest;"]..."

    dim as integer good = 0
    dim as integer missing = 0

    dim as integer f = freefile()
    if (open(tram.manifest, for input, as #f)) then
        print "Can't access " + tram.manifest
        tram.had_error = TRUE
        return
    end if

    dim as string ln = ""

    while (eof(f) = FALSE)
        line input #f, ln

        if (fileExists(ln)) then
            good += 1
        else
            missing += 1
            print "Missing: ";ln
            tram.had_error = TRUE
        end if
    wend

    close #f

    print good & " good, " & missing & " missing."
end sub

sub createPackage()
    if (tram.clean) then return

    print "Packaging..."

    /'
    '' cd into tram1's directory, build it, run it.
    cd("src/contrib/tram")
    sh("make TARGET=" + tram.target_name)
    sh("tram")
    cd("../../..")
    '/

    STEP_BEGIN()
        sh("tar -cf package.tar.lzma -T " + tram.manifest + " --lzma")
    STEP_END()
    STEP_BEGIN()
        sh("cat " + tram.manifest + " | zip -q -9 package.zip -@")
    STEP_END()
end sub

sub createSetup()
    if (tram.clean) then return
    if (tram.target <> TARGET_WIN32) then return

    print "Creating installer..."

    cd("src/contrib/w32_inst")

    STEP_BEGIN()
        sh("make FBC=" + tram.fbc)
    STEP_END()

    const MAKENSIS = "C:/NSIS/makensis.exe"

    STEP_BEGIN()
        sh("make Setup.exe MAKENSIS=" + MAKENSIS)
    STEP_END()

    cd("../../..")
end sub

''
'' main
''
    '' Initialize with defaults
    #ifdef __FB_WIN32__
        tram.target = TARGET_WIN32
    #else
        tram.target = TARGET_LINUX
    #endif

    checkForTarget(__FB_ARGC__, __FB_ARGV__)

    select case (tram.target)
    case TARGET_DOS
        tram.target_name = "dos"
        tram.exeext = ".exe"

        tram.sys_fbc    = "C:/FreeBASIC-dos/fbc.exe"
        '' A win32 fbc can be used too (we're using -target dos either way)
        ''tram.sys_fbc    = "C:/FreeBASIC"
        tram.sys_prev   = "C:/FreeBASIC-dos-0.20"
        tram.sys_gcc    = "C:/djgpp"
        tram.sys_shell  = "C:/msys/1.0"

        '' Note: using --host so fbc is called with -target dos, see README.
        tram.conf_compiler  = " --target=i386-pc-msdosdjgpp --host=i386-pc-msdosdjgpp" + _
                              " --enable-standalone"
        tram.conf_rtlib     = " CFLAGS=-O2 --target=i386-pc-msdosdjgpp --host=i386-pc-msdosdjgpp"
        tram.conf_gfxlib2   = " CFLAGS=-O2 --target=i386-pc-msdosdjgpp --host=i386-pc-msdosdjgpp"

    case TARGET_LINUX
        tram.target_name = "linux"
        tram.exeext = ""

        tram.sys_fbc    = "~/FreeBASIC"
        tram.sys_prev   = "~/FreeBASIC-0.20"
        tram.sys_gcc    = "/usr"
        tram.sys_shell  = "/"

        tram.conf_compiler  = ""
        tram.conf_rtlib     = " CFLAGS=-O2"
        tram.conf_gfxlib2   = " CFLAGS=-O2"

    case TARGET_WIN32
        tram.target_name = "win32"
        tram.exeext = ".exe"

        tram.sys_fbc    = "C:/FreeBASIC"
        tram.sys_prev   = "C:/FreeBASIC-0.20"
        tram.sys_gcc    = "C:/MinGW"
        tram.sys_shell  = "C:/msys/1.0"

        tram.conf_compiler  = " --enable-crosscomp-dos --enable-crosscomp-cygwin" + _
                              " --enable-standalone"
        tram.conf_rtlib     = " CFLAGS=-O2"
        tram.conf_gfxlib2   = " CFLAGS=-O2"

    end select

    tram.fbc    = tram.sys_fbc + "/fbc"        + tram.exeext
    tram.gcc    = tram.sys_gcc + "/bin/gcc"    + tram.exeext
    tram.ar     = tram.sys_gcc + "/bin/ar"     + tram.exeext
    tram.ranlib = tram.sys_gcc + "/bin/ranlib" + tram.exeext

    tram.manifest = "manifest/current/" + tram.target_name + ".lst"

    print "TRAM 2, target ";tram.target_name;"."

    '' Commandline may change options
    parseArgs(__FB_ARGC__, __FB_ARGV__)

    '' Work from the root FreeBASIC directory.
    cd("../../..")

    if (tram.had_error) then
        print "Error."
        end 1
    end if

    if (tram.pullbin) then
        STEP_BEGIN()
            pullBinaries()
        STEP_END()
        STEP_BEGIN()
            makeImportLibraries()
        STEP_END()
    end if

    if (tram.configure) then
        if (tram.rtlib) then
            STEP_BEGIN()
                configureRtlib()
            STEP_END()
        end if

        if (tram.gfxlib2) then
            STEP_BEGIN()
                configureGfxlib2()
            STEP_END()
        end if

        if (tram.compiler) then
            STEP_BEGIN()
                configureCompiler()
            STEP_END()
        end if
    end if

    if (tram.make) then
        if (tram.rtlib) then
            STEP_BEGIN()
                makeRtlib()
            STEP_END()
        end if

        if (tram.gfxlib2) then
            STEP_BEGIN()
                makeGfxlib2()
            STEP_END()
        end if

        if (tram.compiler) then
            STEP_BEGIN()
                makeCompiler()
            STEP_END()
        end if
    end if

    if (tram.remake and tram.compiler) then
        STEP_BEGIN()
            remakeCompiler()
        STEP_END()
    end if

    if (tram.genlist) then
        STEP_BEGIN()
            generateManifest()
        STEP_END()
    end if

    if (tram.testlist) then
        STEP_BEGIN()
            testManifest()
        STEP_END()
    end if

    if (tram.package) then
        STEP_BEGIN()
            createPackage()
        STEP_END()
    end if

    if (tram.setup) then
        STEP_BEGIN()
            createSetup()
        STEP_END()
    end if

    print "Ok."
