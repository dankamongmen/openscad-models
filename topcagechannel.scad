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
                for(i = [50 : (height - 50) / 4 : 20 + (height - 10) * 3 / 4]){
                  translate([5, i, 0]){
                    cube([sidew - 10, 10, sidet / 2]);
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

  translate([104, -25, 0]){
    linear_extrude(height = 5, center = true, convexity = 10){
      offset(0.1)
      scale([.5, .5, .5]){
        rotate([0, 180, 0]){
          import(file="exos.dxf");
        }
      }
    }
  }
}