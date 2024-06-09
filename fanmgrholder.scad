l = 76;
w = 76;
translate([0, 1, 5]){
	cube([l, 4, 2]);
}
translate([0, w - 5, 5]){
	cube([l, 4, 2]);
}

difference(){
	cube([l, w, 7]);
	union(){
		translate([0, 3, 0]){
			cube([l, w - 6, 2]);
		}
		translate([0, 1, 2]){
			cube([l, w - 2, 5]);
		}
	}
}

difference(){
	translate([0, 0, -5]){
		cube([l, w, 5]);
	}
	translate([0, 3, -3]){
		cube([l, w - 6, 3]);
	}
}