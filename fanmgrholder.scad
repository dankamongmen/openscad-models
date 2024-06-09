l = 76;
w = 76;
translate([0, 1, 5]){
	cube([l, 5, 2]);
}
translate([0, w - 6, 5]){
	cube([l, 5, 2]);
}

difference(){
	cube([l, w, 7]);
	union(){
		translate([0, 6, 0]){
			cube([l, w - 12, 2]);
		}
		translate([0, 1, 2]){
			cube([l, w - 2, 5]);
		}
	}
}

difference(){
	translate([0, 3, -5]){
		cube([l, w - 6, 5]);
	}
	translate([0, 6, -3]){
		cube([l, w - 12, 3]);
	}
}