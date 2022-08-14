// a single 5.25" flex bay brace is a long cuboid with
// four holes, and a short cuboid with two. the holes
// of the two cuboids are not aligned, and the two
// sides of each brace are oriented.
h = 41.3;

difference(){
  cube([131.77, h, 1.64]);
  union(){
      translate([119.96, 9.51, 0.82]){
          sphere(1.67);
      }
      translate([38.37, 9.51, 0.82]){
          sphere(1.67);
      }
  }
  translate([119.96, 20.76, 0.82]){
          sphere(1.67);
      }
      translate([38.37, 20.76, 0.82]){
          sphere(1.67);
      }
  }

difference(){
    cube([1.7, h,12.5]);
    union(){
        translate([0, 21, 6.16]){
            rotate([0, 90, 0]){
                cylinder(2, 1.67, 1.67);
            }
        }
        translate([0, 34, 6.16]){
            rotate([0, 90, 0]){
                // FIXME should be an elliptical cylinder 5            mm x 3.33
                cylinder(2, 2.5, 1.67);
            }
        }
    }
}
