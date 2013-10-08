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

// Display angle
//angle=30;	// Normal
angle=40;	// Steep

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

labelText="NnNnNnNn";
labelScale=tkWidth*0.10;
labelDepth=.6;

label2Text="NnNnNnNnNnNnNn";
label2Height=len(label2Text)/3.8;
label2Depth=4.5;

include <write.scad>

// The holder!
difference() {
	scale([overallScaleBy,overallScaleBy,overallScaleBy]) 
		minkowski() {	
			difference() {
				union() {
					translate([0,0,0-(scaleBy*extraZ)])
						rotate([angle,0,0])
							difference() {
								// Main body
								cube([extraWidth+tkWidth,extraHeight+tkDiam,tkMaxThickness+extraZ]);
								
								// Label
								writecube(
									label2Text,
									where=[
										tkDiam+raisedBy*2+extraWidth/2,
										(2+extraHeight+tkDiam)-raisedBy,
										(tkMaxThickness+extraZ-labelDepth)/2
									],
									size=[
										(extraWidth-tkWidth),
										raisedBy,
										tkMaxThickness+extraZ
									],
									face="top",
									center=true,
									h=label2Height,
									t=label2Depth+0.01
									);

								// Token holder spot
								translate([
										tkDiam/2+extraWidth/2,
										extraHeight/1.5,
										extraZ+(tkMaxThickness-tkThickness)+0.65+extraZ*0.4])
									union() {
										translate([-tkDiam/2-tkChainX,tkDiam/2-tkChainY/2-0.9,tkChainZ/4])
											cube([tkChainX+1,tkChainY,tkChainZ]);
										resize([tkWidth,tkDiam,tkMaxThickness]) {
											//minkowski() {
												union() {
													translate([0,tkDiam/2,0])
														cylinder(tkThickness,tkDiam/2,tkDiam/2);
													translate([0,raisedBy,0])
														cube([tkWidth-tkDiam/2,tkMinHeight,tkThickness]);
													translate([0,tkDiam/2,tkThickness])
														cylinder(tkMaxThickness-tkThickness,tkDiam/2,tkDiam/5);
												}
											//	sphere(1);
											//}
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
			}
		sphere(2);
		}
	// Label
	scale([overallScaleBy,overallScaleBy,overallScaleBy])
		translate([xEnd/2-labelScale/4,yEnd+yBegin-labelScale*2,extraRaiseZ-(scaleBy*extraZ)+labelDepth*2+labelScale-0.1])
			rotate([0,180,90])
				write(labelText,h=labelScale,t=labelDepth,center=true);
}