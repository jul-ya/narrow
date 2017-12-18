class SoundListener{
  
  State currentState;
  
  void setState(State state){
    this.currentState = state;
  }
  
  void playSound(SoundEvent event){
    switch(event){
      case Jump:
        break;
      case Start:
        if(currentState instanceof TestState1)
          println("play start " + currentState.getClass().getName());
        if(currentState instanceof TestState2)
          println("play start " + currentState.getClass().getName());
        break;
      case End:
        if(currentState instanceof TestState1)
          println("play end " + currentState.getClass().getName());
        if(currentState instanceof TestState2)
          println("play end " + currentState.getClass().getName());
        break;
      case TriangleCreated:
        break;
      case CircleCollapsed:
        break;
    }
  };
  
}