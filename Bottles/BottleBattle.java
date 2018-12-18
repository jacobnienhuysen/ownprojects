package bottles;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class BottleBattle {

    //bottles.Bottle sizes
    private final int BOTTLE_A_SIZE = 5;
    private final int BOTTLE_B_SIZE = 3;

    //Current state evaluated
    private State currentState = null;

    //Current state index
    private int currentIndex = 0;


    /**
     * The BottleBattle starts here.
     *
     * Firstly, the algorithm is run twice to calculate all possible states.
     * Thereafter the two resulting lists are analyzed to find the minimum amount of actions needed to obtain the wished amount of water.
     * Finally, the result is returned as an integer.
     *
     * @param wantedAmount The wanted amount of water
     * @return the minimum number of actions needed to reach wanted amount of water
     */

    public int run(int wantedAmount){

        //Run algorithm 5-3
        ArrayList<State> runOneResult = calculatePossibleSteps(true);

        //Run algorithm 3-5
        ArrayList<State> runTwoResult = calculatePossibleSteps(false);

        //Get length of shortest path
        return shortestPath(wantedAmount, runOneResult, runTwoResult);

    }


    /**
     * The algorithm starts here.
     *
     * An empty result list is created.
     * currentState is set to an empty state which is also added to the result list.
     * Loop runs as long as there is an unevaluated state in list.
     *
     * Finally, the temp result list is returned.
     *
     */

    protected ArrayList<State> calculatePossibleSteps(boolean firstRun){

        //Init new step list
        ArrayList<State> stepList = new ArrayList<>();

        //Create first state
        currentState = createEmptyState(firstRun);

        //Add first state to temporary list
        stepList.add(currentState);

        //Current index to zero
        currentIndex = 0;

        //Run evaluation as long as new states are added to temporary state list
        while(currentState != null){

            //Evaluate state
            evaluate(currentState, stepList);

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

        return stepList;
    }



    /**
     * Create empty state
     *
     * @return bottles.State with empty bottles.
     */

    protected State createEmptyState(boolean firstRun){

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

    private void evaluate(State state, ArrayList<State> stepList){

        //Step one
        //Fill first bottle if empty
        stepOne(state, stepList);

        //Step two
        //Fill second bottle from first
        stepTwo(state, stepList);

        //Step three
        //If second bottle is full, empty it and transfer water from first bottle
        stepThree(state, stepList);

    }


    /**
     * Step one
     * If a bottle is empty, fill it5, otherwise do nothing
     *
     * @param step
     */
    private void stepOne(State step, ArrayList<State> stepList){

        //Bottles of previous step
        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        //If A is empty, fill A
        if(bottleA.getContent() == 0) {
            addStep(new State(new Bottle(bottleA.getSize(), bottleA.getSize()), bottleB, step), stepList);
        }

        //If B is empty, fill B
        if(bottleB.getContent() == 0) {
            addStep(new State(bottleA, new Bottle(bottleB.getSize(), bottleB.getSize()), step), stepList);
        }

    }



    /**
     * Step two
     * Transfer water from one bottle to the other
     *
     * @param step
     */
    private void stepTwo(State step, ArrayList<State> stepList){

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

            addStep(temp, stepList);
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

            addStep(temp, stepList);
        }

    }

    /**
     * Step three
     * If a bottle is full, empty it, then transfer water to it from the other
     *
     * @param step
     */

    private void stepThree(State step, ArrayList<State> stepList){

        //Bottles from previous step
        Bottle bottleA = step.getBottleA();
        Bottle bottleB = step.getBottleB();

        //If A is full
        if(bottleA.isFull()){

            //Empty bottle A
            State temp = new State(new Bottle(bottleA.getSize()), bottleB, step);
            addStep(temp, stepList);

            int leftInSecondBucket = bottleB.getContent() - bottleA.getAvailableSpace();

            //Fill from bottle B
            if(leftInSecondBucket > 0){
                temp = new State(new Bottle(bottleA.getSize(), bottleA.getSize()), new Bottle(bottleB.getSize(), leftInSecondBucket), step);
            }
            else{
                temp = new State(new Bottle(bottleA.getSize(), bottleB.getContent()), new Bottle(bottleB.getSize()), step);
            }

            addStep(temp, stepList);
        }

        //If B is full
        if(bottleB.isFull()){

            //Empty bottle B
            State temp = new State(bottleA, new Bottle(bottleB.getSize()), step);
            addStep(temp, stepList);

            int leftInSecondBucket = bottleA.getContent() - bottleB.getAvailableSpace();

            //Fill from bottle A
            if(leftInSecondBucket > 0){
                temp = new State(new Bottle(bottleA.getSize(), leftInSecondBucket), new Bottle(bottleB.getSize(), bottleB.getSize()), step);
            }
            else{
                temp = new State(new Bottle(bottleA.getSize()), new Bottle(bottleB.getSize(), bottleB.getContent()), step);
            }

            addStep(temp, stepList);
        }
    }


    /**
     * Add step to step list if not already present
     *
     * @param step
     */
    private void addStep(State step, ArrayList<State> stepList){

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
    protected boolean stepExists(State step, ArrayList<State> stepList){

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
    private int shortestPath(int wantedAmount, ArrayList<State> runOneResult, ArrayList<State> runTwoResult){

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

}