{*
 *	File reading and writing
 *}

{function TMainForm.FileToString(Filename: string; Maxlen: integer): string;
var
	FStrm: TFileStream;
begin
	Result := '';
	if Filename = '' then Exit;
	if not FileExists(Filename) then Exit;
	try
		FStrm := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
	except
		on EFOpenError do Exit;
	end;
	try
		if Maxlen < 0 then Maxlen := FStrm.Size;
		SetLength(Result, Min(Maxlen, FStrm.Size));
		FStrm.Read(Result[1], Min(Maxlen, FStrm.Size));
	finally
		FStrm.Free;
	end;
end;

procedure TMainForm.StringToFile(Filename: string; var S: string);
var
	OutStream: TMemoryStream;
begin
	OutStream := TMemoryStream.Create;
	OutStream.Write(Pointer(S)^, Length(S));
	OutStream.SaveToFile(Filename);
	OutStream.Free;
end;
}

{*
 *	Per-byte "file" seeking, reading and writing
 *	(operates on a string instead of a file)
 *}

function TMainForm.ROM_Seek(Pos: Integer): Integer;
begin
	Result := 0;
	Inc(Pos, ROM_OffsetBy);
	if Pos > Length(ROMdata) then Result := -1
		else ROM_pos := Pos;
end;

function TMainForm.ROM_GetByte(Pos: Integer = -1): Byte;
var
	K: Boolean;
begin
	if Pos >= 0 then K := (ROM_Seek(Pos)>=0) else K := (ROM_pos<Length(ROMdata));
	if K then Result := Ord(ROMdata[ROM_pos+1])
	else Result := 0;
	Inc(ROM_pos);
end;

procedure TMainForm.ROM_PutByte(B: Byte; Pos: Integer = -1);
begin
	if Pos >= 0 then ROM_Seek(Pos);
	ROMdata[ROM_pos+1] := Chr(B);
	Inc(ROM_pos);
	Debug(IntToHex(B,2) + ' ');
end;


{*
 *	Map loading
 *}

procedure TMainForm.LoadMap;
var
	i, j, k: Integer;
	b: Byte;
	kekkala: array[0..65535] of Byte;
begin
	Loading := True;
	pointer_offset := pointer_tables[level-1].offset;
	num_ptrs := pointer_tables[level-1].num_ptrs;
	level_offset := level_array[level-1].rom_level_offset;
	level_object_set := 0;

	if ROM_Seek(pointer_offset) < 0 then
	begin
		Error('Bad pointer offset!');
		Exit;
	end;
	if level < 9 then
	begin
		for j := 0 to 3 do
		begin
			ROM_Seek(map_enemy_offset + ((level-1) * 9) + (j * $48));
			for i := 0 to 8 do
				map_sprites[i][j] := ROM_GetByte;
		end;
	end;
	i := 0; b := 0;
	if ROM_Seek(level_offset) < 0 then
	begin
		Error('Bad level offset!');
		Exit;
	end;
	while (b <> 255) and (i < 65536) do
	begin
		b := ROM_GetByte;
		if ROM_EOF then
		begin
			Error('Bad level offset!');
			Exit;
		end;
		if (b <> 255) then
		begin
			 kekkala[i] := b;
			 Inc(i);
		end;
	end;
	if i > 65535 then
	begin
		Error('Bad level offset or level too large!');
		Exit;
	end;
	map_sections := i div 144;
	level_bytes := i;
	orig_level_bytes := level_bytes;
	for k := 0 to map_sections - 1 do
		for j := 0 to 8 do
			for i := 0 to 15 do
				maparray[j][(i+(16*k))] := kekkala[(144*k)+((16*j)+i)];
	ROM_Seek(pointer_offset);
	for i := 0 to num_ptrs - 1 do
	begin
		b := ROM_GetByte;
		if ROM_EOF then
		begin
			Error('Bad pointer offset!');
			Exit;
		end;
		map_ptr_vert[i] := b;
	end;
	for i := 0 to num_ptrs - 1 do
	begin
		b := ROM_GetByte;
		if ROM_EOF then
		begin
			Error('Bad pointer offset!');
			Exit;
		end;
		map_ptr_hriz[i] := b;
	end;
	if level <> 10 then
	begin
		for i := 0 to (num_ptrs * 2)-1 do
			map_ptr_enemies[i mod 2][i div 2] := ROM_GetByte;
		for i := 0 to (num_ptrs * 2)-1 do
			map_ptr_levels[i mod 2][i div 2]  := ROM_GetByte;
	end;
	sObjectType.Value := 0;
	sObjectType.MaxValue := num_ptrs-1;
	sObjectType.Enabled := True;
	sObjectSet.Enabled := False;
	sObjectLength.Enabled := False;
	SelObject.x := 0;
	SelObject.y := 0;

	InfoLabel.Hint := ' Map offset: ' + IntToHex(level_offset, 5) +
	'   Pointers: ' + IntToStr(num_ptrs);

	Label1.Font.Color := clWindowText;
	Label2.Font.Color := clWindowText;
	Label3.Font.Color := clWindowText;

	vertical_flag := False;
	levelmodified := False;
	x_screen_loc := 0;
	y_screen_loc := 0;
	levellimit_x := (15 * (level_bytes div 144))+1;
	levellimit_y := 8;
	if ROM_gfx then
		LoadRomObjDefs(False);
	GetPalette;
	Loading := False;
	ModeChanged;
