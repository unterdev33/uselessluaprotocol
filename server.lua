local socket = require("socket")
local ULP = require("ulp")

local server = assert(socket.bind("*", 5000))

print("ULP Server started.")
print("Waiting for client...")

local client = server:accept()
print("Client connected.")

while true do
    local message, err = client:receive()

    if not message then
        print("Client disconnected.")
        break
    end

    local packet = ULP.decode(message)

    print("\n[" .. packet.type .. "]")

    for i, v in ipairs(packet.data) do
        print(v)
    end

    io.write("\nServer > ")
    local text = io.read()

    if text == "exit" then
        break
    end

    local response = ULP.encode("SERVER", text)
    client:send(response .. "\n")
end

client:close()
server:close()
