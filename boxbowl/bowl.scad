// common constants used across multiple files

// a carton is 222mm long where it intersects with the bolt.
// two next to one another are 204mm wide with a ~20mm clearance.
// a carton is 250mm tall.


boltd = 5;
wallr = 3;
wallx = 8;
wally = wallr;
wallz = wallr;
mainx = 204;
mainy = 80;
mainz = 222;
totx = mainx + wallx * 2;
totz = mainz + wallz * 2;
toty = mainy + wally;

towerd = 20;
towerw = 18;

bard = 3;

swatchx = 20;
swatchy = 20;
swatchz = 2;

fpanelx = (mainx - towerw) / 2;
clampr = bard / 2 + 0.2;
fpanely = mainy;
fpanelz = 8;
