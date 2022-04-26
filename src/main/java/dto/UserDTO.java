package dto;

public class UserDTO {
    String username;
    Integer credit;

    public UserDTO(String username, Integer credit) {
        this.username = username;
        this.credit = credit;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }
}

