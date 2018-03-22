return 
{
	type = 'View',
	props = 
	{
		width = 640,
		height = 960,
		x = 0,
		sceneColor = '#000000',
		y = 0
	},
	hasChild = true,
	compId = 1,
	animations = {
		
		{
			action = 0,
			frameRate = 24,
			name = 'ani1',
			id = 1,
			nodes = {
				
			}
		}
	},
	child = {
		
		{
			type = 'Image',
			props = 
			{
				width = 640,
				height = 960,
				x = 0,
				skin = 'res/background.jpg',
				y = 0
			},
			hasChild = false,
			compId = 2,
			x = 15,
			nodeParent = 1,
			isAniNode = true,
			child = {
				
			},
			label = 'Image',
			isDirectory = false
		},
		{
			type = 'Image',
			props = 
			{
				x = 2,
				skin = 'res/bg_main_btns.png',
				y = 797
			},
			hasChild = false,
			compId = 11,
			x = 15,
			nodeParent = 1,
			isAniNode = true,
			child = {
				
			},
			label = 'Image',
			isDirectory = false
		},
		{
			isOpen = false,
			type = 'Box',
			props = 
			{
				x = 0,
				y = 6
			},
			hasChild = true,
			compId = 15,
			x = 15,
			nodeParent = 1,
			isAniNode = true,
			child = {
				
				{
					type = 'Image',
					props = 
					{
						x = 0,
						skin = 'res/bg_gradient_mask.png',
						y = -36
					},
					hasChild = false,
					compId = 3,
					nodeParent = 15,
					isAniNode = true,
					child = {
						
					},
					label = 'Image',
					isDirectory = false
				},
				{
					isOpen = true,
					type = 'Image',
					props = 
					{
						skin = 'res/bg_status.png',
						x = 24
					},
					hasChild = true,
					compId = 5,
					nodeParent = 15,
					isAniNode = true,
					child = {
						
						{
							type = 'Image',
							props = 
							{
								anchorX = 0.5,
								x = 10,
								anchorY = 0.5,
								skin = 'res/icon_rank.png',
								y = 24
							},
							hasChild = false,
							compId = 13,
							nodeParent = 5,
							isAniNode = true,
							child = {
								
							},
							label = 'Image',
							isDirectory = false
						},
						{
							type = 'Label',
							props = 
							{
								valign = 'middle',
								align = 'center',
								text = '狐狸大爷',
								font = 'simhei',
								x = 42,
								width = 118,
								height = 42,
								color = '#fff',
								y = 6,
								fontSize = 26
							},
							hasChild = false,
							compId = 16,
							nodeParent = 5,
							isAniNode = true,
							child = {
								
							},
							label = 'Label',
							isDirectory = false
						}
					},
					label = 'Image',
					isDirectory = true
				},
				{
					isOpen = true,
					type = 'Image',
					props = 
					{
						skin = 'res/bg_status.png',
						x = 238
					},
					hasChild = true,
					compId = 6,
					nodeParent = 15,
					isAniNode = true,
					child = {
						
						{
							type = 'Image',
							props = 
							{
								anchorX = 0.5,
								x = 10,
								anchorY = 0.5,
								skin = 'res/icon_gold.png',
								y = 24
							},
							hasChild = false,
							compId = 12,
							nodeParent = 6,
							isAniNode = true,
							child = {
								
							},
							label = 'Image',
							isDirectory = false
						},
						{
							type = 'Label',
							props = 
							{
								valign = 'middle',
								align = 'center',
								text = '999999',
								font = 'simhei',
								x = 42,
								width = 118,
								height = 42,
								color = '#fff',
								y = 6,
								fontSize = 26
							},
							hasChild = false,
							compId = 17,
							nodeParent = 6,
							isAniNode = true,
							child = {
								
							},
							label = 'Label',
							isDirectory = false
						}
					},
					label = 'Image',
					isDirectory = true
				},
				{
					isOpen = true,
					type = 'Image',
					props = 
					{
						skin = 'res/bg_status.png',
						x = 452
					},
					hasChild = true,
					compId = 7,
					nodeParent = 15,
					isAniNode = true,
					child = {
						
						{
							type = 'Image',
							props = 
							{
								anchorX = 0.5,
								x = 10,
								anchorY = 0.5,
								skin = 'res/icon_diamond.png',
								y = 24
							},
							hasChild = false,
							compId = 14,
							nodeParent = 7,
							isAniNode = true,
							child = {
								
							},
							label = 'Image',
							isDirectory = false
						},
						{
							type = 'Label',
							props = 
							{
								valign = 'middle',
								align = 'center',
								text = '999999',
								font = 'simhei',
								x = 42,
								width = 118,
								height = 42,
								color = '#fff',
								y = 6,
								fontSize = 26
							},
							hasChild = false,
							compId = 18,
							nodeParent = 7,
							isAniNode = true,
							child = {
								
							},
							label = 'Label',
							isDirectory = false
						}
					},
					label = 'Image',
					isDirectory = true
				}
			},
			label = 'Box',
			isDirectory = true
		},
		{
			type = 'Image',
			props = 
			{
				width = 412,
				height = 247,
				x = 38,
				skin = 'res/bg_status.png',
				y = 91
			},
			hasChild = false,
			compId = 19,
			x = 15,
			nodeParent = 1,
			isAniNode = true,
			child = {
				
			},
			label = 'Image',
			isDirectory = false
		},
		{
			type = 'Image',
			props = 
			{
				pivotY = 100,
				x = 203,
				width = 412,
				height = 247,
				pivotX = 100,
				sizeGrid = '14,40,19,22',
				skin = 'res/bg_status.png',
				y = 491
			},
			hasChild = false,
			compId = 20,
			x = 15,
			nodeParent = 1,
			isAniNode = true,
			child = {
				
			},
			label = 'Image',
			isDirectory = false
		}
	},
	label = 'View',
	isDirectory = true,
	selectedBox = 1,
	isOpen = true,
	x = 0,
	selecteID = 20,
	nodeParent = -1,
	isAniNode = true
}