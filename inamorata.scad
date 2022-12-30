// hold an arduino MEGA2560 above a breadboard

color([0, 1.0, 0.5]){
	translate([0, -1, 40]){
		import("/home/dank/src/dankamongmen/openscad-models/ImprovedArduinoHolder.stl");
	}
	// fill in the right side (it says "ARDUINO")
	translate([0, 57.85, 37]){
		cube([102, 1, 9]);
	}
}


// breadboard: 165x53x10mm
// stub 13mm down, 1mm up, 5mm x 5mm x 2mm

bby = 53 + 1;  // 1 for 0.5 gap on each side
bbx = 165 + 1; // 1 for 0.5 gap on each side

difference(){
	// bottom support, equal in area to breadboard
	translate([-0.5, -0.5, 0]){
		cube([bbx, bby, 5]);
	}
	union(){
		// core out bottom support for resin printing
		translate([1.5, 1.5, 1.5]){
			cube([bbx - 4, bby - 4, 2]);
		}
		translate([bbx / 2, bby / 2, 0]){
			cube([4, 4, 5]);
		}
	}
}

// back support
translate([-6.5, -0.5, 0]){
	cube([6, bby, 37]);
}
// left support, with hole cut for wiring
difference(){
	translate([0, -5.5, 0]){
		cube([75, 5, 37]);
	}
	translate([10, -5.5, 15]){
		cube([55, 5, 15]);
	}
}
// right support, with hole cut for wiring
// we have a stub off the breadboard for which we must leave room
difference(){
	translate([0, bby - 0.5, 0]){
		cube([75, 5, 37]);
	}
	union(){
		translate([10, bby - 0.5, 15]){
			cube([55, 5, 15]);
		}
		// stub is 13mm down from the beginning of the breadboard, and
		// 1mm up from the bottom (*when sticky back is still there*).
		// also clear 5mm of bottom support.
		translate([13, bby - 0.5, 1 + 5]){
			cube([6, 2, 6]);
		}

	}
}
// footer support
translate([bbx - 0.5, -0.5, 0]){
	cube([5, bby, 15]);
}