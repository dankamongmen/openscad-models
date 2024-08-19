include <bolt.scad>

translate([0, 0, 2]){
	rotate([90, 0, 0]){
		translate([10, 0, 2.5]){
			screw("m4", length=110);
			translate([40, 0, 0]){
				screw("m4", length=110, thread=0);
			}
		}
		translate([60, 0, 0]){
			screw("M4", length=220, thread=0);
		}
	}
}

nut("M4");

translate([0, 10, 0]){
	nut("M4");
}