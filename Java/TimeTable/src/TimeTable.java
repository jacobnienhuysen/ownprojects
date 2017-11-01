import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCodeCombination;
import javafx.scene.input.KeyCombination;
import javafx.scene.input.MouseButton;
import javafx.scene.layout.*;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

import java.io.*;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Optional;

public class TimeTable extends Application {


    //Window components
    private Stage window;
    private Scene mainScene, dayScene;
    private BorderPane mainLayout;


    //GUI Components
    private Label dateLabel, durationLabel, sessionLabel, dayLabel;
    private ComboBox<String> sessionTypeList;
    private ComboBox<Day> chooseDayList;
    private Button newSessionBtn, viewSessionBtn, endDayBtn;
    private MenuBar topMenu;
    private Menu fileMenu, helpMenu;
    private MenuItem newDayFileItem, loadListFileItem, saveListFileItem, quitFileItem, helpHelpItem, aboutHelpItem;


    //TableView of "Session" from selected day
    private TableView<Session> sessionTable;


    //Current date and time
    private LocalDateTime currentDateTime;

    //DecimalFormat
    private DecimalFormat twoDForm = new DecimalFormat("#.##");


    //DAY VARIABLES
    //Current day, the Day object in which new sessions will be stored
    private Day currentDay;

    //Day object being shown in the tableview
    private Day selectedDay;

    //List of loaded days
    private ArrayList<Day> dayList;

    //Total duration of current day sessions:
    private double totalDuration;

    //Is "true" if a Day is active. "false" at start
    private boolean dayIsActive = false;

    //Is "true" if a Day list has not been saved
    private boolean dayListNotSaved = false;


    //SESSION VARIABLES
    //Session types, shown in combobox
    private String[] sessionTypes = {"Arbete", "Lunch", "Fika", "Annat"};

    //Active Session, "null" at start
    private Session activeSession = null;



    //MAIN METHOD
    public static void main(String[] args){
        launch(args);
    }


