jheight = 25;
jradius = 9;
lwidth = 29;

module topplug(){
  hull(){
    circle(jradius);
    translate([lwidth, 0, 0]){
      circle(jradius);
    }
  }
}

module cplug(jh = jheight){
  difference(){
    hull(){
      cylinder(jh, jradius, jradius);
      translate([lwidth, 0, 0]){
        cylinder(jh, jradius, jradius);
      }
    }
    scale([0.9, 0.9, 1]){
      hull(){
        cylinder(jh, jradius, jradius);
        translate([lwidth, 0, 0]){
          cylinder(jh, jradius, jradius);
        }
      }
    }
  }
}

module shearAlongX(p) {
  multmatrix([
    [1, 0, 0, 0],
    [p.y / p.x, 1, 0, 0],
    [p.z / p.x, 0, 1, 0]
  ]) children();
}

module shearAlongY(p) {
  multmatrix([
    [1, p.x / p.y, 0, 0],
    [0, 1, 0, 0],
    [0, p.z / p.y, 1, 0]
  ]) children();
}

module shearAlongZ(p) {
  multmatrix([
    [1, 0, p.x / p.z, 0],
    [0, 1, p.y / p.z, 0],
    [0, 0, 1, 0]
  ]) children();
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

  // hollow vertical straightaway, without back
  difference(){  
      translate([20, -25, 4]){
        rotate([90, 90, 0]){
          cplug();
        }
      }
      // remove back of vertical straightaway
      translate([10, -50, -25]){
        cube([10, 15, 30]);
      }
  }
  
    // sheared joiner
    shearAlongY([0, -30, -30]){
      translate([20, 0, lwidth]){
        rotate([90, 90, 0]){
          cplug();
        }
      }  
    }

    // hollow horizontal straightaway  
    scale([1, 1, 1]){
      translate([-10, 20, lwidth]){
        rotate([0, 90, 0]){
          cplug(jheight / 2);
        }
      }
    }


  }


  // hollow out top bend  
  union(){
    rotate_extrude(angle=90){
      translate([20, 3, 0]){
        scale([0.9, 0.9, 0.9]){
          rotate([0, 0, 90]){
            topplug();
          }
        }
      }
    }
  }

}