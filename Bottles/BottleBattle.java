import java.util.ArrayList;

public class BottleBattle {

    private final int BOTTLE_A_SIZE = 5;
    private final int BOTTLE_B_SIZE = 3;

    private int wantedAmount = 0;

    private ArrayList<State> stateList = new ArrayList<>();


    private void run(String wanted){

        wantedAmount = Integer.parseInt(wanted);

    }

    private State init(){

        Bottle a = new Bottle(BOTTLE_A_SIZE, 0);
        Bottle b = new Bottle(BOTTLE_B_SIZE, 0);

        return new State(a, b);
    }


    private void evaluateFirstRound(State state){

        //Add empty state to list
        stateList.add(state);

        //Fill first bucket
        State firstStep = new State(new Bottle(BOTTLE_A_SIZE, BOTTLE_A_SIZE), new Bottle(BOTTLE_B_SIZE));
        stateList.add(firstStep);

        //Fill second bucket from first
        State secondStep = stepTwo(firstStep);
        stateList.add(secondStep);

        if(secondStep.getBottleAContent() == wantedAmount || secondStep.getBottleBContent() == wantedAmount){
            //bryt
        }

        //If bottle B is full, empty in bottle A
        if(secondStep.getBottleBContent() == secondStep.getBottleB().getSize()){

            State thirdStep = stepThree(secondStep);
            stateList.add(thirdStep);
        }

    }


    //Step two
    //Fill bottle B from bottle A
    private State stepTwo(State firstStep){

        State secondStep = null;

        int spaceInSecondBucket = firstStep.getBottleB().getSize() - firstStep.getBottleBContent();
        if(firstStep.getBottleAContent() > spaceInSecondBucket){

            int leftInFirstBucket = firstStep.getBottleAContent() - spaceInSecondBucket;

            secondStep = new State(new Bottle(BOTTLE_A_SIZE, leftInFirstBucket), new Bottle(BOTTLE_B_SIZE, BOTTLE_B_SIZE));
        }
        else{
            secondStep = new State(new Bottle(BOTTLE_A_SIZE), new Bottle(BOTTLE_B_SIZE, firstStep.getBottleAContent()));
        }

        return secondStep;
    }


    //Step three
    //If bottle B is full, empty it and fill from bottöe A
    private State stepThree(State secondStep){

        State thirdStep = null;

        int spaceInBottleA = secondStep.getBottleA().getSize() - secondStep.getBottleAContent();
        int leftInBottleB = secondStep.getBottleBContent() - spaceInBottleA;

        if(leftInBottleB > 0){
            thirdStep = new State(new Bottle(BOTTLE_A_SIZE, BOTTLE_A_SIZE), new Bottle(BOTTLE_B_SIZE, leftInBottleB));
        }
        else{
            int newBContent = secondStep.getBottleAContent() + secondStep.getBottleBContent()
            thirdStep = new State(new Bottle(BOTTLE_A_SIZE, newBContent), new Bottle(BOTTLE_B_SIZE, 0));
        }

        return thirdStep;
    }



    //Creates new state if not already in list, and returns true. Otherwise returns false
    private boolean createState(Bottle bottleA, Bottle bottleB, State previousStep){

        if(!stateExists(bottleA.getContent(), bottleB.getContent())){
            State tempState = new State(bottleA, bottleB);
            tempState.addStep(previousStep);
            return true;
        }

        return false;
    }

    //Check if state is already in list
    private boolean stateExists(int bottleAContent, int bottleBContent){

        for(State state : stateList){
            if(state.getBottleAContent() == bottleAContent && state.getBottleBContent() == bottleBContent){
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