tkWidth=60;
tkMinHeight=24;
tkDiam=34;
tkThickness=9.5;
tkMaxThickness=10.5;

// Size of the foot pad spots
padIndentX=23;
padIndentY=11;
padIndentDepth=.5;
padEdge=3;

// Where the token's keychain connection is
tkChainX=10;
tkChainY=8;
tkChainZ=6;

angle=30;
extraWidth=6;
extraHeight=10;
extraZ=10;
extraRaiseZ=5;

scaleBy=1.7;
overallScaleBy=1.07;

raisedBy=(tkDiam-tkMinHeight)/2;

xEnd=extraWidth+tkWidth;
yBegin=-8;
yEnd=32;

labelText="By GpMidi";
labelScale=0.6;
labelBuff=padIndentX/4;
labelDepth=.5;

include <TextGenerator.scad>

scale([overallScaleBy,overallScaleBy,overallScaleBy])
//	minkowski() {	
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
				if(angle <= 30) {
					translate([0,20,extraZ-(tkMaxThickness+extraRaiseZ)])
						cube([extraWidth+tkWidth,30,extraZ+7]);
				}
				if(angle > 30) {
					translate([0,12,extraZ-(tkMaxThickness+extraRaiseZ)])
						cube([extraWidth+tkWidth,30,extraZ+7]);
				}
			}
			// Cut off the bottom; make it flat
			translate([-20,-20,0-(tkMaxThickness+extraZ+extraRaiseZ)])
				cube([100,100,tkMaxThickness+extraZ]);

			// Cut off the back
			translate([-1,yEnd,extraZ-(tkMaxThickness+extraRaiseZ)])
				cube([101,100,100]);

			// Spots for sticky pads to be attached as feet
			translate([0+padEdge,0+padEdge+yBegin,0-(extraRaiseZ+0.001)])
				cube([padIndentX,padIndentY,padIndentDepth]);

			translate([xEnd-padIndentX-padEdge,0+padEdge+yBegin,0-(extraRaiseZ+0.001)])
				cube([padIndentX,padIndentY,padIndentDepth]);

			translate([0+padEdge,yEnd-padIndentY-padEdge,0-(extraRaiseZ+0.001)])
				cube([padIndentX,padIndentY,padIndentDepth]);

			translate([xEnd-padIndentX-padEdge,yEnd-padIndentY-padEdge,0-(extraRaiseZ+0.001)])
				cube([padIndentX,padIndentY,padIndentDepth]);

			// Label
			translate([xEnd-padIndentX-padEdge-labelBuff,yEnd-padEdge,0-(extraRaiseZ+0.001)+labelDepth])
				scale([labelScale,labelScale,labelScale])
					rotate([0,180,90])
						drawtext(labelText);

		}
//		sphere(2);
//	}
