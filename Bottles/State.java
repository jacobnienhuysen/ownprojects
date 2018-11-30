public class State {

    private Bottle bottleA;
    private Bottle bottleB;

    public State(Bottle bottleA, Bottle bottleB){
        this.bottleA = bottleA;
        this.bottleB = bottleB;
    }

    public Bottle getBottleA(){
        return bottleA;
    }

    public Bottle getBottleB(){
        return bottleB;
    }

    public int getTotal(){
        return bottleA.getContent()+bottleB.getContent();
    }

}
