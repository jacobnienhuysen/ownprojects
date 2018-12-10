import java.util.ArrayList;

public class BottleBattle {

    private final int BOTTLE_A_SIZE = 3;
    private final int BOTTLE_B_SIZE = 5;

    private ArrayList<State> stateList = new ArrayList<>();


    private void run(String wanted){

        int wantedAmount = Integer.parseInt(wanted);

    }


    private void evaluate(State state){
n b
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



    //Creates new state if not already in list, and returns true. Otherwise returns false
    private boolean createState(Bottle bottleA, Bottle bottleB, State previousStep){

        if(!stateExists(bottleA.getContent(), bottleB.getContent())){
            State tempState = new State(bottleA, bottleB);
            tempState.setPreviousStep(previousStep);
            stateList.add(tempState);
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

        bottleBattle.run(args[0]);

    }

}
