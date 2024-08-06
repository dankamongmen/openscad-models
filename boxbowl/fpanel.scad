include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <roundedcube.scad>
include <hex.scad>
include <bowl.scad>

// front panel for the bowl. two fit on the front.
// they are held in at the top by an M5 bolt, and at
// the bottom by their clamp.

// viewport for hydrogmeter on front face. we use a kite
// to eliminate any need for supports.
vx = 60;
module viewport(){
	// a rectangular viewport would be 60x36
	vy = 36;
	// from 20-70x, 20-50y
	translate([-fpanelz / 2, 27, (fpanelx + vx) / 2]){
		rotate([0, 90, 0]){
			linear_extrude(fpanelz){
				polygon([[0, vy / 2], [vx / 2, vy], [vx, vy / 2], [vx / 2, 0]]);
			}
		}
	}
}

module fpanel(filtype){
	difference(){
		union(){
			// main panel cube
			translate([-fpanelz / 2, 0, 0]){
				cube([fpanelz, fpanely - clampr - 5.5, fpanelx]);
			}
			// we need a cylinder at the top through which our m5 bolt can go
			// FIXME we should use screw_hole() for this, not cylinder
			translate([-2.02, fpanely - 8, 0]){
				difference(){
					cylinder(fpanelx, 5 + 2, 5 + 2);
				}
			}	
		}
		union(){
			// we have the top 180 degrees of the clamp
			translate([-2, 0, 0]){
				cylinder(fpanelx, clampr, clampr);
			}
			viewport();
			// top cylinder interior
			translate([-2.02, fpanely - 8, 0]){
				cylinder(fpanelx, 5, 5);
			}
			translate([-fpanelz / 2, 20, 15]){
				rotate([90, 0, 0]){
					rotate([0, 90, 0]){
						linear_extrude(fpanelz){
							circle(13, $fn=6);
						}
					}
				}
			}
			translate([0, 16, 90]){
				rotate([0, 90, 0]){
					linear_extrude(7){
						text(filtype, font="Prosto One");
					}
				}
			}
		}
	}
	
	translate([-4, 20, 20]){
		rotate([0, 90, 0]){
			hexwall(1, 1);
		}
	}
}