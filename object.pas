procedure TMainForm.Move_Object(X, Y: Integer; Limit: Boolean = True);
var
	xx, yy, domain, a: Integer;
	ibp: Boolean;
begin
	if SelObject.Index < 0 then Exit;
	if (X = SelObject.Drag.X) and (Y = SelObject.Drag.Y) then Exit;

	SelObject.Drag.X := X;
	SelObject.Drag.Y := Y;

	X := X - SelObject.Drag.osX;
	Y := Y - SelObject.Drag.osY;
	ibp := isBlockPlatform(level_object_set, SelObject.objtype);
	if ibp then Dec(levellimit_y);
	xx := X + ObjectSize[SelObject.Index].HandleX;
	yy := Y + ObjectSize[SelObject.Index].HandleY;
	if Limit then
	begin
		if yy < 0 then Y := 0 - ObjectSize[SelObject.Index].HandleY;
		if xx < 0 then X := 0 - ObjectSize[SelObject.Index].HandleX;
		if yy >  levellimit_y-1 then Y := levellimit_y;
		if xx >= levellimit_x   then X := levellimit_x-1;
	end;
	xx := X + ObjectSize[SelObject.Index].HandleX;
	yy := Y + ObjectSize[SelObject.Index].HandleY;
	if Limit then
		if yy > levellimit_y then yy := levellimit_y;
	if ibp then Inc(levellimit_y);

	if SelObject.Obj.orientation = EXT_SKY then
	begin
		Y := SelObject.Drag.Y;
		if Y < 0 then Y := 0;
		if Y > levellimit_y then Y := levellimit_y;
		yy := Y;
	end
	else
	if SelObject.Obj.orientation = ENDING then
	begin
		if X > $E0 then X := $E0;
	end;

	SelObject.x := X;
	SelObject.y := Y;
	with ObjectSize[SelObject.Index] do
	begin
		Left  := X;
		Right := X + ObjectSize[SelObject.Index].Width - 1;
		Top   := Y;
		Bottom:= Y + ObjectSize[SelObject.Index].Height - 1;
	end;

	a := SelObject.SubIndex;
	if objbytes[SelObject.Index] = 3 then
	begin
		domain := tbyte_array[0, a] div 32;
		if vertical_flag then
		begin
			tbyte_array[1,a] := (xx + ((yy div 15) * 16));
			tbyte_array[0,a] := (yy mod 15) + (domain * 32);
		end	else
		begin
			tbyte_array[1,a] := xx;
			tbyte_array[0,a] := yy + (domain * 32);
		end;
	end else
	begin
		domain := fbyte_array[0, a] div 32;
		if vertical_flag then
		begin
			fbyte_array[1,a] := (xx + ((yy div 15) * 16));
			fbyte_array[0,a] := (yy mod 15) + (domain * 32);
		end	else
		begin
			fbyte_array[1,a] := xx;
			fbyte_array[0,a] := yy + (domain * 32);
		end;
	end;

	levelmodified := True;
	DrawLevel;
end;


procedure TMainForm.Move_Enemy(X, Y: Integer);
begin
	if SelEnemy.Index < 0 then Exit;
	if (X <> SelEnemy.Drag.X) or (Y <> SelEnemy.Drag.Y) then
	begin
		SelEnemy.Drag.X := X;
		SelEnemy.Drag.Y := Y;
		X := X - SelEnemy.Drag.osX;
		Y := Y - SelEnemy.Drag.osY;
		if Y < 0 then Y := 0;
		if X < 0 then X := 0;
		//if Y >= levellimit_y then Y := levellimit_y;
		if X >= levellimit_x then X := levellimit_x-1;
		SelEnemy.x := X;
		SelEnemy.y := Y;
		with EnemySize[SelEnemy.Index] do
		begin
			Left  := X;
			Right := X + EnemyWidth(SelEnemy.Index) - 1;
			Top   := Y;
			Bottom:= Y + EnemyHeight(SelEnemy.Index) - 1;
		end;
		// update enemy bytedatas
		enemy_array[1,SelEnemy.Index] := X - enemyhandle_x[enemy_array[0, SelEnemy.Index]] + EnemySize[SelEnemy.Index].HandleX;
		enemy_array[2,SelEnemy.Index] := Y - enemyhandle_y[enemy_array[0, SelEnemy.Index]];
		levelmodified := True;
		DrawLevel;
	end;
end;


procedure TMainForm.Change_Object_Type(B, T, L: Integer; Sender: TObject);
var
	m, obj: Integer;
