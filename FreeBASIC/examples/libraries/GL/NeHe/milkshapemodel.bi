''
'' MilkshapeModel.bi
''

#ifndef __milkshapemodel_bi__
#define __milkshapemodel_bi__

'' Use FIELD = 1 for all structures that are used to read data from disk.
type MS3DHEADER FIELD = 1
	m_ID(9) as ubyte
	m_version as integer
end type

'' Vertex information
type MS3DVERTEX FIELD = 1
	m_flags as ubyte
	m_vertex(2) as single
	m_boneID as ubyte
	m_refCount as ubyte
end type

'' Triangle information
type MS3DTRIANGLE FIELD = 1
	m_flags as short
	m_vertexIndices(2) as short
	m_vertexNormals(2,2) as single
	m_s(2) as single
	m_t(2) as single
	m_smoothingGroup as ubyte
	m_groupIndex as ubyte
end type

'' Material information
type MS3DMATERIAL FIELD = 1
	m_name(31) as ubyte
	m_ambient(3) as single
	m_diffuse(3) as single
	m_specular(3) as single
	m_emissive(3) as single
	m_shininess as single	    '' 0.0f - 128.0f
	m_transparency as single	'' 0.0f - 1.0f
	m_mode as ubyte	            '' 0, 1, 2 is unused now
	m_texture as zstring * 128
	m_alphamap as zstring * 128
end type

'' Keyframe data
type MS3DKEYFRAME FIELD = 1
	m_jointIndex as integer
	m_time as single		      '' millisecs
	m_parameter(2) as single
end type


type MESH
	m_materialIndex as integer
	m_numTriangles as integer
	m_pTriangleIndices as integer ptr
end type

''	Material properties
type MATERIAL
	m_ambient(3) as single
	m_diffuse(3) as single
	m_specular(3) as single
	m_emissive(3) as single
	m_shininess as single
	m_texture as uinteger
	m_pTextureFilename as zstring ptr
end type

''	Triangle structure
type TRIANGLE
	m_vertexNormals(2,2) as single
	m_s(2) as single
	m_t(2) as single
	m_vertexIndices(2) as integer
end type

''	Vertex structure
type VERTEX
	'' for skeletal animation
	m_boneID as ubyte
	m_location(2) as single
end type

type MODEL
	m_numMeshes as integer
	m_pMeshes as MESH ptr

	''	Materials used
	m_numMaterials as integer
	m_pMaterials as MATERIAL ptr

	''	Triangles used
	m_numTriangles as integer
	m_pTriangles as TRIANGLE ptr

	''	Vertices Used
	m_numVertices as integer
	m_pVertices as VERTEX ptr
end type

'' Declare MilkShape functions
declare function LoadGLTexture (byval filename as zstring ptr) as uinteger
declare function Model_LoadModelData(byval pM as MODEL ptr, byref filename as string) as integer
declare sub Model_Draw(byval pM as MODEL ptr)
declare sub Model_ReloadTextures(byval pM as MODEL ptr)
declare sub Model_Init(byval pModel as MODEL ptr)
declare sub Model_Delete(byval pM as MODEL ptr)

''
'' MilkshapeModel.bas
''



''------------------------------------------------------------------------------
'' Common window constants
#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE -1
#endif

''------------------------------------------------------------------------------
'' Load header files

