-- XMonad Config

---------------
-- IMPORTS ----
---------------
    -- Base
import XMonad
import System.Directory
import System.IO
import System.Exit
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.WindowGo
import XMonad.Actions.WithAll
import qualified XMonad.Actions.Search as S


    -- Data
import Data.Char
import Data.Maybe
import Data.Monoid
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.SetWMName

    -- Layout
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.GridVariants
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

    -- Layout modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger
import qualified XMonad.Layout.ToggleLayouts as T
import qualified XMonad.Layout.MultiToggle as MT

    -- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Unicode
import XMonad.Prompt.XMonad
-- import Control.Arrow

    -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)

----------------
-- Constants ---
----------------

    -- Preferences
myModMask :: KeyMask
myModMask = mod4Mask
myTerminal :: String
myTerminal = "kitty "
myBrowser :: String
myBrowser = "firefox "
myEditor :: String
myEditor = myTerminal ++ " -e nvim"
myHtop :: String
myHtop = myTerminal ++ " -e htop"
myGeminiBrowser :: String
myGeminiBrowser = myTerminal ++ " -e amfora"
myFont :: String
myFont = "xft:Mononoki Nerd Font:regular:size=9:antialias=true:hinting=true"

    -- Gaps and borders
myBorderWidth :: Dimension
myBorderWidth = 2
myNormalBorderColor :: String
myNormalBorderColor = "#292d3e"
myFocusedBorderColor :: String
myFocusedBorderColor = "#bbc5ff"
mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border 0 i 0 i) True (Border i 0 i 0) True

    -- Mouse preferences
myFocusFollowMouse :: Bool
myFocusFollowMouse = True
myClickJustFocuses :: Bool
myClickJustFocuses = False

    --
myStartupHook :: X()
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"

myLogHook :: X()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

myEventHook :: X()
myEventHook = mempty

    -- Layouts
tall        = renamed [Replace "tall"]
            $ limitWindows 12
            $ mySpacing 8
            $ Tall 1 (3/100) (1/2)
monocle     = renamed [Replace "monocle"]
            $ limitWindows 20 Full
floats      = renamed [Replace "floats"]
            $ limitWindows 20 simplestFloat

    -- Layout hook preferences
myLayoutHook = avoidStruts
             -- $ windowArrange
             $ T.toggleLayouts floats
             $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where myDefaultLayout = withBorder myBorderWidth tall ||| withBorder myBorderWidth monocle ||| withBorder myBorderWidth floats

    -- Workspaces
myWorkspaces        = [" dev ", " sys ", " www ", " cht ", " gms ", " xtr ", "7", "8", "9"]

    -- Manage hook
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
             [ title      =? "steam"           --> doShift ( myWorkspaces !! 4 )
             , className  =? "discord"         --> doShift ( myWorkspaces !! 3 )
             ,(className  =? "firefox"         <&&> resource =? "Dialog") --> doFloat
             , className  =? "confirm"         --> doFloat
             , className  =? "file_progress"   --> doFloat
             , className  =? "dialog"          --> doFloat
             , className  =? "download"        --> doFloat
             , className  =? "error"           --> doFloat
             , className  =? "notification"    --> doFloat
             , className  =? "toolbar"         --> doFloat
             , resource   =? "desktop_window" --> doIgnore
             , isFullscreen --> doFullFloat
             ]

    -- XMobar
myXmobar = def
        { ppCurrent         = xmobarColor "#98be65" "" . wrap "[" "]"
        , ppVisible         = xmobarColor "#98be65" ""
        , ppHidden          = xmobarColor "#82AAFF" "" . wrap "*" "*"
        , ppHiddenNoWindows = xmobarColor "#c792ea" ""
        , ppTitle           = xmobarColor "#b3afc2" "" . shorten 60
        , ppSep             = "<fc=#666666> <fn=2>|</fn> </fc>"
        , ppUrgent          = xmobarColor "#C45500" "" .wrap "!" "!"
        , ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
        }

    -- Key Binds
myKeys :: [(String, X())]
myKeys =
        -- XMonad
    [ ("M-C-r",   spawn "xmonad --restart")
    , ("M-C-S-r", spawn "xmonad --recompile")
    , ("M-C-x",   io exitSuccess)

        -- DMenu
    , ("M-S-<Return>", spawn "dmenu_run -fn 'LiberationSerif Regular-9'")
    , ("M-p c",        spawn "dcolors")
    , ("M-p q",        spawn "dmlogout")
    , ("M-p k",        spawn "dmkill")

        -- Programs
    , ("M-<Return>", spawn myTerminal)
    , ("M-b",        spawn myBrowser)
    , ("M-S-p",      spawn "pavucontrol")
    , ("M-t e",      spawn myEditor)
    , ("M-t h",      spawn (myTerminal ++ " -e htop"))
    , ("M-t c",      spawn (myTerminal ++ " -e cava"))
    , ("M-t a",      spawn myGeminiBrowser)

        -- Kill windows
    , ("M-C-q", killAll)
    , ("M-q",   kill1)

        -- Layouts
    , ("M-<Tab>",    sendMessage NextLayout)
    , ("M-f",        sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
    , ("M-S-h",      sendMessage Shrink)
    , ("M-S-l",      sendMessage Expand)
    , ("M-S-<Up>",   sendMessage (IncMasterN 1))
    , ("M-S-<Down>", sendMessage (IncMasterN (-1)))

        -- Windows
    , ("M-m",   windows W.focusMaster)
    , ("M-S-m", windows W.swapMaster)
    , ("M-j",   windows W.focusUp)
    , ("M-S-j", windows W.swapUp)
    , ("M-k",   windows W.focusDown)
    , ("M-S-k", windows W.swapDown)
    ]

--------------
---- Main ----
--------------

main :: IO()
main = do
    xmproc <- spawnPipe "xmobar" -- "xmobar -x 0 $HOME/.config/xmobar/xmobarrc"
    xmonad $ ewmh $ ewhmFullscreen def
        { manageHook = myManageHook <+> manageDocks
        , handleEventHook     = handleEventHook def <+> docksEventHook
        , startupHook         = myStartupHook
        , layoutHook          = myLayoutHook
        , workspaces          = myWorkspaces
        , modMask             = myModMask
        , terminal            = myTerminal
        , focusFollowsMouse   = myFocusFollowMouse
        , clickJustFocuses    = myClickJustFocuses
        , borderWidth         = myBorderWidth
        , normalBorderColor   = myNormalBorderColor
        , focusedBorderColor  = myFocusedBorderColor
        , logHook = myLogHook <+> dynamicLogWithPP myXmobar
            { ppOutput       = \x -> hPutStrLn xmproc x
            }
        } `additionalKeysP` myKeys
