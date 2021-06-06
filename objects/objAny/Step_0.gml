if (type == 0) {
	// brick
	
	x = mouse_x;
	y = mouse_y;
	with (objAny) {
		if (type == 1) {
			other.coll = place_meeting(x, y, other);
		}
	}
}