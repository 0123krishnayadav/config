-- Extra plugins on top of kickstart

local function gh(repo) return 'https://github.com/' .. repo end

-- Pin the current function/class signature to the top of the window while scrolling
vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-context' }
require('treesitter-context').setup { max_lines = 3 }
vim.keymap.set('n', '<leader>tc', '<Cmd>TSContext toggle<CR>', { desc = '[T]oggle treesitter [C]ontext' })

-- Cargo.toml: latest crate versions, features and docs inline
vim.pack.add { gh 'saecki/crates.nvim' }
require('crates').setup {
  lsp = { enabled = true, actions = true, completion = true, hover = true },
}
