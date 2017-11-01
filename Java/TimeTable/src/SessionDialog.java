import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class SessionDialog {

    public static void display(Session session){
        Stage window = new Stage();

        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Passdetaljer");
        window.setMinWidth(250);


        //Close button
        Button closeButton = new Button("Stäng");
        closeButton.setOnAction(e -> window.close());


        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10,10,10,10));
        grid.setVgap(5);
        grid.setHgap(5);

        grid.add(new Label("Datum: "),1,1);
        grid.add(new Label("Beskrivning: "),1,2);
        grid.add(new Label("Starttid: "),1,3);
        grid.add(new Label("Sluttid: "),1,4);
        grid.add(new Label("Längd"), 1,5);

        grid.add(new Label(formatDate(session.getSessionStart())), 2,1);
        grid.add(new Label(session.getDescription()), 2,2);
        grid.add(new Label(session.getSessionStartTime()), 2,3);
        grid.add(new Label(session.getSessionEndTime()), 2,4);
        grid.add(new Label(session.getCompleteDuration()),2,5);

        grid.add(closeButton,1,6,2,1);

        grid.setAlignment(Pos.BASELINE_CENTER);

        window.setScene(new Scene(grid));
        window.showAndWait();

    }

    //Format timestamp and return date as "Thursday, 26 october 2017"
    private static String formatDate(LocalDateTime timeStamp){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMMM YYYY");
        String temp = timeStamp.format(formatter);

        return temp;
    }

}
