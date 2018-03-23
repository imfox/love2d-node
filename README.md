# Love2D-node(NÖDE)

&emsp;&emsp;Language [Chinese](https://github.com/rifox/love2d-node/blob/master/README.md/), [English](https://github.com/rifox/love2d-node/blob/master/README-en.md/)。<br/>

&emsp;&emsp;NÖDE是我业余时间试图编写的一个库，它基于[LÖVE (0.10.2)](http://love2d.org/) <!--[(GitHub)](https://bitbucket.org/rude/love
/) -->版本，部分的逻辑代码参考了[LayaAir](https://www.layabox.com/) [(GitHub)](https://github.com/layabox/layaair/)。<br/>
&emsp;&emsp;编写它的目的只是为了让自己在编写游戏过程中，不用在把时间与精力花费在UI布局与游戏显示对象层次上，而是专注于游戏逻辑。以此来提升开发游戏的速度与效率。<br/>
&emsp;&emsp;但我深知包装太过臃肿的痛苦。因此尽量不会编写一些非必要性的代码。并且提高它的易扩展性。让它更加适用于不同类型的游戏，更容易配合其他的开发工具。<br/>
&emsp;&emsp;它追求的是快速、轻量、简单、舒服的开发之道。
## 示例(example)
#### 1.空白项目
```lua
local Node = require "nodeFrame.engine";
Node.register()
```
#### 2.显示精灵
```lua
local Node = require "nodeFrame.engine";
Node.register();

local spr = Node.Sprite.new("res/1.png"):addTo(Node.stage);
```

...待完善