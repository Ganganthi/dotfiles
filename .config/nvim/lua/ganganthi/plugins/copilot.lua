return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<M-l>",
                    accept_word = "<M-m>",
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
        })
    end,
}
