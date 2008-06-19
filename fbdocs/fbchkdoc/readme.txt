fbchkdoc - FreeBASIC Wiki Management Tools
Copyright (C) 2008 Jeffery R. Marshall (coder[at]execulink[dot]com)

    A collection of utilities to help maintain the FreeBASIC documentation
    at http://www.freebasic.net/wiki

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
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


Table of Contents:

    0. Introduction
    1. Installation
    2. Compiling
    3. Configuration
    4. Tools
       4.1 getindex
       4.2 getpage
       4.3 putpage
       4.4 chkdocs
       4.5 replace
    5. Common Tasks
       5.1 Downloading the entire wiki
       5.2 Downloading changed pages since last download
       5.3 Transferring pages between on-line and off-line wiki
       5.4 Name case fixups
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
the wiki (and it's sources) found on http://www.freebasic.net/wiki.  These
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
no binary package.  Checkout /fbc/trunk/fbdocs from sourceforge.net to get 
all the sources needed. Required to build and run are: FreeBASIC, curl, pcre, 
fbdoc (found in ../fbdoc), ASpell, make, a probably a few other libs or
commands.


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
passwords and to avoid having it committed to SVN by accident, it has a 
different name. A description of the options in this file are below:

    cache_dir
        normally '../fbdoc/cache'.  This is where the wakka source files are
        stored and modified.

    web_cache_dir    
        also for storing wakka files.  Typically an extra copy of cache_dir.
        Not used by any of these tools, but useful for comparing one snapshot
        of the wiki with another.  For example, after making changes to
        cache_dir, changes (diff) can be inspected.  Though not needed as
        much since wakka files are also stored in SVN.

    dev_cache_dir    
        like web_cache_dir, excect a duplicate of the off-line server's wiki.

    web_wiki_url
        the location of the on-line wiki.

    web_username, web_password
        the username and password for the on-line wiki.  These options are 
        only if writing (saving files) to the on-line wiki.

    dev_wiki_url
        the location of the secondary "off-line" duplicate wiki.  This url
        is required only if there is a secondary wiki that can be used.

    dev_username, dev_password
        the username and password for the off-line wiki.  These options are 
        only if writing (saving files) to the off-line wiki.


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
   ============

    There are several command line utilities that make up this tool set.  Each
utility is described in the following sub-sections.


4.1 getindex
    --------

    Typical usage:
        $ getindex -web

    getindex reads a list of all pages from the wiki and saves the list to
PageIndex.txt.  Type 'getindex' without any command line arguments to see
a full list of options.  The PageIndex.txt file that is generated is used by 
other utilities.

    Currently this utility downloads PageIndex from the wiki as HTML and
extracts the page names.  A better solution would be having a query available
in the wiki's PHP application that returns a plain list.  Even better would
allowing a plain list that returns all pages changed since a certain date.


4.2 getpage
    -------

    Typical usage:
        $ getpage -web DocToc CatPgFullIndex
        $ getpage -web @list.txt 

    getpage retrieves pages from the wiki and saves each page to a .wakka file
in the cache.  Type 'getpage' without any command line arguments to see a full
list of options.

    Main usage for this subprogram is to get pages from the wiki to files.
Some of the other utilites work on the local cache instead of the wiki server.

    Individual page names can be specified on the command line, or @list.txt
can be used to specify a list of page names from a file.  The format of list
file is fairly flexible.  (See funcs.bas::ParsePageName).  In general the
expected format is one of the following:

    DocToc
    (10:05 EDT) [history] -  DocToc ? JeffMarshall [updated]

    The first form could have been a file that was either hand edited or
generated from some other utility and simply has one page name per line.  The
second form is what I [Jeff] happen to get when I copy a portion of the
RecentChanges page to an ascii text file.  I often use this to copy, for 
example, pages changed in the last several days (as shown in RecentChanges)
and past it to an ascii text file.  I then use 'getpage -web @list.txt' to
get just those pages.  It often saves having to retrieve the entire wiki.


4.3 putpage
    -------

    Typical usage:
        $ putpage -web DocToc CatPgFullIndex
        $ putpage -web @list.txt 

    putpage loads pages from the cache and saves them to the wiki and is the
counterpart to getpage.  Type 'putpage' without any command line arguments to
see a full list of options.

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
    (10:05 EDT) [history] -  DocToc ? JeffMarshall [updated]

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
        $ chkdocs e

    chkdocs will scan all pages in the wakka file cache and report possible
problems with names, links, formatting, examples, images, etc.  Type 'chkdocs'
without any command line options to get a full list of options.  The following
files are generated as a result of running chkdocs.

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

        This file can be used with 'replace' tool to automatically apply the
        name corrections.  See section 5.3, Name case fix-ups.

    samplist.log
        A list of all sample files listed in the wiki using the 
        {{fbdoc item="filename" value="filename"}} tag.

    timer.log
        Some timing statistics.


4.4 replace
    -------

    Typical usage:
        $ replace -f list.txt -c "comment"

    The replace utility will read a list of text replacements from a file and
apply the changes to the cache dir.  Type 'replace' without and command line 
arguments to see a full list of options.  The file must have the following 
format:

    PageName,OldText,NewText

    PageName may be '*' to indicate all pages.  No other wildcard patterns are
recognized.

    After replace completes it's execution, it will write a file "changed.txt"
that can be used with putpage.  For example

    $ putpage -web @changed.txt

 
5. Common Tasks
   ============

    The following are common tasks and operations that can be done using
this tools set.

5.1 Downloading the entire wiki
    ---------------------------

    $ getindex -web
    $ getpage -web @PageIndex.txt

    Use this sparingly as it takes a *long* time and needlessly taxes the
server.  If you don't need the most up to date wiki pages, use the snapshot
in SVN instead


5.2 Downloading changed pages since last download
    ---------------------------------------------

    Open your browser and go to 
    http://www.freebasic.net/wiki/wikka.php?wakka=RecentChanges

    Then highlight the pages that have changed since your last download and
    copy the text to the clipboard.  Paste this in to an editor and save it
    as an ascii text file.  For example 'list.txt'.  Then:

    $ getpage -web @list.txt


5.3 Transferring pages between on-line and off-line wiki
    ----------------------------------------------------

    To get pages from the on-line wiki and put them on your off-line wiki
    
    $ getpage -web @list.txt
    $ putpage -dev @list.txt

    To get pages from your off-line wiki and put them on-line

    $ getpage -dev @list.txt
    $ putpage -web @list.txt

    Always BE CAREFUL when uploading your own pages.  There is no version
control and you always have the risk of overwriting new pages on-line with
your older pages.  If in doubt, compare the on-line wiki with your own
working set.

    $ getindex -web
    $ getpage -web+ @PageIndex.txt
    $ getpage -dev @list.txt

    Then use a diff tool to compare the two sets of files in the cache dir 
and the web_cache dir.  Of course, if the snap-shot of the wiki in SVN is
up to date, you can also use SVN diff to query changes.


5.4 Name case fix-ups
    -----------------

    From time to time, the names of links in the document sources can become
mismatched with the actual page names differing in upper/lower case only.
Having mismatched names in this way works OK for the on-line wiki but causes
problems were case sensitive file-systems are used.  Assuming a current copy
of the wiki in the cache directory, this problem can be fixed as follows:

    $ getindex -web
    $ chkdocs e
    $ replace -f fixlist.txt -c "name case fixup"
    $ putpage -web @changed.txt


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
has been to do the least amount of work possible and still complete the task

    If you make any changes to these sources, please feel free to add your 
name to the Authors and be sure to update any relevant parts of this file.


EOF
