function One()
  x, y = rand(2)
  X = minimum((x, y))
  Y = maximum((x, y))
  a = X
  b = Y - X
  c = 1 - Y
  if c > a + b
    return 0
  elseif b > a + c
    return 0
  elseif a > b + c
    return 0
  else
    return 1
  end
end

function Two()
  x, y, z = rand(3)
  if x > y + z
    return 0
  elseif y > x + z
    return 0
  elseif z > x + y
    return 0
  else
    return 1
  end
end


function Three()
  x, y = rand(2)
  X = minimum((x, y))
  Y = maximum((x, y))
  assert(X != Y)
  a = X^2
  b = (Y - X)^2
  c = (1 - Y)^2
  if c > a + b
    return 0
  elseif b > a + c
    return 0
  elseif a > b + c
    return 0
  else
    return 1
  end
end

function Four()
  x, y, z = rand(3)
  X = x^2
  Y = y^2
  Z = z^2
  if Z > X + Y
    return 0
  elseif Y > X + Z
    return 0
  elseif X > Y + Z
    return 0
  else
    return 1
  end
end


t = 0
n = 10000000
for i in 1:n
  t += Four()
end

avg = t/n
display(avg)
