    // chamber for a high-temperature (140C) filament dryer
// intended to be printed in polycarbonate
// the top is lifted up and out to insert a spool
// the spool sits on corner walls
include <electronics.scad>

// we need to hold a spool up to 205mm in diameter and 75mm wide
spoold = 205;
spoolh = 75;
spoolholed = 55;

// our walls in the four corners
wallz = 2; // bottom thickness; don't want much
wallx = 5;
gapx = 1;
wally = 5;
gapy = 1;
elevation = 10;

totalx = spoold + wallx * 2 + gapx * 2;
totaly = spoold + wally * 2 + gapy * 2;
totalz = spoolh + wallz + elevation;
totald = sqrt(totalx * totalx + totaly * totaly);

// we'll want some room around the spool, but the larger our
// chamber, the more heat we lose.

module hotbox(){
    linear_extrude(wallz){
        polygon([
            [-totalx / 2 + wallx, -totaly / 2],
            [totalx / 2 - wallx, -totaly / 2], 
            [totalx / 2, -totaly / 2 + wally],
            [totalx / 2, totaly / 2 - wally],
            [totalx / 2 - wallx, totaly / 2],
            [-totalx / 2 + wallx, totaly / 2],
            [-totalx / 2, totaly / 2 - wally],
            [-totalx / 2, -totaly / 2 + wally]
        ]);
    }
    translate([0, 0, wallz]){
        linear_extrude(totalz - wallz){
            polygon([
                [-totalx / 2 + wallx, -totaly / 2],
                [totalx / 2 - wallx, -totaly / 2], 
                [totalx / 2, -totaly / 2 + wally],
                [totalx / 2, totaly / 2 - wally],
                [totalx / 2 - wallx, totaly / 2],
                [-totalx / 2 + wallx, totaly / 2],
                [-totalx / 2, totaly / 2 - wally],
                [-totalx / 2, -totaly / 2 + wally],
                [-totalx / 2 + wallx * 2, -totaly / 2 + wally],
                [totalx / 2 - wallx * 2, -totaly / 2 + wally], 
                [totalx / 2 - wally, -totaly / 2 + wally * 2],
                [totalx / 2 - wally, totaly / 2 - wally * 2],
                [totalx / 2 - wallx * 2, totaly / 2 - wally],
                [-totalx / 2 + wallx * 2, totaly / 2 - wally],
                [-totalx / 2 + wallx, totaly / 2 - wally * 2],
                [-totalx / 2 + wallx, -totaly / 2 + wally * 2],

            ], paths=[
                [0, 1, 2, 3, 4, 5, 6, 7],
                [8, 9, 10, 11, 12, 13, 14, 15]
            ]);
        }
    }
}

// pegs for the ceramic heating element
translate([0, totaly / 4, wallz / 2]){
    ceramheat230(10, wallz);
}

// walls to support the spool

ga37rgh = 53.3;
ga37rgr = 37 / 2;
//ga37rgshaftr

module spool(){
    translate([0, 0, wallz + elevation]){
        linear_extrude(spoolh){
            difference(){
                circle(spoold / 2);
                circle(spoolholed / 2);
            }
        }
    }
}

multicolor("purple"){
    hotbox();
}

multicolor("green"){
    spool();
}

module top(){
    cylinder(elevation, totald / 2, (totald - wallx * 2) / 2, $fn=4);
}

multicolor("white"){
    translate([totalx + 10, 0, 0]){
        rotate([0, 0, 45]){
            top();
        }
    }
}