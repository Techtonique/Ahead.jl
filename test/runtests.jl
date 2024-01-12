using Ahead
using Test

@testset "Ahead.jl" begin

    using Ahead
	using Distributions
	import Random

    # Test Ahead.dynrmf ----------------------------
	val = Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10])   
    @test isapprox(round(val[:residuals][1]), 0)
    
    # Test Ahead.ridge2f ----------------------------
	Random.seed!(123)
	y = rand(100, 5)
    val = Ahead.ridge2f(Dict("y" => y, "h" => 5, "level" => 95))
	@test val[:x] == y

end
