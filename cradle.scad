/* [Parameters] */

//Thickness of the cradle walls
WALL_THICKNESS = 1.5; 

//Inner measurement of the cradle from front to back
CRADLE_INNER_DEPTH = 25; //[10:100]
//Inner measurement of the cradle from left to right
CRADLE_INNER_WIDTH = 75; //[10:100]
//Inner measurement of the cradle from top (opening) to bottom
CRADLE_INNER_HEIGHT = 110; //[10:300]
//Thickness of the block on the (mounted to bike)
OFFSET_BLOCK_D = 10; //[1:50]
//Distance on center between the 2 rear mounting holes
SCREW_HOLE_DIST = 70; //[0:100]

//Diameter of the screw holes.  Typically use 1mm larger than your screw size.  IE, if using M6 screws, set this to 7
SCREW_HOLE_W = 7; //[2:10]

//Width of the countersink around the screw holes.  This must be large enough to fit your wrench/driver and washer.  This should also be slightly oversized
SCREW_COUNTER_W = 20; //[10:50]

//Depth of the offset block behind the screw countersink.  A smaller depth will mean a thinner part between the screw head and bike.
SCREW_COUNTER_D = 10; //[0:90]

/* [Hidden] */
CRADLE_D = CRADLE_INNER_DEPTH + WALL_THICKNESS*2; 
CRADLE_W = CRADLE_INNER_WIDTH + WALL_THICKNESS*2;
CRADLE_H = CRADLE_INNER_HEIGHT + WALL_THICKNESS*2;;
OFFSET_BLOCK_W = SCREW_COUNTER_W + WALL_THICKNESS*2;
OFFSET_BLOCK_H  = CRADLE_H;


$fn = 50;
difference()
{
	union()
	{
		//Build cradle
		difference()
		{
			cube([CRADLE_W,CRADLE_D,CRADLE_H]);
			translate([WALL_THICKNESS,WALL_THICKNESS,WALL_THICKNESS])
			{
				cube([CRADLE_W-WALL_THICKNESS*2,CRADLE_D-WALL_THICKNESS*2,CRADLE_H]);
			}
		}
		//Attach offset block
		translate([CRADLE_W/2-OFFSET_BLOCK_W/2,CRADLE_D,CRADLE_H/2-OFFSET_BLOCK_H/2])
		{
			cube([OFFSET_BLOCK_W,OFFSET_BLOCK_D,OFFSET_BLOCK_H]);	
		}
		
	}
	//Drill upper hole
	translate([CRADLE_W/2,0,CRADLE_H/2+SCREW_HOLE_DIST/2])
	{
		rotate([-90,0,0])
		{
			cylinder(CRADLE_D+OFFSET_BLOCK_D,SCREW_HOLE_W/2,SCREW_HOLE_W/2);
		}
	}
	//Drill lower hole
	translate([CRADLE_W/2,0,CRADLE_H/2-SCREW_HOLE_DIST/2])
	{
		rotate([-90,0,0])
		{
			cylinder(CRADLE_D+OFFSET_BLOCK_D,SCREW_HOLE_W/2,SCREW_HOLE_W/2);
		}
	}

	//Drill upper countersink
	translate([CRADLE_W/2,-SCREW_COUNTER_D,CRADLE_H/2+SCREW_HOLE_DIST/2])
	{
		rotate([-90,0,0])
		{
			cylinder(CRADLE_D+OFFSET_BLOCK_D,SCREW_COUNTER_W/2,SCREW_COUNTER_W/2);
		}
	}
	//Drill lower countersink
	translate([CRADLE_W/2,-SCREW_COUNTER_D,CRADLE_H/2-SCREW_HOLE_DIST/2])
	{
		rotate([-90,0,0])
		{
			cylinder(CRADLE_D+OFFSET_BLOCK_D,SCREW_COUNTER_W/2,SCREW_COUNTER_W/2);
		}
	}
	
	//Front cutout
	translate([CRADLE_W/2-SCREW_COUNTER_W/2,0,CRADLE_H/2-(SCREW_HOLE_DIST/2)])
	{
		cube([SCREW_COUNTER_W,WALL_THICKNESS,SCREW_HOLE_DIST]);
	}
	
	
}
