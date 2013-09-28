tkWidth=60;
tkMinHeight=24;
tkDiam=34;
tkThickness=9.5;
tkMaxThickness=10.5;

// Where the token's keychain connection is
tkChainX=10;
tkChainY=8;
tkChainZ=6;

angle=40;
extraWidth=6;
extraHeight=10;
extraZ=10;
extraRaiseZ=5;

scaleBy=1.7;
overallScaleBy=1.07;

raisedBy=(tkDiam-tkMinHeight)/2;


scale([overallScaleBy,overallScaleBy,overallScaleBy])
	minkowski() {	
		difference() {
			union() {
				translate([0,0,0-(scaleBy*extraZ)])
					rotate([angle,0,0])
						difference() {
							cube([extraWidth+tkWidth,extraHeight+tkDiam,tkMaxThickness+extraZ]);
			
							// Token holder spot
							translate([
									tkDiam/2+extraWidth/2,
									extraHeight/1.5,
									extraZ+(tkMaxThickness-tkThickness)+0.65+extraZ*0.4])
								union() {
									translate([-tkDiam/2-tkChainX,tkDiam/2-tkChainY/2-0.9,tkChainZ/4])
										cube([tkChainX+1,tkChainY,tkChainZ]);
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
				
				// Extra bottom of main block
				translate([0,20,extraZ-(tkMaxThickness+extraRaiseZ)])
					cube([extraWidth+tkWidth,20,extraZ+3]);
			}
			// Cut off the bottom; make it flat
			translate([-20,-20,0-(tkMaxThickness+extraZ+extraRaiseZ)])
				cube([100,100,tkMaxThickness+extraZ]);

			// Cut off the back
			translate([-1,32,extraZ-(tkMaxThickness+extraRaiseZ)])
				cube([101,100,100]);
		}
		sphere(2);
	}