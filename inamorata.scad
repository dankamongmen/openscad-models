// hold an arduino MEGA2560 above a breadboard

color([0, 1.0, 0.5]){
	translate([0, 0, 40]){
		import("/home/dank/src/dankamongmen/openscad-models/ImprovedArduinoHolder.stl");
	}
}
// breadboard: 165x53x10mm
// stub 13mm down, 1mm up, 5mm x 5mm x 2mm

// bottom support, equal in area to breadboard
cube([165, 53, 5]);
// back support
translate([-6, 0, 0]){
	cube([6, 53, 37]);
}
// left support, with hole cut for wiring
difference(){
	translate([0, -5, 0]){
		cube([75, 5, 37]);
	}
	translate([10, -5, 15]){
		cube([55, 5, 15]);
	}
}
// right support, with hole cut for wiring
// we have a stub off the breadboard for which we must leave room
difference(){
	translate([0, 53, 0]){
		cube([75, 5, 37]);
	}
	union(){
		translate([10, 53, 15]){
			cube([55, 5, 15]);
		}
		// stub is 13mm down from the beginning of the breadboard, and
		// 1mm up from the bottom (*when sticky back is still there*).
		// also clear 5mm of bottom support.
		translate([13, 53, 1 + 5]){
			cube([5, 2, 5]);
		}

	}
}
// footer support
translate([165, 0, 0]){
	cube([5, 53, 15]);
}