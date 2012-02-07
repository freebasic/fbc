typedef struct _FB_RTTI {
	void				*stdlistVT;
	char				*id;
	struct _FB_RTTI 	*pRTTIBase;
} FB_RTTI;

typedef struct _FB_BASEVT {
	void				*nullPtr;
	FB_RTTI				*pRTTI;
} FB_BASEVT;

typedef struct _FB_OBJECT {
	FB_BASEVT			*pVT;
} FB_OBJECT;

/* Object class constructor */
void _ZN10$fb_ObjectC1Ev( FB_OBJECT* );
