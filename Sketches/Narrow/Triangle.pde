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
 
  
  void paint(PGraphics pg){
     randomSeed(this.seed);
     pg.beginShape();
     pg.fill(random(50,255));
     pg.vertex(p1.x,p1.y);
     pg.fill(random(50,255));
     pg.vertex(p2.x,p2.y);
     pg.fill(random(50,255));
     pg.vertex(p3.x,p3.y);
     pg.endShape();
     //pg.triangle(p1.x,p1.y,p2.x,p2.y, p3.x,p3.y);

  }
  
  
  
}