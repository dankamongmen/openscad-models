include <cyl_head_bolt.scad>

outw = 37.5;
outl = 88.37;
thick = 1.5 + .6;
h = 8;

difference(){
	cube([outw + 2, outl + 2, h]);
	union(){
		translate([1, 1, 2]){
			cube([thick, outl, h]);
		}
		translate([outw + 1 - thick, 1, 2]){
			cube([thick, outl, h]);
		}
		translate([(outw + 2) / 2, 5, h]){
		  hole_threaded(name="M4", h, "yes", cltd=0.6);
		}
		translate([(outw + 2) / 2, outl - 5, h]){
		  hole_threaded(name="M4", h, "yes", cltd=0.6);
		}
	}
}