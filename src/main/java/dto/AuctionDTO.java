package dto;

public class AuctionDTO {

    String idAuction;
    String idGood;
    String user;
    String startPrice;
    String datetime;
    String duration;
    String finalPrice;

    public AuctionDTO(String idAuction, String idGood, String user, String startPrice, String datetime, String duration, String finalPrice) {
        this.idAuction = idAuction;
        this.idGood = idGood;
        this.user = user;
        this.startPrice = startPrice;
        this.datetime = datetime;
        this.duration = duration;
        this.finalPrice = finalPrice;
    }

    public AuctionDTO(String idAuction, String idGood, String user, String startPrice, String datetime, String duration) {
        this.idAuction = idAuction;
        this.idGood = idGood;
        this.user = user;
        this.startPrice = startPrice;
        this.datetime = datetime;
        this.duration = duration;
    }

    public AuctionDTO(String idGood, String user, String startPrice, String datetime, String duration) {
        this.idGood = idGood;
        this.user = user;
        this.startPrice = startPrice;
        this.datetime = datetime;
        this.duration = duration;
    }

    public String getIdAuction() {
        return idAuction;
    }

    public void setIdAuction(String idAuction) {
        this.idAuction = idAuction;
    }

    public String getIdGood() {
        return idGood;
    }

    public void setIdGood(String idGood) {
        this.idGood = idGood;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getStartPrice() {
        return startPrice;
    }

    public void setStartPrice(String startPrice) {
        this.startPrice = startPrice;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(String finalPrice) {
        this.finalPrice = finalPrice;
    }

    @Override
    public String toString() {
        return "AuctionDTO{" +
                "idAuction='" + idAuction + '\'' +
                ", idGood='" + idGood + '\'' +
                ", user='" + user + '\'' +
                ", startPrice='" + startPrice + '\'' +
                ", datetime='" + datetime + '\'' +
                ", duration='" + duration + '\'' +
                ", finalPrice='" + finalPrice + '\'' +
                '}';
    }
}