#include once "bmpload.bi"
#include once "crt.bi"
#include once "GL/gl.bi"
#include once "GL/glu.bi"
''------------------------------------------------------------------------------
''Load the model data into the private variables.
function Model_LoadModelData(byval pM as MODEL ptr, byref filename as string) as integer
	dim i as integer, j as integer, c as integer
	dim ffile as integer
	dim fileSize as integer
	dim pBuffer as byte ptr
	dim pPtr as byte ptr

	dim pHeader as MS3DHEADER ptr
	dim pVertex as MS3DVERTEX ptr
	dim pTriangle as MS3DTRIANGLE ptr
	dim pMaterial as MS3DMATERIAL ptr
	dim pTriangleIndices as integer ptr

	dim nVertices as integer
	dim nTriangles as integer
	dim nMaterials as integer
	dim nGroups as integer

	dim vertexIndices(3) as integer
	dim t(3) as single
	dim materialIndex as byte


	ffile = freefile

	if  dir(filename) = "" then                                      '' Couldn't open the model file.
		return FALSE
	end if

	open filename for binary as ffile

	fileSize = lof(ffile)

	pBuffer = allocate(fileSize)
	pPtr = pBuffer

	for i = 0 to filesize - 1
		get #ffile, , *pPtr
		pPtr=pPtr+1
	next
	close (ffile)

	pPtr = pBuffer
	pHeader = cast(MS3DHEADER ptr,pPtr)
	pPtr = pPtr + len(MS3DHEADER)

	if strncmp(varptr(pHeader->m_ID(0)),"MS3D000000", 10) <> 0 then  '' Not a valid Milkshape3D model file.
		return FALSE
	end if

	if pHeader->m_version < 3  or  pHeader->m_version > 4 then        '' Unhandled file version. Only Milkshape3D Version 1.3 and 1.4 is supported.
		return FALSE
	end if


	nVertices = peek(short,pPtr)
	pM->m_numVertices = nVertices
	pM->m_pVertices = allocate(len(VERTEX)*(nVertices+1))
	pPtr = pPtr + len(short)

	for i = 0 to nVertices - 1
		pVertex = cast(MS3DVERTEX ptr,pPtr)
		pM->m_pVertices[i].m_boneID = pVertex->m_boneID
		memcpy (varptr(pM->m_pVertices[i].m_location(0)), varptr(pVertex->m_vertex(0)), len(single)*3)
		pPtr = pPtr + len(MS3DVERTEX)
	next

	nTriangles = peek(short,pPtr)
	pM->m_numTriangles = nTriangles
	pM->m_pTriangles = allocate(len(TRIANGLE)*(nTriangles+1))
	pPtr = pPtr + len(short)

	for i = 0 to nTriangles - 1
		pTriangle = cast(MS3DTRIANGLE ptr,pPtr)
		vertexIndices(0) = pTriangle->m_vertexIndices(0)
		vertexIndices(1) = pTriangle->m_vertexIndices(1)
		vertexIndices(2) = pTriangle->m_vertexIndices(2)
		t(0) = 1.0 - pTriangle->m_t(0)
		t(1) = 1.0 - pTriangle->m_t(1)
		t(2) = 1.0 - pTriangle->m_t(2)
		memcpy(varptr(pM->m_pTriangles[i].m_vertexNormals(0,0)), varptr(pTriangle->m_vertexNormals(0,0)), len(single)*3*3)
		memcpy(varptr(pM->m_pTriangles[i].m_s(0)), varptr(pTriangle->m_s(0)), len(single)*3)
		memcpy(varptr(pM->m_pTriangles[i].m_t(0)), varptr(t(0)), len(single)*3)
		memcpy(varptr(pM->m_pTriangles[i].m_vertexIndices(0)), varptr(vertexIndices(0)), len(integer)*3)
		pPtr + = len(MS3DTRIANGLE)
	next

	nGroups = peek(short,pPtr)
	pM->m_numMeshes = nGroups
	pM->m_pMeshes = allocate(len(MESH)*(nGroups+1))
	pPtr = pPtr + len(short)

	for i = 0 to nGroups - 1
		pPtr = pPtr + len(byte)                               '' flags
		pPtr = pPtr + 32                                      '' name
		nTriangles = peek(short,pPtr)
		pPtr = pPtr + len(short)

		pTriangleIndices = allocate(len(integer)*(nTriangles+1))

		for j = 0 to nTriangles - 1
			pTriangleIndices[j] = peek(short,pPtr)
			pPtr + = len(short)
		next

		materialIndex = peek(byte,pPtr)
		pPtr = pPtr + len(byte)

		pM->m_pMeshes[i].m_materialIndex = materialIndex
		pM->m_pMeshes[i].m_numTriangles = nTriangles
		pM->m_pMeshes[i].m_pTriangleIndices = pTriangleIndices
	next

	nMaterials = peek(short,pPtr)
	pM->m_numMaterials = nMaterials
	pM->m_pMaterials = allocate(len(MATERIAL)*(nMaterials+1))
	pPtr = pPtr + len(short)
	dim ptemp as ubyte ptr
	for i = 0 to nMaterials - 1
		pMaterial = cast(MS3DMATERIAL ptr,pPtr)
		memcpy (varptr(pM->m_pMaterials[i].m_ambient(0)), varptr(pMaterial->m_ambient(0)), len(single)*4)
		memcpy (varptr(pM->m_pMaterials[i].m_diffuse(0)), varptr(pMaterial->m_diffuse(0)), len(single)*4)
		memcpy (varptr(pM->m_pMaterials[i].m_specular(0)), varptr(pMaterial->m_specular(0)), len(single)*4)
		memcpy (varptr(pM->m_pMaterials[i].m_emissive(0)), varptr(pMaterial->m_emissive(0)), len(single)*4)
		pM->m_pMaterials[i].m_shininess = pMaterial->m_shininess
		pM->m_pMaterials[i].m_pTextureFilename = allocate(strlen(pMaterial->m_texture) + 1)

		c = 0
		while pMaterial->m_texture[c] <> 0
			pM->m_pMaterials[i].m_pTextureFilename[c] = pMaterial->m_texture[c]
			c =c+1
		wend
		pM->m_pMaterials[i].m_pTextureFilename[c] = 0
		pPtr = pPtr + len(MS3DMATERIAL)
	next
	Model_ReloadTextures (pM)

	return TRUE
