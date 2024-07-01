z = 193.675;
y = 52.3875;
x = 244.475;

xex = 10;
yex = 5;
zex = 5;

$fn=50;

difference(){
	cube([x + xex, y + yex, z + zex]);
	union(){
		translate([xex / 2, 0, 0]){
			cube([x, y, z]);
		}
		translate([xex + x / 5, yex + y / 2, z + zex / 2]){
			sphere(zex);
		}
		cutw = 2 * x / 3;
		translate([(x + xex) / 2 - cutw / 2, y, 0]){
			cube([cutw, yex, z / 2]);
		}
	}
}

