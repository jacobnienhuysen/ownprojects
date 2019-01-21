import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;

import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyCodeCombination;
import javafx.scene.input.KeyCombination;
import javafx.scene.layout.*;

import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Stage;

import java.io.*;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;


public class TimeTable extends Application {


    //Window components
    private Stage window;
    private Scene mainScene;
    private BorderPane mainLayout;


    //Version number
    private final String VERSION = "2.6.1";


    //GUI Components
    private Label dateLabel, durationLabel;
    private ComboBox<String> sessionTypeList;
    private Button newSessionBtn, endDayBtn;
    private MenuBar topMenu;
    private Menu fileMenu, helpMenu, testMenu;
    private MenuItem newDayFileItem, exportFileItem, quitFileItem, helpHelpItem, aboutHelpItem;


    //TableView of "Session" from selected day
    private TableView<Session> sessionTable;

    //Current date and time
    private LocalDateTime currentDateTime;

    //Clock label
    private Clock timeLabel;



    //DAY VARIABLES
    //Current day, the Day object in which new sessions will be stored
    private Day currentDay;

    //Is "true" if a Day is active. "false" at start
    private boolean dayIsActive = false;


    //FILE EXTENSIONS
    private ExtensionFilter txtFiles = new ExtensionFilter("Textfil (*.txt)","*.txt");


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

        //Get date and time from current date
        currentDateTime = LocalDateTime.now();

        //Create new Day object for current day
        currentDay = new Day();

        //SET WINDOW
        window = primaryStage;
        window.setTitle("TimeTable " + VERSION);
        window.getIcons().add(new Image(TimeTable.class.getResourceAsStream("clock-icon.png")));


        //MAIN LAYOUT

        //MENUBAR LAYOUT
        //File menu
        fileMenu = new Menu("_Arkiv");

        newDayFileItem = new MenuItem("Ny dag");
        newDayFileItem.setAccelerator(new KeyCodeCombination(KeyCode.N, KeyCombination.CONTROL_DOWN));
        newDayFileItem.setOnAction(e -> newDay());

        exportFileItem = new MenuItem("Exportera dag...");
        exportFileItem.setAccelerator(new KeyCodeCombination(KeyCode.E, KeyCombination.CONTROL_DOWN));
        exportFileItem.setOnAction(e -> exportDay());
        exportFileItem.setDisable(true);

        quitFileItem = new MenuItem("Avsluta");
        quitFileItem.setAccelerator(new KeyCodeCombination(KeyCode.Q, KeyCombination.CONTROL_DOWN));
        quitFileItem.setOnAction(e -> quit());

        fileMenu.getItems().addAll(newDayFileItem, exportFileItem, new SeparatorMenuItem(), quitFileItem);


        //Help menu
        helpMenu = new Menu("_Hjälp");

        helpHelpItem = new MenuItem("Hjälp");
        helpHelpItem.setAccelerator(new KeyCodeCombination(KeyCode.F1));
        helpHelpItem.setOnAction(e -> showHelpWindow());

        aboutHelpItem = new MenuItem("Om");
        aboutHelpItem.setOnAction(e -> showAboutWindow());

        helpMenu.getItems().addAll(helpHelpItem, aboutHelpItem);


        /* TEST MENU

        testMenu = new Menu("Test");
        MenuItem populera = new MenuItem("Testpass");
        populera.setAccelerator(new KeyCodeCombination(KeyCode.F12));
        populera.setOnAction(e -> populate());
        testMenu.getItems().addAll(populera);

        END TEST MENU */


        //Menubar
        topMenu = new MenuBar();
        topMenu.getMenus().addAll(fileMenu, helpMenu);

        /*
        topMenu.getMenus().add(testMenu);
        */

        //CENTER LAYOUT
        //Center box with dateLabel and tableView of day, (listing sessions of selected day)
        dateLabel = new Label(formatDate(currentDateTime));
        timeLabel = new Clock();


        //TableView
        //Session start column
        TableColumn<Session, String> sessionStartColumn = new TableColumn<>("Start");
        sessionStartColumn.setMinWidth(100);
        sessionStartColumn.setId("sessionStartCol");
        sessionStartColumn.setCellValueFactory(new PropertyValueFactory<>("sessionStartTime"));

        //Session description column
        TableColumn<Session, String> sessionDescColumn = new TableColumn<>("Beskrivning");
        sessionDescColumn.setMinWidth(275);
        sessionDescColumn.setCellValueFactory(new PropertyValueFactory<>("description"));

        //Session duration column
        TableColumn<Session, String> sessionDurationColumn = new TableColumn<>("Längd");
        sessionDurationColumn.setMinWidth(75);
        sessionDurationColumn.setId("sessionDurationCol");
        sessionDurationColumn.setCellValueFactory(new PropertyValueFactory<>("duration"));

