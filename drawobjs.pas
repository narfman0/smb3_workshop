unit drawobjs;

interface

	procedure draw_3byteobjects(ii: Integer);
	procedure draw_4byteobjects(a: Integer);
	procedure draw_enemies;

implementation

uses main, sysutils, nessmb3, m3idefs, TSA;

var
	{o, o3, o4, }_object, x_position, y_position{, p_ctr}: Integer;
	{Trans, }ios: boolean;


procedure SetTrans(B: Boolean); overload;
begin
	if B then
		MainForm.TileGfx.Bitmap.OnPixelCombine := MainForm.PC_ColorMask
	else
		MainForm.TileGfx.Bitmap.OnPixelCombine := MainForm.PC_NoColorMask;
end;


procedure SetTrans; overload;
begin
	SetTrans(MainForm.miViewTrans.Checked);
end;


procedure draw_sprite(od, x, y: Integer);
var
	o, zx,zy: Integer;
begin
	o := plains_level[level_object_set, _object].obj_design_2[od];
	if o = 3 then Exit;
	if o = 2 then SetTrans(True);
	if MainForm.ROM_gfx then
	begin
		od := plains_level[level_object_set, _object].obj_design[od];
		if od > 255 then od := Ord(ROMdata[od+1]);
		MainForm.Draw_Sprite(MainForm.Pb, od, x, y);
		zx := x + x_screen_loc;
		zy := y + y_screen_loc;
		if (zx >= 0) and (zy >= 0) and
			(zx < levellimit_x) and (y <= levellimit_y) then
				leveltile[zx,zy] := od;
	end
	else
	MainForm.Draw_Sprite(MainForm.Pb,
		plains_level[level_object_set, _object].obj_design[od] +
			(256 * level_object_set), x, y);
	if o = 2 then SetTrans
	else
	if o > 0 then MainForm.Draw_Sprite(MainForm.Pb, -o, x, y);
end;


procedure draw_4byteobjects(a: Integer);
var
	domain, _length, l_counter, g, h, i, j, k, l, m: Byte;
	x_position, y_position, w_counter, e, n, o: Integer;
