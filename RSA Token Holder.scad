tkWidth=60;
tkMinHeight=20;
tkDiam=28;
tkThickness=9.5;
tkMaxThickness=10.5;
tkChainX=4;
tkChainY=4;
tkChainZ=6;

extraWidth=10;
extraHeight=10;
extraZ=10;

scaleBy=1.7;

raisedBy=(tkDiam-tkMinHeight)/2;


difference() {
	translate([0,0,0-(scaleBy*extraZ)])
	rotate([30,0,0])
		difference() {
			cube([extraWidth+tkWidth,extraHeight+tkDiam,tkMaxThickness+extraZ]);
		
			// Token holder spot
			translate([
					tkDiam/2+extraWidth/2,
					extraHeight/1.2,
					extraZ+(tkMaxThickness-tkThickness)+0.65+extraZ*0.4])
				union() {
					translate([-tkDiam/2-tkChainX,tkDiam/2-tkChainY/2,tkChainZ/4])
						cube([tkChainX,tkChainY,tkChainZ]);
					resize([tkWidth,tkDiam,tkMaxThickness]) {
						minkowski() {
							union() {
								translate([0,tkDiam/2,0])
									cylinder(tkThickness,tkDiam/2,tkDiam/2);
								translate([0,raisedBy,0])
									cube([tkWidth-tkDiam/2,tkMinHeight,tkThickness]);
								translate([0,tkDiam/2,tkThickness])
									cylinder(tkMaxThickness-tkThickness,tkDiam/2,tkDiam/5);
							}
							sphere(1);
						}
					}
				}
		}


	// Angle
	translate([-20,-20,-(tkMaxThickness+extraZ)])
		cube([100,100,tkMaxThickness+extraZ]);
}
