include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <hcomb-insert.scad>

module join(){
	hull(){
		linear_extrude(3){
			polygon([
				[0, 0],
				[5, 8],
				[15, 8],
				[20, 0],
				[15, -8],
				[5, -8]
			]);
		}
		translate([10, -0.5, 0]){
			rotate_extrude($fn=6, convexity=10){
				polygon([[11.6, 5], [11.6, 2], [0, 5]]);
			}
		}
	}
}

// triangle channels on top to avoid floats
module toptri(){
	translate([2, 3, -5]){
		rotate([-90, 0, 0]){
			linear_extrude(sbary){
				polygon([
									[0, 0],
									[5 - sbarx / 2, 0],
									[0, sbarz]
								]);
			}
		}
	}
}

module tophex(yoff){
	translate([0, yoff, -sbarz - 5]){
		linear_extrude(sbarz){
			circle(7, $fn = 6);
		}
	}
}

sbarx = 5;
sbary = 214;
sbarz = 2;

difference(){
	union(){
		// TOPMOST section-add some strength along the main axis, hopefully
		translate([-sbarx / 2, 0, -sbarz - 5]){
			cube([sbarx, sbary, sbarz]);
		}

		toptri();
		mirror([1, 0, 0]){
			toptri();
		}

		tophex(0);
		tophex(sbary);

		rotate([0, 0, 30]){
			hws_insert(centerHole=false);
		}
		translate([-5.5, 0, -5]){
			cube([10, sbary, 5]);
		}
		translate([0, sbary, 0]){
			rotate([0, 0, 30]){
				hws_insert(centerHole=false);
			}
		}
		translate([-9, -5, -5]){
			rotate([0, 0, 30]){
				join();
			}
		}
		translate([-9, sbary - 5, -5]){
			rotate([0, 0, 30]){
				join();
			}
		}
	}
	union(){
		translate([0, 0, 5]){
			screw_hole("M3", length=10, thread=true);
		}
		translate([0, sbary, 5]){
			screw_hole("M3", length=10, thread=true);
		}
	}
}