include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <roundedcube.scad>
include <hex.scad>
include <bowl.scad>
include <bolt.scad>

// FIXME need channel through middle bottom for power
// FIXME need cutaways for LEDs in front of viewports

// uses "OpenSCAD Parameterized Honeycomb Storage Wall"
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall

// bottom honeycomb
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
// boundary around bottom honeycomb
translate([0, 0, 0]){
	difference(){
		cube([mainx, 7, mainz], true);
		cube([mainx - 14, 7, mainz - 14], true);
	}
}
// fill in all partials on bottom right
translate([mainx / 2 - 13.5, -3, -mainz / 2]){
	cube([13.5, 7, mainz]);
	mirror([1, 0, 0]){
		for(i = [0:1:3]){
			translate([0, 7, 41 + i * 41]){
				rotate([90, 0, 0]){
					linear_extrude(7){
						polygon([
							[0, -2],
							[12, 6],
							[12, 18],
							[0, 26]
						]);
					}
				}		
			}
		}
	}
}
// fill in all partials on bottom left
translate([-mainx / 2, -3, -mainz / 2]){
	cube([14.2, 7, mainz]);
	for(i = [0:1:3]){
		translate([14.2, 7, 21 + i * 41]){
			rotate([90, 0, 0]){
				linear_extrude(7){
					polygon([
						[0, 0],
						[10, 6],
						[10, 18],
						[0, 24]
					]);
				}
			}		
		}
	}
}
// front bottom fillins
for(i = [-4:1:3]){
	translate([i * 23.6 - 5, 4, 80])
	rotate([90, 0, 0]){
		linear_extrude(7){
			polygon([
								[0, 18],
								[11, 24],
								[22, 18],
								[22, 4],
								[11, -2],
								[0, 4]
							]);
		}
	}
}
// back bottom fillins
mirror([0, 0, 1])
for(i = [-4:1:3]){
	translate([i * 23.6 + 7, 4, 80])
	rotate([90, 0, 0]){
		linear_extrude(7){
			polygon([
								[0, 18],
								[11, 24],
								[22, 18],
								[22, 4],
								[11, -2],
								[0, 4]
							]);
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
		union(){
			difference(){
				roundedcube([totx, toty, totz], false, wallr);
				union(){
					// scoop out the bowl
					translate([wallx, 0, wallz]){
						cube([mainx, toty, mainz]);
					}
					// rip off the front
					translate([wallx, 7, totz - wallz]){
						cube([mainx, mainy, wallz]);
					}
					// cut holes into back panel to reduce material requirements
					linear_extrude(wallz){
						polygon([
							[20, 20],
							[20, toty / 2],
							[mainx / 2, 20]
						]);
					}
					linear_extrude(wallz){
						polygon([
							[totx - 20, 20],
							[totx - 20, toty / 2],
							[totx - mainx / 2, 20]
						]);
					}
					// cut out the core of the left and right faces
					translate([0, (toty - corey) / 2, (totz - corez) / 2]){
						cube([totx, corey, corez]);
					}
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
			translate([8, toty, 0]){
				rotate([180, 180, 0]){
					sidecomb();
				}
			}
			translate([totx - 8, 0, 0]){
				sidecomb();
			}
		}
		union(){
			// passageways for bolts
			translate([wallx / 2, mainy - boltd / 2 - 1, totz - boltd / 2 - wallz - 1]){
				rotate([0, 90, 0]){
					screw_hole("M5", length=wallx * 2);
				}
			}		
			translate([totx - wallx / 2, mainy - boltd / 2 - 1, totz - boltd / 2 - wallz - 1]){
				rotate([0, 90, 0]){
					screw_hole("M5", length=wallx * 2);
				}
			}
		}
	}
}

// tower in front center for bolts
// we have about 20mm of gap between the two boxes
translate([-towerw / 2, wallr / 2, totz / 2])
rotate([0, 90, 0]){
	// triangle support for tower
	translate([0, 0, wallr]){
		linear_extrude(towerw - wallr * 2){
				polygon([
				 [towerd / 2, 0],
				 [towerd / 2, mainy - 4],
				 [towerd, 0]
				]);
		}
	}
	difference(){
		roundedcube([towerd - wallz * 3, mainy - 2, towerw], false, wallr, "ymax");
		// two threaded M5 holes (need different thread orientation on each side)
		union(){
			translate([boltd + 1.5, mainy - boltd - 3, 0]){
				screw_hole("M5", length=towerw * 2);
			}
		}
	}
}

// a cylindrical bar at the front bottom onto which the front panels can
// be clipped (along with their bolt along the top), and around which they
// can rotate. this way, removing the bolt causes the panel to fall forward,
// rather than separating from the structure entirely.
// we want it to rotate through 90 degrees. if we provide 90 degrees for
// support of the bar, that allows 180 degrees for the panel's clamp.
translate([-mainx / 2, 5, totz / 2 - bard / 2])
	rotate([0, 90, 0])
		cylinder(mainx, bard / 2, bard / 2);

/*translate([totx / 2 - 100, mainy - 7, totz / 2 - 6.5]){
rotate([0, 90, 0]){
  bolt();
}
}*/