end;


{*
 *	Level loading
 *}
procedure TMainForm.LoadLevel(os_level, os_enemy: Integer);
label
	EnemyError,
	EnemyDone;
var
	temp_buf: array[0..3] of Integer;
	b, i, temp_domain, temp_test,
	byte_counter, object_section_counter,
	object_flag, oldobject_flag,
	any_object_counter, enemy_byte_counter,
	enemy_obj_counter, fbyte_obj_counter,
	old_offset, tbyte_obj_counter: Integer;
	//objSlist_3, objSlist_4: TStringList;
	oL, oE: Integer;
	bl: Boolean;
begin
	color_FillSky := Color32($A0, $B0, $F0);
	//objSlist_3 := TStringList.Create;
	//objSlist_4 := TStringList.Create;
	levelmodified := False;
	LogMemo.Lines.Clear;
	Loading := True;
	mode := MODE_EDIT_LEVEL;
{
	World := _World;
	Level := _Level;
}

	if os_level < 0 then
	begin
		header_offset := 3;
		level_offset := 12;
		enemy_offset := 0;
		ROM_Seek(0);
		World := ROM_GetByte;
		Level := ROM_GetByte;
		real_level_object_set := ROM_GetByte;
		level_object_set := convert_object_sets(real_level_object_set);
	end
	else
	begin
		level_offset := os_level;
		enemy_offset := os_enemy;
		if SMAS then
			header_offset := level_offset + $2
		else
			header_offset := level_offset - $9;
		if SMAS then
		begin
			Inc(level_offset, $D);
			Inc(enemy_offset);
		end;
		World := fSelectLevel.ListBox1.ItemIndex;
		Level := fSelectLevel.ListBox2.ItemIndex + 1;
		if World = 0 then
			level_index_number := Level - 1
		else
			level_index_number := WORLD_INDEXES[World] + Level;
		real_level_object_set := level_array[level_index_number].real_obj_set;
	end;
	{
	level_offset := level_array[level_index_number].rom_level_offset;
	enemy_offset := level_array[level_index_number].enemy_offset;
	}

	// 6025 doing Phase
	SelObject.Obj := nil;
	SelObject.Index := -1;
	number_of_level_sections := 0;
	byte_counter := 0;
	enemy_byte_counter := 0;
	any_object_counter := 0;
	fbyte_obj_counter := 0;
	tbyte_obj_counter := 0;
	enemy_obj_counter := 0;
	object_section_counter := 0;
	oldobject_flag := 0;
	b := 0;

	ROM_seek(header_offset);
	for i := 1 to 9 do header[i] := ROM_GetByte;

	// level_array[level_index_number].real_obj_set
	if os_enemy >= 0 then
	level_object_set := convert_object_sets(fSelectLevel.cbObjectSet.ItemIndex+1);

	i := header[8] and 31;	// level graphic set
	// showmessage(inttostr(i));
	(*
	if object set is Underground, make sure graphic set is
	also Underground, otherwise use Hilly graphic set
	*)
	if i = 3 then
		level_object_set := OBJSET_UNDERGROUND;
	if i = 20 then i := 1;

	if level_object_set = OBJSET_UNDERGROUND then
		if i <> 3 then
			level_object_set := OBJSET_HILLY;

	{showmessage(inttohex(header[7],and 15));
	level_object_set := convert_object_sets(header[7] and 15);}


