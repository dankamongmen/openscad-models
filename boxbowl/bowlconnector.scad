include <hcomb-insert.scad>

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
	translate([10, -0.5, 0])
		rotate_extrude($fn=6, convexity=10)
	polygon([[11.6, 5], [11.6, 2], [0, 5]]);
}
}

// add some strength along the main axis, hopefully
sbarx = 5;
sbary = 270;
sbarz = 2;
translate([-sbarx / 2, 0, -sbarz - 5]){
	cube([sbarx, sbary, sbarz]);
}

module tophex(yoff){
	translate([0, yoff, -sbarz - 5]){
		rotate([0, 0, 30]){
			linear_extrude(sbarz){
				circle(7, $fn = 6);
			}
		}
	}
}

tophex(0);
tophex(sbary);

hws_insert(centerHole=false);
translate([-5, 0, -5]){
	cube([10, sbary, 5]);
}
translate([0, sbary, 0]){
	hws_insert(centerHole=false);
}
translate([-10, 0, -5]){
	join();
}
translate([-10, sbary, -5]){
	join();
}