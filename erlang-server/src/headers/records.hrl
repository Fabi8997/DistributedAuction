-record(goods, {sender,
  receiver,
  text,
  timestamp
}).

-record(auctions, {sender,
  receiver,
  text,
  timestamp
}).

-record(offers, {sender,
  receiver,
  text,
  timestamp
}).

-record(users, {username,
  password,
  credit,
  nodeName,
  pid
}).