// *** Testing phase ***

	ROM_seek(level_offset);
	while ((b <> $FF) and (byte_counter < 65536)) do
	begin
		old_offset := level_offset + byte_counter;
		ROM_seek(old_offset);
		for i := 0 to 3 do
		begin
			temp_buf[i] := ROM_GetByte;
			if ROM_EOF then
			begin
				Error('Bad level offset!');
				Exit;
			end;
			if temp_buf[0] = $FF then Break;
		end;
		b := temp_buf[0];
		if b <> $FF then
		begin
			temp_domain := temp_buf[0] div 32;
			temp_test   := temp_buf[2] div 16;
			Inc(byte_counter, object_ranges[level_object_set][temp_domain+1][temp_test+1]);
		end;
	end;
	if byte_counter >= 65536 then
	begin
		Error('Bad level offset or level too large!');
		Exit;
	end;

	if os_enemy < 0 then enemy_offset := ROM_Pos+1;

	byte_counter := 0;
	enemy_byte_counter := 0;
	b := 0;

// *** Doing phase ***

	while ((b <> 255) and (byte_counter < 65536)) do
	begin
		ROM_Seek(level_offset + byte_counter);
		for i := 0 to 3 do
		begin
			temp_buf[i] := ROM_GetByte;
			if ROM_EOF then
			begin
				Error('Bad level offset!');
				Exit;
			end;
			if temp_buf[0] = 255 then Break;
		end;
		b := temp_buf[0];
		if b <> 255 then
		begin
			temp_domain := temp_buf[0] div 32;
			temp_test   := temp_buf[2] div 16;
			object_flag := object_ranges[level_object_set, temp_domain+1, temp_test+1];
			if oldobject_flag <> object_flag then
			begin
				if byte_counter > 0 then
begin
					object_ordering[number_of_level_sections-1] :=
						object_section_counter;
Log(format('object_ordering %d = %d', [number_of_level_sections-1,object_section_counter]));
end;
				object_section_counter := 0;
				oldobject_flag := object_flag;
				Inc(number_of_level_sections);
			end;
			if object_flag = 3 then
			begin
				objbytes[any_object_counter] := 3;
				for i := 0 to 2 do
					tbyte_array[i, tbyte_obj_counter] := temp_buf[i];
				object_numbers_3[tbyte_obj_counter] := any_object_counter;
				//objSlist_3.Add(Format('%.3d%.3d %.3d', [temp_domain, temp_test, tbyte_obj_counter]));
				Inc(tbyte_obj_counter);
			end
			else	// object_flag = 4
			begin
				objbytes[any_object_counter] := 4;
				for i := 0 to 3 do
					fbyte_array[i, fbyte_obj_counter] := temp_buf[i];
				object_numbers_4[fbyte_obj_counter] := any_object_counter;
				//objSlist_4.Add(Format('%.3d%.3d %.3d', [temp_domain, temp_test, fbyte_obj_counter]));
				Inc(fbyte_obj_counter);
			end;
			if byte_counter = 0 then the_first_object := object_flag;
			Inc(byte_counter, object_flag);
			Inc(object_section_counter);
			Inc(any_object_counter);
		end;
	end;

	object_ordering[number_of_level_sections-1] := object_section_counter;
