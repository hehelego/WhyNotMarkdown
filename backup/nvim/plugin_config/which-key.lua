-- see https://github.com/folke/which-key.nvim

local wk = require('which-key')

local whichkey_config = {}
wk.setup(whichkey_config)

local fzf_keymap = {
  name = 'fzf',
  -- find files
  f = 'files',
  g = 'git-files',
  h = 'history',
  r = 'ripgrep',
  a = 'silver-search',
  -- find in buffers and windows
  b = 'buffers',
  w = 'windows',
}
local fzf_ex_keymap = {
  name = 'fzf-ex',

  c = 'commands',
  r = 'registers',
  m = 'marks',
  t = 'asynctasks',
  h = 'helps'
}
local buffer_keymap = {
  name = 'buffer',
  f = 'search-contents',
  r = 'reload-file',
  s = 'source-vimscript',
  t = 'select-filetype',
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
  p = 'pair-color',
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
  name = 'clip-take',

  x = 'xclip-clipboard',
  X = 'xclip-primary',
}
local put_keymap = {
  name = 'clip-put',

  x = 'xclip-clipboard',
  X = 'xclip-primary',
}
local git_keymap = {
  name = 'git',
  -- TODO: more git integration
  g = 'repo-summary',
  b = 'blame %',
  l = 'log %',
  L = 'log',
  d = 'diff %',
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
local asynctasks_keymap = {
  a = 'list',
  s = 'stop',
}
asynctasks_keymap['.'] = 'run-last'
local zoxide_keymap = {
  z = 'home',
  i = 'find-jump',
}

--
-- SECTION: leader keymap
--

local leader_keymap = {
  name = '<leader>',

  a = asynctasks_keymap,
  b = buffer_keymap,
  c = comment_keymap,
  e = editorui_keymap,
  f = fzf_keymap,
  F = fzf_ex_keymap,
  g = git_keymap,
  p = put_keymap,
  q = quickfix_keymap,
  t = 'coc-explorer',
  u = undotree_keymap,
  v = vista_keymap,
  y = yank_keymap,
  z = zoxide_keymap,
}
leader_keymap['<space>'] = {
  name = 'MORE',
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
      name = 'LaTeX',
      t = {'<CMD>LLPStartPreview<CR>', 'start'},
    },
  },
}
wk.register(leader_keymap, { prefix = '<leader>' })


--
-- SECTION: coc LSP keymap
--


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

--
-- SECTION: easymotion keymap
--

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
