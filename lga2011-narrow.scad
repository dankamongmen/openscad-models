translate([0, 2.95, 0]){
	id = 59.5;
	hd = 73.3;
	w = 4.3;
	h = 7.4;
	t = 1.84;
	
	difference(){
		cube([2 * w + id, 2 * h + hd, t]);
		translate([w, h, 0]){
			cube([id, hd, t]);
		}
	}
	
	ol = 88.35;
	
	bw = 68.1; // outer width
	holesw = 56; // hole spacing width
	
	bh = 88.1;
	holesh = 94;
	
	conth = 6;
	contw = bw - 2;
	
	difference(){
		union(){
			for(i = [-conth, bh]){
				translate([1, i, 0]){
					cube([contw, conth, t]);
				}
			}
		}
		for(i = [6.05, 62.05]){
			for(j = [-2.95, 91.05]){
				translate([i, j, 0]){
					cylinder(t, 2.04, 2.04);
				}
			}
		}
	}
}