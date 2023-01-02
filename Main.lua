
local hideCount = 0

local BLACKLIST = {
    "boost"
}

local SELL_PATTERNS = {
    "kauf",
    "wts",
    "biete[tn]",
    "vip",
    "rabatt",
    "sale",
    "booking",
    "boost",
    "wow gold",
    "nur gold",
    "nur für gold",
    "buchung",
    "[1-5][0-9][0-9]? ?k"
}

local SELL_TARGETS = {
    "mythic",
    "m\+",
    "nathria",
    "[kc]urve",
    "torgh?ast",
    "level ?up",
}

local function filter_blacklist(text, blacklist)
    for _, pattern in ipairs(blacklist) do
        if text:lower():find(pattern:lower()) then
            return true
        end
    end
    return false
end

local function filter_blacklist_pair(text, blacklist_1, blacklist_2)
    return  filter_blacklist(text, blacklist_1) and
            filter_blacklist(text, blacklist_2)
end

local function chat_filter(self, event, msg, author, ...)
    if filter_blacklist(msg, BLACKLIST) or
        filter_blacklist_pair(msg, SELL_PATTERNS, SELL_TARGETS) then
        hideCount = hideCount + 1
        if hideCount % 1000 == 0 then
            print("ChatFilter: Hidden " .. hideCount .. " messages")
        end
        return true
    end
    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", chat_filter)