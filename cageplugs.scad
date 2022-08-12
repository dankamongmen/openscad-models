// these ought be printed clear, and used to lock in
// the labels on hard drive cages. the polygon is based
// off of enclosurewrapper.scad.

gap = 0.6;

linear_extrude(2 - gap){
	polygon([
					 [10 - gap, 12 - gap],
					 [0 + gap, -10 + gap],
					 [-10 + gap, -10 + gap],
					 [0 + gap, 12 - gap]
					]);
}