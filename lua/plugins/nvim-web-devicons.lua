local setup, devicons = pcall(require, "nvim-web-devicons")
if not setup then
    return
end

devicons.setup({
    color_icons = true,
    default = true,
    strict = true,
    override_by_operating_system = {
        ["apple"] = {
            icon = "",
            color = "#A2AAAD",
            cterm_color = "248",
            name = "Apple",
        },
    };
})
