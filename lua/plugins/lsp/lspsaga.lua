local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
    return
end

saga.setup({
    ui = {
        border = "rounded",
        devicon = true,
    },
    symbol_in_winbar = {
        enable = true,
        separator = "  ",
        hide_keyword = true,
    },
    lightbulb = {
        enable = false,
    },
})
