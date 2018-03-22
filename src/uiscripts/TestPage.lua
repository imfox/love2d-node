return 
{
	type = 'View',
	props = 
	{
		width = 600,
		height = 400,
		sceneColor = '#ffffff'
	},
	compId = 1,
	child = {
		
		{
			hasChild = false,
			type = 'Image',
			props = 
			{
				x = 0,
				y = 0,
				width = 600,
				height = 400,
				sizeGrid = '30,4,4,4',
				skin = 'comp/bg.png'
			},
			compId = 3,
			$LOCKED = false,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 138,
						skin = 'comp/bg.png',
						x = 63
					},
					frame = 0
				}
			},
			label = 'Image',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'Button',
			props = 
			{
				label = '点我赋值',
				sizeGrid = '4,4,4,4',
				y = 56,
				width = 150,
				height = 37,
				x = 41,
				skin = 'comp/button.png',
				var = 'btn'
			},
			compId = 2,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 44,
						skin = 'comp/button.png',
						x = 63
					},
					frame = 0
				}
			},
			label = 'Button',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'Clip',
			props = 
			{
				y = 56,
				clipX = 10,
				skin = 'comp/clip_num.png',
				var = 'clip',
				x = 401
			},
			compId = 4,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 81,
						skin = 'comp/clip_num.png',
						x = 209
					},
					frame = 0
				}
			},
			label = 'Clip',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'ComboBox',
			props = 
			{
				labels = 'select1,select2,selecte3',
				sizeGrid = '4,20,4,4',
				y = 143,
				width = 200,
				height = 23,
				x = 220,
				selectedIndex = 1,
				skin = 'comp/combobox.png',
				var = 'combobox'
			},
			compId = 5,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 101,
						skin = 'comp/combobox.png',
						x = 312
					},
					frame = 0
				}
			},
			label = 'ComboBox',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'Tab',
			props = 
			{
				labels = 'tab1,tab2,tab3',
				y = 96,
				skin = 'comp/tab.png',
				var = 'tab',
				x = 220
			},
			compId = 8,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 168,
						skin = 'comp/tab.png',
						x = 204
					},
					frame = 0
				}
			},
			label = 'Tab',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'VScrollBar',
			props = 
			{
				height = 150,
				y = 223,
				skin = 'comp/vscroll.png',
				x = 259
			},
			compId = 10,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 258,
						skin = 'comp/vscroll.png',
						x = 277
					},
					frame = 0
				}
			},
			label = 'VScrollBar',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'VSlider',
			props = 
			{
				height = 150,
				y = 223,
				skin = 'comp/vslider.png',
				x = 224
			},
			compId = 11,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 305,
						skin = 'comp/vslider.png',
						x = 249
					},
					frame = 0
				}
			},
			label = 'VSlider',
			isDirectory = false
		},
		{
			hasChild = true,
			isOpen = true,
			type = 'List',
			props = 
			{
				var = 'list',
				y = 68,
				width = 128,
				height = 299,
				x = 452,
				vScrollBarSkin = 'comp/vscroll.png',
				repeatX = 1
			},
			compId = 19,
			x = 15,
			nodeParent = 1,
			child = {
				
				{
					hasChild = true,
					isOpen = true,
					type = 'Box',
					props = 
					{
						width = 112,
						height = 30,
						y = 0,
						name = 'render',
						x = 0
					},
					compId = 30,
					x = 30,
					nodeParent = 19,
					child = {
						
						{
							type = 'Label',
							props = 
							{
								fontSize = 14,
								text = 'this is a list',
								name = 'label',
								y = 5,
								width = 78,
								height = 20,
								x = 26,
								skin = 'comp/label.png'
							},
							hasChild = false,
							compId = 31,
							x = 45,
							nodeParent = 30,
							child = {
								
							},
							frames = {
								
								{
									type = 1,
									props = 
									{
										text = 'label',
										y = -3,
										skin = 'comp/label.png',
										x = -17
									},
									frame = 0
								}
							},
							label = 'Label(label)',
							isDirectory = false
						},
						{
							hasChild = false,
							type = 'Clip',
							props = 
							{
								y = 2,
								clipX = 10,
								skin = 'comp/clip_num.png',
								name = 'clip',
								x = 0
							},
							compId = 32,
							x = 45,
							nodeParent = 30,
							child = {
								
							},
							frames = {
								
								{
									type = 1,
									props = 
									{
										y = 1,
										skin = 'comp/clip_num.png',
										x = -2
									},
									frame = 0
								}
							},
							label = 'Clip(clip)',
							isDirectory = false
						}
					},
					frames = {
						
						{
							type = 1,
							props = 
							{

							},
							frame = 0
						}
					},
					label = 'Box(render)',
					isDirectory = true
				}
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 248,
						x = 337
					},
					frame = 0
				}
			},
			label = 'List',
			isDirectory = true
		},
		{
			hasChild = false,
			type = 'Button',
			props = 
			{
				y = 4,
				skin = 'comp/btn_close.png',
				name = 'close',
				x = 563
			},
			compId = 20,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						label = 'label',
						y = 96,
						skin = 'comp/btn_close.png',
						x = 556
					},
					frame = 0
				}
			},
			label = 'Button(close)',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'Button',
			props = 
			{
				labelBold = true,
				labelSize = 30,
				label = '点我赋值',
				sizeGrid = '4,4,4,4',
				y = 112,
				width = 150,
				height = 66,
				x = 41,
				skin = 'comp/button.png',
				var = 'btn2'
			},
			compId = 21,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						label = 'label',
						y = 142,
						skin = 'comp/button.png',
						x = 85
					},
					frame = 0
				}
			},
			label = 'Button',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'CheckBox',
			props = 
			{
				label = 'checkBox1',
				y = 188,
				skin = 'comp/checkbox.png',
				var = 'check',
				x = 220
			},
			compId = 22,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						label = 'label',
						y = 300,
						skin = 'comp/checkbox.png',
						x = 75
					},
					frame = 0
				}
			},
			label = 'CheckBox',
			isDirectory = false
		},
		{
			hasChild = false,
			type = 'RadioGroup',
			props = 
			{
				labels = 'radio1,radio2,radio3',
				y = 61,
				skin = 'comp/radiogroup.png',
				var = 'radio',
				x = 220
			},
			compId = 27,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						labels = 'label1,label2',
						y = 306,
						skin = 'comp/radiogroup.png',
						x = 215
					},
					frame = 0
				}
			},
			label = 'RadioGroup',
			isDirectory = false
		},
		{
			hasChild = true,
			isOpen = true,
			type = 'Panel',
			props = 
			{
				width = 127,
				height = 150,
				y = 223,
				vScrollBarSkin = 'comp/vscroll.png',
				x = 299
			},
			compId = 33,
			x = 15,
			nodeParent = 1,
			child = {
				
				{
					type = 'Image',
					props = 
					{
						skin = 'comp/image.png'
					},
					hasChild = false,
					compId = 34,
					x = 30,
					nodeParent = 33,
					child = {
						
					},
					frames = {
						
						{
							type = 1,
							props = 
							{
								y = 207,
								skin = 'comp/image.png',
								x = 420
							},
							frame = 0
						}
					},
					label = 'Image',
					isDirectory = false
				}
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 124,
						x = 610
					},
					frame = 0
				}
			},
			label = 'Panel',
			isDirectory = true
		},
		{
			type = 'CheckBox',
			props = 
			{
				label = 'checkBox2',
				y = 188,
				skin = 'comp/checkbox.png',
				labelColors = '#ff0000',
				x = 326
			},
			hasChild = false,
			compId = 35,
			x = 15,
			nodeParent = 1,
			child = {
				
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						label = 'label',
						y = 300,
						skin = 'comp/checkbox.png',
						x = 75
					},
					frame = 0
				}
			},
			label = 'CheckBox',
			isDirectory = false
		},
		{
			hasChild = true,
			isOpen = true,
			type = 'Box',
			props = 
			{
				y = 197,
				var = 'box',
				x = 41
			},
			compId = 36,
			x = 15,
			nodeParent = 1,
			child = {
				
				{
					type = 'ProgressBar',
					props = 
					{
						name = 'progress',
						y = 70,
						width = 150,
						height = 14,
						sizeGrid = '4,4,4,4',
						skin = 'comp/progress.png'
					},
					hasChild = false,
					compId = 37,
					x = 30,
					nodeParent = 36,
					child = {
						
					},
					frames = {
						
						{
							type = 1,
							props = 
							{
								y = 124,
								skin = 'comp/progress.png',
								x = 322
							},
							frame = 0
						}
					},
					label = 'ProgressBar(progress)',
					isDirectory = false
				},
				{
					type = 'Label',
					props = 
					{
						fontSize = 20,
						text = 'This is a Label',
						name = 'label',
						y = 103,
						width = 137,
						height = 26,
						skin = 'comp/label.png'
					},
					hasChild = false,
					compId = 38,
					x = 30,
					nodeParent = 36,
					child = {
						
					},
					frames = {
						
						{
							type = 1,
							props = 
							{
								y = 172,
								skin = 'comp/label.png',
								x = 445
							},
							frame = 0
						}
					},
					label = 'Label(label)',
					isDirectory = false
				},
				{
					type = 'TextInput',
					props = 
					{
						width = 150,
						text = 'textinput',
						skin = 'comp/textinput.png',
						name = 'input',
						y = 148
					},
					hasChild = false,
					compId = 39,
					x = 30,
					nodeParent = 36,
					child = {
						
					},
					frames = {
						
						{
							type = 1,
							props = 
							{
								y = 178,
								skin = 'comp/textinput.png',
								x = 238
							},
							frame = 0
						}
					},
					label = 'TextInput(input)',
					isDirectory = false
				},
				{
					type = 'HSlider',
					props = 
					{
						width = 150,
						skin = 'comp/hslider.png',
						name = 'slider'
					},
					hasChild = false,
					compId = 40,
					x = 30,
					nodeParent = 36,
					child = {
						
					},
					frames = {
						
						{
							type = 1,
							props = 
							{
								y = 187,
								skin = 'comp/hslider.png',
								x = 90
							},
							frame = 0
						}
					},
					label = 'HSlider(slider)',
					isDirectory = false
				},
				{
					type = 'HScrollBar',
					props = 
					{
						width = 150,
						name = 'scroll',
						skin = 'comp/hscroll.png',
						y = 34
					},
					hasChild = false,
					compId = 41,
					x = 30,
					nodeParent = 36,
					child = {
						
					},
					frames = {
						
						{
							type = 1,
							props = 
							{
								y = 287,
								skin = 'comp/hscroll.png',
								x = 123
							},
							frame = 0
						}
					},
					label = 'HScrollBar(scroll)',
					isDirectory = false
				}
			},
			frames = {
				
				{
					type = 1,
					props = 
					{
						y = 197,
						x = 41
					},
					frame = 0
				}
			},
			label = 'Box',
			isDirectory = true
		}
	},
	frames = {
		
		{
			type = 1,
			props = 
			{
				width = 600,
				height = 400,
				sceneColor = '#ffffff'
			},
			frame = 0
		}
	},
	label = 'View',
	isDirectory = true,
	selectedBox = 1,
	isOpen = true,
	x = 0,
	nodeParent = 0,
	hasChild = true
}