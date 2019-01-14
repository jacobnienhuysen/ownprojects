import javafx.application.Application;
import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.util.Optional;

public class Encoder extends Application {

    //VERSION
    private final String VERSION = "1.3";

    //Window
    private Stage window;
    private GridPane layout;

    //GUI components
    private TextField originalText;
    private ListView<String> keyList;
    private TextArea resultText;
    private RadioButton cipherBtn, decipherBtn;
    private Button addKeyBtn, delKeyBtn, runBtn;

    //Algorithm
    private Coder coder;
    private boolean cipher;

    //Key list
    ObservableList<String> keys = FXCollections.observableArrayList("synthetic");



    @Override
    public void start(Stage stage) throws Exception{

        //Init coder
        coder = new Coder();

        //Init window
        window = stage;
        window.setTitle("Encoder " + VERSION);

        //Init layout
        layout = new GridPane();
        layout.setHgap(10);
        layout.setVgap(10);
        layout.setPadding(new Insets(10,10,10,10));


        //First row
        originalText = new TextField();
        VBox originalRow = new VBox(10);
        originalRow.getChildren().addAll(new Label("Original: "), originalText);

        layout.add(originalRow,0,0);

        //RadioButtons
        cipherBtn = new RadioButton("Cipher");
        cipherBtn.setSelected(true);
        decipherBtn = new RadioButton("Decipher");

        VBox cipherButtons = new VBox(10);
        cipherButtons.getChildren().addAll(cipherBtn, decipherBtn);
        cipherButtons.setAlignment(Pos.BOTTOM_LEFT);

        ToggleGroup toggleGroup = new ToggleGroup();
        toggleGroup.getToggles().addAll(cipherBtn, decipherBtn);

        layout.add(cipherButtons, 1,0);


        //Key list
        keyList = new ListView<>();
        keyList.setMaxHeight(150);
        keyList.setItems(keys);

        VBox keysRow = new VBox(10);
        keysRow.getChildren().addAll(new Label("Keys"), keyList);
        layout.add(keysRow, 0,1);


        //Key list buttons
        addKeyBtn = new Button("Add...");
        addKeyBtn.setOnAction(e -> addKey());

        delKeyBtn = new Button("Delete...");
        delKeyBtn.setOnAction(e -> deleteKey());

        VBox keyListButtons = new VBox(10);
        keyListButtons.getChildren().addAll(addKeyBtn, delKeyBtn);
        keyListButtons.setAlignment(Pos.BOTTOM_LEFT);
        layout.add(keyListButtons, 1,1);

        //Result area
        resultText = new TextArea();
        resultText.setEditable(false);
        ScrollPane resultArea = new ScrollPane(resultText);
        resultArea.setFitToWidth(true);

        VBox resultRow = new VBox(10);
        resultRow.getChildren().addAll(new Label("Result:"), resultArea);
        layout.add(resultRow, 0,2,2,1);


        //Buttons
        runBtn = new Button("Start");
        runBtn.setOnAction(e -> start());

        VBox buttonRow = new VBox(10);
        buttonRow.getChildren().addAll(runBtn);
        layout.add(buttonRow, 0,3,2,1);


        //Set scene
        Scene scene = new Scene(layout,500, 600);
        scene.getStylesheets().add("styles.css");

        //Close
        window.setOnCloseRequest(e -> {
            e.consume();
            quit();
        });

        window.setScene(scene);
        window.show();

    }


    private void addKey(){

        String key = keyPrompt();

        if(key != null && !key.isEmpty()){
            keyList.getItems().add(key);
        }

    }


    private void deleteKey(){

        ObservableList<String> selected = keyList.getSelectionModel().getSelectedItems();
        keyList.getItems().removeAll(selected);

    }


    private void start(){

        String original = originalText.getText().toLowerCase();

        if(cipherBtn.isSelected()){
            cipher = true;
        }
        else if(decipherBtn.isSelected()){
            cipher = false;
        }


        String[] tempKeyStrings = keys.toArray(new String[keys.size()]);

        String result = coder.runVigenere(cipher, original, tempKeyStrings);

        resultText.setText("");
        resultText.appendText(result);

    }


    //QUIT PROGRAM
    private void quit(){

        if(confirmAlert("Avsluta program","Vill du verkligen avsluta?")){
            System.exit(0);
        }
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
    private boolean confirmAlert(String header, String question){

        Alert confirmAlert = new Alert(Alert.AlertType.CONFIRMATION);
        confirmAlert.setTitle("Fråga");
        confirmAlert.setHeaderText(header);
        confirmAlert.setContentText(question);
        confirmAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);

        ButtonType yesBtn = new ButtonType("Ja");
        ButtonType noBtn = new ButtonType("Nej");

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


    //NEW KEY PROMPT
    private String keyPrompt(){

        Alert confirmAlert = new Alert(Alert.AlertType.CONFIRMATION);
        confirmAlert.setTitle("New key");
        confirmAlert.setHeaderText("Enter key string");

        HBox promptContent = new HBox(5);

        TextField keyField = new TextField();
        promptContent.getChildren().add(keyField);

        Platform.runLater(() -> keyField.requestFocus());

        promptContent.setAlignment(Pos.CENTER);
        confirmAlert.getDialogPane().setContent(promptContent);
        confirmAlert.getDialogPane().setMinHeight(Region.USE_PREF_SIZE);

        Optional<ButtonType> result = confirmAlert.showAndWait();

        if(result.get() == ButtonType.OK){
            return keyField.getText().trim();
        }
        else
            return null;
    }

    public static void main(String[] args){
        launch(args);
    }

}
