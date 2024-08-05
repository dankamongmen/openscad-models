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
	translate([10, -0.5, 0]){
		rotate_extrude($fn=6, convexity=10){
			polygon([[11.6, 5], [11.6, 2], [0, 5]]);
		}
	}
}
}

// add some strength along the main axis, hopefully
sbarx = 5;
sbary = 210;
sbarz = 2;
translate([-sbarx / 2, 0, -sbarz - 5]){
	cube([sbarx, sbary, sbarz]);
}

module tophex(yoff){
	translate([0, yoff, -sbarz - 5]){
		linear_extrude(sbarz){
			circle(5, $fn = 6);
		}
	}
}

tophex(0);
tophex(210);

rotate([0, 0, 30]){
	hws_insert(centerHole=false);
}
translate([-5.5, 0, -5]){
	cube([10, 210, 5]);
}
translate([0, 210, 0]){
	rotate([0, 0, 30]){
		hws_insert(centerHole=false);
	}
}
translate([-9, -5, -5]){
	rotate([0, 0, 30]){
		join();
	}
}
translate([-9, 205, -5]){
	rotate([0, 0, 30]){
		join();
	}
}