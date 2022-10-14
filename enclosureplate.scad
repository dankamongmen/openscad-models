// big plate that fits into enclosurewrapper.scad

// plugging into 253mm tall
tall = 253;
minkow = 2;
gap = 0.3;

difference(){
  minkowski(){
    sphere(minkow);
    cube([tall - (minkow + gap) * 2, 132, 0.5], true);
  }
  union(){
    translate([0, 0, -3]){
      cube([400, 400, 3], true);
    }
  }
}

