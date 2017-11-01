import java.io.Serializable;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Session implements Serializable{

    private String sessionDescription;
    private LocalDateTime sessionStart;
    private LocalDateTime sessionEnd;
    private boolean active;

    public Session(String sessionDescription){
        this.sessionDescription = sessionDescription;
        this.sessionStart = LocalDateTime.now();
        this.sessionEnd = null;
        this.active = true;
    }


    public String getDescription() {
        return sessionDescription;
    }


    public LocalDateTime getSessionStart() {
        return sessionStart;
    }


    public String getSessionStartTime() {

        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        return sessionStart.format(timeFormatter);

    }


    public String getSessionEndTime() {

        if(active){
            return "";
        }
        else{
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            return sessionEnd.format(timeFormatter);
        }
    }


    public long getDurationInSeconds(){

        if(active) {
            return Duration.between(sessionStart, LocalDateTime.now()).toSeconds();
        }
        else {
            return Duration.between(sessionStart, sessionEnd).toSeconds();
        }
    }


    public String getDuration() {

        Duration d;

        if(active) {
            d = Duration.between(sessionStart, LocalDateTime.now());
        }
        else {
            d = Duration.between(sessionStart, sessionEnd);
        }

        return d.toHoursPart() + ":" + d.toMinutesPart();
    }

    public String getCompleteDuration(){
        Duration d;

        if(active) {
            d = Duration.between(sessionStart, LocalDateTime.now());
        }
        else {
            d = Duration.between(sessionStart, sessionEnd);
        }

        return d.toHoursPart() + ":" + d.toMinutesPart() + ":" + d.toSecondsPart();

    }


    //REMOVE!
    public void setStart(LocalDateTime startTime){
        sessionStart=startTime;
    }


    public void setEnd(LocalDateTime endTime){

        //If sessionEnd is set, then it must not be changed again.
        if(active) {
            sessionEnd = endTime;
            active = false;
        }
        else
            throw new IllegalArgumentException("Session has already ended");
    }


    public String toString(){
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("YYYY-mm-dd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

        String temp = "";

        if(active){
            temp = sessionStart.format(dateFormatter) + "\n";
            temp += sessionDescription + "\n";
            temp += sessionStart.format(timeFormatter) + " - nu";
        }
        else {
            temp = sessionStart.format(dateFormatter) + "\n";
            temp += sessionDescription + ", " + (getDurationInSeconds()/3600) + "h\n";
            temp += sessionStart.format(timeFormatter) + " - " + sessionEnd.format(timeFormatter) + "";
        }

        return temp;
    }
}
