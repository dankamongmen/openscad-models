include <arduino.scad>

enclosure(MEGA2560);
union() {
  translate([-5,105,0]){
    cube([50, 5, 50]);
  }
}
