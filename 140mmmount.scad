//import("/home/dank/Downloads/Middle_Part.STL");

// 140mm wide on either side, and 50mm tall
// (fan is ~25mm tall, top is ~75mm)
side = 140;
height = 60;
difference() {
  cube([side + 10, side + 10, height]);
  union(){
    // cut out the inside, save for 5mm on each side
    translate([5, 5, 0]){
      cube([side, side, height]);
    }
   
    for (y = [0, 30]) { 
        // cut out all but the corners for 20mm
        translate([5, 0, y]){
          cube([side, side + 10, 20]);
        }
        translate([0, 5, y]){
            cube([side + 10, side, 20]);
        }
    }
    
    // remove one wall entirely
    translate([0, 0, 50]){
        cube([side + 10, 10, 25]);
        cube([10, side + 10, 25]);
    }
  }
}

// add supports for underside of fan
translate([0, 0, 48]){
  cube([15, 15, 2]);
}
translate([side - 5, 0, 48]){
  cube([15, 15, 2]);
}
translate([0, side - 5, 48]){
  cube([15, 15, 2]);
}
translate([side - 5, side - 5, 48]){
  cube([15, 15, 2]);
}
