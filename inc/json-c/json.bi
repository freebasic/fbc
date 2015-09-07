'' FreeBASIC binding for json-c-0.12-20140410
''
'' based on the C header files:
''   $Id: json.h,v 1.6 2006/01/26 02:16:28 mclark Exp $
''
''   Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
''   Michael Clark <michael@metaparadigm.com>
''   Copyright (c) 2009 Hewlett-Packard Development Company, L.P.
''
''   This library is free software; you can redistribute it and/or modify
''   it under the terms of the MIT license. See COPYING for details.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "bits.bi"
#include once "debug.bi"
#include once "linkhash.bi"
#include once "arraylist.bi"
#include once "json_util.bi"
#include once "json_object.bi"
#include once "json_tokener.bi"
#include once "json_object_iterator.bi"
#include once "json_c_version.bi"

#define _json_h_
