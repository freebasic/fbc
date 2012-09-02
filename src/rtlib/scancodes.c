#include "fb.h"

int fb_hScancodeToExtendedKey( int scancode ) {
	int key;

	/* FB scancode to FB key translation,
	   currently only used for extended keys. */
	switch( scancode ) {
	case SC_F1:         key = KEY_F1;        break;
	case SC_F2:         key = KEY_F2;        break;
	case SC_F3:         key = KEY_F3;        break;
	case SC_F4:         key = KEY_F4;        break;
	case SC_F5:         key = KEY_F5;        break;
	case SC_F6:         key = KEY_F6;        break;
	case SC_F7:         key = KEY_F7;        break;
	case SC_F8:         key = KEY_F8;        break;
	case SC_F9:         key = KEY_F9;        break;
	case SC_F10:        key = KEY_F10;       break;
	case SC_HOME:       key = KEY_HOME;      break;
	case SC_UP:         key = KEY_UP;        break;
	case SC_PAGEUP:     key = KEY_PAGE_UP;   break;
	case SC_LEFT:       key = KEY_LEFT;      break;
	case SC_CLEAR:      key = KEY_CLEAR;     break;
	case SC_RIGHT:      key = KEY_RIGHT;     break;
	case SC_END:        key = KEY_END;       break;
	case SC_DOWN:       key = KEY_DOWN;      break;
	case SC_PAGEDOWN:   key = KEY_PAGE_DOWN; break;
	case SC_INSERT:     key = KEY_INS;       break;
	case SC_DELETE:     key = KEY_DEL;       break;
	default:            key = 0;             break;
	}

	return key;
}
