procedure TMainForm.Draw_Sprite(var Box: TPaintbox32; id, x, y: Integer);
label
	GetSize;
var
	xx, yy: Integer;
begin
	if (x < 0) or (y < 0) then goto GetSize;

	if AskTile.Want then
		if (X = AskTile.X) and (Y = AskTile.Y) then
		begin
			AskTile.Tile := tsaData[(AskTile.Corner * $100) + id];
			// AskTile.Want := False;
		end;

	xx := Zoomsize * x;
	yy := Zoomsize * y;

	if (xx + Zoomsize > pbW) or (yy + Zoomsize > pbH) then
		goto GetSize;
	if id >= 0 then
		pb.Buffer.Draw(Bounds(xx, yy, Zoomsize, Zoomsize),
			Bounds( (id mod 64) * 16, (id div 64) * 16, 16, 16),
				TileGfx.Bitmap)
	else
	begin
		if mode = MODE_EDIT_LEVEL then
			if not ROM_gfx then Exit;
		id := Abs(id);
		if id < 64 then
		begin
			TransColor := Color32($FF, $33, $FF);
			TileGfx.Bitmap.OnPixelCombine := PC_ColorMask;
			pb.Buffer.Draw(Bounds(xx, yy, Zoomsize, Zoomsize),
				Bounds(id * 16, 848, 16, 16), TileGfx.Bitmap);
			if miViewTrans.Checked then
				TileGfx.Bitmap.OnPixelCombine := PC_ColorMask
			else
				TileGfx.Bitmap.OnPixelCombine := PC_NoColorMask;
			TransColor := color_Sky;
		end
		else
		begin
			TransColor := Color32($FF, $33, $FF); // Color_FillSky;
			id := (id - 64) + (level_object_set * 256);
			pb.Buffer.Draw(Bounds(xx, yy, Zoomsize, Zoomsize),
				Bounds( (id mod 64) * 16, (id div 64) * 16, 16, 16),
					TileGfx.Bitmap);
			TransColor := color_Sky;
		end;
	end;
	if blitting_object < 0 then Exit;

GetSize:
(*
 * Finds out an object's position and size from the positions
 * its blocks are drawn in. Definitely a hacky way to do it.
 *)
	if drawingstate = DS_HANDLE then Exit;
	if not init_objectsizes then Exit;
	if blitting_object < 0 then Exit;
	if drawingstate = DS_ENEMY then
	begin
		objectsizeinit_prev := blitting_object;
		Exit;
	end;
	x := x + x_screen_loc;
	y := y + y_screen_loc;
	if objectsizeinit_prev <> blitting_object then
	  with ObjectSize[blitting_object] do
	  begin
		Left   := x;
		Top    := y;
		Right  := x;
		Bottom := y;
		Width  := 1;
		Height := 1;
	  end
	else
	begin
		if x < ObjectSize[blitting_object].Left   then
			ObjectSize[blitting_object].Left   := x;
		if y < ObjectSize[blitting_object].Top    then
			ObjectSize[blitting_object].Top    := y;
		if x > ObjectSize[blitting_object].Right  then
			ObjectSize[blitting_object].Right  := x;
		if y > ObjectSize[blitting_object].Bottom then
			ObjectSize[blitting_object].Bottom := y;
		ObjectSize[blitting_object].Width  :=
			ObjectSize[blitting_object].Right  -
			ObjectSize[blitting_object].Left + 1;
		ObjectSize[blitting_object].Height :=
			ObjectSize[blitting_object].Bottom -
			ObjectSize[blitting_object].Top + 1;
	end;
	objectsizeinit_prev := blitting_object;
end;


procedure TMainForm.Draw_Handle(id, x, y: Integer);
var
	drst: Integer;
