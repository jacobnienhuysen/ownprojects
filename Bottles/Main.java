import bottles.*;

import java.util.Scanner;

public class Main {

    private static Scanner input = new Scanner(System.in);

    public static void main(String[] args){

        //Instantiate program class
        BottleBattle bottleBattle = new BottleBattle();

        //Wanted liters
        int wantedAmount = userInput();

        //Run program
        int shortestPathLength = bottleBattle.run(wantedAmount);

        System.out.println("Minsta antalet steg som krävs: " + shortestPathLength);

    }


    /**
     * Prints message and returns user input, if not illegal value or input.
     *
     * @return wanted number of liters
     */

    protected static int userInput(){

        //result
        int wantedAmount = 0;

        //keep asking until user provides valid input (an integer 0-8)
        while(true) {

            try {

                //Print message
                System.out.print("Önskad mängd: ");

                wantedAmount = Integer.parseInt(input.nextLine());

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

        }

        return wantedAmount;
    }

}
