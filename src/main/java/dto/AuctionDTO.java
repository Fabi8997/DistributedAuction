package dto;

import com.ericsson.otp.erlang.OtpErlangTuple;

public class AuctionDTO {

    String idAuction;
    String idGood;
    String duration;
    String initialPrice;
    String currentPrice;
    String currentWinner;
    String seller;
    String status;

    public AuctionDTO(String idAuction, String idGood, String duration, String initialPrice, String seller){
        this.idAuction = idAuction;
        this.idGood = idGood;
        this.duration = duration;
        this.initialPrice = initialPrice;
        this.seller = seller;
    }

    public AuctionDTO(OtpErlangTuple auctionInfo) {
        idAuction = auctionInfo.elementAt(0).toString();
        idGood = auctionInfo.elementAt(1).toString();
        duration = auctionInfo.elementAt(2).toString();
        initialPrice = auctionInfo.elementAt(3).toString();
        currentPrice = auctionInfo.elementAt(4).toString();
        currentWinner = auctionInfo.elementAt(5).toString();
        seller = auctionInfo.elementAt(6).toString();
        status = auctionInfo.elementAt(7).toString();
    }

    public String getIdAuction() {
        return idAuction;
    }

    public String getIdGood() {
        return idGood;
    }

    public String getDuration() {
        return duration;
    }

    public String getInitialPrice() {
        return initialPrice;
    }

    public String getCurrentPrice() {
        return currentPrice;
    }

    public String getSeller() {
        return seller;
    }

    @Override
    public String toString() {
        return "AuctionDTO{" +
                "idAuction='" + idAuction + '\'' +
                ", idGood='" + idGood + '\'' +
                ", duration='" + duration + '\'' +
                ", initialPrice='" + initialPrice + '\'' +
                ", currentPrice='" + currentPrice + '\'' +
                ", currentWinner='" + currentWinner + '\'' +
                ", seller='" + seller + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