begin
//	for aa := 0 to fbyte_objs-1 do
	drawingstate := DS_4BYTE;
	begin
		domain := fbyte_array[0, a] div 32;
		if vertical_flag then
		begin
			x_position := fbyte_array[1, a] mod 16;
			y_position := ((fbyte_array[1, a] div 16) * 15) + (fbyte_array[0, a] mod 32);
		end	else
		begin
			x_position := fbyte_array[1, a];
			y_position := fbyte_array[0, a] mod 32;
		end;
		// values of 0x00 to 0x0F are invalid for 4-byte objects, so show a warning block
		if (fbyte_array[2, a] < 16) then
			  for l_counter := 0 to fbyte_array[3, a] do
				mainform.draw_sprite(mainform.pb, 145 + (256 * level_object_set),
					x_position - x_screen_loc + l_counter, y_position - y_screen_loc)
		else
		begin
			_object := ((fbyte_array[2, a] div 16) + ((domain * 31) + 16)) - 1;
			if Loading then
				mainform.Log(inttostr(_object) + ' = ' +  plains_level[level_object_set, _object].obj_descript);
			// show warning block if object is not 4 bytes
			if plains_level[level_object_set, _object].obj_flag <> FOUR_BYTE then
			begin
				// warning block
			  for l_counter := 0 to fbyte_array[3, a] do
				mainform.draw_sprite(mainform.pb, 145 + (256 * level_object_set),
					x_position - x_screen_loc + l_counter, y_position - y_screen_loc)
			end
			else
			begin
				_length := fbyte_array[2, a] mod 16;
				if plains_level[level_object_set, _object].orientation in [HORIZ, HORIZ_2] then
				begin
					// if 4th byte extends object horizontally
					// if every block is the same - e.g. X-blocks (note: allows for if
					// the top edge of the object uses a different bitmap, e.g. water)
					if level_object_set = OBJSET_PLAINS then
					 if domain = 0 then
					  if (fbyte_array[2,a] >= $C0) and (fbyte_array[2,a] <= $DF) then
						if _length > 1 then _length := 1; // DD
					if plains_level[level_object_set, _object].ends = 0 then
					begin
					  for l_counter := 0 to _length do
						for w_counter := 0 to fbyte_array[3, a] do
						begin
							if plains_level[level_object_set, _object].orientation = HORIZ then
							begin
								if ((l_counter = 0) and (plains_level[level_object_set, _object].orientation = HORIZ)) then
									draw_sprite(0, x_position-x_screen_loc+w_counter,y_position-y_screen_loc)
								else
									draw_sprite(plains_level[level_object_set,_object].bmp_height - 1,
									x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter);
							end else
							begin
								if l_counter = _length then
									draw_sprite(1, x_position-x_screen_loc+w_counter,y_position-y_screen_loc+l_counter)
								else
									draw_sprite(0,x_position-x_screen_loc+w_counter,y_position-y_screen_loc+l_counter);
							end; // plains_level HORIZ
						end; // for W_COUNTER
						mainform.Draw_Handle(155, x_position, y_position);
					end // object_set ends 0
					// if left edge of object uses a different bitmap (e.g. ???)
					else
					if plains_level[level_object_set, _object].ends = 1 then
					begin
						for l_counter := 0 to _length do
							for w_counter := 0 to fbyte_array[3, a] do
							begin
								if w_counter = 0 then
								begin
									if l_counter = 0 then
										draw_sprite(0,x_position-x_screen_loc+w_counter,y_position-y_screen_loc)
									else
										draw_sprite(plains_level[level_object_set,_object].bmp_width
										* (plains_level[level_object_set,_object].bmp_height - 1),
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter);
								end else
								begin
									if l_counter = 0 then
										draw_sprite(plains_level[level_object_set,_object].bmp_width-1,
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc)
									else
										draw_sprite(plains_level[level_object_set,_object].bmp_width
										* (plains_level[level_object_set,_object].bmp_height - 1) + 1,
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter);
								end;
							end;
						mainform.Draw_Handle(155, x_position, y_position);
					end
					else
					// if right edge of object uses a different bitmap (e.g. ???)
					if plains_level[level_object_set, _object].ends = 2 then
					begin
						for l_counter := 0 to _length-1 do
							for w_counter := 0 to fbyte_array[3, a]-1 do
							begin
								if w_counter = fbyte_array[3, a]-1 then
								begin
									if l_counter = 0 then
										draw_sprite(plains_level[level_object_set, _object].bmp_width-1,
										x_position-x_screen_loc+w_counter,y_position-y_screen_loc)
									else
										draw_sprite(plains_level[level_object_set, _object].bmp_width
										* (plains_level[level_object_set, _object].bmp_height - 1) + 1,
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter);
								end else
								begin
									if l_counter = 0 then
										draw_sprite(0, x_position-x_screen_loc+w_counter, y_position-y_screen_loc)
									else
										draw_sprite(plains_level[level_object_set, _object].bmp_width
										* (plains_level[level_object_set, _object].bmp_height - 1),
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter);
								end;
							end;
						mainform.Draw_Handle(155, x_position, y_position);
					end
					else
					// if all blocks in the middle use the same bitmap but right and left
					// edges don't (e.g. the flat ground found in plains levels)
					if plains_level[level_object_set, _object].ends = 3 then
					begin
						for l_counter := 0 to _length do
						begin
							for w_counter := 0 to fbyte_array[3, a] do
							begin
								if w_counter = 0 then
								begin
									if l_counter = 0 then
										draw_sprite(0, x_position-x_screen_loc+w_counter, y_position - y_screen_loc)
									else if l_counter = _length - 1 then
										draw_sprite(plains_level[level_object_set, _object].bmp_width
										* (plains_level[level_object_set, _object].bmp_height - 1),
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter)
									else
										draw_sprite(3, x_position-x_screen_loc+w_counter,y_position-y_screen_loc+l_counter);
{
									if l_counter = 0 then
										mainform.draw_sprite(mainform.pb, plains_level[level_object_set,
										_object].obj_design[0] + (256 * level_object_set), ((
										(x_position - x_screen_loc)) + ( w_counter)),
										(( ((y_position) - y_screen_loc))))
									else if l_counter = _length - 1 then
										mainform.draw_sprite(mainform.pb, (plains_level[level_object_set,
										_object].obj_design[(plains_level[level_object_set, _object].bmp_width)
										* (plains_level[level_object_set, _object].bmp_height - 1)]) + (256 *
										level_object_set), (( (x_position - x_screen_loc)) +
										(w_counter)), (((((y_position)-y_screen_loc))+(l_counter))))
									else
										mainform.draw_sprite(mainform.pb, (plains_level[level_object_set,
										_object].obj_design[3]) + (256 * level_object_set), ((
										(x_position - x_screen_loc)) + ( w_counter)),
										y_position-y_screen_loc+l_counter);
}

								end
								else
								if w_counter = fbyte_array[3, a] then
								begin
									if l_counter = 0 then
										draw_sprite(2, x_position-x_screen_loc+w_counter, y_position-y_screen_loc)
									else if l_counter = _length - 1 then
										draw_sprite(plains_level[level_object_set,_object].bmp_width *
										(plains_level[level_object_set,_object].bmp_height - 1) + 2,
										x_position-x_screen_loc+w_counter,
										y_position-y_screen_loc+l_counter)
									else
										draw_sprite(5, x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter);
								end else
								begin
									if l_counter = 0 then
										draw_sprite(1, x_position-x_screen_loc+w_counter, y_position-y_screen_loc)
									else if l_counter = _length - 1 then
										draw_sprite(plains_level[level_object_set, _object].bmp_width
										* (plains_level[level_object_set, _object].bmp_height - 1) + 1,
										x_position-x_screen_loc+w_counter, y_position-y_screen_loc+l_counter)
									else
										draw_sprite(4,x_position-x_screen_loc+w_counter,y_position-y_screen_loc+l_counter);
                                end;
							end;
                        end;
					end;
					mainform.Draw_Handle(155, x_position, y_position);
				end
				else
				if plains_level[level_object_set, _object].orientation = VERTICAL then
				begin
					// if 4th byte extends object vertically (note: only one object is like this,
					// the X-block object in the Dungeon object set with values 0xF0 to 0xFF)
					for l_counter := 0 to _length do
						for w_counter := 0 to fbyte_array[3, a] do
							draw_sprite(plains_level[level_object_set,_object].bmp_height - 1,
							x_position-x_screen_loc+l_counter, y_position-y_screen_loc+w_counter);
						mainform.Draw_Handle(155, x_position, y_position);
				end
				else
				if plains_level[level_object_set, _object].orientation = DUMMY then
					// used mostly or entirely for warning blocks
					draw_sprite(0,	x_position-x_screen_loc, y_position-y_screen_loc);
			end;
		end;
	end;
end;






procedure draw_3byteobjects(ii: Integer);
var
	domain, _length, l_counter, a, g, h, i, j, k, l, m: Byte;
	gg, tx, ty, w_counter, e, n, o: Integer;
