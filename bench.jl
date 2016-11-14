using ParallelAccelerator

@acc avg1(x) = [ 0.25*x[i-1] + 0.5*x[i] + 0.25*x[i+1] for i = 2:length(x) - 1 ]
@inline avg2(x) = [ 0.25*x[i-1] + 0.5*x[i] + 0.25*x[i+1] for i = 2:length(x) - 1 ]

@printf "@acc"
@time avg1(collect(1:100000000))
@printf "normal"
@time avg2(collect(1:100000000))