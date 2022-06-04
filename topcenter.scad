jheight = 15;
jradius = 17;

module topplug(){
  hull(){
    translate([40, 0, 0]){
      cylinder(jheight, jradius, jradius);
    }
    cylinder(jheight, jradius, jradius);
  }
}

difference(){
  topplug();
  translate([2, 0, 0]){
    scale([0.9, 0.9, 1]){
      topplug();
    }
  }
}