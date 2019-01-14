import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class Session{

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

    public void setDescription(String newDescription){
        sessionDescription = newDescription;
    }


    public LocalDateTime getSessionStart() {
        return sessionStart;
    }

    public LocalDateTime getSessionEnd() {
        if(active)
            return LocalDateTime.now();
        else
            return sessionEnd;
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


    public String getDuration() {

        Duration d;

        if(active) {
            d = Duration.between(sessionStart, LocalDateTime.now());
        }
        else {
            d = Duration.between(sessionStart, sessionEnd);
        }

        return d.toHoursPart() + ":" + String.format("%02d", d.toMinutesPart());
    }


    public Duration getCompleteDuration(){
        Duration duration;

        if(active) {
            duration = Duration.between(sessionStart, LocalDateTime.now());
        }
        else {
            duration = Duration.between(sessionStart, sessionEnd);
        }

        return duration;

    }


    //REMOVE!
    public void setStart(LocalDateTime startTime){
        sessionStart=startTime;
    }
    //REMOVE ABOVE

    public void setStart(LocalTime startTime){
        LocalDateTime newSessionStart = LocalDateTime.of(sessionStart.getYear(), sessionStart.getMonthValue(),sessionStart.getDayOfMonth(), startTime.getHour(),startTime.getMinute(),0);

        if(!active && newSessionStart.isAfter(sessionEnd)){
            throw new IllegalArgumentException("Session start time can not be after end time.");
        }
        else{

            sessionStart = newSessionStart;

        }

    }

    public boolean isActive(){
        return active;
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

    public void setEnd(LocalTime endTime){
        if(!active) {
            LocalDateTime newSessionEnd = LocalDateTime.of(sessionEnd.getYear(), sessionEnd.getMonthValue(), sessionEnd.getDayOfMonth(), endTime.getHour(), endTime.getMinute(), 0);

            if(newSessionEnd.isAfter(sessionStart)){
                sessionEnd = newSessionEnd;
            }
            else{
                throw new IllegalArgumentException("Session end time can not be before start time.");
            }

        }
    }


    public String toString(){

        String temp = sessionDescription + " - " + getSessionStartTime();

        if (active){
            temp += "-nu, ";
        }
        else{
            temp += "-" + getSessionEndTime() + ", ";
        }

        if(active){
            temp += "(pågår)";
        }
        else {
            temp += "(" + getDuration() + ")";
        }

        return temp;
    }
}
