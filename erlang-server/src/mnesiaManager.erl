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
      mnesia:create_table(unisup_messages,
        [{attributes, record_info(fields, unisup_messages)},
          {type, bag},
          {disc_copies, [node()]}
        ])
  end.


%%%===================================================================
%%% USER OPERATIONS
%%%===================================================================

add_user(Username, Password, NodeName, Pid) ->
  Fun = fun() ->
    mnesia:write(#users{username = Username,
      password = Password,
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
%%% MESSAGE OPERATIONS
%%%===================================================================

insert_new_message(Sender, Receiver, Text) ->
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
            add_message(Sender, Receiver, Text)
        end
    end
        end,
  mnesia:activity(transaction, Fun).

add_message(Sender, Receiver, Text) ->
  Fun = fun() ->
    Timestamp = time_format:format_utc_timestamp(),
    mnesia:write(#offers{
      %sender = {Sender, Timestamp},
      sender = Sender,
      receiver = Receiver,
      text = Text,
      timestamp = Timestamp
    }),
    Timestamp
        end,
  mnesia:activity(transaction, Fun).

add_good(Sender, Receiver, Text) ->
  Fun = fun() ->
    Timestamp = time_format:format_utc_timestamp(),
    mnesia:write(#goods{
      %sender = {Sender, Timestamp},
      sender = Sender,
      receiver = Receiver,
      text = Text,
      timestamp = Timestamp
    }),
    Timestamp
        end,
  mnesia:activity(transaction, Fun).

add_auction(Sender, Receiver, Text) ->
  Fun = fun() ->
    Timestamp = time_format:format_utc_timestamp(),
    mnesia:write(#goods{
      %sender = {Sender, Timestamp},
      sender = Sender,
      receiver = Receiver,
      text = Text,
      timestamp = Timestamp
    }),
    Timestamp
        end,
  mnesia:activity(transaction, Fun).

all_messages() ->
  F = fun() ->
    Q = qlc:q([{E#offers.sender, E#offers.receiver, E#offers.text, E#offers.timestamp} || E <- mnesia:table(offers)]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

message_sent(Username) ->
  F = fun() ->
    %Q = qlc:q([{Username, E#unisup_messages.receiver, E#unisup_messages.text, E#unisup_messages.timestamp} || E <- mnesia:table(unisup_messages), hd(tuple_to_list(E#unisup_messages.sender)) == Username]),
    Q = qlc:q([{Username, E#offers.receiver, E#offers.text, E#offers.timestamp} || E <- mnesia:table(offers), E#offers.sender == Username]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

get_message_sent(Username) ->
  {_, Messages} = message_sent(Username),
  Messages.

message_received(Username) ->
  F = fun() ->
    %Q = qlc:q([{hd(tuple_to_list(E#unisup_messages.sender)), Username, E#unisup_messages.text, E#unisup_messages.timestamp} || E <- mnesia:table(unisup_messages), E#unisup_messages.receiver == Username]),
    Q = qlc:q([{E#offers.sender, Username, E#offers.text, E#offers.timestamp} || E <- mnesia:table(offers), E#offers.receiver == Username]),
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