begin
(* get x offset for handle *)
	if blitting_object < 0 then Exit;
	if init_objectsizes = True then
	begin
		if drawingstate = DS_ENEMY then
		{
		  EnemySize[blitting_object].HandleX :=
			x -  EnemySize[blitting_object].Left
			- enemyhandle_x[enemy_array[0, blitting_object]]
		}
		EnemySize[blitting_object].HandleX :=
			enemyhandle_x2[enemy_array[0, blitting_object]]
		else
		begin
		  ObjectSize[blitting_object].HandleX :=
			x - ObjectSize[blitting_object].Left;
		  ObjectSize[blitting_object].HandleY :=
			y - ObjectSize[blitting_object].Top;
		end;
	end;
(* draw handle *)
	if ROM_gfx then Exit;
	if not miViewHandles.Checked then Exit;
	drst := drawingstate;
	drawingstate := DS_HANDLE;
	Draw_Sprite(pb, id + 256 {* level_object_set)},
		x - x_screen_loc, y - y_screen_loc);
	drawingstate := drst;
end;


procedure TMainForm.PC_ColorMask(F: TColor32; var B: TColor32; M: TColor32);
begin	//	color masking callback called for each pixel plotted
	if F = color_FillSky then B := color_Sky
	else if F <> TransColor then B := F;
end;

procedure TMainForm.PC_NoColorMask(F: TColor32; var B: TColor32; M: TColor32);
begin	//	color masking callback called for each pixel plotted
	if drawingstate in [DS_HANDLE, DS_ENEMY] then
	begin
		if F = color_FillSky then B := color_Sky
		else if F <> TransColor then B := F;
	end else
	begin
		if F = TransColor then B := color_Sky
		else if F = color_FillSky then B := color_Sky
		else B := F;
	end;
end;


procedure TMainForm.GetBgTileSolidColor;
var
	x, y: Integer;
	oc: TColor32;
begin
	BgTileIsSolidColor := True;
	oc := FloorGfx.Buffer.PixelS[0,0];
	for x := 0 to 15 do
	  for y := 0 to 15 do
		if FloorGfx.Buffer.PixelS[x,y] <> oc then
		begin
			BgTileIsSolidColor := False;
			Break;
		end;
	if not BgTileIsSolidColor then
		color_BgTile := color_Sky
	else
		color_BgTile := oc;
	if level_object_set = OBJSET_CLOUDY then color_Sky := color_BgTile;
//	if level_object_set = OBJSET_UNDERGROUND then color_Sky := 0;
end;


procedure TMainForm.ClearLevel(what, romloc: Integer);
var
	x, y, m, floortile: Integer;
begin
	// if not ROMgfx then Exit;
	floortile := romloc; //Ord(ROMdata[romloc+1]);
	case what of
	LOC_ALL:
		begin
			if BgTileIsSolidColor then Exit;
			for y := 0 to Min(pb.Height div Zoomsize, levellimit_y-y_screen_loc) do
				for x := 0 to pb.Width  div Zoomsize do
					Draw_FloorTile(floortile, x, y);
		end;
	LOC_TOP, LOC_TOP2:
		begin
			y := 0;
			if y = LOC_TOP2 then Inc(y);
			for x := 0 to pb.Width div Zoomsize do
				Draw_FloorTile(floortile, x, y - y_screen_loc);
		end;
	LOC_BOTTOM:
		begin
			y := 26;
			for x := 0 to pb.Width div Zoomsize do
				Draw_FloorTile(floortile, x, y - y_screen_loc);
		end;
	LOC_DBOTTOM, LOC_DBOTTOM2:
		begin
			y := 26 - y_screen_loc;
			if what = LOC_DBOTTOM2 then Dec(y);
			m := x_screen_loc mod 2;
			for x := 0 to pb.Width div Zoomsize do
			begin
				Draw_FloorTile(floortile+m, x, y);
				m := 1 - m;
			end;
		end;
	end;
end;


procedure TMainForm.Draw_ROMTile(tile, x, y: Integer);
begin
	if tile > 255 then Exit;
	if tile < 0   then Exit;
	TSA.BlitBlock(Pointer(pb.Buffer), tile, x * Zoomsize, y * Zoomsize);
