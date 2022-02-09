include <cyl_head_bolt.scad>
 union() {
  // the base for the 120x50mm unit -- 2mm sides
  difference() {
    cube([124,54,10]);
    union() {
      translate([2, 2, 2]) {
        cube([120,50,8]);
      }
      cube([2,10,20]);
      // cutaway for switch
      translate([32,50,4]) {
        cube([20,10,20]);
      }
      // hole for speaker hookup
      rotate([90,90,90])
        translate([-5,35,5])
          hole_through(name="M2", l=50+5, cld=0.1, h=10, hcld=0.4);
    }
  }
  // 2mm mounting "plate" with two M3 screw holes
  translate([0,0,0]) {
    difference() {
      cube([2,15,22]);
      rotate([90,90,90])
        translate([-8,5,5])
          hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
      rotate([90,90,90])
        translate([-16,5,5])
          hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
    }
  }
}
