package database;

import com.ericsson.otp.erlang.*;

import java.io.IOException;

public class MnesiaManager {

    private static final String cookie = "abcde";
    private static final String remoteNodeId ="mnesia_manager@localhost";
    private static final String registeredServer ="mnesia_manager";

    public static void main(String[] args) {
    }

    //Tested --> OK!
    private static boolean login(String user, String pass){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {

                conn.sendRPC(registeredServer, "login", new OtpErlangObject[]{new OtpErlangString(user), new OtpErlangString(pass)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();

                return Boolean.parseBoolean(reply.toString());
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
            return false;
        }
        return false;
    }

    //Tested --> OK!
    private static boolean register(String user, String pass, double credit){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {

                conn.sendRPC(registeredServer, "register", new OtpErlangObject[]{new OtpErlangString(user), new OtpErlangString(pass), new OtpErlangDouble(credit)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();

                return Boolean.parseBoolean(reply.toString());
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
            return false;
        }
        return false;
    }

    //Tested --> OK!
    private static Double getCredit(String user){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "get_credit", new OtpErlangObject[]{new OtpErlangString(user)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();
                return Double.parseDouble(reply.toString());
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
        return null;
    }

    //Tested --> OK!
    private static boolean add_credit(String user, double credit){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {

                conn.sendRPC(registeredServer, "add_credit", new OtpErlangObject[]{new OtpErlangString(user), new OtpErlangDouble(credit)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();

                return Boolean.parseBoolean(reply.toString());
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static OtpConnection getConnectionDB(String username) throws IOException {

        String nodeId = username + "_client@localhost";
        OtpSelf self = new OtpSelf(nodeId,cookie);
        OtpPeer auctionServerNode = new OtpPeer(remoteNodeId);
        try {
            return self.connect(auctionServerNode);
        } catch (OtpAuthException | IOException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return null;
    }
}
