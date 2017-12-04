//import processing.sound.*;
import java.util.*;

//***************************CONFIG ME HERE************************************

float sd_y = 50;  //Standard Deviation X
float sd_x = 140; //Standard Deviation Y
//*****************************DO NOT TOUCH ME BELOW***************************
//Points
ArrayList<QPoint> points = new ArrayList<QPoint>(0);
int numPoints = 60;
float maxDist = 500;



//************TODO************************
// ---
//---- Display Methode auslagern
//---- Check if Point has already been visited

void setup()
{
    size(800, 600);  
    createRandomStartPoints();
}

void draw()
{
    smooth();
    noFill();
    background(0);
    stroke(255);  
    //connectPoints();
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
      points.add(new QPoint(start_x, start_y));
  }

}

void nearest(){
  int min_dist=0;
  
  for(int i=0; i < numPoints; i++)
  {
    int numConnections = 0;
    for(int j=0; j<numPoints; j++)
    {
      
    }
    
    
    
  }
  
  
  
}
//Connect Points
void connectPoints(){
 
    //Helpers
    int min_dist = 0;
   
    for (int i = 0; i < numPoints; i++) 
    {  
        QPoint nearestPoint = new QPoint(new PVector()); 
        QPoint nearestPoint2 = new QPoint(new PVector()); 
        int index = 0;
        //Draw First Line
         for (int j = 0; j < numPoints; j++) 
          {
                if ( j != i  )
                {  
                  QPoint currentPoint_j =  points.get(j);
                  //Get Current Distance
                  float dst = dist( points.get(i).pos.x, points.get(i).pos.y, points.get(j).pos.x, points.get(j).pos.y );
                  //Check if Current Distance is smaller than existing one                                       
                  if((dst < min_dist || isZero(min_dist)) && (dst < maxDist)) //Check MinDist for nearest Neighbour
                  {       
                    nearestPoint = currentPoint_j;
                    min_dist = (int) dst;  
                    index = j;
                    continue;
                  }
                }                
          }
         
         //points.add(points.get(i));
         //points.add(nearestPoint);
         //Draw First Line 
         setLineColor(min_dist);
         line( points.get(i).pos.x, points.get(i).pos.y, nearestPoint.pos.x, nearestPoint.pos.y); 
         
         min_dist = 0;
          //**********************Second Line ********************
         for (int j = 0; j < numPoints; j++) 
          {
             
                if ( j != i  && j != index)
                {  
                  //Get Current Distance
                  QPoint currentPoint_j =  points.get(j);
                  float dst = dist( points.get(i).pos.x, points.get(i).pos.y, points.get(j).pos.x, points.get(j).pos.y );
                  //Check if Current Distance is smaller than existing one                                       
                  if((dst < min_dist || isZero(min_dist)) && (dst < maxDist)) //Check MinDist for nearest Neighbour
                  {       
                    nearestPoint2 = currentPoint_j;
                    min_dist = (int) dst;  
                  }
                }                
          }
          
          //points.add(points.get(i));
          //points.add(nearestPoint);
          //Draw Line2
          line( points.get(i).pos.x, points.get(i).pos.y, nearestPoint2.pos.x, nearestPoint2.pos.y);    
          //***********Points**************//      
          //Draw Current Point
          strokeWeight(2);
          ellipse( points.get(i).pos.x, points.get(i).pos.y,2,2 );
          
          //Reset Values for next Point   
          min_dist = 0;
    }    
}

boolean isZero(float value){
    return value < 1 ? true : false;
  }
  
void setLineColor(float dist){
    stroke(255,255,255,150-dist); 
  }
  
void display()
{
  
  
}




 