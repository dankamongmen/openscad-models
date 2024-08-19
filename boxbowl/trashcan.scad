include <bowl.scad>
include <hex plug library.scad>

tcanw = 130;
tcanh = 128;
tcand = 128;

translate([0, 0, -tcand]){
	difference(){
		roundedcube([tcanw, tcanh, tcand], false, 5, "ymax");
		translate([6 / 2, 6, 5 / 2]){
			roundedcube([tcanw - 6, tcanh - 6, tcand - 5], false, 5);
		}
	}
}

translate([22, -tcanh + 20, -2]){
	rotate([0, 0, 30]){
		import("double M5.stl");
	}
}