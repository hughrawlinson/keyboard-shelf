gridfinityUnit = 42;
gridfinityHeightUnit = 7;

plankThickness = 15;
drawerPlankThickness = 5.5;
drawerTolerance = 1;

internalDepth = 4*gridfinityUnit+1;
internalWidth = 11*gridfinityUnit+1;
internalHeight = 16*gridfinityHeightUnit;

depth = internalDepth + 2*plankThickness + 2*drawerPlankThickness + 2*drawerTolerance;
width = 11*gridfinityUnit + 2*drawerPlankThickness;
height = internalHeight + drawerPlankThickness + drawerTolerance + plankThickness;


drawerDepth = depth - 2 * plankThickness - 2 * drawerTolerance;
drawerHeight = height - plankThickness - drawerTolerance;

echo(internalDepth, internalWidth, internalHeight);

handleRadius = 15;
handleWidth = 80;
handleVerticalOffset = 15;

jointFingers = 10;
fingerWidth = width / (2*jointFingers+1);

module finger(th = 5,odd = 0) {
  thickness = th + 2;
  offset = odd == 0 ? 0 : fingerWidth;
  
  for (i = [0:1:jointFingers]) {
    translate([-width/2+i*fingerWidth*2+fingerWidth/2+offset,0,0]) {
      cube([fingerWidth, thickness, thickness], center=true);
    }
  }
}

module shelf() {
  translate([0,0,height/2-plankThickness/2]) {
    cube([width, depth, plankThickness], center=true);
  }
  
  translate([0,-depth/2+plankThickness/2,0]) {
    cube([width, plankThickness, height], center=true);
  }
  
  translate([0,depth/2-plankThickness/2,0]) {
    cube([width, plankThickness, height], center=true);
  }
}

module handle() {
  rotate([0,90,0]) {
    hull() {
      translate([0,-(handleWidth-2*handleRadius)/2,0]) {
        cylinder(30, handleRadius, handleRadius, center=true);
      }
      translate([0,(handleWidth-2*handleRadius)/2,0]) {
        cylinder(30, handleRadius, handleRadius, center=true);
      }
    }
  }
}

module drawer() {
  color("brown") {
    difference(){
      translate([0,0,-height/2+drawerPlankThickness/2]) {
        cube([width, drawerDepth, drawerPlankThickness],center=true);
      }
      translate([0,drawerDepth/2-drawerPlankThickness/2+1, -height/2+drawerPlankThickness/2-1]) {
        finger(5,1);
      }
    }
  }

  
  translate([width/2-drawerPlankThickness/2,0,-(height-drawerHeight)/2]) {
      
    difference() {
      cube([drawerPlankThickness, drawerDepth, drawerHeight], center=true);
      translate([0,0,handleVerticalOffset]) {
        handle();
      }
    }

  }
  
  translate([-(width/2-drawerPlankThickness/2),0,-(height-drawerHeight)/2]) {
    cube([drawerPlankThickness, drawerDepth, drawerHeight], center=true);
  }
  
  difference() {
    translate([0,depth/2-plankThickness-drawerTolerance-drawerPlankThickness/2,-(height-drawerHeight)/2]) {
      cube([width, drawerPlankThickness,drawerHeight], center=true);
    }
    
    translate([0,drawerDepth/2-drawerPlankThickness/2, -height/2+drawerPlankThickness/2-1]) {
      finger();
    }
  }
  
  difference() {
    translate([0,-(depth/2-plankThickness-drawerTolerance-drawerPlankThickness/2),-(height-drawerHeight)/2]) {
      cube([width, drawerPlankThickness,drawerHeight], center=true);
    }
    
    translate([0,-drawerDepth/2+drawerPlankThickness/2, -height/2+drawerPlankThickness/2-1]) {
      finger();
    }
  }
}

module stockSheet(thickness=15) {
  sheetWidth = 1220;
  sheetDepth = 610;
  
  cube([sheetWidth, sheetDepth, thickness-0.2], center=true);
}

module flatShelf() {
  cutWidth = 5;
  
  width = width;
  depth = depth;
  height = height;
  plankThickness = plankThickness;
  
  
  echo(610-width);
  #translate([1220/2-depth/2,-(610-width)/2,0]) {
    rotate([0,0,90]) {
      cube([width, depth, plankThickness], center=true);
    }
  }
  
  #translate([1220/2-depth/2-(depth+cutWidth),-(610-width)/2,0]) {
    rotate([0,0,90]) {
      cube([width, depth, plankThickness], center=true);
    }
  }
  
  #translate([1220/2-depth/2-2*(depth+cutWidth),-(610-width)/2,0]) {
    rotate([0,0,90]) {
      cube([width, depth, plankThickness], center=true);
    }
  }
  
  #translate([1220/2-width/2,610/2-(height/2),0]) {
    rotate([90,0,0]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-width/2-(width+cutWidth),610/2-(height/2),0]) {
    rotate([90,0,0]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth)-(height+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth)-2*(height+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth)-3*(height+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
}


module flatDrawer() {
  cutWidth = 5;
  
  width = width;
  depth = drawerDepth;
  height = drawerHeight;
  plankThickness = drawerPlankThickness;
  
  
  echo(610-width);
  #translate([1220/2-depth/2,-(610-width)/2,0]) {
    rotate([0,0,90]) {
      cube([width, depth, plankThickness], center=true);
    }
  }
  
  #translate([1220/2-depth/2-(depth+cutWidth),-(610-width)/2,0]) {
    rotate([0,0,90]) {
      cube([width, depth, plankThickness], center=true);
    }
  }
  
  #translate([1220/2-depth/2-2*(depth+cutWidth),-(610-width)/2,0]) {
    rotate([0,0,90]) {
      cube([width, depth, plankThickness], center=true);
    }
  }
  
  #translate([1220/2-width/2,610/2-(height/2),0]) {
    rotate([90,0,0]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-width/2-(width+cutWidth),610/2-(height/2),0]) {
    rotate([90,0,0]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth)-(height+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth)-2*(height+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
  #translate([1220/2-height/2-3*(depth+cutWidth)-3*(height+cutWidth),-(610-width)/2,0]) {
    rotate([90,0,90]) {
      cube([width, plankThickness, height], center=true);
    }
  }
}

module sheetLayout() {
  gap = 25;
  translate([0,610/2+gap,0]) {
    difference() {
      stockSheet();
      flatShelf();
    }
  }
  
  translate([0,-(610/2+gap),0]) {
    difference() {
      stockSheet(5.5);
      flatDrawer();
    }
  }
}

gap = 50;

translate([-(1220/2+gap),0,0]) {
  sheetLayout();
}

translate([width/2+gap,-depth-gap,0]) {
  color("red",0.5) {
    shelf();
  }
  color("yellow",0.5) {
    drawer();
  }
}

translate([width/2+gap,0,0]) {
  color("red",0.5) {
    shelf();
  }
  color("yellow",0.5) {
    drawer();
  }
}

translate([width/2+gap,depth+gap,0]) {
  color("red",0.5) {
    shelf();
  }
  color("yellow",0.5) {
    drawer();
  }
}
