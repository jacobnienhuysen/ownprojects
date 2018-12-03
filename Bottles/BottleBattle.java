import javax.lang.model.type.ArrayType;
import java.util.ArrayList;

public class BottleBattle {

    private ArrayList<State> stateList = new ArrayList<>();
    private int stepCounter = 0;

    private final int BOTTLE_A_SIZE = 3;
    private final int BOTTLE_B_SIZE = 5;

    public static void main(String[] args){

        BottleBattle bottleBattle = new BottleBattle();

        State temp = bottleBattle.init();
        bottleBattle.stateList.add(temp);
        bottleBattle.evaluate(temp);

        System.out.println(bottleBattle.stateList);
        System.out.println(bottleBattle.stateList.size());
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

        ArrayList<State> previousSteps = new ArrayList<>(state.getSteps());

        //Kolla först kombinationen A-B

        //Om flaska A inte är tom, töm i badkaret
        if(tempA.getContent() != 0){

            //Töm i badkaret, dvs. skapa nytt state
            createState(new Bottle(tempA.getSize(), 0),tempB, previousSteps);

            //Om flaska B inte är full, fyll på från A
            if(tempB.getContent() != tempB.getSize()){

                int totalAmount = state.getCurrentContent();

                //Allt vatten får inte plats i flaska B
                if(totalAmount > tempB.getSize()){
                    int leftInA = totalAmount - tempB.getSize();
                    createState(new Bottle(tempA.getSize(), leftInA), new Bottle(tempB.getSize(), tempB.getSize()), previousSteps);
                }
                //Allt vatten får plats i flaska B
                else{
                    createState(new Bottle(tempA.getSize(),0), new Bottle(tempB.getSize(), state.getCurrentContent()), previousSteps);
                }
            }
        }

        //Om flaska A inte är full
        if(tempA.getContent() != tempA.getSize()){
            createState(new Bottle(tempA.getSize(), tempA.getSize()), new Bottle(tempB.getSize(), tempB.getContent()), previousSteps);
        }

        //Kolla först kombinationen B-A

        //Om flaska B inte är tom, töm i badkaret
        if(tempB.getContent() != 0){

            //Töm i badkaret, dvs. skapa nytt state
            createState(tempA, new Bottle(tempB.getSize(), 0), previousSteps);

            //Om flaska A inte är full, fyll på från B
            if(tempA.getContent() != tempA.getSize()){

                int totalAmount = state.getCurrentContent();

                //Allt vatten får inte plats i flaska A
                if(totalAmount > tempA.getSize()){
                    int leftInB = totalAmount - tempA.getSize();
                    createState(new Bottle(tempA.getSize(), tempA.getSize()), new Bottle(tempB.getSize(), leftInB), previousSteps);
                }
                //Allt vatten får plats i flaska A
                else{
                    createState(new Bottle(tempA.getSize(),state.getCurrentContent()), new Bottle(tempB.getSize(), 0), previousSteps);
                }
            }
        }

        //Om flaska B inte är full
        if(tempB.getContent() != tempB.getSize()){
            createState(new Bottle(tempA.getSize(), tempA.getContent()), new Bottle(tempB.getSize(), tempB.getSize()), previousSteps);
        }

    }


    private void createState(Bottle bottleA, Bottle bottleB, ArrayList<State> previousSteps){

        State tempState = new State(bottleA, bottleB);
        tempState.getSteps().addAll(previousSteps);


        if(!stateExists(bottleA.getContent(), bottleB.getContent())){
            stateList.add(tempState);
        }
        else{
            tempState.addStep(tempState);
        }

        evaluate(tempState);
    }


    private boolean stateExists(int bottleAContent, int bottleBContent){

        for(State state : stateList){
            if(state.getBottleAContent() == bottleAContent && state.getBottleBContent() == bottleBContent){
                return true;
            }
        }

        return false;
    }
}