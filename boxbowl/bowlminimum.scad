include <bowl.scad>

current_color = "ALL";

rwallr = 8; // same thickness as honeycomb

mtotx = mainx + rwallr * 2;
mtoty = mainy + rwallr;
mtotz = mainz + rwallr * 2 - 6;

htotx = height + 2 * wall - 0.05; // FIXME eliminate
xoffbase = -100.2; // FIXME eliminate
module lfill(){
	polygon([[xoffbase, -33],
				 [xoffbase, -29 + htotx],
				 [xoffbase + htotx / 2 + 0.5, -28 + 2 * htotx / 3],
				 [xoffbase + htotx / 2 + 0.5, -35 + htotx / 3]]);
}

//hexh = 5.77349; // 10**2 + x**2 = 11.547**2
hexh = 7.5;
hexy = 26.5;
module sidecomb(){
	translate([0, mtoty / 2, mtotz / 2 - 3]){
		rotate([0, 90, 0]){
			hexwall(8, 3);
			// fill in the top holes (on the left side, bottom on right)
			for(i = [0:1:7]){
				linear_extrude(8){
					polygon([[xoffbase + i * htotx, hexy + hexh],
									 [xoffbase + i * htotx + 11.8, hexy],
									 [xoffbase + i * htotx + 23.6, hexy + hexh]]);
					polygon([[xoffbase + i * htotx, -hexy - hexh],
									 [xoffbase + i * htotx + 11.8, -hexy],
									 [xoffbase + i * htotx + 23.6, -hexy - hexh]]);
				}
			}
			linear_extrude(8){
				polygon([[xoffbase + 8 * htotx, 34],
				         [xoffbase + 8 * htotx + wall + height / 2, 27],
				         [xoffbase + 8 * htotx + wall + height / 2, 34]]);
				polygon([[xoffbase + 8 * htotx, -34],
				         [xoffbase + 8 * htotx + wall + height / 2, -27],
				         [xoffbase + 8 * htotx + wall + height / 2, -34]]);
				// fill in the front holes on both sides
				translate([0, -1, 0]){
					lfill();
				}
				translate([0, height * 2, 0]){
					lfill();
				}
				// fill in the back hole on both sides
				translate([0, height - 1, 0]){
					mirror([1, 0, 0]){
						lfill();
					}
				}
			}
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
			roundedcube([mainx, mainy, mainz * rwallr], false, wallr, "ymin");
		}
		// remove the bottom half of the bottom
		translate([0, 0, 0]){
			cube([mtotx, rwallr / 2, mtotz]);
		}
		// remove the back half of the back
		translate([0, 0, 0]){
			cube([mtotx, mtoty, rwallr / 2]);
		}
		// cut triangles into back panel to reduce material requirements
		backtriangle(20, mainx / 2);
		backtriangle(totx - 20, totx - mainx / 2);
		// remove the sides to insert the honeycomb
		translate([0, rwallr + wallr, rwallr + wallr + 5]){
			cube([mtotx, mainy - rwallr - wallr -1, mainz - wallr - 19]);
		}
		// passageways for bolts
		translate([0, mainy - boltd / 2, mtotz - rwallr - boltd / 2]){
			rotate([0, 90, 0]){
				cylinder(mtotx, boltd / 2, boltd / 2);
				//screw_hole("M5", length=wallx * 2);
			}
		}		
	}
}

translate([0, 1, wallz]){
	// left side
	translate([8, mtoty, 0]){
		rotate([180, 180, 0]){
			sidecomb();
		}
	}
}
// right side
translate([totx - 8, 1, 3]){
	sidecomb();
}

multicolor("blue"){
	// tower in front center for bolts
	// we have about 20mm of gap between the two boxes
	translate([(mtotx - towerw) / 2, rwallr, mtotz - bard - boltd / 2 + 1]){
		rotate([0, 90, 0]){
			// triangle support for tower
			translate([2, 0, wallr]){
				linear_extrude(towerw - wallr * 2){
						polygon([
							[towerd / 2, 0],
							[towerd / 2, mainy - 2],
							[towerd, 0]
						]);
				}
			}
			difference(){
				roundedcube([towerd - wallz * 3 + 1, mainy - 2, towerw], false, wallr, "y");
				// two threaded M5 holes (need different thread orientation on each side)
				translate([(towerd + wallr * 2 - wallz * 3 - boltd) / 2, mainy - 8 - boltd / 2, 0]){
					screw_hole("M5", length=towerw * 2, thread=true);
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

// for testing
/*multicolor("red"){
	translate([0, mtoty - rwallr - boltd / 2, mtotz - rwallr - boltd / 2]){
		rotate([0, 90, 0]){
			cylinder(mtotx, boltd / 2, boltd / 2);
		}
	}
}*/