fbchkdoc - FreeBASIC Wiki Management Tools
Copyright (C) 2008-2022 Jeffery R. Marshall (coder[at]execulink[dot]com)

    A collection of utilities to help maintain the FreeBASIC documentation
    at https://www.freebasic.net/wiki

License:

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.


Table of Contents:

    0. Introduction
    1. Installation
    2. Compiling
    3. Configuration
    4. Tools
       4.1 getindex - get an index of all wiki pages
       4.2 getpage - get pages from the wiki
       4.3 putpage - save pages to the wiki
       4.4 chkdocs - do some checks on the wiki
       4.5 replace - replace text in wiki pages
       4.6 rebuild - parse and rebuild wiki pages
       4.7 mkprntoc - generate a linear table of contents
       4.8 mkerrlst - make warnings/errors from FB sources
       4.9 delextra - delete extra pages not in the wiki
       4.10 mkimglst - generate a list of linked images
       4.11 getimage - download images from a list
       4.12 spellit - spell check individual words
       4.13 spell - spell check wiki pages
       4.14 samps - manage wiki samples
    5. Common Tasks
       5.1 Downloading the entire wiki
       5.2 Downloading changed pages since last download
       5.3 Transferring pages between on-line and off-line wiki
       5.4 Name case fixups
       5.5 Update PrintToc
       5.6 Sychronizing Wiki Samples
       5.7 Synchronizing Wiki with GIT repo
    6. Authors
    7. Notes


0. Introduction
   ============

    When I [Jeff Marshall] first started with the FreeBASIC project in 2006,
the project was using a wiki to manage the documentation and I really liked
this idea and wanted to help out.  One of the first things I did was to
convert the documentation generator application (fbdoc) from PHP to FreeBASIC 
(to eat our own dog-food so to speak).  Later, when managing the wiki content
I found I was doing the same kinds of things over and over and soon a had a
little collection of utilities that I would use to perform routine tasks that
would be boring or time-consuming otherwise.

    The utilities found here are not "generic" tools.  They are specific to