begin
	if SelObject.Index < 0     then Exit;
	if SelObject.SubIndex < 0  then Exit;
	if SelObject.Obj = nil     then Exit;

	if Sender is TBMSpinEdit then
	  if Sender <> sObjectSet then
		UpdateEditValue(Sender as TBMSpinEdit);

	ObjectSize[blitting_object].Right  := ObjectSize[blitting_object].Left + 1;
	ObjectSize[blitting_object].Bottom := ObjectSize[blitting_object].Top  + 1;
	plains_level[level_object_set, SelObject.objtype].obj_domain := B;
	m := SelObject.SubIndex;

	//if SelObject.Obj.obj_flag = THREE_BYTE then
	if objbytes[SelObject.Index] = 3 then
	begin {
		if tbyte_array[2, SelObject.SubIndex] < 0 then
		begin
			tbyte_array[2,SelObject.SubIndex] := 255;
			tbyte_array[0,SelObject.SubIndex] := tbyte_array[0,SelObject.SubIndex] - 32;
		end; }

		if (tbyte_array[2,m] < 16) then
			obj := tbyte_array[2,m] + ((tbyte_array[0,m] div 32) * 31)
		else
			obj := ((tbyte_array[2,m] div 16) + (((tbyte_array[0,m] div 32) * 31) + 16)) - 1;

		tbyte_array[2, SelObject.SubIndex] := T;
			tbyte_array[0,SelObject.SubIndex] := (B shl 5) +
			 ((tbyte_array[0,SelObject.SubIndex]) and 31);

		bEditPointer.Visible := sObjectSet.Value = 7;
	end
	else
	begin {
		if fbyte_array[2, SelObject.SubIndex] < 0 then
		begin
			fbyte_array[2,SelObject.SubIndex] := 255;
			fbyte_array[0,SelObject.SubIndex] := fbyte_array[0,SelObject.SubIndex] - 32;
		end; }
		obj := ((fbyte_array[2,m] div 16) + (((fbyte_array[0,m] div 32) * 31) + 16)) - 1;

		fbyte_array[2, SelObject.SubIndex] := T;
		fbyte_array[3, SelObject.SubIndex] := L;
			fbyte_array[0,SelObject.SubIndex] := (B shl 5) +
			 ((fbyte_array[0,SelObject.SubIndex]) and 31);
	end;

	SelObject.objtype := T;
	SelObject.Obj := @plains_level[level_object_set, obj];

	(* another stupid hack to find out new size of the object *)
	objectsizeinit_prev := -1;
	init_objectsizes := True;
	blitting_object := SelObject.Index;
	ground_level := 26;
	if objbytes[SelObject.Index] = 3 then
		draw_3byteobjects(SelObject.SubIndex)
	else
		draw_4byteobjects(SelObject.SubIndex);
	init_objectsizes := False;
	DrawLevel;
end;


procedure TMainForm.Change_Enemy_Type(T: Integer);
begin
	if SelEnemy.Index < 0 then Exit;
	enemy_array[0, SelEnemy.Index] := T;
	(* stupid hack to find out new size of the enemy *)
{
	drawingstate := DS_ENEMY;
	objectsizeinit_prev := -1;
	init_objectsizes := True;
	blitting_object := SelEnemy.Index;
	ground_level := 26;
	draw_enemies;
	init_objectsizes := False;
	drawingstate := DS_NONE;
}
	GetEnemySize(SelEnemy.Index);
	DrawLevel;
end;


procedure TMainForm.AddEnemy(x, y: Integer);
begin
	if enemy_objs > (65536 div 3) then Exit;
	if cloneobjarray[0] = 1 then
		enemy_array[0][enemy_objs] := cloneobjarray[1]
	else
		enemy_array[0][enemy_objs] := $72;
	enemy_array[1][enemy_objs] := x;
	enemy_array[2][enemy_objs] := y;
	Inc(enemy_bytes, 3);
	GetEnemySize(enemy_objs);
	Inc(enemy_objs);
end;

procedure TMainForm.AddObject_3byte(x, y: Integer);
begin
	if tbyte_objs >= (65536 div 3) then Exit;
	if (y > 27) and (vertical_flag = False) then y := 27;
	if (x > 15) and (vertical_flag) then x := 15;
	tbyte_array[0][tbyte_objs] := y;
	tbyte_array[1][tbyte_objs] := x;
	if cloneobjarray[0] = 3 then
	begin
		tbyte_array[2][tbyte_objs] := cloneobjarray[3];
		tbyte_array[0,tbyte_objs] := (cloneobjarray[1] shl 5) +
			((tbyte_array[0,tbyte_objs]) and 31);
	end
	else
		tbyte_array[2][tbyte_objs] := 0;
	Inc(tbyte_objs);
	objbytes[tbyte_objs + fbyte_objs - 1] := 3;
	if level_bytes <= 0 then
	begin
		the_first_object := 3;
		ff_number_of_level_sections := 0;
		ff_oldobject_flag := 0;
	end;
	Inc(level_bytes, 3);
	ff_object_flag := 3;
	if (ff_oldobject_flag <> ff_object_flag) then
	begin
		ff_oldobject_flag := ff_object_flag;
		Inc(ff_number_of_level_sections);
		object_ordering[ff_number_of_level_sections-1] := 1;
	end
	else
	Inc(object_ordering[ff_number_of_level_sections-1]);
	levelmodified := True;
