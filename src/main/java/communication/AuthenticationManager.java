package communication;

import com.ericsson.otp.erlang.*;
import dto.UserDTO;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;

public class AuthenticationManager extends CommunicationGateway implements AuthenticationControl{
    private static AuthenticationManager ref=null;
    public Future chatHistory=null;

    public static AuthenticationManager getInstance(){
        if(ref==null){
            ref= new AuthenticationManager();
        }
        return ref;
    }

    @Override
    public boolean login(UserDTO u) {
        prepareGateway(u.getUsername());
        Callable<Boolean> toRunLogin = new AuthenticationManager.LogTask(u);
        boolean result = (Boolean)addToExecutor(toRunLogin);
        return result;
    }



    @Override
    public boolean register(UserDTO u) {
        prepareGateway(u.getUsername());
        Callable<Boolean> toRun = new AuthenticationManager.RegisterTask(u);
        boolean result = (Boolean)addToExecutor(toRun);
        return result;
    }

    @Override
    public boolean logout(UserDTO u) {
        Callable<Boolean> toRun = new AuthenticationManager.LogoutTask(u);
        boolean result = (Boolean)addToExecutor(toRun);

        stopExecutor();
        return result;
    }

    private static class LogTask implements Callable<Boolean> {
        private UserDTO me;
        private final OtpMbox mbox;

        LogTask(UserDTO u){
            me=u;
            mbox = clientNode.createMbox();
        }

        @Override
        public Boolean call() throws Exception {
            OtpErlangAtom log = new OtpErlangAtom("log");
            OtpErlangPid pid = mbox.self();
            OtpErlangString username = new OtpErlangString(me.getUsername());
            OtpErlangString password = new OtpErlangString(me.getPassword());
            OtpErlangString myNodeName = new OtpErlangString(myName);
            OtpErlangTuple tuple = new OtpErlangTuple(new OtpErlangObject[]{receiveMessagesMailbox.self(), username, password, myNodeName});
            OtpErlangTuple reqMessage = new OtpErlangTuple(new OtpErlangObject[]{pid, log, tuple});
            mbox.send(serverRegisteredName, serverNodeName, reqMessage);

            OtpErlangAtom response = (OtpErlangAtom) mbox.receive();
            return response.booleanValue();
        }
    }

    private static class RegisterTask implements Callable<Boolean> {
        private UserDTO me;
        private final OtpMbox mbox;

        RegisterTask(UserDTO u){
            me=u;
            mbox = clientNode.createMbox();
        }

        @Override
        public Boolean call() throws Exception {
            OtpErlangPid pid = mbox.self();
            OtpErlangAtom register = new OtpErlangAtom("register");

            OtpErlangString username = new OtpErlangString(me.getUsername());
            OtpErlangString password = new OtpErlangString(me.getPassword());
            OtpErlangString myNodeName = new OtpErlangString(myName);
            OtpErlangTuple tuple = new OtpErlangTuple(new OtpErlangObject[]{receiveMessagesMailbox.self(), username, password, myNodeName});
            OtpErlangTuple reqMessage = new OtpErlangTuple(new OtpErlangObject[]{pid, register, tuple});
            mbox.send(serverRegisteredName, serverNodeName, reqMessage);

            OtpErlangAtom response = (OtpErlangAtom) mbox.receive();
            return response.booleanValue();
        }
    }

    private static class LogoutTask implements Callable<Boolean>{
        private UserDTO me;
        private final OtpMbox mbox;

        LogoutTask(UserDTO u){
            me=u;
            mbox = clientNode.createMbox();
        }

        @Override
        public Boolean call() throws Exception {
            OtpErlangPid pid = mbox.self();
            OtpErlangAtom logout = new OtpErlangAtom("logout");

            OtpErlangString username = new OtpErlangString(me.getUsername());
            OtpErlangTuple reqMessage = new OtpErlangTuple(new OtpErlangObject[]{pid, logout, username});
            mbox.send(serverRegisteredName, serverNodeName, reqMessage);

            OtpErlangAtom response = (OtpErlangAtom) mbox.receive();
            return response.booleanValue();
        }
    }

}