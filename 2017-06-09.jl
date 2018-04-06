push!(LOAD_PATH, string(pwd(), "\\Cat_v2"))

using custom

function game()
  x = custom.sample_wor([1, 2, 3, 4], 4)
  if x[2] > x[1]
    return x[2]
  else
    if x[3] > maximum([x[1], x[2]])
      return x[3]
    elseif x[3] < minimum([x[1], x[2]])
      return x[4]
    else
      i = rand([3, 4])
      return x[i]
    end
  end
end

function game2()
  x = custom.sample_wor([1, 2, 3, 4], 4)
  if x[3] > maximum([x[1], x[2]])
    return x[3]
  elseif x[3] < minimum([x[1], x[2]])
    return x[4]
  else
    i = rand([3, 4])
    return x[i]
  end
end


function sims(n::Int64)
  total = 0
  for i in 1:n
    total += game2()
  end
  avg = total / n
  return avg
end


"""
n = 1000000
g = 0
l = 0
g2nd = 0
l2nd = 0
w1sts = [0, 0, 0, 0]
l1sts = [0, 0, 0, 0]
for i in 1:n
  b, x1, x2 = game()
  if b
    g += 1
    g2nd += x2
    w1sts[x1] += 1
  else
    l += 1
    l2nd += x2
    l1sts[x1] += 1
  end
end

g2nd = g2nd / g
l2nd = l2nd / l

w1sts = 1/g * w1sts
l1sts = 1/g * l1sts

g = g/n
l = l/n
"""
