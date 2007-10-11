// C wrapper (c) 2005 Daniel Verkamp
// based on mini.h (c) by Stefan Roettger
// http://www9.cs.fau.de/~roettger/download

#include "mini.h"

extern "C" {

void mini_setminierrorhandler(void (*handler)(char *file,int line,int fatal))
{
	setminierrorhandler(handler);
}

void mini_setparams(float minr,
               float maxd,
               float ginf,
               int maxc)
{
	mini::setparams(minr, maxd, ginf, maxc);
}

void *mini_initmap(short int *image,void **d2map,
              int *size,float *dim,float scale,
              float cellaspect,
              short int (*getelevation)(int i,int j,int size,void *data),
              void *objref)
{
	mini::initmap(image, d2map, size, dim, scale, cellaspect, getelevation, objref);
}

int mini_inittexmap(unsigned char *image,int *width,int *height)
{
	return mini::inittexmap(image, width, height);
}

void *mini_initfogmap(unsigned char *image,int size,
                 float lambda,float displace,float emission,
                 float fogatt,float fogR,float fogG,float fogB)
{
	return mini::initfogmap(image, size, lambda, displace, emission, fogatt, fogR, fogG, fogB);
}

void mini_setmaps(void *map,void *d2map,
             int size,float dim,float scale,
             int texid,int width,int height,
             float cellaspect,
             float ox,float oy,float oz,
             void **d2map2,int *size2,
             void *fogmap,float lambda,float displace,
             float emission,float fogR,float fogG,float fogB)
{
	mini::setmaps(map, d2map, size, dim, scale, texid, width, height, cellaspect, ox, oy, oz, d2map2, size2, fogmap, lambda, displace, emission, fogR, fogG, fogB);
}

void mini_drawlandscape(float res,
                   float ex,float ey,float ez,
                   float fx,float fy,float fz,
                   float dx,float dy,float dz,
                   float ux,float uy,float uz,
                   float fovy,float aspect,
                   float nearp,float farp,
                   void (*beginfan)(void),
                   void (*fanvertex)(float i,float y,float j),
                   void (*notify)(int i,int j,int s),
                   void (*prismedge)(float x,float y,float yf,float z),
                   int state)
{
	mini::drawlandscape(res,
                   ex,ey,ez,
                   fx,fy,fz,
                   dx,dy,dz,
                   ux,uy,uz,
                   fovy,aspect,
                   nearp,farp,
                   beginfan,
                   fanvertex,
                   notify,
                   prismedge,
                   state);
}
                   
int mini_checklandscape(float ex,float ey,float ez,
                   float dx,float dy,float dz,
                   float ux,float uy,float uz,
                   float fovy,float aspect,
                   float nearp,float farp,
                   int phase)
{
	return mini::checklandscape(ex,ey,ez,
                   dx,dy,dz,
                   ux,uy,uz,
                   fovy,aspect,
                   nearp,farp,
                   phase);
}

float mini_getheight1(int i,int j)
{
	return mini::getheight(i, j);
}

void mini_getheight2(float s,float t,float *height)
{
	mini::getheight(s, t, height);
}

float mini_getheight3(float x,float z)
{
	return mini::getheight(x, z);
}

float mini_getfogheight(float x,float z)
{
	return mini::getfogheight(x, z);
}

void mini_getnormal1(float s,float t,float *nx,float *nz)
{
	mini::getnormal(s, t, nx, nz);
}

void mini_getnormal2(float x,float z,float *nx,float *ny,float *nz)
{
	mini::getnormal(x, z, nx, ny, nz);
}

int mini_getmaxsize(float res,float fx,float fy,float fz,float fovy)
{
	return mini::getmaxsize(res, fx, fy, fz, fovy);
}

void mini_deletemaps()
{
	mini::deletemaps();
}

int mini_getS(void)
{
	return mini::S;
}

void mini_setS(int newval)
{
	mini::S = newval;
}

float mini_getDx(void)
{
	return mini::Dx;
}

void mini_setDx(float newval)
{
	mini::Dx = newval;
}

float mini_getSCALE(void)
{
	return mini::SCALE;
}

void mini_setSCALE(float newval)
{
	mini::SCALE = newval;
}

float mini_getDz(void)
{
	return mini::Dz;
}

void mini_setDz(float newval)
{
	mini::Dz = newval;
}

float mini_getOX(void)
{
	return mini::OX;
}

void mini_setOX(float newval)
{
	mini::OX = newval;
}

float mini_getOY(void)
{
	return mini::OY;
}

void mini_setOY(float newval)
{
	mini::OY = newval;
}

float mini_getOZ(void)
{
	return mini::OZ;
}

void mini_setOZ(float newval)
{
	mini::OZ = newval;
}

float mini_getX(const float i)
{
	return((i - mini::S / 2) * mini::Dx + mini::OX);
}

float getY(const float y)
{
	return(y * mini::SCALE + mini::OY);
}

float getZ(const float j)
{
	return((mini::S / 2 - j) * mini::Dz + mini::OZ);
}

} // extern "C"
