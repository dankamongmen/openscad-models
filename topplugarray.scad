gap = 79; // 79mm apart
nheight = 5; // 4mm hole, 1mm gap

module smallplug(){
  // 5mm wide at its largest
	translate([-3, (nheight - 1) / 2, 0]){
		circle((nheight - 1) / 2, $fn=50);
	}
	translate([-3.5, 0, 0]){
		square([2, nheight - 1]);
	}
	translate([-2, (nheight - 1) / 2, 0]){
		circle((nheight - 1) / 2, $fn=50);
	}
}

module plug(){
	// 13mm wide at its largest
	translate([-11, (nheight - 1) / 2, 0]){
		circle((nheight - 1) / 2, $fn=50);
	}
	
	translate([-11.5, 0, 0]){
		square([10, nheight - 1]);
	}
	translate([-2, (nheight - 1) / 2, 0]){
		circle((nheight - 1) / 2, $fn=50);
	}
}

module pair(){
	translate([0, 5, 0]){
	  smallplug();
	}
	plug();
}

linear_extrude(10){
	for(i = [0 : 1]){
		translate([0, 10 * i, 0]){
			pair();
		}
	}
}

translate([-3.5, 0, 5]){
	cube([2, 20, 5]);
}