Log(format('object_ordering %d = %d', [number_of_level_sections-1,object_section_counter]));

	if byte_counter >= 65536 then
	begin
		Error('Bad level offset or level too large!');
		Exit;
	end;

	level_bytes := byte_counter;
	orig_level_bytes := level_bytes;
	fbyte_objs := fbyte_obj_counter;
	tbyte_objs := tbyte_obj_counter;
	enemy_byte_counter := 0;

	if enemy_offset > 0 then
	begin
		ROM_seek(enemy_offset);
		if ROM_EOF then
		begin
			Error('Bad enemy offset - unexpected end of file!');
			goto EnemyError;
		end;
		b := Ord(ROMdata[enemy_offset]);
		while ((b <> 255) and (enemy_byte_counter < 65536)) do
		begin
			for i := 0 to 2 do
			begin
				temp_buf[i] := ROM_GetByte;
//showmessage(inttohex(temp_buf[i],2));
				if ROM_EOF then
				begin
					Error('Bad enemy offset - unexpected end of file!');
					goto EnemyError;
				end;
				if temp_buf[0] = 255 then Break;
			end;
			b := temp_buf[0];
			if b <> 255 then
			begin
				for i := 0 to 2 do
					enemy_array[i, enemy_obj_counter] := temp_buf[i];
				Inc(enemy_obj_counter);
				Inc(enemy_byte_counter, 3);
			end;
		end;
		if enemy_byte_counter >= 65536 then
		begin
			Error('Bad enemy offset or enemy data too large!');
			goto EnemyError;
		end;
	end;
	enemy_bytes := enemy_byte_counter;
	enemy_objs  := enemy_obj_counter;
	goto EnemyDone;

EnemyError:
	enemy_offset := 0;

EnemyDone:
	if enemy_offset = 0 then
	begin
		enemy_bytes := 0;
		enemy_objs  := 0;
	end;
	orig_enemy_bytes := enemy_bytes;
	vertical_flag := False;
	if World > 0 then
		if ((header[7] div 16) mod 2) = 1 then
			//if not SMAS then
				vertical_flag := True;
	x_screen_loc := 0;
	y_screen_loc := 0;

	for i := 0 to enemy_objs do
		GetEnemySize(i);

	ff_number_of_level_sections := number_of_level_sections;
	init_objectsizes := True;
	UpdateLevelInfo;

	if vertical_flag then levellimit_x := $10 else
		levellimit_x := ((header[5] and 15) + 1) * $10;
	if not vertical_flag then levellimit_y := $1F-5 else
		levellimit_y := ((header[5] and 15) + 1) * $10;

	SetLength(leveltile, levellimit_x+1, levellimit_y+1);


	ff_oldobject_flag := 4;
	if (the_first_object = 3) and (ff_number_of_level_sections mod 2 = 1)
		then ff_oldobject_flag := 3;
	if (the_first_object = 4) and (ff_number_of_level_sections mod 2 = 0)
		then ff_oldobject_flag := 3;


	if (ROMloaded) and (not SMAS) then
		ROM_gfx := miROMgfx.Checked
	else ROM_gfx := False;

	//if not Loading then
	//	if ROMgfx then
	LoadGfx;

	(* prepare floor/ceiling/bg tile gfx *)
	if ROMloaded then
	if not SMAS then
	case level_object_set of
		OBJSET_PLAINS:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$1E41B+1]), 0, 0);
		end;
		OBJSET_HILLY:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$20427+1]), 0, 0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2041B+1]), 16,0);
		end;
		OBJSET_UNDERGROUND:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$1A427+1]), 0, 0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$1A41B+1]), 16,0);
			for i := 0 to tbyte_objs - 1 do
			if tbyte_array[2][i] = $E then	// starry bg
			if (tbyte_array[0][i] div 32) = 2 then
			begin
				TSA.BlitBlock(Pointer(FloorGfx.Buffer), $C1, 0, 0);
				Break;
			end;
		end;
		OBJSET_SKY:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$22429+1]), 0, 0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$22420+1]), 16,0);
		end;
		OBJSET_DUNGEON:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A437+1]), 0, 0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A420+1]), 16,0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A42E+1]),	32,0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A443+1]), 48,0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A449+1]), 64,0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A453+1]), 80,0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2A459+1]), 96,0);
		end;
		OBJSET_AIRSHIP:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2E41B+1]), 0, 0);
		end;
		OBJSET_CLOUDY:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2642C+1]), 0, 0);
		end;
		OBJSET_DESERT:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2841B+1]), 0, 0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$28427+1]), 16,0);
		end;
		OBJSET_WATERPIPE:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2441B+1]), 0, 0);
		end;
		OBJSET_GIANT:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$2641B+1]), 0, 0);
		end;
		OBJSET_ICE:
		begin
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$22429+1]), 0, 0);
			TSA.BlitBlock(Pointer(FloorGfx.Buffer), Ord(ROMdata[$22420+1]), 16,0);
		end;
	end;
	FloorGfx.Flush;

	if enemy_offset > 0 then
		i := enemy_offset - 1
	else i := 0;
	InfoLabel.Hint := ' Level offset: ' + IntToHex(Max(level_offset-9,0), 5) +
	'   Enemy offset: ' + IntToHex(i, 4);

	if SMAS then
	begin
		Dec(level_offset, $D);
		Dec(enemy_offset);
	end;

