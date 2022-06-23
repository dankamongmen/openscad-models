// two quasi-elliptical plugs separated by a long rod, fit for bridging
// the top two central plugs and supporting a CCFL.

r = 9; // radius of 9 on the plug cylinders
outerr = 7.5; // thickness of plug wrap
innerplug = 45;                     // inner plug width
cyldist = innerplug - r * 2;        // width between cylinder foci
outerplug = innerplug + 2 * outerr; // full plug width
distance = 92;                     // distance between extremal outer points
plugheight = 10; // arbitrary, enough to test FIXME

module plug2dsolid(){
  hull(){
    mirror([1, 0, 0]){
      translate([cyldist / 2, 0, 0]){
        circle(r);
      }
    }
    translate([cyldist / 2, 0, 0]){
      circle(r);
    }
  }
}

module plug2d(){
  difference(){
    plug2dsolid();
    offset(-1.5){
      plug2dsolid();
    }
  }  
}

module plug3d(){
  translate([-(outerplug / 2 + distance / 2), 0, 0]){
    linear_extrude(plugheight){
      plug2d();
    }
  }
}

plug3d();
mirror([1, 0, 0]){
  plug3d();
}

translate([-(distance / 2 + cyldist + r + outerr), r, 0]){
  cube([distance + (r + outerr + cyldist) * 2, 2, 4]);
}