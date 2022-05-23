package database;

import com.ericsson.otp.erlang.*;
import dto.AuctionDTO;
import dto.GoodDTO;

import java.io.IOException;
import java.util.ArrayList;

public class DbManager {

    private static final String cookie = "abcde";
    private static final String remoteNodeId ="server@localhost";
    private static final String registeredServer ="mnesia_manager";

    public static void main(String[] args) {
        System.out.println(DbManager.getAuctionFromGood(1,"Provaj"));
    }

    //Tested --> OK!
    public static boolean login(String user, String pass){
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
    public static boolean register(String user, String pass, double credit){
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
    public static Double getCredit(String user){
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
        return 0.00;
    }

    //Tested --> OK!
    public static boolean addCredit(String user, double credit){
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


    public static boolean addGood(String name, String description, String user){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {

                conn.sendRPC(registeredServer, "add_good", new OtpErlangObject[]{new OtpErlangString(name), new OtpErlangString(description), new OtpErlangString(user)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();

                return reply.toString().equals("ok");
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

    public static GoodDTO getGood(int goodId, String user){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "get_good", new OtpErlangObject[]{new OtpErlangInt(goodId)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();
                if (reply instanceof OtpErlangTuple) {
                    return new GoodDTO((OtpErlangTuple) reply);
                }
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
        return null;
    }


    //Tested -> OK
    public static ArrayList<GoodDTO> getUserGoods(String user){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "get_user_goods", new OtpErlangObject[]{new OtpErlangString(user)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();
                if (reply instanceof OtpErlangList) {
                    return toGoodsArray((OtpErlangList) reply);
                }
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    //Tested -> OK
    public static boolean inAuction(String user, int GoodId){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {

                conn.sendRPC(registeredServer, "in_auction", new OtpErlangObject[]{ new OtpErlangInt(GoodId)});
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

    //Tested -> OK
    public static ArrayList<AuctionDTO> getAllAuctions(String user){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "all_auctions", new OtpErlangObject[]{new OtpErlangString(user)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();
                if (reply instanceof OtpErlangList) {
                    return toAuctionsArray((OtpErlangList) reply);
                }
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
        return new ArrayList<>();
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

    private static ArrayList<GoodDTO> toGoodsArray(OtpErlangList list){
        ArrayList<GoodDTO> goods = new ArrayList<>();

        for(int i = 0; i < list.arity(); i++){
            goods.add(new GoodDTO((OtpErlangTuple) list.elementAt(i)));
        }
        return goods;
    }

    private static ArrayList<AuctionDTO> toAuctionsArray(OtpErlangList list){
        ArrayList<AuctionDTO> auctions = new ArrayList<>();

        for(int i = 0; i < list.arity(); i++){
            auctions.add(new AuctionDTO((OtpErlangTuple) list.elementAt(i)));
        }
        return auctions;
    }

    public static Integer getAuctionFromGood(int GoodId, String user){
        OtpConnection conn = null;
        try {
            conn = getConnectionDB(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "get_auction_from_good", new OtpErlangObject[]{new OtpErlangInt(GoodId)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();
                return Integer.parseInt(reply.toString());
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
        return -1;
    }
}
