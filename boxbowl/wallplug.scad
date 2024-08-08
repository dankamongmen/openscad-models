// wallhole is 45.5mm
// backhole is 45mm

wallr = 45 / 2;
backr = 44.5 / 2;
innerr = 20; // FIXME strengthen for final version once fitted
wlen = 20;
bowllen = 3.5;
difference(){
	union(){
		// part that plugs into wall
		cylinder(wlen, wallr, wallr);
		translate([0, 0, wlen]){
			// part that plugs into bowlback
			cylinder(bowllen, backr, backr);
		}
	}
	// big hole through all of it
	cylinder(wlen + bowllen, innerr, innerr);
}