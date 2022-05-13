package utils;

import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;

public class Utils {



    public static String datetimeFromNow(String durationInMillis){
        Instant instant = Instant.now().plus(Duration.ofMillis(Long.parseLong(String.valueOf(durationInMillis))));
        LocalDateTime localDateTime = LocalDateTime.ofInstant(instant, ZoneOffset.of("+02:00")).truncatedTo(ChronoUnit.SECONDS);
        System.out.println(localDateTime);
        return localDateTime.toString();
    }
}
