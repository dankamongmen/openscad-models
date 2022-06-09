encheight = 122; // measured
hookheight = 2; // we only have 5mm between enclosures
theight = encheight + hookheight * 2;
backthick = 3;
tofan = 40; // distance from edge to 80mm fan
fanheight = 25;
tobrace = 40; // measured distance to FlexBay brace
frontwidth = fanheight + tobrace;

difference(){
  cube([theight, frontwidth, tofan]);
  union(){
    translate([hookheight, backthick, backthick]){
      cube([theight - hookheight * 2, frontwidth, tofan]);
    }
    cube([theight, 4, 4]);
    linear_extrude(2){
      for(ul = [1 : 4]){
        polygon([[ul * encheight / 5 + 10, 12],
                 [ul * encheight / 5, frontwidth - 10],
                 [ul * encheight / 5 - 10, frontwidth - 10],
                 [ul * encheight / 5, 12]]);
      }
    }
  }
}


// round the corner
difference(){
  translate([0, 5, 5]){
    rotate([0, 90, 0]){
      cylinder(theight, 5, 5);
    }
  }
  translate([hookheight, backthick, backthick]){
    cube([encheight, 8, 8]);
  }
}