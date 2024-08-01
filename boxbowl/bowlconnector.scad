include <hcomb-insert.scad>

// FIXME use helix_extrude to extend across bottom, eliminating floats

module join(){
	linear_extrude(5){
		polygon([
			[0, 0],
			[5, 8],
			[15, 8],
			[20, 0],
			[15, -8],
			[5, -8]
		]);
	}
}

hws_insert(centerHole=true);
translate([-5, 0, -5]){
	cube([10, 190, 5]);
}
translate([0, 190, 0]){
	hws_insert(centerHole=true);
}
translate([-10, 0, -5]){
	join();
}
translate([-10, 190, -5]){
	join();
}