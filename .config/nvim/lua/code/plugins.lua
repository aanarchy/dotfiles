local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()

-- motions
use 'unblevable/quick-scope'
-- use 'svermeulen/vim-yoink'
use 'svermeulen/vim-cutlass'
use 'svermeulen/vim-subversive'
use 'tpope/vim-surround'
use 'asvetliakov/vim-easymotion'

end)
