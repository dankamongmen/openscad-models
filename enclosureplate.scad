// big plate that fits into enclosurewrapper.scad

// plugging into 253mm tall
tall = 253;
minkow = 2;
gap = 0.3;

difference(){
  minkowski(){
    sphere(minkow);
    cube([tall - (minkow + gap) * 2, 132, 1], true);
  }
  union(){
    translate([0, 0, -3]){
      cube([400, 400, 3], true);
    }
      translate([70, -50, 2]){
        rotate([0, 0, 90]){
          linear_extrude(3){
            offset(0.1){
              import("/home/dank/src/dankamongmen/openscad-models/tux.svg");
            }
          }
        }
      }
  }
}

