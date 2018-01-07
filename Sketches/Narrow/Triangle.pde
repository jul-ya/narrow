class Triangle{
  
  PVector p1;
  PVector p2;
  PVector p3;
  int seed;
  
  Triangle(PVector p1, PVector p2, PVector p3)
  {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.seed = int(random(500));
  }
 
  int currentCol = 255;
  void paint(PGraphics pg){
     randomSeed(this.seed);
     currentCol = (int)(120 * Math.sin(float(frameCount) * 0.25 * random(1)) + 120.0);
     pg.fill(currentCol);
     //pg.fill(random(0,255));
     pg.beginShape();
     //pg.fill(random(50,255));
     pg.vertex(p1.x,p1.y);
     //pg.fill(random(50,255)-50);
     pg.vertex(p2.x,p2.y);
     //pg.fill(random(50,255)+10);
     pg.vertex(p3.x,p3.y);
     pg.endShape();
     
 

  }
  
  
  
}