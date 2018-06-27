float xx=-200.0, yy=260.0, zz=80.0, cx=0.0, cy=0.0, cz=0.0;
boolean firstFlagC, firstFlagCC, doubleClick=true, firstFlagR;
float originalX, originalXX, originalY, originalYY, originalZZ;
float distance;
float theta, phi;
float deltaX, deltaY;

void changeCamera(){
  //println(cos(t+=0.1));
  if (mouseButton==CENTER)  //mouseButton==LEFT/RIGHT/CENTER   //last data:::pmouseX,pmouseY.
  {
    if (firstFlagC) {
      firstFlagC=false;
      if (firstFlagCC && mouseX==originalX && mouseY==originalY) {
        firstFlagCC=false;
        xx=-200.0; 
        yy=260.0; 
        zz=80.0; 
        cx=0.0;
        cy=0.0; 
        cz=0.0;
      }
      originalX=mouseX;
      originalY=mouseY;
      originalXX=xx;
      originalYY=yy;
      originalZZ=zz;
      distance=sqrt(originalXX*originalXX+originalYY*originalYY+originalZZ*originalZZ);

      if (originalXX==0) {
        if (originalYY>=0)theta=PI/2;
        else theta=1.5*PI;
      } else if (originalXX<0) theta=PI+atan(originalYY/originalXX);
      else if (originalYY<0) theta=2*PI+atan(originalYY/originalXX);
      else theta=atan(originalYY/originalXX);
      if (originalZZ==0)phi=PI/2;
      else if (originalZZ<0) phi=PI+atan(sqrt(originalXX*originalXX+originalYY*originalYY)/originalZZ);
      else phi=atan(sqrt(originalXX*originalXX+originalYY*originalYY)/originalZZ);
    }
    
    xx=distance*sin( phi-((abs(mouseY-originalY)<3)?0:(mouseY-originalY)/57.5) )*cos(theta+((abs(mouseX-originalX)<3)?0:(mouseX-originalX)/57.5) );
    yy=distance*sin( phi-((abs(mouseY-originalY)<3)?0:(mouseY-originalY)/57.5) )*sin(theta+((abs(mouseX-originalX)<3)?0:(mouseX-originalX)/57.5) );
    zz=distance*cos( phi-((abs(mouseY-originalY)<3)?0:(mouseY-originalY)/57.5) );
  } else firstFlagC=true;


  if (mouseButton==RIGHT)
  {
    deltaX-=mouseX-pmouseX;
    deltaY-=mouseY-pmouseY;
    if (firstFlagR) {
      firstFlagR=false;
      originalXX=xx;
      originalYY=yy;
      originalZZ=zz;
    }
    /*todo*/
    cx=deltaX;
    cy=deltaY;
    xx=originalXX-((abs(deltaX)<3)?0:deltaX/12) ;
    yy=originalYY-((abs(deltaY)<3)?0:deltaY/12) ;
  } else {
    deltaX=cx;
    deltaY=cy;
    firstFlagR=true;
  }
    camera(xx, yy, zz, // eyeX, eyeY, eyeZ  -200, 260, 80
    cx, cy, cz, // centerX, centerY, centerZ
    0, 0, -1.0); // upX, upY, upZ
    print(xx);
    print(".....");
    print(yy);
    print(".....");
    println(zz);
    
    stroke(0, 255, 100);
    line(0, 0, 0, 0, 0, 500);
    stroke(0, 255, 100);
    line(0, 0, 0, 0, 500, 0);
    stroke(0, 255, 100);
    line(0, 0, 0, 500, 0, 0);
    noStroke();
}

void mouseWheel(MouseEvent event)
{ 
  float e=event.getCount();
  xx+=(xx-cx)*e*0.1;
  yy+=(yy-cy)*e*0.1;
  zz+=(zz-cz)*e*0.1;
}
void mousePressed()
{
  firstFlagC=true;
}
void mouseMoved() {
  firstFlagCC=true;
}
