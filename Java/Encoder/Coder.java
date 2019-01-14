public class Coder {

    private int count = 0;
    private String key;
    private boolean encode = false;
    private final String ALPHA = "abcdefghijklmnopqrstuvwxyzåäö";
    private final String ALPHA_UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ";

    public String runVigenere(boolean encode, String encoded, String... keys){

        this.encode = encode;
        char[] charList = encoded.toCharArray();
        for(String key : keys){
            charList = shift(key, charList);
        }
        return new String(charList);
    }

    private char[] shift(String key, char[] charList){

        this.key = key;
        this.count = 0;

        for(int i = 0; i<charList.length; i++) {
	        if (ALPHA.indexOf(charList[i]) != -1){
	        	charList[i] = shiftChar(charList[i]);
	        }
    	}
        return charList;
    }

    private char shiftChar(char unshifted) {

        char nextKey = key.charAt(count++%key.length());
        int keyInt = encode ? ALPHA.indexOf(nextKey) : -ALPHA.indexOf(nextKey);
        
        int shiftedInt = (ALPHA.indexOf(unshifted) + keyInt + 29)%29;

        return ALPHA.charAt(shiftedInt);
    }
}