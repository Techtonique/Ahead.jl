module Ahead	

	# exports 
	export armagarchf
	export basicf
	export dynrmf
	export eatf
	export loessf
	export ridge2f
	export varf
		
	if Sys.islinux()	
		try	
			#run(`ls -la`)
			run(`sudo apt update`)
			run(`sudo apt upgrade`)
			run(`sudo apt install r-base r-base-dev -y`)
			run(`sudo apt install libcurl-dev`)
			run(`sudo apt install curl`)
			run(`sudo apt-get install libcurl4-openssl-dev`)
			run(`sudo apt install gfortran`)					
			run(`Rscript --version`)
			#username = strip(chomp(read(`whoami`, String)))
			#run(`sudo chown -R $username:$username /usr/local/lib/R/site-library`) # check permissions
		catch e
			println("Either R is already installed, or can't be installed on this machine (check manually: https://cloud.r-project.org/)")
		end 
	end	

	if Sys.isapple()
		try
			run(`brew update`)
			run(`brew install gcc`) # for gfortran
			run(`brew install r`)
			run(`Rscript --version`)
		catch e
			println("Either R is already installed, or can't be installed on this machine (check manually: https://cloud.r-project.org/)")
		end
	end

	if Sys.iswindows()
		try
			run(`Rscript --version`)
		catch e
			println("Either R is already installed, or can't be installed on this machine (check manually: https://cloud.r-project.org/)")
		end
	end
	
	if Sys.isapple() || Sys.islinux() || Sys.iswindows()
		# Run the `which R` command to get the path to the R executable
		output = strip(chomp(read(`which R`, String)))
		# Check if the output is not an empty string (R executable path found)
		if output != ""
			# Set the obtained R executable path to ENV["R_HOME"]
			ENV["R_HOME"] = output
			println("R_HOME is: ", ENV["R_HOME"])
		else
			println("R executable not found on this machine. Please install R (https://cloud.r-project.org/) and try again.")
		end
	end

	using RCall
	using TimeSeries
	using Dates

	if Sys.islinux()
		try 
			username = strip(chomp(read(`whoami`, String)))
			run(`sudo usermod -aG staff $username`)
		catch e
			println("Can't define as staff")
		end
	end

	if Sys.islinux()
		try	
			run(`sudo Rscript -e "utils::install.packages('remotes', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('curl', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('e1071', repos='https://cran.rstudio.com', dependencies=TRUE)"`)				
			run(`sudo Rscript -e "utils::install.packages('ranger', repos='https://cran.rstudio.com', dependencies=TRUE)"`)				
			run(`sudo Rscript -e "utils::install.packages('fGarch', repos='https://cran.rstudio.com', dependencies=TRUE)"`)	
			run(`sudo Rscript -e "utils::install.packages('foreach', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('curl', repos='https://cran.rstudio.com', dependencies=TRUE)"`)							
			run(`sudo Rscript -e "utils::install.packages('randtoolbox', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('Rcpp', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('snow', repos='https://cran.rstudio.com', dependencies=TRUE)"`)						
			run(`sudo Rscript -e "utils::install.packages('VineCopula', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('tseries', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "try(utils::install.packages('forecast', repos='https://cran.rstudio.com', dependencies=TRUE), silent = TRUE)"`)
			run(`sudo Rscript -e "try(remotes::install_github('robjhyndman/forecast', dependencies=TRUE), silent = TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', dependencies=TRUE)"`)
		catch e1		
			try 
				run(`sudo Rscript -e "install.packages('remotes', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`sudo Rscript -e "install.packages('curl', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`sudo Rscript -e "install.packages('e1071', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`sudo Rscript -e "install.packages('ranger', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`sudo Rscript -e "install.packages('fGarch', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)					
				run(`sudo Rscript -e "install.packages('foreach', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('curl', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)									
				run(`sudo Rscript -e "install.packages('randtoolbox', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('Rcpp', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('snow', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('VineCopula', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('tseries', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "try(install.packages('forecast', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE), silent = TRUE)"`)												
				run(`sudo Rscript -e "try(remotes::install_github('robjhyndman/forecast', lib= '.', dependencies=TRUE), silent = TRUE)"`)
				run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', lib= '.', dependencies=TRUE)"`)
			catch e2
				println("Done trying to install R packages")
			end 
		finally 
			println("Done trying to install R packages")
		end	
	end

	if Sys.isapple() || Sys.iswindows()
		try	
			run(`Rscript -e "utils::install.packages('remotes', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "utils::install.packages('curl', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "utils::install.packages('e1071', repos='https://cran.rstudio.com', dependencies=TRUE)"`)				
			run(`Rscript -e "utils::install.packages('ranger', repos='https://cran.rstudio.com', dependencies=TRUE)"`)				
			run(`Rscript -e "utils::install.packages('fGarch', repos='https://cran.rstudio.com', dependencies=TRUE)"`)	
			run(`Rscript -e "utils::install.packages('foreach', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "utils::install.packages('curl', repos='https://cran.rstudio.com', dependencies=TRUE)"`)							
			run(`Rscript -e "utils::install.packages('randtoolbox', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "utils::install.packages('Rcpp', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "utils::install.packages('snow', repos='https://cran.rstudio.com', dependencies=TRUE)"`)						
			run(`Rscript -e "utils::install.packages('VineCopula', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "utils::install.packages('tseries', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`Rscript -e "try(utils::install.packages('forecast', repos='https://cran.rstudio.com', dependencies=TRUE), silent = TRUE)"`)
			run(`Rscript -e "try(remotes::install_github('robjhyndman/forecast', dependencies=TRUE), silent = TRUE)"`)
			run(`Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', dependencies=TRUE)"`)
		catch e1		
			try 
				run(`Rscript -e "install.packages('remotes', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`Rscript -e "install.packages('curl', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`Rscript -e "install.packages('e1071', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`Rscript -e "install.packages('ranger', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`Rscript -e "install.packages('fGarch', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)					
				run(`Rscript -e "install.packages('foreach', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`Rscript -e "install.packages('curl', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)					
				run(`Rscript -e "try(install.packages('forecast', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE), silent = TRUE)"`)												
				run(`Rscript -e "install.packages('randtoolbox', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`Rscript -e "install.packages('Rcpp', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`Rscript -e "install.packages('snow', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`Rscript -e "install.packages('VineCopula', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`Rscript -e "try(remotes::install_github('robjhyndman/forecast', lib= '.', dependencies=TRUE), silent = TRUE)"`)
				run(`Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', lib= '.', dependencies=TRUE)"`)
			catch e2
				println("Done trying to install R packages")
			end 
		finally 
			println("Done trying to install R packages")
		end	
	end
		
	R"""
	load_ahead <- NULL
	load_ahead2 <- NULL
	load_ahead3 <- NULL
	load_ahead4 <- NULL

	load_ahead <- try(library('ahead'),
					silent = TRUE)

	if (inherits(load_ahead, 'try-error'))
	{
	load_ahead2 <- try(library('ahead',
								lib.loc = '.'),
						silent = TRUE)
	}

	if (inherits(load_ahead2, 'try-error')) {
	try(utils::install.packages(c('foreach', 'snow', 'Rcpp'), 
								dependencies = TRUE), 
		silent = TRUE)
	try(utils::install.packages("ahead", 
								dependencies = TRUE,
								repos = 'https://techtonique.r-universe.dev'),
		silent = TRUE)
	load_ahead3 <- try(library('ahead'),
						silent = TRUE)
	} 

	if (inherits(load_ahead3, 'try-error')) {
	try(utils::install.packages(c('foreach', 'snow', 'Rcpp'), 
								dependencies = TRUE, lib='.'), 
		silent = TRUE)
	try(utils::install.packages("ahead", 
								dependencies = TRUE,
								repos = 'https://techtonique.r-universe.dev', lib = '.'),
		silent = TRUE)
	load_ahead4 <- try(library('ahead', 
								dependencies = TRUE,
								lib.loc = '.'),
						silent = TRUE)
	} 

	list_err <- list(load_ahead, load_ahead2, load_ahead3, load_ahead4)

	if (all(sapply(list_err, function(x) inherits(x, 'try-error')))) {
	stop(
		'Please install the ahead package (first) manually from https://techtonique.r-universe.dev)'
	)
	}  
	"""
	
	# TimeArray helpers -----

	# Infer the step between observations from the last two timestamps.
	# Falls back to the modal step over the whole series if the tail
	# looks irregular, since forecasting needs a single step to project.
	function _infer_step(ts::Vector{<:TimeType})
		length(ts) < 2 && error("Need at least 2 timestamps to infer a step")
		diffs = diff(ts)
		tail_step = diffs[end]
		if all(==(tail_step), diffs)
			return tail_step
		else
			counts = Dict{eltype(diffs),Int}()
			for d in diffs
				counts[d] = get(counts, d, 0) + 1
			end
			return first(sort(collect(counts), by=x -> -x[2]))[1]
		end
	end

	# Project `h` future timestamps starting one step after the last
	# observation of `ta`, using the (inferred) regular step size.
	function forecast_dates(ta::TimeArray, h::Int)
		ts_ = timestamp(ta)
		step = _infer_step(ts_)
		return [ts_[end] + step * i for i in 1:h]
	end

	# Best-effort extraction of mean/lower/upper from whatever `rcopy`
	# handed back (NamedTuple- or Dict-like). Field names follow the
	# `ahead`/`forecast`-style R convention; verify against a live call
	# if the underlying R package changes its return structure.
	function _extract_bounds(res)
		getfield_or(k) = haskey(res, k) ? res[k] : getproperty(res, k)
		mean_ = getfield_or(:mean)
		lower_ = getfield_or(:lower)
		upper_ = getfield_or(:upper)
		return vec(mean_), vec(lower_), vec(upper_)
	end

	# Wrap a univariate forecast result into a TimeArray with projected
	# dates and mean/lower/upper columns.
	function _forecast_to_timearray(ta::TimeArray, res, h::Int)
		mean_, lower_, upper_ = _extract_bounds(res)
		dates = forecast_dates(ta, h)
		return TimeArray(dates, hcat(mean_, lower_, upper_), [:mean, :lower, :upper])
	end

	# univariate -----
	function armagarchf(y; h=5, level=95)
		return rcopy(R"ahead::armagarchf(y=$y, h=$h, level=$level)")	
	end

	function armagarchf(ta::TimeArray; h=5, level=95)
		res = armagarchf(vec(values(ta)); h=h, level=level)
		return _forecast_to_timearray(ta, res, h)
	end

	function eatf(y; h=5, level=95)
		return rcopy(R"ahead::eatf(y=$y, h=$h, level=$level)")	
	end

	function eatf(ta::TimeArray; h=5, level=95)
		res = eatf(vec(values(ta)); h=h, level=level)
		return _forecast_to_timearray(ta, res, h)
	end

	function dynrmf(y; h=5, level=95, method="autoridge", kwargs...)
		
		if method == "autoridge"

			return rcopy(R"ahead::dynrmf(y=$y, h=$h, level=$level)")					

		elseif method == "svm"

			kwargs = Dict(kwargs)
			if haskey(kwargs, "kernel")
				kernel = kwargs["kernel"]
			else
				kernel = "radial"
			end
			R"""
			params <- list()
			params[['kernel']] <- $kernel
			z <- ahead::dynrmf(fdeaths, h=20, level=95, fit_func = e1071::svm,
			fit_params = params, predict_func = predict)
			"""
			return rcopy(R"z")

		elseif method == "randomforest"

			kwargs = Dict(kwargs)
			if haskey(kwargs, "num_trees")
				num_trees = kwargs["num_trees"]
			else
				num_trees = 500
			end
			R"""
			fit_func <- function(x, y, ...)
			{
			df <- data.frame(y=y, x) # naming of columns is mandatory for `predict`
			ranger::ranger(y ~ ., data=df, ...)
			};			
			predict_func <- function(obj, newx)
			{
			colnames(newx) <- paste0("X", 1:ncol(newx)) # mandatory, linked to df in fit_func
			predict(object=obj, data=newx)[['predictions']] # only accepts a named newx
			};			
			params <- list()
			params[['num.trees']] <- $num_trees
			z <- ahead::dynrmf(y=$y, h=$h, level=$level, 
							fit_func = fit_func,
							fit_params = params,
							predict_func = predict_func);
			"""
			return rcopy(R"z")					

		end	
	end 	

	function dynrmf(ta::TimeArray; h=5, level=95, method="autoridge", kwargs...)
		res = dynrmf(vec(values(ta)); h=h, level=level, method=method, kwargs...)
		return _forecast_to_timearray(ta, res, h)
	end

	function loessf(y; h=5, level=95)					
		return rcopy(R"ahead::loessf(y=$y, h=$h, level=$level)")	
	end 	

	function loessf(ta::TimeArray; h=5, level=95)
		res = loessf(vec(values(ta)); h=h, level=level)
		return _forecast_to_timearray(ta, res, h)
	end

	# multivariate -----

	# Wrap a multivariate forecast result into a NamedTuple of TimeArrays
	# (:mean, :lower, :upper), each an h x N array reusing the original
	# TimeArray's column names. A single TimeArray isn't used here since
	# it can't cleanly hold both the point forecast and the two bounds
	# for several variables at once without renaming every column.
	function _forecast_to_timearray_multivariate(ta::TimeArray, res, h::Int)
		mean_, lower_, upper_ = res.mean, res.lower, res.upper
		dates = forecast_dates(ta, h)
		cn = colnames(ta)
		return (
			mean = TimeArray(dates, mean_, cn),
			lower = TimeArray(dates, lower_, cn),
			upper = TimeArray(dates, upper_, cn),
		)
	end

	function basicf(y; h=5, level=95)					
		return rcopy(R"ahead::basicf(y=$y, h=$h, level=$level)")	
	end 

	function basicf(ta::TimeArray; h=5, level=95)
		res = basicf(values(ta); h=h, level=level)
		return _forecast_to_timearray_multivariate(ta, res, h)
	end

	function ridge2f(y; h=5, level=95)					
		return rcopy(R"ahead::ridge2f(y=$y, h=$h, level=$level)")	
	end 

	function ridge2f(ta::TimeArray; h=5, level=95)
		res = ridge2f(values(ta); h=h, level=level)
		return _forecast_to_timearray_multivariate(ta, res, h)
	end
	
	function varf(y; h=5, level=95)					
		return rcopy(R"ahead::varf(y=$y, h=$h, level=$level)")	
	end 

	function varf(ta::TimeArray; h=5, level=95)
		res = varf(values(ta); h=h, level=level)
		return _forecast_to_timearray_multivariate(ta, res, h)
	end
	
end
