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

difference(){
  union(){
        union(){
          // side face, with indentations for labeling drives
          translate([backt, latchh, 0]){
            difference(){
              cube([sidew, height, sidet]);
              union(){
                linear_extrude(2){
                  for(ul = [1 : 4]){
                    polygon([[16, height - ul * height / 5 + 10],
                             [sidew - 10, height - ul * height / 5],
                             [sidew - 10, height - ul * height / 5 - 10],
                             [16, height - ul * height / 5]]);
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
}
