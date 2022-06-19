// cable runner from PSU to drive cages, enclosing two SATA cables with
// four power plugs each

include <MCAD/regular_shapes.scad>
include <vars.scad>

module octtube(){
  tubelen = 70;
  translate([-tubelen + backt, 25, 20]){
    rotate([0, 90, 0]){
      octagon_tube(tubelen, 11, 1);
    }
  }
}

difference(){
  union(){
        union(){
          // top and bottom faces
          translate([backt, 0, 0]){
            cube([sidew, latchh, depth]);
          }
          translate([backt, latchh + height, 0]){
            cube([sidew, latchh, depth]);
          }
          // back face
          cube([backt, height + 2 * latchh, depth]);
        }
        // riserlock on the top
        translate([0, height + latchh - riserdepth, backt]){
          cube([sidew + backt, riserdepth, risergap]);
          translate([0, 0, riserspace + risergap]){
            cube([sidew + backt, riserdepth, 4]);
          }
        }
        
        // riserlock on the bottom
        translate([0, latchh, backt]){
          cube([sidew + backt, riserdepth, risergap]);
        }
        translate([0, latchh + 4, risergap + backt + 4]){
          cube([sidew + backt, 4, 24]);
        }
  }
  hull(){
    octtube();
  }
}

//octtube();
