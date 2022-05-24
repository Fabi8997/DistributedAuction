package dto;

public class UserDTO {
    Integer userId;
    String username;
    String password;
    Integer credit;

    public UserDTO(Integer userId, String username, String password, Integer credit) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.credit = credit;
    }

    public UserDTO(Integer userId, String username) {
        this.userId = userId;
        this.username = username;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

