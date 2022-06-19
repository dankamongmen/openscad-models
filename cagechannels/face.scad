include <vars.scad>

// side face, with indentations for labeling drives
rotate([90, 0, 0]){
  difference(){
    cube([sidew, height, sidet]);
    union(){
      linear_extrude(2){
        for(ul = [1 : 4]){
          polygon([[16, height - ul * height / 5 + 10],
                   [sidew - 10, height - ul * height / 5],
                   [sidew - 10, height - ul * height / 5 - 10],
                   [16, height - ul * height / 5]]);
        }
      }
    }
  }
}