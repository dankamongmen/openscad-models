// ring for twitch's game. it's a cylindrical hole, where the
// outside of the torus is tapered top and bottom.

h = 3.9;    // height
od = 36.2;  // outer diameter
id = 25.2;  // inner diameter

difference(){
	union(){
		cylinder(h, od, od, true);
		
	}
	cylinder(h, id, id, true);
}
