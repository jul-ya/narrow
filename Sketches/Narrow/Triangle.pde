class Triangle{
  
  PVector p1;
  PVector p2;
  PVector p3;
  int seed;
  PVector velocity = new PVector();
  
  float randVal = 0.8; 
  
  Triangle(PVector p1, PVector p2, PVector p3)
  {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.seed = int(random(500));
    this.velocity =  new PVector(random(-randVal, randVal), random(-randVal,randVal));
  }
 
  int currentCol = 255;
  void paint(PGraphics pg){
     randomSeed(this.seed);
     currentCol = (int)(120 * Math.sin(float(frameCount) * 0.25 * random(1)) + 120.0);
     pg.fill(currentCol);
     pg.triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
  }
  
    // ------ calculate new position of the node ------
  void update() {
      p1.x += velocity.x;
      p1.y += velocity.y;
      
      p2.x += velocity.x;
      p2.y += velocity.y;
      
      p3.x += velocity.x;
      p3.y += velocity.y;
  }
  
  
  
}