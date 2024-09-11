    // chamber for a high-temperature (140C) filament dryer
// intended to be printed in polycarbonate
// the top is lifted up and out to insert a spool
// the spool sits on corner walls
include <electronics.scad>

// we need to hold a spool up to 205mm in diameter and 75mm wide
spoold = 205;
spoolh = 75;
spoolholed = 55;

// we'll want some room around the spool, but the larger our
// chamber, the more heat we lose.
wallz = 2; // bottom thickness; don't want much
gapxy = 2; // gap between spool and walls; spool might expand with heat!
wallxy = 2;
topz = 5; // height of top piece
elevation = 10; // spool distance from bottom
chordxy = 10;

totalxy = spoold + wallxy * 2 + gapxy * 2;
totalz = spoolh + wallz + topz + elevation;
totald = sqrt(totalxy * totalxy + totalxy * totalxy);

// motor is 37x33mm diameter gearbox and 6x14mm shaft
motorboxh = 33;
motorboxd = 37;
motorshafth = 14;
motorshaftd = 6;

opoints = [
            [-totalxy / 2 + chordxy, -totalxy / 2],
            [totalxy / 2 - chordxy, -totalxy / 2], 
            [totalxy / 2, -totalxy / 2 + chordxy],
            [totalxy / 2, totalxy / 2 - chordxy],
            [totalxy / 2 - chordxy, totalxy / 2],
            [-totalxy / 2 + chordxy, totalxy / 2],
            [-totalxy / 2, totalxy / 2 - chordxy],
            [-totalxy / 2, -totalxy / 2 + chordxy]
        ];

ipoints = [[-totalxy / 2 + (chordxy + wallxy), -totalxy / 2 + wallxy],
                [totalxy / 2 - (chordxy + wallxy), -totalxy / 2 + wallxy], 
                [totalxy / 2 - wallxy, -totalxy / 2 + (chordxy + wallxy)],
                [totalxy / 2 - wallxy, totalxy / 2 - (chordxy + wallxy)],
                [totalxy / 2 - (chordxy + wallxy), totalxy / 2 - wallxy],
                [-totalxy / 2 + (chordxy + wallxy), totalxy / 2 - wallxy],
                [-totalxy / 2 + wallxy, totalxy / 2 - (chordxy + wallxy)],
                [-totalxy / 2 + wallxy, -totalxy / 2 + (chordxy + wallxy)]];
iipoints = concat(opoints, ipoints);


module topbottom(height){
    linear_extrude(wallz){
        polygon(opoints);
    }
}

module interior(height){
}

echo(ipoints);

module hotbox(){
    difference(){
        union(){
            topbottom(wallz);
            translate([0, 0, wallz]){
                linear_extrude(totalz - wallz){
                    polygon(
                        iipoints,
                    , paths=[
                        [0, 1, 2, 3, 4, 5, 6, 7],
                        [8, 9, 10, 11, 12, 13, 14, 15]
                    ]);
                }
            }
        }
        // now remove all other interacting pieces
        union(){
            translate([0, 0, totalz - wallz]){
                mirror([0, 0, 1]){
                    top();
                }
            }
            motor();
        }
    }
}

// pegs for the ceramic heating element
translate([0, totalxy / 4, wallz / 2]){
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

module motor(){
    cylinder(motorboxh, motorboxd / 2, motorboxd / 2);
    translate([0, 0, motorboxh]){
        cylinder(motorshafth, motorshaftd / 2, motorshaftd / 2);
    }
}

multicolor("purple"){
    hotbox();
}

multicolor("green"){
    spool();
}

module top(){
    hull(){
        topbottom(1);
        translate([0, 0, topz]){
            linear_extrude(1){
                polygon(ipoints);
            }
        }
    }
}

/*multicolor("pink"){
    translate([0, 0, -motorboxh]){
        motor();
    }
}*/

multicolor("white"){
    translate([totalxy + 10, 0, 0]){
        top();
    }
}
