   if (show3byte_flag)
      for (i = 0; i < tbyte_objs; i++)
	 {
	    domain = (tbyte_array[0][i] / 32);
	    if (vertical_flag)
	       {
		  x_position = (tbyte_array[1][i] % 16);
		  y_position = (((tbyte_array[1][i] / 16) * 15) + (tbyte_array[0][i] % 32));
	       }
	    else
	       {
		  x_position = tbyte_array[1][i];
		  y_position = (tbyte_array[0][i] % 32);
	       }

	    if (tbyte_array[2][i] < 16)
	       //if object is one of the single-length 0x00 to 0x0F objects//
	       {
		  object = ((tbyte_array[2][i] + (domain * 31)));

		  for (j = 0; j < plains_level[level_object_set][object].bmp_width; j++)
		     for (k = 0; k < plains_level[level_object_set][object].bmp_height; k++)
			draw_sprite(buffer, obj_01_data[plains_level[level_object_set][object].obj_design[(((plains_level[level_object_set][object].bmp_width) * k) + j)] + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc)) + (16 * j)), ((16 * ((y_position) - y_screen_loc)) + (16 * k)));

		  draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
	       }
	    if (tbyte_array[2][i] >= 16)
	       {
		  object = (((tbyte_array[2][i] / 16) + ((domain * 31) + 16)) - 1);

		  //test if object is 3 bytes
		  if (plains_level[level_object_set][object].obj_flag != THREE_BYTE)
		     draw_sprite(buffer, obj_01_data[145 + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * ((y_position) - y_screen_loc))));
		  else
		     {
			length = (tbyte_array[2][i] % 16);
			if ((plains_level[level_object_set][object].orientation == HORIZ) || (plains_level[level_object_set][object].orientation == HORIZ_2))
			   //if object is horizontally oriented
			   {
			      if (plains_level[level_object_set][object].ends == 0)
				 //if all blocks are the same (e.g. a row of bricks)
				 {
				    for (l_counter = 0; l_counter < (length + 1); l_counter++)
				       for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					  for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					     draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(((plains_level[level_object_set][object].bmp_width) * l) + m)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));

				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));

				 }
			      if (plains_level[level_object_set][object].ends == 1)
				 //if all blocks are the same except for the column on the left, e.g.
				 //rightward pipes
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       {
					  if (l_counter == 0)
					     {
						for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						   {
						      m = 0;
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width / 2) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
						   }
					     }
					  else
					     {
						for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						   for (m = 1; m < plains_level[level_object_set][object].bmp_width; m++)
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * (m - 1))) + (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));

					     }
				       }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }	//end of if (plains_level[level_object_set][object].ends == 1)


			      if (plains_level[level_object_set][object].ends == 2)
				 //if all blocks are the same except for the column on the right, e.g.
				 //leftward pipes        
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       {
					  if (l_counter == length)
					     {
						for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						   {
						      m = (plains_level[level_object_set][object].bmp_width - 1);
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
						   }
					     }
					  else
					     {
						for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						   for (m = 0; m < (plains_level[level_object_set][object].bmp_width - 1); m++)
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
					     }
				       }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }	//end of if (plains_level[level_object_set][object].ends == 2)


			      if (plains_level[level_object_set][object].ends == 3)
				 //if all blocks in the middle are the same, but both the right
				 //and left edges use different bitmaps (e.g. the block platforms)       
				 {
				    if (plains_level[level_object_set][object].orientation == HORIZ)
				       {
					  for (l_counter = 0; l_counter <= length; l_counter++)
					     {
						if (l_counter == 0)
						   {
						      for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
							 {
							    m = 0;
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[0 + (l * plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
							 }
						   }
						else if (l_counter == length)
						   {
						      for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
							 {
							    m = (plains_level[level_object_set][object].bmp_width - 1);
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_width - 1) + (l * plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * (m - 2))) + (16 * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
							 }
						   }
						else
						   {
						      for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
							 {
							    h = (plains_level[level_object_set][object].bmp_width - 2);
							    for (m = 1; m < (plains_level[level_object_set][object].bmp_width - 1); m++)
							       draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * (m - 1))) + (16 * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
							 }
						   }
					     }
				       }	//end of if(plains_level[level_object_set][object].orientation == HORIZ)
				    else
				       {
					  for (l_counter = 0; l_counter < length; l_counter++)
					     if (l_counter == 0)
						{
						   for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						      {
							 m = 0;
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[0 + (l * plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
						      }
						}
					     else if (l_counter == (length - 1))
						{
						   for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						      {
							 m = (plains_level[level_object_set][object].bmp_width - 1);
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_width - 1) + (l * plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * (m - 2))) + (16 * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
						      }
						}
					     else
						{
						   for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
						      {
							 h = (plains_level[level_object_set][object].bmp_width - 2);
							 for (m = 1; m < (plains_level[level_object_set][object].bmp_width - 1); m++)
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[m + (l * plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * (m - 1))) + (16 * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
						      }
						}

				       }

				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			   }
			else if (plains_level[level_object_set][object].orientation == VERTICAL)
			   //if object is vertically oriented
			   {
			      if (plains_level[level_object_set][object].ends == 0)
				 //if all blocks are the same (e.g. ???)
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					  for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					     draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * (plains_level[level_object_set][object].bmp_height) * l_counter))));
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 1)
				 //if all blocks are the same except for the row on the top (e.g.
				 //downward pipes)       
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       if (l_counter == 0)
					  {
					     for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
						{
						   if (length > 0)
						      {
							 for (l = 0; l < (plains_level[level_object_set][object].bmp_height - 1); l++)
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * (plains_level[level_object_set][object].bmp_height) * l_counter))));
						      }
						   else
						      {
							 l = 0;
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * (plains_level[level_object_set][object].bmp_height) * l_counter))));
						      }
						}
					  }
				       else
					  {
					     l = (plains_level[level_object_set][object].bmp_height - 1);
					     for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
						if (plains_level[level_object_set][object].bmp_height <= 2)
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * (l - 1))) + (16 * (plains_level[level_object_set][object].bmp_height - 1) * l_counter))));
						else
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * (l - 1))) + (16 * (plains_level[level_object_set][object].bmp_height - 2) * (l_counter - 1)))));
					  }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 2)
				 //if all blocks are the same except for the row on the bottom, e.g.
				 //upward pipes  
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       if (l_counter == length)
					  {
					     for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
						{
						   l = (plains_level[level_object_set][object].bmp_height - 1);
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), (((16 * ((y_position) - y_screen_loc)) + (16 * l_counter))));
						}
					  }
				       else
					  {
					     for (l = 0; l < plains_level[level_object_set][object].bmp_height - 1; l++)
						for (m = 0; m < (plains_level[level_object_set][object].bmp_width); m++)
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * (plains_level[level_object_set][object].bmp_height - 1) * l_counter))));
					  }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 3)
				 //if all blocks in the middle are the same, but both the top
				 //and bottom edges use different bitmaps (e.g. double-ended pipes)      
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       if (l_counter == 0)
					  {
					     for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
						{
						   l = 0;
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * (plains_level[level_object_set][object].bmp_height) * l_counter))));
						}
					  }
				       else if (l_counter == length)
					  {
					     for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
						{
						   l = (plains_level[level_object_set][object].bmp_height - 1);
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * (l - 2))) + (16 * l_counter))));
						}
					  }
				       else
					  {
					     for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
						for (l = 1; l < (plains_level[level_object_set][object].bmp_height - 1); l++)
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * m)), ((((16 * ((y_position) - y_screen_loc)) + (16 * (l - 1))) + (16 * l_counter))));
					  }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			   }


			else if (plains_level[level_object_set][object].orientation == GD_EXT)
			   {
			      //if object is horizontally oriented but also extends to the ground
			      //Assumes ground is at vertical location 26 or 0x1A
			      //Some code could be placed right here to find the true location
			      //of the ground but I haven't done it yet.
			      if (plains_level[level_object_set][object].ends == 0)
				 //if all blocks are the same (e.g. ???) 
				 {
				    for (l_counter = 0; l_counter < length; l_counter++)
				       for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					  for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					     for (g = (y_position); g <= 25; g++)
						draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (g - (y_position))))));
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 1)
				 //if all blocks are the same except for the column on the left (e.g. ???)               
				 {
				    for (l_counter = 0; l_counter < length; l_counter++)
				       {
					  if (l_counter == 0)
					     {
						for (g = (y_position); g <= 25; g++)
						   {
						      if (g == (y_position))
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[0]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * (y_position) - y_screen_loc)));
						      else if (g == 25)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * (25 - y_screen_loc))));
						      else
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * (g - y_screen_loc))));
						   }
					     }
					  else
					     {
						for (g = (y_position); g <= 25; g++)
						   {
						      if (g == (y_position))
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * (y_position) - y_screen_loc)));
						      else if (g == 25)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width) + 1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * (25 - y_screen_loc))));
						      else
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width) + 1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * (g - y_screen_loc))));
						   }
					     }
				       }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 2)
				 //if all blocks are the same except for the column on the right (e.g. ???)              
				 {
				    for (l_counter = 0; l_counter < length; l_counter++)
				       {
					  if (l_counter == (length - 1))
					     {
						for (g = (y_position); g <= 25; g++)
						   {
						      if (g == (y_position))
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), (16 * (y_position) - y_screen_loc));
						      else if (g == 25)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width) + 1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), (16 * (25 - y_screen_loc)));
						      else
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width) + 1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), (16 * (g - y_screen_loc)));
						   }
					     }
					  else
					     {
						for (g = (y_position); g <= 25; g++)
						   {
						      if (g == (y_position))
							 draw_sprite(main_display, obj_01_data[(plains_level[level_object_set][object].obj_design[0]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), (16 * (y_position) - y_screen_loc));
						      else if (g == 25)
							 draw_sprite(main_display, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), (16 * (25 - y_screen_loc)));
						      else
							 draw_sprite(main_display, obj_01_data[(plains_level[level_object_set][object].obj_design[(plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), (16 * (g - y_screen_loc)));
						   }
					     }
				       }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 3)
				 //if all blocks in the middle are the same but left and right
				 //edges use different bitmaps (e.g. the block platforms)
				 {
				    for (l_counter = 0; l_counter < (length + 1); l_counter++)
				       {
					  if (l_counter == 0)
					     {
						for (g = (y_position); g <= 25; g++)
						   {
						      if (g == (y_position))
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[0]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * ((y_position) - y_screen_loc))));
						      else if (g == 25)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width))]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * (25 - y_screen_loc))));
						      else
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width))]) + (257 * level_object_set)].dat, (16 * (x_position - x_screen_loc)), ((16 * (g - y_screen_loc))));
						   }
					     }
					  else if (l_counter == length)
					     {
						for (g = (y_position); g <= 25; g++)
						   for (l = ((plains_level[level_object_set][object].bmp_width) - ((plains_level[level_object_set][object].bmp_width - 2))); l < (plains_level[level_object_set][object].bmp_width); l++)
						      {
							 if (g == (y_position))
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[l]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * ((y_position) - y_screen_loc))));
							 else if (g == 25)
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width) + l)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * (l_counter))), ((16 * (25 - y_screen_loc))));
							 else
							    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width) + l)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * (l_counter))), ((16 * (g - y_screen_loc))));
						      }
					     }
					  else
					     {
						for (g = (y_position); g <= 25; g++)
						   {
						      if (g == (y_position))
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[1]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * ((y_position) - y_screen_loc))));
						      else if (g == 25)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_height - 1) * (plains_level[level_object_set][object].bmp_width) + 1)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * (25 - y_screen_loc))));
						      else
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_height - 2) * (plains_level[level_object_set][object].bmp_width) + 1)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * l_counter)), ((16 * (g - y_screen_loc))));
						   }
					     }
				       }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			   }
			else if (plains_level[level_object_set][object].orientation == DUMMY)
			   //used mostly or entirely for warning blocks    
			   {
			      for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
				 for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
				    draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * m) + l]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + (16 * m)), (((16 * ((y_position) - y_screen_loc)) + (16 * l))));
			   }
			else if (plains_level[level_object_set][object].orientation == DIAG_DL)
			   {
			      if (plains_level[level_object_set][object].ends == 0)
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					  for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					     draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * m) + l]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * m)) - (16 * plains_level[level_object_set][object].bmp_width * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 1)
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					  for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					     {
						if (!(m == (plains_level[level_object_set][object].bmp_width - 1)))
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * m)) - (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
						else
						   {
						      for (h = 0; h < (l_counter * (plains_level[level_object_set][object].bmp_width - 1)); h++)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) - 1)]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * (h + plains_level[level_object_set][object].bmp_width - 1))) - (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * (((y_position)) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
						   }
					     }

				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));


				 }
			      if (plains_level[level_object_set][object].ends == 2)
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					  for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					     draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * m) + l]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * m)) - (16 * plains_level[level_object_set][object].bmp_width * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * (plains_level[level_object_set][object].bmp_height - 1) * l_counter)));
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));


				 }


			   }
			else if (plains_level[level_object_set][object].orientation == DIAG_DR)
			   {
			      if (plains_level[level_object_set][object].ends == 0)
				 {
				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					  for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					     draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * m) + l]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * m)) + (16 * plains_level[level_object_set][object].bmp_width * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));


				 }
			      if (plains_level[level_object_set][object].ends == 1)

				 {

				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					  for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					     {
						if (!(m == 0))
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * (m - 1))) + (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
						else
						   for (h = 0; h < (l_counter * (plains_level[level_object_set][object].bmp_width - 1)); h++)
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[0]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * h))), (((16 * (((y_position)) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
					     }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			      if (plains_level[level_object_set][object].ends == 2)

				 {

				    for (l_counter = 0; l_counter <= length; l_counter++)
				       for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
					  for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
					     {
						if (!(m == (plains_level[level_object_set][object].bmp_width - 1)))

						   // draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc ))), ((16 * ((y_position) - y_screen_loc))));
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
						else
						   for (h = ((length - l_counter) * (plains_level[level_object_set][object].bmp_width - 1)); h > 0; h--)
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) - 1)]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * (h + plains_level[level_object_set][object].bmp_width - 2))) + (16 * (plains_level[level_object_set][object].bmp_width - 1) * l_counter)), (((16 * (((y_position)) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
					     }
				    draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
				 }
			   }
			else if (plains_level[level_object_set][object].orientation == DIAG_CRNR)
			   {
			      for (l_counter = 0; l_counter <= length; l_counter++)
				 for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
				    for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)

				       {
					  if (m == 0)
					     {
						for (h = ((length - l_counter) * (plains_level[level_object_set][object].bmp_width - 1)); h > 0; h--)
						   draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[0]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * (h - 1)))), (((16 * (((y_position)) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
					     }
					  else
					     draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * l) + m]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc)) + ((16 * (((length - l_counter) * (plains_level[level_object_set][object].bmp_width - 1)) - 1)) + (16 * m))), (((16 * (((y_position)) - y_screen_loc)) + (16 * l)) + (16 * plains_level[level_object_set][object].bmp_height * l_counter)));

				       }
			      draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
			   }
			else if (plains_level[level_object_set][object].orientation == DIAG_UR)
			   {
			      for (l_counter = 0; l_counter <= length; l_counter++)
				 for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)
				    for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
				       draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[((plains_level[level_object_set][object].bmp_width) * m) + l]) + (257 * level_object_set)].dat, (((16 * (x_position - x_screen_loc)) + (16 * m)) + (16 * plains_level[level_object_set][object].bmp_width * l_counter)), (((16 * ((y_position) - y_screen_loc)) + (16 * l)) - (16 * plains_level[level_object_set][object].bmp_height * l_counter)));
			      draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));



			   }
			else if (plains_level[level_object_set][object].orientation == PIPEBOX)
			   {
			      for (l_counter = 0; l_counter <= ((length * 2) + 1); l_counter++)
				 for (h = 0; h <= 4; h++)
				    for (m = 0; m < plains_level[level_object_set][object].bmp_width; m++)

				       {

					  if (plains_level[level_object_set][object].bmp_height <= 4)
					     {
						if (h == 4)
						   {
						      l = 0;
						      draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(((plains_level[level_object_set][object].bmp_width) * l) + m)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), ((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (plains_level[level_object_set][object].bmp_height) * h)));
						   }
						else
						   {

						      for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(((plains_level[level_object_set][object].bmp_width) * l) + m)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), ((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (plains_level[level_object_set][object].bmp_height) * h)));
						   }
					     }
					  else
					     {
						if (h == 0)
						   {
						      for (l = 0; l < plains_level[level_object_set][object].bmp_height; l++)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(((plains_level[level_object_set][object].bmp_width) * l) + m)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), ((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (plains_level[level_object_set][object].bmp_height) * h)));
						   }
						else
						   {

						      for (l = 1; l < plains_level[level_object_set][object].bmp_height; l++)
							 draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[(((plains_level[level_object_set][object].bmp_width) * l) + m)]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * m)) + (16 * (plains_level[level_object_set][object].bmp_width) * l_counter)), ((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (plains_level[level_object_set][object].bmp_height - 1) * h)));
						   }
					     }




				       }


			      for (h = 0; h <= 4; h++)
				 for (g = 0; g < 8; g++)
				    {
				       if (plains_level[level_object_set][object].bmp_height <= 4)
					  {
					     if (h == 4)
						draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[2]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * g)) + (16 * ((length * 2) + 1) * plains_level[level_object_set][object].bmp_width) + 16), ((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (plains_level[level_object_set][object].bmp_height) * h)));
					     else
						draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[2]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * g)) + (16 * ((length * 2) + 1) * plains_level[level_object_set][object].bmp_width) + 16), ((16 * ((y_position) - y_screen_loc)) + (16 * l) + (16 * (plains_level[level_object_set][object].bmp_height) * h)));
					  }
				       else
					  {
					     if (h == 0)
						draw_sprite(buffer, obj_01_data[(plains_level[level_object_set][object].obj_design[2]) + (257 * level_object_set)].dat, ((16 * (x_position - x_screen_loc) + (16 * g)) + (16 * ((length * 2) + 1) * plains_level[level_object_set][object].bmp_width) + 16), ((16 * ((y_position) - y_screen_loc))));
					  }
				    }
			      draw_sprite(buffer, obj_01_data[156 + (257 * level_object_set)].dat, (16 * (x_position - (x_screen_loc))), ((16 * ((y_position) - y_screen_loc))));
			   }

		     }


	       }
	 }
