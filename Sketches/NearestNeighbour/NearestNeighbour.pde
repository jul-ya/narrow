//import processing.sound.*;
import java.util.*;

//****************CONFIG********************
float sd_y = 50;  //Standard Deviation X
float sd_x = 140; //Standard Deviation Y

int numPoints = 200;
float maxConnections = 3;

//NEW VARS
int maxConnectWidth = 100;
int pSize = 2;
int alpha = 150;
//****************CONFIG END********************


//Points
ArrayList<CPoint> points = new ArrayList<CPoint>(0);
void setup()
{
    size(800, 600);  
    createRandomStartPoints();
    background(0);
}

void draw()
{
    smooth();
    noFill();
    stroke(255);
    connect();
    displayConnections();
    
}

void connect(){
  for (int i = 0; i < points.size(); i++) { //<>//
    CPoint c = points.get(i);
    float currMinDist = 999999;
    int index = 0;
    // TODO Insert Loop for Max Connections
    if(c.getNeighbours().size() < maxConnections){
      for(int j= 0; j < points.size(); j++){
          if(i!=j){//Dont check the same Point   
            CPoint o = points.get(j); //Get the other Point
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
      c.addNeighbour(points.get(index));
    }
  }  
}


void displayConnections(){
    //Get all Points
    for(int i = 0; i < points.size(); i++){ //<>//
      CPoint c = points.get(i); //Get First
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

//Creating Gaussian Random Start Points
void createRandomStartPoints(){
  //Helpers
  float num = 0f;
  float mean_x = width/2;
  float mean_y = height/2;
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
      points.add(new CPoint(start_x, start_y));
  }

}




 