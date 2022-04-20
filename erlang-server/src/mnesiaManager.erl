%%%-------------------------------------------------------------------
%%% @author Stefano
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. apr 2022 16:55
%%%-------------------------------------------------------------------
-module(mnesiaManager).
-author("Stefano").

%% API
-export([init/0, login/4, register/4, all_user/0, readTest/1, insert_new_message/3,
  all_messages/0, get_user_related_messages/1, retrieve_nodename/1, retrieve_pid/1,
  is_user_present/1]).

-include_lib("stdlib/include/qlc.hrl").
-include("headers/records.hrl").

%%%===================================================================
%%% API
%%%===================================================================
init() ->
  mnesia:create_schema([node()]),
  mnesia:start(),
  case mnesia:wait_for_tables([unisup_messages, unisup_users], 5000) == ok of
    true ->
      ok;
    false ->
      mnesia:create_table(users,
        [{attributes, record_info(fields, users)},
          {disc_copies, [node()]}
        ]),
	  mnesia:create_table(auctions,
        [{attributes, record_info(fields, auctions)},
          {disc_copies, [node()]}
        ]),
      mnesia:create_table(goods,
        [{attributes, record_info(fields, goods)},
          {disc_copies, [node()]}
        ]),		
      mnesia:create_table(offers,
        [{attributes, record_info(fields, offers)},
          {type, bag},
          {disc_copies, [node()]}
        ])
  end.


%%%===================================================================
%%% USER OPERATIONS
%%%===================================================================

add_user(Username, Password, Credit, NodeName, Pid) ->
  Fun = fun() ->
    mnesia:write(#users{username = Username,
      password = Password,
	  credit = Credit,
      nodeName = NodeName,
      pid = Pid
    })
        end,
  mnesia:activity(transaction, Fun).

