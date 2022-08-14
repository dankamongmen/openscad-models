// these ought be printed clear, and used to lock in
// the labels on hard drive cages. the polygon is based
// off of enclosurewrapper.scad.

gap = 2;
vgap = 3;

linear_extrude(.8){
	polygon([
					 [10 - vgap, 40 - gap],
					 [0 + vgap, 0 + gap],
					 [-10 + vgap, 0 + gap],
					 [0 - vgap, 40 - gap]
					]);
}
