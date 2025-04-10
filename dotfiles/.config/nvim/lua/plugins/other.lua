return {
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    opts = {
      mappings = {
        {
          context = "test",
          pattern = function(path)
            local match = vim.fn.matchlist(path, '\\v^(.*)/src/(.{-}_test)@!(.{-}).clj(.?)')
            if #match > 0 then
              return match
            end
          end,
          target = "%2/test/%4_test.clj%5"
        },
        {
          context = "implementation",
          pattern = "(.*)/test/(.*)_test.clj(.?)$",
          target = "%1/src/%2.clj%3",
        },
      },
    },
  },
}
