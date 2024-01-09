using Ahead
using Test

@testset "Ahead.jl" begin
	val = Ahead.foo(1)
    @test  val == 0
end
