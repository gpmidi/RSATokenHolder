tkWidth=60;
tkMinHeight=20;
tkDiam=28;
tkThickness=9.5;
tkMaxThickness=10.5;

extraWidth=10;
extraHeight=10;
extraZ=5;

scaleBy=1.01;

raisedBy=(tkDiam-tkMinHeight)/2;

difference() {
	cube([extraWidth+tkWidth,extraHeight+tkDiam,tkMaxThickness+extraZ]);

	translate([
			tkDiam/2+extraWidth/2,
			extraHeight/2,
			extraZ+(tkMaxThickness-tkThickness)+0.65])
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