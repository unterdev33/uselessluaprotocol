local ULP = {}

ULP.VERSION = "2607.1"
ULP.SEP = "|"

function ULP.encode(packetType, ...)
    local packet = {ULP.VERSION, packetType}

    for _, value in ipairs({...}) do
        table.insert(packet, tostring(value))
    end

    return table.concat(packet, ULP.SEP)
end

function ULP.decode(packet)
    local parts = {}

    for value in string.gmatch(packet, "[^" .. ULP.SEP .. "]+") do
        table.insert(parts, value)
    end

    return {
        version = parts[1],
        type = parts[2],
        data = {table.unpack(parts, 3)}
    }
end

return ULP