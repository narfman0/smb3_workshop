SMB3 Workshop quick help

-----------------------------------------------------------------------------
 Controls in level editing mode
-----------------------------------------------------------------------------
 Left click ............... select/unselect 3 and 4 byte object
 Right click .............. select/unselect enemy
 Drag w/ left button ...... move object
 Drag w/ right button ..... move enemy
 Mouse wheel .............. scroll vertically
 Mouse wheel w/ Shift ..... scroll horizontally
 Mouse wheel w/ Ctrl ...... modify object/enemy type
 Tilt wheel left/right .... scroll horizontally
 Mouse nav. back/forward .. scroll view one page

 F4 ....................... select level
 Arrows ................... scroll view
 Numpad +/- ............... modify object type
 Delete ................... remove object/enemy


-----------------------------------------------------------------------------
 Controls in map editing mode
-----------------------------------------------------------------------------
 Left click ............... select pointer
 Double click ............. edit pointer

 Enter .................... edit level under pointer


-----------------------------------------------------------------------------
Object definition edit mode help
-----------------------------------------------------------------------------
 (Normal users may ignore this section.)
 In order to properly display level graphics using the actual
 graphics contained in the ROM itself, it is necessary to know
 which graphics tiles are used to draw different objects. This
 is what the Object definition editor is for.
 The area titled "ROM gfx tiles" displays the graphic tiles
 from the ROM and two additional rows of special tiles at the
 bottom of this area. These special tiles are used to:
  1) Control how the graphic tile under the special tile is drawn
  2) Show additional information about the tile/object that
     would not be visible with the original graphics. This kind
     of use includes showing which pipes can be used and which
     ones cannot, and is also used to display the bonuses that
     appear from question mark blocks, bricks, and other such
     tiles.
 The special tiles are drawn in front of the normal ROM graphic
 tile. Here is the listing of the special tiles. The ones that
 affect the drawing of the tile underneath are marked with a *.

 00 No special tile
*01 Fill tile with background color
 02 Nothing
 03 Warning
 04 Nothing
 05 Garbled
 06 Unknown
 07 Pointer
 08 Cross
 09 Yellow square
 10 Cross
 11 Up arrow
 12 Down arrow
 13 Left arrow
 14 Right arrow
 15 Flower
 16 Leaf
 17 Star
 18 Green star
 19 Movable/multi
 20 1-up
 21 Coin
 22 Vine
 23 P-switch
 24 Invisible coin
 25 Invisible 1-up
 26 Invisible
 27 Special
*28 Draw this tile using level bg color as transparency
*29 Do not draw this tile
 30 Level end (1)
 31 Level end (2)

Controls
--------
 Left click in "ROM Gfx tiles" area .... choose tile or special tile
 Left click   in "ROM" area ............ put tile/special tile
 Right click  in "ROM" area ............ pick tile
 Middle click in "ROM" area ............ pick special tile
 Mouse wheel ........................... browse objects
 Up, Down arrow keys ................... browse objects
 Left, Right arrow keys ................ browse ROM gfx tiles


-----------------------------------------------------------------------------
 Missing features
-----------------------------------------------------------------------------
 Planned to be implemented:

 * Decrease amount of glitches
 * Display enemies using ROM graphics (once I find out how)
 * Enemy graphics editing

 POSSIBLY to be implemented:

 * Improve display and editing of some objects (huge PITA to implement)
 * More extensive overworld editing (for now use Beneficii's map editor)
 * Better SMAS support (I want to support it eventually, but we'll see)

 Not planned:

 * ?


-----------------------------------------------------------------------------
 Known bugs or glitches
-----------------------------------------------------------------------------
 Confirmed:

 * Some objects, such as triangular ones, are rendered incorrectly.
 * Enemies and certain objects are not drawn using actual ROM graphics.

 Unconfirmed:

 * Crash on startup upon opening ROM
 * "Save ROM" does not always actually save?

-----------------------------------------------------------------------------
Last modified 2007-11-14, hukka (hukkax@gmail.com, http://hukka.furtopia.org)
