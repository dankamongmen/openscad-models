encheight = 122.5; // measured
hookheight = 3; // we only have 3mm between enclosures
backthick = 3;
tofan = 55; // distance from edge to 80mm fan
fanheight = 25;
tobrace = 40; // measured distance to FlexBay brace
frontwidth = fanheight + tobrace;
totalheight = encheight * 2 + hookheight * 3;
curve = 10;

module flat(){
  polygon([[encheight + hookheight, 16],
         [encheight + hookheight, 16 + tobrace],
         [hookheight, 16 + tobrace],
         [hookheight, 16]]);
}

difference(){
  union(){
    cube([totalheight, frontwidth, tofan]);
    translate([0, 0, -2]){
      difference(){
        linear_extrude(2){
          minkowski(){
            translate([10, 8, -20]){
              scale([0.8, 0.8, 1])
              offset(10){
                flat();
              }
            }
          }
          minkowski(){
            translate([140, 8, -20]){
              scale([0.8, 0.8, 1])
              offset(10){
                flat();
              }
            }
          }
        }
        union(){
          linear_extrude(2){
            for(ul = [1 : 4]){
              polygon([[ul * encheight / 5 - 10, 16],
                      [ul * encheight / 5, frontwidth - 10],
                      [ul * encheight / 5 + 10, frontwidth - 10],
                      [ul * encheight / 5, 16]]);
            }
          }
          linear_extrude(2){
            for(ul = [1 : 4]){
              polygon([[totalheight - ul * encheight / 5 + 10, 16],
                       [totalheight - ul * encheight / 5, frontwidth - 10],
                       [totalheight - ul * encheight / 5 - 10, frontwidth - 10],
                       [totalheight - ul * encheight / 5, 16]]);
            }
          }
        }
      }
    }
  }
  union(){
    translate([hookheight, backthick, backthick]){
      cube([totalheight - hookheight * 2, frontwidth, tofan]);
    }
    cube([totalheight, curve, curve]);
  }
}

// round the corner
difference(){
  translate([0, curve, curve]){
    rotate([0, 90, 0]){
      cylinder(totalheight, curve, curve);
    }
  }
  translate([hookheight, hookheight, hookheight]){
    cube([totalheight - hookheight * 2, curve * 2, curve * 2]);
  }
}
