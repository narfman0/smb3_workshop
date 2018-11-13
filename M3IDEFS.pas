unit M3IDEFS;

interface
uses NESSMB3;

const
  THREE_BYTE = 0;
  FOUR_BYTE  = 1;

  // definitions for orientation of objects
  HORIZ     = 0;	// horizontally, to the right
  VERTICAL  = 1;	// vertically, downward
  DIAG_DL   = 2;	// diagonally, down and to the left
  PIPEBOX   = 3;	// special orientation for desert pipe boxes because they're so big
  DIAG_DR   = 4;	// diagonally, down and to the right
  DIAG_UR   = 5;	// diagonally, up and to the right
  GD_EXT    = 6;	// same as HORIZONTAL but also extends vertically to the ground
  HORIZ_2   = 7;	// same as HORIZ but for objects that display a bit differently
  DIAG_CRNR = 8;	// weird way of displaying diagonal objects that appear nowhere else
  DUMMY     = 9;	// dummy value for single-value objects ($00 to $0F)
  CENTER    = 10;	// some sprites such as spinning platforms that are centered
  PYRAMID   = 11;   // pyramid shape, extends to level bottom ground
  PYRAMID2  = 12;   // pyramid shape, extends to ground or next object
  EXT_SKY   = 13;	// object extends to sky (blue poles)
  ENDING    = 14;

type

  ObjectDef = record
	obj_domain,	// object type of object
	min_value,	// minimum possible value of object
	max_value,	// maximum possible value of object
	bmp_width,	// width of multi-bitmap objects
	bmp_height:	// height of multi-bitmap objects
	byte;
	// which 16x16 bitmaps this object uses - if it uses just
	// one it will be one in size
	obj_design: array{[0..69]} of Cardinal;
	obj_design_2: array{[0..69]} of Byte;
	rom_obj_design: array of Cardinal;
	obj_design_length: byte;
	orientation,// how this object extends with byte value increase
	ends,		// how many "ends" this object has when it extends
				// (0 = every block is the same, 1=has one end on the top or
				// left, 2=has one end on the bottom or right, 3=has two ends
	obj_flag: Byte;			// 1 = 4 bytes, 0= 3 bytes
	obj_descript: String[80];	// [80] used to display the name of the object
  end;
{
  SMB3_ENEMY = record
    enemy,
    horiz,
    vert:  Byte;
  end;

  SMB3_OBJECT = record
    byte1, byte2, byte3, byte4: SmallInt;
  end;
}

implementation

end.
