return {
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    opts = {
      mappings = {
        -- src/foo.cljc -> test/foo_test.cljc
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
        -- src/foo.cljc -> test/foo_test.clj
        {
          context = "test",
          pattern = function(path)
            local match = vim.fn.matchlist(path, '\\v^(.*)/src/(.{-}_test)@!(.{-}).cljc')
            if #match > 0 then
              return match
            end
          end,
          target = "%2/test/%4_test.clj"
        },
        -- test/foo_test.cljc -> src/foo.cljc
        {
          context = "implementation",
          pattern = "(.*)/test/(.*)_test.clj(.?)$",
          target = "%1/src/%2.clj%3",
        },
      },
    },
  },
}