end;

procedure TMainForm.AddObject_4byte(x, y: Integer);
begin
	if fbyte_objs >= (65536 div 4) then Exit;
	if (y > 27) and (vertical_flag = False) then y := 27;
	if (x > 15) and (vertical_flag) then x := 15;
	fbyte_array[0][fbyte_objs] := y + 64;
	fbyte_array[1][fbyte_objs] := x;
	if cloneobjarray[0] = 4 then
	begin
		fbyte_array[2][fbyte_objs] := cloneobjarray[3];
		fbyte_array[3][fbyte_objs] := cloneobjarray[4];
		fbyte_array[0,fbyte_objs] := (cloneobjarray[1] shl 5) +
			((fbyte_array[0,fbyte_objs]) and 31);
	end
	else
	begin
		fbyte_array[2][fbyte_objs] := $B0;
		fbyte_array[3][fbyte_objs] := 0;
	end;
	Inc(fbyte_objs);
	objbytes[tbyte_objs + fbyte_objs - 1] := 4;
	if level_bytes <= 0 then
	begin
		the_first_object := 4;
		ff_number_of_level_sections := 0;
		ff_oldobject_flag := 0;
	end;
	Inc(level_bytes, 4);
	ff_object_flag := 4;
	if (ff_oldobject_flag <> ff_object_flag) then
	begin
		ff_oldobject_flag := ff_object_flag;
		Inc(ff_number_of_level_sections);
		object_ordering[ff_number_of_level_sections-1] := 1;
	end
	else
	Inc(object_ordering[ff_number_of_level_sections-1]);
	levelmodified := True;
end;


procedure Delete_Enemy(e: Integer);
var
	i: Integer;
begin
	for i := e to enemy_objs - 1 do
	begin
		enemy_array[0][i] := enemy_array[0][i+1];
		enemy_array[1][i] := enemy_array[1][i+1];
		enemy_array[2][i] := enemy_array[2][i+1];
		EnemySize[i] := EnemySize[i+1];
	end;
	Dec(enemy_bytes, 3);
	Dec(enemy_objs);
	levelmodified := True;
end;


procedure Delete_Object(bytes, o: Integer);
label
	DelObjDone;
var
	v1,v2, i, j, index, object_counter: Integer;
begin
	object_counter := 0;

	if the_first_object = bytes then
	begin
		v1 := 0;
		v2 := (4 - bytes) + 3;
	end else
	begin
		v1 := 1;
		v2 := bytes;
	end;

	for i := 0 to ff_number_of_level_sections - 1 do
	begin
		if (i mod 2) = v1 then
		begin
			Inc(object_counter, object_ordering[i]);
			if object_counter > o then
			begin
				if object_ordering[i] = 1 then
				begin
					if i = (ff_number_of_level_sections - 1) then
						Dec(ff_number_of_level_sections)
					else
					begin
						if i = 0 then
						begin
							for j := 0 to ff_number_of_level_sections - 1 do
								object_ordering[j] := object_ordering[j + 1];
							Dec(ff_number_of_level_sections);
							the_first_object := v2;
						end
						else
						begin
							Inc(object_ordering[i-1], object_ordering[i+1]);
							for j := i to ff_number_of_level_sections - 1 do
								object_ordering[j] := object_ordering[j + 2];
							Dec(ff_number_of_level_sections, 2);
						end;
					end;
				end
				else
					Dec(object_ordering[i]);
				Goto DelObjDone;
			end;
		end;
	end;

DelObjDone:
	index := GetObjectIndex(bytes, o);
	for i := index to (tbyte_objs + fbyte_objs - 1) do
	begin
		objbytes[i] := objbytes[i+1];
		ObjectSize[i] := ObjectSize[i+1];
	end;
	if bytes = 3 then
	begin
		for i := o to tbyte_objs - 1 do
		begin
			tbyte_array[0][i] := tbyte_array[0][i+1];
			tbyte_array[1][i] := tbyte_array[1][i+1];
			tbyte_array[2][i] := tbyte_array[2][i+1];
		end;
		Dec(tbyte_objs);
		Dec(level_bytes, 3);
	end else
	begin
		for i := o to fbyte_objs - 1 do
		begin
			fbyte_array[0][i] := fbyte_array[0][i+1];
			fbyte_array[1][i] := fbyte_array[1][i+1];
			fbyte_array[2][i] := fbyte_array[2][i+1];
			fbyte_array[3][i] := fbyte_array[3][i+1];
		end;
		Dec(fbyte_objs);
		Dec(level_bytes, 4);
	end;
	if level_bytes <= 0 then
	begin
		the_first_object := 0;
		ff_number_of_level_sections := 0;
		ff_oldobject_flag := 0;
	end else
	ff_oldobject_flag := objbytes[tbyte_objs + fbyte_objs - 1];
	levelmodified := True;
end;
