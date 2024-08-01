include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <roundedcube.scad>
include <hex.scad>

// FIXME need front to be hinged for hot swapping boxen
// FIXME need channel through middle bottom for power
// FIXME need cutaways for LEDs in front of viewports

// uses "OpenSCAD Parameterized Honeycomb Storage Wall"
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall

// a carton is 210mm long.
// two next to one another are 225mm wide.
// a carton is 250mm tall.

//bottom honeycomb
difference(){
	translate([0, 4, 0]){
		rotate([90, 0, 0]){
			hexwall(8, 10);
		}
	}
	translate([0, -4, 0]){
		cube([totx, 2, totz], true);
	}
}

/*for(i = [0:1:numx]){
	translate([-htotx / 2 + i * htot , 0, 0]){
		cube([4, 4, 4]);
	}
}*/
wallr = 3;
wallx = 8;
wally = wallr;
wallz = wallr;
mainx = 204;
mainy = 80;
mainz = 210;
totx = mainx + wallx * 2;
totz = mainz + wallz * 2;
toty = mainy + wally;


// viewport for hydrogmeter on front face. we use a kite
// to eliminate any need for supports.
vx = 60;
module viewport(xoff){
	// a rectangular viewport would be 60x36
	vy = 36;
	// one from 20-70x, 20-50y
	translate([xoff, 27, totz - wallz]){
		linear_extrude(wallz){
			polygon([[0, vy / 2], [vx / 2, vy], [vx, vy / 2], [vx / 2, 0]]);
		}
	}
}

// core is a roundedcube using tot{x,y,z}, with a cube using
// main{x,y,z} removed from it. we then remove faces, replacing
// them with honeycomb

// the section cut out of the sides for honeycomb
corey = 4 * mainy / 5;
corez = 11 * mainz / 12 + 4;

height = 20;
wall = 1.8;
htotx = height + 2 * wall;
xoffbase = -100;

module lfill(){
	polygon([[xoffbase, -34],
				 [xoffbase, -30 + htotx],
				 [xoffbase + htotx / 2, -29 + 2 * htotx / 3],
				 [xoffbase + htotx / 2, -34 + htotx / 3]]);
}

module sidecomb(){
	translate([0, toty / 2, totz / 2]){
		rotate([0, 90, 0]){
			hexwall(8, 3);
			for(i = [0:1:7]){
				linear_extrude(8){
					polygon([[xoffbase + i * htotx, 34],
					         [xoffbase + i * htotx + wall + height / 2, 25],
					         [xoffbase + i * htotx + height + wall * 2, 34]]);
					polygon([[xoffbase + i * htotx, -34],
					         [xoffbase + i * htotx + wall + height / 2, -25],
									 [xoffbase + i * htotx + height + wall * 2, -34]]);
				}
			}
			linear_extrude(8){
				polygon([[xoffbase + 8 * htotx, 34],
				         [xoffbase + 8 * htotx + wall + height / 2, 25],
				         [xoffbase + 8 * htotx + wall + height / 2, 34]]);
				polygon([[xoffbase + 8 * htotx, -34],
				         [xoffbase + 8 * htotx + wall + height / 2, -25],
				         [xoffbase + 8 * htotx + wall + height / 2, -34]]);
				lfill();
				translate([0, height * 2, 0]){
					lfill();
				}
				translate([0, height, 0]){
					mirror([1, 0, 0]){
						lfill();
					}
				}
			}
		}
	}
}
			
translate([-totx / 2, -wally, -totz / 2]){
	difference(){
		roundedcube([totx, toty, totz], false, wallr);
		union(){
			// scoop out the bowl
			translate([wallx, 0, wallz]){
				cube([mainx, toty, mainz]);
			}
			// cut out the core of the left and right faces
			translate([0, (toty - corey) / 2, (totz - corez) / 2]){
				cube([totx, corey, corez]);
			}
			viewport(wallx + 18);
			viewport(totx - wallx - 18 - vx);
      // front face, with two viewports
			translate([totx / 2 - 10, 2 * toty / 3, 0]){
				screw_hole("M5", head="pan", length=12);
			}
			translate([totx / 2 + 10, 2 * toty / 3, 0]){
				screw_hole("M5", head="pan", length=12);
			}
		}
	}
	// we need to rotate the left side so that the correct (plug)
	// side of the hexagons is facing outward
	translate([8, 0, totz]){
		rotate([0, 180, 0]){
			sidecomb();
		}
	}
	translate([totx - 8, 0, 0]){
		sidecomb();
	}
}

// boundary around bottom honeycomb
translate([0, 1, 0]){
	difference(){
		cube([mainx, 6, mainz], true);
		cube([mainx - 14, 6, mainz - 14], true);
	}
}