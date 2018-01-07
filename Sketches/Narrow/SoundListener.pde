class SoundListener{
  
  State currentState;
  AudioTrigger audioTrigger = new AudioTrigger();
  
  void setState(State state){
    this.currentState = state;
  }
  
  void playSound(SoundEvent event){
    switch(event){
      case Jump:
        if(currentState instanceof CircleState)
          println("play jump " + currentState.getClass().getName());
        if(currentState instanceof PlexusState)
          println("play jump " + currentState.getClass().getName());
        break;
      case Start:
        if(currentState instanceof CircleState)
          println("play start " + currentState.getClass().getName());
          audioTrigger.circleVolumeGain();
        if(currentState instanceof PlexusState)
          println("play start " + currentState.getClass().getName());
        break;
      case End:
        if(currentState instanceof CircleState)
          println("play end " + currentState.getClass().getName());
          audioTrigger.circleEndTrigger();
        if(currentState instanceof PlexusState)
          println("play end " + currentState.getClass().getName());
        break;
      case TriangleCreated:
        break;
      default:
        break;
    }
  };
  
}