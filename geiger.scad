include <cyl_head_bolt.scad>
 union() {
  // the base for the 120x50mm unit -- 2mm sides
  difference() {
      translate([-1,0,0])
    cube([125,54,12]);
    union() {
      translate([2, 2, 2]) {
        cube([120,50,10]);
      }
      cube([2,10,20]);
      // cutaway for switch
      translate([86,0,6]) {
        cube([15,10,15]);
      }
      // hole for speaker hookup
      translate([120, -18.5, 0]){
      rotate([90,90,90])
      translate([-5,35,5])
      hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
      }
    }
  }
  // 2mm mounting "plate" with two M3 screw holes
  translate([-2,0,0]) {
    difference() {
      cube([4,18,34]);
      rotate([90,90,90])
        translate([-15,6,5])
          hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
      rotate([90,90,90])
        translate([-28,6,5])
          hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
    }
  }
}
