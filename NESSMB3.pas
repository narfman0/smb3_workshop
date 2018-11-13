unit NESSMB3;

interface

const
  MAX_LEVEL_SECTIONS = 65;
  NUM_SMB3_LEVELS = 298;
  map_enemy_offset: Integer = $16070;

type

  MAPSCREEN_POINTER_LOCS = record
    num_ptrs,
    offset: Integer;
  end;

  OBJECTSET_POINTER_TYPES = record
    ptr_type: Integer;
    type_name: string;
    ptr_min,
    ptr_max: Integer;
  end;

  Mario3Level = record
    game_world,
    level_in_world: Byte;
    rom_level_offset,
    enemy_offset: LongInt;
    real_obj_set: Byte;
    name: String;
  end;


const

enemybank = 12;

map_sprite_names: array [1..17] of String = (
 'Nothing?', '"Help!"', 'Ship', 'Hammer Bros.',
 'Boomerang Bros.', 'Sledge Bros.', 'Fire Bros.',
 'Piranha Plant', 'Weird', 'N-card',
 'White Mushroom House', 'Coin Ship', 'World 8 Ship #1',
 'Battleship', 'Tank', 'World 8 Ship #2', 'Boat'
);

obj_sets: array [1..11] of String = (
 'Map Screen',
 'Plains Level',
 'Hilly/Underground Level',
 'Sky Level',
 'Dungeon',
 'Airship',
 'Cloudy Level',
 'Desert Level',
 'Water/Pipe Level',
 'Giant Level',
 'Ice Level'
);
							 {"Plains             ",  0
                             "Dungeon            ",   1
                             "Hilly              ",   2
                             "Sky                ",   3
                             "Water              ",   5
                             "Pipe               ",   7
                             "Desert             ",   8
                             "Ship               ",   9
                             "Giant              ",   10
                             "Ice                ",   11
                             "Cloudy             ",   12
                             "Underground        "    13}

OBJSET_MAP			= 0;
OBJSET_PLAINS		= 1;
OBJSET_HILLY		= 2;
OBJSET_UNDERGROUND	= 11;
OBJSET_SKY			= 3;
OBJSET_DUNGEON		= 4;
OBJSET_AIRSHIP		= 5;
OBJSET_CLOUDY		= 6;
OBJSET_DESERT		= 7;
OBJSET_WATERPIPE	= 8;
OBJSET_GIANT		= 9;
OBJSET_ICE			= 10;


mushroom_houses: array [0..26] of String = (
 'P-Wing Only', 'Warp Whistle Only',
 'P-Wing Only', 'Frog Suit Only',
 'Tanooki Suit Only', 'Hammer Suit Only',
 'Frog, Tanooki, Hammer Suit', 'Mushroom, Leaf, Flower',
 'Leaf, Flower, Frog Suit', 'Leaf, Flower, Tanooki Suit',
 'Anchor Only',
 'Warp Whistle, P-Wing, Frog Suit', 'Frog Suit, P-Wing, Tanooki Suit',
 'Frog, Tanooki, Hammer Suit',
 'Warp Whistle, P-Wing, Frog Suit', 'Frog Suit, P-Wing, Tanooki Suit',
 'Frog, Tanooki, Hammer Suit',
 'Warp Whistle, P-Wing, Frog Suit', 'Frog Suit, P-Wing, Tanooki Suit',
 'Frog, Tanooki, Hammer Suit',
 'Warp Whistle, P-Wing, Frog Suit', 'Frog Suit, P-Wing, Tanooki Suit',
 'Frog, Tanooki, Hammer Suit',
 'Warp Whistle, P-Wing, Frog Suit', 'Frog Suit, P-Wing, Tanooki Suit',
 'Frog, Tanooki, Hammer Suit',
 'Warp Whistle, P-Wing, Frog Suit'
);