begin
	drawingstate := DS_3BYTE;
	begin
		i := ii; //objlist_3[ii];
		domain := tbyte_array[0,i] div 32;
		if vertical_flag = True then
		begin
			x_position := tbyte_array[1,i] mod 16;
			y_position := ((tbyte_array[1,i] div 16) * 15) + (tbyte_array[0,i] mod 32);
		end else
		begin
			x_position := tbyte_array[1,i];
			y_position := tbyte_array[0,i] mod 32;
		end;
		// if object is one of the single-length 0x00 to 0x0F objects
		if tbyte_array[2,i] < 16 then
		begin
			_object := tbyte_array[2,i] + (domain * 31);
			if Loading then
				mainform.Log(inttostr(_object) + ' <16 = ' + plains_level[level_object_set, _object].obj_descript);
			// extend to sky?
			if plains_level[level_object_set, _object].orientation = EXT_SKY then
			begin
				if blitting_object >= 0 then
				begin
					ObjectSize[blitting_object].Top := 0;
					ObjectSize[blitting_object].Height := y_position + 1;
					ObjectSize[blitting_object].Bottom := y_position;
				end;
				for g := 0 to y_position - 1 do
					draw_sprite(0, x_position - x_screen_loc, g - y_screen_loc);
					draw_sprite(1, x_position - x_screen_loc, y_position - y_screen_loc);
			end
			else
			// extend to ground?
			if plains_level[level_object_set, _object].orientation = GD_EXT then
			begin
			  // blue poles extend to sky!
			  begin
				//ground_level := GetGroundlevel(x_position, y_position, _length);
				if blitting_object >=0 then
				begin
					ObjectSize[blitting_object].Bottom := 27;
					ObjectSize[blitting_object].Height := 27 - ObjectSize[blitting_object].Top;
				end;
			  // others extend to ground
				for g := y_position to ground_level do
				  for j := 0 to plains_level[level_object_set,_object].bmp_width-1 do
				   for k := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						draw_sprite((((plains_level[level_object_set,
							_object].bmp_width) * k) + j),
							x_position - x_screen_loc + j, g - y_screen_loc + k);
				end;
			end // GD_EXT
			else
			if plains_level[level_object_set,_object].orientation in [PYRAMID, PYRAMID2] then
			begin
				gg := 0;
	{
				if plains_level[level_object_set,_object].orientation = PYRAMID2 then
				begin
					ground_level := Mainform.GetGroundlevel(x_position, y_position, 15);
					gg := 1;
				end;
	}
	ground_level := Mainform.GetGroundlevel(x_position, y_position-1, 1, True, False);
	gg := ground_level; // lowest yet
	k := 2; h := 1; j := 0;

	while ground_level >= gg do
	begin
		gg := Mainform.GetGroundlevel(x_position-h, y_position+j, k+1, True, False);
		if gg < ground_level then
		begin
			ground_level := gg;
			Break;
		end;
		if h < 8 then Inc(h);
		if k < 16 then Inc(k, 2);
		Inc(j);
		if j > 30 then Break;
	end;
	gg := 1;
	//if plains_level[level_object_set,_object].orientation = PYRAMID2 then gg := 1;
	if ground_level+gg > 25 then ground_level := 26-gg;
				ObjectSize[blitting_object].Bottom := ground_level - 1 + gg;
				ObjectSize[blitting_object].Height := ground_level + gg - ObjectSize[blitting_object].Top;
				if ObjectSize[blitting_object].Height < 1 then ObjectSize[blitting_object].Height := 1;

	ios := init_objectsizes;
	init_objectsizes := True;
				gg := 7;
				h := ObjectSize[blitting_object].Height-1;
				for k := 0 to h do
				begin
					for j := 0 to 7 do
					begin
						if j < gg then h := 0 else
						if j = gg then h := 1 else
						if j > gg then h := 2;
						draw_sprite(h,  x_position - x_screen_loc + j - 7, y_position - y_screen_loc + k );
						draw_sprite(5-h,x_position - x_screen_loc + (15-j) - 7, y_position - y_screen_loc + k );
					end;
					Dec(gg);
				end;
				//ObjectSize[blitting_object].HandleX := x_position - x_screen_loc - 7;
				mainform.Draw_Handle(156, x_position, y_position);
				init_objectsizes := ios;
			end // PYRAMID
			else
			if plains_level[level_object_set, _object].orientation = ENDING then
			begin 	// level ending object
				{ find 1st page limit }
				m := 16 - (x_position mod 16);
				{ page 1 }
				for k := 0 to m do
				for j := 0 to $19 do
				begin
					draw_sprite(0,	// indented tile
						x_position-x_screen_loc, y_position-y_screen_loc+j);
					draw_sprite(1,	// black tile
						x_position-x_screen_loc+k, y_position-y_screen_loc+j);
				end;
				{ page 2 }
				for k := 0 to 16 do
				for j := 0 to $19 do
					draw_sprite(1,
						x_position-x_screen_loc+k+m, y_position-y_screen_loc+j);
				{ gfx in page 2 }
				if (ROMloaded) and (not SMAS) then
				begin
					gg := $1C8F9 + (MainForm.Get_Ending_Index(real_level_object_set) * 96);
					for k := 0 to 15 do
					for j := 0 to 5 do
						TSA.BlitBlock(Pointer(MainForm.pb.Buffer),
							Ord(ROMdata[j*16+k+gg]),
							(x_position-x_screen_loc+k+m+1) * Zoomsize,
							(y_position-y_screen_loc+j+20) * Zoomsize );
				end;
				{ set size }
				if blitting_object > 0 then
					ObjectSize[blitting_object].Width := m + 17;
			end
			else
			{ default }
				for j := 0 to plains_level[level_object_set,_object].bmp_width-1 do
				  for k := 0 to plains_level[level_object_set,_object].bmp_height-1 do
					draw_sprite((((plains_level[level_object_set,_object].bmp_width) * k) + j),
						x_position - x_screen_loc + j, y_position - y_screen_loc + k);
			mainform.Draw_Handle(156, x_position, y_position);
		end // < 16 SINGLE-LENGTH
		else
		begin
			_object := (((tbyte_array[2,i] div 16) + ((domain * 31) + 16)) - 1);
			if Loading then
				mainform.Log(inttostr(_object) + ' >15 = ' +  plains_level[level_object_set, _object].obj_descript);
			//test if object is 3 bytes
			if (plains_level[level_object_set,_object].obj_flag <> THREE_BYTE) then
				mainform.draw_sprite(mainform.pb, 145 + (256 * level_object_set), ( (x_position - x_screen_loc)), (( ((y_position) - y_screen_loc))))
			else
			begin
				_length := tbyte_array[2,i] mod 16;
				//if object is horizontally oriented
				if plains_level[level_object_set,_object].orientation in [HORIZ, HORIZ_2] then
				begin
					// if all blocks are the same (e.g. a row of bricks)
					if plains_level[level_object_set, _object].ends = 0 then
					begin
						for l_counter := 0 to _length do
						 for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						  for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						   draw_sprite((((plains_level[level_object_set,_object].bmp_width) * l) + m), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l))));
						mainform.Draw_Handle(156, x_position, y_position);
					end
					else
					//if all blocks are the same except for the column on the left, e.g.
					//rightward pipes
					if plains_level[level_object_set,_object].ends = 1 then
					begin
					 for l_counter := 0 to _length do
					   begin
						 if l_counter = 0 then
						 begin
						  for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   begin
							  m := 0;
							  draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l),
								(((x_position - x_screen_loc) + m) + ( (plains_level[level_object_set,
								_object].bmp_width div 2)*l_counter)), ((((y_position)-y_screen_loc))+l));
						   end;
						 end
						 else
						 begin
						  for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   for m := 1 to plains_level[level_object_set,_object].bmp_width-1 do
							  draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m,
								(((x_position-x_screen_loc) + (m-1)) + (
								(plains_level[level_object_set,_object].bmp_width-1) * l_counter)),
								 (((((y_position)-y_screen_loc)) + l)));
						 end;
					   end;
					mainform.Draw_Handle(156, x_position, y_position);
				 end 	//end of if (plains_level[level_object_set][object].ends == 1)
				 else
				 if (plains_level[level_object_set,_object].ends = 2) then
				 //if all blocks are the same except for the column on the right, e.g.
				 //leftward pipes
				 begin
					for l_counter := 0 to _length{-1} do
					   begin
					  if l_counter = _length then
					   begin
						for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   begin
							  m := (plains_level[level_object_set,_object].bmp_width - 1);
							  draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m,
								x_position-x_screen_loc+l_counter, y_position-y_screen_loc+l);
						   end;
						 end
					  else
						 begin
						for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   for m := 0 to plains_level[level_object_set,_object].bmp_width - 2 do // -2
							  draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m,
								x_position - x_screen_loc + m + (
								(plains_level[level_object_set,_object].bmp_width - 1) * l_counter),
								y_position-y_screen_loc+l);
						 end;
					   end;
					mainform.Draw_Handle(156, x_position, y_position);
				 end	//end of if (plains_level[level_object_set][object].ends == 2)
				 else
				 if (plains_level[level_object_set,_object].ends = 3) then
				 //if all blocks in the middle are the same, but both the right
				 //and left edges use different bitmaps (e.g. the block platforms)
				 begin
					if (plains_level[level_object_set,_object].orientation = HORIZ) then
					begin
					  for l_counter := 0 to _length do
					  begin
						   if (l_counter = 0) then
						   begin
							 for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
							 begin
								m := 0;
								draw_sprite(0+(l*plains_level[level_object_set,_object].bmp_width), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l))));
							 end;
						   end
						   else if (l_counter = _length) then
						   begin
							 for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
							 begin
								m := (plains_level[level_object_set,_object].bmp_width - 1);
								draw_sprite((plains_level[level_object_set,_object].bmp_width - 1) +
								(l * plains_level[level_object_set,_object].bmp_width),
								x_position-x_screen_loc+m-2+l_counter, y_position-y_screen_loc+l);
							 end;
						   end
						   else
						   begin // clouds, double-ended horizontal pipes, ...
							 for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
							 begin
								h := (plains_level[level_object_set,_object].bmp_width - 1);
								for m := 1 to plains_level[level_object_set,_object].bmp_width-2 do
								   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m,
									x_position-x_screen_loc+m-1+l_counter, y_position-y_screen_loc+l);
							 end;
						   end;
						end;
				end 	//end HORIZ
					else
					begin
					  for l_counter := 0 to _length-1 do // HELLO
						if (l_counter = 0) then
						begin
						   for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   begin
								m := 0;
								draw_sprite(0 + (l * plains_level[level_object_set,_object].bmp_width), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l))));
						   end;
						end
						else if (l_counter = (_length - 1)) then
						begin
						   for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   begin
							 m := (plains_level[level_object_set,_object].bmp_width - 1);
							 draw_sprite((plains_level[level_object_set,_object].bmp_width-1) + (l * plains_level[level_object_set,_object].bmp_width), (( (x_position - x_screen_loc) + ( (m - 2))) + ( l_counter)), ((( ((y_position) - y_screen_loc)) + ( l))));
						   end;
						end
						 else
						begin
						   for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						   begin
							 h := (plains_level[level_object_set,_object].bmp_width - 1);    	// -2
							 for m := 1 to plains_level[level_object_set,_object].bmp_width-1 do  // -2
								draw_sprite(m + (l * plains_level[level_object_set,_object].bmp_width), x_position - x_screen_loc + m - 1 + l_counter, y_position - y_screen_loc + l);
							 // right corner shadow
							 if mainform.isBlockPlatform(level_object_set, _object) then
							 begin
