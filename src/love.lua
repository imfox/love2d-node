---@class love @Love2d modules, functions, and callbacks.
---@field public system system @Provides access to information about the user's system.
---@field public audio audio @Provides an interface to create noise with the user's speakers.
---@field public physics physics @Can simulate 2D rigid body physics in a realistic manner. This module is based on Box2D, and this API corresponds to the Box2D API as closely as possible.
---@field public window window @Provides an interface for modifying and retrieving information about the program's window.
---@field public event event @Manages events, like keypresses.
---@field public timer timer @Provides an interface to the user's clock.
---@field public thread thread @Allows you to work with threads.  Threads are separate Lua environments, running in parallel to the main code. As their code runs separately, they can be used to compute complex operations without adversely affecting the frame rate of the main thread. However, as they are separate environments, they cannot access the variables and functions of the main thread, and communication between threads is limited.  All LOVE objects (userdata) are shared among threads so you'll only have to send their references across threads. You may run into concurrency issues if you manipulate an object on multiple threads at the same time.  When a Thread is started, it only loads the love.thread module. Every other module has to be loaded with require.
---@field public mouse mouse @Provides an interface to the user's mouse.
---@field public image image @Provides an interface to decode encoded image data.
---@field public joystick joystick @Provides an interface to the user's joystick.
---@field public touch touch @Provides an interface to touch-screen presses.
---@field public filesystem filesystem @Provides an interface to the user's filesystem.
---@field public math math @Provides system-independent mathematical functions.
---@field public graphics graphics @The primary responsibility for the love.graphics module is the drawing of lines, shapes, text, Images and other Drawable objects onto the screen. Its secondary responsibilities include loading external files (including Images and Fonts) into memory, creating specialized objects (such as ParticleSystems or Framebuffers) and managing screen geometry.  LÖVE's coordinate system is rooted in the upper-left corner of the screen, which is at location (0, 0). The x-axis is horizontal: larger values are further to the right. The y-axis is vertical: larger values are further towards the bottom.  In many cases, you draw images or shapes in terms of their upper-left corner (See the picture above).  Many of the functions are used to manipulate the graphics coordinate system, which is essentially the way coordinates are mapped to the display. You can change the position, scale, and even rotation in this way.
---@field public sound sound @This module is responsible for decoding sound files. It can't play the sounds, see love.audio for that.
---@field public keyboard keyboard @Provides an interface to the user's keyboard.
---@field public video video @This module is responsible for decoding, controlling, and streaming video files.  It can't draw the videos, see love.graphics.newVideo and Video objects for that.
love = {}
---@param joystick Joystick
---@param button GamepadButton
function love.gamepadreleased(joystick, button) end
---@param focus boolean
function love.focus(focus) end
function love.lowmemory() end
---@return number
---@return number
---@return number
---@return string
function love.getVersion() end
---@return boolean
function love.quit() end
---@param x number
---@param y number
function love.wheelmoved(x, y) end
---@param joystick Joystick
---@param hat number
---@param direction JoystickHat
function love.joystickhat(joystick, hat, direction) end
---@param joystick Joystick
---@param axis number
---@param value number
function love.joystickaxis(joystick, axis, value) end
---@param joystick number
---@param button number
function love.joystickpressed(joystick, button) end
---@param x number
---@param y number
---@param button number
---@param isTouch boolean
function love.mousereleased(x, y, button, isTouch) end
---@param file File
function love.filedropped(file) end
---@param x number
---@param y number
---@param button number
---@param isTouch boolean
function love.mousepressed(x, y, button, isTouch) end
---@param visible boolean
function love.visible(visible) end
---@param x number
---@param y number
---@param dx number
---@param dy number
---@param istouch boolean
function love.mousemoved(x, y, dx, dy, istouch) end
---@param joystick Joystick
function love.joystickadded(joystick) end
---@param joystick number
---@param button number
function love.joystickreleased(joystick, button) end
---@param dt number
function love.update(dt) end
---@param id light userdata
---@param x number
---@param y number
---@param dx number
---@param dy number
---@param pressure number
function love.touchreleased(id, x, y, dx, dy, pressure) end
---@param id light userdata
---@param x number
---@param y number
---@param dx number
---@param dy number
---@param pressure number
function love.touchpressed(id, x, y, dx, dy, pressure) end
---@param id light userdata
---@param x number
---@param y number
---@param dx number
---@param dy number
---@param pressure number
function love.touchmoved(id, x, y, dx, dy, pressure) end
---@param thread Thread
---@param errorstr string
function love.threaderror(thread, errorstr) end
---@param t table
function love.conf(t) end
function love.run() end
---@param text string
function love.textinput(text) end
---@param msg string
function love.errhand(msg) end
---@param text string
---@param start number
---@param length number
function love.textedited(text, start, length) end
---@param w number
---@param h number
function love.resize(w, h) end
function love.draw() end
---@param joystick Joystick
---@param button GamepadButton
function love.gamepadpressed(joystick, button) end
---@param focus boolean
function love.mousefocus(focus) end
---@param joystick Joystick
---@param axis GamepadAxis
function love.gamepadaxis(joystick, axis) end
---@param path string
function love.directorydropped(path) end
---@param arg table
function love.load(arg) end
---@param joystick Joystick
function love.joystickremoved(joystick) end
---@param key KeyConstant
function love.keyreleased(key) end
---@param key KeyConstant
---@param scancode Scancode
---@param isrepeat boolean
function love.keypressed(key, scancode, isrepeat) end
---@class audio @Provides an interface to create noise with the user's speakers.
---@field public TimeUnit TimeUnit @class constants
---@field public SourceType SourceType @class constants
---@field public Source Source @A Source represents audio you can play back. You can do interesting things with Sources, like set the volume, pitch, and its position relative to the listener.
---@field public DistanceModel DistanceModel @class constants
local audio = {}
---@param source Source
function audio.rewind(source) end
---@param x number
---@param y number
---@param z number
function audio.setVelocity(x, y, z) end
---@param model DistanceModel
function audio.setDistanceModel(model) end
---@param source Source
function audio.resume(source) end
---@return number
function audio.getDopplerScale() end
---@param source Source
function audio.play(source) end
---@param fx number
---@param fy number
---@param fz number
---@param ux number
---@param uy number
---@param uz number
function audio.setOrientation(fx, fy, fz, ux, uy, uz) end
---@param source Source
function audio.stop(source) end
---@param filename string
---@param type SourceType
---@return Source
function audio.newSource(filename, type) end
---@return number
function audio.getSourceCount() end
---@param volume number
function audio.setVolume(volume) end
---@return number
---@return number
---@return number
function audio.getVelocity() end
---@return number
---@return number
---@return number
function audio.getPosition() end
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
function audio.getOrientation() end
---@param x number
---@param y number
---@param z number
function audio.setPosition(x, y, z) end
---@param source Source
function audio.pause(source) end
---@return number
function audio.getVolume() end
---@param scale number
function audio.setDopplerScale(scale) end
---@class TimeUnit @class constants
---@field public samples @Audio samples.
---@field public seconds @Regular seconds.
local TimeUnit = {}
---@class SourceType @class constants
---@field public stream @Stream the sound; decode it gradually.
---@field public static @Decode the entire sound at once.
local SourceType = {}
---@class DistanceModel @class constants
---@field public inverse @Inverse distance attenuation.
---@field public linearclamped @Linear attenuation. Gain is clamped. In version 0.9.2 and older this is named linear clamped.
---@field public inverseclamped @Inverse distance attenuation. Gain is clamped. In version 0.9.2 and older this is named inverse clamped.
---@field public exponentclamped @Exponential attenuation. Gain is clamped. In version 0.9.2 and older this is named exponent clamped.
---@field public none @Sources do not get attenuated.
---@field public exponent @Exponential attenuation.
---@field public linear @Linear attenuation.
local DistanceModel = {}
---@class Source @A Source represents audio you can play back. You can do interesting things with Sources, like set the volume, pitch, and its position relative to the listener.
local Source = {}
---@return boolean
function Source:isPaused() end
---@param x number
---@param y number
---@param z number
function Source:setVelocity(x, y, z) end
---@param pitch number
function Source:setPitch(pitch) end
---@return SourceType
function Source:getType() end
---@return boolean
function Source:isLooping() end
---@param volume number
function Source:setVolume(volume) end
---@param x number
---@param y number
---@param z number
function Source:setDirection(x, y, z) end
---@param min number
---@param max number
function Source:setVolumeLimits(min, max) end
---@return number
function Source:getChannels() end
---@return boolean
function Source:isStopped() end
---@param innerAngle number
---@param outerAngle number
---@param outerVolume number
function Source:setCone(innerAngle, outerAngle, outerVolume) end
---@param unit TimeUnit
---@return number
function Source:tell(unit) end
---@return number
function Source:getVolume() end
function Source:stop() end
---@param loop boolean
function Source:setLooping(loop) end
---@param position number
---@param unit TimeUnit
function Source:seek(position, unit) end
function Source:resume() end
---@return number
---@return number
---@return number
function Source:getDirection() end
---@return boolean
function Source:play() end
---@param ref number
---@param max number
function Source:setAttenuationDistances(ref, max) end
---@param rolloff number
function Source:setRolloff(rolloff) end
function Source:pause() end
---@param unit TimeUnit
---@return number
function Source:getDuration(unit) end
function Source:rewind() end
---@return number
---@return number
---@return number
function Source:getCone() end
---@return number
function Source:getPitch() end
---@return number
---@return number
---@return number
function Source:getPosition() end
---@return number
---@return number
function Source:getAttenuationDistances() end
---@param x number
---@param y number
---@param z number
function Source:setPosition(x, y, z) end
---@return boolean
function Source:isPlaying() end
---@return number
function Source:getRolloff() end
---@return number
---@return number
function Source:getVolumeLimits() end
---@return number
---@return number
---@return number
function Source:getVelocity() end
---@class physics @Can simulate 2D rigid body physics in a realistic manner. This module is based on Box2D, and this API corresponds to the Box2D API as closely as possible.
---@field public PrismaticJoint PrismaticJoint @Restricts relative motion between Bodies to one shared axis.
---@field public MouseJoint MouseJoint @For controlling objects with the mouse.
---@field public World World @A world is an object that contains all bodies and joints.
---@field public PulleyJoint PulleyJoint @Allows you to simulate bodies connected through pulleys.
---@field public WheelJoint WheelJoint @Restricts a point on the second body to a line on the first body.
---@field public FrictionJoint FrictionJoint @A FrictionJoint applies friction to a body.
---@field public RopeJoint RopeJoint @The RopeJoint enforces a maximum distance between two points on two bodies. It has no other effect.
---@field public Body Body @Bodies are objects with velocity and position.
---@field public Contact Contact @Contacts are objects created to manage collisions in worlds.
---@field public Shape Shape @Shapes are solid 2d geometrical objects used in love.physics.  Shapes are attached to a Body via a Fixture. The Shape object is copied when this happens. Shape position is relative to Body position.
---@field public EdgeShape EdgeShape @A EdgeShape is a line segment. They can be used to create the boundaries of your terrain. The shape does not have volume and can only collide with PolygonShape and CircleShape.
---@field public WeldJoint WeldJoint @A WeldJoint essentially glues two bodies together.
---@field public JointType JointType @class constants
---@field public BodyType BodyType @class constants
---@field public DistanceJoint DistanceJoint @Keeps two bodies at the same distance.
---@field public ChainShape ChainShape @A ChainShape consists of multiple line segments. It can be used to create the boundaries of your terrain. The shape does not have volume and can only collide with PolygonShape and CircleShape.  Unlike the PolygonShape, the ChainShape does not have a vertices limit or has to form a convex shape, but self intersections are not supported.
---@field public PolygonShape PolygonShape @Polygon is a convex polygon with up to 8 sides.
---@field public MotorJoint MotorJoint @Controls the relative motion between two Bodies. Position and rotation offsets can be specified, as well as the maximum motor force and torque that will be applied to reach the target offsets.
---@field public Joint Joint @Attach multiple bodies together to interact in unique ways.
---@field public GearJoint GearJoint @Keeps bodies together in such a way that they act like gears.
---@field public ShapeType ShapeType @class constants
---@field public RevoluteJoint RevoluteJoint @Allow two Bodies to revolve around a shared point.
---@field public CircleShape CircleShape @Circle extends Shape and adds a radius and a local position.
---@field public Fixture Fixture @Fixtures attach shapes to bodies.
local physics = {}
---@param body Body
---@param x number
---@param y number
---@return Joint
function physics.newMouseJoint(body, x, y) end
---@param body Body
---@param shape Shape
---@param density number
---@return Fixture
function physics.newFixture(body, shape, density) end
---@param body1 Body
---@param body2 Body
---@param x number
---@param y number
---@param ax number
---@param ay number
---@param collideConnected boolean
---@return WheelJoint
function physics.newWheelJoint(body1, body2, x, y, ax, ay, collideConnected) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return EdgeShape
function physics.newEdgeShape(x1, y1, x2, y2) end
---@param world World
---@param x number
---@param y number
---@param type BodyType
---@return Body
function physics.newBody(world, x, y, type) end
---@param loop boolean
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param ... table
---@return ChainShape
function physics.newChainShape(loop, x1, y1, x2, y2, ...) end
---@param scale number
function physics.setMeter(scale) end
---@param xg number
---@param yg number
---@param sleep boolean
---@return World
function physics.newWorld(xg, yg, sleep) end
---@param body1 Body
---@param body2 Body
---@param x number
---@param y number
---@param collideConnected boolean
---@return WeldJoint
function physics.newWeldJoint(body1, body2, x, y, collideConnected) end
---@param body1 Body
---@param body2 Body
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param maxLength number
---@param collideConnected boolean
---@return RopeJoint
function physics.newRopeJoint(body1, body2, x1, y1, x2, y2, maxLength, collideConnected) end
---@return number
function physics.getMeter() end
---@param joint1 Joint
---@param joint2 Joint
---@param ratio number
---@param collideConnected boolean
---@return Joint
function physics.newGearJoint(joint1, joint2, ratio, collideConnected) end
---@param width number
---@param height number
---@return PolygonShape
function physics.newRectangleShape(width, height) end
---@param body1 Body
---@param body2 Body
---@param x number
---@param y number
---@param collideConnected boolean
---@return FrictionJoint
function physics.newFrictionJoint(body1, body2, x, y, collideConnected) end
---@param body1 Body
---@param body2 Body
---@param gx1 number
---@param gy1 number
---@param gx2 number
---@param gy2 number
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param ratio number
---@param collideConnected boolean
---@return Joint
function physics.newPulleyJoint(body1, body2, gx1, gy1, gx2, gy2, x1, y1, x2, y2, ratio, collideConnected) end
---@param body1 Body
---@param body2 Body
---@param x number
---@param y number
---@param ax number
---@param ay number
---@param collideConnected boolean
---@return PrismaticJoint
function physics.newPrismaticJoint(body1, body2, x, y, ax, ay, collideConnected) end
---@param body1 Body
---@param body2 Body
---@param correctionFactor number
---@return MotorJoint
function physics.newMotorJoint(body1, body2, correctionFactor) end
---@param body1 Body
---@param body2 Body
---@param x number
---@param y number
---@param collideConnected boolean
---@return Joint
function physics.newRevoluteJoint(body1, body2, x, y, collideConnected) end
---@param radius number
---@return CircleShape
function physics.newCircleShape(radius) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param ... table
---@return PolygonShape
function physics.newPolygonShape(x1, y1, x2, y2, ...) end
---@param body1 Body
---@param body2 Body
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param collideConnected boolean
---@return DistanceJoint
function physics.newDistanceJoint(body1, body2, x1, y1, x2, y2, collideConnected) end
---@class JointType @class constants
---@field public rope @A RopeJoint.
---@field public friction @A FrictionJoint.
---@field public prismatic @A PrismaticJoint.
---@field public mouse @A MouseJoint.
---@field public gear @A GearJoint.
---@field public pulley @A PulleyJoint.
---@field public distance @A DistanceJoint.
---@field public revolute @A RevoluteJoint.
---@field public weld @A WeldJoint.
local JointType = {}
---@class BodyType @class constants
---@field public kinematic @Kinematic bodies only collide with dynamic bodies.
---@field public dynamic @Dynamic bodies collide with all bodies.
---@field public static @Static bodies do not move.
local BodyType = {}
---@class ShapeType @class constants
---@field public polygon @The Shape is a PolygonShape.
---@field public circle @The Shape is a CircleShape.
---@field public chain @The Shape is a ChainShape.
---@field public edge @The Shape is a EdgeShape.
local ShapeType = {}
---@class PrismaticJoint @Restricts relative motion between Bodies to one shared axis.
local PrismaticJoint = {}
---@return number
function PrismaticJoint:getMotorForce() end
---@param enable boolean
function PrismaticJoint:setLimitsEnabled(enable) end
---@return number
function PrismaticJoint:getUpperLimit() end
---@param s number
function PrismaticJoint:setMotorSpeed(s) end
---@return number
function PrismaticJoint:getMotorSpeed() end
---@return number
function PrismaticJoint:getJointTranslation() end
---@param enable boolean
function PrismaticJoint:setMotorEnabled(enable) end
---@param upper number
function PrismaticJoint:setUpperLimit(upper) end
---@return number
function PrismaticJoint:getMaxMotorForce() end
---@return boolean
function PrismaticJoint:isMotorEnabled() end
---@param lower number
---@param upper number
function PrismaticJoint:setLimits(lower, upper) end
---@return number
function PrismaticJoint:getLowerLimit() end
---@param f number
function PrismaticJoint:setMaxMotorForce(f) end
---@return number
function PrismaticJoint:getJointSpeed() end
---@return number
---@return number
function PrismaticJoint:getLimits() end
---@return boolean
function PrismaticJoint:hasLimitsEnabled() end
---@param lower number
function PrismaticJoint:setLowerLimit(lower) end
---@class MouseJoint @For controlling objects with the mouse.
local MouseJoint = {}
---@return number
---@return number
function MouseJoint:getTarget() end
---@return number
function MouseJoint:getMaxForce() end
---@return number
function MouseJoint:getFrequency() end
---@param x number
---@param y number
function MouseJoint:setTarget(x, y) end
---@param f number
function MouseJoint:setMaxForce(f) end
---@param ratio number
function MouseJoint:setDampingRatio(ratio) end
---@param freq number
function MouseJoint:setFrequency(freq) end
---@class World @A world is an object that contains all bodies and joints.
local World = {}
---@return number
function World:getJointCount() end
---@return table
function World:getContactList() end
---@return boolean
function World:isDestroyed() end
---@param topLeftX number
---@param topLeftY number
---@param bottomRightX number
---@param bottomRightY number
---@param callback function
function World:queryBoundingBox(topLeftX, topLeftY, bottomRightX, bottomRightY, callback) end
---@param beginContact function
---@param endContact function
---@param preSolve function
---@param postSolve function
function World:setCallbacks(beginContact, endContact, preSolve, postSolve) end
---@return table
function World:getBodyList() end
---@return function
function World:getContactFilter() end
---@param dt number
function World:update(dt) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param callback function
function World:rayCast(x1, y1, x2, y2, callback) end
---@return number
function World:getContactCount() end
---@param filter function
function World:setContactFilter(filter) end
---@return boolean
function World:isSleepingAllowed() end
---@return function
---@return function
---@return function
---@return function
function World:getCallbacks() end
---@param x number
---@param y number
function World:translateOrigin(x, y) end
---@return number
function World:getBodyCount() end
---@return number
---@return number
function World:getGravity() end
---@param allowSleep boolean
function World:setSleepingAllowed(allowSleep) end
---@param x number
---@param y number
function World:setGravity(x, y) end
---@return table
function World:getJointList() end
---@return boolean
function World:isLocked() end
---@class PulleyJoint @Allows you to simulate bodies connected through pulleys.
local PulleyJoint = {}
---@return number
function PulleyJoint:getLengthA() end
---@return number
---@return number
---@return number
---@return number
function PulleyJoint:getGroundAnchors() end
---@return number
---@return number
function PulleyJoint:getMaxLengths() end
---@param ratio number
function PulleyJoint:setRatio(ratio) end
---@param max1 number
---@param max2 number
function PulleyJoint:setMaxLengths(max1, max2) end
---@param length number
function PulleyJoint:setConstant(length) end
---@return number
function PulleyJoint:getLengthB() end
---@return number
function PulleyJoint:getRatio() end
---@class WheelJoint @Restricts a point on the second body to a line on the first body.
local WheelJoint = {}
---@return number
function WheelJoint:getMaxMotorTorque() end
---@return number
function WheelJoint:getJointTranslation() end
---@return number
function WheelJoint:getSpringDampingRatio() end
---@return number
function WheelJoint:getJointSpeed() end
---@param speed number
function WheelJoint:setMotorSpeed(speed) end
---@param enable boolean
function WheelJoint:setMotorEnabled(enable) end
---@param ratio number
function WheelJoint:setSpringDampingRatio(ratio) end
---@param freq number
function WheelJoint:setSpringFrequency(freq) end
---@return number
function WheelJoint:getMotorSpeed() end
---@param maxTorque number
function WheelJoint:setMaxMotorTorque(maxTorque) end
---@return number
---@return number
function WheelJoint:getLimits() end
---@return number
function WheelJoint:getSpringFrequency() end
---@param invdt number
---@return number
function WheelJoint:getMotorTorque(invdt) end
---@class FrictionJoint @A FrictionJoint applies friction to a body.
local FrictionJoint = {}
---@param maxForce number
function FrictionJoint:setMaxForce(maxForce) end
---@return number
function FrictionJoint:getMaxTorque() end
---@param torque number
function FrictionJoint:setMaxTorque(torque) end
---@class RopeJoint @The RopeJoint enforces a maximum distance between two points on two bodies. It has no other effect.
local RopeJoint = {}
---@return number
function RopeJoint:getMaxLength() end
---@class Body @Bodies are objects with velocity and position.
local Body = {}
---@return table
function Body:getJointList() end
---@return boolean
function Body:isDestroyed() end
---@return boolean
function Body:isBullet() end
---@return BodyType
function Body:getType() end
---@param status boolean
function Body:setBullet(status) end
---@param scale number
function Body:setGravityScale(scale) end
---@param localX number
---@param localY number
---@return number
---@return number
function Body:getWorldVector(localX, localY) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param ... table
---@return number
---@return number
---@return number
---@return number
---@return number
function Body:getWorldPoints(x1, y1, x2, y2, ...) end
---@return World
function Body:getWorld() end
---@param mass number
function Body:setMass(mass) end
---@param ld number
function Body:setLinearDamping(ld) end
---@param value value
function Body:setUserData(value) end
---@param type BodyType
function Body:setType(type) end
---@param torque number
function Body:applyTorque(torque) end
---@return number
function Body:getLinearDamping() end
---@return table
function Body:getFixtureList() end
---@param x number
---@param y number
function Body:setPosition(x, y) end
---@param x number
---@param y number
---@return number
---@return number
function Body:getLinearVelocityFromLocalPoint(x, y) end
---@return number
function Body:getAngle() end
---@param ix number
---@param iy number
function Body:applyLinearImpulse(ix, iy) end
---@return boolean
function Body:isActive() end
---@param x number
---@param y number
function Body:setLinearVelocity(x, y) end
---@return boolean
function Body:isFixedRotation() end
---@return number
function Body:getAngularDamping() end
---@param worldX number
---@param worldY number
---@return number
---@return number
function Body:getLocalPoint(worldX, worldY) end
---@return number
---@return number
function Body:getLinearVelocity() end
---@return table
function Body:getContactList() end
---@param damping number
function Body:setAngularDamping(damping) end
---@param x number
function Body:setX(x) end
---@param y number
function Body:setY(y) end
---@param awake boolean
function Body:setAwake(awake) end
---@param fixed boolean
function Body:setFixedRotation(fixed) end
---@return number
function Body:getGravityScale() end
---@param angle number
function Body:setAngle(angle) end
---@param w number
function Body:setAngularVelocity(w) end
---@return boolean
function Body:isAwake() end
---@param active boolean
function Body:setActive(active) end
---@param fx number
---@param fy number
function Body:applyForce(fx, fy) end
---@return number
function Body:getInertia() end
function Body:resetMassData() end
---@param x number
---@param y number
---@return number
---@return number
function Body:getLinearVelocityFromWorldPoint(x, y) end
---@param localX number
---@param localY number
---@return number
---@return number
function Body:getWorldPoint(localX, localY) end
---@param inertia number
function Body:setInertia(inertia) end
---@param worldX number
---@param worldY number
---@return number
---@return number
function Body:getLocalVector(worldX, worldY) end
---@return boolean
function Body:isSleepingAllowed() end
---@param allowed boolean
function Body:setSleepingAllowed(allowed) end
---@return number
function Body:getAngularVelocity() end
function Body:destroy() end
---@return number
---@return number
function Body:getPosition() end
---@return number
---@return number
function Body:getLocalCenter() end
---@param x number
---@param y number
---@param mass number
---@param inertia number
function Body:setMassData(x, y, mass, inertia) end
---@return number
---@return number
---@return number
---@return number
function Body:getMassData() end
---@return value
function Body:getUserData() end
---@return number
function Body:getX() end
---@return number
function Body:getY() end
---@return number
function Body:getMass() end
---@return number
---@return number
function Body:getWorldCenter() end
---@class Contact @Contacts are objects created to manage collisions in worlds.
local Contact = {}
---@return boolean
function Contact:isTouching() end
---@param friction number
function Contact:setFriction(friction) end
function Contact:resetRestitution() end
---@return number
function Contact:getFriction() end
---@return number
---@return number
function Contact:getNormal() end
---@return number
function Contact:getRestitution() end
---@return number
---@return number
---@return number
---@return number
function Contact:getPositions() end
---@param enabled boolean
function Contact:setEnabled(enabled) end
---@param restitution number
function Contact:setRestitution(restitution) end
---@return boolean
function Contact:isEnabled() end
function Contact:resetFriction() end
---@class Shape @Shapes are solid 2d geometrical objects used in love.physics.  Shapes are attached to a Body via a Fixture. The Shape object is copied when this happens. Shape position is relative to Body position.
local Shape = {}
---@param x number
---@param y number
---@return boolean
function Shape:testPoint(x, y) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param maxFraction number
---@param tx number
---@param ty number
---@param tr number
---@param childIndex number
---@return number
---@return number
---@return number
function Shape:rayCast(x1, y1, x2, y2, maxFraction, tx, ty, tr, childIndex) end
---@param density number
---@return number
---@return number
---@return number
---@return number
function Shape:computeMass(density) end
---@return number
function Shape:getChildCount() end
---@return number
function Shape:getRadius() end
---@return ShapeType
function Shape:getType() end
---@class EdgeShape @A EdgeShape is a line segment. They can be used to create the boundaries of your terrain. The shape does not have volume and can only collide with PolygonShape and CircleShape.
local EdgeShape = {}
---@param x number
---@param y number
function EdgeShape:setPreviousVertex(x, y) end
---@param x number
---@param y number
function EdgeShape:setNextVertex(x, y) end
---@return number
---@return number
function EdgeShape:getNextVertex() end
---@return number
---@return number
function EdgeShape:getPreviousVertex() end
---@class WeldJoint @A WeldJoint essentially glues two bodies together.
local WeldJoint = {}
---@param ratio number
function WeldJoint:setDampingRatio(ratio) end
---@param freq number
function WeldJoint:setFrequency(freq) end
---@return number
function WeldJoint:getFrequency() end
---@class DistanceJoint @Keeps two bodies at the same distance.
local DistanceJoint = {}
---@param l number
function DistanceJoint:setLength(l) end
---@param ratio number
function DistanceJoint:setDampingRatio(ratio) end
---@return number
function DistanceJoint:getFrequency() end
---@return number
function DistanceJoint:getLength() end
---@param Hz number
function DistanceJoint:setFrequency(Hz) end
---@class ChainShape @A ChainShape consists of multiple line segments. It can be used to create the boundaries of your terrain. The shape does not have volume and can only collide with PolygonShape and CircleShape.  Unlike the PolygonShape, the ChainShape does not have a vertices limit or has to form a convex shape, but self intersections are not supported.
local ChainShape = {}
---@param index number
---@return number
---@return number
function ChainShape:getPoint(index) end
---@return number
function ChainShape:getVertexCount() end
---@param x number
---@param y number
function ChainShape:getNextVertex(x, y) end
---@param x number
---@param y number
function ChainShape:setPreviousVertex(x, y) end
---@param x number
---@param y number
function ChainShape:setNextVertex(x, y) end
---@return number
---@return number
function ChainShape:getPreviousVertex() end
---@return number
---@return number
---@return number
---@return number
---@return number
function ChainShape:getPoints() end
---@class PolygonShape @Polygon is a convex polygon with up to 8 sides.
local PolygonShape = {}
---@return number
---@return number
---@return number
---@return number
---@return number
function PolygonShape:getPoints() end
---@class MotorJoint @Controls the relative motion between two Bodies. Position and rotation offsets can be specified, as well as the maximum motor force and torque that will be applied to reach the target offsets.
local MotorJoint = {}
---@param x number
---@param y number
function MotorJoint:setLinearOffset(x, y) end
---@return number
---@return number
function MotorJoint:getLinearOffset() end
---@param angularoffset number
function MotorJoint:setAngularOffset(angularoffset) end
---@class Joint @Attach multiple bodies together to interact in unique ways.
local Joint = {}
---@param invdt number
---@return number
function Joint:getReactionTorque(invdt) end
---@return boolean
function Joint:isDestroyed() end
---@return Body
---@return Body
function Joint:getBodies() end
---@return JointType
function Joint:getType() end
---@return number
---@return number
---@return number
---@return number
function Joint:getAnchors() end
---@return boolean
function Joint:getCollideConnected() end
---@return number
---@return number
function Joint:getReactionForce() end
---@param value mixed
function Joint:setUserData(value) end
---@return mixed
function Joint:getUserData() end
---@class GearJoint @Keeps bodies together in such a way that they act like gears.
local GearJoint = {}
---@return number
function GearJoint:getRatio() end
---@param ratio number
function GearJoint:setRatio(ratio) end
---@class RevoluteJoint @Allow two Bodies to revolve around a shared point.
local RevoluteJoint = {}
---@return number
function RevoluteJoint:getMaxMotorTorque() end
---@param upper number
function RevoluteJoint:setUpperLimit(upper) end
---@param lower number
function RevoluteJoint:setLowerLimit(lower) end
---@return boolean
function RevoluteJoint:isMotorEnabled() end
---@param enable boolean
function RevoluteJoint:setMotorEnabled(enable) end
---@return number
function RevoluteJoint:getUpperLimit() end
---@return number
function RevoluteJoint:getJointSpeed() end
---@param s number
function RevoluteJoint:setMotorSpeed(s) end
---@param lower number
---@param upper number
function RevoluteJoint:setLimits(lower, upper) end
---@return number
function RevoluteJoint:getLowerLimit() end
---@return boolean
function RevoluteJoint:hasLimitsEnabled() end
---@return number
function RevoluteJoint:getMotorSpeed() end
---@param f number
function RevoluteJoint:setMaxMotorTorque(f) end
---@return number
---@return number
function RevoluteJoint:getLimits() end
---@return number
function RevoluteJoint:getJointAngle() end
---@return number
function RevoluteJoint:getMotorTorque() end
---@class CircleShape @Circle extends Shape and adds a radius and a local position.
local CircleShape = {}
---@param x number
---@param y number
function CircleShape:setPoint(x, y) end
---@return number
function CircleShape:getRadius() end
---@param radius number
function CircleShape:setRadius(radius) end
---@class Fixture @Fixtures attach shapes to bodies.
local Fixture = {}
---@return number
---@return number
---@return number
function Fixture:getCategory() end
---@return boolean
function Fixture:isDestroyed() end
---@return number
---@return number
---@return number
function Fixture:getFilterData() end
---@param value mixed
function Fixture:setUserData(value) end
---@param x number
---@param y number
---@return boolean
function Fixture:testPoint(x, y) end
---@return Body
function Fixture:getBody() end
---@param restitution number
function Fixture:setRestitution(restitution) end
---@param sensor boolean
function Fixture:setSensor(sensor) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y1 number
---@param maxFraction number
---@param childIndex number
---@return number
---@return number
---@return number
function Fixture:rayCast(x1, y1, x2, y1, maxFraction, childIndex) end
---@param mask1 number
---@param mask2 number
---@param ... table
function Fixture:setMask(mask1, mask2, ...) end
---@param group number
function Fixture:setGroupIndex(group) end
---@param friction number
function Fixture:setFriction(friction) end
---@return number
function Fixture:getGroupIndex() end
---@return boolean
function Fixture:isSensor() end
---@param categories number
---@param mask number
---@param group number
function Fixture:setFilterData(categories, mask, group) end
---@return number
function Fixture:getFriction() end
---@return number
---@return number
---@return number
function Fixture:getMask() end
---@param index number
---@return number
---@return number
---@return number
---@return number
function Fixture:getBoundingBox(index) end
---@return number
function Fixture:getRestitution() end
---@return number
---@return number
---@return number
---@return number
function Fixture:getMassData() end
---@return mixed
function Fixture:getUserData() end
---@return number
function Fixture:getDensity() end
---@param category1 number
---@param category2 number
---@param ... table
function Fixture:setCategory(category1, category2, ...) end
---@param density number
function Fixture:setDensity(density) end
---@return Shape
function Fixture:getShape() end
---@class thread @Allows you to work with threads.  Threads are separate Lua environments, running in parallel to the main code. As their code runs separately, they can be used to compute complex operations without adversely affecting the frame rate of the main thread. However, as they are separate environments, they cannot access the variables and functions of the main thread, and communication between threads is limited.  All LOVE objects (userdata) are shared among threads so you'll only have to send their references across threads. You may run into concurrency issues if you manipulate an object on multiple threads at the same time.  When a Thread is started, it only loads the love.thread module. Every other module has to be loaded with require.
---@field public Thread Thread @A Thread is a chunk of code that can run in parallel with other threads. Data can be sent between different threads with Channel objects.
---@field public Channel Channel @A channel is a way to send and receive data to and from different threads.
local thread = {}
---@param filename string
---@return Thread
function thread.newThread(filename) end
---@return Channel
function thread.newChannel() end
---@class Thread @A Thread is a chunk of code that can run in parallel with other threads. Data can be sent between different threads with Channel objects.
local Thread = {}
---@return boolean
function Thread:isRunning() end
function Thread:wait() end
---@param arg1 value
---@param arg2 value
---@param ... table
function Thread:start(arg1, arg2, ...) end
---@class Channel @A channel is a way to send and receive data to and from different threads.
local Channel = {}
---@return value
function Channel:peek() end
---@param func function
---@param arg1 any
---@param ... table
---@return any
---@return any
function Channel:performAtomic(func, arg1, ...) end
---@param value value
function Channel:supply(value) end
---@return value
function Channel:demand() end
---@return number
function Channel:getCount() end
---@param value value
function Channel:push(value) end
---@return value
function Channel:pop() end
---@class mouse @Provides an interface to the user's mouse.
---@field public Cursor Cursor @Represents a hardware cursor.
---@field public CursorType CursorType @class constants
local mouse = {}
---@param x number
function mouse.setX(x) end
---@param ctype CursorType
---@return Cursor
function mouse.getSystemCursor(ctype) end
---@return boolean
function mouse.isGrabbed() end
---@param button number
---@param ... table
---@return boolean
function mouse.isDown(button, ...) end
---@param imageData ImageData
---@param hotx number
---@param hoty number
---@return Cursor
function mouse.newCursor(imageData, hotx, hoty) end
---@param visible boolean
function mouse.setVisible(visible) end
---@return boolean
function mouse.getRelativeMode() end
---@param cursor Cursor
function mouse.setCursor(cursor) end
---@return number
---@return number
function mouse.getPosition() end
---@return boolean
function mouse.hasCursor() end
---@param y number
function mouse.setY(y) end
---@param grab boolean
function mouse.setGrabbed(grab) end
---@param x number
---@param y number
function mouse.setPosition(x, y) end
---@return number
function mouse.getX() end
---@return number
function mouse.getY() end
---@return boolean
function mouse.isVisible() end
---@param enable boolean
function mouse.setRelativeMode(enable) end
---@class CursorType @class constants
---@field public sizenwse @Double arrow pointing to the top-left and bottom-right.
---@field public arrow @An arrow pointer.
---@field public crosshair @Crosshair symbol.
---@field public sizewe @Double arrow pointing left and right.
---@field public hand @Hand symbol.
---@field public waitarrow @Small wait cursor with an arrow pointer.
---@field public no @Slashed circle or crossbones.
---@field public image @The cursor is using a custom image.
---@field public wait @Wait graphic.
---@field public ibeam @An I-beam, normally used when mousing over editable or selectable text.
---@field public sizens @Double arrow pointing up and down.
---@field public sizenesw @Double arrow pointing to the top-right and bottom-left.
---@field public sizeall @Four-pointed arrow pointing up, down, left, and right.
local CursorType = {}
---@class Cursor @Represents a hardware cursor.
local Cursor = {}
---@return CursorType
function Cursor:getType() end
---@class image @Provides an interface to decode encoded image data.
---@field public CompressedImageData CompressedImageData @Represents compressed image data designed to stay compressed in RAM.  CompressedImageData encompasses standard compressed texture formats such as DXT1, DXT5, and BC5 / 3Dc.  You can't draw CompressedImageData directly to the screen. See Image for that.
---@field public ImageFormat ImageFormat @class constants
---@field public ImageData ImageData @Raw (decoded) image data.  You can't draw ImageData directly to screen. See Image for that.
---@field public CompressedImageFormat CompressedImageFormat @class constants
local image = {}
---@param width number
---@param height number
---@return ImageData
function image.newImageData(width, height) end
---@param filename string
---@return CompressedImageData
function image.newCompressedData(filename) end
---@class ImageFormat @class constants
---@field public tga @Targa image format.
---@field public png @PNG image format.
local ImageFormat = {}
---@class CompressedImageFormat @class constants
---@field public ASTC4x4 @The 4x4 pixels per block variant of the ASTC format. RGBA data at 8 bits per pixel.
---@field public PVR1rgb2 @The 2 bit per pixel RGB variant of the PVRTC1 format. Stores RGB data at 2 bits per pixel. Textures compressed with PVRTC1 formats must be square and power-of-two sized.
---@field public ETC2rgba1 @The RGBA variant of the ETC2 format where pixels are either fully transparent or fully opaque. RGBA data at 4 bits per pixel.
---@field public DXT3 @The DXT3 format. RGBA data at 8 bits per pixel. Smooth variations in opacity do not mix well with this format.
---@field public ASTC5x5 @The 5x5 pixels per block variant of the ASTC format. RGBA data at 5.12 bits per pixel.
---@field public ASTC12x10 @The 12x10 pixels per block variant of the ASTC format. RGBA data at 1.07 bits per pixel.
---@field public PVR1rgb4 @The 4 bit per pixel RGB variant of the PVRTC1 format. Stores RGB data at 4 bits per pixel.
---@field public ASTC5x4 @The 5x4 pixels per block variant of the ASTC format. RGBA data at 6.4 bits per pixel.
---@field public PVR1rgba2 @The 2 bit per pixel RGBA variant of the PVRTC1 format.
---@field public BC4s @The signed variant of the BC4 format. Same as above but the pixel values in the texture are in the range of [-1, 1] instead of [0, 1] in shaders.
---@field public BC5s @The signed variant of the BC5 format.
---@field public EACrg @The two-channel variant of the EAC format. Stores red and green channels at 8 bits per pixel.
---@field public DXT1 @The DXT1 format. RGB data at 4 bits per pixel (compared to 32 bits for ImageData and regular Images.) Suitable for fully opaque images. Suitable for fully opaque images on desktop systems.
---@field public ETC2rgba @The RGBA variant of the ETC2 format. RGBA data at 8 bits per pixel. Recommended for images with varying opacity on newer mobile devices.
---@field public PVR1rgba4 @The 4 bit per pixel RGBA variant of the PVRTC1 format.
---@field public ASTC8x5 @The 8x5 pixels per block variant of the ASTC format. RGBA data at 3.2 bits per pixel.
---@field public ASTC8x8 @The 8x8 pixels per block variant of the ASTC format. RGBA data at 2 bits per pixel.
---@field public ASTC10x8 @The 10x8 pixels per block variant of the ASTC format. RGBA data at 1.6 bits per pixel.
---@field public ASTC6x6 @The 6x6 pixels per block variant of the ASTC format. RGBA data at 3.56 bits per pixel.
---@field public ETC1 @The ETC1 format. RGB data at 4 bits per pixel. Suitable for fully opaque images on older Android devices.
---@field public BC4 @The BC4 format (also known as 3Dc+ or ATI1.) Stores just the red channel, at 4 bits per pixel.
---@field public ASTC10x5 @The 10x5 pixels per block variant of the ASTC format. RGBA data at 2.56 bits per pixel.
---@field public EACrs @The signed single-channel variant of the EAC format. Same as above but pixel values in the texture are in the range of [-1, 1] instead of [0, 1] in shaders.
---@field public EACr @The single-channel variant of the EAC format. Stores just the red channel, at 4 bits per pixel.
---@field public BC5 @The BC5 format (also known as 3Dc or ATI2.) Stores red and green channels at 8 bits per pixel.
---@field public BC6hs @The signed variant of the BC6H format. Stores RGB data in the range of [-65504, +65504].
---@field public EACrgs @The signed two-channel variant of the EAC format.
---@field public ASTC12x12 @The 12x12 pixels per block variant of the ASTC format. RGBA data at 0.89 bits per pixel.
---@field public ASTC10x10 @The 10x10 pixels per block variant of the ASTC format. RGBA data at 1.28 bits per pixel.
---@field public BC6h @The BC6H format. Stores half-precision floating-point RGB data in the range of [0, 65504] at 8 bits per pixel. Suitable for HDR images on desktop systems.
---@field public ASTC8x6 @The 8x6 pixels per block variant of the ASTC format. RGBA data at 2.67 bits per pixel.
---@field public ASTC6x5 @The 6x5 pixels per block variant of the ASTC format. RGBA data at 4.27 bits per pixel.
---@field public ASTC10x6 @The 10x6 pixels per block variant of the ASTC format. RGBA data at 2.13 bits per pixel.
---@field public DXT5 @The DXT5 format. RGBA data at 8 bits per pixel. Recommended for images with varying opacity on desktop systems.
---@field public ETC2rgb @The RGB variant of the ETC2 format. RGB data at 4 bits per pixel. Suitable for fully opaque images on newer mobile devices.
---@field public BC7 @The BC7 format (also known as BPTC.) Stores RGB or RGBA data at 8 bits per pixel.
local CompressedImageFormat = {}
---@class CompressedImageData @Represents compressed image data designed to stay compressed in RAM.  CompressedImageData encompasses standard compressed texture formats such as DXT1, DXT5, and BC5 / 3Dc.  You can't draw CompressedImageData directly to the screen. See Image for that.
local CompressedImageData = {}
---@param level number
---@return number
function CompressedImageData:getWidth(level) end
---@param mipmaps number
function CompressedImageData:getMipmapCount(mipmaps) end
---@return CompressedImageFormat
function CompressedImageData:getFormat() end
---@param level number
---@return number
function CompressedImageData:getHeight(level) end
---@class ImageData @Raw (decoded) image data.  You can't draw ImageData directly to screen. See Image for that.
local ImageData = {}
---@param source ImageData
---@param dx number
---@param dy number
---@param sx number
---@param sy number
---@param sw number
---@param sh number
function ImageData:paste(source, dx, dy, sx, sy, sw, sh) end
---@param x number
---@param y number
---@return number
---@return number
---@return number
---@return number
function ImageData:getPixel(x, y) end
---@return number
function ImageData:getWidth() end
---@param pixelFunction function
function ImageData:mapPixel(pixelFunction) end
---@param x number
---@param y number
---@param r number
---@param g number
---@param b number
---@param a number
function ImageData:setPixel(x, y, r, g, b, a) end
---@return number
function ImageData:getHeight() end
---@return number
---@return number
function ImageData:getDimensions() end
---@class joystick @Provides an interface to the user's joystick.
---@field public GamepadButton GamepadButton @class constants
---@field public Joystick Joystick @Represents a physical joystick.
---@field public JoystickHat JoystickHat @class constants
---@field public JoystickInputType JoystickInputType @class constants
---@field public GamepadAxis GamepadAxis @class constants
local joystick = {}
---@param filename string
---@return string
function joystick.saveGamepadMappings(filename) end
---@param guid string
---@param button GamepadButton
---@param inputtype JoystickInputType
---@param inputindex number
---@param hatdirection JoystickHat
---@return boolean
function joystick.setGamepadMapping(guid, button, inputtype, inputindex, hatdirection) end
---@return table
function joystick.getJoysticks() end
---@param filename string
function joystick.loadGamepadMappings(filename) end
---@class GamepadButton @class constants
---@field public dpleft @D-pad left.
---@field public x @Left face button (X).
---@field public dpup @D-pad up.
---@field public rightshoulder @Right bumper.
---@field public y @Top face button (Y).
---@field public rightstick @Right stick click button.
---@field public start @Start button.
---@field public b @Right face button (B).
---@field public leftstick @Left stick click button.
---@field public dpdown @D-pad down.
---@field public dpright @D-pad right.
---@field public back @Back button.
---@field public guide @Guide button.
---@field public a @Bottom face button (A).
---@field public leftshoulder @Left bumper.
local GamepadButton = {}
---@class JoystickHat @class constants
---@field public rd @Right+Down
---@field public ld @Left+Down
---@field public u @Up
---@field public c @Centered
---@field public ru @Right+Up
---@field public lu @Left+Up
---@field public r @Right
---@field public l @Left
---@field public d @Down
local JoystickHat = {}
---@class JoystickInputType @class constants
---@field public axis @Analog axis.
---@field public button @Button.
---@field public hat @8-direction hat value.
local JoystickInputType = {}
---@class GamepadAxis @class constants
---@field public lefty @The y-axis of the left thumbstick.
---@field public rightx @The x-axis of the right thumbstick.
---@field public righty @The y-axis of the right thumbstick.
---@field public triggerright @Right analog trigger.
---@field public triggerleft @Left analog trigger.
---@field public leftx @The x-axis of the left thumbstick.
local GamepadAxis = {}
---@class Joystick @Represents a physical joystick.
local Joystick = {}
---@return boolean
function Joystick:isConnected() end
---@return boolean
function Joystick:isGamepad() end
---@param hat number
---@return JoystickHat
function Joystick:getHat(hat) end
---@param ... table
---@return boolean
function Joystick:isDown(...) end
---@return number
---@return number
function Joystick:getID() end
---@return string
function Joystick:getGUID() end
---@param ... table
---@return boolean
function Joystick:isGamepadDown(...) end
---@param axis number
---@return number
function Joystick:getAxis(axis) end
---@return string
function Joystick:getName() end
---@return number
function Joystick:getAxisCount() end
---@return boolean
function Joystick:isVibrationSupported() end
---@return number
function Joystick:getButtonCount() end
---@return number
---@return number
function Joystick:getVibration() end
---@param axis GamepadAxis
---@return JoystickInputType
---@return number
---@return JoystickHat
function Joystick:getGamepadMapping(axis) end
---@param axis GamepadAxis
---@return number
function Joystick:getGamepadAxis(axis) end
---@return number
function Joystick:getHatCount() end
---@param left number
---@param right number
---@return boolean
function Joystick:setVibration(left, right) end
---@class filesystem @Provides an interface to the user's filesystem.
---@field public FileData FileData @Data representing the contents of a file.
---@field public FileMode FileMode @class constants
---@field public FileDecoder FileDecoder @class constants
---@field public File File @Represents a file on the filesystem.
---@field public BufferMode BufferMode @class constants
local filesystem = {}
---@param archive string
---@return boolean
function filesystem.unmount(archive) end
---@param name string
---@param data string
---@param size number
---@return boolean
function filesystem.write(name, data, size) end
---@param filename string
---@return number
---@return string
function filesystem.getLastModified(filename) end
---@param appname string
function filesystem.init(appname) end
---@param contents string
---@param name string
---@param decoder FileDecoder
---@return FileData
function filesystem.newFileData(contents, name, decoder) end
---@param path string
---@return boolean
function filesystem.isSymlink(path) end
---@param name string
---@return boolean
function filesystem.createDirectory(name) end
---@param name string
---@return function
function filesystem.lines(name) end
---@param filename string
---@return boolean
function filesystem.exists(filename) end
---@param filename string
---@param mode FileMode
---@return File
---@return string
function filesystem.newFile(filename, mode) end
---@return string
function filesystem.getSaveDirectory() end
---@param archive string
---@param mountpoint string
---@return boolean
function filesystem.mount(archive, mountpoint) end
---@return string
function filesystem.getWorkingDirectory() end
---@param filename string
---@return number
---@return string
function filesystem.getSize(filename) end
---@param paths string
function filesystem.setRequirePath(paths) end
---@param enable boolean
function filesystem.setSymlinksEnabled(enable) end
---@param dir string
---@return table
function filesystem.getDirectoryItems(dir) end
---@param name string
---@param appendToPath boolean
function filesystem.setIdentity(name, appendToPath) end
---@param path string
function filesystem.setSource(path) end
---@param name string
---@param bytes number
---@return string
---@return number
function filesystem.read(name, bytes) end
---@param name string
function filesystem.getIdentity(name) end
---@return boolean
function filesystem.areSymlinksEnabled() end
---@return string
function filesystem.getAppdataDirectory() end
---@return string
function filesystem.getSource() end
---@return string
function filesystem.getUserDirectory() end
---@param filepath string
---@return string
function filesystem.getRealDirectory(filepath) end
---@param name string
---@param errormsg string
---@return function
function filesystem.load(name, errormsg) end
---@param name string
---@return boolean
function filesystem.remove(name) end
---@param path string
---@return boolean
function filesystem.isDirectory(path) end
---@param path string
---@return boolean
function filesystem.isFile(path) end
---@return boolean
function filesystem.isFused() end
---@return string
function filesystem.getRequirePath() end
---@return string
function filesystem.getSourceBaseDirectory() end
---@class FileMode @class constants
---@field public r @Open a file for read.
---@field public c @Do not open a file (represents a closed file.)
---@field public a @Open a file for append.
---@field public w @Open a file for write.
local FileMode = {}
---@class FileDecoder @class constants
---@field public base64 @The data is base64-encoded.
---@field public file @The data is unencoded.
local FileDecoder = {}
---@class BufferMode @class constants
---@field public line @Line buffering. Write and append operations are buffered until a newline is output or the buffer size limit is reached.
---@field public full @Full buffering. Write and append operations are always buffered until the buffer size limit is reached.
---@field public none @No buffering. The result of write and append operations appears immediately.
local BufferMode = {}
---@class FileData @Data representing the contents of a file.
local FileData = {}
---@return string
function FileData:getFilename() end
---@class File @Represents a file on the filesystem.
local File = {}
---@param mode BufferMode
---@param size number
---@return boolean
---@return string
function File:setBuffer(mode, size) end
---@param data string
---@param size number
---@return boolean
function File:write(data, size) end
---@return string
function File:getFilename() end
---@param bytes number
---@return string
---@return number
function File:read(bytes) end
---@return BufferMode
---@return number
function File:getBuffer() end
---@param mode FileMode
---@return boolean
function File:open(mode) end
---@param position number
---@return boolean
function File:seek(position) end
---@return number
function File:getSize() end
---@return boolean
---@return string
function File:flush() end
---@return boolean
function File:isOpen() end
---@return function
function File:lines() end
---@return FileMode
function File:getMode() end
---@return boolean
function File:isEOF() end
---@class math @Provides system-independent mathematical functions.
---@field public CompressedDataFormat CompressedDataFormat @class constants
---@field public BezierCurve BezierCurve @A Bézier curve object that can evaluate and render Bézier curves of arbitrary degree.
---@field public CompressedData CompressedData @Represents byte data compressed using a specific algorithm.  love.math.decompress can be used to de-compress the data.
---@field public RandomGenerator RandomGenerator @A random number generation object which has its own random state.
local math = {}
---@param stddev number
---@param mean number
---@return number
function math.randomNormal(stddev, mean) end
---@param vertices table
---@return boolean
function math.isConvex(vertices) end
---@param r number
---@param g number
---@param b number
---@return number
---@return number
---@return number
function math.gammaToLinear(r, g, b) end
---@param x number
---@return number
function math.noise(x) end
---@return number
---@return number
function math.getRandomSeed() end
---@param seed number
function math.setRandomSeed(seed) end
---@param lr number
---@param lg number
---@param lb number
---@return number
---@return number
---@return number
function math.linearToGamma(lr, lg, lb) end
---@param polygon table
---@return table
function math.triangulate(polygon) end
---@param state string
function math.setRandomState(state) end
---@return string
function math.getRandomState() end
---@param max number
---@return number
function math.random(max) end
---@param low number
---@param high number
---@return RandomGenerator
function math.newRandomGenerator(low, high) end
---@param compressedData CompressedData
---@return string
function math.decompress(compressedData) end
---@param vertices table
---@return BezierCurve
function math.newBezierCurve(vertices) end
---@class CompressedDataFormat @class constants
---@field public zlib @The zlib format is DEFLATE-compressed data with a small bit of header data. Compresses relatively slowly and decompresses moderately quickly, and has a decent compression ratio.
---@field public gzip @The gzip format is DEFLATE-compressed data with a slightly larger header than zlib. Since it uses DEFLATE it has the same compression characteristics as the zlib format.
---@field public lz4 @The LZ4 compression format. Compresses and decompresses very quickly, but the compression ratio is not the best. LZ4-HC is used when compression level 9 is specified.
local CompressedDataFormat = {}
---@class BezierCurve @A Bézier curve object that can evaluate and render Bézier curves of arbitrary degree.
local BezierCurve = {}
---@param index number
function BezierCurve:removeControlPoint(index) end
---@param s number
---@param ox number
---@param oy number
function BezierCurve:scale(s, ox, oy) end
---@param depth number
---@return table
function BezierCurve:render(depth) end
---@return number
function BezierCurve:getControlPointCount() end
---@param dx number
---@param dy number
function BezierCurve:translate(dx, dy) end
---@param startpoint number
---@param endpoint number
---@return BezierCurve
function BezierCurve:getSegment(startpoint, endpoint) end
---@return number
function BezierCurve:getDegree() end
---@param i number
---@param ox number
---@param oy number
function BezierCurve:setControlPoint(i, ox, oy) end
---@param x number
---@param y number
---@param i number
function BezierCurve:insertControlPoint(x, y, i) end
---@param startpoint number
---@param endpoint number
---@param depth number
---@return table
function BezierCurve:renderSegment(startpoint, endpoint, depth) end
---@param i number
---@return number
---@return number
function BezierCurve:getControlPoint(i) end
---@param angle number
---@param ox number
---@param oy number
function BezierCurve:rotate(angle, ox, oy) end
---@return BezierCurve
function BezierCurve:getDerivative() end
---@class CompressedData @Represents byte data compressed using a specific algorithm.  love.math.decompress can be used to de-compress the data.
local CompressedData = {}
---@return CompressedDataFormat
function CompressedData:getFormat() end
---@class RandomGenerator @A random number generation object which has its own random state.
local RandomGenerator = {}
---@param stddev number
---@param mean number
---@return number
function RandomGenerator:randomNormal(stddev, mean) end
---@param state string
function RandomGenerator:setState(state) end
---@param max number
---@return number
function RandomGenerator:random(max) end
---@return string
function RandomGenerator:getState() end
---@param seed number
function RandomGenerator:setSeed(seed) end
---@class graphics @The primary responsibility for the love.graphics module is the drawing of lines, shapes, text, Images and other Drawable objects onto the screen. Its secondary responsibilities include loading external files (including Images and Fonts) into memory, creating specialized objects (such as ParticleSystems or Framebuffers) and managing screen geometry.  LÖVE's coordinate system is rooted in the upper-left corner of the screen, which is at location (0, 0). The x-axis is horizontal: larger values are further to the right. The y-axis is vertical: larger values are further towards the bottom.  In many cases, you draw images or shapes in terms of their upper-left corner (See the picture above).  Many of the functions are used to manipulate the graphics coordinate system, which is essentially the way coordinates are mapped to the display. You can change the position, scale, and even rotation in this way.
---@field public Mesh Mesh @A 2D polygon mesh used for drawing arbitrary textured shapes.
---@field public Texture @Superclass for drawable objects which represent a texture. All Textures can be drawn with Quads. This is an abstract type that can't be created directly.
---@field public AreaSpreadDistribution AreaSpreadDistribution @class constants
---@field public FilterMode FilterMode @class constants
---@field public Shader Shader @A Shader is used for advanced hardware-accelerated pixel or vertex manipulation. These effects are written in a language based on GLSL (OpenGL Shading Language) with a few things simplified for easier coding.  Potential uses for shaders include HDR/bloom, motion blur, grayscale/invert/sepia/any kind of color effect, reflection/refraction, distortions, bump mapping, and much more! Here is a collection of basic shaders and good starting point to learn: https://github.com/vrld/shine
---@field public AlignMode AlignMode @class constants
---@field public Canvas Canvas @A Canvas is used for off-screen rendering. Think of it as an invisible screen that you can draw to, but that will not be visible until you draw it to the actual visible screen. It is also known as "render to texture".  By drawing things that do not change position often (such as background items) to the Canvas, and then drawing the entire Canvas instead of each item, you can reduce the number of draw operations performed each frame.  In versions prior to 0.10.0, not all graphics cards that LÖVE supported could use Canvases. love.graphics.isSupported("canvas") could be used to check for support at runtime.
---@field public DrawMode DrawMode @class constants
---@field public BlendAlphaMode BlendAlphaMode @class constants
---@field public CanvasFormat CanvasFormat @class constants
---@field public StackType StackType @class constants
---@field public Quad Quad @A quadrilateral (a polygon with four sides and four corners) with texture coordinate information.  Quads can be used to select part of a texture to draw. In this way, one large texture atlas can be loaded, and then split up into sub-images.
---@field public Image Image @Drawable image type.
---@field public Video Video @A drawable video.
---@field public ParticleInsertMode ParticleInsertMode @class constants
---@field public BlendMode BlendMode @class constants
---@field public SpriteBatch SpriteBatch @Using a single image, draw any number of identical copies of the image using a single call to love.graphics.draw. This can be used, for example, to draw repeating copies of a single background image.  A SpriteBatch can be even more useful when the underlying image is a Texture Atlas (a single image file containing many independent images); by adding Quad to the batch, different sub-images from within the atlas can be drawn.
---@field public PointStyle PointStyle @class constants
---@field public LineStyle LineStyle @class constants
---@field public Font Font @Defines the shape of characters than can be drawn onto the screen.
---@field public MeshDrawMode MeshDrawMode @class constants
---@field public GraphicsFeature GraphicsFeature @class constants
---@field public StencilAction StencilAction @class constants
---@field public ArcType ArcType @class constants
---@field public ParticleSystem ParticleSystem @Used to create cool effects, like fire. The particle systems are created and drawn on the screen using functions in love.graphics. They also need to be updated in the update(dt) callback for you to see any changes in the particles emitted.
---@field public CompareMode CompareMode @class constants
---@field public LineJoin LineJoin @class constants
---@field public GraphicsLimit GraphicsLimit @class constants
---@field public WrapMode WrapMode @class constants
---@field public SpriteBatchUsage SpriteBatchUsage @class constants
---@field public Text Text @Drawable text.
local graphics = {}
---@param stencilfunction function
---@param action StencilAction
---@param value number
---@param keepvalues boolean
function graphics.stencil(stencilfunction, action, value, keepvalues) end
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param ... table
function graphics.line(x1, y1, x2, y2, ...) end
---@param texture Texture
---@param buffer number
---@return ParticleSystem
function graphics.newParticleSystem(texture, buffer) end
---@param font Font
function graphics.setFont(font) end
---@return boolean
function graphics.isWireframe() end
---@return FilterMode
---@return FilterMode
---@return number
function graphics.getDefaultFilter() end
---@param min FilterMode
---@param mag FilterMode
---@param anisotropy number
function graphics.setDefaultFilter(min, mag, anisotropy) end
---@param kx number
---@param ky number
function graphics.shear(kx, ky) end
---@param text string
---@param x number
---@param y number
---@param r number
---@param sx number
---@param sy number
---@param ox number
---@param oy number
---@param kx number
---@param ky number
function graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky) end
---@param code string
---@return Shader
function graphics.newShader(code) end
---@return table
function graphics.getCompressedImageFormats() end
---@return Canvas
function graphics.getCanvas() end
---@return boolean
---@return boolean
function graphics.getStencilTest() end
---@param x number
---@param y number
---@param ... table
function graphics.points(x, y, ...) end
---@param sx number
---@param sy number
function graphics.scale(sx, sy) end
---@return LineStyle
function graphics.getLineStyle() end
---@param mode BlendMode
function graphics.setBlendMode(mode) end
---@return LineJoin
function graphics.getLineJoin() end
---@param drawable Drawable
---@param x number
---@param y number
---@param r number
---@param sx number
---@param sy number
---@param ox number
---@param oy number
---@param kx number
---@param ky number
function graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky) end
---@return number
function graphics.getWidth() end
---@param dx number
---@param dy number
function graphics.translate(dx, dy) end
---@param x number
---@param y number
---@param width number
---@param height number
function graphics.intersectScissor(x, y, width, height) end
---@param discardcolor boolean
---@param discardstencil boolean
function graphics.discard(discardcolor, discardstencil) end
---@param enable boolean
function graphics.setWireframe(enable) end
---@param comparemode CompareMode
---@param comparevalue number
function graphics.setStencilTest(comparemode, comparevalue) end
---@param shader Shader
function graphics.setShader(shader) end
function graphics.origin() end
---@param stack StackType
function graphics.push(stack) end
---@param x number
---@param y number
---@param width number
---@param height number
function graphics.setScissor(x, y, width, height) end
---@param r number
---@param g number
---@param b number
---@param a number
function graphics.clear(r, g, b, a) end
---@param size number
function graphics.setPointSize(size) end
---@param filename string
---@param size number
---@return Font
function graphics.setNewFont(filename, size) end
---@param width number
function graphics.setLineWidth(width) end
---@param texture Texture
---@param maxsprites number
---@param usage SpriteBatchUsage
---@return SpriteBatch
function graphics.newSpriteBatch(texture, maxsprites, usage) end
---@param mode DrawMode
---@param x number
---@param y number
---@param width number
---@param height number
function graphics.rectangle(mode, x, y, width, height) end
---@param style LineStyle
function graphics.setLineStyle(style) end
---@return BlendMode
---@return BlendAlphaMode
function graphics.getBlendMode() end
---@param red boolean
---@param green boolean
---@param blue boolean
---@param alpha boolean
function graphics.setColorMask(red, green, blue, alpha) end
---@return number
---@return number
---@return number
---@return number
function graphics.getScissor() end
---@param red number
---@param green number
---@param blue number
---@param alpha number
function graphics.setColor(red, green, blue, alpha) end
---@param canvas Canvas
---@param ... table
function graphics.setCanvas(canvas, ...) end
---@param text string
---@param x number
---@param y number
---@param limit number
---@param align AlignMode
---@param r number
---@param sx number
---@param sy number
---@param ox number
---@param oy number
---@param kx number
---@param ky number
function graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky) end
---@return boolean
function graphics.isGammaCorrect() end
---@param width number
---@param height number
---@param format CanvasFormat
---@param msaa number
---@return Canvas
function graphics.newCanvas(width, height, format, msaa) end
---@param angle number
function graphics.rotate(angle) end
function graphics.reset() end
---@param r number
---@param g number
---@param b number
---@param a number
function graphics.setBackgroundColor(r, g, b, a) end
function graphics.present() end
function graphics.pop() end
---@return string
---@return string
---@return string
---@return string
function graphics.getRendererInfo() end
---@param mode DrawMode
---@param ... table
function graphics.polygon(mode, ...) end
---@param vertices table
---@param mode MeshDrawMode
---@param usage SpriteBatchUsage
---@return Mesh
function graphics.newMesh(vertices, mode, usage) end
---@param copyAlpha boolean
---@return ImageData
function graphics.newScreenshot(copyAlpha) end
---@param x number
---@param y number
---@param width number
---@param height number
---@param sw number
---@param sh number
---@return Quad
function graphics.newQuad(x, y, width, height, sw, sh) end
---@param filename string
---@param loadaudio boolean
---@return Video
function graphics.newVideo(filename, loadaudio) end
---@return number
---@return number
function graphics.getDimensions() end
---@param filename string
---@return Image
function graphics.newImage(filename) end
---@return number
---@return number
---@return number
---@return number
function graphics.getColor() end
---@param filename string
---@param size number
---@return Font
function graphics.newFont(filename, size) end
---@return table
function graphics.getSupported() end
---@return number
function graphics.getHeight() end
---@param mode DrawMode
---@param x number
---@param y number
---@param radius number
function graphics.circle(mode, x, y, radius) end
---@return boolean
---@return boolean
---@return boolean
---@return boolean
function graphics.getColorMask() end
---@param mode DrawMode
---@param x number
---@param y number
---@param radiusx number
---@param radiusy number
function graphics.ellipse(mode, x, y, radiusx, radiusy) end
---@return table
function graphics.getSystemLimits() end
---@param join LineJoin
function graphics.setLineJoin(join) end
---@return table
function graphics.getCanvasFormats() end
---@param filename string
---@param glyphs string
---@return Font
function graphics.newImageFont(filename, glyphs) end
---@return number
function graphics.getLineWidth() end
---@param font Font
---@param textstring string
---@return Text
function graphics.newText(font, textstring) end
---@return Font
function graphics.getFont() end
---@return number
---@return number
---@return number
---@return number
function graphics.getBackgroundColor() end
---@return number
function graphics.getPointSize() end
---@return Shader
function graphics.getShader() end
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
function graphics.getStats() end
---@class AreaSpreadDistribution @class constants
---@field public none @No distribution - area spread is disabled.
---@field public normal @Normal (gaussian) distribution.
---@field public uniform @Uniform distribution.
---@field public ellipse @Uniform distribution in an ellipse.
local AreaSpreadDistribution = {}
---@class FilterMode @class constants
---@field public linear @Scale image with linear interpolation.
---@field public nearest @Scale image with nearest neighbor interpolation.
local FilterMode = {}
---@class AlignMode @class constants
---@field public right @Align text right.
---@field public left @Align text left.
---@field public center @Align text center.
local AlignMode = {}
---@class DrawMode @class constants
---@field public fill @Draw filled shape.
---@field public line @Draw outlined shape.
local DrawMode = {}
---@class BlendAlphaMode @class constants
---@field public premultiplied @The RGB values of what's drawn are not multiplied by the alpha values of those colors during blending. For most blend modes to work correctly with this alpha mode, the colors of a drawn object need to have had their RGB values multiplied by their alpha values at some point previously ("premultiplied alpha").
---@field public alphamultiply @The RGB values of what's drawn are multiplied by the alpha values of those colors during blending. This is the default alpha mode.
local BlendAlphaMode = {}
---@class CanvasFormat @class constants
---@field public rgb10a2 @RGB with 10 bits per channel, and a 2-bit alpha channel (32 bpp).
---@field public r32f @Floating point single-channel format (32 bpp).
---@field public rgba4 @4 bits per channel (16 bpp) RGBA.
---@field public r16f @Floating point single-channel format (16 bpp). Color values can range from [-65504, +65504].
---@field public r8 @Single-channel (red component) format (8 bpp).
---@field public rg32f @Floating point two-channel format with 32 bits per channel (64 bpp).
---@field public rgba32f @Floating point RGBA with 32 bits per channel (128 bpp).
---@field public rgba8 @8 bits per channel (32 bpp) RGBA. Color channel values range from 0-255 (0-1 in shaders).
---@field public rgb565 @RGB with 5, 6, and 5 bits each, respectively (16 bpp). There is no alpha channel in this format.
---@field public normal @The default Canvas format - usually an alias for the rgba8 format, or the srgb format if gamma-correct rendering is enabled in LÖVE 0.10.0 and newer.
---@field public rgba16f @Floating point RGBA with 16 bits per channel (64 bpp). Color values can range from [-65504, +65504].
---@field public rg16f @Floating point two-channel format with 16 bits per channel (32 bpp). Color values can range from [-65504, +65504].
---@field public rgb5a1 @RGB with 5 bits each, and a 1-bit alpha channel (16 bpp).
---@field public hdr @A format suitable for high dynamic range content - an alias for the rgba16f format, normally.
---@field public rg8 @Two channels (red and green components) with 8 bits per channel (16 bpp).
---@field public srgb @The same as rgba8, but the Canvas is interpreted as being in the sRGB color space. Everything drawn to the Canvas will be converted from linear RGB to sRGB. When the Canvas is drawn (or used in a shader), it will be decoded from sRGB to linear RGB. This reduces color banding when doing gamma-correct rendering, since sRGB encoding has more precision than linear RGB for darker colors.
---@field public rg11b10f @Floating point RGB with 11 bits in the red and green channels, and 10 bits in the blue channel (32 bpp). There is no alpha channel. Color values can range from [0, +65024].
local CanvasFormat = {}
---@class StackType @class constants
---@field public transform @The transformation stack (love.graphics.translate, love.graphics.rotate, etc.)
---@field public all @All love.graphics state, including transform state.
local StackType = {}
---@class ParticleInsertMode @class constants
---@field public random @Particles are inserted at random positions in the ParticleSystem's list of particles.
---@field public bottom @Particles are inserted at the bottom of the ParticleSystem's list of particles.
---@field public top @Particles are inserted at the top of the ParticleSystem's list of particles.
local ParticleInsertMode = {}
---@class BlendMode @class constants
---@field public multiply @The pixel colors of what's drawn are multiplied with the pixel colors already on the screen (darkening them). The alpha of drawn objects is multiplied with the alpha of the screen rather than determining how much the colors on the screen are affected, even when the "alphamultiply" BlendAlphaMode is used.
---@field public replace @The colors of what's drawn completely replace what was on the screen, with no additional blending. The BlendAlphaMode specified in love.graphics.setBlendMode still affects what happens.
---@field public lighten @The pixel colors of what's drawn are compared to the existing pixel colors, and the larger of the two values for each color component is used. Only works when the "premultiplied" BlendAlphaMode is used in love.graphics.setBlendMode.
---@field public darken @The pixel colors of what's drawn are compared to the existing pixel colors, and the smaller of the two values for each color component is used. Only works when the "premultiplied" BlendAlphaMode is used in love.graphics.setBlendMode.
---@field public subtract @The pixel colors of what's drawn are subtracted from the pixel colors already on the screen. The alpha of the screen is not modified.
---@field public add @The pixel colors of what's drawn are added to the pixel colors already on the screen. The alpha of the screen is not modified.
---@field public screen @"Screen" blending.
---@field public alpha @Alpha blending (normal). The alpha of what's drawn determines its opacity.
local BlendMode = {}
---@class PointStyle @class constants
---@field public smooth @Draw smooth points.
---@field public rough @Draw rough points.
local PointStyle = {}
---@class LineStyle @class constants
---@field public smooth @Draw smooth lines.
---@field public rough @Draw rough lines.
local LineStyle = {}
---@class MeshDrawMode @class constants
---@field public points @The vertices are drawn as unconnected points (see love.graphics.setPointSize.)
---@field public triangles @The vertices create unconnected triangles.
---@field public strip @The vertices create a series of connected triangles using vertices 1, 2, 3, then 3, 2, 4 (note the order), then 3, 4, 5 and so on.
---@field public fan @The vertices create a "fan" shape with the first vertex acting as the hub point. Can be easily used to draw simple convex polygons.
local MeshDrawMode = {}
---@class GraphicsFeature @class constants
---@field public clampzero @Whether the "clampzero" WrapMode is supported.
---@field public lighten @Whether the "lighten" and "darken" BlendModes are supported.
---@field public multicanvasformats @Whether multiple Canvases with different formats can be used in the same love.graphics.setCanvas call.
local GraphicsFeature = {}
---@class StencilAction @class constants
---@field public decrementwrap @The stencil value of a pixel will be decremented by 1 for each object that touches the pixel. If the stencil value of 0 is decremented it will be set to 255.
---@field public invert @The stencil value of a pixel will be bitwise-inverted for each object that touches the pixel. If a stencil value of 0 is inverted it will become 255.
---@field public incrementwrap @The stencil value of a pixel will be incremented by 1 for each object that touches the pixel. If a stencil value of 255 is incremented it will be set to 0.
---@field public decrement @The stencil value of a pixel will be decremented by 1 for each object that touches the pixel. If the stencil value reaches 0 it will stay at 0.
---@field public replace @The stencil value of a pixel will be replaced by the value specified in love.graphics.stencil, if any object touches the pixel.
---@field public increment @The stencil value of a pixel will be incremented by 1 for each object that touches the pixel. If the stencil value reaches 255 it will stay at 255.
local StencilAction = {}
---@class ArcType @class constants
---@field public closed @The arc circle's two end-points are connected to each other.
---@field public pie @The arc is drawn like a slice of pie, with the arc circle connected to the center at its end-points.
---@field public open @The arc circle's two end-points are unconnected when the arc is drawn as a line. Behaves like the "closed" arc type when the arc is drawn in filled mode.
local ArcType = {}
---@class CompareMode @class constants
---@field public equal @The stencil value of the pixel must be equal to the supplied value.
---@field public gequal @The stencil value of the pixel must be greater than or equal to the supplied value.
---@field public greater @The stencil value of the pixel must be greater than the supplied value.
---@field public notequal @The stencil value of the pixel must not be equal to the supplied value.
---@field public lequal @The stencil value of the pixel must be less than or equal to the supplied value.
---@field public less @The stencil value of the pixel must be less than the supplied value.
local CompareMode = {}
---@class LineJoin @class constants
---@field public miter @Miter style.
---@field public bevel @Bevel style.
---@field public none @None style.
local LineJoin = {}
---@class GraphicsLimit @class constants
---@field public texturesize @The maximum width or height of Images and Canvases.
---@field public pointsize @The maximum size of points.
---@field public canvasmsaa @The maximum number of antialiasing samples for a Canvas.
---@field public multicanvas @The maximum number of simultaneously active canvases (via love.graphics.setCanvas).
local GraphicsLimit = {}
---@class WrapMode @class constants
---@field public clampzero @Clamp the texture. Fills the area outside the texture's normal range with transparent black (or opaque black for textures with no alpha channel.)
---@field public mirroredrepeat @Repeat the texture, flipping it each time it repeats. May produce better visual results than the repeat mode when the texture doesn't seamlessly tile.
---@field public repeat @Repeat the image. Fills the whole available extent.
---@field public clamp @How the image wraps inside a Quad with a larger quad size than image size. This also affects how Meshes with texture coordinates which are outside the range of [0, 1] are drawn, and the color returned by the Texel Shader function when using it to sample from texture coordinates outside of the range of [0, 1].
local WrapMode = {}
---@class SpriteBatchUsage @class constants
---@field public stream @The object data will always change between draws.
---@field public dynamic @The object's data will change repeatedly during its lifetime.
---@field public static @The object will not be modified after initial sprites or vertices are added.
local SpriteBatchUsage = {}
---@class Mesh @A 2D polygon mesh used for drawing arbitrary textured shapes.
local Mesh = {}
---@return number
---@return number
function Mesh:getDrawRange() end
---@param name string
---@param enable boolean
function Mesh:setAttributeEnabled(name, enable) end
---@param map table
function Mesh:setVertexMap(map) end
---@param texture Texture
function Mesh:setTexture(texture) end
---@param vertexindex number
---@param attributeindex number
---@param value1 number
---@param value2 number
---@param ... table
function Mesh:setVertexAttribute(vertexindex, attributeindex, value1, value2, ...) end
---@return table
function Mesh:getVertexMap() end
---@return Texture
function Mesh:getTexture() end
---@param mode MeshDrawMode
function Mesh:setDrawMode(mode) end
---@param on boolean
function Mesh:setVertexColors(on) end
---@param index number
---@param attributecomponent number
---@param ... table
function Mesh:setVertex(index, attributecomponent, ...) end
---@param vertices table
function Mesh:setVertices(vertices) end
---@param index number
---@return number
---@return number
function Mesh:getVertex(index) end
---@return table
function Mesh:getVertexFormat() end
---@param vertexindex number
---@param attributeindex number
---@return number
---@return number
---@return number
function Mesh:getVertexAttribute(vertexindex, attributeindex) end
---@return number
function Mesh:getVertexCount() end
---@param name string
---@return boolean
function Mesh:isAttributeEnabled(name) end
---@param min number
---@param max number
function Mesh:setDrawRange(min, max) end
---@return MeshDrawMode
function Mesh:getDrawMode() end
---@class Shader @A Shader is used for advanced hardware-accelerated pixel or vertex manipulation. These effects are written in a language based on GLSL (OpenGL Shading Language) with a few things simplified for easier coding.  Potential uses for shaders include HDR/bloom, motion blur, grayscale/invert/sepia/any kind of color effect, reflection/refraction, distortions, bump mapping, and much more! Here is a collection of basic shaders and good starting point to learn: https://github.com/vrld/shine
local Shader = {}
---@param name string
---@param number number
---@param ... table
function Shader:send(name, number, ...) end
---@param name string
---@param color table
---@param ... table
function Shader:sendColor(name, color, ...) end
---@return string
function Shader:getWarnings() end
---@class Canvas @A Canvas is used for off-screen rendering. Think of it as an invisible screen that you can draw to, but that will not be visible until you draw it to the actual visible screen. It is also known as "render to texture".  By drawing things that do not change position often (such as background items) to the Canvas, and then drawing the entire Canvas instead of each item, you can reduce the number of draw operations performed each frame.  In versions prior to 0.10.0, not all graphics cards that LÖVE supported could use Canvases. love.graphics.isSupported("canvas") could be used to check for support at runtime.
local Canvas = {}
---@param min FilterMode
---@param mag FilterMode
---@param anisotropy number
function Canvas:setFilter(min, mag, anisotropy) end
---@return CanvasFormat
function Canvas:getFormat() end
---@return FilterMode
---@return FilterMode
---@return number
function Canvas:getFilter() end
---@return WrapMode
---@return WrapMode
function Canvas:getWrap() end
---@return number
function Canvas:getWidth() end
---@param horizontal WrapMode
---@param vertical WrapMode
function Canvas:setWrap(horizontal, vertical) end
---@param x number
---@param y number
---@param width number
---@param height number
---@return ImageData
function Canvas:newImageData(x, y, width, height) end
---@return number
function Canvas:getMSAA() end
---@param func function
function Canvas:renderTo(func) end
---@return number
function Canvas:getHeight() end
---@class Quad @A quadrilateral (a polygon with four sides and four corners) with texture coordinate information.  Quads can be used to select part of a texture to draw. In this way, one large texture atlas can be loaded, and then split up into sub-images.
local Quad = {}
---@return number
---@return number
---@return number
---@return number
function Quad:setViewport() end
---@return number
---@return number
---@return number
---@return number
function Quad:getViewport() end
---@class Image @Drawable image type.
local Image = {}
---@param min FilterMode
---@param mag FilterMode
function Image:setFilter(min, mag) end
---@return FilterMode
---@return FilterMode
function Image:getFilter() end
---@return WrapMode
---@return WrapMode
function Image:getWrap() end
---@param horizontal WrapMode
---@param vertical WrapMode
function Image:setWrap(horizontal, vertical) end
---@param x number
---@param y number
---@param width number
---@param height number
function Image:refresh(x, y, width, height) end
---@return number
function Image:getWidth() end
---@param filtermode FilterMode
---@param sharpness number
function Image:setMipmapFilter(filtermode, sharpness) end
---@return number
function Image:getHeight() end
---@return FilterMode
---@return number
function Image:getMipmapFilter() end
---@return number
---@return number
function Image:getDimensions() end
---@return table
function Image:getFlags() end
---@class Video @A drawable video.
local Video = {}
function Video:rewind() end
---@param source Source
function Video:setSource(source) end
---@return Source
function Video:getSource() end
---@param seconds number
function Video:tell(seconds) end
---@return boolean
function Video:isPlaying() end
---@param offset number
function Video:seek(offset) end
---@param min FilterMode
---@param mag FilterMode
---@param anisotropy number
function Video:setFilter(min, mag, anisotropy) end
---@return number
function Video:getWidth() end
function Video:pause() end
---@return FilterMode
---@return FilterMode
---@return number
function Video:getFilter() end
function Video:play() end
---@return VideoStream
function Video:getStream() end
---@return number
function Video:getHeight() end
---@class SpriteBatch @Using a single image, draw any number of identical copies of the image using a single call to love.graphics.draw. This can be used, for example, to draw repeating copies of a single background image.  A SpriteBatch can be even more useful when the underlying image is a Texture Atlas (a single image file containing many independent images); by adding Quad to the batch, different sub-images from within the atlas can be drawn.
local SpriteBatch = {}
---@param name string
---@param mesh Mesh
function SpriteBatch:attachAttribute(name, mesh) end
---@param r number
---@param g number
---@param b number
---@param a number
function SpriteBatch:setColor(r, g, b, a) end
---@param id number
---@param x number
---@param y number
---@param r number
---@param sx number
---@param sy number
---@param ox number
---@param oy number
---@param kx number
---@param ky number
function SpriteBatch:set(id, x, y, r, sx, sy, ox, oy, kx, ky) end
---@return number
function SpriteBatch:getCount() end
---@return number
---@return number
---@return number
---@return number
function SpriteBatch:getColor() end
---@return number
function SpriteBatch:getBufferSize() end
---@return Texture
function SpriteBatch:getTexture() end
function SpriteBatch:flush() end
---@param texture Texture
function SpriteBatch:setTexture(texture) end
function SpriteBatch:clear() end
---@param size number
function SpriteBatch:setBufferSize(size) end
---@class Font @Defines the shape of characters than can be drawn onto the screen.
local Font = {}
---@param min FilterMode
---@param mag FilterMode
---@param anisotropy number
function Font:setFilter(min, mag, anisotropy) end
---@return number
function Font:getDescent() end
---@return FilterMode
---@return FilterMode
---@return number
function Font:getFilter() end
---@param text string
---@param wraplimit number
---@return number
---@return table
function Font:getWrap(text, wraplimit) end
---@param height number
function Font:setLineHeight(height) end
---@param line string
---@return number
function Font:getWidth(line) end
---@return number
function Font:getBaseline() end
---@param character string
---@return boolean
function Font:hasGlyphs(character) end
---@param fallbackfont1 Font
---@param ... table
function Font:setFallbacks(fallbackfont1, ...) end
---@return number
function Font:getLineHeight() end
---@return number
function Font:getHeight() end
---@class ParticleSystem @Used to create cool effects, like fire. The particle systems are created and drawn on the screen using functions in love.graphics. They also need to be updated in the update(dt) callback for you to see any changes in the particles emitted.
local ParticleSystem = {}
---@return boolean
function ParticleSystem:isPaused() end
---@return number
function ParticleSystem:getSizeVariation() end
---@return ParticleInsertMode
function ParticleSystem:getInsertMode() end
---@return AreaSpreadDistribution
---@return number
---@return number
function ParticleSystem:getAreaSpread() end
---@param distribution AreaSpreadDistribution
---@param dx number
---@param dy number
function ParticleSystem:setAreaSpread(distribution, dx, dy) end
---@return Texture
function ParticleSystem:getTexture() end
function ParticleSystem:start() end
---@param min number
---@param max number
function ParticleSystem:setSpeed(min, max) end
---@param dt number
function ParticleSystem:update(dt) end
---@return number
---@return number
function ParticleSystem:getRotation() end
---@param min number
---@param max number
function ParticleSystem:setRotation(min, max) end
---@param min number
---@param max number
function ParticleSystem:setLinearDamping(min, max) end
---@param min number
---@param max number
function ParticleSystem:setParticleLifetime(min, max) end
---@param numparticles number
function ParticleSystem:emit(numparticles) end
---@param variation number
function ParticleSystem:setSizeVariation(variation) end
---@return number
---@return number
function ParticleSystem:getLinearDamping() end
---@return boolean
function ParticleSystem:isStopped() end
---@param spread number
function ParticleSystem:setSpread(spread) end
---@param variation number
function ParticleSystem:setSpinVariation(variation) end
---@return boolean
function ParticleSystem:hasRelativeRotation() end
---@param life number
function ParticleSystem:setEmitterLifetime(life) end
---@return boolean
function ParticleSystem:isActive() end
---@param min number
---@param max number
function ParticleSystem:setSpin(min, max) end
---@param enable boolean
function ParticleSystem:setRelativeRotation(enable) end
---@param x number
---@param y number
function ParticleSystem:moveTo(x, y) end
---@param min number
---@param max number
function ParticleSystem:setRadialAcceleration(min, max) end
function ParticleSystem:stop() end
---@param size1 number
---@param size2 number
---@param ... table
function ParticleSystem:setSizes(size1, size2, ...) end
---@param xmin number
---@param ymin number
---@param xmax number
---@param ymax number
function ParticleSystem:setLinearAcceleration(xmin, ymin, xmax, ymax) end
---@param min number
---@param max number
function ParticleSystem:setTangentialAcceleration(min, max) end
---@param rate number
function ParticleSystem:setEmissionRate(rate) end
---@return number
function ParticleSystem:getCount() end
---@param texture Texture
function ParticleSystem:setTexture(texture) end
---@param quad1 Quad
---@param quad2 Quad
function ParticleSystem:setQuads(quad1, quad2) end
---@param x number
---@param y number
function ParticleSystem:setOffset(x, y) end
---@return number
---@return number
function ParticleSystem:getRadialAcceleration() end
---@param mode ParticleInsertMode
function ParticleSystem:setInsertMode(mode) end
---@return number
function ParticleSystem:getDirection() end
---@param direction number
function ParticleSystem:setDirection(direction) end
---@param r1 number
---@param g1 number
---@param b1 number
---@param a1 number
---@param r2 number
---@param g2 number
---@param b2 number
---@param a2 number
---@param ... table
function ParticleSystem:setColors(r1, g1, b1, a1, r2, g2, b2, a2, ...) end
---@return number
function ParticleSystem:getEmitterLifetime() end
---@return number
---@return number
function ParticleSystem:getParticleLifetime() end
---@return number
function ParticleSystem:getEmissionRate() end
function ParticleSystem:reset() end
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
---@return number
function ParticleSystem:getColors() end
---@return number
---@return number
---@return number
function ParticleSystem:getSizes() end
function ParticleSystem:pause() end
---@param buffer number
function ParticleSystem:setBufferSize(buffer) end
---@return number
function ParticleSystem:getSpinVariation() end
---@return number
---@return number
function ParticleSystem:getPosition() end
---@return number
function ParticleSystem:getBufferSize() end
---@return number
---@return number
function ParticleSystem:getOffset() end
---@return number
---@return number
function ParticleSystem:getSpeed() end
---@param x number
---@param y number
function ParticleSystem:setPosition(x, y) end
---@return number
---@return number
function ParticleSystem:getSpin() end
---@return number
---@return number
---@return number
---@return number
function ParticleSystem:getLinearAcceleration() end
---@return number
function ParticleSystem:getSpread() end
---@return number
---@return number
function ParticleSystem:getTangentialAcceleration() end
---@class Text @Drawable text.
local Text = {}
---@param textstring string
function Text:set(textstring) end
---@param textstring string
---@param wraplimit number
---@param align AlignMode
---@param x number
---@param y number
---@param angle number
---@param sx number
---@param sy number
---@param ox number
---@param oy number
---@param kx number
---@param ky number
---@return number
function Text:addf(textstring, wraplimit, align, x, y, angle, sx, sy, ox, oy, kx, ky) end
---@param index number
---@return number
---@return number
function Text:getDimensions(index) end
---@param textstring string
---@param wraplimit number
---@param align AlignMode
function Text:setf(textstring, wraplimit, align) end
---@param font Font
function Text:setFont(font) end
---@return Font
function Text:getFont() end
---@param index number
---@return number
function Text:getWidth(index) end
function Text:clear() end
---@param index number
---@return number
function Text:getHeight(index) end
---@class sound @This module is responsible for decoding sound files. It can't play the sounds, see love.audio for that.
---@field public Decoder Decoder @An object which can gradually decode a sound file.
---@field public SoundData SoundData @Contains raw audio samples. You can not play SoundData back directly. You must wrap a Source object around it.
local sound = {}
---@param filename string
---@return SoundData
function sound.newSoundData(filename) end
---@class Decoder @An object which can gradually decode a sound file.
local Decoder = {}
---@return number
function Decoder:getChannels() end
---@return number
function Decoder:getDuration() end
---@return number
function Decoder:getSampleRate() end
---@class SoundData @Contains raw audio samples. You can not play SoundData back directly. You must wrap a Source object around it.
local SoundData = {}
---@return number
function SoundData:getSampleRate() end
---@param i number
---@return number
function SoundData:getSample(i) end
---@return number
function SoundData:getChannels() end
---@return number
function SoundData:getSampleCount() end
---@return number
function SoundData:getDuration() end
---@param i number
---@param sample number
function SoundData:setSample(i, sample) end
---@class video @This module is responsible for decoding, controlling, and streaming video files.  It can't draw the videos, see love.graphics.newVideo and Video objects for that.
---@field public VideoStream @An object which decodes, streams, and controls Videos.
local video = {}
---@param filename string
---@return VideoStream
function video.newVideoStream(filename) end
---@class system @Provides access to information about the user's system.
---@field public PowerState PowerState @class constants
local system = {}
---@param text string
function system.setClipboardText(text) end
---@param seconds number
function system.vibrate(seconds) end
---@param url string
---@return boolean
function system.openURL(url) end
---@return PowerState
---@return number
---@return number
function system.getPowerInfo() end
---@return string
function system.getOS() end
---@return number
function system.getProcessorCount() end
---@class PowerState @class constants
---@field public battery @Not plugged in, running on a battery.
---@field public charging @Plugged in, charging battery.
---@field public nobattery @Plugged in, no battery available.
---@field public unknown @Cannot determine power status.
---@field public charged @Plugged in, battery is fully charged.
local PowerState = {}
---@class window @Provides an interface for modifying and retrieving information about the program's window.
---@field public FullscreenType FullscreenType @class constants
---@field public MessageBoxType MessageBoxType @class constants
local window = {}
---@param pixelvalue number
---@return number
function window.fromPixels(pixelvalue) end
---@param continuous boolean
function window.requestAttention(continuous) end
---@param value number
---@return number
function window.toPixels(value) end
---@return boolean
function window.isVisible() end
---@param displayindex number
---@return string
function window.getDisplayName(displayindex) end
---@return number
function window.getPixelScale() end
---@return boolean
function window.isOpen() end
---@param title string
function window.setTitle(title) end
---@return number
---@return number
---@return table
function window.getMode() end
function window.maximize() end
---@return string
function window.getTitle() end
---@param width number
---@param height number
---@param flags table
---@return boolean
function window.setMode(width, height, flags) end
---@param imagedata ImageData
---@return boolean
function window.setIcon(imagedata) end
function window.minimize() end
---@param display number
---@return table
function window.getFullscreenModes(display) end
---@param fullscreen boolean
---@return boolean
function window.setFullscreen(fullscreen) end
---@return boolean
---@return FullscreenType
function window.getFullscreen() end
---@return number
---@return number
---@return number
function window.getPosition() end
---@param enable boolean
function window.setDisplaySleepEnabled(enable) end
---@return boolean
function window.isDisplaySleepEnabled() end
---@return ImageData
function window.getIcon() end
---@param x number
---@param y number
---@param display number
function window.setPosition(x, y, display) end
---@param title string
---@param message string
---@param type MessageBoxType
---@param attachtowindow boolean
---@return boolean
function window.showMessageBox(title, message, type, attachtowindow) end
---@return boolean
function window.hasMouseFocus() end
---@return boolean
function window.isMaximized() end
---@return boolean
function window.hasFocus() end
---@class FullscreenType @class constants
---@field public desktop @Sometimes known as borderless fullscreen windowed mode. A borderless screen-sized window is created which sits on top of all desktop UI elements. The window is automatically resized to match the dimensions of the desktop, and its size cannot be changed.
---@field public exclusive @Standard exclusive-fullscreen mode. Changes the display mode (actual resolution) of the monitor.
local FullscreenType = {}
---@class MessageBoxType @class constants
---@field public error @Error dialog.
---@field public info @Informational dialog.
---@field public warning @Warning dialog.
local MessageBoxType = {}
---@class event @Manages events, like keypresses.
---@field public Event Event @class constants
local event = {}
function event.pump() end
---@return function
function event.poll() end
---@param e Event
---@param a mixed
---@param b mixed
---@param c mixed
---@param d mixed
function event.push(e, a, b, c, d) end
---@return Event
---@return mixed
---@return mixed
---@return mixed
---@return mixed
function event.wait() end
---@param exitstatus number
function event.quit(exitstatus) end
---@class Event @class constants
---@field public focus @Window focus gained or lost
---@field public mousefocus @Window mouse focus gained or lost
---@field public visible @Window is minimized or un-minimized by the user
---@field public threaderror @A Lua error has occurred in a thread.
---@field public keyreleased @Key released
---@field public quit @Quit
---@field public mousereleased @Mouse released
---@field public mousepressed @Mouse pressed
---@field public resize @Window size changed by the user
---@field public joystickpressed @Joystick pressed
---@field public joystickreleased @Joystick released
---@field public joystickhat @Joystick hat pressed
---@field public joystickaxis @Joystick axis motion
---@field public keypressed @Key pressed
local Event = {}
---@class timer @Provides an interface to the user's clock.
local timer = {}
function timer.step() end
---@return number
function timer.getDelta() end
---@return number
function timer.getTime() end
---@return number
function timer.getFPS() end
---@param s number
function timer.sleep(s) end
---@class touch @Provides an interface to touch-screen presses.
local touch = {}
---@param id light userdata
---@return number
function touch.getPressure(id) end
---@return table
function touch.getTouches() end
---@class keyboard @Provides an interface to the user's keyboard.
---@field public Scancode Scancode @class constants
---@field public KeyConstant KeyConstant @class constants
local keyboard = {}
---@return boolean
function keyboard.hasTextInput() end
---@param key KeyConstant
---@return Scancode
function keyboard.getScancodeFromKey(key) end
---@param key KeyConstant
---@return boolean
function keyboard.isDown(key) end
---@param enable boolean
function keyboard.setKeyRepeat(enable) end
---@param enable boolean
function keyboard.setTextInput(enable) end
---@return boolean
function keyboard.hasKeyRepeat() end
---@param scancode Scancode
---@param ... table
---@return boolean
function keyboard.isScancodeDown(scancode, ...) end
---@class Scancode @class constants
---@field public 4 @The '4' key on an American layout.
---@field public f9 @The F9 key on an American layout.
---@field public . @The period key on an American layout.
---@field public audiostop @The audio stop key on an American layout.
---@field public clearagain @The 'clearagain' key on an American layout.
---@field public kp3 @The keypad '3' key on an American layout.
---@field public r @The 'R' key on an American layout.
---@field public lshift @The left shift key on an American layout.
---@field public t @The 'T' key on an American layout.
---@field public 8 @The '8' key on an American layout.
---@field public copy @The 'copy' key on an American layout.
---@field public 6 @The '6' key on an American layout.
---@field public unknown @An unknown key.
---@field public f14 @The F14 key on an American layout.
---@field public kp2 @The keypad '2' key on an American layout.
---@field public sleep @The system sleep scancode.
---@field public find @The 'find' key on an American layout.
---@field public kp/ @The keypad forward-slash key on an American layout.
---@field public [ @The left-bracket key on an American layout.
---@field public f15 @The F15 key on an American layout.
---@field public kp9 @The keypad '9' key on an American layout.
---@field public application @The application key on an American layout. Windows contextual menu, compose key.
---@field public ] @The right-bracket key on an American layout.
---@field public z @The 'Z' key on an American layout.
---@field public insert @The insert key on an American layout.
---@field public execute @The 'execute' key on an American layout.
---@field public mail @The Mail key on an American layout.
---@field public acsearch @The AC Search key on an American layout.
---@field public kp8 @The keypad '8' key on an American layout.
---@field public f21 @The F21 key on an American layout.
---@field public pagedown @The page-down key on an American layout.
---@field public a @The 'A' key on an American layout.
---@field public acback @The AC Back key on an American layout.
---@field public tab @The 'tab' key on an American layout.
---@field public audiomute @The audio mute key on an American layout.
---@field public c @The 'C' key on an American layout.
---@field public kp- @The keypad minus key on an American layout.
---@field public delete @The forward-delete key on an American layout.
---@field public left @The left-arrow key on an American layout.
---@field public e @The 'E' key on an American layout.
---@field public f20 @The F20 key on an American layout.
---@field public kp00 @The keypad 00 key on an American layout.
---@field public kpenter @The keypad enter key on an American layout.
---@field public acstop @Th AC Stop key on an American layout.
---@field public g @The 'G' key on an American layout.
---@field public kp. @The keypad period key on an American layout.
---@field public f23 @The F23 key on an American layout.
---@field public lang4 @Hiragana scancode.
---@field public i @The 'I' key on an American layout.
---@field public audioprev @The audio previous track key on an American layout.
---@field public numlock @The numlock / clear key on an American layout.
---@field public f19 @The F19 key on an American layout.
---@field public kp5 @The keypad '5' key on an American layout.
---@field public f6 @The F6 key on an American layout.
---@field public k @The 'K' key on an American layout.
---@field public / @The forward-slash key on an American layout.
---@field public kp+ @The keypad plus key on an American layout.
---@field public f22 @The F22 key on an American layout.
---@field public acrefresh @The AC Refresh key on an American layout.
---@field public 1 @The '1' key on an American layout.
---@field public pageup @The page-up key on an American layout.
---@field public kp4 @The keypad '4' key on an American layout.
---@field public 3 @The '3' key on an American layout.
---@field public brightnessdown @The brightness-down scancode.
---@field public f8 @The F8 key on an American layout.
---@field public achome @The AC Home key on an American layout.
---@field public return2 @The 'return2' key on an American layout.
---@field public x @The 'X' key on an American layout.
---@field public q @The 'Q' key on an American layout.
---@field public 5 @The '5' key on an American layout.
---@field public www @The 'WWW' key on an American layout.
---@field public w @The 'W' key on an American layout.
---@field public volumeup @The volume up key on an American layout.
---@field public audionext @The audio next track key on an American layout.
---@field public f24 @The F24 key on an American layout.
---@field public nonusbackslash @The non-U.S. backslash scancode.
---@field public s @The 'S' key on an American layout.
---@field public 7 @The '7' key on an American layout.
---@field public separator @The 'separator' key on an American layout.
---@field public v @The 'V' key on an American layout.
---@field public up @The up-arrow key on an American layout.
---@field public eject @The eject scancode.
---@field public undo @The 'undo' key on an American layout.
---@field public acforward @The AC Forward key on an American layout.
---@field public lgui @The left GUI (command / windows / super) key on an American layout.
---@field public u @The 'U' key on an American layout.
---@field public 9 @The '9' key on an American layout.
---@field public sysreq @The sysreq key on an American layout.
---@field public stop @The 'stop' key on an American layout.
---@field public computer @The 'computer' key on an American layout.
---@field public paste @The 'paste' key on an American layout.
---@field public kp* @The keypad '*' key on an American layout.
---@field public backspace @The 'backspace' key on an American layout.
---@field public printscreen @The printscreen key on an American layout.
---@field public kp000 @The keypad 000 key on an American layout.
---@field public power @The system power scancode.
---@field public international3 @The 3rd international key on an American layout. Yen.
---@field public select @The 'select' key on an American layout.
---@field public international6 @The 6th international key on an American layout.
---@field public rshift @The right shift key on an American layout.
---@field public f4 @The F4 key on an American layout.
---@field public rgui @The right GUI (command / windows / super) key on an American layout.
---@field public y @The 'Y' key on an American layout.
---@field public = @The equals key on an American layout.
---@field public kp1 @The keypad '1' key on an American layout.
---@field public international9 @The 9th international key on an American layout.
---@field public ralt @The right alt / option key on an American layout.
---@field public rctrl @The right control key on an American layout.
---@field public cancel @The 'cancel' key on an American layout.
---@field public return @The 'return' / 'enter' key on an American layout.
---@field public kbdillumup @The keyboard illumination up scancode.
---@field public prior @The 'prior' key on an American layout.
---@field public space @The spacebar on an American layout.
---@field public pause @The pause key on an American layout.
---@field public international4 @The 4th international key on an American layout.
---@field public out @The 'out' key on an American layout.
---@field public kp7 @The keypad '7' key on an American layout.
---@field public f12 @The F12 key on an American layout.
---@field public o @The 'O' key on an American layout.
---@field public nonus# @The non-U.S. hash scancode.
---@field public n @The 'N' key on an American layout.
---@field public cut @The 'cut' key on an American layout.
---@field public kp0 @The keypad '0' key on an American layout.
---@field public home @The home key on an American layout.
---@field public mute @The mute key on an American layout.
---@field public ` @The back-tick / grave key on an American layout.
---@field public international2 @The 2nd international key on an American layout.
---@field public menu @The 'menu' key on an American layout.
---@field public clear @The 'clear' key on an American layout.
---@field public mediaselect @The media select key on an American layout.
---@field public m @The 'M' key on an American layout.
---@field public ; @The semicolon key on an American layout.
---@field public lang5 @Zenkaku/Hankaku scancode.
---@field public lang3 @Katakana scancode.
---@field public lang2 @Hanja conversion scancode.
---@field public lang1 @Hangul/English toggle scancode.
---@field public lalt @The left alt / option key on an American layout.
---@field public l @The 'L' key on an American layout.
---@field public b @The 'B' key on an American layout.
---@field public again @The 'again' key on an American layout.
---@field public kp= @The keypad equals key on an American layout.
---@field public down @The down-arrow key on an American layout.
---@field public d @The 'D' key on an American layout.
---@field public end @The end key on an American layout.
---@field public lctrl @The left control key on an American layout.
---@field public \ @The backslash key on an American layout.
---@field public help @The 'help' key on an American layout.
---@field public crsel @The 'crsel' key on an American layout.
---@field public - @The minus key on an American layout.
---@field public ' @The apostrophe key on an American layout.
---@field public alterase @The alt-erase key on an American layout.
---@field public international8 @The 8th international key on an American layout.
---@field public capslock @The capslock key on an American layout.
---@field public f10 @The F10 key on an American layout.
---@field public kp6 @The keypad '6' key on an American layout.
---@field public f13 @The F13 key on an American layout.
---@field public f7 @The F7 key on an American layout.
---@field public volumedown @The volume down key on an American layout.
---@field public f3 @The F3 key on an American layout.
---@field public h @The 'H' key on an American layout.
---@field public , @The comma key on an American layout.
---@field public app2 @The 'app2' scancode.
---@field public right @The right-arrow key on an American layout.
---@field public currencyunit @The currency unit key on an American layout.
---@field public f @The 'F' key on an American layout.
---@field public f1 @The F1 key on an American layout.
---@field public f5 @The F5 key on an American layout.
---@field public f11 @The F11 key on an American layout.
---@field public exsel @The 'exsel' key on an American layout.
---@field public displayswitch @The display switch scancode.
---@field public f2 @The F2 key on an American layout.
---@field public calculator @The calculator key on an American layout.
---@field public j @The 'J' key on an American layout.
---@field public app1 @The 'app1' scancode.
---@field public kbdillumtoggle @The keyboard illumination toggle scancode.
---@field public oper @The 'oper' key on an American layout.
---@field public brightnessup @The brightness-up scancode.
---@field public 0 @The '0' key on an American layout.
---@field public decimalseparator @The decimal separator key on an American layout.
---@field public f17 @The F17 key on an American layout.
---@field public international5 @The 5th international key on an American layout.
---@field public f18 @The F18 key on an American layout.
---@field public escape @The 'escape' key on an American layout.
---@field public kbdillumdown @The keyboard illumination down scancode.
---@field public international7 @The 7th international key on an American layout.
---@field public f16 @The F16 key on an American layout.
---@field public currencysubunit @The currency sub-unit key on an American layout.
---@field public scrolllock @The scroll-lock key on an American layout.
---@field public international1 @The 1st international key on an American layout. Used on Asian keyboards.
---@field public acbookmarks @The AC Bookmarks key on an American layout.
---@field public 2 @The '2' key on an American layout.
---@field public audioplay @The audio play key on an American layout.
---@field public thsousandsseparator @The thousands-separator key on an American layout.
---@field public p @The 'P' key on an American layout.
local Scancode = {}
---@class KeyConstant @class constants
---@field public 4 @The four key
---@field public f9 @The 9th function key
---@field public . @Full stop key
---@field public appforward @Application forward key
---@field public kp3 @The numpad three key
---@field public r @The R key
---@field public lshift @Left shift key
---@field public t @The T key
---@field public 8 @The eight key
---@field public n @The N key
---@field public print @Print key
---@field public up @Up cursor key
---@field public f14 @The 14th function key
---@field public kp2 @The numpad two key
---@field public : @Colon key
---@field public x @The X key
---@field public < @Less-than key
---@field public kp/ @The numpad division key
---@field public [ @Left square bracket key
---@field public f15 @The 15th function key
---@field public kp9 @The numpad nine key
---@field public rsuper @Right super key
---@field public ] @Right square bracket key
---@field public ! @Exclamation mark key
---@field public insert @Insert key
---@field public lalt @Left alt key
---@field public mail @Mail key
---@field public _ @Underscore key
---@field public # @Hash key
---@field public kp8 @The numpad eight key
---@field public ralt @Right alt key
---@field public a @The A key
---@field public tab @Tab key
---@field public c @The C key
---@field public ' @Single quote key
---@field public delete @Delete key
---@field public left @Left cursor key
---@field public e @The E key
---@field public capslock @Caps-lock key
---@field public kpenter @The numpad enter key
---@field public g @The G key
---@field public + @Plus key
---@field public kp. @The numpad decimal point key
---@field public f2 @The 2nd function key
---@field public i @The I key
---@field public - @Hyphen-minus key
---@field public lsuper @Left super key
---@field public numlock @Num-lock key
---@field public kp5 @The numpad five key
---@field public f6 @The 6th function key
---@field public k @The K key
---@field public menu @Menu key
---@field public kp+ @The numpad addition key
---@field public apphome @Application home key
---@field public lmeta @Left meta key
---@field public m @The M key
---@field public 1 @The one key
---@field public pause @Pause key
---@field public o @The O key
---@field public 3 @The three key
---@field public f8 @The 8th function key
---@field public end @End key
---@field public appbookmarks @Application bookmarks key
---@field public q @The Q key
---@field public 5 @The five key
---@field public s @The S key
---@field public 7 @The seven key
---@field public undo @Undo key
---@field public u @The U key
---@field public 9 @The nine key
---@field public apprefresh @Application refresh key
---@field public kp* @The numpad multiplication key
---@field public backspace @Backspace key
---@field public w @The W key
---@field public ; @Semicolon key
---@field public y @The Y key
---@field public = @Equal key
---@field public kp1 @The numpad one key
---@field public > @Greater-than key
---@field public \ @Backslash key
---@field public return @Return key
---@field public ? @Question mark key
---@field public space @Space key
---@field public kp7 @The numpad seven key
---@field public f12 @The 12th function key
---@field public " @Double quote key
---@field public home @Home key
---@field public ` @Grave accent key
---@field public $ @Dollar key
---@field public clear @Clear key
---@field public b @The B key
---@field public f13 @The 13th function key
---@field public d @The D key
---@field public ( @Left parenthesis key
---@field public lctrl @Left control key
---@field public compose @Compose key
---@field public z @The Z key
---@field public & @Ampersand key
---@field public www @WWW key
---@field public v @The V key
---@field public sysreq @System request key
---@field public scrollock @Scroll-lock key
---@field public power @Power key
---@field public f10 @The 10th function key
---@field public kp6 @The numpad six key
---@field public appsearch @Application search key
---@field public * @Asterisk key
---@field public kp4 @The numpad four key
---@field public calculator @Calculator key
---@field public h @The H key
---@field public , @Comma key
---@field public mode @Mode key
---@field public right @Right cursor key
---@field public f @The F key
---@field public f1 @The 1st function key
---@field public break @Break key
---@field public f5 @The 5th function key
---@field public f11 @The 11th function key
---@field public euro @Euro (&euro;) key
---@field public kp= @The numpad equals key
---@field public appback @Application back key
---@field public down @Down cursor key
---@field public j @The J key
---@field public 0 @The zero key
---@field public / @Slash key
---@field public f7 @The 7th function key
---@field public l @The L key
---@field public ^ @Caret key
---@field public f4 @The 4th function key
---@field public f3 @The 3rd function key
---@field public help @Help key
---@field public rmeta @Right meta key
---@field public escape @Escape key
---@field public rshift @Right shift key
---@field public rctrl @Right control key
---@field public ) @Right parenthesis key
---@field public kp- @The numpad substraction key
---@field public kp0 @The numpad zero key
---@field public pagedown @Page down key
---@field public @ @At sign key
---@field public 2 @The two key
---@field public pageup @Page up key
---@field public 6 @The six key
---@field public p @The P key
local KeyConstant = {}