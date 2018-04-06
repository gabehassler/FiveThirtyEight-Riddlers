function plane{T<:AbstractFloat}(p1::Vector{T}, p2::Vector{T}, p3::Vector{T})
  v2 = p2 - p1
  v3 = p3 - p1
  coeffs = cross(v2, v3)
  sol = p1' * coeffs
  sol = sol[1]
  return coeffs, sol
end

function distance{T<:Number}(p1::Vector{T}, p2::Vector{T})
  t = 0.0
  for i in 1:length(p1)
    t += (p1[i] - p2[i])^2
  end
  return sqrt(t)
end

function Mdist(M::Array{Float64, 2})
  s = size(M, 1)
  A = zeros(s, s)
  for i in 1:s
    for j in 1:s
      A[i, j] = distance(M[i,:], M[j,:])
    end
  end
  return A
end


points = [2/sqrt(3) 0 0;
          -1/sqrt(3) 1 0;
          -1/sqrt(3) -1 0
          0 0 2*sqrt(6)/3]

v1 = points[1,:] - points[4,:]
v2 = points[2,:] - points[4,:]
v3 = points[3,:] - points[4,:]

d3 = normalize(cross(v1, v2))
d2 = normalize(cross(v3, v1))
d1 = normalize(cross(v2, v3))
d4 = [0.0, 0.0, -1.0]

wings = [d1, d2, d3, d4]

Mc = zeros(4, 3)
X = zeros(4, 1)

for i in 1:4
  x = [1, 2, 3, 4]
  deleteat!(x, i)
  M = points[x, :]
  W = [wings[i]'; wings[i]'; wings[i]']
  N = M + W
  c, s = plane(N[1,:], N[2,:], N[3,:])
  Mc[i,:] = c
  X[i] = s
end

verteces = zeros(4, 3)

for i in 1:4
  x = [1, 2, 3, 4]
  deleteat!(x, i)
  M = Mc[x,:]
  s = X[x]
  y = inv(M) * s
  verteces[i,:] = y
end
