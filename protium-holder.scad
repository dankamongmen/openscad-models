// designed to cradle a Singularity Computers Protium reservoir. the relevant tube
// diameter is 60mm: https://singularitycomputers.com/shop/watercooling/protium/protium-reservoir-200mm-frosted-acrylic-black/
// we leave space underneath for electronics. we put magnets in the feet to bind
// to the MORA3. the MORA3's center is 70mm wide.
// FIXME cut holes to let light through?
// FIXME grooves for LEDs?

d = 60 + 3; // 3mm gap for tape/LEDs
h = 150; // it's actually 200, but we don't want the entire length
e = 70 - d;

// magnets are 60x10x2. we have them in pairs (20mm).
magh = 60 + 1; // 1mm gap
magw = 20 + 1; // 1mm gap
magl = 2 + 1; // 1mm gap

// we want a big cuboid with a cylinder removed
difference(){
	cube([d + e, (d + e) / 2, h]);
	translate([(d + e) / 2, (d +e) / 2, 0]){
		cylinder(h, d / 2, d / 2);
	}
}

padh = magh + 5;
padl = magl + 5;
padw = magw + 5;

// a stand on the bottom, with a slot to contain two magnets.
module padbottom(z){
	difference(){
		cube([padw, padl, padh]);
		if(z){
			translate([(padw - magw) / 2, (padl - magl) / 2, 0]){
				cube([magw, magl, magh]);
			}
		}else{
			translate([(padw - magw) / 2, (padl - magl) / 2, (padh - magh)]){
				cube([magw, magl, magh]);
			}
		}
	}
}

for(x = [0, d + e - padw])
	for(z = [0, h - padh])
		translate([x, -padl, z]){
			padbottom(z == 0);
		}
		