local map = require('util').map
map({'n', 'x'}, '<leader>r', function() require('ssr').open() end)
