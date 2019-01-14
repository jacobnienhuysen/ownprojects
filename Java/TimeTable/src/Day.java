
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Day{

    private ArrayList<Session> sessionList;
    private LocalDateTime date;

    public Day(){
        sessionList = new ArrayList<>();
        date = LocalDateTime.now();
    }

    public LocalDateTime getDate() {
        return date;
    }

    public ArrayList<Session> getSessionList() {
        return sessionList;
    }

    public void addSession(Session newSession){
        sessionList.add(newSession);
    }

    public Duration getTotalDuration(){

        Duration totalDuration = Duration.ZERO;

        if(!sessionList.isEmpty()) {
            for (Session s : sessionList) {
               totalDuration = totalDuration.plus(s.getCompleteDuration());
            }
        }

        return totalDuration;
    }

    public String toString(){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY-MM-dd");
        String temp = date.format(formatter);

        return temp;
    }
}
