local utils = {}

utils.CheckCollision = function(a, b)
    return a.laserX < b.x + b.width and
        a.laserX + a.laserWidth > b.x and
        a.laserY < b.y + b.height and
        a.laserY + a.laserHeight > b.y
end

return utils
