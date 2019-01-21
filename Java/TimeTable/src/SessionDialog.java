import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;


public class SessionDialog {

    private Session session;
    private Button closeButton, saveButton;
    private TextField descriptionField;
    private ComboBox<String> startHour, startMin, endHour, endMin;
    private ArrayList<Session> sessionList;

    public SessionDialog(Session session, ArrayList<Session> sessionList){
        this.session = session;
        this.sessionList = sessionList;
        display();
    }

    private void display(){
        Stage window = new Stage();

        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Detaljer");
        window.setMinWidth(250);

        //Close button
        closeButton = new Button("Stäng");
        closeButton.setOnAction(e -> window.close());
        closeButton.setId("closeButton");

        //Save button
        saveButton = new Button("Spara och stäng");
        saveButton.setOnAction(e -> {
            if(update()){
                window.close();
            }
            else{
                saveButton.setDisable(true);
            }
        });
        saveButton.setDisable(true);
        saveButton.setId("saveButton");


        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10,10,10,10));
        grid.setVgap(5);
        grid.setHgap(5);

        grid.add(new Label("Datum: "),1,1);
        grid.add(new Label("Beskrivning: "),1,2);
        grid.add(new Label("Starttid: "),1,3);
        grid.add(new Label("Sluttid: "),1,4);
        grid.add(new Label("Längd:"), 1,5);

        grid.add(new Label(formatDate(session.getSessionStart())), 2,1);
        grid.add(descriptionField = new TextField(session.getDescription()), 2,2);
        descriptionField.textProperty().addListener((obs, oldValue, newValue) -> {
            if(descriptionField.getText().trim().length() > 0) {
                saveButton.setDisable(false);
            }
            else{
                saveButton.setDisable(true);
            }
        });

        //Hour lists
        startHour = new ComboBox<>();
        startHour.setMaxWidth(65);
        startHour.setMinWidth(65);

        endHour = new ComboBox<>();
        endHour.setMaxWidth(65);
        endHour.setMinWidth(65);

        //Fill hour lists with values 0-23
        for(int i = 0; i < 24; i++){
            startHour.getItems().add(i<10 ? "0" + i : "" + i);
            endHour.getItems().add(i<10 ? "0" + i : "" + i);
        }


        //Start minute lists
        startMin = new ComboBox<>();
        startMin.setMaxWidth(65);
        startMin.setMinWidth(65);

        //End minute lists
        endMin = new ComboBox<>();
        endMin.setMaxWidth(65);
        endMin.setMinWidth(65);

        //Fill minute lists with values 0-59
        for(int i = 0; i < 60; i++){
            startMin.getItems().add(i<10 ? "0" + i : "" + i);
            endMin.getItems().add(i<10 ? "0" + i : "" + i);
        }


        //Set start list values
        int sessionStartHour = session.getSessionStart().getHour();
        int sessionStartMinute = session.getSessionStart().getMinute();
        startHour.setValue(sessionStartHour<10 ? "0" + sessionStartHour : "" + sessionStartHour);
        startMin.setValue(sessionStartMinute<10 ? "0" + sessionStartMinute : "" + sessionStartMinute);

        //Start time box
        HBox startTimeBox = new HBox(5);
        startTimeBox.getChildren().addAll(startHour, new Label(":"), startMin);

        //Add start time box to grid
        grid.add(startTimeBox, 2,3);

        //If session is still active, set lists disabled
        if(session.isActive()) {
            endHour.setDisable(true);
            endMin.setDisable(true);
        }
        else{
            //If session has ended, set end time
            int sessionEndHour = session.getSessionEnd().getHour();
            int sessionEndMinute = session.getSessionEnd().getMinute();
            endHour.setValue(sessionEndHour<10 ? "0" + sessionEndHour : "" + sessionEndHour);
            endMin.setValue(sessionEndMinute<10 ? "0" + sessionEndMinute : "" + sessionEndMinute);
        }

        //End time box
        HBox endTimeBox = new HBox(5);
        endTimeBox.getChildren().addAll(endHour, new Label(":"), endMin);

        //Add end time box to grid
        grid.add(endTimeBox, 2,4);

        //Add duration label to grid
        grid.add(new Label(formatDuration(session.getCompleteDuration())),2,5);

        //Bottom button box
        HBox buttonBox = new HBox(10);
        buttonBox.getChildren().addAll(saveButton, closeButton);

        //Add button box to layout
        grid.add(buttonBox,1,6,2,1);

        //Hour listeners
        startHour.getSelectionModel().selectedItemProperty().addListener((obs, oldValue, newValue) -> saveButton.setDisable(false));
        endHour.getSelectionModel().selectedItemProperty().addListener((obs, oldValue, newValue) -> saveButton.setDisable(false));

        //Minute listeners
        startMin.getSelectionModel().selectedItemProperty().addListener((obs, oldValue, newValue) -> saveButton.setDisable(false));
        endMin.getSelectionModel().selectedItemProperty().addListener((obs, oldValue, newValue) -> saveButton.setDisable(false));

        //Add grid to scene
        grid.setAlignment(Pos.BASELINE_CENTER);
        Scene scene = new Scene(grid);

        //Add key listener to saveButton
        setGlobalEventHandler(grid);

        //Add styling
        grid.getStylesheets().add("Styles.css");

        //Add scene to stage
        window.setScene(scene);

        //Show window
        window.showAndWait();

    }


    //Format timestamp and return date as "Thursday, 26 october 2017"
    private String formatDate(LocalDateTime timeStamp){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMMM YYYY");

        return timeStamp.format(formatter);
    }


    //Format duration in seconds and return as "01:23:45"
    private String formatDuration(Duration duration){

        int hours = duration.toHoursPart();
        int minutes = duration.toMinutesPart();
        int seconds = duration.toSecondsPart();

        return String.format("%02d", hours) + ":" + String.format("%02d", minutes) + ":" + String.format("%02d", seconds);

    }



    /**
     * Checks if given description, start and end times are valid and, if so, updates session object.
     *
     * @return true - if successful, false - if any given value is invalid or in case of any other error
     */

    private boolean update(){

        //Fetch description from field and trim
        String description = descriptionField.getText().trim();

        //Update description if not empty
        if(description.length() > 0 ){
            session.setDescription(description);
        }
        else{
            errorAlert("Ange en beskrivning!");
            return false;
        }

        //Fetch start time values
        LocalTime start = LocalTime.of(Integer.parseInt(startHour.getValue()), Integer.parseInt(startMin.getValue()));

        //Check if time is not in the future
        if(inTheFuture(start)){
            errorAlert("Passet får inte börja i framtiden!");
            return false;
        }

        //Get index of THIS session
        int index = sessionList.indexOf(session);


        //Change end of the preceding session, if THIS is not first
        if(index > 0){

            //Get index of the preceding session
            Session previousSession = sessionList.get(index - 1);

            try {

                //Set end of preceding session
                previousSession.setEnd(start);


            }catch(IllegalArgumentException e){
                errorAlert("Passet får inte börja innan föregående pass!");
                return false;
            }
        }


        //Set start of THIS session
        try {
            session.setStart(start);
        }catch(IllegalArgumentException e){
            errorAlert("Starttiden kan inte vara en tidpunkt efter sluttiden");
            return false;
        }


        //If THIS session is not active, allow change of end time of THIS session (and succeeding session)
        if(!session.isActive()) {

            //Fetch end time values
            LocalTime end = LocalTime.of(Integer.parseInt(endHour.getValue()), Integer.parseInt(endMin.getValue()));

            //Check if time is not in the future
            if(inTheFuture(end)){
                errorAlert("Sluttiden får inte ligga i framtiden!");
                return false;
            }

            //Session must not end before start time
            if(end.isBefore(start)){
                errorAlert("Sluttiden får inte vara en tidpunkt före starttiden.");
                return false;
            }

            //Set end time of THIS session
            session.setEnd(end);

            //Change start of the succeeding session, if THIS is not last
            if (index < sessionList.size() - 1) {

                //Get index the succeeding session
                Session nextSession = sessionList.get(index + 1);

                try {

                    //Set start of succeeding session
                    nextSession.setStart(end);

                } catch (IllegalArgumentException e) {
                    errorAlert("Passet får inte sluta innan nästa pass!");
                    return false;
                }
            }

            //Set end of THIS session
            try {
                session.setEnd(end);
            }catch(IllegalArgumentException e){
                errorAlert("Sluttiden kan inte vara en tidpunkt före starttiden");
                return false;
            }
        }

        return true;
    }


    private boolean inTheFuture(LocalTime time){

        return time.isAfter(LocalTime.now());

    }

    //Enter key listener
    private void setGlobalEventHandler(Node root){

        root.addEventHandler(KeyEvent.KEY_PRESSED, ev -> {
            if(ev.getCode() == KeyCode.ENTER){
                if(!saveButton.isDisabled()) {
                    saveButton.fire();
                }
            }
        });

    }


    private void errorAlert(String message){

        //Init alert
        Alert errorMessage = new Alert(Alert.AlertType.ERROR);

        //Set values
        errorMessage.setTitle("Fel");
        errorMessage.setHeaderText("Felaktigt värde!");
        errorMessage.setContentText(message);

        //Show error
        errorMessage.showAndWait();

    }

}