SetTrans(True);
								if l < 1 then
								  mainform.draw_sprite(mainform.pb, shadowblock[5], x_position - x_screen_loc + m - 1 + l_counter, y_position - y_screen_loc + l)
								else
								  mainform.draw_sprite(mainform.pb, shadowblock[4], x_position - x_screen_loc + m - 1 + l_counter, y_position - y_screen_loc + l);
SetTrans;
							 end;
						   end;
						end;
					   end;
					// bottom shadow
					if mainform.isBlockPlatform(level_object_set, _object) then
					begin
SetTrans(True);
						for m := 1 to _length-1 do
							mainform.draw_sprite(mainform.pb, shadowblock[2], x_position-x_screen_loc+m, y_position-y_screen_loc+plains_level[level_object_set,_object].bmp_height);
						mainform.draw_sprite(mainform.pb, shadowblock[1], x_position-x_screen_loc, y_position-y_screen_loc+plains_level[level_object_set,_object].bmp_height);
						mainform.draw_sprite(mainform.pb, shadowblock[3], x_position-x_screen_loc + _length, y_position-y_screen_loc+plains_level[level_object_set,_object].bmp_height);
SetTrans;
					end;
					Mainform.Draw_Handle(156, x_position, y_position);
				 end;
			   end
			else if (plains_level[level_object_set,_object].orientation = VERTICAL) then
			   //if object is vertically oriented
			   begin
				 if (plains_level[level_object_set,_object].ends = 0) then
				 //if all blocks are the same (e.g. ???)
				 begin
					for l_counter := 0 to _length{-1} do
					  for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
					   for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						 draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ( (x_position - x_screen_loc) + ( m)), (((( ((y_position) - y_screen_loc)) + ( l)) + ( (plains_level[level_object_set,_object].bmp_height) * l_counter))));
					Mainform.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if (plains_level[level_object_set,_object].ends = 1) then
				 // if all blocks are the same except for the row on the top (e.g. downward pipes)
				 begin
					for l_counter := 0 to _length do
					  if l_counter = 0 then
					  begin
						for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						begin
						   if _length > 1 then
						   begin
							for l := 0 to plains_level[level_object_set,_object].bmp_height - 1 do
							 draw_sprite( plains_level[level_object_set,_object].bmp_width * l + m,
								x_position - x_screen_loc + m, y_position-y_screen_loc + l +
									(plains_level[level_object_set,_object].bmp_height * l_counter) );
						   end
						   else
						   begin
							l := 0;
							draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ( (x_position - x_screen_loc) + ( m)), (((( ((y_position) - y_screen_loc)) + ( l)) + ( (plains_level[level_object_set,_object].bmp_height) * l_counter))));
						   end;
						end;
					  end
					  else  // l_counter > 0
					  begin
						 l := (plains_level[level_object_set,_object].bmp_height - 1);
						 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						 if (plains_level[level_object_set,_object].bmp_height <= 2) then
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ( (x_position - x_screen_loc) + ( m)), (((( ((y_position) - y_screen_loc)) + ( (l - 1))) + ( (plains_level[level_object_set,_object].bmp_height - 1) * l_counter))))
						 else
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ( (x_position - x_screen_loc) + ( m)), (((( ((y_position) - y_screen_loc)) + ( (l - 1))) + ( (plains_level[level_object_set,_object].bmp_height - 2) * (l_counter - 1)))));
					  end;
					Mainform.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if (plains_level[level_object_set,_object].ends = 2) then
				 //if all blocks are the same except for the row on the bottom, e.g.
				 //upward pipes
				 begin
					for l_counter := 0 to _length do
					   if (l_counter = _length) then
					  begin
						 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						begin
						   l := (plains_level[level_object_set,_object].bmp_height - 1);
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ( (x_position - x_screen_loc) + ( m)), ((( ((y_position) - y_screen_loc)) + ( l_counter))));
						end;
					  end
					   else
					  begin
						 for l := 0 to plains_level[level_object_set,_object].bmp_height - 2 do
						  for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, (( (x_position - x_screen_loc)) + ( m)), (((( ((y_position) - y_screen_loc)) + ( l)) + ( (plains_level[level_object_set,_object].bmp_height - 1) * l_counter))));
					  end;
					Mainform.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if (plains_level[level_object_set,_object].ends = 3) then
				 //if all blocks in the middle are the same, but both the top
				 //and bottom edges use different bitmaps (e.g. double-ended pipes)
				 begin
					for l_counter := 0 to _length do
					   if (l_counter = 0) then
					  begin
						 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						begin
						   l := 0;
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ( (x_position - x_screen_loc) + ( m)), (((( ((y_position) - y_screen_loc)) + ( l)) + ( (plains_level[level_object_set,_object].bmp_height) * l_counter))));
						end;
					  end
					   else if (l_counter = _length) then
					  begin
						 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						begin
						   l := (plains_level[level_object_set,_object].bmp_height - 1);
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, (( (x_position - x_screen_loc)) + ( m)), (((( ((y_position) - y_screen_loc)) + ( (l - 2))) + ( l_counter))));
						end;
					  end
					   else
					  begin
						 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						  for l := 1 to plains_level[level_object_set,_object].bmp_height - 2 do
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, (( (x_position - x_screen_loc)) + ( m)), (((( ((y_position) - y_screen_loc)) + ( (l - 1))) + ( l_counter))));
					  end;
					Mainform.Draw_Handle(156, x_position, y_position);
				 end;
			   end
			else if (plains_level[level_object_set,_object].orientation = GD_EXT) then
			   begin
{
 Object is horizontally oriented but also extends to the ground.
 Assumes ground is at vertical location 26 or $1A.
 Some code could be placed right here to find the true location of the ground.
}
				//if not mainform.isBlockPlatform(level_object_set, _object) then
				  ground_level := Mainform.GetGroundlevel(x_position, y_position,
					_length, level_object_set <> 1);
				{else
				if blitting_object >=0 then
				begin
					ground_level := 25;
					ObjectSize[blitting_object].Bottom := ground_level;
					ObjectSize[blitting_object].Height := ground_level+1 - ObjectSize[blitting_object].Top;
				end;}

				 //if all blocks are the same (e.g. ???)
				 if (plains_level[level_object_set,_object].ends = 0) then
				 begin
					for l_counter := 0 to _length-1 do
					  for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
					   for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						 for g := y_position to ground_level do
						  draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l) + ( (g - (y_position))))));
					MainForm.Draw_Handle(156, x_position, y_position);
				 end;
				 if (plains_level[level_object_set,_object].ends = 1) then
				 //if all blocks are the same except for the column on the left (e.g. ???)
				 begin
					for l_counter := 0 to _length-1 do
					begin
					  if l_counter = 0 then
					  begin
						for g := y_position to ground_level do
						   begin
							  if g = y_position then
								draw_sprite(0, ( (x_position - x_screen_loc)), (( (y_position) - y_screen_loc)))
							  else if g = ground_level then
								draw_sprite((plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width), ( (x_position - x_screen_loc)), (( (25 - y_screen_loc))))
							  else
								draw_sprite((plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width), ( (x_position - x_screen_loc)), (( (g - y_screen_loc))));
						   end;
						 end
					  else
						 begin
						   for g := y_position to ground_level do
						   begin
							  if g = y_position then
								draw_sprite(1, (( (x_position - x_screen_loc)) + ( l_counter)), (( (y_position) - y_screen_loc)))
							  else if g = ground_level then
								draw_sprite((plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width) + 1, (( (x_position - x_screen_loc)) + ( l_counter)), (( (ground_level - y_screen_loc))))
							  else
								draw_sprite((plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width) + 1, (( (x_position - x_screen_loc)) + ( l_counter)), (( (g - y_screen_loc))));
						   end;
						 end;
					   end;
					MainForm.Draw_Handle(156, x_position, y_position);
				 end;
				  if (plains_level[level_object_set,_object].ends = 2) then
				 //if all blocks are the same except for the column on the right (e.g. ???)
				 begin
					for l_counter := 0 to _length-1 do
					   begin
					  if (l_counter = (_length - 1)) then
						 begin
						   for g := y_position to ground_level do
						   begin
							  if (g = (y_position)) then
								draw_sprite(1, (( (x_position - x_screen_loc)) + ( l_counter)), ( (y_position) - y_screen_loc))
							  else if g = ground_level then
								draw_sprite((plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width) + 1, (( (x_position - x_screen_loc)) + ( l_counter)), ( (ground_level - y_screen_loc)))
							  else
								draw_sprite((plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width) + 1, (( (x_position - x_screen_loc)) + ( l_counter)), ( (g - y_screen_loc)));
						   end;
						 end
					  else
						 begin {
						   for g := y_position to ground_level do
						   begin
							  if g = y_position then
							 mainform.draw_sprite(main_display, (plains_level[level_object_set,_object].obj_design[0]) + (256 * level_object_set), (( (x_position - x_screen_loc)) + ( l_counter)), ( (y_position) - y_screen_loc))
							  else if (g = 25) then
							 mainform.draw_sprite(main_display, (plains_level[level_object_set,_object].obj_design[(plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width)]) + (256 * level_object_set), (( (x_position - x_screen_loc)) + ( l_counter)), ( (25 - y_screen_loc)))
							  else
							 mainform.draw_sprite(main_display, (plains_level[level_object_set,_object].obj_design[(plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width)]) + (256 * level_object_set), (( (x_position - x_screen_loc)) + ( l_counter)), ( (g - y_screen_loc)));
						   end; }
						 end;
					   end;
					MainForm.Draw_Handle(156, x_position, y_position);
				 end;
				 // if all blocks in the middle are the same but left and right
				 // edges use different bitmaps (e.g. the block platforms)
				 if (plains_level[level_object_set,_object].ends = 3) then
				 begin
					for l_counter := 0 to _length do
					begin
					  if (l_counter = 0) then
						 begin
						   for g := y_position to ground_level do
						   begin
							  if g = y_position then
								draw_sprite(0, ( (x_position - x_screen_loc)), (( ((y_position) - y_screen_loc))))
							  else if g = ground_level then
								draw_sprite(((plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width)), ( (x_position - x_screen_loc)), (( (ground_level - y_screen_loc))))
							  else
								draw_sprite(((plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width)), ( (x_position - x_screen_loc)), (( (g - y_screen_loc))));
						   end;
						 end
					  else
					   if l_counter = _length then
						 begin
						   for g := y_position to ground_level do
							for l := ((plains_level[level_object_set,_object].bmp_width) - ((plains_level[level_object_set,_object].bmp_width - 2))) to (plains_level[level_object_set,_object].bmp_width-1) do
							begin
							 if g = y_position then
							 begin
								draw_sprite(l, (( (x_position - x_screen_loc)) + ( l_counter)), (( ((y_position) - y_screen_loc))));
								// block platform top right shadow
								if mainform.isBlockplatform(level_object_set, _object) then // is block platform ?
								begin
									SetTrans(True);
								  mainform.draw_sprite(mainform.pb, shadowblock[5], x_position - x_screen_loc + l_counter + 1, g - y_screen_loc);
									SetTrans;
								end;
							 end
							 else
							 begin
								if g = ground_level then
									draw_sprite(((plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width) + l), (( (x_position - x_screen_loc)) + ( (l_counter))), (( (ground_level - y_screen_loc))))
								else
									draw_sprite(((plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width) + l), (( (x_position - x_screen_loc)) + ( (l_counter))), (( (g - y_screen_loc))));
								// block platform right shadow
								if mainform.isBlockPlatform(level_object_set, _object) then // is block platform ?
								begin
									SetTrans(True);
									mainform.draw_sprite(mainform.pb, shadowblock[4], x_position - x_screen_loc + l_counter + 1, g - y_screen_loc);
									SetTrans;
								end;
							 end;
							end;
						 end
					  else
						 begin
						   for g := y_position to ground_level do
						   begin
							  if g = y_position then
								draw_sprite(1, (( (x_position - x_screen_loc)) + ( l_counter)), (( ((y_position) - y_screen_loc))))
							  else
							  if g = ground_level then
								draw_sprite(((plains_level[level_object_set,_object].bmp_height - 1) * (plains_level[level_object_set,_object].bmp_width) + 1), (( (x_position - x_screen_loc)) + ( l_counter)), (( (ground_level - y_screen_loc))))
							  else
								draw_sprite(((plains_level[level_object_set,_object].bmp_height - 2) * (plains_level[level_object_set,_object].bmp_width) + 1), (( (x_position - x_screen_loc)) + ( l_counter)), (( (g - y_screen_loc))));
						   end;
						 end;
					   end;
					MainForm.Draw_Handle(156, x_position, y_position);
				 end;
			   end
			else if plains_level[level_object_set,_object].orientation = DUMMY then
			   //used mostly or entirely for warning blocks
			   begin
				  for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
				   for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
					draw_sprite(((plains_level[level_object_set,_object].bmp_width) * m) + l, (( (x_position - x_screen_loc)) + ( m)), ((( ((y_position) - y_screen_loc)) + ( l))));
			   end
			else if (plains_level[level_object_set,_object].orientation = DIAG_DL) then
			   begin
				 if (plains_level[level_object_set,_object].ends = 0) then
				 begin
					for l_counter := 0 to _length do
					   for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						 draw_sprite(((plains_level[level_object_set,_object].bmp_width) * m) + l, ((( (x_position - x_screen_loc)) + ( m)) - ( plains_level[level_object_set,_object].bmp_width * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l)) + ( plains_level[level_object_set,_object].bmp_height * l_counter)));
						MainForm.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if plains_level[level_object_set,_object].ends = 1 then
				 begin
					for l_counter := 0 to _length do
					   for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						 begin
						  if m <> (plains_level[level_object_set,_object].bmp_width - 1) then
						   draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, ((( (x_position - x_screen_loc)) + ( m)) - ( (plains_level[level_object_set,_object].bmp_width - 1) * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l)) + ( plains_level[level_object_set,_object].bmp_height * l_counter)))
						else
						   begin
							g := l_counter * (plains_level[level_object_set,_object].bmp_width - 1);
							if g > 0 then
							 for h := 0 to g-1 do
							  draw_sprite(((plains_level[level_object_set,_object].bmp_width) - 1), ((( (x_position - x_screen_loc)) + ( (h + plains_level[level_object_set,_object].bmp_width - 1))) - ( (plains_level[level_object_set,_object].bmp_width - 1) * l_counter)), ((( (((y_position)) - y_screen_loc)) + ( l)) + ( plains_level[level_object_set,_object].bmp_height * l_counter)));
						   end;
						 end;
					MainForm.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if (plains_level[level_object_set,_object].ends = 2) then
				 begin
					for l_counter := 0 to _length do
					  for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
					   for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						 draw_sprite(((plains_level[level_object_set,_object].bmp_width) * m) + l, ((( (x_position - x_screen_loc)) + ( m)) - ( plains_level[level_object_set,_object].bmp_width * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l)) + ( (plains_level[level_object_set,_object].bmp_height - 1) * l_counter)));
					MainForm.Draw_Handle(156, x_position, y_position);
				 end;
			   end
			else if (plains_level[level_object_set,_object].orientation = DIAG_DR) then
			   begin
				 if (plains_level[level_object_set,_object].ends = 0) then
				 begin
					for l_counter := 0 to _length do
					 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
					  for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						draw_sprite(((plains_level[level_object_set,_object].bmp_width) * m) + l, ((( (x_position - x_screen_loc)) + ( m)) + ( plains_level[level_object_set,_object].bmp_width * l_counter)), ((( ((y_position) - y_screen_loc)) + ( l)) + ( plains_level[level_object_set,_object].bmp_height * l_counter)));
					MainForm.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if (plains_level[level_object_set,_object].ends = 1) then
				  begin
					for l_counter := 0 to _length do
					 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
					   for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						begin
							if m <> 0 then
								draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m,
								((( (x_position - x_screen_loc)) + ((m - 1)))
								+ ( (plains_level[level_object_set,_object].bmp_width-1) * l_counter)),
								((( (y_position - y_screen_loc)) + l) + ( plains_level[level_object_set,
								_object].bmp_height * l_counter)))
							else
							begin
								g := l_counter * (plains_level[level_object_set,_object].bmp_width-1);
								if g > 0 then
								for h := 0 to g-1 do
									draw_sprite(0, ((( (x_position - x_screen_loc)) + ( h))),
									(((y_position - y_screen_loc) + l) + (plains_level[level_object_set,
									_object].bmp_height * l_counter)));
							end;
						end;
					MainForm.Draw_Handle(156, x_position, y_position);
				 end
				 else
				 if (plains_level[level_object_set,_object].ends = 2) then
				 begin
