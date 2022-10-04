// panel for running ZMT through the wall

wall = 150;  // thickness of transfixed wall
zmt = 19.05; // three-fourths of an inch diameter
w = 70;
h = zmt + 10;

module rounded( width, height, radius_corner ) {
	translate( [ radius_corner, radius_corner, 0 ] )
		minkowski() {
			square( [width - 2 * radius_corner, height - 2 * radius_corner]);
			circle( radius_corner );
		}
}

// combined thickness of walls around tubes
cthick = 2;
// combined gaproom of walls around tubes
cgap = 1;

module tube(){
	difference(){
		cylinder(wall / 2, (zmt + cthick + cgap) / 2, (zmt + cthick + cgap) / 2);
		cylinder(wall / 2, (zmt + cgap) / 2, (zmt + cgap) / 2);
	}
}

difference(){
	union(){
		linear_extrude(3){
			translate([-w / 2, -h / 2, 0]){
				rounded(w, h, 5);
			}
		}
		translate([-15, 0, 0]){
			tube();
		}
		translate([15, 0, 0]){
			tube();
		}
	}
	linear_extrude(3){
		translate([-15, 0, 0]){
			circle((zmt + cgap) / 2);
		}
		translate([15, 0, 0]){
			circle((zmt + cgap) / 2);
		}
	}
}
