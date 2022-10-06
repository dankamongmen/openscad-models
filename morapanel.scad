// panel for running kool through the wall

wall = 150;  // thickness of transfixed wall
//zmt = 19.05; // three-fourths of an inch diameter
kool = 28;  // max diameter of Koolance QD4 is 28mm
// golden ratio:
//  a = 2 * kool == 56
//  (a+x)/a = a/x
//  ax/a + xx/a = a
//  x + xx/a = a
//  xx/a = a - x
//  xx = aa - xa
//  xx = 3136 - 56x
//  x = 34.6
x = 34.6; // amount of free space in width
w = 2 * kool + x;
// (w+h) / w = w/h
// hh = ww - wh
// hh = 8208.36 - 90.6h
// h = 55.99
h = 60;

// placement of right hole
centx = x / 6 + kool / 2;

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
		cylinder(wall / 2, (kool + cthick + cgap) / 2, (kool + cthick + cgap) / 2);
		cylinder(wall / 2, (kool + cgap) / 2, (kool + cgap) / 2);
	}
}

difference(){
	union(){
		linear_extrude(3){
			translate([-w / 2, -h / 2, 0]){
				rounded(w, h, 5);
			}
		}
		translate([-centx, 0, 0]){
			tube();
		}
		translate([centx, 0, 0]){
			tube();
		}
	}
	linear_extrude(3){
		translate([-centx, 0, 0]){
			circle((kool + cgap) / 2);
		}
		translate([centx, 0, 0]){
			circle((kool + cgap) / 2);
		}
	}
}
