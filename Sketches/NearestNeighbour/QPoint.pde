class QPoint extends PVector{
   
  //Position
  PVector pos;
  // velocity
  PVector velocity = new PVector();
  // minimum and maximum posiions
  float minX=5, minY=5, maxX=width-5, maxY=height-5;
  //Size
  int size = 4;

  //Constructor
  QPoint(float x, float y){
    this.pos = new PVector(x,y);
  }
   QPoint(PVector vec){
    this.pos = vec;
  }
  
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
  
  void setSize(int size)
  {
     this.size = size; 
  }
  
  void setVelocity(float velX, float velY)
  {
     velocity.x = velX;
     velocity.y = velY;
  }
  
  void display(){
     ellipse( this.x, this.y, size, size);   
  }
  
  
  
  
  
}