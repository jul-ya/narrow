//NodeStep
int stepX = 20;
int stepY = 20;
//NodeShape
int nSize = 3;
//AttractorCount
int aCount = 1;

ArrayList<Node> nodes = new ArrayList<Node>(0);
ArrayList<Attractor> attractors = new ArrayList<Attractor>(0);

void setup(){
  
  size(800,600);
  background(0);
  //Create NodeGrid
  placeNodes();
  
  //Create Attractor 
  //***********TODO****** - Create Attractor per TUIO Player)
  createAttractor();
  
}



void draw(){
  
  background(0);
  attractNodes();
  displayNodes();
  

}



void displayNodes()
{ 
  //DEBUG/DUMMY - DRAW
  for(int i = 0; i < nodes.size(); i++)
  {
    noStroke();
    fill(255);
    ellipse(nodes.get(i).x, nodes.get(i).y, nSize, nSize);
  }

}

void attractNodes(){
 
  for(int i = 0; i < attractors.size(); i++)
  {
    Attractor a = attractors.get(i);
    a.x = mouseX;
    a.y = mouseY;
    
    for(int j = 0; j < nodes.size(); j++)
    {
      Node n = nodes.get(j);
      a.attract(n);
      n.update();
    }

    
  }
  
}

void createAttractor(){
 
  for(int i = 0; i < aCount; i++)
  {
    attractors.add(new Attractor(0,0));
  }

}


void placeNodes(){
  
  //Add Nodes depending on Grid
  for(int y = stepY/2; y < height; y+=stepY){
    
    for(int x = stepX/2; x < width; x+=stepX){
      {
        nodes.add(new Node(x,y));
      }
    }
  }
  
  
}