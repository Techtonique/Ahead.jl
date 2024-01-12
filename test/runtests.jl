using Ahead
using Test

@testset "Ahead.jl" begin
	val = Ahead.foo(1)
    print(val['residuals'][1])
    @test isapprox(val['residuals'][1], 0)
end
