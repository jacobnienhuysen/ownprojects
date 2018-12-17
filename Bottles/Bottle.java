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

    public boolean isFull(){
        return content == SIZE;
    }

    public boolean isEmpty(){
        return content == 0;
    }

    public int getAvailableSpace(){
        return SIZE - content;
    }

    public String toString(){
        return (SIZE + "-litersflaska som innehåller " + content + " liter vatten.");
    }

}
