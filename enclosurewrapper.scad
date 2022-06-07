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
  translate([hookheight, backthick, backthick]){
    cube([theight - hookheight * 2, frontwidth, tofan]);
  }
}