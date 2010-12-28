// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: t -*-
//
//  Shim GPS driver, for use when the actual GPS data is coming from somewhere else.
//  Code by Mike Smith
//
//	This library is free software; you can redistribute it and / or
//	modify it under the terms of the GNU Lesser General Public
//	License as published by the Free Software Foundation; either
//	version 2.1 of the License, or (at your option) any later version.
//
//
#ifndef AP_GPS_Shim_h
#define AP_GPS_Shim_h

#include <GPS.h>

class AP_GPS_Shim : public GPS
public:
	AP_GPS_Shim() : GPS(NULL) {}
	virtual void init(void) {};
	virtual bool read(void) {

	/// Set-and-mark-updated macro for the public member variables; each instance
	/// defines a member function set_<variable>(<type>)
	///
	bool	_updated;		///< set anytime a member is updated, cleared when read() returns true
};

#endif	// AP_GPS_HIL_H