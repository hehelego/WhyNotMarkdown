-- see https://github.com/folke/which-key.nvim

local wk = require('which-key')

local whichkey_config = {}
wk.setup(whichkey_config)

local fzf_keymap = {
  name = 'fzf',
  -- find files
  f = 'files',
  h = 'history',
  r = 'ripgrep',
  a = 'silver-search',
  -- find buffers and windows
  b = 'buffers',
  w = 'windows',
}
local comment_keymap = {
  name = 'comment',

  c = 'on',
  i = 'invert',
  t = 'toggle',
  u = 'off',
  y = 'yank',
}
local quickfix_keymap = {
  name = 'quickfix',

  c = 'close',
  n = 'next',
  o = 'open',
  p = 'prev',
}
local xclip_keymap = {
  name = 'xclip',

  y = 'yank:\tvim->xclip',
  p = 'paste:\txclip->vim',
}
local path_keymap = {
  name = 'path',

  y = {
    name = 'yank',

    d = 'directory',
    f = 'file',
    p = 'fullpath',
  },
  p = 'cd ..',
  w = 'pwd',
  h = 'cd $HOME',
}
local undotree_keymap = {
  name = 'undo-tree',

  u = 'toggle',
  o = 'focus',
  c = 'close',
}
local git_keymap = {
  name = 'git',
  -- TODO: more git integration
  g = 'repo-summary',
  b = 'blame',
  l = 'log',
  d = 'diff',
  m = 'merge',
}
local vista_keymap = {
  name = 'vista',

  f = 'finder',
  F = 'finder-recursive',
  l = 'lsp',
  t = 'ctags',
  m = 'markdown-toc',

  o = 'focus',
  c = 'close',
  v = 'toggle',
}
local buffer_keymap = {
  name = 'buffer',

  t = 'cur-filetype',
  w = 'cur-write',
  e = 'cur-edit',
  f = 'cur-find',
}
local leader_keymap = {
  name = '<leader>',

  b = buffer_keymap,
  c = comment_keymap,
  r = 'reload-current-file',
  f = fzf_keymap,
  g = git_keymap,
  p = path_keymap,
  q = quickfix_keymap,
  t = 'file-tree',
  u = undotree_keymap,
  v = vista_keymap,
  x = xclip_keymap,
}
leader_keymap['<space>'] = {
  name = 'MORE',
  h = {
    name = 'history',
    h = {'<CMD>History<CR>', 'file'},
    s = {'<CMD>History/<CR>', 'search'},
    c = {'<CMD>History:<CR>', 'command'},
  },
  c = {
    name = 'colorscheme',
    t = {'<CMD>highlight Normal guibg=NONE ctermbg=NONE<CR>', 'transparent-background'},
    c = {'<CMD>Colors<CR>', 'select-color-theme'},
  },
  f = {
    name = 'fuzzy-find',
    c = {'<CMD>Commands<CR>', 'commands'},
    r = {'<CMD>FzfRegister<CR>', 'registers'},
    f = {'<CMD>FzfFunctions<CR>', 'functions'},
    m = {'<CMD>Marks<CR>', 'marks'},
    k = {'<CMD>Maps<CR>', 'keymaps'},
    h = {'<CMD>Helptags<CR>', 'help'},
  },
  e = {
    name = 'editor',
    c = {
      name = 'cursor',
      r = {'<CMD>set cursorline!<CR>', 'cursor-line'},
      c = {'<CMD>set cursorcolumn!<CR>', 'cursor-column'},
    },
    n = {
      name = 'line-number',
      a = {'<CMD>set number!<CR>' ,'absolute'},
      r = {'<CMD>set relativenumber!<CR>' ,'relative'},
    }
  },
  p = {
    name = 'plugins',

    c     = {'<CMD>PlugClean<CR>',  'vimplug-clean'},
    d     = {'<CMD>PlugDiff<CR>',  'vimplug-diff'},
    i     = {'<CMD>PlugInstall<CR>', 'vimplug-install'},
    s     = {'<CMD>PlugStatus<CR>', 'vimplug-status'},
    u     = {'<CMD>PlugUpdate<CR>', 'vimplug-update'},
    U     = {'<CMD>PlugUpgrade<CR>', 'vimplug-upgrade'},
    [';'] = {'<CMD>CocUpdate<CR>', 'coc-update'},
  },
  v = {
    name = 'document-preview',

    m = {
      name = 'markdown',
      m = {'<CMD>MarkdownPreview<CR>', 'start'},
      s = {'<CMD>MarkdownPreviewStop<CR>', 'shutdown'},
      t = {'<CMD>MarkdownPreviewStop<CR>', 'toggle'},
    },
    t = {
      name = 'latex',
      t = {'<CMD>LLPStartPreview<CR>', 'start'},
    },
  },
}
wk.register(leader_keymap, { prefix = '<leader>' })




local coc_keymap = {
  name = 'coc',

  a = 'apply-codeaction',
  f = 'format',
  q = 'quickfix-current',
  r = 'rename',
  l = {
    name = 'coc-list',

    c = 'commands',
    d = 'diagnostics',
    l = 'lists',
    t = 'async-tasks',
  },
}
wk.register(coc_keymap, { prefix = ';' })


local easymotion_keymap = {
  name = 'easymotion',

  f = '[char]',
  F = '[char,char]',
  k = '^line up',
  j = '^line down',
  K = 'line$ up',
  J = 'line$ down',
  w = '^word',
  W = 'word$',
}
wk.register(easymotion_keymap, { prefix = '\\' })
