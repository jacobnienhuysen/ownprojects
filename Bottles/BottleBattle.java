import java.util.ArrayList;
import java.util.Scanner;

/**
 * TODO 1: Se till att alla steg räknas korrekt. Glöm inte hällningar från en flaska till en annan i steg 4!
 * TODO 2: Kör båda alogritmerna efter varandra och returnera den med kortast väg!
 * TODO 3: Strukturera och kommentera!
 *
 */

public class BottleBattle {

    //Bottle sizes
    private final int BOTTLE_A_SIZE = 5;
    private final int BOTTLE_B_SIZE = 3;

    //Wanted amount of water
    private int wantedAmount = 0;

    //List of necessary steps to reach goal
    private ArrayList<State> stepList = new ArrayList<>();


    private void run(){

        //User input scanner
        Scanner scan = new Scanner(System.in);
        System.out.print("Önskad mängd: ");

        //Wanted amount input
        wantedAmount = Integer.parseInt(scan.nextLine());

        //Run algorithm twice. First 5-3 then 3-5.
        evaluate(init(true));
        evaluate(init(false));

        //Choose shortest path from the two

    }

    /**
     * Preparation before running algorithm
     * Pass parameter true for first run and false for second run in order to switch bottle sizes.
     *
     * Clears step list and returns an empty state.
     *
     * @param firstRound
     * @return State [0,0]
     */

    private State init(boolean firstRound){

        //Clear step list
        stepList.clear();

        //Create empty bottles
        Bottle a = new Bottle(BOTTLE_A_SIZE);
        Bottle b = new Bottle(BOTTLE_B_SIZE);

        //Return empty state
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


    /**
     * Step one
     * If bottle A is empty, fill A, otherwise return state as is
     *
     * @param step
     * @return
     */
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



    /**
     * Step two
     * Transfer water from bottle a to bottle b
     *
     * @param step
     * @return
     */
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



    /**
     * Step four
     * If bottle B is full, empty it, then transfer water from bottle A to B
     *
     * @param step
     * @return
     */
    private State stepFour(State step){

        System.out.println("STEG fyra " + step);

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


    /**
     * Add step to step list if not already present
     *
     * @param step
     */
    private void addStep(State step){

        boolean stepExists = false;

        //Loop through steps
        for(State state : stepList){
            if(state.getBottleAContent() == step.getBottleAContent() && state.getBottleBContent() == step.getBottleBContent()){
                stepExists = true;
            }
        }

        //If step is not yet in step list, add
        if(!stepExists){
            stepList.add(step);
        }

    }


    /**
     * Main method
     *
     * @param args
     */
    public static void main(String[] args){

        //Instantiate main class
        BottleBattle bottleBattle = new BottleBattle();

        //Run program
        bottleBattle.run();

    }

}