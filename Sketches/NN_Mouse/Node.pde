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

class Node extends PVector {

  // velocity
  PVector velocity = new PVector();

  // minimum and maximum posiions
  float minX=5, minY=5, maxX=width-5, maxY=height-5;

  // damping of the velocity (0 = no damping, 1 = full damping)
  float damping = .01;
  
  // radius of impact
  float radius = 30;
  // strength: positive for attraction, negative for repulsion
  float strength = 1;  
  // parameter that influences the form of the function
  float ramp = 0.5;    //// 0.01 - 0.99
  float minDist = 30;

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
    float d = pow(dx,2) + pow(dy,2);
    
    
    if(d < pow(minDist,2))
    {
        // calculate force
      float s = d/radius;
      float f = (1 / pow(s, 0.5*ramp) - 1);
      f = strength * f/radius;

      // apply force to node velocity
      theNode.x += dx * f;
      theNode.y += dy * f;
    }
     
  }
}