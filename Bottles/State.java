import java.util.ArrayList;

public class State {

    private Bottle bottleA;
    private Bottle bottleB;
    private ArrayList<State> steps;

    public State(Bottle bottleA, Bottle bottleB){
        this.bottleA = bottleA;
        this.bottleB = bottleB;
        this.steps = new ArrayList<>();
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

    public ArrayList<State> getSteps(){
        return steps;
    }

    public void addStep(State step){
        steps.add(step);
    }

    public String toString(){

        return "[" + bottleA.getContent() + ", " + bottleB.getContent() + "], " + steps.size() + " steg\n";

    }

}