end;


procedure TMainForm.Draw_FloorTile(tile, x, y: Integer);
begin
	if tile > 255 then Exit;
	if tile < 0   then Exit;
	pb.Buffer.Draw(Bounds(x*Zoomsize, y*Zoomsize, Zoomsize, Zoomsize),
		Bounds(tile*16, 0, 16, 16), FloorGfx.Buffer);
	Inc(x, x_screen_loc);
	Inc(y, y_screen_loc);
	if (x < levellimit_x) and (y <= levellimit_y) then
		leveltile[x,y] := floortile[tile];
end;


procedure TMainForm.DrawFrame(x1, y1, x2, y2: Integer; S: String = '');
begin
	x1 := x1 * 16; y1 := y1 * 16;
	x2 := x2 * 16; y2 := y2 * 16;
	Pb.Buffer.FillRectTS(x1, y1, x2, y2, Color32(clBtnFace));
	Pb.Buffer.RaiseRectTS(x1, y1, x2, y2, 100);
	Pb.Buffer.RaiseRectTS(x1+15, y1+15, x2-15, y2-15, -50);
	Pb.Buffer.Font.Name := 'Verdana';
	Pb.Buffer.Font.Size := 8;
	if S = '' then Exit;
	y2 := ((x2 - x1) div 2) - (Pb.Buffer.TextWidth(S) div 2);
	Pb.Buffer.RenderText(x1+y2, y1+1, S, 2, Color32(clBtnText));
end;


procedure TMainForm.DrawFloor;
begin
	if not ROMloaded then Exit;
	if miViewFloor.Checked then
	case level_object_set of
		{OBJSET_HILLY:
			ClearLevel(LOC_TOP,		1);}
		{OBJSET_UNDERGROUND:
			ClearLevel(LOC_TOP,		1);}
		{OBJSET_SKY:
			ClearLevel(LOC_TOP,		1);}
		OBJSET_DUNGEON:
		begin
			ClearLevel(LOC_ALL,		0);
			ClearLevel(LOC_TOP,		1);
			ClearLevel(LOC_TOP2,	2);
			ClearLevel(LOC_DBOTTOM2,3);
			ClearLevel(LOC_DBOTTOM, 5);
		end;
		OBJSET_DESERT:
			ClearLevel(LOC_BOTTOM,	1);
		{OBJSET_ICE:
			ClearLevel(LOC_TOP,		1);}
	end;
end;




procedure TMainForm.DrawMap;
var
	x, y, p_ctr, o3, o: Integer;
begin
	if not ROMloaded then Exit;
	pb.Buffer.Clear(Color32(128,128,128));
	for x := 0 to (15 * (level_bytes div 144)) do
	for y := 0 to 8 do
	begin
		o := maparray[y][x];
		if o > 236 then o := 236;
		Draw_Sprite(Pb, plains_level[0][o].obj_design[0],
			x-x_screen_loc, y-y_screen_loc);
	end;
	{
	o := 0;
	for y := 0 to 15 do
	for x := 0 to 15 do
	begin
		Draw_Sprite(Pb, plains_level[0][o].obj_design[0], x, y+9);
		Inc(o);
		if o >= 236 then Break;
	end;
	}
{
	// Draw map sprites
	if level <> 10 then
	  for x := 0 to 8 do
	  begin
		if map_sprites[x][3] < $11 then o := map_sprites[x][3]+170
			else o := 145 + 257;
		Draw_Sprite(Pb, o,
			map_sprites[x][2] div 16 + map_sprites[x][1] - x_screen_loc,
			map_sprites[x][0] div 16 - 2 - y_screen_loc );
	  end;
}
	// Draw pointers
	o := Trunc(sObjectType.Value);
	for x := 0 to (16 * (level_bytes div 144)-1) do
	 for y := 0 to 8 do
	  for p_ctr := 0 to num_ptrs-1 do
		if (map_ptr_hriz[p_ctr] = x) and (((map_ptr_vert[p_ctr] div 16) - 2) = y) then
		begin
			if p_ctr = o then
				Draw_Sprite(Pb, -12, x-x_screen_loc, y-y_screen_loc)
			else
				Draw_Sprite(Pb, -13, x-x_screen_loc, y-y_screen_loc)
		end;

