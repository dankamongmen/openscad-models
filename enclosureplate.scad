// big plate that fits into enclosurewrapper.scad

// plugging into 253mm tall
tall = 253;
minkow = 2;

difference(){
  minkowski(){
    sphere(minkow);
    cube([tall - minkow * 2, 132, 1], true);
  }
  union(){
    translate([0, 0, -3]){
      cube([400, 400, 3], true);
    }
  }
}
