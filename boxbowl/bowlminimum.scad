include <bowl.scad>

current_color = "ALL";

rwallr = 8; // same thickness as honeycomb

mtotx = mainx + rwallr * 2;
mtoty = mainy + rwallr;
mtotz = mainz + rwallr * 2;

htotx = height + 2 * wall; // FIXME eliminate
xoffbase = -100; // FIXME eliminate
module lfill(){
	polygon([[xoffbase - 5, -36],
				 [xoffbase - 5, -27 + htotx],
				 [xoffbase + mtotx / 2, -29 + 2 * mtotx / 3],
				 [xoffbase + mtotx / 2, -35 + mtotx / 3]]);
}

module sidecomb(){
	translate([0, mtoty / 2, mtotz / 2 - 3]){
		rotate([0, 90, 0]){
			hexwall(8, 3);
			/*
			// back center gap
			translate([mainz / 2 - 11.5, -mainy / 2 + wally, 0]){
				cube([5.5, mainy - wally * 2, 8]);
			}
			// front center gap
			translate([-mainz / 2 + 6, -mainy / 2 + wally, 0]){
				cube([5.5, mainy - wally * 2, 8]);
			}
			// fill in the top holes
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
				// fill in the front holes on both sides
				translate([0, -1, 0]){
					lfill();
				}
				translate([0, height * 2, 0]){
					lfill();
				}
				// fill in the back hole on both sides
				translate([0, height, 0]){
					mirror([1, 0, 0]){
						lfill();
					}
				}
			}*/
		}
	}
}

module backtriangle(xoff, xto){
		linear_extrude(rwallr + wallr){
			polygon([
				[xoff, 20],
				[xoff, 4 * toty / 5],
				[xto, 20]
			]);
	}
}

difference(){
	// the primary bowl
	roundedcube([mtotx, mtoty, mtotz], false, rwallr);
	union(){
		// remove the core, leaving filleted inside
		translate([(mtotx - mainx) / 2, rwallr, rwallr]){
			roundedcube([mainx, mainy, mainz + 200 * rwallr], false, wallr, "ymin");
		}
		// remove the bottom half of the bottom
		translate([0, 0, 0]){
			cube([mtotx, rwallr / 2, mtotz]);
		}
		// cut triangles into back panel to reduce material requirements
		backtriangle(20, mainx / 2);
		backtriangle(totx - 20, totx - mainx / 2);
		// remove the sides to insert the honeycomb
		translate([0, rwallr + wallr, rwallr + wallr]){
			cube([mtotx, mainy - rwallr - wallr, mainz - wallr]);
		}
	}
}

difference(){
	union(){
		translate([0, 1, wallz]){
			// left side
			translate([8, mtoty, 0]){
				rotate([180, 180, 0]){
					sidecomb();
				}
			}
		}
		// right side
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

multicolor("blue"){
	// tower in front center for bolts
	// we have about 20mm of gap between the two boxes
	translate([(mtotx - towerw) / 2, rwallr, mtotz]){
		rotate([0, 90, 0]){
			// triangle support for tower
			translate([2, 0, wallr]){
				linear_extrude(towerw - wallr * 2){
						polygon([
							[towerd / 2, 0],
							[towerd / 2, mainy - 5],
							[towerd, 0]
						]);
				}
			}
			difference(){
				roundedcube([towerd - wallz * 3 + 1, mainy - 2, towerw], false, wallr, "ymax");
				// two threaded M5 holes (need different thread orientation on each side)
				union(){
					translate([(towerd + wallr * 2 - wallz * 3 - boltd) / 2, mainy - boltd - 3, 0]){
						screw_hole("M5", length=towerw * 2, thread=true);
					}
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
	translate([rwallr, rwallr, mtotz - bard / 2]){
		rotate([0, 90, 0]){
			cylinder(mainx, bard / 2, bard / 2);
		}
	}
} // blue