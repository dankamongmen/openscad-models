// fitting between mobo bottom plugs

zh = 15 - 2 * 0.3;
midheight = 20;
bottom = -10;

module bottom(){
  cube([30, midheight, zh]);
}

difference(){
  translate([0, bottom, -(zh - 1)]){
    bottom();
  }
  translate([0, bottom + 1, -zh]){
    scale([1, 0.9, 0.9]){
      bottom();
    }
  }
}