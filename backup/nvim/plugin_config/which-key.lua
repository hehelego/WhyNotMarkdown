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
local buffer_keymap = {
  name = 'buffer',

  t = 'filetype',
  f = 'find',
}
local editorui_keymap = {
  name = 'editor-ui',
  m = 'mouse',
  l = 'hl-line',
  c = 'hl-column',
  a = 'ln-absolute',
  r = 'ln-relative',
  t = 'transparent-bg',
  s = 'colors',
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
local yank_keymap = {
  name = 'clip-in',

  x = 'xclip clipboard',
  X = 'xclip primary',
}
local put_keymap = {
  name = 'clip-out',

  x = 'xclip clipboard',
  X = 'xclip primary',
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
local undotree_keymap = {
  name = 'undo-tree',

  u = 'toggle',
  o = 'focus',
  c = 'close',
}



local leader_keymap = {
  name = '<leader>',

  b = buffer_keymap,
  c = comment_keymap,
  e = editorui_keymap,
  f = fzf_keymap,
  g = git_keymap,
  p = put_keymap,
  q = quickfix_keymap,
  r = 'reload %',
  s = 'source %',
  t = 'coc-explorer',
  u = undotree_keymap,
  v = vista_keymap,
  y = yank_keymap,
}
leader_keymap['<space>'] = {
  name = 'MORE',
  h = {
    name = 'history',
    h = {'<CMD>History<CR>', 'file'},
    s = {'<CMD>History/<CR>', 'search'},
    c = {'<CMD>History:<CR>', 'command'},
  },
  f = {
    name = 'fzf-ui',
    c = {'<CMD>Commands<CR>', 'commands'},
    r = {'<CMD>FzfRegister<CR>', 'registers'},
    f = {'<CMD>FzfFunctions<CR>', 'functions'},
    m = {'<CMD>Marks<CR>', 'marks'},
    k = {'<CMD>Maps<CR>', 'keymaps'},
    h = {'<CMD>Helptags<CR>', 'help'},
    t = {'<CMD>FzfAsyncTask<CR>' ,'tasks'},
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
  t = {'<CMD>FzfAsyncTask<CR>' ,'asynctasks'},
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
  k = '^line',
  j = '^line',
  K = 'line$',
  J = 'line$',
  w = '^word',
  W = 'word$',
}
easymotion_keymap[','] = 'ANYWHERE-search'
easymotion_keymap['.'] = 'REPEAT-search'
easymotion_keymap['n'] = 'PREV-match'
easymotion_keymap['N'] = 'NEXT-match'
wk.register(easymotion_keymap, { prefix = ',' })
