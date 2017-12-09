//import processing.sound.*;
import java.util.*;

//****************CONFIG********************
float sd_y = 20;  //Standard Deviation X
float sd_x = 20; //Standard Deviation Y

int numPoints = 30;
float maxConnections = 3;

//NEW VARS
int maxConnectWidth = 100;
int pSize = 3;
int alpha = 150;
//****************CONFIG END********************


//PlayerPoints
//

Attractor player;
ArrayList<Node> playerNodes = new ArrayList<Node>();

ArrayList<CPoint> playerPoints = new ArrayList<CPoint>(0);
boolean running = false;

void setup()
{
    size(800, 600);  
    background(0);
}

void draw()
{
    smooth();
    noFill();
    stroke(255);
    //If Game has started
    if(running){
      background(100);
      updatePlayer();
      updatePoints();
      
      drawPoints();
      
      connect();
      //displayConnections();
    }
}


void updatePoints()
{
   
   for(int i = 0; i <  playerNodes.size(); i++)
   {
     Node n = playerNodes.get(i);
     player.attract(n);  
     
     //Push myself away from other nodes
     for(int j = 0; j < playerNodes.size(); j++){
       if(i!=j){
        n.deflect(playerNodes.get(j));
       }
     }
     //Write Vel to Node
     n.update();
   }
}

void init()
{
  //Create Player Attractor
  player = new Attractor(mouseX, mouseY);

  //Create Points around Player
  playerNodes.clear();
  createRandomStartNodes();

  running = true;
}

//Creating Gaussian Random Start Points
void createRandomStartNodes(){
  //Helpers
  float num = 0f;
  float mean_x = mouseX;
  float mean_y = mouseY;
  float start_x, start_y;
  
  //Create
  Random generator = new Random();
  for (int i = 0; i < numPoints; i++) {
      //Gen X-Coord
      num = (float) generator.nextGaussian();
      start_x = sd_x * num + mean_x;
      //Gen Y-Coord
      num = (float) generator.nextGaussian();
      start_y = sd_y * num + mean_y;
      //Fill Array
      playerNodes.add(new Node(start_x, start_y));
  }
}

float pMinDist = 15;

void updatePlayer(){
  
  player.x = mouseX; 
  player.y = mouseY;
}


void drawPoints(){
  
  for(int i = 0; i < playerNodes.size(); i++)
  {
    Node n = playerNodes.get(i);
    stroke(255);
    fill(255);
    ellipse(n.x, n.y, pSize, pSize);
  }
}



void connect(){
  for (int i = 0; i < playerPoints.size(); i++) { //<>//
    CPoint c = playerPoints.get(i);
    float currMinDist = 999999;
    int index = 0;
    // TODO Insert Loop for Max Connections
    if(c.getNeighbours().size() < maxConnections){
      for(int j= 0; j < playerPoints.size(); j++){
          if(i!=j){//Dont check the same Point   
            CPoint o = playerPoints.get(j); //Get the other Point
            if(!c.isNeighbour(o)){  //Check if current Point isnt already a Neighbour of the Current outer Point
               float dist = c.pos.dist(o.pos);
               if(dist < maxConnectWidth){ //Check max Connect Width
                 if(dist < currMinDist){  //Check current Iteration Width
                   index = j;
                   currMinDist = dist;
                 } 
               }
             } 
          }       
      }
      c.addNeighbour(playerPoints.get(index));
    }
  }  
}


void displayConnections(){
    //Get all Points
    for(int i = 0; i < playerPoints.size(); i++){ //<>//
      CPoint c = playerPoints.get(i); //Get First
      ArrayList<CPoint> cn = c.getNeighbours();//Iterate over all Neighbours of the current Point
      for(int j = 0; j < cn.size(); j++){
        CPoint np = cn.get(j);
        if(np.isVisited(c) == false){
            //Draw 
            display(c, np);
            //Add both to Visited
            np.addToVisited(c);
            c.addToVisited(np);
          //}
        }  
      }
    }   
      
  }

void display(CPoint c, CPoint np)
{
   stroke(255);
   fill(255);
   ellipse(c.pos.x, c.pos.y, pSize, pSize);
   noFill();
   float dist = c.pos.dist(np.pos);
   stroke(255,255,255,alpha-dist);
   line(c.pos.x, c.pos.y, np.pos.x, np.pos.y);
}




void mouseClicked(){
  if(!running){
    init();
  }
}

void keyPressed(){
   if(key == BACKSPACE)
  {
    running = false; 
    background(0);
  }
  
}




 