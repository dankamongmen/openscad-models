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

    // hollow vertical straightaway  
   translate([20, 0, 30]){
      rotate([90, 90, 0]){
        cplug();
      }
    }
  
    // sheared joiner
    shearAlongY([0, -30, -30]){
      translate([20, -25, 55]){
        rotate([90, 90, 0]){
          cplug();
        }
      }  
    }

    // hollow horizontal straightaway  
    scale([1, 1, 1]){
      translate([-10, 20, 30]){
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
        scale([0.8, 0.8, 0.8]){
          rotate([0, 0, 90]){
            topplug();
          }
        }
      }
    }
  }

}