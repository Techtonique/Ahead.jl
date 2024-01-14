using Ahead
using Test

@testset "Ahead.jl" begin
	
    @testset "----- 1 - Testing for univariate time series -----" begin
        @testset "----- 1 - 1 Testing dynrmf -----" begin
            val = Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10], 6)
            println(val) 
            @test isapprox(round(val[:residuals][1]), 0)
        end 
    end 
    
    @testset "----- 2 - Testing for multivariate time series -----" begin
        @testset "----- 2 - 1 Testing ridge2f -----" begin
            y = rand(8, 2)
            val = Ahead.ridge2f(y, 4)
            println(val) 
            @test val[:x] == y
        end 
    end 

end
