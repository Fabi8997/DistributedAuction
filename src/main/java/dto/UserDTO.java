package dto;

public class UserDTO {
    String username;
    String password;
    Integer credit;

    public UserDTO(String username, String password, Integer credit) {
        this.username = username;
        this.password = password;
        this.credit = credit;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }
}

