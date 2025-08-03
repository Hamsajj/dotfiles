return {
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        opts = {
            -- The panel is useless.
            panel = { enabled = false },
            suggestion = {
                auto_trigger = false,
                hide_during_completion = false,
                keymap = {
                    accept = '<M-.>',
                    accept_word = '<M-w>',
                    accept_line = '<M-l>',
                    next = '<M-c>',
                    prev = '<M-x>',
                    dismiss = '<C-/>',
                },
            },
            filetypes = {
                markdown = true,
                yaml = true,
            },
        },
    },
}
