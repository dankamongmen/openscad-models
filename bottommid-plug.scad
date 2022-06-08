// fitting between mobo bottom plugs

zh = 15 - 2 * 0.3;
midheight = 20;
bottom = -10;
hook = 5;
width = 20 + 2 * hook; // gap of 20 between them, and 5mm on each to hook
midwidth = 10; // actual width of middle *gap* (box is larger, for walls)
midthick = 3;
// other baskets are 88 tall in their entirety; we want to rise just a bit higher up
midtall = 88 - midheight + 5;

module bottom(){
  cube([width, midheight, zh]);
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

hookheight = 5;
coverwidth = (width - hook * 2 - midwidth) / 2;

// left half of bottom top
translate([hook, bottom, -zh - hookheight + 1]){
  cube([coverwidth, -bottom * 2, hookheight]);
}
// right half of bottom top
translate([width - (coverwidth + hook), bottom, -zh - hookheight + 1]){
  cube([coverwidth, -bottom * 2, hookheight]);
}
// middle box
module midbox(){
  translate([(width - (midwidth + midthick * 2)) / 2, bottom, -zh + 1 - midtall]){
    cube([midwidth + midthick * 2, -bottom * 2, midtall]);
  }
}

// hollow middle box with missing back
difference(){
  midbox();
  translate([midthick / 2, midthick / 2, 0]){
    scale([0.9, 0.9, 1]){
      midbox();
    }
  }
}