    //START METHOD TO CREATE WINDOW
    @Override
    public void start(Stage primaryStage) throws Exception {

        //INITIATE VARIABLES

        //Version number
        double versionNumber = 1.1;


        //Get date and time from current dat
        currentDateTime = LocalDateTime.now();

        //Create new Day object for current day
        currentDay = new Day();

        //Load list of previous days
        dayList = new ArrayList<>();

        //SET WINDOW
        window = primaryStage;
        window.setTitle("TimeTable " + versionNumber);


        //MAIN LAYOUT

        //Menubar layout
        //File menu
        fileMenu = new Menu("_Arkiv");

        newDayFileItem = new MenuItem("Ny dag");
        newDayFileItem.setAccelerator(new KeyCodeCombination(KeyCode.N, KeyCombination.CONTROL_DOWN));
        newDayFileItem.setDisable(true);

        loadListFileItem = new MenuItem("Ladda lista...");
        loadListFileItem.setAccelerator(new KeyCodeCombination(KeyCode.O, KeyCombination.CONTROL_DOWN));
        loadListFileItem.setOnAction(e -> loadDayList());

        saveListFileItem = new MenuItem("Spara lista...");
        saveListFileItem.setAccelerator(new KeyCodeCombination(KeyCode.S, KeyCombination.CONTROL_DOWN));
        saveListFileItem.setOnAction(e -> saveDayList());
        saveListFileItem.setDisable(true);

        quitFileItem = new MenuItem("Avsluta");
        quitFileItem.setAccelerator(new KeyCodeCombination(KeyCode.Q, KeyCombination.CONTROL_DOWN));
        quitFileItem.setOnAction(e -> quit());

        fileMenu.getItems().addAll(newDayFileItem, new SeparatorMenuItem(), loadListFileItem, saveListFileItem, new SeparatorMenuItem(), quitFileItem);

        /*
        //Help menu
        helpMenu = new Menu("_Hjälp");

        helpHelpItem = new MenuItem("Hjälp");
        aboutHelpItem = new MenuItem("Om");

        helpMenu.getItems().addAll(helpHelpItem, aboutHelpItem);
        */

        //Menubar
        topMenu = new MenuBar();
        topMenu.getMenus().addAll(fileMenu);



        //Center box with dateLabel and tableView of day, (listing sessions of selected day)
        dateLabel = new Label(getCurrentDate(currentDateTime));

        //TableView
        //Session start column
        TableColumn<Session, String> sessionStartColumn = new TableColumn("Start");
        sessionStartColumn.setMinWidth(100);
        sessionStartColumn.setId("sessionStartCol");
        sessionStartColumn.setCellValueFactory(new PropertyValueFactory<>("sessionStartTime"));

        //Session description column
        TableColumn<Session, String> sessionDescColumn = new TableColumn("Beskrivning");
        sessionDescColumn.setMinWidth(200);
        sessionDescColumn.setCellValueFactory(new PropertyValueFactory<>("description"));

        //Session duration column
        TableColumn<Session, String> sessionDurationColumn = new TableColumn("Längd");
        sessionDurationColumn.setMinWidth(75);
        sessionDurationColumn.setId("sessionDurationCol");
        sessionDurationColumn.setCellValueFactory(new PropertyValueFactory<>("duration"));

        sessionTable = new TableView<>();
        sessionTable.getColumns().addAll(sessionStartColumn, sessionDescColumn, sessionDurationColumn);
        sessionTable.setPlaceholder(new Label("Det finns inga pass att visa."));

        sessionTable.getSelectionModel().selectedItemProperty().addListener((obs, oldSelection, newSelection) -> {
            if(newSelection != null){
                viewSessionBtn.setDisable(false);
            }
            else{
                viewSessionBtn.setDisable(true);
            }
        });

        durationLabel = new Label("Total tid: " + totalDuration + " h");

        VBox tableBox = new VBox(10);
        tableBox.setPadding(new Insets(10,10,10,10));
        tableBox.getChildren().addAll(dateLabel, sessionTable, durationLabel);
        tableBox.setAlignment(Pos.CENTER);


        //Bottom box with controls

        //Left box with "Session" controls
        sessionLabel = new Label("Pass: ");

        sessionTypeList = new ComboBox<>();
        sessionTypeList.getItems().addAll(sessionTypes);
        sessionTypeList.setValue("Arbete");
        sessionTypeList.setEditable(true);
        sessionTypeList.setMinWidth(75);

        newSessionBtn = new Button("Nytt pass");
        newSessionBtn.setOnAction(e -> newSession(sessionTypeList.getSelectionModel().getSelectedItem()));

        viewSessionBtn = new Button("Detaljer");
        viewSessionBtn.setOnAction(e -> {
            viewSessionDetails(sessionTable.getSelectionModel().getSelectedItem());
        });
        viewSessionBtn.setDisable(true);

        HBox sessionBox = new HBox(10);
        sessionBox.getChildren().addAll(sessionLabel, sessionTypeList, newSessionBtn, viewSessionBtn);
        sessionBox.setAlignment(Pos.CENTER);


        //Right box with "Day" controls
        dayLabel = new Label("Dag: ");

        chooseDayList = new ComboBox<>();
        chooseDayList.setMinWidth(150);
        chooseDayList.setValue(currentDay);
        chooseDayList.setDisable(true);

        chooseDayList.setOnAction(e -> getSessionsFromDay(chooseDayList.getValue()));

        endDayBtn = new Button("Avsluta dag");
        endDayBtn.setOnAction(e -> endDay());
        endDayBtn.setDisable(true);


        HBox dayBox = new HBox(10);
        dayBox.getChildren().addAll(dayLabel, chooseDayList, endDayBtn);
        dayBox.setAlignment(Pos.CENTER);


        //Create bottomBox
        GridPane bottomBox = new GridPane();
        bottomBox.setId("bottomBox");
        bottomBox.add(sessionBox, 1,1);
        bottomBox.add(dayBox,1,2);
        bottomBox.setPadding(new Insets(10,10,10,10));
        bottomBox.setVgap(10);


        //Set Main layout
        mainLayout = new BorderPane();
        mainLayout.setTop(topMenu);
        mainLayout.setCenter(tableBox);
        mainLayout.setBottom(bottomBox);

        mainScene = new Scene(mainLayout);
        mainScene.getStylesheets().add("Styles.css");

        window.setOnCloseRequest(e -> {
            e.consume();
            quit();
        });

        window.setScene(mainScene);

        window.show();
        window.setMinWidth(500);
    }


