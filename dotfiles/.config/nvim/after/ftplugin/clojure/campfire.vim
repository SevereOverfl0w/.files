" Campfire-specific bindings. Self-skips if vim-campfire not loaded.
" Plugin's own ftplugin (lua/campfire activate) handles core wiring:
" cp/cpp eval, K hover, [D/]D source, formatexpr, :CampfireEval,
" :CampfireRunTests, :CampfireDoc, etc.
"
" Add user-level customisations here as the need surfaces.
if !exists(':CampfireConnect')
  finish
endif
