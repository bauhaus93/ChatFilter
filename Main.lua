
local hideCount = 0

local BLACKLIST = {
    "[bB][oO][oO][sS][tT]",
    --"[gG]arona"
}

local SELL_PATTERNS = {
    "[vV]erkauf",
    "[kK]auf",
    "[wW][tT][sS]",
    "[bB]iete[tn]",
    "[vV][iI][pP]",
    "[rR]abatt",
    "[sS]ale",
    "[bB]ooking",
}

local SELL_TARGETS = {
    "[mM]ythic",
    "[mM]\+",
    "[nN]'?[zZ]oth",
    "[nN]y'?alotha",
}

local function filter_blacklist(text, blacklist)
    for _, pattern in ipairs(blacklist) do
        if text:find(pattern) then
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
    local hide = false
    if filter_blacklist(msg, BLACKLIST) or
        filter_blacklist_pair(msg, SELL_PATTERNS, SELL_TARGETS) then
        hideCount = hideCount + 1
        hide = true
    end
    if hide == true and hideCount % 100 == 0 then
        print("ChatFilter: Hidden " .. hideCount .. " messages")
    end
    return hide
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", chat_filter)