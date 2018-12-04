
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class BottleBattle {

    private ArrayList<State> stateList = new ArrayList<>();
    private int stepCounter = 0;
    private State currentState = null;

    private final int BOTTLE_A_SIZE = 3;
    private final int BOTTLE_B_SIZE = 5;

    public static void main(String[] args){

        int wanted = 1;

        BottleBattle bottleBattle = new BottleBattle();

        State temp = bottleBattle.init();
        bottleBattle.stateList.add(temp);
        bottleBattle.evaluate(temp);

        ArrayList<State> result = bottleBattle.shortestPathTo(wanted);

        System.out.println(result);

    }

    private State init(){

        stateList.clear();

        Bottle b1 = new Bottle(BOTTLE_A_SIZE, 0);
        Bottle b2 = new Bottle(BOTTLE_B_SIZE, 0);

        return new State(b1,b2);
    }



    private void evaluate(State state){

        Bottle tempA = state.getBottleA();
        Bottle tempB = state.getBottleB();

        //State previousStep = state.getPreviousStep();

        //Kolla först kombinationen A-B

        //Om flaska A inte är tom, töm i badkaret
        if(tempA.getContent() != 0){

            //Töm i badkaret, dvs. skapa nytt state
            createState(new Bottle(tempA.getSize(), 0),tempB, state);

            //Om flaska B inte är full, fyll på från A
            if(tempB.getContent() != tempB.getSize()){

                int totalAmount = state.getCurrentContent();

                //Allt vatten får inte plats i flaska B
                if(totalAmount > tempB.getSize()){
                    int leftInA = totalAmount - tempB.getSize();
                    createState(new Bottle(tempA.getSize(), leftInA), new Bottle(tempB.getSize(), tempB.getSize()), state);
                }
                //Allt vatten får plats i flaska B
                else{
                    createState(new Bottle(tempA.getSize(),0), new Bottle(tempB.getSize(), state.getCurrentContent()), state);
                }
            }
        }

        //Om flaska A inte är full
        if(tempA.getContent() != tempA.getSize()){
            createState(new Bottle(tempA.getSize(), tempA.getSize()), new Bottle(tempB.getSize(), tempB.getContent()), state);
        }

        //Kolla först kombinationen B-A

        //Om flaska B inte är tom, töm i badkaret
        if(tempB.getContent() != 0){

            //Töm i badkaret, dvs. skapa nytt state
            createState(tempA, new Bottle(tempB.getSize(), 0), state);

            //Om flaska A inte är full, fyll på från B
            if(tempA.getContent() != tempA.getSize()){

                int totalAmount = state.getCurrentContent();

                //Allt vatten får inte plats i flaska A
                if(totalAmount > tempA.getSize()){
                    int leftInB = totalAmount - tempA.getSize();
                    createState(new Bottle(tempA.getSize(), tempA.getSize()), new Bottle(tempB.getSize(), leftInB), state);
                }
                //Allt vatten får plats i flaska A
                else{
                    createState(new Bottle(tempA.getSize(),state.getCurrentContent()), new Bottle(tempB.getSize(), 0), state);
                }
            }
        }

        //Om flaska B inte är full
        if(tempB.getContent() != tempB.getSize()){
            createState(new Bottle(tempA.getSize(), tempA.getContent()), new Bottle(tempB.getSize(), tempB.getSize()), state);
        }

    }


    private void createState(Bottle bottleA, Bottle bottleB, State previousStep){

        if(!stateExists(bottleA.getContent(), bottleB.getContent())){
            State tempState = new State(bottleA, bottleB);
            tempState.setPreviousStep(previousStep);
            stateList.add(tempState);
            evaluate(tempState);
        }
    }


    private boolean stateExists(int bottleAContent, int bottleBContent){

        for(State state : stateList){
            if(state.getBottleAContent() == bottleAContent && state.getBottleBContent() == bottleBContent){
                return true;
            }
        }

        return false;
    }


    private ArrayList<State> shortestPathTo(int wantedAmount){

        //Routes, keys are result states and the arraylist contains all steps
        HashMap<State, ArrayList<State>> alternativeRoutes = new HashMap<>();

        for(State state : stateList){

            //If state has wanted amount of water, count the steps
            if(state.getCurrentContent() == wantedAmount){
                alternativeRoutes.put(state, new ArrayList<>());

                State previousStep = state.getPreviousStep();

                //Go to previous step until you get to start state
                while(previousStep != null){
                    alternativeRoutes.get(state).add(previousStep);
                    previousStep = previousStep.getPreviousStep();
                }

            }
        }

        if(!alternativeRoutes.isEmpty()) {

            ArrayList<State> shortestRoute = new ArrayList<>();
            int shortest = Integer.MAX_VALUE;

            for (Map.Entry<State, ArrayList<State>> route : alternativeRoutes.entrySet()) {

                //Get length of current route
                int routeLength = route.getValue().size();

                //If shorter than previous, save route
                if (routeLength < shortest && routeLength != 0) {
                    shortestRoute = route.getValue();
                }

            }

            //Flip list so path starts from beginning
            Collections.reverse(shortestRoute);

            return shortestRoute;
        }

        return null;
    }

}