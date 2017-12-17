class Triangle{
  
  PVector p1;
  PVector p2;
  PVector p3;
  
  Triangle(PVector p1, PVector p2, PVector p3)
  {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
  }
 
  
  void paint(){
    
      triangle(p1.x,p1.y,p2.x,p2.y, p3.x,p3.y);

  }
  
  
  
}