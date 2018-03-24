---
--- Created by fox.
--- DateTime: 2018/3/24 22:11
---
local export  = {};

export.grayShader = love.graphics.newShader([[
	vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords) {
		vec4 c = Texel(texture, textureCoords);
		float cc = c.r * 0.299 + c.g * 0.518 + c.b * 0.184;
		c.r = c.g = c.b = cc;
		c.rgb *= c.a;
		return c;
	}
]])


return export;