    //Format timestamp and return date as "Thursday, 26 october 2017"
    private String getCurrentDate(LocalDateTime timeStamp){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMMM YYYY");
        String temp = timeStamp.format(formatter);

        return temp;
    }


    //Format timestamp and return time as "12:34:59"
    private String formatTime(LocalDateTime timeStamp){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String temp = timeStamp.format(formatter);

        return temp;
    }


    //Handle day selection.
    private void getSessionsFromDay(Day chosenDay){
        ObservableList<Session> sessionList = FXCollections.observableArrayList();

        //Set selected day
        selectedDay = chosenDay;


        //Get list of "Session" from selected Day and load to tableView
        sessionList.addAll(chosenDay.getSessionList());
        sessionTable.setItems(sessionList);

        //Set text of dateLabel to date of selected day.
        dateLabel.setText(getCurrentDate(selectedDay.getDate()));

        //Set text of durationLabel
        durationLabel.setText("Total tid: " + twoDForm.format(selectedDay.getTotalDuration()/3600) + " h");


        //If selected day is current day, enable buttons to Add session and end day. Otherwise, disable buttons
        if(selectedDay == currentDay){
            newSessionBtn.setDisable(false);
            endDayBtn.setDisable(!dayIsActive);
        }
        else{
            newSessionBtn.setDisable(true);
            endDayBtn.setDisable(true);
        }

    }


    //START NEW SESSION
    public void newSession(String sessionType){

        //Create new Session object
        Session newSession = new Session(sessionType);

        //If first session of day, set activeSession to newSession and dayIsActive to true
        if(activeSession == null){
            activeSession = newSession;
            dayIsActive = true;
            endDayBtn.setDisable(false);
        }

        //otherwise end active session, update duration time and set activeSession to newSession
        else{
            activeSession.setEnd(LocalDateTime.now());
            activeSession = newSession;
        }

        //add new session to sessionList of current day, then update tableView
        currentDay.addSession(newSession);
        getSessionsFromDay(currentDay);


        //Update text of durationLabel with total duration in hours
        durationLabel.setText("Total tid: " + twoDForm.format(selectedDay.getTotalDuration()/3600) + " h");

    }


    //VIEW SESSION DETAILS

    public void viewSessionDetails(Session session){

        SessionDialog.display(session);

    }


    //END DAY

    public void endDay(){

        if(confirmAlert("Avsluta dag?","Du kommer inte att kunna lägga till fler pass.\nVill du avsluta dagen?",true)){
            newSessionBtn.setDisable(true);
            endDayBtn.setDisable(true);
            sessionTypeList.setDisable(true);
            dayIsActive = false;
            dayListNotSaved = true;
            saveListFileItem.setDisable(false);

            activeSession.setEnd(LocalDateTime.now());
            dayList.add(currentDay);

        }
        else{
            return;
        }
    }


    //CLOSE WINDOW

    public void quit(){

        //If a day is still active
        if(dayIsActive){
            errorMessage("Du måste avsluta aktiv dag innan du kan stänga programmet!");
            return;
        }

        //If day is ended, but not saved
        else if(dayListNotSaved){
            if(confirmAlert("Avsluta program", "Du har inte sparat dina ändringar. Om du avslutar programmet nu kommer de att förloras.\nVill du avsluta programet ändå?", true)){
                System.exit(0);
            }
        }


        else if(confirmAlert("Avsluta program","Vill du verkligen avsluta?",true)){
            System.exit(0);
        }
        else{
            return;
        }

    }


