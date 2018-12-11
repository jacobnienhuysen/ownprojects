public class Bottle {

    private final int SIZE;
    private int content;

    public Bottle(int size){
        this(size,0);
    }

    public Bottle(int size, int content){
        this.SIZE = size;
        this.content = content;
    }

    public int getSize(){
        return SIZE;
    }

    public int getContent(){
        return content;
    }

    public String toString(){
        return (SIZE + "-litersflaska som innehåller " + content + " liter vatten.");
    }

}