{
	x := map_ptr_hriz[o];
	y := (map_ptr_vert[o] div 16) - 2;
}
	x := SelObject.x; y := SelObject.y;
	Draw_Sprite(Pb, -14, x-x_screen_loc, y-y_screen_loc);

	o3 := maparray[y][x];
	if o3 > 236 then o3 := 236;
	Info(Format('Tile:%s   X:%.2d   Y:%.2d   %s',
		[IntToHex(maparray[y,x],2), x, y, plains_level[0][o3].obj_descript]), True);

	if level = 10 then
	begin
		Label1.Caption := 'Goes to world ' + IntToStr((map_ptr_vert[o] mod 16) + 1);
		Label2.Caption := '';
		Label3.Caption := '';
	end
	else
	begin
		mapptr_objectset := map_ptr_vert[o] mod 16;
		Label1.Caption := 'Object set: ' + IntToHex(mapptr_objectset, 1)
		+ ' - ' + object_set_pointers[(map_ptr_vert[o] mod 16)+1].type_name;
		// enemy_pointer
		x := (map_ptr_enemies[1][o] * $100) + $10 + map_ptr_enemies[0][o];
		// level_pointer
		y := (map_ptr_levels[1][o] * $100) + map_ptr_levels[0][o] + $10010
		+ object_set_pointers[(map_ptr_vert[o] mod 16)+1].ptr_type;
		mapptr_level := 0;
		mapptr_enemy := 0;
		case map_ptr_vert[o] mod 16 of
		  $F:
		  begin
			Label2.Caption := 'Object data: N/A';
			Label3.Caption := 'Points to Spade House';
		  end;
		  $7:
		  begin
			Label3.Caption := 'Points to Mushroom House';
			Label2.Caption := 'Type: ' + IntToHex(x div $100, 1) +
				' - ' + mushroom_houses[x div $100];
		  end;
		  else
		  begin
			Label3.Caption := 'Enemy data: '  + IntToHex(x, 1);
			Label2.Caption := 'Object data: ' + IntToHex(y, 5);
			mapptr_enemy := x;
			mapptr_level := y;
		  end;
		end;
	end;
	DrawGridlines;
	AdjustScrollbars;
	drawingstate := DS_NONE;
	Pb.Flush;
end;


procedure TMainForm.DrawObjDef;
label break_objed;
const
	objdsc: array[0..48] of string = (
 'Special tile: ', 'None',
 '* Fill tile with background color',
 '* Draw this tile using level bg color as transparency',
 '* Do not draw this tile',
 'Nothing', 'Warning', 'Nothing', 'Pointer', 'Unknown', 'Garbled',
 'Cross', 'Yellow square', 'Square 1', 'Square 2', 'Invisible 1', 'Invisible 2',
 'Flower', 'Leaf', 'Star', 'Green star', 'Movable/multi', '1-up', 'Coin', 'Vine',
 'P-switch', 'Silver coin', 'Invisible coin', 'Invisible 1-up',
 'Nothing', 'Nothing', 'Nothing', 'Nothing',
 'Cross','Up arrow','Down arrow','Left arrow','Right arrow','Up arrow 2',
 'Nothing', 'Nothing', 'Nothing', 'Nothing', 'Door (upper)', 'Door (lower)',
 'Door (upper, disabled)','Door (lower, disabled)','Level end (1)','Level end (2)'
 );
var
	x, y, o, o3, o4, p_ctr: Integer;