    public void loadDayList() {

        if(dayListNotSaved){
            if(!confirmAlert("Ladda lista?","Du har inte sparat dina ändringar. Om du laddar en ny lista kommer de att förloras.\nVill du ladda ändå?", true)) {
                return;
            }
        }

        File file = configureFileChooser("Ladda dagar").showOpenDialog(window);

        if (file != null){

            //Empty daylist before loading
            dayList.clear();

            try {
                FileInputStream fins = new FileInputStream(file);
                ObjectInputStream ois = new ObjectInputStream(fins);
                ArrayList<Day> readList = (ArrayList<Day>) ois.readObject();
                dayList.addAll(readList);
                ois.close();

                chooseDayList.getItems().addAll(dayList);
                chooseDayList.setDisable(false);
                chooseDayList.setValue(dayList.get(0));

            } catch (Exception e) {
                errorMessage(e.toString());
            }

            infoMessage("Laddat!");

        }
    }

    public void saveDayList(){

        File file = configureFileChooser("Spara dagar").showSaveDialog(window);

        if(file != null){
            try {
                FileOutputStream fouts = new FileOutputStream(file.getAbsolutePath());
                ObjectOutputStream oos = new ObjectOutputStream(fouts);
                oos.writeObject(dayList);
                oos.close();
            }catch(Exception e) {
                errorMessage(e.toString());
            }

            dayListNotSaved = false;
            saveListFileItem.setDisable(true);

            infoMessage("Sparat!");

        }
    }


    //INFORMAITION MESSAGE

    public void infoMessage(String message){
        Alert infoAlert = new Alert(Alert.AlertType.INFORMATION);
        infoAlert.setTitle("Information");
        infoAlert.setHeaderText("Information");
        infoAlert.setContentText(message);
        infoAlert.showAndWait();
        infoAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
    }


    //ERROR MESSAGE

    public void errorMessage(String message){
        Alert errorAlert = new Alert(Alert.AlertType.ERROR);
        errorAlert.setTitle("Fel");
        errorAlert.setHeaderText("Fel");
        errorAlert.setContentText(message);
        errorAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
        errorAlert.showAndWait();
    }


    //CONFIRMATION ALERT

    public boolean confirmAlert(String header, String question, boolean yesOrNo){

        Alert confirmAlert = new Alert(Alert.AlertType.CONFIRMATION);
        confirmAlert.setTitle("Fråga");
        confirmAlert.setHeaderText(header);
        confirmAlert.setContentText(question);
        confirmAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);

        ButtonType yesBtn = new ButtonType("Ja");
        ButtonType noBtn = new ButtonType("Nej");

        //If Yes or No buttons are preferred
        if(yesOrNo){
            confirmAlert.getButtonTypes().setAll(yesBtn, noBtn);
        }

        Optional<ButtonType> result = confirmAlert.showAndWait();

        if(result.get() == yesBtn || result.get() == ButtonType.OK){
            return true;
        }
        else if(result.get() == noBtn){
            return false;
        }
        else{
            return false;
        }

    }

    //Configure file chooser
    private FileChooser configureFileChooser(String title){

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle(title);
        fileChooser.getExtensionFilters().add((new FileChooser.ExtensionFilter("Sparade dagar (*.ser)","*.ser")));
        fileChooser.setInitialDirectory(new File(System.getProperty("user.home")));
        return fileChooser;

    }



    ///TEST FUNCTIONS; REMOVE THESE

    public void populate(){

        Day day1 = new Day();
        day1.setDate(LocalDateTime.of(2017,10,26,9,0));

        Session pass1 = new Session("Arbete");
        pass1.setStart(LocalDateTime.of(2017,10,26,9,2));
        pass1.setEnd(LocalDateTime.of(2017,10,26,11,33));

        Session pass2 = new Session("Lunch");
        pass2.setStart(LocalDateTime.of(2017,10,26,11,33));
        pass2.setEnd(LocalDateTime.of(2017,10,26,12,4));

        Session pass3 = new Session("Arbete");
        pass3.setStart(LocalDateTime.of(2017,10,26,12,4));
        pass3.setEnd(LocalDateTime.of(2017,10,26,16,28));

        day1.addSession(pass1);
        day1.addSession(pass2);
        day1.addSession(pass3);

        dayList.add(day1);

        System.out.println("System running.");

    }


}
