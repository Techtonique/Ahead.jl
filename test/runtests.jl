using Ahead
using Test

@testset "Ahead.jl" begin	

    y = [1,2,3,4,5,6,7,8,9,10]
    z = rand(8, 2)
    u = rand(50)

    #@testset "----- Testing armagarchf -----" begin
    #     y = rand(25)
    #    val = Ahead.armagarchf(y, h=6)
    #     println(val) 
    #     @test val[:x] == y
    #     @test val[:method] == "ARMA(1, 1) - GARCH(1, 1)"
    #end 

    @testset "----- Testing basicf -----" begin        
        val = Ahead.basicf(z, h=4)
        println(val) 
        @test val[:x] == z
        @test val[:method] == "mean"
    end 

    @testset "----- Testing dynrmf (autoridge) -----" begin
        val = Ahead.dynrmf(y, h=6)
        println(val) 
        @test isapprox(round(val[:residuals][1]), 0)
        @test val[:method] == "DynRM 1"
    end
    
    #@testset "----- Testing dynrmf (svm) -----" begin
    #    val = Ahead.dynrmf(u, h=6, method="svm", kernel="linear")
    #    println(val) 
    #    #@test isapprox(round(val[:residuals][1]), 0)
    #    @test val[:x] == u
    #end

    #@testset "----- Testing dynrmf (ranger) -----" begin
    #    val = Ahead.dynrmf(u, h=6, method="randomforest", num_trees=50)
    #    println(val) 
    #    #@test isapprox(round(val[:residuals][1]), 0)
    #    @test val[:x] == u
    #end
    
    #@testset "----- Testing eatf -----" begin
    #    val = Ahead.eatf(y, h=6)
    #    println(val) 
    #    @test val[:x] == y
    #    @test val[:method] == "EAT"
    #end 

    @testset "----- Testing loessf -----" begin
        val = Ahead.loessf(y, h=6)
        println(val) 
        @test val[:x] == y
        @test val[:method] == "loessf"
    end 

    @testset "----- Testing ridge2f -----" begin        
        val = Ahead.ridge2f(z, h=4)
        println(val) 
        @test val[:x] == z
        @test val[:method] == "ridge2"
    end 

end
