include <cyl_head_bolt.scad>
 union() {
  difference() {
    cube([122,52,5]);
    translate([1, 1, 1]) {
      cube([120,50,4]);
    }
  }
  translate([0,0,0]) {
    difference() {
      cube([1,15,22]);
        rotate([90,90,90])
translate([-8,5,5])
hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
rotate([90,90,90])
translate([-16,5,5])
hole_through(name="M3", l=50+5, cld=0.1, h=10, hcld=0.4);
  
 /*
      rotate([90,90,90]) {
        translate([-8,4,0]) {
          cylinder(h=5,r=2);
        }
      }
      rotate([90,90,90]) {
        translate([-15,4,0]) {
          cylinder(h=5,r=2);
        }
      }
 */
    }
  }
}
