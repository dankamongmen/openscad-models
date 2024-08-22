// distance between sensors is 28.6 on the inside and 30.16
// on the outside, roughly checking out with their ~1mm width.
gap = 28.6;
sensorw = 1.1;

outl = 88.37;
thick = sensorw + 0.6;
h = 4;

difference(){
	cube([gap + 2 * (1 + sensorw), outl + 2, h]);
	union(){
		translate([1, 1, 2]){
			cube([thick, outl, h]);
		}
		translate([1 + gap, 1, 2]){
			cube([thick, outl, h]);
		}
	}
}