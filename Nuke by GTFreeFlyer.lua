---------------------------------------------------------------------------------------------------------------
--Nuke script by GTFreeFlyer
--Please give credit if using in your missions.

--When you want to create the explosion, use the mission editor to set up some sort of trigger...
--then, when that trigger condition hits, set the action to load this script and... boom!

--Edit only the first two parameters (_groundZeroPoint & _explosionPower)
--Do not edit further in the script

_groundZeroPoint = {x = 101812, y = 21434} -- X is the north/south coordinate as seen in the mission editor and Y is east/west (displayed as Z in the mission editor)
_explosionPower = 100000 -- You can play with this number to fine-tune the blast radius effects.  1 million is pretty insane and will kill things up to 3-4 miles away.

--The bigger the explosion, the more it affects your FPS




---------------------------------------------------------------------------------------------------------------
--Do not edit below this line, this is where the magic happens.
---------------------------------------------------------------------------------------------------------------
function _createExplosion(_vec2)
    _elevation = land.getHeight(_vec2) -- retrieve the ground elevation at the point of explosion   
    _vec3 = {x = _vec2.x, y = _elevation, z = _vec2.y} --store the coordinates in a format required by DCS scripting
    trigger.action.effectSmokeBig(_vec3, 4, 1) -- create fire and smoke on the ground
    _vec3.y = _vec3.y + 5  --set the explosion height 5 meters above the ground.  Do not set the explosion at ground level because it causes strange display of the terrain mesh.
    trigger.action.explosion(_vec3, _explosionPower) --explode!    
end

--this next function will cause the concentric rings of explosions to expand around the ground-zero point
function _expandRing(_ring)
    _vec2= {}
    _numberAroundTheCircle = 360/(60/_ring[1])
    env.info("_numberAroundTheCircle = " .. _numberAroundTheCircle)
    for _station = 1, _numberAroundTheCircle do
        env.info("_station = " .. _station)
        _vec2.y = _groundZeroPoint.y + _ring[1]*2*_explosionRadius * math.cos(_station * (60*math.pi/180)/_ring[1])
        _vec2.x = _groundZeroPoint.x + _ring[1]*2*_explosionRadius * math.sin(_station * (60*math.pi/180)/_ring[1])
        env.info("_vec2 = {" .. _vec2.x .. ", " .. _vec2.y .. "}")
        _createExplosion(_vec2)
    end
end

_explosionRadius = 70 --meters (leave as is)
_delayBetweenRings = .25 --seconds (leave as is)
_createExplosion(_groundZeroPoint, explosionPower)
timer.scheduleFunction(_expandRing, {1}, timer.getTime() + _delayBetweenRings)
timer.scheduleFunction(_expandRing, {2}, timer.getTime() + _delayBetweenRings*2)
timer.scheduleFunction(_expandRing, {3}, timer.getTime() + _delayBetweenRings*3)
timer.scheduleFunction(_expandRing, {4}, timer.getTime() + _delayBetweenRings*4)
timer.scheduleFunction(_expandRing, {5}, timer.getTime() + _delayBetweenRings*5)
timer.scheduleFunction(_expandRing, {6}, timer.getTime() + _delayBetweenRings*6)
