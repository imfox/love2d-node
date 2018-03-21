# love2d-node

这是我在`love2d`的基础上所尝试编写的库，模仿了`layabox`的函数命名方式

您的游戏应该编写在 `scripts/mian.lua` 中。

`love.stage` 为主舞台，它是一个`node`实例对象。所以，您要做的一切都是在它上面。您可以使用`addChild`为它添加子元素，也可以用`removeChild`来删除它的子元素，没错这些都是`node`的方法。

在这个库中，一切都是基于`node`(节点)，包括文字标签`label`、精灵`sprite`、按钮`button`等，它们都直接或间接继承`node`类。

`sprite`拥有很多变量，里面存储了一些显示的属性包括`x`、`y`、`scaleX`、`scaleY`、`rotation`等~

下面是一些目前所拥有的类

	love.loader 资源加载类，您可以通过它来加载一些资源
	love.tween 缓动类，您可以通过它来做一些小动画，支持大部分transfrom中的属性
	love.timer 时间类，这里您可以得到一些关于时间方面的函数
	love.Sprite 精灵类，用于渲染图片
	love.Label 标签类，用于渲染文字

	main.ui.SButton 缩放按钮类

在这里您可能需要了解一下我的命名方式
	
	基础类，将是小驼峰命名法，比如 love.loader、love.tween、love.timer
	需要实例化的类，将以大驼峰命名法，比如 love.Sprite、love.Label
	对象的内部成员或者内部方法将以 _ 开头，我建议您不要在外部调用或者修改它们，避免发生一些意料之外的事
	对象的公开成员将是小驼峰命名法，比如 node:addChild()、node.transfrom.x，静态方法为大驼峰命名法，比如 love.tween:FrameLoop() 
	常量为全大写加 _ 分割，比如 love.Event.MOUSE_DOWN
	这是目前的一些规范，您如果使用本库的话，请务必遵守
	
可能会很少更新了...