pointer_tables: array [1..9] of MAPSCREEN_POINTER_LOCS = (
 (num_ptrs:21; offset:$19438),  // World 1 map pointers
 (num_ptrs:47; offset:$194BA),  // World 2 map pointers
 (num_ptrs:52; offset:$195D8),  // World 3 map pointers
 (num_ptrs:34; offset:$19714),  // World 4 map pointers
 (num_ptrs:42; offset:$197E4),  // World 5 map pointers
 (num_ptrs:57; offset:$198E4),  // World 6 map pointers
 (num_ptrs:46; offset:$19A3E),  // World 7 map pointers
 (num_ptrs:41; offset:$19B56),  // World 8 map pointers
 (num_ptrs:10; offset:$19C50)   // Warp Zone pointers (no enemy set / level pointers)
);

object_set_pointers: array [1..17] of OBJECTSET_POINTER_TYPES = (
 (ptr_type:$0000;  type_name:'Unknown'; ptr_min:$0000; ptr_max: $0000),
 (ptr_type:$4000;  type_name:'Plains'; ptr_min:$1E512; ptr_max: $2000F),
 (ptr_type:$10000; type_name:'Dungeon'; ptr_min:$2A7F7; ptr_max: $2C00F),
 (ptr_type:$6000;  type_name:'Hilly'; ptr_min:$20587; ptr_max: $2200F),
 (ptr_type:$8000;  type_name:'Sky'; ptr_min:$227E0; ptr_max: $2400F),
 (ptr_type:$C000;  type_name:'Piranha Plant'; ptr_min:$26A6F; ptr_max: $2800F),
 (ptr_type:$A000;  type_name:'Water'; ptr_min:$24BA7; ptr_max: $2600F),
 (ptr_type:$0000;  type_name:'Mushroom House'; ptr_min:$0000; ptr_max: $0000),
 (ptr_type:$A000;  type_name:'Pipe'; ptr_min:$24BA7; ptr_max: $2600F),
 (ptr_type:$E000;  type_name:'Desert'; ptr_min:$28F3F; ptr_max: $2A00F),
 (ptr_type:$14000; type_name:'Ship'; ptr_min:$2EC07; ptr_max: $3000F),
 (ptr_type:$C000;  type_name:'Giant'; ptr_min:$26A6F; ptr_max: $2800F),
 (ptr_type:$8000;  type_name:'Ice'; ptr_min:$227E0; ptr_max: $2400F),
 (ptr_type:$C000;  type_name:'Cloudy'; ptr_min:$26A6F; ptr_max: $2800F),
 (ptr_type:$0000;  type_name:'Underground'; ptr_min:$1A587; ptr_max: $1C00F),
 (ptr_type:$0000;  type_name:'Spade House'; ptr_min:$A010; ptr_max: $C00F),
 (ptr_type:$0000;  type_name:'Map Screen'; ptr_min:$18010; ptr_max: $1A00F)
);

object_ranges: array [1..11, 1..8, 1..16] of Byte = (
 //Object Set 1
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 2
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,4,4,4,  4,4,4,4,  4,4,4,4,  4,3,3,3),
  (3,3,3,3,  3,3,4,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 3
 ((3,4,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,4,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 4
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,4,4),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,4,4,  4,3,3,3,  3,3,3,3,  3,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 5
 ((3,3,4,4,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  4,3,3,4,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 6
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,4,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,4,4,3,  4,3,3,4,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 7
 ((3,3,3,3,  3,3,3,3,  3,3,3,4,  4,4,4,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 8
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,4,3,3,  3,3,3,3,  3,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 9
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,4,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,4,4,3,  4,3,3,4,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 10
 ((3,4,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,4,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3)),
 //Object Set 11
 ((3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,4,4,  4,4,4,4,  4,4,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,4,4,4,  4,4,4,4,  4,4,4,4,  4,3,3,3),
  (3,3,3,3,  3,3,4,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3),
  (3,3,3,3,  3,3,3,3,  3,3,3,3,  3,3,3,3))
);


implementation

end.
