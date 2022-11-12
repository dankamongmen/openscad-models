l = 140;
w = 60;
botheight = 25;

// we're working with 3/4" OD tubes (19.05mm)
// add 1mm to the diameter for gap space
od = 19.05 + 1;


module tubinghole(){
	rotate([90, 0, 0]){
		cylinder(w, od / 2, od / 2);
	}
}

// a block underneath the top portion, with two cylinders for tubing removed,
// and the screw holes extended through the height.
difference(){
	union(){
		import("/media/qwop/3dprint/Mo-Ra3_stand.stl");
		translate([-l / 2, -w / 2, -botheight]){
			cube([l, w, botheight]);
		}
	}
	union(){
		// two holes sufficient for tubing through bottom block
		for(x = [-l / 4, l / 4])
		translate([x, w / 2, -botheight + od / 2 + 2]){
			tubinghole();
		}
		// extend the screw holes
		for(x = [6, -19])
			for(y = [12, -12])
				translate([x, y, -botheight]){
					cylinder(botheight, 3, 3);
				}
	}
}
