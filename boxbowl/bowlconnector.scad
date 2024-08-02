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

hws_insert(centerHole=true);
translate([-5, 0, -5]){
	cube([10, 270, 5]);
}
translate([0, 270, 0]){
	hws_insert(centerHole=true);
}
translate([-10, 0, -5]){
	join();
}
translate([-10, 270, -5]){
	join();
}