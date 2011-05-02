const FALSE = 0
const TRUE = -1
const NULL = 0
type boolean as integer

const FB_VERSION = "0.22.0"

enum
    TARGET_DOS = 0
    TARGET_LINUX
    TARGET_WIN32
end enum

type TRAMCTX
    as integer target
    as string target_name
    as string exeext

    as string path_prev '' Path to previous FreeBASIC release
    as string path_sys  '' Path to MinGW, DJGPP etc. (to copy libs/binutils from and run gcc/ranlib/ar)

    as string fbc
    as string gcc
    as string ar
    as string ranlib

    as string conf_rtlib
    as string conf_gfxlib2
    as string conf_compiler

    as string manifest

    as boolean standalone : 1
    as boolean build      : 1
    as boolean clean      : 1
    as boolean genmanifest: 1
    as boolean archive    : 1
    as boolean installer  : 1
    as boolean deb        : 1
    as boolean source     : 1
end type

dim shared as TRAMCTX tram

#include once "datetime.bi"
#include once "string.bi"

function strReplace _
    ( _
        byref text as string, _
        byref a as string, _
        byref b as string _
    ) as string

    static as string result
    static as string keep

    result = text

    dim as integer alen = len(a)
    dim as integer blen = len(b)

    dim as integer p = 0
    do
        p = instr(p + 1, result, a)
        if (p = 0) then
            exit do
        end if

        keep = mid(result, p + alen)
        result = left(result, p - 1)
        result += b
        result += keep
        p += blen - 1
    loop

    return result
end function

sub strSplit _
    ( _
        byref s as string, _
        byref delimiter as string, _
        byref l as string, _
        byref r as string _
    )
    dim as integer leftlen = instr(s, delimiter) - 1
    if (leftlen > 0) then
        l = left(s, leftlen)
        r = right(s, len(s) - leftlen - len(delimiter))
    else
        l = s
        r = ""
    end if
end sub

sub tramNotice(byref text as string)
    print "tram2: " + text
end sub

sub tramError(byref text as string)
    tramNotice("error: " + text)
    end(1)
end sub

sub tramCantAccessFile(byref filename as string)
    tramError("could not access '" + filename + "'")
end sub

'' Executes any shell command
sub sh(byref cmd as string, byval max_good_exitcode as integer = 0)
    print "    $ " + cmd
    dim as integer exitcode = shell(cmd)
    if (exitcode > max_good_exitcode) then
        tramError("command returned exit code " + str(exitcode))
    end if
end sub

sub cd(byref folder as string)
    print "    $ cd ";folder
    if (chdir(folder)) then
        tramError("failed to change to '" + folder + "'")
    end if
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

function getStandaloneTitle() as string
    #ifdef __FB_LINUX__
        if (tram.standalone) then
            return "-standalone"
        end if
    #endif
    return ""
end function

function getTargetTitle() as string
    return tram.target_name + getStandaloneTitle()
end function

function getReleaseTitle() as string
    return "FreeBASIC-" + FB_VERSION + "-" + getTargetTitle()
end function

function getSourceTitle() as string
    return "FreeBASIC-" + FB_VERSION + "-source"
end function

#ifdef __FB_WIN32__
sub checkForTarget(byval argc as integer, byval argv as zstring ptr ptr)
    dim as string arg = ""
    for i as integer = 1 to (argc-1)
        arg = *argv[i]
        select case (arg)
        case "dos"
            tram.target = TARGET_DOS
        end select
    next
end sub
#endif

sub parseArgs(byval argc as integer, byval argv as zstring ptr ptr)
    dim as string arg = ""
    dim as string variable = ""
    dim as string value = ""

    for i as integer = 1 to (argc-1)
        arg = *argv[i]

        select case (arg)
        case "dos"

        case "standalone"
            tram.standalone = TRUE

        case "build"
            tram.build = TRUE

        case "clean"
            tram.clean = TRUE

        case "manifest"
            tram.genmanifest = TRUE

        case "archive"
            tram.archive = TRUE

        case "installer"
            tram.installer = TRUE

        case "deb"
            tram.deb = TRUE

        case "source"
            tram.source = TRUE

        case else
            tramError("unknown command-line option '" + arg + "'")

        end select
    next
end sub

sub replacePathVars(byref path as string)
    path = strReplace(path, "<prev>", tram.path_prev)
    path = strReplace(path, "<sys>", tram.path_sys)
end sub

