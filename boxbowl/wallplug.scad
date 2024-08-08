// wallhole is 45.5mm
// backhole is 45mm

wlen = 20;
bowllen = 3.5;
difference(){
	union(){
		// part that plugs into wall
		cylinder(wlen, 22.75, 22.75);
		translate([0, 0, wlen]){
			// part that plugs into bowlback
			cylinder(bowllen, 22.5, 22.5);
		}
	}
	// big hole through all of it
	cylinder(wlen + bowllen, 20, 20);
}