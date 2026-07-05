# UselessLuaProtocol (ULP)

a uselessly simple text-based data transfer protocol written in lua

```text
Client                         Server

1.0|CHAT|Player|Hello!  ----->

                        <-----  1.0|SERVER|Welcome!
```

## requirements

* Lua 5.3+
* LuaSocket

### install LuaSocket

```bash
luarocks install luasocket
```

## installation

clone the repository:

```bash
git clone https://github.com/unterdev33/uselessluaprotocol
cd uselessluaprotocol
```

## project structure

```text
.
├── client.lua
├── server.lua
├── ulp.lua
└── README.md
```

## running

start the server:

```bash
lua server.lua
```

open another terminal and start the client:

```bash
lua client.lua
```

the client will connect to:

```text
127.0.0.1:5000
```

## packet format

all packets are plain text.

```text
VERSION|TYPE|DATA1|DATA2|...
```

examples:

```text
1.0|PING
1.0|CHAT|Player|Hello!
1.0|LOGIN|Steve|password
1.0|SERVER|Welcome!
```

## usage

encode a packet:

```lua
local packet = ULP.encode("CHAT", "Player", "Hello!")
client:send(packet .. "\n")
```

decode a packet:

```lua
local packet = ULP.decode(received)

print(packet.version)
print(packet.type)

for _, value in ipairs(packet.data) do
    print(value)
end
```

## limitations

* no encryption
* no compression
* no checksums
* no binary packets
* no escaping (`|` is reserved as a separator)
* all values are transferred as strings
