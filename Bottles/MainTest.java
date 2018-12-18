import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeAll;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintStream;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {

    private static final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private static final PrintStream originalOut = System.out;

    @BeforeAll
    public static void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @Test
    void userInputSmallerThanZero() {

        String input = "-1";
        InputStream in = new ByteArrayInputStream(input.getBytes());

        assertThrows(IllegalArgumentException.class,  () -> {System.setIn(in);});

    }

    @Test
    void userInputIsZero() {

        String input = "0";
        InputStream in = new ByteArrayInputStream(input.getBytes());
        System.setIn(in);
        assertEquals(0, Main.userInput());
    }

    @Test
    void userInputIsOne() {

        String input = "1";
        InputStream in = new ByteArrayInputStream(input.getBytes());
        System.setIn(in);
        assertEquals(1, Main.userInput());
    }

    @Test
    void userInputIsNotNumeral() {

        String input = "kk";
        InputStream in = new ByteArrayInputStream(input.getBytes());
        System.setIn(in);
        assertEquals("", outContent.toString());
    }

    @Test
    void userInputIsGreaterThanEight() {

        String input = "9";
        InputStream in = new ByteArrayInputStream(input.getBytes());
        System.setIn(in);
        assertEquals("", outContent.toString());
    }

    @AfterAll
    public static void restoreStreams() {
        System.setOut(originalOut);

    }

}