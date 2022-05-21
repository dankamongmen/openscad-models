difference(){
  union(){
    cylinder(10, r=34.5, true);
    translate([0, 0, 10]){
        cylinder(4, 38, true);
    }
  }
  translate([-20, -5, 0]){
    cube([40, 10, 14]);
  }
}