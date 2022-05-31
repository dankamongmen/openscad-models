jheight = 25;
jradius = 8.5;
lwidth = 30;

module topplug(){
  hull(){
    circle(jradius);
    translate([lwidth, 0, 0]){
      circle(jradius);
    }
  }
}

module cplug(){
  difference(){
    hull(){
      cylinder(jheight, jradius, jradius);
      translate([lwidth, 0, 0]){
        cylinder(jheight, jradius, jradius);
      }
    }
    scale([0.9, 0.9, 1]){
      hull(){
        cylinder(jheight, jradius, jradius);
        translate([lwidth, 0, 0]){
          cylinder(jheight, jradius, jradius);
        }
      }
    }
  }
}


difference(){
  union(){
    rotate_extrude(angle=90){
      translate([20, 0, 0]){
        rotate([0, 0, 90]){
          topplug();
        }
      }
    }
    scale([1, 2, 1]){
      translate([20, 0, 30]){
        rotate([90, 90, 0]){
          cplug();
        }
      }
    }
  }

  
  union(){
    rotate_extrude(angle=90){
      translate([20, 3, 0]){
        scale([0.8, 0.8, 0.8]){
          rotate([0, 0, 90]){
            topplug();
          }
        }
      }
    }
  }
}