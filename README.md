# Ahead

Univariate and multivariate time series forecasting with uncertainty quantification (including simulation).

[![Build Status](https://github.com/Techtonique/Ahead.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Techtonique/Ahead.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Documentation

This package is a Julia wrapper for [R package `ahead`](https://github.com/Techtonique/ahead), 
and it follows its API as closely as possible: see https://techtonique.r-universe.dev/ahead#reference for details. 

## Installation

```julia
julia> using Pkg; Pkg.add(path = "https://github.com/Techtonique/Ahead.jl")
```

## Examples

```julia
using Ahead
y = [1,2,3,4,5,6,7,8,9,10]
z = rand(8, 2)
u = rand(50)
```

Univariate forecasting with [`dynrmf`](https://techtonique.r-universe.dev/ahead/doc/manual.html#dynrmf), Dynamic regression model

```julia
val1 = Ahead.dynrmf(y, h=6)
println(val1) 
```

Multivariate forecasting with [`ridge2f`](https://techtonique.r-universe.dev/ahead/doc/manual.html#ridge2f), Random Vector functional link network model with 2 regularization parameters (see https://www.mdpi.com/2227-9091/6/1/22)

```julia
val2 = Ahead.ridge2f(z, h=4)
println(val2) 
```

## TODO

- Use TimeSeries.jl (https://juliastats.org/TimeSeries.jl/stable/)


## Note to self or developers

### Docker 

```
docker build -t ahead .&&docker run ahead 
```

### Install locally

- Install `RCall`: https://juliainterop.github.io/RCall.jl/stable/installation/
- Getting started with `RCall`: https://juliainterop.github.io/RCall.jl/latest/gettingstarted.html
- Julia `RCall`: https://www.geeksforgeeks.org/julia-rcall/

```R
$ rm -rf ~/.julia/compiled # clearing cache
$ rm -rf ~/.julia/lib # clearing cache
julia> using Pkg; Pkg.rm("Ahead")
pkg> rm Ahead 
julia> using Pkg; Pkg.add(path="https://github.com/Techtonique/Ahead.jl")
julia> using Pkg; Pkg.update("Ahead")
pkg> activate Ahead
```