begin
	if not ROMloaded then Exit;
	o4 := Trunc(sObjectType.Value);
	p_ctr := Length(plains_level[level_object_set, o4].obj_design);

	Pb.Buffer.Clear(clGray32);
	DrawFrame(0,  0, 18, 18+SPECIALTILEROWS, 'ROM gfx tiles');

	x := plains_level[level_object_set, o4].bmp_width;
	y := plains_level[level_object_set, o4].bmp_height;

	Pb.Buffer.Draw(16, 16, Bounds(0, 0, 256, RomGfx.Height), RomGfx.Buffer);
	DrawFrame(18, 0, 20+x, y+2, 'ROM');
	DrawFrame(20+x, 0, 22+x+x, y+2, 'Rip');

	x := 0; y := 848;
	for o := 0 to 2 do
	begin
		Pb.Buffer.Draw(Rect(16, 16+256+(o*16), 16+256, 32+256+(o*16)),
			Rect(x, y, x+256, y+16), TileGfx.Bitmap);
		Inc(x, 256);
		if x+256 >= TileGfx.Bitmap.Width then begin
			x := 0; Inc(y, 16);
		end;
	end;

	o := 38; x := 16; y := 320;
	while o < 186 do
	begin
		o3 := o + (256 * level_object_set);
		if o = 97  then o := 120;
		if o = 143 then o := 156;
		pb.Buffer.Draw(Bounds(x, y, 16, 16),
			Bounds( (o3 mod 64) * 16, (o3 div 64) * 16, 16, 16), TileGfx.Bitmap);
		Inc(o);
		Inc(x, 16);
		if x > 256 then
		begin
			Inc(y, 16);
			x := 16;
		end;
	end;

	if SelObjTile > (255+(SPECIALTILEROWS*16)) then SelObjTile := 0;
	if SelObjTile < 0 then SelObjTile := (255+(SPECIALTILEROWS*16));
	y := SelObjTile div 16;
	x := SelObjTile - (y*16);
	y := (y+1) * 16;
	x := (x+1) * 16;
	// Draw_Sprite(Pb, -33, x+1, y+1);
	pb.Buffer.FrameRectTS(x-2, y-2, x+18, y+18, clWhite32);
	pb.Buffer.FrameRectTS(x-1, y-1, x+17, y+17, clBlack32);

	if SelObjTile >= 256 then
	begin
		if SelObjTile < (256 + 16*3) then
			Label3.Caption := objdsc[0] + objdsc[SelObjTile-255]
		else
			Label3.Caption := 'Ripped graphic tile';
	end
	else
		Label3.Caption := 'Graphic tile: ' + IntToHex(SelObjTile,2) +
		' (' + IntToStr(SelObjTile) + ')';

	ListBox.Items.Clear;
	ObjdefPanel.Top := Pb.Top + (plains_level[level_object_set, o4].bmp_height+2) * 16;
	ObjdefPanel.Left := 256+33;
	ObjdefPanel.Height := (Pb.Height - sbh) - ObjdefPanel.Top + Pb.Top;

	o3 := 0;
	p_ctr := plains_level[level_object_set, o4].bmp_width;
	for y := 0 to plains_level[level_object_set, o4].bmp_height - 1 do
	for x := 0 to p_ctr - 1 do
	begin
		o := plains_level[level_object_set, o4].rom_obj_design[o3];
		if o > 255 then
		begin
			ListBox.Items.Add('$' + IntToHex(o, 5) + ' = ' +
				IntToHex(Ord(ROMdata[o+1]),2));
			o := Ord(ROMdata[o+1]);
		end
		else
			ListBox.Items.Add(IntToHex(o, 2));
		TSA.BlitBlock(Pointer(Pb.Buffer), o, 256+48+(x*16), 16+(y*16));

		o := plains_level[level_object_set, o4].obj_design_2[o3];
		if o > 0 then Draw_Sprite(Pb, -o, 19+x, 1+y);

		if o3 = ListBox.Tag then Draw_Sprite(Pb, -13, 19+x, 1+y);

		o := plains_level[level_object_set, o4].obj_design[o3];
		if o > 0 then
			Draw_Sprite(Pb, o + (256 * level_object_set), 21+x+p_ctr, y+1);

		Inc(o3);
		if o3 >= Length(plains_level[level_object_set,Trunc(sObjectType.Value)].obj_design)
			then goto break_objed;
	end;