update_user(Username, NodeName, Pid) ->
  F = fun() ->
    [User] = mnesia:read(users, Username),
    mnesia:write(User#users{nodeName = NodeName, pid = Pid})
      end,
  mnesia:activity(transaction, F).
  
update_credit(Username, Credit) ->
  F = fun() ->
    [User] = mnesia:read(users, Username),
    mnesia:write(User#users{credit = Credit})
      end,
  mnesia:activity(transaction, F).

login(Username, Password, NodeName, Pid) ->
  F = fun() ->
    case mnesia:read({users, Username}) =:= [] of
      false -> % User present
        %% GET PASSWORD
        [{users, Username, Pass, _, _}] = mnesia:read({users, Username}),

        %% CHECK IF THE PASSWORD IS CORRECT
        case Password =:= Pass of
          %% If the password is equal to the one inserted then I update the data in Mnesia
          %% and I will return true. Otherwise, I will return false
          true ->
            update_user(Username, NodeName, Pid),
            true;
          false -> false
        end;
      true ->
        false
    end
      end,
  mnesia:activity(transaction, F).

is_user_present(Username) ->
  F = fun() ->
    case mnesia:read({users, Username}) =:= [] of
      true ->
        false;
      false ->
        true
    end
      end,
  mnesia:activity(transaction, F).

register(Username, Password, NodeName, Pid) ->
  F = fun() ->
    case mnesia:read({users, Username}) =:= [] of
      true -> % User not present
        add_user(Username, Password, NodeName, Pid),
        true;
      false ->
        false
    end
      end,
  mnesia:activity(transaction, F).

readTest(Username) ->
  F = fun() ->
    mnesia:read({users, Username})
      end,
  mnesia:activity(transaction, F).

all_user() ->
  F = fun() ->
    Q = qlc:q([{E#users.username, E#users.password, E#users.nodeName, E#users.pid} || E <- mnesia:table(users)]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

retrieve_nodename(Username) ->
  F = fun() ->
    [{users, _, _, NodeName, _}] = mnesia:read({users, Username}),
    NodeName
      end,
  mnesia:activity(transaction, F).

retrieve_pid(Username) ->
  F = fun() ->
    [{users, _, _, _, Pid}] = mnesia:read({users, Username}),
    Pid
      end,
  mnesia:activity(transaction, F).

  
%%%===================================================================
%%% AUCTION OPERATIONS
%%%===================================================================
  
  add_auction(Id, GoodName, Winner, Timestamp, Amount, Status) ->
  Fun = fun() ->
    mnesia:write(#auctions{idAuction = id,
      goodName = GoodName,
      status = Status
    })
        end,
  mnesia:activity(transaction, Fun).

update_auction(Id, Winner, Amount, Status) ->
  F = fun() ->
    [Auction] = mnesia:read(auctions, Id),
    mnesia:write(Auction#auctions{winner = Winner, amount = Amount, status = Status})
      end,
  mnesia:activity(transaction, F).

is_auction_present(Id) ->
  F = fun() ->
    case mnesia:read({auctions, Id}) =:= [] of
      true ->
        false;
      false ->
        true
    end
      end,
  mnesia:activity(transaction, F).

readTest(Id) ->
  F = fun() ->
    mnesia:read({auctions, Id})
      end,
  mnesia:activity(transaction, F).
  
  
%%%===================================================================
%%% GOOD OPERATIONS
%%%===================================================================
  
   add_good(Id, Name, User, Value) ->
  Fun = fun() ->
    mnesia:write(#goods{idGood = Id,
	  name = Name,
	  user = User,
	  value = Value
    })
        end,
  mnesia:activity(transaction, Fun).

update_good(Id, User, Value) ->
  F = fun() ->
    [Good] = mnesia:read(goods, Id),
    mnesia:write(Good#goods{user = User, value = Value})
      end,
  mnesia:activity(transaction, F).

is_good_present(Id) ->
  F = fun() ->
    case mnesia:read({goods, Id}) =:= [] of
      true ->
        false;
      false ->
        true
    end
      end,
  mnesia:activity(transaction, F).


readTest(Id) ->
  F = fun() ->
    mnesia:read({goods, Id})
      end,
  mnesia:activity(transaction, F).
  
  
  
%%%===================================================================
%%% MESSAGE OPERATIONS
%%%===================================================================

insert_new_message(Sender, Receiver, Value) ->
  Fun = fun() ->
    %% CHECK IF THE SENDER AND THE RECEIVER DO EXIST
    case mnesia:read({users, Sender}) =:= []  of
      true ->
        false;
      false ->
        case mnesia:read({users, Receiver}) =:= [] of
          true ->
            false;
          false ->
            add_message(Sender, Receiver, Value)
        end
    end
        end,
  mnesia:activity(transaction, Fun).

add_message(Sender, Receiver, Value) ->
  Fun = fun() ->
    Timestamp = time_format:format_utc_timestamp(),
    mnesia:write(#offers{
      %sender = {Sender, Timestamp},
      sender = Sender,
      receiver = Receiver,
      value = Value,
      timestamp = Timestamp
    }),
    Timestamp
        end,
  mnesia:activity(transaction, Fun).

all_messages() ->
  F = fun() ->
    Q = qlc:q([{E#offers.sender, E#offers.receiver, E#offers.value, E#offers.timestamp} || E <- mnesia:table(offers)]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

message_sent(Username) ->
  F = fun() ->
    %Q = qlc:q([{Username, E#unisup_messages.receiver, E#unisup_messages.text, E#unisup_messages.timestamp} || E <- mnesia:table(unisup_messages), hd(tuple_to_list(E#unisup_messages.sender)) == Username]),
    Q = qlc:q([{Username, E#offers.receiver, E#offers.value, E#offers.timestamp} || E <- mnesia:table(offers), E#offers.sender == Username]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

get_message_sent(Username) ->
  {_, Messages} = message_sent(Username),
  Messages.

message_received(Username) ->
  F = fun() ->
    %Q = qlc:q([{hd(tuple_to_list(E#unisup_messages.sender)), Username, E#unisup_messages.text, E#unisup_messages.timestamp} || E <- mnesia:table(unisup_messages), E#unisup_messages.receiver == Username]),
    Q = qlc:q([{E#offers.sender, Username, E#offers.value, E#offers.timestamp} || E <- mnesia:table(offers), E#offers.receiver == Username]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

get_message_received(Username) ->
  {_, Messages} = message_received(Username),
  Messages.


%% FORMAT:
%%      [{"edo","pippo","Test1","3 Jan 2021 13:32:40.857139"}, ....]
get_user_related_messages(Username) ->
  get_message_sent(Username) ++ get_message_received(Username).
