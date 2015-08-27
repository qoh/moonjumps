local baseentity = require "shared.entities.baseentity"

local player = {
  pack_size = 16,
  user_control = true
}
player.__index = player
setmetatable(player, baseentity)

function player:new(x, y)
  return setmetatable({
    x = x, y = y,
    xv = 0, yv = 0
  }, self)
end

function player:new_client()
  return setmetatable({
    x = 0, y = 0, xv = 0, yv = 0
  }, self)
end

function player:pack(writer)
  writer.f32(self.x)
  writer.f32(self.y)
  writer.f32(self.xv)
  writer.f32(self.yv)
end

function player:unpack(reader)
  self.x = reader.f32()
  self.y = reader.f32()
  self.xv = reader.f32()
  self.yv = reader.f32()
end

function player:update_user(dt, input)
  self.xv = input.x * 100
  self.yv = self.yv + 300 * dt

  if input.y > 0 and self.y >= 400 then
    self.yv = -400
  end

  self.x = self.x + self.xv * dt
  self.y = self.y + self.yv * dt

  self.y = math.min(self.y, 400)
end

function player:draw()
  love.graphics.rectangle("fill", self.x, self.y, 15, 15)
end