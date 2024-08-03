include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <roundedcube.scad>
include <hex.scad>
include <bowl.scad>

// front panel for the bowl. two fit on the front.
// they are held in at the top by an M5 bolt, and at
// the bottom by their clamp.

fpanelx = (mainx - towerw) / 2;

// we have the top 180 degrees
clampr = bard / 2 + 0.2;
difference(){
	cylinder(fpanelx, clampr, clampr);
	union(){
		// core out the clamp
		translate([0.1, 0.1, 0]){
			cylinder(fpanelx, bard / 2, bard / 2);
		}
		// remove the bottom half
		translate([-clampr, -bard, 0]){
			cube([clampr * 2, bard, fpanelx]);
		}
	}
}

fpanely = mainy;

// we need a cylinder at the top through which our m5 bolt can go
translate([0, fpanely - 5 / 2, 0]){
	difference(){
		cylinder(fpanelx, 5 + 0.2, 5 + 0.2);
		translate([-0.1, -0.1, 0])
			cylinder(fpanelx, 5, 5);
	}
}

// main panel
translate([-3.5, clampr, 0]){
	cube([7, fpanely - clampr - 8, fpanelx]);
}