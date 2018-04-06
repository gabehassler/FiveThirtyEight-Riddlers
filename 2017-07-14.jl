using PlotlyJS, HDF5

function pwin(n::Int64, p::Float64)
  t = 0.0
  m = Int((n - 1) / 2)
  for i in 0:m
    t += binomial(n, n-i) * p^(n-i) * (1-p)^i
  end
  return t
end

function winnings(n::Int64)
  return 1000000 - 10000 * Int((n + 1) / 2)
end

function comb(p::Float64)
  expected = Vector{Float64}()
  pairs = Vector{Pair}()
  for i in 1:2:65
    push!(pairs, i => pwin(i, p) * winnings(i))
    push!(expected, pwin(i, p) * winnings(i))
  end
  return expected, pairs
end

function find_best()
  xs = 0.0:.001:1.0
  ys = Vector{Int64}()
  for i in xs
    x, y = comb(i)
    index = findin(x, maximum(x))
    series = index[1] * 2 - 1
    push!(ys, series)
  end
  return xs, ys
end

function plot_data()
  xs, ys = find_best()
  trace = scatter(;x = xs,
                   y = ys,
                   mode = "lines")
  layout = Layout(;title = "Optimal Series Length",
                   xaxis=attr(title="Probability of Winning Each Game",
                              showgrid=false,
                              zeroline=true),
                   yaxis=attr(title="Series Length"),
                   legend = attr(x = .05, y = 2))
  p = plot(trace, layout)
  return p
end

function store_data()
  xs, ys = find_best()
  xs = collect(xs)
  file = h5open("Riddlers\\squishyball_data.h5", "w")
  g = g_create(file, "data")
  g["x"] = xs
  g["y"] = ys
  close(file)
end


function sim(n::Int64)
  t = 0
  for i in 1:n
    r = rand()
    if r <= .6
      t += 1
    end
  end
  if t >= Int((n+1)/2)
    return 1
  else
    return 0
  end
end

function sims(n::Int64)
  ps = Vector{Float64}()
  expected = Vector{Float64}()
  for i in 1:2:65
    display(i)
    t = 0
    for j in 1:n
      t += sim(i)
    end
    avg = t/n
    push!(ps, avg)
    push!(expected, avg * winnings(i))
  end
  return ps, expected
end