(*
	Up/Left Diagonal Hills
 *)
					for l_counter := 0 to _length do
					 for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
					  for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
						 begin
						   if m <> (plains_level[level_object_set,_object].bmp_width - 1) then
							 draw_sprite( ((plains_level[level_object_set,_object].bmp_width) * l) + m,
								 ((( (x_position - x_screen_loc)) + m) + ( (plains_level[level_object_set,_object].bmp_width-1)
								 * l_counter)), (((y_position - y_screen_loc) + l) + ( plains_level[level_object_set,
								_object].bmp_height * l_counter)))
						else
						   for h := ((_length - l_counter) * (plains_level[level_object_set,_object].bmp_width - 1)) downto 1 do
							  draw_sprite(((plains_level[level_object_set,_object].bmp_width) - 1),
								((( (x_position - x_screen_loc)) + ( (h + plains_level[level_object_set,_object].bmp_width - 2)))
								 + ( (plains_level[level_object_set,_object].bmp_width - 1) * l_counter)), ((( ((y_position)
								 - y_screen_loc)) + l) + ( plains_level[level_object_set,_object].bmp_height * l_counter)));
						 end;
					MainForm.Draw_Handle(156, x_position, y_position);

				 end;
			   end
			else if (plains_level[level_object_set,_object].orientation = DIAG_CRNR) then
			   begin
				  for l_counter := 0 to _length do
				   for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
					for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
					   begin
						 if m = 0 then
						 begin
							for h := ((_length - l_counter) * (plains_level[level_object_set,_object].bmp_width - 1)) downto 1 do
								draw_sprite(0, ((( (x_position - x_screen_loc)) + ( (h - 1)))), ((( (((y_position)) - y_screen_loc)) + ( l)) + ( plains_level[level_object_set,_object].bmp_height * l_counter)));
						 end
					  else
						 draw_sprite(((plains_level[level_object_set,_object].bmp_width) * l) + m, (( (x_position - x_screen_loc)) + (( (((_length - l_counter) * (plains_level[level_object_set,_object].bmp_width - 1)) - 1)) + ( m))), ((( (((y_position)) - y_screen_loc)) + ( l)) + ( plains_level[level_object_set,_object].bmp_height * l_counter)));
					   end;
					MainForm.Draw_Handle(156, x_position, y_position);
			   end
			else if (plains_level[level_object_set,_object].orientation = DIAG_UR) then
			   begin
				  for l_counter := 0 to _length do
				   for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
					for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
					   draw_sprite(	((plains_level[level_object_set,_object].bmp_width) * m) + l,
						((( x_position - x_screen_loc) + m) + ( plains_level[level_object_set,_object].bmp_width *
						 l_counter)), ((( y_position) - y_screen_loc + l) - (
						plains_level[level_object_set,_object].bmp_height * l_counter)));
					MainForm.Draw_Handle(156, x_position, y_position);
			   end
			else if (plains_level[level_object_set,_object].orientation = PIPEBOX) then
			begin
				for l_counter := 0 to ((_length * 2) + 1) do
					for h := 0 to 4 do
						for m := 0 to plains_level[level_object_set,_object].bmp_width-1 do
						begin
							if (plains_level[level_object_set,_object].bmp_height <= 4) then
							begin
								if h = 4 then
								begin
									l := 0;
									draw_sprite((((plains_level[level_object_set,_object].bmp_width) * l) + m), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), (( ((y_position) - y_screen_loc)) + ( l) + ( (plains_level[level_object_set,_object].bmp_height) * h)));
								end
								else
								begin
									for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
										draw_sprite((((plains_level[level_object_set,_object].bmp_width) * l) + m), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), (( ((y_position) - y_screen_loc)) + ( l) + ( (plains_level[level_object_set,_object].bmp_height) * h)));
								end;
							end
							else
							begin
								if h = 0 then
								begin
									for l := 0 to plains_level[level_object_set,_object].bmp_height-1 do
										draw_sprite((((plains_level[level_object_set,_object].bmp_width) * l) + m), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), (( ((y_position) - y_screen_loc)) + ( l) + ( (plains_level[level_object_set,_object].bmp_height) * h)));
								end
								else
								begin
									for l := 1 to plains_level[level_object_set,_object].bmp_height-1 do
										draw_sprite((((plains_level[level_object_set,_object].bmp_width) * l) + m), (( (x_position - x_screen_loc) + ( m)) + ( (plains_level[level_object_set,_object].bmp_width) * l_counter)), (( ((y_position) - y_screen_loc)) + ( l) + ( (plains_level[level_object_set,_object].bmp_height - 1) * h)));
								end;
							end;
						end; // for
{
				for h := 0 to 4 do
					for g := 0 to 7 do
					begin
						if (plains_level[level_object_set,_object].bmp_height <= 4) then
						begin
							if h = 4 then
								draw_sprite(2, (( (x_position - x_screen_loc) + g) + ( ((_length * 2) + 1) * plains_level[level_object_set,_object].bmp_width) ), (( ((y_position) - y_screen_loc)) + ( l) + ( (plains_level[level_object_set,_object].bmp_height) * h)))
							else
								draw_sprite(2]) + (256 * level_object_set), (( (x_position - x_screen_loc) + g) + ( ((_length * 2) + 1) * plains_level[level_object_set,_object].bmp_width) ), (( ((y_position) - y_screen_loc)) + ( l) + ( (plains_level[level_object_set,_object].bmp_height) * h)));
						end
						else
						begin
							if h = 0 then
								draw_sprite(2]) + (256 * level_object_set), (( (x_position - x_screen_loc) + g) + ( ((_length * 2) + 1) * plains_level[level_object_set,_object].bmp_width) ), (( ((y_position) - y_screen_loc))));
						end;
					end;
}
					MainForm.Draw_Handle(156, x_position, y_position);
				end; // PIPEBOX
			end;
		end;
	 end;
