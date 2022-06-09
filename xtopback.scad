// we want something that can sit across the
// 5.25" bay holders, which are 146.1mm wide
w = 146.1;

// 15mm from xtop brace to back
m = 15;

// come just about down to the bottom
h = 70;

// brace we're topping is 1.5mm wide. give it
// an extra half mm.
i = 2;

// the wings on the sides hold us onto the
// braces. if they're too thin, they'll break off.
ww = 3;

translate([-w/2, 0, 0]){
    // left wing
    translate([-(i + ww), 0, -h]){
      cube([ww, m, h]);
    }
    translate([-(i + ww), 15, -h]){
      cube([ww, m, h - 15]);
    }
    
    // common layer
    translate([-(i + ww), 0, 0]){
        minkowski(){
            cube([w + i * 2 + ww * 2, m, 1.5]);
            rotate([90, 90, 0]){
                cylinder(r = 2, h = 2);
            }
        }
    }
    // middle piece to wedge us atop bay mounts
    translate([i + 1, -1, -4]){
        cube([w - i * 2 - 2, m, 4]);
    }
    // right wing
    translate([w + i, 0, -h]){
      cube([ww, m, h]);
    }
    translate([w + i, 15, -h]){
      cube([ww, m, h - 15]);
    }

    // backplate
    translate([-i, m + 12, -h]){
      cube([w + i * 2, ww, h - 15]);
    }

}

difference(){
  translate([0, m, -m + 1]){
    rotate([0, 90, 0]){
      minkowski(){
        cylinder(w + i * 3, m, m, true);
        rotate([90, 90, 0]){
          cylinder(2, 2, 2);
        }
      }
    }
  }
  union(){
    translate([0, 0, -45]){
      cube([w + i * 15, m * 4, m * 4], true);
    }
    translate([0, -m, -m]){
      cube([w + i * 15, m * 4, m * 4], true);
    }
  }
}