        sessionTable = new TableView<>();
        sessionTable.getColumns().addAll(sessionStartColumn, sessionDescColumn, sessionDurationColumn);
        sessionTable.setPlaceholder(new Label("Det finns inga pass att visa."));


        //Double click to view session details
        sessionTable.setRowFactory(tv -> {

            TableRow<Session> row = new TableRow<>();

            row.setOnMouseClicked(e -> {

                if (e.getClickCount() == 2 && !row.isEmpty()) {
                    viewSessionDetails(row.getItem());
                }

            });
            return row;

        });

        durationLabel = new Label("Total tid: 00:00:00");

        VBox tableBox = new VBox(5);
        tableBox.setPadding(new Insets(10,10,0,10));
        tableBox.getChildren().addAll(dateLabel, timeLabel, sessionTable, durationLabel);
        tableBox.setAlignment(Pos.CENTER);


        //BOTTOM BOX WITH CONTROLS

        sessionTypeList = new ComboBox<>();
        sessionTypeList.getItems().addAll(sessionTypes);
        sessionTypeList.setValue("Arbete");
        sessionTypeList.setEditable(true);
        sessionTypeList.setMinWidth(75);
        sessionTypeList.setId("sessionTypeList");

        newSessionBtn = new Button("Nytt pass");
        newSessionBtn.setOnAction(e -> newSession(sessionTypeList.getSelectionModel().getSelectedItem()));
        newSessionBtn.setId("newSessionBtn");

        endDayBtn = new Button("Avsluta dag");
        endDayBtn.setOnAction(e -> endDay());
        endDayBtn.setDisable(true);
        endDayBtn.setId("endBtn");

        HBox bottomBox = new HBox(10);
        bottomBox.setId("bottomBox");
        bottomBox.getChildren().addAll(sessionTypeList, newSessionBtn, endDayBtn);
        bottomBox.setPadding(new Insets(10,10,15,10));


        //Set Main layout
        mainLayout = new BorderPane();
        mainLayout.setTop(topMenu);
        mainLayout.setCenter(tableBox);
        mainLayout.setBottom(bottomBox);
        bottomBox.setAlignment(Pos.CENTER);

        mainScene = new Scene(mainLayout);
        mainScene.getStylesheets().add("Styles.css");

        window.setOnCloseRequest(e -> {
            e.consume();
            quit();
        });


        //WINDOW PREFERENCES
        window.setScene(mainScene);
        window.show();
        window.setMinWidth(500);

