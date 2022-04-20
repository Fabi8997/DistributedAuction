-record(goods, {idGood,
  name,
  user,
  value
}).

-record(auctions, {idAuction,
  goodName,
  winner,
  timestamp,
  amount,
  status
}).

-record(offers, {sender,
  receiver,
  value,
  timestamp,
  idAuction
}).

-record(users, {username,
  password,
  credit,
  nodeName,
  pid
}).