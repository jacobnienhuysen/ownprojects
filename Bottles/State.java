import java.util.ArrayList;

public class State {

    private Bottle bottleA;
    private Bottle bottleB;
    private State previousStep;

    public State(Bottle bottleA, Bottle bottleB){
        this.bottleA = bottleA;
        this.bottleB = bottleB;
        this.previousStep = null;
    }


    public Bottle getBottleA(){
        return bottleA;
    }

    public Bottle getBottleB(){
        return bottleB;
    }

    public int getBottleAContent(){
        return bottleA.getContent();
    }

    public int getBottleBContent(){
        return bottleB.getContent();
    }

    public int getCurrentContent(){
        return getBottleAContent()+getBottleBContent();
    }

    public State getPreviousStep(){
        return previousStep;
    }

    public void setPreviousStep(State step){
        previousStep = step;
    }

    public String toString(){

        return "[" + bottleA.getContent() + ", " + bottleB.getContent() + "]";

    }

}
