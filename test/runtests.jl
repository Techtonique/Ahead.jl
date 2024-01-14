using Ahead
using Test

@testset "Ahead.jl" begin	
    
    @testset "----- 1 - Testing dynrmf -----" begin
        val = Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10], h=6)
        println(val) 
        @test isapprox(round(val[:residuals][1]), 0)
        @test val[:method] == "DynRM 1"
    end 
    
    @testset "----- 2 - Testing ridge2f -----" begin
        y = rand(8, 2)
        val = Ahead.ridge2f(y, h=4)
        println(val) 
        @test val[:x] == y
        @test val[:method] == "ridge2"
    end 

end 
