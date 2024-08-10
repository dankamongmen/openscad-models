include <bowl.scad>
// wallhole is 44.5 mm
// backhole is 44mm

wallr = 44.5 / 2;
innerr = 20; // FIXME strengthen for final version once fitted
wlen = 20;
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