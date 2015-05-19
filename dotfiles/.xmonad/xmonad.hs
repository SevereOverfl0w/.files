import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.WorkspaceNames
import XMonad.Prompt


main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ ewmh defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , logHook = dynamicLogWithPP =<< workspaceNamesPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , terminal = "termite"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((mod4Mask .|. shiftMask, xK_r      ), renameWorkspace defaultXPConfig)
        , ((mod4Mask .|. shiftMask, xK_Left  ), swapTo Prev)
        , ((mod4Mask .|. shiftMask, xK_Right ), swapTo Next)
          , ((0, xK_Print), spawn "scrot")
        ]

