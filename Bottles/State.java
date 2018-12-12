import java.util.ArrayList;

public class State {

    private Bottle bottleA;
    private Bottle bottleB;

    public State(Bottle bottleA, Bottle bottleB){
        this.bottleA = bottleA;
        this.bottleB = bottleB;
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

    public String toString(){

        return "[" + bottleA.getContent() + ", " + bottleB.getContent() + "]";

    }

}
