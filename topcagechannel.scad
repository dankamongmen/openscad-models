// cable runner from PSU to drive cages, enclosing two SATA cables with
// four power plugs each

height = 136; // measured
sidew = 60; // 30 on, 30 off
sidet = 4;
depth = 40;
latchh = 4;
backt = 4;
risergap = 8; // space occupied by drive mounts
riserspace = 2; // space occupied by drive cage
riserdepth = 4; // how far riser descends

union(){
      minkowski(){
        union(){
          // side face, with indentations for labeling drives
          translate([backt, latchh, 0]){
            difference(){
              cube([sidew, height, sidet]);
              union(){
                for(i = [10 : (height - 10) / 4 : 20 + (height - 10) * 3 / 4]){
                  translate([10, i, 0]){
                    cube([sidew - 2 * 10, 10, sidet / 2]);
                  }
                }
              }
            }
          }
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
        cylinder(0);
      }
      // riserlock on the top
      translate([0, height + latchh - riserdepth, backt]){
        cube([sidew + backt, riserdepth, risergap]);
        translate([0, 0, riserspace + risergap]){
          cube([sidew + backt, riserdepth, 4]);
        }
      }
}