//	sObjectType.MaxValue := 255;
	LoadRomObjDefs(not ROM_gfx);

	GetPalette;
	GetBgTileSolidColor;

	DrawLevel;
	init_objectsizes := True;
	drawingstate := DS_ENEMY;
	Loading := False;
	draw_enemies;
	init_objectsizes := False;
	drawingstate := DS_NONE;
	if fPalette.Visible then EditPaletteExecute(miLevel);
	miROMgfx.Enabled := (ROMloaded) and (not SMAS);
	miEdPalette.Enabled := (ROMloaded) and (not SMAS);
	miEdObjdefs.Enabled := (ROMloaded) and (not SMAS);
	ModeChanged(False);

	bl := False;
	if mode = MODE_EDIT_LEVEL then
	begin
		i := header[7] and 15 - 1;
		oL := header[2] * $100 + header[1] +
			object_set_pointers[(header[7] mod 16)+1].ptr_type + $10010;
		if (oL >= object_set_pointers[i+2].ptr_min)
			and (oL <= object_set_pointers[i+2].ptr_max)
		then bl := True;
	end;
	GotoNextarea.Enabled := bl;
end;


procedure LoadLevelEasy(W, L: byte);
begin
	with fSelectLevel do
	begin
		ListBox1.ItemIndex := W;
		ListBox2.ItemIndex := L;
		ListBox1Click(ListBox1);
		ListBox2Click(ListBox2);
		if W > 0 then
			MainForm.LoadLevel(seOffset.AsInteger+9,
				seEnemy.AsInteger+1)
		else
			MainForm.LoadMap;
	end;
end;


procedure TMainForm.LoadRomObjDefs(ToROM: Boolean = True);
var
	O, L, I, P, K, odl, obs: Integer;
	S: String;
begin
	S := GetConfigFile('romobjs' + IntToStr(level_object_set) +'.dat');
	S := FileToString(S, -1);
	if S = '' then Exit;
	obs := Ord(S[1]);
	if obs < $F7 then
	begin
		obs := $FF;
		P := 1;
	end else
		P := 2;
	for O := 0 to obs do
	begin
		odl := plains_level[level_object_set, O].obj_design_length;
		L := Ord(S[P]);
		if ToROM then
		begin
			if L > odl then
				SetLength(plains_level[level_object_set, O].rom_obj_design, L)
		end
		else
			SetLength(plains_level[level_object_set, O].obj_design, L);
		SetLength(plains_level[level_object_set, O].obj_design_2, L);
		Inc(P);
		for I := 0 to L - 1 do
		begin
			if I > odl then Break;
			K := Ord(S[P]);
			if K = 255 then
			begin
				K := (Ord(S[P+1]) shl 16) + (Ord(S[P+2]) shl 8) + Ord(S[P+3]);
				Inc(P, 3);
			end;
			if ToROM then
				plains_level[level_object_set, O].rom_obj_design[I] := K
			else
				plains_level[level_object_set, O].obj_design[I] := K;
			Inc(P);
		end;
	end;
	if P >= Length(S) then Exit;
	// read overlay data
	for O := 0 to obs do
	begin
		L := Length(plains_level[level_object_set, O].obj_design_2);
		odl := plains_level[level_object_set, O].obj_design_length;
		for I := 0 to L - 1 do
		begin
			if I <= odl then begin
			  plains_level[level_object_set, O].obj_design_2[I] := Ord(S[P]);
			Inc(P); end;
		end;
	end;
