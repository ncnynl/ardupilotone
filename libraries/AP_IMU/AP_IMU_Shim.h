// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: t -*-

/// @file	AP_IMU_Shim.h
/// @brief	IMU shim driver, used when the IMU data is coming from somewhere else.

#ifndef AP_IMU_Shim_h
	virtual void	init_accel(Start_style style) {};
	virtual void	init_gyro(Start_style style) {};
	virtual bool	update(void) {
		_updated = false;

#endif