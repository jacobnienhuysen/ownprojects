import javafx.animation.Animation;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.scene.control.Label;
import javafx.util.Duration;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class Clock extends Label{

    private DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm:ss");
    private LocalDateTime currentTime;

    public void initialize() {

        Timeline clock = new Timeline(new KeyFrame(Duration.ZERO, e -> {
            currentTime = LocalDateTime.now();

            Clock.this.setText(currentTime.format(timeFormat));
        }),
                new KeyFrame(Duration.seconds(1))
        );
        clock.setCycleCount(Animation.INDEFINITE);
        clock.play();
    }


}
