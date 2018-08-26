import XMonad
import XMonad.Config.Mate

import XMonad.Layout.Spacing 
import XMonad.Layout.Grid
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle


myTerminal = "mate-terminal"
myModMask = mod4Mask
myFocusedBorderColor = "#338188"
myBorderWidth = 3
myLayout = desktopLayoutModifiers $ tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio -- default tiling algorithm partitions the screen into two panes
    nmaster = 1	-- The default number of windows in the master pane
    ratio   = 5/8 -- Default proportion of screen occupied by master pane
    delta   = 3/100 -- Percent of screen to increment by when resizing panes

--layoutHook = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $
             --layoutHook def
--myLayout = (spacing 10 $ avoidStruts (tall ||| GridRatio (4/3) ||| Full )) ||| smartBorders Full
                   -- where tall = Tall 1 (3/100) (1/2)
-- myLayout = avoidStruts $ spacing 4 $ Tall 1 (3/100) (1/2)


main = do
	xmonad $ mateConfig
		{ terminal = myTerminal
		, modMask = mod4Mask
	 	, borderWidth = myBorderWidth
	 	, focusedBorderColor = myFocusedBorderColor
	 	--, layoutHook = smartBorders $ layoutHook
		, layoutHook = myLayout
		}
