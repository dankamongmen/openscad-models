difference(){
  union(){
    cylinder(10, r=17, true);
    translate([0, 0, 10]){
        cylinder(4, 19, true);
    }
  }
  cube([23.6, 8.6, 28], true);
}