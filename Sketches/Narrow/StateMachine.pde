import de.looksgood.ani.*;
float alpha = 255;

PharusClient pc;
HashMap<Player, Attractor> attractorMap = new HashMap<Player, Attractor>();

class StateMachine {
  
  State currentState;
  State newState;
  PApplet applet;
  
  boolean stateInit = true;
  boolean alphaInverse = false;
  
  StateMachine(PApplet applet){
    this.applet = applet;
    
    pc = new PharusClient(applet, WallHeight);
    pc.setMaxAge(50);
    pc.setjumpDistanceMaxTolerance(0.05f);
  }
  
  void setState(State state){
    currentState = state;
    newState = state;
    soundInitiator.setState(state);
  }

  void update() {
    if(alpha == 255){
      currentState = newState;
      
      if(stateInit){
        soundInitiator.setState(currentState);
        soundInitiator.playSound(SoundEvent.Start);
        stateInit = false;
      }
      
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
      
      if(alphaInverse)
        tint(255, 255 - alpha);
      else
        tint(255, alpha); 
       
      image(newState.pg, 0, 0);
      
      stateInit = true;
    }
  }
  
  State getCurrentState(){
    return currentState;
  }
  
  boolean isInState(State state){
   return currentState == state;
  }

  void transitionTo(State newState, float time, boolean alphaInverse) {
    if(alpha == 255){
    this.newState = newState;
    this.alphaInverse = alphaInverse;
    currentState.exitTransition(newState, time);
    newState.enterTransition(currentState, time);
    
    soundInitiator.playSound(SoundEvent.End);
    
    alpha = 0;
    Ani.to(applet, time, "alpha", 255);
    } else {
      println("state machine is currently in transition");
    }
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
    println("player " + player.id + " added");
    stateMachine.playerAdded(player);
  }
  
  void pharusPlayerRemoved(Player player)
  {
    println("player " + player.id + " removed");
    stateMachine.playerRemoved(player); 
  }