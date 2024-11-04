# i base it on this
N=100
V0 = zeros(N, 1)
kmin = 0.0
kmax = 100
K= range(kmin, kmax, length=N)
tolerance=0.01
its = 0       # Initial iteration count
maxiteration=1000
V1 = zeros(N, 1)  # Storage for updated values
k11 = zeros(N, 1) # Storage for optimal choices
# Define the known parameter values
β = 0.99 # Example value for discount factor
α = 0.37 # Example capital share in production
δ = 0.021 # Example depreciation rate
#g=Matrix(N,maxiteration) but does not work so ignore the policy
function valfun(V0,K,α,δ,k0,β)
    c=-K.+k0^α.+(1-δ)*k0
    val = ifelse.(c .≤ 0, -888888888888888888 .- 800 .* abs.(c), (c)+β*V0 )
    return val
end
dif=Inf
# Main iteration loop
while dif > tolerance && its < maxiteration
    for i in 1:N
        k0 = K[i]  # we fix the capital 
        vals=valfun(V0,K,α,δ,k0,β) #calculate all values for potential choices
        V1[i] = maximum(vals) #set the value to the maxium achieved for all allowed grid choices of V
    end
    
    dif = maximum(V1 - V0)
    V0 .= V1  # Update v0 with the new values of v1
    its += 1
end


