import de.looksgood.ani.*;
float alpha = 255;

PharusClient pc;

class StateMachine {
  
  State currentState;
  State newState;
  PApplet applet;
  
  StateMachine(PApplet applet){
    this.applet = applet;
    
    pc = new PharusClient(applet, WallHeight);
    pc.setMaxAge(50);
    pc.setjumpDistanceMaxTolerance(0.05f); 
  }
  
  void setState(State state){
    currentState = state;
    newState = state;
  }

  void update() {
    if(alpha == 255){
      
      currentState = newState;
      
      currentState.begin();
      currentState.update();
      currentState.end();
      
      image(currentState.pg, 0, 0);
    } else {
      currentState.begin();
      currentState.update();
      currentState.end();
      
      newState.begin();
      newState.update();
      newState.end();
      
      image(currentState.pg, 0, 0);
      tint(255, alpha);
      image(newState.pg, 0, 0);
    }
  }
  
  State getCurrentState(){
    return currentState;
  }
  
  boolean isInState(State state){
   return currentState == state;
  }

  void transitionTo(State newState, float time) {
    this.newState = newState;
    currentState.exitTransition(newState, time);
    newState.enterTransition(currentState, time);
    
    alpha = 0;
    Ani.to(applet, time, "alpha", 255);
  }
  
  void playerAdded(Player player){
    currentState.playerAdded(player);
    if(alpha != 255){
      newState.playerAdded(player);
    }
  }
  
  void playerRemoved(Player player){
    currentState.playerRemoved(player);
    if(alpha != 255){
      newState.playerRemoved(player);
    }
  }
}

  
void pharusPlayerAdded(Player player)
  {
    println("Player " + player.id + " added");
    stateMachine.playerAdded(player);
  }
  
  void pharusPlayerRemoved(Player player)
  {
    println("Player " + player.id + " removed");
    stateMachine.playerRemoved(player); 
  }