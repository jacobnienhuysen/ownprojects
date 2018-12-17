import java.util.ArrayList;

public class State {

    private Bottle bottleA;
    private Bottle bottleB;
    private State previousState;

    public State(Bottle bottleA, Bottle bottleB){
        this.bottleA = bottleA;
        this.bottleB = bottleB;
        previousState = null;
    }

    public State(Bottle bottleA, Bottle bottleB, State previousState){
        this(bottleA, bottleB);
        this.previousState = previousState;
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

    public State getPreviousState(){
        return previousState;
    }

    public String toString(){

        return "[" + bottleA.getContent() + ", " + bottleB.getContent() + "]";

    }

}
