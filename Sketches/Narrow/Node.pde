// M_4_1_01.pde
// Node.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class Node {

  // velocity
  PVector velocity = new PVector();
  float x = 0;
  float y = 0;
  // minimum and maximum posiions
  float minX=5, minY=5, maxX=WindowWidth-5, maxY=WindowHeight-WallHeight-5;

  // damping of the velocity (0 = no damping, 1 = full damping)
  float damping = .0005;

  // strength: positive for attraction, negative for repulsion
  float strength = 20;  
  // parameter that influences the form of the function
  float ramp = 0.9;    //// 0.01 - 0.99
  float minDist = 75/shrink;
  
  int numConnections = 0;
  ArrayList<Node> neighbours = new ArrayList<Node>(0);
  
  //For Drawing
  ArrayList<Node> visited = new ArrayList<Node>(0); 

  Node(float theX, float theY) {
    x = theX;
    y = theY;
  }

  // ------ calculate new position of the node ------
  void update() {
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

    velocity.x *= (1-damping);
    velocity.y *= (1-damping);
  }
  
  //Push away other Nodes
  void deflect(Node theNode){
    
    float dx = x - theNode.x;
    float dy = y - theNode.y;
    float d = mag(dx, dy);
    
    
    if(d < minDist)
    {
      // calculate force
     
      float s = d/minDist;
    
      float f = (1 / pow(s, 0.5*ramp) - 1);
      f = noise(theNode.x,theNode.y) * 0.5 +  strength * f/minDist ;
      
      //Apply Force
      theNode.velocity.x -= dx * f * damping;
      theNode.velocity.y -= dy * f * damping;
           
    }
  }
  
  void setVelocity(PVector v){
   this.velocity = v; 
  }
  
  void setDamping(float d){
   this.damping = d; 
  }
  
  void addConnection(){
    numConnections+=1;
  }
  
  int getNumConnections(){
    return this.numConnections;
  }
  
  ArrayList<Node> getNeighbours(){
   return this.neighbours; 
  }
  
  void addNeighbour(Node n){
    this.neighbours.add(n);
  }
  
  boolean isNeighbour(Node n){ 
    for(int i = 0; i < this.neighbours.size(); i++){
      if(neighbours.get(i)==n)
      {
        return true;
      }
    }
    return false;
  }
  
  
  void addToVisited(Node n){
    this.visited.add(n);
  }
  
  boolean isVisited(Node n){ 
    for(int i = 0; i < this.visited.size(); i++){
      if(visited.get(i)==n)
      {
        return true;
      }
    }
    return false;
  }
  
}