        //START REAL TIME CLOCK
        timeLabel.initialize();
    }


    //START NEW DAY
    private void newDay(){

        //If day is active or session table contains sessions
        if(dayIsActive || !sessionTable.getItems().isEmpty()) {
            if (!confirmAlert("Starta ny dag?", "Alla pass som inte är sparade kommer att förloras.\nVill du fortsätta?", true)) {
                return;
            }
        }

        dayIsActive = false;

        exportFileItem.setDisable(true);

        sessionTypeList.setDisable(false);
        newSessionBtn.setDisable(false);
        endDayBtn.setDisable(true);

        currentDay = new Day();
        activeSession = null;
        loadSessions();

    }


    //START NEW SESSION
    private void newSession(String sessionType){

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
        loadSessions();


        //Update text of durationLabel with total duration in hours
        durationLabel.setText("Total tid: " + formatDuration(currentDay.getTotalDuration()));

    }


    //Load sessions to TableView
    private void loadSessions(){
        ObservableList<Session> sessionList = FXCollections.observableArrayList();

        //Get list of "Session" from Day object and load to tableView
        sessionList.addAll(currentDay.getSessionList());
        sessionTable.setItems(sessionList);

        //Set text of durationLabel
        durationLabel.setText("Total tid: " + formatDuration(currentDay.getTotalDuration()));

    }


    //VIEW SESSION DETAILS
    private void viewSessionDetails(Session session){
        new SessionDialog(session, currentDay.getSessionList());
        sessionTable.refresh();

        //Update text of durationLabel with total duration in hours
        durationLabel.setText("Total tid: " + formatDuration(currentDay.getTotalDuration()));
    }


    //END DAY
    private void endDay(){

        if(confirmAlert("Avsluta dag?","Du kommer inte att kunna lägga till fler pass.\nVill du avsluta dagen?",true)){

            newSessionBtn.setDisable(true);
            endDayBtn.setDisable(true);
            sessionTypeList.setDisable(true);
            exportFileItem.setDisable(false);

            dayIsActive = false;

            activeSession.setEnd(LocalDateTime.now());

            durationLabel.setText("Total tid: " + formatDuration(currentDay.getTotalDuration()));
            loadSessions();

            sessionTable.refresh();

        }

        //Ask if export

        if(confirmAlert("Exportera dag?", "Vill du exportera dagens pass?", true)){
            exportDay();
        }

    }


    //EXPORT DAY WITH SESSIONS TO *.TXT-FILE
    private void exportDay(){

        File file = configureFileChooser("Exportera dag", txtFiles).showSaveDialog(window);
        if(file != null){

            String dayStartTime = currentDay.getSessionList().get(0).getSessionStartTime();
            String dayEndTime = currentDay.getSessionList().get(currentDay.getSessionList().size()-1).getSessionEndTime();

            try{
                FileOutputStream fout = new FileOutputStream(file.getAbsolutePath());
                OutputStreamWriter osw = new OutputStreamWriter(fout);

                //Header with date, timestamp start and timestamp end
                osw.write("Datum: " + formatDate(currentDay.getDate()) + "\r\n");
                osw.write("Start: " + dayStartTime + "\r\n");
                osw.write("Slut: " + dayEndTime + "\r\n\r\n");

                //Print Session objects
                osw.write("Start\tBeskrivning\t\tLängd\r\n");
                osw.write("--------------------------------------\r\n");

                for(Session s : currentDay.getSessionList()){

                    String temp = s.getSessionStartTime() + "\t";

                    if(s.getDescription().length() < 8){
                        temp += s.getDescription() + "\t\t\t";
                    }
                    else if(s.getDescription().length() < 16){
                        temp += s.getDescription() + "\t\t";
                    }
                    else if(s.getDescription().length() <= 22){
                        temp += s.getDescription() + "\t";
                    }
                    else if(s.getDescription().length() > 22 ){
                        temp += s.getDescription().substring(0,20) + "...\t";
                    }
                    else{
                        temp += "\t\t\t";
                    }

                    if(s.isActive()){
                        temp += "pågår";
                    }
                    else {
                        temp += s.getDuration();
                    }

                    osw.write(temp + "\r\n");
                }

                //Footer with total duration and program name
                osw.write("--------------------------------------\r\n");
                osw.write("Total tid: " + formatDuration(currentDay.getTotalDuration()) + "\r\n\r\n");

                osw.write("Exporterad från TimeTable " + VERSION);

                osw.close();
                fout.close();

            }catch(Exception e){
                errorMessage(e.toString());
            }
        }
    }


    //QUIT PROGRAM
    private void quit(){
        //If a day is still active
        if(dayIsActive){
            errorMessage("Du måste avsluta aktiv dag innan du kan stänga programmet!");
        }

        else if(confirmAlert("Avsluta program","Vill du verkligen avsluta?",true)){
            System.exit(0);
        }
    }


    //HELP WINDOW
    private void showHelpWindow(){
        infoMessage("Dubbelklicka på ett pass i tabellen för att se detaljer eller göra ändringar.\nKlicka på 'Avsluta dag' för att stämpla ut. Därefter kan du exportera en texfil med en sammanfattning av dagen.");
    }


    //ABOUT WINDOW
    private void showAboutWindow(){
        infoMessage("TimeTable version " + VERSION +"\n2017");
    }


    //INFORMATION MESSAGE
    private void infoMessage(String message){
        Alert infoAlert = new Alert(Alert.AlertType.INFORMATION);
        infoAlert.setTitle("Information");
        infoAlert.setHeaderText("Information");
        infoAlert.setContentText(message);
        infoAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
        infoAlert.showAndWait();
    }


    //ERROR MESSAGE
    private void errorMessage(String message){
        Alert errorAlert = new Alert(Alert.AlertType.ERROR);
        errorAlert.setTitle("Fel");
        errorAlert.setHeaderText("Fel");
        errorAlert.setContentText(message);
        errorAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);
        errorAlert.showAndWait();
    }


    //CONFIRMATION ALERT
    private boolean confirmAlert(String header, String question, boolean yesOrNo){

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


    //CONFIGURE FILE CHOOSER
    private FileChooser configureFileChooser(String title, ExtensionFilter extensionFilter){

        int year = currentDay.getDate().getYear();
        String month = String.format("%02d", currentDay.getDate().getMonthValue());
        String day = String.format("%02d", currentDay.getDate().getDayOfMonth());

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle(title);
        fileChooser.getExtensionFilters().add(extensionFilter);
        fileChooser.setInitialDirectory(new File(System.getProperty("user.home")));
        fileChooser.setInitialFileName(year + "-" + month + "-" + day);
        return fileChooser;

    }


    //Format timestamp and return date as "Thursday, 26 october 2017"
    private String formatDate(LocalDateTime timeStamp){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMMM YYYY");

        return timeStamp.format(formatter);
    }


    //Format timestamp and return time as "12:34:59"
    private String formatTime(LocalDateTime timeStamp){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

        return timeStamp.format(formatter);
    }


    //Format duration in seconds and return as "01:23:45"
    private String formatDuration(Duration duration){

        int hours = duration.toHoursPart();
        int minutes = duration.toMinutesPart();
        int seconds = duration.toSecondsPart();

        return String.format("%02d", hours) + ":" + String.format("%02d", minutes) + ":" + String.format("%02d", seconds);

    }

}