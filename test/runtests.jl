using Ahead
using Test

@testset "Ahead.jl" begin
	val = Ahead.foo(1)
    @test  round(val['residuals'][1]; digits=1) == 0.0
end
