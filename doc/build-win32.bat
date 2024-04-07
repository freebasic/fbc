@echo off
setlocal

rem -----------------------------------------------
rem   Batch to buld fbc, getindex, getpage 
rem   on windows without the use of makefiles
rem   only fbc installation is required
rem 
rem   example:
rem     build-win32 d:/path/fbc-win32.exe
rem     build-win32 d:/path/fbc-win64.exe static
rem
rem ----------------------------------------------- 

if "%1" == "" goto HELP
if not exist "%1" goto HELP
if "%2" == "static" set USE_PCRE_STATIC=-d PCRE_STATIC=1

set FBCEXE=%1 -exx

rem  ============================================
echo build library: libfbdoc
cd libfbdoc

set FBDOCSRCS=
set FBDOCSRCS=%FBDOCSRCS% CFbCode.bas CHttp.bas CHttpForm.bas CHttpStream.bas 
set FBDOCSRCS=%FBDOCSRCS% COptions.bas CPage.bas CPageList.bas CRegex.bas 
set FBDOCSRCS=%FBDOCSRCS% CWakka2fbhelp.bas CWakka2Html.bas CWakka2texinfo.bas 
set FBDOCSRCS=%FBDOCSRCS% CWiki.bas CWiki2Chm.bas CWiki2fbhelp.bas 
set FBDOCSRCS=%FBDOCSRCS% CWiki2texinfo.bas CWiki2txt.bas CWikiCache.bas 
set FBDOCSRCS=%FBDOCSRCS% CWikiCon.bas CWikiConDir.bas CWikiConUrl.bas 
set FBDOCSRCS=%FBDOCSRCS% fbdoc_buildtoc.bas fbdoc_cache.bas fbdoc_keywords.bas 
set FBDOCSRCS=%FBDOCSRCS% fbdoc_lang.bas fbdoc_loader.bas fbdoc_loader_web.bas 
set FBDOCSRCS=%FBDOCSRCS% fbdoc_misc.bas fbdoc_string.bas fbdoc_templates.bas 
set FBDOCSRCS=%FBDOCSRCS% fbdoc_trace.bas hash.bas list.bas printlog.bas 


%FBCEXE% -lib CFbCode.bas %FBDOCSRCS% %USE_PCRE_STATIC% -x libfbdoc.a
if errorlevel 1 goto ERROR
cd ..

rem  =============================================
echo build app: fbdoc.exe
cd fbdoc
%FBCEXE% fbdoc.bas -i ../libfbdoc -p ../libfbdoc -l fbdoc
if errorlevel 1 goto ERROR 
cd ..

rem  =============================================
echo build library: libfuncs.a
cd fbchkdoc
%FBCEXE% -lib funcs.bas cmd_opts.bas funcsdir.bas fmtcode.bas buffer.bas -i ../libfbdoc
if errorlevel 1 goto ERROR
cd ..

rem  =============================================
cd fbchkdoc                                             

echo build app: getindex.exe
%FBCEXE% getindex.bas -i ../libfbdoc -p ../libfbdoc -l fbdoc
if errorlevel 1 goto ERROR

echo build app: getpage.exe
%FBCEXE% getpage.bas -i ../libfbdoc -p ../libfbdoc -l fbdoc
if errorlevel 1 goto ERROR

cd ..

rem  =============================================
echo Success - finished

goto DONE
:ERROR
echo Build error
goto DONE

:HELP
echo usage: build-win32.bat d:\path\fbc.exe [static]
echo example:
echo build-win32 d:/path/fbc-win32.exe
echo build-win32 d:/path/fbc-win64.exe static

:DONE
