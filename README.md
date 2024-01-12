# Ahead

[![Build Status](https://github.com/Techtonique/Ahead.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Techtonique/Ahead.jl/actions/workflows/CI.yml?query=branch%3Amain) [![HitCount](https://hits.dwyl.com/Techtonique/Aheadjl.svg?style=flat-square)](http://hits.dwyl.com/Techtonique/Aheadjl)

**Univariate and multivariate time series forecasting, with uncertainty quantification**.

## Installation

From GitHub (for now):

```julia
julia> using Pkg; Pkg.add("https://github.com/Techtonique/Ahead.jl")
````

Ultimately:

```julia
julia> using Pkg; Pkg.add("Ahead")
```

## Usage

```julia
julia> using Ahead
julia> print(Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10]))
```

## Note to self or developers

- Install `RCall`: https://juliainterop.github.io/RCall.jl/stable/installation/
- Getting started with `RCall`: https://juliainterop.github.io/RCall.jl/latest/gettingstarted.html
- Julia `RCall`: https://www.geeksforgeeks.org/julia-rcall/

```R
$ rm -rf ~/.julia/compiled # for clear cache
$ rm -rf ~/.julia/lib # for clear cache
julia> using Pkg; Pkg.rm("Ahead")
pkg> rm Ahead 
julia> using Pkg; Pkg.add(path="https://github.com/Techtonique/Ahead.jl")
julia> using Pkg; Pkg.update("Ahead")
pkg> activate Ahead
```

