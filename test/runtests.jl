using Ahead
using Distributions
using Random
using Test

@testset "Ahead.jl" begin
	
    val = Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10], 6)
    println(val) 
    @test isapprox(round(val[:residuals][1]), 0)

    rng = MersenneTwister(1234);
    y = randexp(rng, 10, 3)
    val = Ahead.ridge2f(y, 6)
    println(val) 
    @test val[:x] == y

end
