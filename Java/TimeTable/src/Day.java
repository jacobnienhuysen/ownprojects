import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Day implements Serializable{

    private ArrayList<Session> sessionList;
    private LocalDateTime date;

    public Day(){
        sessionList = new ArrayList<>();
        date = LocalDateTime.now();
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime newDate){
        date = newDate;
    }

    public ArrayList<Session> getSessionList() {
        return sessionList;
    }

    public void addSession(Session newSession){
        sessionList.add(newSession);
    }

    public double getTotalDuration(){

        double totalDuration = 0;

        if(!sessionList.isEmpty()) {
            for (Session s : sessionList) {
                totalDuration += s.getDurationInSeconds();
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
