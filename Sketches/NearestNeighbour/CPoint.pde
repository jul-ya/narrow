class CPoint extends PVector{

  //Position
  PVector pos;
  PVector velocity = new PVector();
  float minX=5, minY=5, maxX=width-5, maxY=height-5;
  
  //Neighbours
  ArrayList<CPoint> neighbours = new ArrayList<CPoint>(0);
  int numConnections = 0;
  int maxDistIndex = -1;
  float maxDist = -1;
  
  //For Drawing
  ArrayList<CPoint> visited = new ArrayList<CPoint>(0); 
  
  
  //Shape
  int pSize = 5;
  
  //Constructor
  CPoint(float x, float y){
    this.pos = new PVector(x,y);
  }
  
  CPoint(PVector vec){
    this.pos = vec; 
  }
  
  //Movement
  void update(){
    x += velocity.x;
    y += velocity.y;
    
    if (x < minX) {
      x = minX - (x - minX);
      velocity.x = -velocity.x;
    }
    if (x > maxX) {
      x = maxX - (x - maxX);
      velocity.x = -velocity.x;
    }

    if (y < minY) {
      y = minY - (y - minY);
      velocity.y = -velocity.y;
    }
    if (y > maxY) {
      y = maxY - (y - maxY);
      velocity.y = -velocity.y;
    }
  }
    
  void setVelocity(float velX, float velY)
  {
     velocity.x = velX;
     velocity.y = velY;
  }
  
  //Neighbours  
  int getNumConnections(){
    return this.numConnections;
  }
   //<>//
  void addNeighbour(CPoint point){
    this.neighbours.add(point);
  }

  ArrayList<CPoint> getNeighbours(){
   return this.neighbours; 
  }
  
  //Display
   void setSize(int size){
     this.size = size; 
  } 
  
  void addToVisited(CPoint point){
    this.visited.add(point);
  }
  
  boolean isVisited(CPoint point){ 
    for(int i = 0; i < this.visited.size(); i++){
      if(visited.get(i)==point)
      {
        return true;
      }
    }
    return false;
  }
  
  
  boolean isNeighbour(CPoint point){ 
    for(int i = 0; i < this.neighbours.size(); i++){
      if(neighbours.get(i)==point)
      {
        return true;
      }
    }
    return false;
  }
  
  
  void display(){
    stroke(255);
    fill(255);
    ellipse(this.pos.x, this.pos.y, pSize, pSize);   
  }
  
  
  
  
  
}