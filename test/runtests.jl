using Ahead
using Test

@testset "Ahead.jl" begin
	val = Ahead.foo(1)    
    print(val)
    @test isapprox(round(val[:residuals][1]), 0)
end
