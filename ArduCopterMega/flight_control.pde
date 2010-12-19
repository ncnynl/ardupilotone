
/*************************************************************
throttle control
****************************************************************/

// user input:
// -----------
void output_manual_throttle()
{
	rc_3.servo_out = rc_3.control_in;
	//rc_3.servo_out = (float)rc_3.servo_out * throttle_boost();
}

// Autopilot
// ---------
void output_auto_throttle()
{
	rc_3.servo_out 	= (float)nav_throttle * throttle_boost();
}

void calc_nav_throttle()
{
	long err = constrain (altitude_error, -300, 300); //+-5 meters
	long temp = pid_throttle.get_pid(err, deltaMiliSeconds, 1.0);
	nav_throttle = (float)(throttle_cruise + temp) * throttle_boost();
}

float throttle_boost()
{
	//static byte flipper;
	float temp = 1 / (cos(dcm.roll) * cos(dcm.pitch));
	if(temp > 1.25) 
		temp = 1.25;
	return temp;
}





/*************************************************************
yaw control
****************************************************************/

void input_yaw_hold()
{
	if(rc_3.control_in == 0){
		nav_yaw = yaw_sensor;
	
	}else if(rc_4.control_in == 0){
		// do nothing
	}else{
		nav_yaw = yaw_sensor + rc_4.control_in;
		nav_yaw = wrap_360(nav_yaw);
	}
}

/*void output_yaw_stabilize()
{
	rc_4.servo_out	= rc_4.control_in;
	rc_4.servo_out  = constrain(rc_4.servo_out, -MAX_SERVO_OUTPUT, MAX_SERVO_OUTPUT);
}*/




/*************************************************************
picth and roll control
****************************************************************/

// how hard to tilt towards the target
// -----------------------------------
void calc_nav_pid()
{
	nav_angle 	= pid_nav.get_pid(wp_distance * 100, dTnav, 1.0);
	nav_angle 	= constrain(nav_angle, -pitch_max, pitch_max);
}

// distribute the pitch angle based on our orientation
// ---------------------------------------------------
void calc_nav_pitch()
{
	long b_err 	= bearing_error;
	bool rev = false;
	float roll_out;
	
	if(b_err > 18000){
		b_err -= 18000;
		rev = true;
	}
	
	roll_out = abs(b_err - 18000);
	roll_out = (9000.0 - roll_out) / 9000.0;
	roll_out = (rev) ? roll_out : -roll_out;

	nav_pitch = (float)nav_angle * roll_out;
}

// distribute the roll angle based on our orientation
// --------------------------------------------------
void calc_nav_roll()
{
	long b_err 	= bearing_error;
	bool rev = false;
	float roll_out;
	
	if(b_err > 18000){
		b_err -= 18000;
		rev = true;
	}
	
	roll_out = abs(b_err - 9000);
	roll_out = (9000.0 - roll_out) / 9000.0;
	roll_out = (rev) ? -roll_out : roll_out;

	nav_roll = (float)nav_angle * roll_out;
}
