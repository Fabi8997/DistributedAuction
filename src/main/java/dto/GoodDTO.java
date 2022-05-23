package dto;

import com.ericsson.otp.erlang.OtpErlangTuple;

public class GoodDTO {
    int goodId;
    String name;
    String description;
    String user;

    public GoodDTO(String name, String description, String user) {
        this.name = name;
        this.description = description;
        this.user = user;
    }

    public GoodDTO(int goodId, String name, String description, String user) {
        this.goodId = goodId;
        this.name = name;
        this.description = description;
        this.user = user;
    }

    public GoodDTO(OtpErlangTuple good) {
        this.goodId = Integer.parseInt(good.elementAt(1).toString());
        this.name = good.elementAt(2).toString();
        this.description = good.elementAt(3).toString();
        this.user = good.elementAt(4).toString();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public int getGoodId() {
        return goodId;
    }

    @Override
    public String toString() {
        return "GoodDTO{" +
                "goodId=" + goodId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", user=" + user +
                '}';
    }
}