end;

procedure TMainForm.SaveRomObjDefs;
var
	O, I, L, K: Integer;
	S: String;
begin
	S := Chr(247);
	for O := 0 to 247 do
	begin
		L := Length(plains_level[level_object_set, O].rom_obj_design);
		S := S + Chr(L);
		for I := 0 to L - 1 do
		begin
			K := plains_level[level_object_set, O].rom_obj_design[I];
			if K < 255 then
				S := S + Chr(K)
			else
			begin
				S := S + Chr(255) +
				Chr(K shr 16 and 255) + Chr(K shr 8 and 255) + Chr(K and 255);
			end;
		end;
	end;
	for O := 0 to 247 do
	begin
		L := Length(plains_level[level_object_set, O].rom_obj_design);
		for I := 0 to L-1 do
		  S := S + Chr(plains_level[level_object_set, O].obj_design_2[I]);
	end;
	StringToFile(DataDir + RomDir + 'romobjs' + IntToStr(level_object_set) +'.dat', S);
end;


procedure TMainForm.SaveMap;
var
	k, j, i: Integer;
begin
	if mode <> MODE_EDIT_MAP then Exit;
	pointer_offset := pointer_tables[level-1].offset;
	level_offset := level_array[level-1].rom_level_offset;
	if ROM_Seek(level_offset) < 0 then
	begin
		Error('Save error: Bad level offset!');
		Exit;
	end;

	if level <> 10 then
	begin
		for j := 0 to 3 do
		begin
			ROM_Seek(map_enemy_offset + ((level - 1) * 9) + (j * 72));
			for i := 0 to 8 do
				ROM_PutByte(map_sprites[i][j]);
		end;
	end;

	ROM_Seek(pointer_offset);
	for j := 0 to num_ptrs-1 do
		ROM_PutByte(map_ptr_vert[j]);
	for j := 0 to num_ptrs-1 do
		ROM_PutByte(map_ptr_hriz[j]);

	if level <> 10 then
	begin
		for i := 0 to (num_ptrs * 2)-1 do
			ROM_PutByte(map_ptr_enemies[i mod 2][i div 2]);
		for i := 0 to (num_ptrs * 2)-1 do
			ROM_PutByte(map_ptr_levels[i mod 2][i div 2]);
	end;

	for k := 0 to (level_bytes div 144)-1 do
		for j := 0 to 8 do
			for i := 0 to 15 do
				ROM_PutByte(maparray[j][(i+(16*k))], level_offset+((144*k)+((16*j)+i)));

	StringToFile(ROMfilename, ROMdata);
	levelmodified := False;
	Info('Save: wrote ' + IntToStr(ROM_Pos - level_offset) + ' bytes of mapdata.');
end;


procedure TMainForm.SaveROMGraphics;
var
	i: Integer;
begin
	if GraphicsModified then
	begin
		if MainForm.World > 0 then
		begin
			i := tsaobjset[level_object_set-1];
			SaveMetaTable(patternTableMT, 128, graphicsOffsets[i]);
			SaveMetaTable(commonTableMT,  128, commonOffsets[i]);
		end
		else
		begin
			i := MainForm.Level - 2;
			SaveMetaTable(patternTableMT, 128, graphicsOffsets[$e+i]);
			SaveMetaTable(commonTableMT,  128, commonOffsets[$e+i]);
		end;
		GraphicsModified := False;
	end;
end;


procedure TMainForm.SaveLevel(ToM3L: Boolean = False);
var
	byte_counter, tbyte_obj_counter, fbyte_obj_counter,
	i, j, k: Integer;
	ListE: TStrings;
	L3, L4, LE: array of Integer;
	S: string;
	orig_romdata: String;
