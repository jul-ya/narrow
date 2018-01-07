float dB = 0.0;
boolean play = true;

class AudioTrigger{
  
  void circleVolumeGain(){
    
    //load and play Audio File
    filePlayer = new FilePlayer( minim.loadFileStream("Antigravity_Atmo.mp3"));
    filePlayer.play();
    gain = new Gain(0.f);
    out = minim.getLineOut();
    filePlayer.patch(gain).patch(out);
    
    //increase Volume
    dB+=circleSize * 0.005;
    gain.setValue(dB);
  }
  
  void circleEndTrigger(){
    
    //stopsAtmo
    filePlayer.pause();
    
    //Load Sound that is triggered at the end of the state
    snap = minim.loadSample( "Trigger.mp3", // filename
                            512      // buffer size
                         );
                         
    //Triggers the sound once
    if(play == true){
      snap.trigger(); //<>//
      play = false;
    }
  }
}