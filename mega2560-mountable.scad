include <arduino.scad>
include <cyl_head_bolt.scad>

union(){
  difference(){
    enclosure(MEGA2560);
    translate([-20,-20,25])
      cube([400,400,10]);
    translate([0,104,0])
      cube([10,20,40]);
  }
    // 2mm mounting "plate" with two M3 screw holes
  translate([10,104,0]) {
    rotate([0,0,90])
    difference() {
      cube([4,15,40]);
      rotate([90,90,90])
        translate([-24,6,5])
          hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
      rotate([90,90,90])
        translate([-35,6,5])
          hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
    }
  }
}