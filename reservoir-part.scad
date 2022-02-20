union(){
  // cut a big chunk out of it, leaving three sides
  // depth is 2.25in (57.15mm)
  // width to cover is 123.825mm (4.875in)
  // we'll use 4mm thick side walls -- 132
  difference(){
    cube([120,132,57]);
    translate([10,4,0])
      // 124mm for inside area
      difference(){
        cube([110,124,57]);
        // add two 4mm wings to hold it in, with 2mm between the
        // sidewalls and wings. we're short by 4mm on each side,
        // leaving 49mm.
        translate([0, 2, 4])
          cube([20,4,49]);
        translate([0, 118, 4])
          cube([20,4,49]);
    }
  }
}