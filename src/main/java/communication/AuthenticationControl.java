package communication;
import dto.UserDTO;

public interface AuthenticationControl {
    boolean login(UserDTO u);

    boolean register(UserDTO u);

    boolean logout(UserDTO u);
}
