import java.util.ArrayList;

public class BottleBattle {

    private ArrayList<State> stateList = new ArrayList<>();

    private final int BOTTLE_A_SIZE = 3;
    private final int BOTTLE_B_SIZE = 5;

    public static void main(String[] args){

    }

    private void evaluate(State state){

        State temp = null;

        if(!state.getBottleA().isEmpty()){
            createState(new Bottle(state.getBottleA().getSize()), state.getBottleB());

            if(!state.getBottleB().isFull()){
                createState();
            }

        }

        evaluate(temp);
    }


    //Create new state if not already present in state list
    private void createState(Bottle a, Bottle b){

        if(!stateExists(a,b)){
            stateList.add(new State(a,b));
        }

    }

    //Return true if there already is a state with sa
    private boolean stateExists(Bottle a, Bottle b){

        for(State state : stateList){
            if(state.getBottleA().getContent() == a.getContent() && state.getBottleB().getContent() == b.getContent()){
                return true;
            }
        }

        return false;
    }

}
