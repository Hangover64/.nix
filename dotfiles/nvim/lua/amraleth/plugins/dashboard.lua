return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        header = {
          '',
          '',
          ' /$$$$$$                                   /$$    /$$ /$$              ',
          '/$$__  $$                                 | $$   | $$|__/              ',
          '| $$  \\ $$ /$$$$$$/$$$$   /$$$$$$  /$$$$$$ | $$   | $$ /$$ /$$$$$$/$$$$ ',
          '| $$$$$$$$| $$_  $$_  $$ /$$__  $$|____  $$|  $$ / $$/| $$| $$_  $$_  $$',
          '| $$__  $$| $$ \\ $$ \\ $$| $$  \\__/ /$$$$$$$ \\  $$ $$/ | $$| $$ \\ $$ \\ $$',
          '| $$  | $$| $$ | $$ | $$| $$      /$$__  $$  \\  $$$/  | $$| $$ | $$ | $$',
          '| $$  | $$| $$ | $$ | $$| $$     |  $$$$$$$   \\  $/   | $$| $$ | $$ | $$',
          '|__/  |__/|__/ |__/ |__/|__/      \\_______/    \\_/    |__/|__/ |__/ |__/',
          '',
          '',
        },
        shortcut = {
          { desc = 'Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            desc = 'Files',
            group = '@property',
            action = 'Ex',
            key = 'f',
          },
          {
            desc = ' Config',
            group = '@property',
            action = 'edit ~/.config/nvim/',
            key = 'c',
          },
        },
        project = { enable = false },
        mru = { limit = 10 },
        footer = { ' ', 'Bin kein Nerd, doch hab \'ne Tec' },
      },
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
    })
  end,
}
