import java.util.ArrayList;

/**
 * TODO 1: Se till att alla steg räknas korrekt. Glöm inte hällningar från en flaska till en annan i steg 4!
 * TODO 2: Kör båda alogritmerna efter varandra och returnera den med kortast väg!
 * TODO 3: Strukturera och kommentera!
 *
 */

public class BottleBattle {

    private final int BOTTLE_A_SIZE = 5;
    private final int BOTTLE_B_SIZE = 3;

    private int wantedAmount = 0;

    private ArrayList<State> stepList = new ArrayList<>();

    private void run(String wanted){

        wantedAmount = Integer.parseInt(wanted);

        System.out.println("Jag vill ha " + wanted);

        evaluate(init(true));

        //evaluateSecondRound(init(false));

    }

    private State init(boolean firstRound){

        stepList.clear();

        Bottle a = new Bottle(BOTTLE_A_SIZE, 0);
        Bottle b = new Bottle(BOTTLE_B_SIZE, 0);

        if(firstRound){
            return new State(a, b);
        }
        else{
            return new State(b, a);
        }
    }


    private void evaluate(State state){

        //Step one
        //Fill first bucket if empty
        State firstStep = stepOne(state);
        addStep(firstStep);

        //Step two
        //Fill second bucket from first
        State secondStep = stepTwo(firstStep);
        addStep(secondStep);

        //Step three
        //Break if we have got the amount we want
        if(secondStep.getBottleAContent() == wantedAmount || secondStep.getBottleBContent() == wantedAmount){
            System.out.println("Klar! " + stepList.size() + " steg.");

            System.out.println(stepList);
        }
        else {

            //Step four
            //If bottle B is full, empty it and transfer water from A
            State fourthStep = secondStep;
            if (fourthStep.getBottleBContent() == fourthStep.getBottleB().getSize()) {

                fourthStep = stepFour(secondStep);

            }

            addStep(fourthStep);
            evaluate(fourthStep);
        }

    }


    //Step one
    //If bottle A is empty, fill A, otherwise return state as is
    private State stepOne(State step){

        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        if(bottleA.getContent() == 0) {
            return new State(new Bottle(bottleA.getSize(), bottleA.getSize()), bottleB);
        }
        else{
            return step;
        }

    }



    //Step two
    //Transfer water from bottle a to bottle b
    private State stepTwo(State step){

        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        int spaceInSecondBottle = bottleB.getSize() - bottleB.getContent();
        if(bottleA.getContent() > spaceInSecondBottle){

            int leftInFirstBucket = bottleA.getContent() - spaceInSecondBottle;

            return new State(new Bottle(bottleA.getSize(), leftInFirstBucket), new Bottle(bottleB.getSize(), bottleB.getSize()));
        }
        else{
            return new State(new Bottle(bottleA.getSize()), new Bottle(bottleB.getSize(), bottleA.getContent()));
        }

    }


    //Step four
    //If bottle B is full, empty it, then transfer water from bottle A to B
    private State stepFour(State step){

        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        int leftInBottleA = bottleA.getContent() - bottleB.getSize();

        State state;

        if(leftInBottleA > 0){
            state = new State(new Bottle(bottleA.getSize(), leftInBottleA), new Bottle(bottleB.getSize(), bottleB.getSize()));
        }
        else{
            int newBContent = bottleB.getSize() + leftInBottleA;
            state = new State(new Bottle(bottleA.getSize()), new Bottle(bottleB.getSize(), newBContent));
        }


        return state;
    }



    private void addStep(State state){

        if(!stepExists(state)){
            stepList.add(state);
        }

    }


    private boolean stepExists(State step){

        for(State state : stepList){
            if(state.getBottleAContent() == step.getBottleAContent() && state.getBottleBContent() == step.getBottleBContent()){
                return true;
            }
        }

        return false;
    }


    // Main method
    public static void main(String[] args){

        BottleBattle bottleBattle = new BottleBattle();

        String wanted = "1";

        bottleBattle.run(wanted);

        //bottleBattle.run(args[0]);

    }

}