break_objed:
	ListBox.ItemIndex := ListBox.Tag;
	Info(plains_level[level_object_set, o4].obj_descript, True);
	drawingstate := DS_NONE;
	Pb.Flush;
end;


procedure TMainForm.DrawLevel;
var
	{x, y, p_ctr,} o, o3, o4: Integer;
	tbyte_drawn: Boolean;
	//Linecolor: TColor32;
begin
	pbW := pb.Width;
	pbH := pb.Height;

	if fGfxEdit.Showing then
		with fGfxEdit do
		begin
			UpdateView(False);
			UpdatePaletteView;
		end;

	(* draw object design editor *)
	if mode = MODE_EDIT_OBJDEF then
	begin
		DrawObjDef;
		Exit;
	end;

	if mode = MODE_EDIT_MAP then
	begin
		DrawMap;
		Exit;
	end;

	(* draw level *)
	drawingstate := DS_INIT;
	pb.Buffer.BeginUpdate;
{
	if miViewFloor.Checked then
		color_Sky := color_BgTile
	else
		color_Sky := color_Sky_orig;
}
	pb.Buffer.Clear(color_Sky);

	if ROM_gfx then
		TransColor := color_Sky
	else
		TransColor := Color32($FF, $33, $FF);
	AdjustScrollbars;
	tbyte_drawn := False;
	if not miFloorinfront.Checked then DrawFloor;

	if (BgTileIsSolidColor) or (not miViewFloor.Checked) then
	begin
		for o3 := 0 to levellimit_x do
		for o4 := 0 to levellimit_y do
			leveltile[o3, o4] := 0;
	end;

	// the following takes care of clearing the level background
	// and ceiling/floor with the appropriate gfx tiles
	if (miViewFloor.Checked) and (ROMloaded) then
	case level_object_set of
		OBJSET_PLAINS:
			ClearLevel(LOC_ALL,     0);
		OBJSET_HILLY:
			ClearLevel(LOC_ALL,     0); // ClearLevel(LOC_TOP, 1);
		OBJSET_UNDERGROUND:
			ClearLevel(LOC_ALL,     0); // ClearLevel(LOC_TOP, $1A41B);
		OBJSET_SKY:
			ClearLevel(LOC_ALL,     0); // ClearLevel(LOC_TOP, 1);
		OBJSET_DUNGEON:
		begin
			//ClearLevel(LOC_ALL,    0);
			//ClearLevel(LOC_TOP,    1);
			//ClearLevel(LOC_BOTTOM, 2);
		end;
		OBJSET_AIRSHIP:
			ClearLevel(LOC_ALL,     0);
		OBJSET_CLOUDY:
			ClearLevel(LOC_ALL,     0);
		OBJSET_DESERT:
			ClearLevel(LOC_ALL,     0); //ClearLevel(LOC_BOTTOM, 1);
		OBJSET_WATERPIPE:
			ClearLevel(LOC_ALL,     0);
		OBJSET_GIANT:
			ClearLevel(LOC_ALL,     0);
		OBJSET_ICE:
			ClearLevel(LOC_ALL,     0); //ClearLevel(LOC_TOP,    1);
	end;

	// draw objects
	o3 := 0; o4 := 0;
	for o := 0 to (tbyte_objs + fbyte_objs - 1) do
	begin
		blitting_object := o;
		ground_level := 26;
		if objbytes[o] = 3 then
		begin
			if miView3bo.Checked then drawobjs.draw_3byteobjects(o3);
			Inc(o3);
		end
		else
		begin
			if miView4bo.Checked then drawobjs.draw_4byteobjects(o4);
			Inc(o4);
		end;
	end;
	init_objectsizes := False;
	blitting_object := -1;

	if miFloorinfront.Checked then DrawFloor;

	(* draw transparent gridlines *)
	DrawGridlines;

	if not enemymode then
	  if (SelObject.Index >= 0) and (SelObject.Obj <> nil) then
	  begin
		if miViewActiveObjTop.Checked then
		begin
			ground_level := 26;
			if objbytes[SelObject.Index] = 3 then
				draw_3byteobjects(SelObject.SubIndex)
			else
				draw_4byteobjects(SelObject.SubIndex);
		end;
		SelObject.x  := ObjectSize[SelObject.Index].Left;// + x_screen_loc;
		SelObject.x2 := SelObject.x + ObjectSize[SelObject.Index].Width;
		SelObject.y  := ObjectSize[SelObject.Index].Top;// + y_screen_loc;
		SelObject.y2 := SelObject.y + ObjectSize[SelObject.Index].Height;
		if objbytes[SelObject.Index] = 3 then
		pb.Buffer.FrameRectTS(
			((SelObject.x  - x_screen_loc)*Zoomsize)-1, ((SelObject.y  - y_screen_loc)*Zoomsize)-1,
			((SelObject.x2 - x_screen_loc)*Zoomsize)+1, ((SelObject.y2 - y_screen_loc)*Zoomsize)+1,
			COL_RECT_3BYTE)
		else
		pb.Buffer.FrameRectTS(
			((SelObject.x  - x_screen_loc)*Zoomsize)-1, ((SelObject.y  - y_screen_loc)*Zoomsize)-1,
			((SelObject.x2 - x_screen_loc)*Zoomsize)+1, ((SelObject.y2 - y_screen_loc)*Zoomsize)+1,
			COL_RECT_4BYTE);
		pb.Buffer.FrameRectTS(
			((SelObject.x  - x_screen_loc)*Zoomsize), ((SelObject.y  - y_screen_loc)*Zoomsize),
			((SelObject.x2 - x_screen_loc)*Zoomsize), ((SelObject.y2 - y_screen_loc)*Zoomsize),
			COL_RECT_OUTER);
	  end;
	if enemymode then
	  if SelEnemy.Index >= 0 then
	  begin
		{if miViewActiveObjTop.Checked then
			draw_enemies(SelEnemy.Index);}
		SelEnemy.x  := EnemySize[SelEnemy.Index].Left;
		SelEnemy.x2 := SelEnemy.x + EnemyWidth(SelEnemy.Index);
		SelEnemy.y  := EnemySize[SelEnemy.Index].Top;
		SelEnemy.y2 := SelEnemy.y + EnemyHeight(SelEnemy.Index);
		pb.Buffer.FrameRectTS(
			((SelEnemy.x  - x_screen_loc)*Zoomsize)-1, ((SelEnemy.y  - y_screen_loc)*Zoomsize)-1,
			((SelEnemy.x2 - x_screen_loc)*Zoomsize)+1, ((SelEnemy.y2 - y_screen_loc)*Zoomsize)+1,
			COL_RECT_ENEMY);
		pb.Buffer.FrameRectTS(
			((SelEnemy.x  - x_screen_loc)*Zoomsize), ((SelEnemy.y  - y_screen_loc)*Zoomsize),
			((SelEnemy.x2 - x_screen_loc)*Zoomsize), ((SelEnemy.y2 - y_screen_loc)*Zoomsize),
			COL_RECT_OUTER);
	  end;

	// draw enemies
	TransColor := Color32($FF, $33, $FF);
	drawingstate := DS_ENEMY;
	if miViewEnemies.Checked then draw_enemies;
	drawingstate := DS_NONE;

	// all done, update view
	pb.Buffer.EndUpdate;
	pb.Flush;
	TellObjectInfo;
end;

