package dto;

public class AuctionDTO {

    String idAuction;
    String idGood;
    String user;
    String startPrice;
    String datetime;
    String finalPrice;

    public AuctionDTO(String idAuction, String idGood, String user, String startPrice, String datetime, String finalPrice) {
        this.idAuction = idAuction;
        this.idGood = idGood;
        this.user = user;
        this.startPrice = startPrice;
        this.datetime = datetime;
        this.finalPrice = finalPrice;
    }

    public AuctionDTO(String idAuction, String idGood, String user, String startPrice, String datetime) {
        this.idAuction = idAuction;
        this.idGood = idGood;
        this.user = user;
        this.startPrice = startPrice;
        this.datetime = datetime;
    }

    public AuctionDTO(String idGood, String user, String startPrice, String datetime) {
        this.idGood = idGood;
        this.user = user;
        this.startPrice = startPrice;
        this.datetime = datetime;
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
                ", finalPrice='" + finalPrice + '\'' +
                '}';
    }
}
