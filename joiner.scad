// these modular units are printed as pairs according to their shearing. they
// are unoriented; it is sufficient to print two copies of one half. looking out
// into the open face, the left side is male, and the right side is female. the
// fastener is split into thirds, with the male insert in the middle.abs
//
// we need be able to snap in components (rather than sliding them in).
tabheight = 3;

// the model total unit is 50mm long. a central circle has four rectangular
// sections at its compass points. two are simple; the other two are fasteners.
// all lie 5mm in from the sides.
unitlength = 50;
margin = 5;

r = 8;
d = 2 * r;
pwidth = r * 2 - 4;

module rod(l) {
  cube([1, 1, l]);
}

// we're missing our top, which is where a pairing will sit
module dunit(length) {
  plength = length - margin * 2;
  difference(){
    union(){
      difference(){
        cylinder(length, r, r, true);
        // cut out the core
        cylinder(length, r - 1, r - 1, true);
      }
      difference(){
        translate([0, -(r - 1), 0]){
          cube([pwidth, tabheight, plength], true);
        }
        cylinder(length, r, r, true);
      }
      difference(){
        rotate([0, 0, 90]){
          translate([0, -(r - 1), 0]){
            cube([pwidth, tabheight, plength], true);
          }
        }
      }
      difference(){
        translate([-(r - 1), 0, 0]){
          rotate([0, 0, 90]){
            cube([pwidth, tabheight, plength], true);
          }
        }
      }
      translate([-pwidth / 2 - 1, -pwidth / 2 - 1, -plength / 2]){
        rod(plength);
      }
      translate([pwidth / 2, -pwidth / 2 - 1, -plength / 2]){
        rod(plength);
      }
    }
    union(){
      // cut off the top
      translate([-(d + tabheight) / 2, 0, -length / 2]){
        cube([d + tabheight, r, length]);
      }
      // female receptacle on right (looking up)
      give = 0.3;
      translate([r - tabheight / 3 - give / 2,
                 -(pwidth + give) / 2 + 1,
                 -(plength - margin + give) / 2]){
        cube([tabheight / 3 + give,
              pwidth / 2 - 1 + give,
              plength - margin + give]);
      }
    }
  }
  // male fitting on left (looking up)
  translate([-r, 0, -(plength - margin) / 2]){
    cube([tabheight / 3, pwidth / 2 - 1, plength - margin]);
  }
}

dunit(unitlength);