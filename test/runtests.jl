using Ahead
using Test

@testset "Ahead.jl" begin
	val = Ahead.foo(1)    
    print(val)
    @test val == 0
end