end function

''------------------------------------------------------------------------------
'' Set everything to NULL - possibly not needed in FreeBASIC?
sub Model_Init(byval pM as MODEL ptr)
	pM->m_numMeshes = 0
	pM->m_pMeshes = 0
	pM->m_numMaterials = 0
	pM->m_pMaterials = 0
	pM->m_numTriangles = 0
	pM->m_pTriangles = 0
	pM->m_numVertices = 0
	pM->m_pVertices = 0
end sub

''------------------------------------------------------------------------------
'' Free the memory of our model
sub Model_Delete(byval pM as MODEL ptr)
	dim i as integer

	if pM = 0 then exit sub

	for i = 0 to pM->m_numMeshes - 1
		if pM->m_pMeshes[i].m_pTriangleIndices then
			deallocate(pM->m_pMeshes[i].m_pTriangleIndices)
		end if
	next

	for i = 0 to pM->m_numMaterials - 1
		if pM->m_pMaterials[i].m_pTextureFilename then
			deallocate(pM->m_pMaterials[i].m_pTextureFilename)
		end if
	next

	pM->m_numMeshes = 0
	if pM->m_pMeshes <> 0 then
		if pM->m_pMeshes then
			deallocate(pM->m_pMeshes)
		end if
		pM->m_pMeshes = 0
	end if
	pM->m_numMaterials = 0
	if pM->m_pMaterials <> 0 then
		if pM->m_pMaterials then
			deallocate(pM->m_pMaterials)
		end if
		pM->m_pMaterials = 0
	end if
	pM->m_numTriangles = 0
	if pM->m_pTriangles <> 0 then
		if pM->m_pTriangles then
			deallocate(pM->m_pTriangles)
		end if
		pM->m_pTriangles = 0
	end if
	pM->m_numVertices = 0
	if pM->m_pVertices <> 0 then
		if pM->m_pVertices then
			deallocate(pM->m_pVertices)
		end if
		pM->m_pVertices = 0
	end if
	pM = 0
end sub