begin
	SaveROMGraphics;

	if mode = MODE_EDIT_MAP then
	begin
		SaveMap;
		Exit;
	end;

	if miFreeform.Checked then
		number_of_level_sections := ff_number_of_level_sections;

	if ToM3L then
	begin
		if ROMloaded then
			orig_romdata := ROMdata;
		SetLength(ROMdata, 15+level_bytes+enemy_bytes);
		ROM_Seek(0);
		ROM_PutByte(World);
		ROM_PutByte(Level);
		ROM_PutByte(real_level_object_set);
	end
	else
		ROM_Seek(header_offset);

	Log('Writing header and leveldata...');
	for k := 1 to 9 do
		ROM_PutByte(header[k]);

	ListE := TStringList.Create;
	S := '%.3d %.3d %.3d';
	for i := 0 to enemy_objs-1 do
	begin
		if not vertical_flag then
		 ListE.Add(Format(S, [enemy_array[1][i], enemy_array[2][i], i]))
		else
		 ListE.Add(Format(S, [Trunc(enemy_array[1][i]/10), enemy_array[2][i], i]));
	end;
	TStringList(ListE).Sort;

	SetLength(L3, tbyte_objs+1);
	SetLength(L4, fbyte_objs+1);
	SetLength(LE, enemy_objs);

	for i := 0 to tbyte_objs do
		L3[i] := i;
	for i := 0 to fbyte_objs do
		L4[i] := i;
	for i := 0 to enemy_objs-1 do
		LE[i] := StrToInt(ExtractWord(3, ListE.Strings[i], [' ']));
	ListE.Free;

	byte_counter := 0;
	tbyte_obj_counter := 0;
	fbyte_obj_counter := 0;
	Debug();

	if not ToM3L then
		ROM_Seek(level_offset);

	for i := 0 to number_of_level_sections - 1 do
	begin
		if the_first_object = 3 then
		begin
			if (i mod 2) = 0 then
			begin
				for j := 0 to object_ordering[i] - 1 do
				begin
				Debug('3-BYTE object: ');
					for k := 0 to 2 do
						ROM_PutByte(tbyte_array[k][L3[tbyte_obj_counter]]);
					Inc(tbyte_obj_counter);
					Inc(byte_counter, 3);
				Debug();
				end;
			end
			else // if (i mod 2) = 1 then
			begin
				for j := 0 to object_ordering[i] - 1 do
				begin
				Debug('4-BYTE object: ');
					for k := 0 to 3 do
						ROM_PutByte(fbyte_array[k][L4[fbyte_obj_counter]]);
					Inc(fbyte_obj_counter);
					Inc(byte_counter, 4);
				Debug();
				end;
			end;
		end
		else
		begin
			if (i mod 2) = 1 then
			begin
				for j := 0 to object_ordering[i] - 1 do
				begin
				Debug('3-BYTE OBJECT: ');
					for k := 0 to 2 do
						ROM_PutByte(tbyte_array[k][L3[tbyte_obj_counter]]);
					Inc(tbyte_obj_counter);
					Inc(byte_counter, 3);
				Debug();
				end;
			end
			else // if (i mod 2) = 0 then
			begin
				for j := 0 to object_ordering[i] - 1 do
				begin
				Debug('4-BYTE OBJECT: ');
					for k := 0 to 3 do
						ROM_PutByte(fbyte_array[k][L4[fbyte_obj_counter]]);
				Debug();
					Inc(fbyte_obj_counter);
					Inc(byte_counter, 4);
				end;
			end;
		end;
	end;
	ROM_PutByte($FF);

	(* save enemy data (sorted by X loc *)
	if not ToM3L then
		ROM_Seek(enemy_offset)
	else
		ROM_PutByte($01);

	for j := 0 to enemy_objs-1 do
	  for k := 0 to 2 do
		ROM_PutByte(enemy_array[k][LE[j]]);
	ROM_PutByte($FF);

	StringToFile(ROMfilename, ROMdata);
	levelmodified := False;
	Info('Save: wrote ' + IntToStr(byte_counter) + ' bytes of leveldata.');

	if ToM3L then
		if ROMloaded then
			ROMdata := orig_romdata;
end;

