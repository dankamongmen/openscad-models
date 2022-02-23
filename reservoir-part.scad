difference(){
    //for testing, we only want the top
union(){
  // cut a big chunk out of it, leaving three sides
  // depth is 2.25in (57.15mm)
  //  fix up by experimentation to 55
  // width to cover is 123.825mm (4.875in)
  // we'll use 4mm thick side walls -- 132
  // fix up with another mm -- 133
    difference(){
    cube([40,133,55]);
    union(){
  union(){
translate([7,5,8])
rotate([0,270,0])
  linear_extrude(2)
    text("schwarzgerät",size=5);
translate([7,125,48])
rotate([0,90,180])
  linear_extrude(2)
    text("schwarzgerät",size=5);
  }
      cube([5,133,55]);
      translate([10,4,0])
      // 124mm for inside area
      difference(){
        cube([110,125,57]);
        // add two 4mm wings to hold it in, with 2mm between the
        // sidewalls and wings. we're short by 4mm on each side,
        // leaving 49mm.
        translate([0, 2.5, 4])
          cube([20,4,49]);
        translate([0, 118.5, 4])
          cube([20,4,49]);
      }
    }
  }
}
}