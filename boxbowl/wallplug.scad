include <bowl.scad>
// wallhole is 43 mm at entry, but gets smaller
// backhole is 44mm

wallr = 43 / 2;
wlen = 30;
bowllen = 3.5;
difference(){
	union(){
		// part that plugs into wall
		cylinder(wlen, wallr, wallr);
		translate([0, 0, wlen]){
			// part that plugs into bowlback
			cylinder(bowllen, backholer, backholer);
		}
		translate([0, 0, bowllen + wlen]){
			screw("M6", length = towerw * 2);
		}
	}
}
