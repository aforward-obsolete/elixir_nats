# NATS - Elixir Client

A [Elixir](http://elixir-lang.org/) client for the [NATS messaging system](https://nats.io).

[![License MIT](https://img.shields.io/npm/l/express.svg)](http://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/aforward/elixir_nats.svg?branch=master)](https://travis-ci.org/aforward/elixir_nats)
[![Inline docs](http://inch-ci.org/github/aforward/elixir_nats.svg?branch=master&style=flat)](http://inch-ci.org/github/aforward/elixir_nats)

Here is a sample configuration to connect to your NATS server.

```elixir
# In your config/config.exs file
config :nats, Nats.Connection,
  url: "mynatsserver.com",
  port: 4222,
  verbose: true,
  pedantic: false,
  user: "aforward",
  password: "nicetry",
  tcp: [:binary, active: false],
```



To play around with the client, start your NATS server, for example (using docker)

```bash
docker run -it -p 4222:4222 -p 6222:6222 -p 8222:8222 --name=nats nats:0.6.6
```

The output should look similar to

```bash
[1] 2015/09/07 21:49:00.431970 [INF] Starting gnatsd version 0.6.6
[1] 2015/09/07 21:49:00.432082 [INF] Starting http monitor on port 8222
[1] 2015/09/07 21:49:00.432191 [INF] Listening for route connections on :6222
[1] 2015/09/07 21:49:00.432285 [INF] Listening for client connections on 0.0.0.0:4222
[1] 2015/09/07 21:49:00.432356 [INF] gnatsd is ready
```

Now start your iex from the elixir-nats directory

```elixir
iex -S mix
```

You should see your nats server properly connected (make sure to get the configs right above)

```bash
[info] Attempting to connect to NATS Server: 192.168.59.103:4222
[info] Connected.
```

Now you can send messages to the server

```elixir
Nats.send("PING\r\n")
```

I am still figuring out the protocol, so the only way to see that the connection was actually established
was to send an invalid message and watch the NATS server report the error

```elixir
Nats.send("GARBLE\r\n")
```

Which would report an error similar to

```
[1] 2015/09/07 21:51:45.962684 [ERR] 172.17.42.1:42032 - cid:1 - Error reading from client: Client Parser ERROR, state=0, i=0: proto='"GARBLE\r"...'
```

Next steps are to figure out protocol and wrap in meaningful helper functions.
