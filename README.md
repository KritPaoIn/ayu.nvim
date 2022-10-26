
## Installation

```lua
require("packer").startup({
    use({ "KritPaoIn/ayu.nvim", opt = true })
})

vim.cmd([[packadd ayu.nvim]])
require("ayu").setup({
    style = "dark",
})
vim.cmd([[colorscheme ayu-nvim]])
```

## Configuration

```lua
require("ayu").setup({
    style = "dark", -- "dark" | "light"
    extend = {
        -- ExampleHighlight = { fg = "#FFFFFF", bg = "#000000" },
        -- ExampleFunctionHighlight = function() return { fg = "#FFFFFF", bg = "#000000" } end,
    },
})
```

### Inspiration

- [ayu-theme/ayu-vim](https://github.com/ayu-theme/ayu-vim)
