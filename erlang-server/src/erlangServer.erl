%%%-------------------------------------------------------------------
%%% @author Stefano
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. apr 2022 16:50
%%%-------------------------------------------------------------------
-module(erlangServer).
-author("Stefano").
-behaviour(gen_server).

%% API
-export([]).

%% API
-export([start_server/0, call_server/1]).

%% gen_server callbacks
-export([handle_call/3, handle_cast/2]).

-define(SERVER, ?MODULE).

%% RECORD


%%%===================================================================
%%% API
%%%===================================================================

%% @doc Spawns the server and registers the local name (unique)
start_server() ->
  gen_server:start({local, da_gen_server}, ?MODULE, [], []).

%% @doc Standard API for every possible request to the server.
call_server(Content) ->
  gen_server:call(da_gen_server, Content).


%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc Handles messages to be sent: checks the receiver username, if it exists pushes the message into RabbitMQ
handle_call({message, {Msg_Id, Sender, Receiver, Text}}, _From, _)->
  case mnesiaFunctions:is_user_present(Receiver) of    %%maybe to do at consuming time from RabbitMQ
    true->
      _ReceiverPid = mnesiaFunctions:retrieve_pid(Receiver),
      _ReceiverNodeName = mnesiaFunctions:retrieve_nodename(Receiver),
      Timestamp = mnesiaFunctions:insert_new_message(Sender, Receiver, Text),
      rabbitmq:push({Msg_Id, Sender, Receiver, Text, Timestamp}),
      {reply, {ack, Msg_Id},  _ = '_'};
    false ->
      {reply, {nack, Msg_Id},  _ = '_'}
  end;

%% @doc Handles login requests: calls mnesiaFunctions:login for credential checking and physical addresses updating
handle_call({log, {Pid, Username, Password, ClientNodeName}}, _From, _)->
  case mnesiaFunctions:login(Username, Password, ClientNodeName, Pid) of
    true->
      case rabbitmq:request_consuming(Username, Pid) of
        consumer_created -> {reply, true, _ = '_'};
        _ -> {reply, false, _ = '_'}
      end;
    _->
      {reply, false, _ = '_'}
  end;

%% @doc Handles register requests: calls MnesiaFunctions:register for username checking and user storaging
handle_call({register, {Pid, Username, Password, ClientNodeName}}, _From, _)->
  {reply, mnesiaFunctions:register(Username, Password, ClientNodeName, Pid), _ = '_'};

handle_call({addAuction, {Id, GoodName, Winner, Timestamp, Amount, Status}}, _From, _)->
  {reply, mnesiaFunctions:add_auction(Id, GoodName, Winner, Timestamp, Amount, Status), _ = '_'};

handle_call({addGood, {Id, Name, User, Value}}, _From, _)->
  {reply, mnesiaFunctions:add_good(Id, Name, User, Value), _ = '_'};

handle_call({updateAuction, {Id, Winner, Amount, Status}}, _From, _)->
  case mnesiaFunctions:is_auction_present(Id) of
    true->
      {reply, mnesiaFunctions:update_auction(Id, Winner, Amount, Status), _ = '_'};
    _->
      {reply, false, _ = '_'}
    end;

handle_call({updateGood, {Id, User, Value}}, _From, _)->
  case mnesiaFunctions:is_good_present(Id) of
    true->
      {reply, mnesiaFunctions:update_good(Id, User, Value), _ = '_'};
    _->
      {reply, false, _ = '_'}
  end;


handle_call(_, _From, _) ->
  {reply, false, _ = '_'}.

handle_cast(_, _) ->
  {noreply, _ = '_'}.