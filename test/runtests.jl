using Ahead
using Test

@testset "Ahead.jl" begin
	
    val = Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10], 6)
    println(val) 
    @test isapprox(round(val[:residuals][1]), 0)

    y = rand(8, 2)
    val = Ahead.ridge2f(y, 4)
    println(val) 
    @test val[:x] == y

end
