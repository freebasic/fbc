	fbcunit - FreeBASIC Compiler Unit Testing Component
	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)

fbcunit version 1.0
-------------------
	Unit testing component for fbc compiler.  Provides macros 
	and common code for unit testing fbc compiled sources. 

Licensing
---------

	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

	As a special exception, the copyright holders of this library give
	you permission to link this library with independent modules to
	produce an executable, regardless of the license terms of these
	independent modules, and to copy and distribute the resulting
	executable under terms of your choice, provided that you also meet,
	for each linked independent module, the terms and conditions of the
	license of that module. An independent module is a module which is
	not derived from or based on this library. If you modify this library,
	you may extend this exception to your version of the library, but
	you are not obligated to do so. If you do not wish to do so, delete
	this exception statement from your version.

Compiling
---------
	To compile fbcunit library, from top level directory:

		$ make

	To compile everything: the library, the test-suite (for fbcunit
	itself), and examples, from top level directory:

		$ make everything

	To list targets and options:

		$ make help


Testing
-------
	To test the library (with itself), from top level directory:

		$ make tests && tests/tests.exe

	Also see ./examples directory for examples of usage


Installing
----------
	Copy the following files to the appropriate include and 
	library directories:

		./inc/fbcunit.bi
		./lib/libfbcunit.a
	

Usage
-----
	Simple example:

		#include "fbcunit.bi"

		SUITE( fbcunit )
			TEST( sanity_check )
				CU_ASSERT( true )
			END_TEST
		END_SUITE

		fbcu.run_tests


Files & Directories
-------------------

	./readme.txt         this file

	./changelog.txt      changelog for fbcunit

	./makefile           simple makefile for the library and tests

	./src/*.bas          source files

	./inc/fbcunit.bi     header file for fbcunit library

	./lib/libfbcunit.a   binary of the library

	./tests/tests.bas    main module for testing fbcunit itself
	./tests/fbcu_*.bas   unit test modules

	./examples/*.bas     usage examples

