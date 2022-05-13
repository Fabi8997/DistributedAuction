package communication;

import com.ericsson.otp.erlang.*;
import dto.AuctionDTO;

import java.io.IOException;

public class OtpErlangCommunication {

    private static final String cookie = "abcde";
    private static final String remoteNodeId ="auctions_server@localhost";
    private static final String registeredServer = "auction_server";
    private static final String registeredMasterServer ="auctions_manager";

    public static void main(String[] args) {
    }

    private static void get_status(String auction,String user){
        OtpConnection conn = null;
        try {
            conn = getConnection(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "get_status", new OtpErlangObject[]{new OtpErlangAtom(auction)});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
    }

    private static AuctionDTO get_info(String auction,String user){
        OtpConnection conn = null;
        try {
            conn = getConnection(user);
            if(conn != null) {
                conn.sendRPC(registeredServer, "get_info", new OtpErlangObject[]{new OtpErlangAtom(auction)});
                OtpErlangObject reply = conn.receiveRPC();
                if (reply instanceof OtpErlangTuple) {
                    return new AuctionDTO((OtpErlangTuple) reply);
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

    private static void make_offer(String auction,String user,int offer){
        OtpConnection conn = null;
        try {
            conn = getConnection(user);
            if(conn != null){
                OtpErlangTuple msg = new OtpErlangTuple(new OtpErlangObject[]{new OtpErlangString(user), new OtpErlangInt(offer)});
                conn.sendRPC(registeredServer,"make_offer",new OtpErlangObject[]{new OtpErlangAtom(auction),msg});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn!= null){
                conn.close();
            }
            e.printStackTrace();
        }
    }

    public static void start_auction(AuctionDTO newAuction){
        OtpConnection conn = null;
        try {
            conn = getConnection(newAuction.getSeller());
            if(conn != null) {
                OtpErlangTuple state = new OtpErlangTuple(new OtpErlangObject[]{
                        new OtpErlangString(newAuction.getIdGood()),
                        new OtpErlangInt(Integer.parseInt(newAuction.getDuration())),
                        new OtpErlangDouble(Double.parseDouble(newAuction.getInitialPrice())),
                        new OtpErlangString(newAuction.getSeller())
                });
                OtpErlangTuple msg = new OtpErlangTuple(new OtpErlangObject[]{
                        new OtpErlangAtom(newAuction.getIdAuction()),
                        state
                });
                conn.sendRPC(registeredMasterServer, "start_new_auction", new OtpErlangObject[]{msg});
                OtpErlangObject reply = conn.receiveRPC();
                System.out.println("Received " + reply);
                conn.close();
            }
        } catch (IOException | OtpErlangExit | OtpAuthException e) {
            if(conn != null){
                conn.close();
            }
            e.printStackTrace();
        }
    }

    public static OtpConnection getConnection(String username) throws IOException {

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
