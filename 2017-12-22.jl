function turn!(X::Vector{Int64}, i::Int64, x::Int64)
  for j = 1:3
    if X[i] > 0
      r = rand([-1, 0, 1])
      if r != 0
        n_i = mod1(r + i, x)
        X[n_i] += 1
      end
      X[i] = X[i] - 1
    end
  end
end

function game(x::Int64, y::Int64)
  X = ones(Int64, x)
  X = y * X
  turn = 0
  nil = count(i -> (i == 0), X)
  while nil < (x - 1)
    turn += 1
    i = mod1(turn, x)
    turn!(X, i, x)
  end
  return turn
end

x = 1
y = 3

t = game(x, y)
