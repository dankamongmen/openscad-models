// through-plug + cable box for back of caselabs T10

s=8.5;
t=10;
w=99;
h=88;
zh=15;
mzh = 15 - 2 * 0.3;
midheight = 10;
bottom = -10;
hook = 5;
width = 21 + 2 * hook; // gap of 20 between them, and 5mm on each to hook
midwidth = 11; // actual width of middle *gap* (box is larger, for walls)
midthick = 3;
// other baskets are 88 tall in their entirety; we want to rise just a bit higher up
midtall = 80 - midheight + 5;

// middle fitting
module bottom(){
  cube([width, 1, 21]);
}

// middle box
module midbox(){
  translate([(width - (midwidth + midthick * 2)) / 2, bottom, -mzh + 1 - midtall]){
    cube([midwidth + midthick * 2, midheight, midtall]);
  }
}

difference(){
  union(){
    difference(){
        translate([-57, -20, -zh]){
            cube([w + 7, h, zh]);
        }
        union(){
            // main cavity, closed bottom
            translate([-(w-10)/2 - 7, -18, -(zh -2)]){
                cube([w - 1, h, zh - 5]);
            }
            // inlet on left side
            translate([40, -10, -(zh - 1)]){
                cube([10, 50, zh]);
            }
            // inlet on right side
            translate([-57, -10, -(zh - 1)]){
                cube([10, 20, zh]);
            }
            // area intersecting with plug
            translate([-4, -7.5, -3]){
                cube([30, 15, 3]);
            }
            // bottom of back is open
            translate([-3, -22.5, -10]){
                cube([29, 20, 10]);
            }
            // top of back is open
            translate([-55, 55, -5]){
                cube([w + 3, 15, 5]);
            }
    
         }
    }
    translate([33, -10, -15])
        rotate([0, 180, 0])
            linear_extrude(2)
                text("III", font="Liberation Sans:style=Bold Italic", size=70);
    translate([43, 58, -15])
        rotate([180, 0, 270])
            linear_extrude(2)
                text("schwarzgerät", size=8.5);
    // round element (plug)
    difference(){
        union(){
            translate([-5, 0, 0]){
                cylinder(t, s, s);
            }
            translate([-5, -s , 0]){
              cube([30, s*2, t]);
            }
            translate([25, 0, 0]){
              cylinder(t, s, s);
            }
        }
        union(){
            translate([-5, 0, 0]){
                cylinder(15, s - 1, s- 1);
            }
            translate([-5, -12.5, 0]){
                cube([34, s*2 + 2, 35]);
            }
            translate([25, 0, 0]){
                cylinder(15, s - 1, s - 1);
            }
        }
    }
    
    translate([-132, 0, 0]){
      difference(){
        translate([-w/2 + 5, -20, -zh]){
            cube([w + 7, h, zh]);
        }
        union(){
            // main cavity, closed bottom
            translate([-(w-10)/2 + 7, -15, -(zh -2)]){
                cube([w - 3, h, zh - 5]);
            }
            // inlet on left side
            translate([55, -10, -(zh - 1)]){
                cube([10, 20, zh]);
            }
            // inlet on right side
            translate([-45, -10, -(zh - 1)]){
                cube([10, 20, zh]);
            }
            // area intersecting with plug
            translate([-25, -7.5, -3]){
                cube([30, 15, 3]);
            }
            // bottom of back is open
            translate([-25, -22.5, -10]){
                cube([29, 20, 10]);
            }
            // top of back is open
            translate([-42, 55, -5]){
                cube([w + 3, 15, 5]);
            }
        }
    }
    
      translate([45, -10, -15])
          rotate([0, 180, 0])
              linear_extrude(2)
                  text("III", font="Liberation Sans:style=Bold Italic", size=70);
      translate([55, 58, -15])
          rotate([180, 0, 270])
              linear_extrude(2)
                  text("schwarzgerät", size=8.5);
      // round element (plug)
      difference(){
          union(){
              translate([-25, 0, 0]){
                  cylinder(t, s, s);
              }
              translate([-25, -s , 0]){
                cube([30, s*2  ,t]);
              }
              translate([5, 0, 0]){
                cylinder(t , s, s);
              }
          }
          union(){
              translate([-25, -22.5, 0]){
                  cube([23, 20, 20]);
              }
              translate([-25, 0, 0]){
                  cylinder(15, s - 1, s- 1);
              }
              translate([-24, -9, 0]){
                  cube([30, s*2 -2, 15]);
              }
              translate([5, 0, 0]){
                  cylinder(15, s - 1, s - 1);
              }
          }
      }
    }
    
    
    translate([-78, -3, 0]){  
      rotate([90, 0, 0]){
        difference(){
          translate([0, bottom - 4, -(mzh - 1)]){
            bottom();
          }
          translate([0, bottom + 1, -mzh]){
            scale([1, 0.9, 0.9]){
              bottom();
            }
          }
        }
        
        translate([7, -13, -23]){
          cube([midwidth + 3, 3, 10]);
        }
        
        hookheight = 5;
        coverwidth = (width - hook * 2 - midwidth) / 2;
        
        
        // hollow middle box with missing back
        difference(){
          midbox();
          translate([midthick / 2, midthick / 2, 0]){
            scale([0.9, 0.9, 1]){
              midbox();
            }
          }
        }
      }
    }
  }
  // lop off the front
  translate([-200, -200, -100]){
    cube([400, 400, 91]);
  }
}