translate([0, 0, 2]){
	cube([3, 90, 2]);
}
translate([47, 0, 2]){
	cube([3, 90, 2]);
}
difference(){
	translate([-3, 0, -2]){
		cube([56, 96, 6]);
	}
	union(){
		cube([50, 90, 5]);
		translate([20, 90, 0]){
			cube([10, 6, 6]);
		}
	}
}