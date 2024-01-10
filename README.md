# Ahead

[![Build Status](https://github.com/thierrymoudiki/Ahead.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/thierrymoudiki/Ahead.jl/actions/workflows/CI.yml?query=branch%3Amain)



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