end;






procedure draw_enemies;
var
	// domain, _length, l_counter, a, g, i, j, k, l, m: Byte;
	h: Byte;
	{w_counter, }e, n, o: Integer;
	xo, yo: Integer;
begin
	MainForm.Log('**** ENEMIES', Loading);
	for e := 0 to enemy_objs - 1 do
	begin
	blitting_object := e;
		_object := enemy_array[0, e];
		{if init_objectsizes then
		begin}
		xo := enemyhandle_x[_object];
		yo := enemyhandle_y[_object];
		{end else begin
			xo := 0; yo := 0;
		end;}
		if Loading then
			MainForm.Log(inttostr(_object) + ' = ' +  plains_level[12, _object].obj_descript);
		// invalid enemy? enemies past value 0xD6 all crash the game.
		if _object >= 236 then
			mainform.draw_sprite(mainform.pb, 145 + (256 * enemybank),
				( (enemy_array[1, e] - x_screen_loc)) + xo,
				( (enemy_array[2, e] - y_screen_loc)) + yo)
		else
		begin
			if plains_level[enemybank, _object].orientation = DUMMY then
			begin
				// most enemies fall under this category.  enemies are simple
				// because you can't extend their lengths or anything.
				h := 0;
				{ if plains_level[11, _object].bmp_width = 1 then
				  if plains_level[11, _object].bmp_height = 2 then
					h := 16; }
{
if (plains_level[11, _object].min_value < $A0) or
   (plains_level[11, _object].min_value > $A7) then
					h := plains_level[11, _object].bmp_height-1;
}
				for n := 0 to plains_level[enemybank, _object].bmp_width - 1  do
					for o := 0 to plains_level[enemybank, _object].bmp_height - 1 do
					begin
						mainform.draw_sprite(mainform.pb, plains_level[enemybank,
							_object].obj_design[(((plains_level[enemybank,
							_object].bmp_width) * o) + n)] + (256 * enemybank),
							( (enemy_array[1, e] - (x_screen_loc)) +
							n)  + xo, (( (enemy_array[2, e] -
							y_screen_loc)) + ( o)) - h  + yo);
						if MainForm.miViewHandles.Checked then
							mainform.draw_sprite(mainform.pb, 155 + (256 * enemybank), (
								(enemy_array[1, e] - (x_screen_loc))) + xo, ((
								((enemy_array[2, e]) - y_screen_loc))) - h  + yo);
					end;
			end
			else
			// special process for "centered" enemies like spinning platforms
			if plains_level[enemybank, _object].orientation = CENTER then
			begin
				mainform.draw_sprite(mainform.pb, plains_level[enemybank,
					_object].obj_design[((plains_level[enemybank, _object].bmp_width) div 2)]
					 + (256 * enemybank), ( (enemy_array[1, e] - x_screen_loc)) + xo,
					( (enemy_array[2, e] - y_screen_loc)) + yo);
				for n := 0 to (plains_level[enemybank, _object].bmp_width div 2) -1 do
				begin
					o := 0;
					mainform.draw_sprite(mainform.pb, plains_level[enemybank,
					_object].obj_design[(((plains_level[enemybank, _object].bmp_width) * o)
					+ n)] + (256 * enemybank), ( (enemy_array[1, e] - (x_screen_loc))
					+ ( (n - (plains_level[enemybank, _object].bmp_width div 2)))) + xo,
					(( (enemy_array[2, e] - y_screen_loc)) + o) + yo);
				end;
				for n := ((plains_level[enemybank, _object].bmp_width div 2)+1)
					to (plains_level[enemybank, _object].bmp_width-1) do
				begin
					o := 0;
					mainform.draw_sprite(mainform.pb, plains_level[enemybank,
						_object].obj_design[(((plains_level[enemybank, _object].bmp_width)
						* o) + n)] + (256 * enemybank), ( (enemy_array[1, e] -
						(x_screen_loc)) + ( (n - (plains_level[enemybank,
						_object].bmp_width div 2)))) + xo, (( (enemy_array[2, e]
						- y_screen_loc)) + o) + yo );
				end;
{					mainform.draw_sprite(mainform.pb, 155 + (256 * enemybank),
						( (enemy_array[1, e] - (x_screen_loc))), ((
						((enemy_array[2, e]) - y_screen_loc)))); }
			end;
		end;
//		if MainForm.miViewHandles.Checked then
			mainform.Draw_Handle(155, enemy_array[1,e], enemy_array[2, e]);

	end;
end;


end.

