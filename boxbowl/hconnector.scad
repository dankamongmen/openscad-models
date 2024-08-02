include <hcomb-insert.scad>

// FIXME eliminate floats

module join(){
	hull(){
	linear_extrude(3)
		polygon([
			[0, 0],
			[5, 8],
			[15, 8],
			[20, 0],
			[15, -8],
			[5, -8]
		]);
	/*linear_extrude(1)
		translate([10, 0, 5]){
			polygon([
				[-12, 0],
				[-6, 10],
				[6, 10],
				[12, 0],
				[6, -10],
				[-6, -10]
			]);
		}
	}*/
	translate([10, -0.5, 0])
		rotate_extrude($fn=6, convexity=10)
	polygon([[11.6, 5], [11.6, 2], [0, 5]]);
}
}

difference(){
	union(){
		hws_insert(centerHole=true);
		translate([-10, 0, -5]){
			join();
		}
		rotate([180, 0, 0]){
			translate([0, 0, 40]){
				hws_insert(centerHole=true);
				translate([-10, 0, -5]){
					join();
				}
			}
		}
		translate([0, 0, -40]){
				cylinder(40, 10, 10, $fn=6);
		}
		}
	translate([0, 0, -40]){
		cylinder(40, 8, 8);
	}
}