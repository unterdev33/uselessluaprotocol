local socket = require("socket")
local ulp = require("ulp")

local client = assert(socket.connect("127.0.0.1", 5000))

print("Connected to server.")

while true do
    io.write("> ")

    local text = io.read()

    if text == "exit" then
        break
    end

    local packet = ulp.encode("CHAT", "Client", text)

    client:send(packet .. "\n")

    local response = client:receive()

    if response then
        local packet = ulp.decode(response)

        if packet.type == "SERVER" then
            print("Server:", packet.data[1])
        end
    end
end

client:close()