the wiki (and it's sources) found on https://www.freebasic.net/wiki.  These
utilities may not work for everyone.  I have only used these on the win32
platform (due to regularly building a CHM file), and you may need to tweak,
change, or write new code to get them to work on other platforms.

    The sources of these utilities are not pretty.  They have evolved over a
long period of time and I tend to only fix them when something doesn't work,
or something new is needed.  So in all usage, please BE CAREFUL, they can do
a fair amount of damage if you are not sure what you are doing.  If you have
any doubts, please contact me and I will do my best to correct or explain any
issue.


1. Installation
   ============

    Because these tools are so specific to FreeBASIC and its wiki, there is
no binary package.  Checkout https:/www.github.com/freebasic/fbc to get 
all the sources needed. Required to build and run are: FreeBASIC, curl, pcre, 
fbdoc (found in ../fbdoc), ASpell, make, and probably a few other libs or 
commands.

    The utilities use relative paths by default.  Always run the utilities
so that ./fbchkdoc is the current working directory.  However, if you
correctly set-up a fbchkdoc.ini file, the exes can be located anywhere, and
you can use the current directory, which contatins fbchkdoc.ini as the
working directory.


2. Compiling
   =========

    Use the makefile to build the utilities.  This should work without any
problems on the win32 platform (assuming dependant libraries and/or DLL's are 
installed).


3. Configuration
   =============

    It should be possible to specify all necessary options to each utility,
from the command line.  However, since most options won't change regularly,
they can be specified in the fbchkdoc.ini configuration file.

    Copy fbchkdoc.org to fbchkdoc.ini.  fbchkdoc.org is a template for the 
configuration settings file.  fbchkdoc.ini may contain user names and 
passwords and to avoid having it committed to GIT or SVN by accident, it has
a different name.  Alternatively, you can use your own ini file by passing
the '-ini FILE' command line option to any of the tools.


    A description of the options in this file are below:

    manual_dir
        normally '../manual'.  Relative to this directory, there needs to
        be a few other sub directories and files, like templates and html.
        Set or override this option from the command line using the
        '-manual_dir DIR' command line option.

    cache_dir
        normally '../manual/cache'.  This is where the wakka source files are
        stored and modified.  This cache directory is selected when the
        '-web' or '-dev' command line option is given.  Set or override this
        option from the command line using the '-cache DIR' command line
        option.

    web_cache_dir    
        also for storing wakka files.  Typically an extra copy of cache_dir.
        Not used by any of these tools, but useful for comparing one snapshot
        of the wiki with another.  For example, after making changes to
        cache_dir, changes (diff) can be inspected.  If working with a git
        repository then can also perform a diff with another commit.  This
        cache directory is selected when the '-web+' command line option is
        given.  Set or override this option from the command line using the
        '-cache DIR' command line option.

    dev_cache_dir
        like web_cache_dir, excect a duplicate of the off-line server's wiki.
        This cache directory is selected when the '-dev+' command line option
        is given.  Set or override this option from the command line using
        the '-cache DIR' command line option.

    image_dir
        location of the images (used in the wiki).  Set or override this
        option with the '-image_dir DIR' command line option.

    fb_dir
        top-level FreeBASIC directory

    web_wiki_url
        the location of the on-line wiki.  This url is selected when the
        '-web' or '-web+' command line option is given.  Set or override 
        this url with the '-url URL' command line option'

    web_username, web_password
        the username and password for the on-line wiki.  These options are 
        only if writing (saving files) to the on-line wiki.  This user
        name and password selected when the '-web' or '-web+' command line
        option is given.  Set or override these options with 
        '-u USER -p PASS' command line options.

    dev_wiki_url
        the location of the secondary "off-line" duplicate wiki.  This url
        is required only if there is a secondary wiki that can be used.
        This url is selected when the '-dev' or '-dev+' command line options
        are given.  Set or override this url with the '-url URL' command
        line option

    web_cert_file
        path and file name to the certificate for web url.  Selected when the
        '-web' or '-web+' command line option given.  Set or override this
        option with the '-certificate FILE' command line option.

    dev_cert_file
        path and file name to the certificate for dev url.  Selected when the
        '-dev' or '-dev+' command line option given.  Set or override this
        option with the '-certificate FILE' command line option.

    dev_username, dev_password
        the username and password for the off-line wiki.  These options are 
        only if writing (saving files) to the off-line wiki.  This user
        name and password selected when the '-dev' or '-dev+' command line
        option is given.  Set or override these options with 
        '-u USER -p PASS' command line options.

    db_host, db_user, db_pass, db_name, db_port
        db_host = database host name
        db_user = database user login name
        db_pass = database user login password
        db_name = name of database to select for use
        db_port = port on database host

    Why all the extra directories and extra wiki, you ask? I have all these 
extra copies of the wiki because many people have worked very hard to create 
the wiki and I am paranoid that it could be lost to a foolish programming 
mistake, or some on-line natural disaster, or a malicious attack. Plus, some 
of these tools make mass changes to the wiki and a small mistake could result 
in disaster without any means to revert to previous good state.  In my 
setup, I have extra directories for wakka pages, plus an off-line server that 
has a duplicate of the on-line FreeBASIC wiki so it is easy to inspect changes
before they are committed or saved back to the wiki.


4. Tools
   =====

    There are several command line utilities that make up this tool set.  Each
utility is described in the following sub-sections.


4.1 getindex
    --------

    Usage:
        $ ./getindex -web

    getindex reads a list of all pages from the wiki and saves the list to
PageIndex.txt.  Type './getindex' without any command line arguments to see
a full list of options.  The PageIndex.txt file that is generated is used by 
other utilities.

    Usage:
        $ ./getindex -web -recent

    Retrieve the recent changes index and save the file to RecentChanges.txt.

    Currently this utility downloads PageIndex from a plain list format from
the wiki.  Use of the '-recent' option downloads an index in plain text format
but has the last wiki page revision number prefixed on each line.

    Usage:
        $ ./getindex -web -local

    If the -local option is given, the cache directory is scanned for file
names instead allowing the creation of PageIndex.txt without having to connect
to the wiki server.  This is useful when using a snapshot of the wiki in the
cache dir that is not the same as what is available on the wiki server.  (For
example, checking an older version of the manual).

    Full refresh on the cache
        $ getindex -web
        $ getpage -web @PageIndex.txt
        $ copy PageIndex.txt CacheIndex.txt

    We make a copy of PageIndex.txt because PageIndex.txt might get trashed
doing other fbdoc activities and we want to keep an index that matches
with the wakka files that are in the cache. 

    Sometime later when we want to refresh the cache but not download the
whole wiki.

        $ getindex -web -recent

    We now have:
        - CacheIndex.txt - saved from last getindex & getpage use
        - RecentChanges.txt - index of most recent changes 
        - PageIndex.txt (maybe trashed from other fbdoc activities, so don't use)

        $ getpage -web @RecentChanges.txt -diff CacheIndex.txt

    No errors? Ok, make RecentChanges.txt the new CacheIndex.txt saved for 
    next time.

        $ copy RecentChanges.txt CacheIndex.txt


4.2 getpage
    -------

    Typical usage:
        $ ./getpage -web DocToc CatPgFullIndex
        $ ./getpage -web @list.txt 

    getpage retrieves pages from the wiki and saves each page to a .wakka file
in the cache.  Type './getpage' without any command line arguments to see a 
full list of options.

    Main usage for this subprogram is to get pages from the wiki to files.
Some of the other utilites work on the local cache instead of the wiki server.

    Individual page names can be specified on the command line, or @list.txt
can be used to specify a list of page names from a file.  The format of list
file is fairly flexible.  (See funcs.bas::ParsePageName).  In general the
expected format is one of the following:

    DocToc
	2061 DocToc
    (10:05 EDT) [history] -  DocToc ? JeffMarshall [updated]
	14:24 UTC [26061] [history] -  DocToc ? JeffMarshall [updated]

    The first form could have been a file that was either hand edited or
generated from some other utility and simply has one page name per line.  The
second form is what I [Jeff] happen to get when I copy a portion of the
RecentChanges page to an ascii text file.  I often use this to copy, for 
example, pages changed in the last several days (as shown in RecentChanges)
and paste it to an ascii text file.  I then use 'getpage -web @list.txt' to
get just those pages.  It often saves having to retrieve the entire wiki.


4.3 putpage
    -------

    Typical usage:
        $ ./putpage -web DocToc CatPgFullIndex
        $ ./putpage -web @list.txt 

    putpage loads pages from the cache and saves them to the wiki and is the
counterpart to getpage.  Type './putpage' without any command line arguments
to see a full list of options.

    You will need a username and password on the wiki to use this command. In
all cases, please BE CAREFUL with this command.  Always inspect your changes 
before making a mass update of pages, especially if pages were modified using
an automated tool.  You will upset developers and users if you suddenly screw
up hundreds of pages.

    Individual page names can be specified on the command line, or @list.txt
can be used to specify a list of page names from a file.  The format of list
file is fairly flexible.  (See funcs.bas::ParsePageName).  In general the
expected format is one of the following:

    DocToc
    20061 DocToc
    (10:05 EDT) [history] -  DocToc ? JeffMarshall [updated]
    14:24 UTC [26061] [history] -  DocToc ? JeffMarshall [updated]

    The first form could have been a file that was either hand edited or
generated from some other utility and simply has one page name per line.  The
second form is what I [Jeff] happen to get when I copy a portion of the
RecentChanges page to an ascii text file.  The text inside the second [] will
be used as a revision comment when saving to the wiki.

    If you happen to put a page to the wiki that is identical to the page you
are sending, no revision is saved.  The wiki application determines that the
new page and the existing page are identical, and no operation is performed.


4.4 chkdocs
    -------

    Typical usage:
        $ ./chkdocs e

    chkdocs will scan all pages in the wakka file cache and report possible
problems with names, links, formatting, examples, images, etc.  Type 
'./chkdocs' without any command line options to get a full list of options.  
The following files are generated as a result of running chkdocs.

    linklist.csv
        A list of all links with each line as one of the following formats:

        PageName,link,DestinationPageName
        PageName,keyword,DestinationPageName
        PageName,back,ParentPageName
        PageName,url,URL

    DocPages.txt
        A list of pages that would be included in the document as generated by
        fbdoc.  The list is generated by including any page that can be reached
        from from DocToc and each line in the file has the following format:

        PageName{tab}Title

    results.txt
        The results of the check.  Results are in plain english.  This file is
        sometimes posted to the wiki as the FBWikiCheck wiki page.

    fixlist.txt
        A list of links that have mismatched name case in the following 
        format:

        PageName,LinkName,CorrectedLinkName

        This file can be used with the 'replace' tool to automatically apply 
        the name corrections.  See section 5.4, Name case fix-ups.

    samplist.log
        A list of all sample files listed in the wiki using the 
        {{fbdoc item="filename" value="filename"}} tag.

    timer.log
        Some timing statistics.


4.4 replace
    -------

    Typical usage:
        $ ./replace -f list.txt -c "comment"

    The replace utility will read a list of text replacements from a file and
apply the changes to the cache dir.  Type './replace' without and command line 
arguments to see a full list of options.  The file must have the following 
format:

    PageName,OldText,NewText

    PageName may be '*' to indicate all pages.  No other wildcard patterns are
recognized.

    After replace completes it's execution, it will write a file "changed.txt"
that can be used with putpage.  For example

    $ ./putpage -web @changed.txt


4.6 rebuild
    -------

    Typical usage:
        $ ./rebuild -web @PageIndex.txt

    This utility reads in wakka source script, parses it, and rebuilds the
page using the parsed data, then finally writes the file back to the source
in the selected cache directory.  Type './rebuild' without and command line 
arguments to see a full list of options.

    The main purpose of this utility is to test the internal wakka parsing
routines.  A side effect is that it can clean-up and/or detect some
abnormalities in the wakka source.


4.7 mkprntoc
    --------

    Typical usage:
        $ ./mkprntoc -web
        $ ./putpage -web PrintToc

    This disgusting utility is meant to generate a linear table of contents
from the wakka source files.  Type './mkprntoc' without any command line 
arguments to see a full list of options.  It reads in key files from the
cache directory starting with DocToc.wakka and writes the results to
PrintToc.wakka in the same cache directory.

    The current layout of the wiki does not lend itself well to a linear 
format (as needed by the single TXT format emitter), and this utility is
an experimental attempt to generate that order.


4.8 mkerrlst
    --------

    Typical usage:
        $ ./mkerrlst [ -p ../../src/compiler/ ]
        $ fbc mkerrtxt.bas
        $ ./mkerrtxt > errlist.txt

    This program scans inc/error.bi and error.bas from the FreeBASIC sources
to generate a program (mkerrlst.bas) that will in turn generate a list of
FreeBASIC compiler warnings and error messages.  The final output can be used
to update the CompilerErrMsg wiki page.

    Currently, there is no automatic update for the CompilerErrMsg wakka file.
To update CompilerErrMsg, the output of 'mkerrtxt' must be copied and pasted
to the wiki page manually.  It is possible that this task could be automated
if  {{fbdoc item="tag"}} were used in the wakka source as start/end markers.  
(The "tag" item does not display any text on-line, or in the converted manual 
formats).


4.9 delextra
    --------

    Typical usage:
        $ ./getindex -web
        $ ./delextra -web -git

    This utility will delete (or remove) the extra *.wakka files in the cache 
directory not present in the PageIndex for the wiki.  Type './delextra' 
without any command line arguments to see a full list of options.

    When pages are deleted from the wiki, old file names will persist in the
cache directories.  Use this utility to purge deleted wiki pages.  Pass "-git"
on the command line to use "git rm" instead of FreeBASIC's built-in KILL
statement.


4.10 mkimglst
     --------

    Typical usage:
        $ ./getindex -web
        $ ./mkimglst -web @PageIndex.txt

    This utility will scan the wakka pages in the cache dir for images links
on each page.  Type './mkimglst' without any command line arguments for a full
list of options.

    When the program completes, two files will have been written:

    imagelist.txt with the following format, one image per line:
    PageName,url-to-image

    imagepages.txt with the following format, one page per line:
    PageName

    imagelist.txt can be used to download all linked images:
    $ ./getimage imagelist.txt


4.11 getimage
     --------

    Typical usage:
        $ ./getimage imagelist.txt

    This utility will download all images listed in the specified file and
store them by default at ../fbdoc/html/images.  Type './getimage' without any
command line arguments for a full list of options.

    getimage takes one argument only and it must be a text file with the
following format, one image per line:

    PageName,URL
or
    URL

    The output from mkimglst can be used with getimage.


4.12 spellit
     -------

    Typical usage:
        $ ./spellit
        $ ./spellit their

    This utility will check spelling of individual words.  Type './spellit' to
start an interactive version of the program.  For each word enter, the 
program will report if the word is correct, otherwise it will give a list of
suggestions.  Or, enter words as command line arguments to checks the words
and then exit.  If words are specified on the command line, the return code
will be the number of incorrect words.


4.13 spell
     -----

    Typical usage:
        $ ./getindex -web
        $ ./spell -web @PageIndex.txt > badwords.txt

    This utility will check spelling of all specified wakka source files.
Type './spell' without any command line options for a full list of options.

    Two files that should be present to make this utility work correctly are:
PageIndex.txt and dict.txt.  PageIndex.txt is needed so page names are not
considered as mispelled words and dict.txt can hold any words that may be
erroneously considered incorrect (i.e. a custom word dictionary).

    Output is to the console with page names followed by incorrect words found
on each page.


4.14 samps
     -----

    Typical usage:
        $ ./samps check @PageIndex.txt
        $ ./samps extract @PageIndex.txt

    This utility is used for managing the wiki samples and synchronizing them
with examples/manual.  Type './samps' without any command line options for a
full list of commands.

    Directories used must be configured in fbchkdoc.ini

    To check if there have been any changes to the sample files use:
    $ ./samps check @PageIndex.txt

    To extract new or changed samples from the wiki and store them the examples
    directory:
    $ ./samps extract @PageIndex.txt


5. Common Tasks
   ============

    The following are common tasks and operations that can be done using
this tools set.

5.1 Downloading the entire wiki
    ---------------------------

    $ ./getindex -web
    $ ./getpage -web @PageIndex.txt

    Use this sparingly as it takes a *long* time and needlessly taxes the
server.  If you don't need the most up to date wiki pages, use the snapshot
at https://www.github.com/freebasic/fbc instead


5.2 Downloading changed pages since last download
    ---------------------------------------------


    Once ... some time in the past ...:

    $ getindex -web -recent
    $ getpage -web @RecentChanges.txt
    $ copy RecentChanges.txt CacheIndex.txt

    Refresh ... many days later ...:

    $ getindex -web -recent
    $ getpage -web @RecentChanges.txt -diff CacheIndex.txt
    $ copy RecentChanges.txt CacheIndex.txt

    Repeat Refresh as needed

    Alternatively, to manually inspect the updates, open your browser and
 go to:
    https://www.freebasic.net/wiki/wikka.php?wakka=RecentChanges

    Then highlight the pages that have changed since your last download and
copy the text to the clipboard.  Paste this in to an editor and save it
as an ascii text file.  For example 'list.txt'.  Then:

    $ ./getpage -web @list.txt


5.3 Transferring pages between on-line and off-line wiki
    ----------------------------------------------------

    To get pages from the on-line wiki and put them on your off-line wiki
    
    $ ./getpage -web @list.txt
    $ ./putpage -dev @list.txt

    To get pages from your off-line wiki and put them on-line

    $ ./getpage -dev @list.txt
    $ ./putpage -web @list.txt

    Always BE CAREFUL when uploading your own pages.  There is no version
control and you always have the risk of overwriting new pages on-line with
your older pages.  If in doubt, compare the on-line wiki with your own
working set.

    $ ./getindex -web
    $ ./getpage -web+ @PageIndex.txt
    $ ./getpage -dev @list.txt

    Then use a diff tool to compare the two sets of files in the cache dir 
and the web_cache dir.  Of course, if the snap-shot of the wiki in GIT is
up to date, you can also use GIT diff to query changes.


5.4 Name case fix-ups
    -----------------

    From time to time, the names of links in the document sources can become
mismatched with the actual page names differing in upper/lower case only.
Having mismatched names in this way works OK for the on-line wiki but can 
cause problems where case sensitive file-systems are used.  Assuming a current
copy of the wiki in the cache directory, this problem can be fixed as follows:

    $ ./getindex -web
    $ ./chkdocs e
    $ ./replace -f fixlist.txt -c "name case fixup"
    $ ./putpage -web @changed.txt


5.5 Update PrintToc
    ---------------

    The TXT format emitter needs a valid PrintToc wakka page to correctly
generate the content and order of this single file output format.  Assuming
that the wakka cache directory is up to date:

    $ ./mkprntoc -web
    $ ./putpage -web PrintToc

    Then proceed to the ../fbdoc directory to make the TXT format.


5.6 Sychronizing Wiki Samples
    -------------------------

    Most of the samples code in the wiki (any code marked with %%(freebasic)
tags) should also exist in examples/manual.  The main reason for
this is to automate testing of the wiki's sample code for compile errors. The
examples/manual/samples.bas program can be used to compile all, or
a specified directory of sample sources and optionally report an error.

    Assuming that PageIndex.txt and the cache directory is up to date, these
commands will help synchronize the samples with GIT

    Find out if new samples were added or changed:
    $ ./samps check @PageIndex.txt

    Extract them from the cache directory to the sample directory:
    $ ./samps extract @PageIndex.txt

    Note: GIT commands to add files or set properties are not automatically
    issued, so remember to 'git add' any new samples.

    Check for deleted samples, and use 'git rm' to get rid of them:
    $ ./samps checkex

    Most of the time you should assume that the wiki has the most up to date
    versions of the sample files.  But, if you do happen to change a file in
    examples/manual, use the following to update the wiki with the changes:
    $ ./samps update PageName @list.txt

    If any pages are changed, the file 'changed.txt' will be generated.
    $ ./putpage -web @changed.txt



5.7 Synchronizing Wiki with GIT repo
    --------------------------------

    The following is a list of "things to do" if you are going to maintain the
wiki, GIT, examples, etc, on a regular basis:

    1) Get the most up to date PageIndex.txt
    $ ./getindex -web

    2) Make sure that the cache directory is up to date by getting all of the
    pages since the last up date (or in some cases a refresh of the entire
    wiki)
    $ ./getpage -web @list.txt
    or
    $ ./getpage -web @PageIndex.txt

    3) Generate PrintToc.  This file is used by chkdocs, and by some of the 
    output formats in fbdoc.
    $ ./mkprntoc -web

    4) Check for common wiki problems:
    $ ./chkdocs e

    Inspect results.txt and make any corrections deemed necessary.  At the 
    very least, apply a fix for any incorrectly cased names:
    $ ./replace -f fixlist.txt -c "name case fixup"
    $ ./putpage -web @changed.txt

    5) If any changes were made in step 4, go back and repeat step 3.  If you
    used the online web interface to change pages on-line, go back and repeat
    step 2.  If no more changes were made at this point, proceed to step 6
    after storing PrintToc to the wiki.
    $ ./putpage -web PrintToc

    6) Get new/updated samples from the wiki and save them to examples/manual,
    and delete removed wiki examples:
    $ ./samps extract @PageIndex.txt
    $ ./samps checkex @PageIndex.txt

    The samps utility will not automatically 'git add' or 'git rm' files
    so be sure to make the appropriate changes to git.  If no samples were
    added or changed, proceed to step 8.

    7) Build and run examples/manual/samples.bas. This should test all of the
    extracted samples.  If you make any changes to the files in
    examples/manual, be sure to update the wiki with the changes:
    $ ./samps update @PageIndex.txt
    $ ./putpage -web @changed.txt

    8) By this point, the wiki, cache directory, and examples should be in
    good working condition.  Proceed to the fbdoc directory to generate the
    output formats needed.  Once you are satisfied with the results, be sure
    to commit the cache directory to GIT.

    9) You are done.  The wiki and examples have been synchronized with the
    git repository.


6. Authors
   =======

    Jeff Marshall - coder[at]execulink[dot]com


7. Notes
   =====

    Even though these utilities may automate some tasks and save some time,
managing the wiki is still very much a hands on deal.  These tools are
meant to help, but not replace, human involvement in maintaining the wiki.

    I sincerely apologize for the lack of any standard in file names and file
formats.  These tools evolved over many months and it was easy to just pick a
name or format that was convenient and then get in the habit of using it.
These utilities are a means to an end.  They are intended to help get a
(sometimes boring) job completed.  They could be totally obsolete should the
documentation ever move to a different wiki application.  The strategy so far
has been to do the least amount of work possible and still complete the task.

    If you make any changes to these sources, please feel free to add your 
name to the Authors and be sure to update any relevant parts of this file.


EOF