''------------------------------------------------------------------------------
'' Draw the model
sub Model_Draw(byval pM as MODEL ptr)
	dim  i as integer, j as integer, k as integer
	dim texEnabled as GLboolean
	dim materialIndex as integer
	dim triangleIndex as integer
	dim pTri as TRIANGLE ptr
	dim index as integer

	texEnabled = glIsEnabled (GL_TEXTURE_2D)

	'' Draw by group
	for i = 0 to pM->m_numMeshes - 1
		materialIndex = pM->m_pMeshes[i].m_materialIndex
		if materialIndex >= 0 then
			glMaterialfv (GL_FRONT, GL_AMBIENT, varptr(pM->m_pMaterials[materialIndex].m_ambient(0)))
			glMaterialfv (GL_FRONT, GL_DIFFUSE, varptr(pM->m_pMaterials[materialIndex].m_diffuse(0)))
			glMaterialfv (GL_FRONT, GL_SPECULAR, varptr(pM->m_pMaterials[materialIndex].m_specular(0)))
			glMaterialfv (GL_FRONT, GL_EMISSION, varptr(pM->m_pMaterials[materialIndex].m_emissive(0)))
			glMaterialf (GL_FRONT, GL_SHININESS, pM->m_pMaterials[materialIndex].m_shininess)
			if pM->m_pMaterials[materialIndex].m_texture > 0 then
				glBindTexture (GL_TEXTURE_2D, pM->m_pMaterials[materialIndex].m_texture)
				glEnable (GL_TEXTURE_2D)
			else
				glDisable (GL_TEXTURE_2D)
			end if
		else
			'' Material properties?
			glDisable (GL_TEXTURE_2D)
		end if

		glBegin (GL_TRIANGLES)

			for j = 0 to pM->m_pMeshes[i].m_numTriangles - 1
				triangleIndex = pM->m_pMeshes[i].m_pTriangleIndices[j]
				pTri = varptr(pM->m_pTriangles[triangleIndex])
				for k = 0 to 2
					index = pTri->m_vertexIndices(k)
					glNormal3fv (varptr(pTri->m_vertexNormals(k,0)))
					glTexCoord2f (pTri->m_s(k), pTri->m_t(k))
					glVertex3fv (varptr(pM->m_pVertices[index].m_location(0)))
				next
			next
		glEnd ()
	next

	if texEnabled <> 0 then
		glEnable (GL_TEXTURE_2D)
	else
		glDisable (GL_TEXTURE_2D)
	end if
end sub

''------------------------------------------------------------------------------
'' Reload the textures.
'' Note that the filenames of materials stored in the Model
'' are in Null terminated strings and will need to be converted later. Relative
'' paths must also be correct.
sub Model_ReloadTextures(byval pM as MODEL ptr)
	dim  i as integer

	for i = 0 to pM->m_numMaterials - 1
		if strlen (*pM->m_pMaterials[i].m_pTextureFilename) > 0 then
			pM->m_pMaterials[i].m_texture = LoadGLTexture(pM->m_pMaterials[i].m_pTextureFilename)
		else
			pM->m_pMaterials[i].m_texture = 0
		end if
	next
end sub


''------------------------------------------------------------------------------
function LoadGLTexture (byval filename as zstring ptr) as uinteger       '' Load Bitmaps And Convert To Textures
	dim pImage as BITMAP_RGBImageRec ptr   	     '' Create Storage Space For The Texture
	dim texture as uinteger           			 '' Texture ID
	dim fbfilename as string

	'' Convert filename in model from a zstring to a FB string.
	'' Notice that NeHe created the model with the "data" directory hard coded in the Milkshape model
	fbfilename = exepath + "/" + *filename

	pImage = LoadBMP (fbfilename)

	if pImage <> NULL  then
		if  pImage->buffer <> NULL then
			glGenTextures (1, varptr(texture))          '' Create The Texture

			 '' Typical Texture Generation Using Data From The Bitmap
			glBindTexture (GL_TEXTURE_2D, texture)
			glTexImage2D (GL_TEXTURE_2D, 0, 3, pImage->sizeX, pImage->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, pImage->buffer)
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
			glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)

			deallocate(pImage->buffer)                  '' DEALLOCATE The Texture Image Memory
			deallocate(pImage)                          '' DEALLOCATE The Image Structure
		end if
	end if

	return texture
end function


#endif
