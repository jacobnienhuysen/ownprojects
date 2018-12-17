import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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

    //Lists of necessary steps to reach goal
    private ArrayList<State> runOneResult = new ArrayList<>();
    private ArrayList<State> runTwoResult = new ArrayList<>();

    //Temporary list of steps
    private ArrayList<State> stepList = new ArrayList<>();

    //Current state evaluated
    private State currentState = null;

    //Current state index
    private int currentIndex = 0;

    //Remember if first run
    boolean firstRun = true;

    private void init(){

        //User input scanner
        Scanner scan = new Scanner(System.in);

        //Print message
        System.out.print("Önskad mängd: ");

        //Handle input
        while(true) {
            try {

                //Wanted amount input
                wantedAmount = Integer.parseInt(scan.nextLine());

                //Check if not to large or small
                if(wantedAmount < 0 || wantedAmount > 8){
                    throw new IllegalArgumentException();
                }

                break;

            }catch(NumberFormatException e){
                System.out.println("Ogiltigt värde. Försök igen!");
            }catch(IllegalArgumentException e){
                System.out.println(wantedAmount + " går inte att räkna ut. Försök med en annan mängd.");
            }

            System.out.print("Önskad mängd: ");
        }

        //Run algorithm 5-3
        run(firstRun);

        //Change run switch to false, to denote second run
        firstRun = false;

        //Run algorithm 3-5
        run(firstRun);

        //Get lenght of shortest path
        int shortestPathLength = shortestPath();

        System.out.println("Minsta antalet steg som krävs: " + shortestPathLength);

    }

    /**
     * Start algorithm.
     * Temp step list is cleared.
     * An initial state with empty bottles is created and added to temp step list.
     * Current state is set to the empty state and current index is set to 0.
     *
     * Loop runs as long as there is an unevaluated state in list.
     *
     * Finally, the temp result list is returned.
     *
     */

    private void run(boolean firstRun){

        //Clear temporary step list
        stepList.clear();

        //Create first state
        currentState = createEmptyState(firstRun);

        //Add first state to temporary list
        stepList.add(currentState);

        //Current index to zero
        currentIndex = 0;

        //Run evaluation as long as new states are added to temporary state list
        while(currentState != null){

            //Evaluate state
            evaluate(currentState);

            //Increase index counter
            currentIndex++;

            //If there is an unevaluated state next in list, evaluate
            if(currentIndex < stepList.size()) {
                currentState = stepList.get(currentIndex);
            }

            //If no more states in list, set current to null to break loop
            else{
                currentState = null;
            }
        }

        if(firstRun){
            runOneResult.addAll(stepList);
        }
        else{
            runTwoResult.addAll(stepList);
        }

    }



    /**
     * Create empty state
     *
     * @return State with empty bottles.
     */

    private State createEmptyState(boolean firstRun){

        //Create empty bottles
        Bottle a = new Bottle(BOTTLE_A_SIZE);
        Bottle b = new Bottle(BOTTLE_B_SIZE);

        //Return empty state
        if(firstRun){
            return new State(a, b);
        }
        else{
            return new State(b, a);
        }
    }

    /**
     * Evaluate each state by passing it to the three steps.
     *
     * @param state
     */

    private void evaluate(State state){

        //Step one
        //Fill first bottle if empty
        stepOne(state);

        //Step two
        //Fill second bottle from first
        stepTwo(state);

        //Step three
        //If second bottle is full, empty it and transfer water from first bottle
        stepThree(state);

    }


    /**
     * Step one
     * If a bottle is empty, fill it5, otherwise do nothing
     *
     * @param step
     */
    private void stepOne(State step){

        //Bottles of previous step
        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        //If A is empty, fill A
        if(bottleA.getContent() == 0) {
            addStep(new State(new Bottle(bottleA.getSize(), bottleA.getSize()), bottleB, step));
        }

        //If B is empty, fill B
        if(bottleB.getContent() == 0) {
            addStep(new State(bottleA, new Bottle(bottleB.getSize(), bottleB.getSize()), step));
        }

    }



    /**
     * Step two
     * Transfer water from one bottle to the other
     *
     * @param step
     */
    private void stepTwo(State step){

        //Bottles of previous step
        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        //New state
        State temp = null;

        //If there is room in A and B is not empty, transfer to A
        if(!bottleA.isFull() && !bottleB.isEmpty()){

            int spaceInFirstBottle = bottleA.getAvailableSpace();
            int leftInSecondBucket = bottleB.getContent() - spaceInFirstBottle;

            if(leftInSecondBucket > 0){
                temp = new State(new Bottle(bottleA.getSize(), bottleA.getSize()), new Bottle(bottleB.getSize(), leftInSecondBucket), step);
            }
            else{
                temp = new State(new Bottle(bottleA.getSize(), bottleB.getContent()), new Bottle(bottleB.getSize()), step);
            }

            addStep(temp);
        }

        //If there is room in B and A is not empty, transfer to B
        if(!bottleB.isFull() && !bottleA.isEmpty()){

            int spaceInSecondBottle = bottleB.getAvailableSpace();
            int leftInFirstBucket = bottleA.getContent() - spaceInSecondBottle;

            if(leftInFirstBucket > 0){
                temp = new State(new Bottle(bottleA.getSize(), leftInFirstBucket), new Bottle(bottleB.getSize(), bottleB.getSize()), step);
            }
            else{
                temp = new State(new Bottle(bottleA.getSize()), new Bottle(bottleB.getSize(), bottleA.getContent()), step);
            }

            addStep(temp);
        }

    }

    /**
     * Step three
     * If a bottle is full, empty it, then transfer water to it from the other
     *
     * @param step
     */

    private void stepThree(State step){

        //Bottles from previous step
        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        //If A is full
        if(bottleA.isFull()){

            //Empty bottle A
            State temp = new State(new Bottle(bottleA.getSize()), bottleB, step);
            addStep(temp);

            int leftInSecondBucket = bottleB.getContent() - bottleA.getAvailableSpace();

            //Fill from bottle B
            if(leftInSecondBucket > 0){
                temp = new State(new Bottle(bottleA.getSize(), bottleA.getSize()), new Bottle(bottleB.getSize(), leftInSecondBucket), step);
            }
            else{
                temp = new State(new Bottle(bottleA.getSize(), bottleB.getContent()), new Bottle(bottleB.getSize()), step);
            }

            addStep(temp);
        }

        //If B is full
        if(bottleB.isFull()){

            //Empty bottle B
            State temp = new State(bottleA, new Bottle(bottleB.getSize()), step);
            addStep(temp);

            int leftInSecondBucket = bottleA.getContent() - bottleB.getAvailableSpace();

            //Fill from bottle A
            if(leftInSecondBucket > 0){
                temp = new State(new Bottle(bottleA.getSize(), leftInSecondBucket), new Bottle(bottleB.getSize(), bottleB.getSize()), step);
            }
            else{
                temp = new State(new Bottle(bottleA.getSize()), new Bottle(bottleB.getSize(), bottleB.getContent()), step);
            }

            addStep(temp);

        }
    }


    /**
     * Add step to step list if not already present
     *
     * @param step
     */
    private void addStep(State step){

        //If step is not yet in step list, add
        if(!stepExists(step, stepList)){
            stepList.add(step);
        }
    }



    /**
     * Check if step is already present in list
     *
     * @param step
     * @param stepList
     */
    private boolean stepExists(State step, ArrayList<State> stepList){

        //Loop through steps
        for(State state : stepList){
            if(state.getBottleAContent() == step.getBottleAContent() && state.getBottleBContent() == step.getBottleBContent()){
                return true;
            }
        }

        return false;
    }


    /**
     * With the two result lists as starting points, calculate minimum number of steps needed to get wanted amount of water.
     *
     * @return minimum number of steps needed
     */
    private int shortestPath(){

        //Create empty result map
        HashMap<State, ArrayList<State>> resultMap = new HashMap<>();

        //Go through result list from first run to find wanted amount of water. Add correct state in hash map as key
        for(State state : runOneResult){
            if(state.getBottleAContent() == wantedAmount || state.getBottleBContent() == wantedAmount || state.getCurrentContent() == wantedAmount){
                resultMap.put(state, new ArrayList<>());
            }
        }

        //Go through result list from second run to find wanted amount of water. Add correct state in hash map as key
        for(State state : runTwoResult){
            if(state.getBottleAContent() == wantedAmount || state.getBottleBContent() == wantedAmount || state.getCurrentContent() == wantedAmount){
                resultMap.put(state, new ArrayList<>());
            }
        }

        //For each key state, trace previous steps until initial state is found. Add all steps to array list in map
        for(State state : resultMap.keySet()){

            State previous = state.getPreviousState();

            while(previous != null){
                resultMap.get(state).add(previous);
                previous = previous.getPreviousState();
            }

        }

        //Current length of path
        int shortestPath = Integer.MAX_VALUE;

        //Traverse map to find shortest path
        for(Map.Entry<State, ArrayList<State>> path : resultMap.entrySet()){

            int temp = path.getValue().size();

            if(temp < shortestPath) {
                shortestPath = temp;
            }
        }

        return shortestPath;
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
        bottleBattle.init();

    }

}