'' Copies in binaries/libraries listed in the binaries-<target>.ini and runs
'' genimplibs.
sub getBinsAndLibs()
    dim as string binariesfile = "src/contrib/tram2/binaries-" + tram.target_name + ".ini"

    dim as integer f = freefile()
    if (open(binariesfile, for input, as #f)) then
        tramCantAccessFile(binariesfile)
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
                if (tram.clean) then
                    sh("rm -f " + dest + "/" + ln)
                else
                    '' Copy the file into our tree, preserving the timestamps
                    sh("cp --preserve " + source + "/" + ln + " " + dest)
                end if

            end select
        end if
    wend

    close #f

    #ifdef __FB_WIN32__
        if (tram.target = TARGET_WIN32) then
            '' Run genimplibs
            if (tram.clean) then
                sh("rm -f lib/win32/*.dll.a")
            else
                cd("src/contrib/genimplibs")
                sh("make")
                sh("genimplibs.exe -f -a")
                cd("../../..")
            end if
        end if
    #endif
end sub

sub buildRtlib()
    cd("src/rtlib/obj/" + tram.target_name)

    dim as string confopt = " CC=" + tram.gcc + _
                            " RANLIB=" + tram.ranlib + _
                            tram.conf_rtlib

    dim as string makeopt = " AR=" + tram.ar

    sh("sh ../../configure" + confopt)
    sh("make" + makeopt)
    if (tram.target <> TARGET_DOS) then
        sh("make MULTITHREADED=1" + makeopt)
    end if
    sh("make install")

    cd("../../../..")
end sub

sub buildGfxlib()
    cd("src/gfxlib2/obj/" + tram.target_name)

    dim as string confopt = " CC=" + tram.gcc + _
                            " RANLIB=" + tram.ranlib + _
                            tram.conf_gfxlib2

    dim as string makeopt = " AR=" + tram.ar

    sh("sh ../../configure" + confopt)
    sh("make" + makeopt)
    sh("make install")

    cd("../../../..")
end sub

sub buildCompiler1()
    cd("src/compiler/obj/" + tram.target_name)

    dim as string confopt = " FBC=" + tram.fbc + _
                            " CC=" + tram.gcc + _
                            tram.conf_compiler + _
                            " --disable-objinfo"

    sh("sh ../../configure" + confopt)
    sh("make")
    sh("make install")

    cd("../../../..")
end sub

'' Rebuilds fbc with the one that was built before. This fbc will be
'' built with the tools in the root tree, and linked against the libs
'' in the root tree.
sub buildCompiler2(byval deb_ready as boolean)
    cd("src/compiler/obj/" + tram.target_name)

    #ifdef __FB_LINUX__
        '' Hack to get the normal (non-standalone) linux fbc to run in the dev
        '' tree, instead of using stuff in /usr/local.
        '' This seems like a better solution then running install.sh -i and
        '' altering the system...
        if (tram.standalone = FALSE) then
            '' Recreate part of the non-standalone directory structure in the dev tree...
            '' include/freebasic is covered by the -i inc.
            cd("../../../..")

            '' lib/freebasic can partly be covered by -p lib/linux, but it's
            '' not enough, because fbc doesn't look for fbrt0.o in lib paths.
            cd("lib")
            sh("mkdir freebasic")
            sh("cp -r linux freebasic/linux")
            cd("..")

            cd("src/compiler/obj/linux")
        end if
    #endif

    dim as string fbc = "../../../../fbc" + tram.exeext
    dim as string prefix = ""

    #ifdef __FB_LINUX__
        if (tram.standalone = FALSE) then
            '' Use -prefix to override /usr/local...
            fbc = """" + fbc + " -prefix ../../../.. -i ../../../../inc"""

            '' For non-standalone .deb, use /usr prefix instead of the
            '' default /usr/local.
            if (deb_ready) then
                prefix = " --prefix=/usr"
            end if
        end if
    #endif

    dim as string confopt = " FBC=" + fbc + _
                            " CC=" + tram.gcc + _
                            prefix + _
                            tram.conf_compiler

    sh("sh ../../configure" + confopt)
    sh("make clean")
    sh("make")
    sh("make install")

    cd("../../../..")

    #ifdef __FB_LINUX__
        if (tram.standalone = FALSE) then
            cd("lib")
            sh("rm -r -f freebasic")
            cd("..")
        end if
    #endif
end sub

sub rmLib(byref file as string)
    sh("rm ../../../../lib/" + tram.target_name + "/" + file)
end sub

sub build()
    if (tram.standalone) then
        getBinsAndLibs()
    end if

    if (tram.clean) then
        cd("src/rtlib/obj/" + tram.target_name)
        sh("make clean")
        rmLib("libfb.a")
        rmLib("fbrt0.o")
        if (tram.target <> TARGET_DOS) then
            sh("make clean MULTITHREADED=1")
            rmLib("libfbmt.a")
        end if

        cd("../../../gfxlib2/obj/" + tram.target_name)
        sh("make clean")
        rmLib("libfbgfx.a")
        cd("../../../..")

        cd("src/compiler/obj/" + tram.target_name)
        sh("make clean")
        cd("../../../..")

        sh("rm fbc" + tram.exeext)
    else
        buildRtlib()
        buildGfxlib()
        buildCompiler1()
        buildCompiler2(FALSE)
    end if
end sub

'' Note: creating temp files outside the tree, otherwise they'd be listed in the manifest too...
const TEMP_FILELIST = "../filelist.tmp"
const TEMP_MANIFEST = "../manifest.tmp"

sub applyPattern _
    ( _
        byref manifest as string, _
        byref pattern as string, _  
        byval exclude as boolean _
    )

    '' Run the files list through the pattern.
    '' Note: using double quotes to prevent quirks with the
    '' cmd.exe escape character '^'.
    dim as string cmd = "grep -E """ + pattern + """ "

    if (exclude) then
        '' Excluding: Apply the inversed pattern to
        '' the current manifest (removing from what was gathered
        '' already), and overwrite the current manifest.
        cmd += "-v " + manifest + " > " + TEMP_MANIFEST
    else
        '' Including: Apply the pattern to the whole file list,
        '' append the result to the manifest (duplicates are
        '' removed later).
        cmd += TEMP_FILELIST + " >> " + manifest
    end if

    '' grep will return exit code '1' if no matches were found,
    '' so handle this special case as not-an-error. 
    '' On linux a '256' exit code is coming from somewhere,
    '' when no matches were found, weird...
    sh(cmd, 256)

    if (exclude) then
        sh("mv " + TEMP_MANIFEST + " " + manifest)
    end if
end sub

const MANIFEST_PATTERN = "src/contrib/tram2/manifest-pattern.ini"

sub generateManifest(byref manifest as string)
    sh("rm " + manifest)

    '' Find files (files only, no directories), and remove leading ./, because
    '' find's output looks like:
    ''      ./file.a
    ''      ./dir/file.bas
    '' but we want:
    ''      file.a
    ''      dir/file.bas
    sh("find . -type f | sed ""s/^\.\///"" > " + TEMP_FILELIST)

    '' Read in & apply the regexps
    dim as integer f = freefile()
    if (open(MANIFEST_PATTERN, for input, as #f)) then
        tramCantAccessFile(MANIFEST_PATTERN)
    end if

    dim as string ln = ""
    dim as boolean skipping = FALSE

    while (eof(f) = FALSE)
        line input #f, ln
        ln = trim(ln)

        if (len(ln) > 0) then
            select case (ln[0])
            case asc("+"), asc("-")
                if (skipping = FALSE) then
                    '' '-' means "exclude it".
                    dim as boolean exclude = (ln[0] = asc("-"))

                    '' Cut off +/- at the front.
                    ln = trim(right(ln, len(ln) - 1))

                    '' Replace '<target>' by 'win32' etc.
                    ln = strReplace(ln, "<target>", tram.target_name)

                    applyPattern(manifest, ln, exclude)
                end if

            '' '[' [Target] ']'
            case asc("[")
                if (right(ln, 1) = "]") then
                    '' Cut off the []'s.
                    ln = trim(mid(ln, 2, len(ln)-2))

                    '' Finding empty []'s/the correct target stops skipping.
                    '' If a different target is found, this section is skipped
                    '' until the next [...].
                    skipping = ((len(ln) > 0) and (ln <> tram.target_name))
                end if

            end select
        end if
    wend

    close #f

    sh("rm " + TEMP_FILELIST)

    '' Sort the manifest: case-insensitive, removing duplicates.
    sh("sort --ignore-case --unique " + manifest + " > " + TEMP_MANIFEST)
    sh("mv " + TEMP_MANIFEST + " " + manifest)
end sub

'' Packages the folder <title> into <title>.zip or <title>.tar.gz
sub packageThis(byref title as string)
    #ifdef __FB_WIN32__
        '' dos/win32: make a .zip
        dim as string archive = "../" + title + ".zip"
        sh("rm -f " + archive)
        sh("zip -q -9 -r " + archive + " " + title)
    #else
        '' linux/freebsd: make a .tar.gz
        dim as string archive = "../" + title + ".tar.gz"
        sh("rm -f " + archive)
        sh("tar -c -z -f " + archive + " " + title)
    #endif
end sub

const TEMP_ZIP = "temp.tmp"

sub createArchive(byref title as string, byref manifest as string)
    '' Copy all files from the manifest into a local directory, so that
    '' a) the content of the package is inside a directory (ready for "Extract Here"),
    '' b) only stuff from the manifest is packaged.
    sh("zip -@ -q -0 -r " + TEMP_ZIP + " < " + manifest)
    sh("mkdir " + title)
    sh("mv " + TEMP_ZIP + " " + title)
    cd(title)
    sh("unzip -q -o " + TEMP_ZIP)
    sh("rm " + TEMP_ZIP)
    cd("..")

    packageThis(title)

    sh("rm -r " + title)
end sub

#ifdef __FB_WIN32__
sub createInstaller()
    cd("src/contrib/installer")
    sh("create.bat")
    cd("../../..")
end sub
#endif

#ifdef __FB_LINUX__
sub createDeb()
    '' But not when standalone is enabled
    if (tram.standalone) then
        return
    end if

    '' Build compiler with /usr prefix.
    buildCompiler2(TRUE)

    cd("src/contrib/deb")
    sh("sh makedeb.sh ../../../../freebasic_" + FB_VERSION + "-1_i386.deb")
    cd("../../..")
end sub
#endif

sub createSourceArchive()
    dim as string title = getSourceTitle()

    '' Duplicate the working copy
    sh("svn export . " + title)

    packageThis(title)

    sh("rm -r " + title)
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

    #ifdef __FB_WIN32__
        checkForTarget(__FB_ARGC__, __FB_ARGV__)
    #endif

    parseArgs(__FB_ARGC__, __FB_ARGV__)

    select case (tram.target)
    case TARGET_DOS
        tram.target_name = "dos"
        tram.exeext = ".exe"

        tram.path_prev = "C:/FreeBASIC-dos-0.20"
        tram.path_sys  = "C:/DJGPP"

        tram.fbc    = "C:/FreeBASIC-dos/fbc.exe"
        tram.gcc    = tram.path_sys + "/bin/gcc.exe"
        tram.ar     = tram.path_sys + "/bin/ar.exe"
        tram.ranlib = tram.path_sys + "/bin/ranlib.exe"

        '' Note: using --host so fbc is called with -target dos, see README.
        tram.conf_rtlib    = " --target=i386-pc-msdosdjgpp --host=i386-pc-msdosdjgpp"
        tram.conf_gfxlib2  = " --target=i386-pc-msdosdjgpp --host=i386-pc-msdosdjgpp"
        tram.conf_compiler = " --target=i386-pc-msdosdjgpp --host=i386-pc-msdosdjgpp"
        tram.standalone = TRUE

    case TARGET_LINUX
        tram.target_name = "linux"
        tram.exeext = ""

        tram.path_sys  = "/usr"
        tram.path_prev = "~/FreeBASIC-0.20" + getStandaloneTitle()

        tram.fbc    = "fbc"
        tram.gcc    = "gcc"
        tram.ar     = "ar"
        tram.ranlib = "ranlib"

    case TARGET_WIN32
        tram.target_name = "win32"
        tram.exeext = ".exe"

        tram.path_sys  = "C:/MinGW"
        tram.path_prev = "C:/FreeBASIC-0.20"

        tram.fbc    = "C:/FreeBASIC/fbc.exe"
        tram.gcc    = tram.path_sys + "/bin/gcc.exe"
        tram.ar     = tram.path_sys + "/bin/ar.exe"
        tram.ranlib = tram.path_sys + "/bin/ranlib.exe"

        tram.conf_compiler  = " --enable-crosscomp-dos --enable-crosscomp-cygwin"
        tram.standalone = TRUE

    end select

    '' No -g
    tram.conf_rtlib   += " CFLAGS=-O2"
    tram.conf_gfxlib2 += " CFLAGS=-O2"

    '' The default manifest is manifest/<target>.lst.
    tram.manifest = "manifest/" + getTargetTitle() + ".lst"

    '' We always use standalone for dos/win32 targets, but for linux, there is
    '' the 'standalone' tram2 commandline option.
    if (tram.standalone) then
        tram.conf_compiler += " --enable-standalone"
    end if

    '' -------------------------------------------------------------------------

    tramNotice("target: " + tram.target_name)

    '' Work from the root FreeBASIC directory.
    cd("../../..")

    if (tram.build) then
        build()
    end if

    if (tram.clean = FALSE) then
        if (tram.genmanifest) then
            generateManifest(tram.manifest)
        end if

        if (tram.archive) then
            createArchive(getReleaseTitle(), tram.manifest)
        end if

        #ifdef __FB_WIN32__
            if (tram.installer) then
                createInstaller()
            end if
        #endif

        #ifdef __FB_LINUX__
            if (tram.deb) then
                createDeb()
            end if
        #endif

        if (tram.source) then
            createSourceArchive()
        end if
    end if

    tramNotice("done")
