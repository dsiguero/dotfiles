import XMonad
import XMonad.Config.Mate

import XMonad.Layout.Spacing 
import XMonad.Layout.Grid
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal = "termite"
myModMask = mod4Mask
myFocusedBorderColor = "#3F94A8"
myNormalBorderColor = "#E6E8EF"
myBorderWidth = 2
myLayout = desktopLayoutModifiers $ tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio -- default tiling algorithm partitions the screen into two panes
    nmaster = 1 -- The default number of windows in the master pane
    ratio   = 5/8 -- Default proportion of screen occupied by master pane
    delta   = 3/100 -- Percent of screen to increment by when resizing panes

--layoutHook = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $
             --layoutHook def
--myLayout = (spacing 10 $ avoidStruts (tall ||| GridRatio (4/3) ||| Full )) ||| smartBorders Full
                   -- where tall = Tall 1 (3/100) (1/2)
-- myLayout = avoidStruts $ spacing 4 $ Tall 1 (3/100) (1/2)


-- SHORTCUT CONFIG
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
        -- launch a terminal (Mod + Enter)
        ((modm,  xK_Return), spawn $ XMonad.terminal conf)

        -- Swap the focused window and the master window (Mod + Shift + Enter)
        , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

        -- launch rofi
        , ((modm,               xK_p     ), spawn "rofi -show run")

        -- close focused window
        , ((modm, xK_c     ), kill)

        -- launch thunar
        -- , ((modm .|. shiftMask, xK_f     ), spawn "thunar")

        -- launch gmrun
        -- , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

        -- launch zeal
        -- , ((modm,               xK_z     ), namedScratchpadAction myScratchpads "zeal")

        -- launch telegram
        -- , ((modm,               xK_F10   ), namedScratchpadAction myScratchpads "telegram")

        -- Grid Select
        -- , ((modm,               xK_g     ), goToSelected defaultGSConfig)

         -- Rotate through the available layout algorithms
        -- , ((modm,               xK_space ), sendMessage NextLayout)

        --  Reset the layouts on the current workspace to default
        -- , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

        -- Resize viewed windows to the correct size
        -- , ((modm,               xK_n     ), refresh)

        -- Move focus to the next window
        -- , ((modm,               xK_Tab   ), windows W.focusDown)

        -- Move focus to the next window
        -- , ((modm,               xK_j     ), windows W.focusDown)

        -- Move focus to the previous window
        -- , ((modm,               xK_k     ), windows W.focusUp  )

        -- Move focus to the master window
        --, ((modm,               xK_m     ), windows W.focusMaster  )
        -- , ((modm,               xK_m     ), withFocused minimizeWindow)
        -- , ((modm .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)

        -- Maximize selected window
        -- , ((modm,                xK_f     ), (sendMessage $ Toggle FULL))

        -- Swap the focused window with the next window
        -- , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

        -- Swap the focused window with the previous window
        -- , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

        -- Shrink the master area
        -- , ((modm,               xK_h     ), sendMessage Shrink)

        -- Expand the master area
        -- , ((modm,               xK_l     ), sendMessage Expand)

        -- Push window back into tiling
        -- , ((modm,               xK_t     ), withFocused $ windows . W.sink)

        -- Increment the number of windows in the master area
        -- , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

        -- Deincrement the number of windows in the master area
        -- , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

        -- Switch workspaces and screens
        -- , ((modm,               xK_Right),  moveTo Next (WSIs hiddenNotNSP))
        -- , ((modm,               xK_Left),   moveTo Prev (WSIs hiddenNotNSP))
        -- , ((modm .|. shiftMask, xK_Right),  shiftTo Next (WSIs hiddenNotNSP))
        -- , ((modm .|. shiftMask, xK_Left),   shiftTo Prev (WSIs hiddenNotNSP))
        -- , ((modm,               xK_Down),   nextScreen)
        -- , ((modm,               xK_Up),     prevScreen)
        -- , ((modm .|. shiftMask, xK_Down),   shiftNextScreen)
        -- , ((modm .|. shiftMask, xK_Up),     shiftPrevScreen)

        -- Toggle the status bar gap
        -- Use this binding with avoidStruts from Hooks.ManageDocks.
        -- See also the statusBar function from Hooks.DynamicLog.
        --
        -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

        -- Quit xmonad
        -- , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

        -- Restart xmonad
        -- , ((modm , xK_q), spawn "xmonad --recompile; xmonad --restart")

        -- Run xmessage with a summary of the default keybindings (useful for beginners)
        -- , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    -- ++
    -- -- mod-[1..9], Switch to workspace N
    -- -- mod-shift-[1..9], Move client to workspace N
    -- --
    -- [((m .|. modm, k), windows $ f i)
    --     | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    --     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    -- -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    -- --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

mergedKeys x  = myKeys x `M.union` keys def x

main = do
    xmonad $ mateConfig
        {
            terminal = myTerminal
            , modMask = mod4Mask
            , borderWidth = myBorderWidth
            , focusedBorderColor = myFocusedBorderColor
            , normalBorderColor = myNormalBorderColor
            --, layoutHook = smartBorders $ layoutHook
            -- key bindings
            , keys = mergedKeys
            , layoutHook = myLayout
        }
