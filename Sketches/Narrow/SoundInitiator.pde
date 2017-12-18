class SoundInitiator {
    private List<SoundListener> listeners = new ArrayList<SoundListener>();

    public void addListener(SoundListener sl) {
        listeners.add(sl);
    }

    public void setState(State state) {
        for (SoundListener sl : listeners)
            sl.setState(state);
    }
    
    public void playSound(SoundEvent event) {
        for (SoundListener sl : listeners)
            sl.playSound(event);
    }
}