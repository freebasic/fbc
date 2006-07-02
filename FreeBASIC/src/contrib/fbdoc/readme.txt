
  fbdoc - FreeBASIC User's Manual Converter/Generator
  Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com)


License:

  This program is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later 
  version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with
  this program; if not, write to the Free Software Foundation, Inc., 59 Temple
  Place, Suite 330, Boston, MA 02111-1307 USA.


Installing:

  o Requirements:

    - FreeBASIC Compiler version 0.16 or greater and compatible build environment.

	- libcurl
	- pcre
	- mysql client
	- internet connection ( to download wiki pages )

  o Windows version:

    - type "make TARGET=win32" in the fbdoc directory at the command prompt.  
	  This will generate "fbdoc.exe"
      
  o Linux version:

    - type "make TARGET=linux" in the fbdoc directory at the command prompt.  
	  This will generate "fbdoc"

	- At the time of this writing, not all of the required headers may be
	  available to build the program.  fbdoc has not been tested in

  o DOS:

    - not supported



Running:

  o First time use:

    - In the directory where fbdoc executable was made, type "fbdoc -makeini"
	  this will create a default "fbdoc.ini"


  o Building the CHM from the wiki over the web:

	- In the directory where fbdoc executable was made, 
	  type "fbdoc -useweb -chm"

	- When the process is complete, use html help compilter to make the CHM using
	  ./html/fbdoc.hhp as the project file.


  o Building the CHM using an MySQL Database source:

	- Edit "fbdoc.ini" to set the host name or ip address, user name, password,
	  database name , and port number to use for the MySQL database connection. 

	- In the directory where fbdoc executable was made, 
	  type "fbdoc -usesql -chm"

	- When the process is complete, use html help compilter to make the CHM using
	  ./html/fbdoc.hhp as the project file.


Credits:

  o Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br):
    - Created backend code for using PCRE and libCURL.
	- Ported the Wikka parser code from PHP version to FreeBASIC.


Links:

  o Official site: http://www.freebasic.net/ or
                   http://fbc.sourceforge.net/ or
                   http://www.sourceforge.net/projects/fbc


EOF
