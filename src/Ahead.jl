module Ahead	

	# exports 
	export dynrmf
	export ridge2f
		
	if Sys.islinux()		
		run(`ls -la`)
		run(`sudo apt update`)
		run(`sudo apt install r-base r-base-dev -y`)
		run(`sudo apt-get install libcurl4-openssl-dev`)
		run(`sudo apt update`)
		run(`sudo apt upgrade`)
		run(`Rscript --version`)
		username = strip(chomp(read(`whoami`, String)))
		run(`sudo chown -R $username:$username /usr/local/lib/R/site-library`) # check permissions
	end	
	
	# Run the `which R` command to get the path to the R executable
	output = strip(chomp(read(`which R`, String)))

	# Check if the output is not an empty string (R executable path found)
	if output != ""
		# Set the obtained R executable path to ENV["R_HOME"]
		ENV["R_HOME"] = output
		println("R_HOME set to: ", ENV["R_HOME"])
	else
		println("R executable not found.")
	end

	using RCall

	if Sys.islinux()
		username = strip(chomp(read(`whoami`, String)))
		run(`sudo usermod -aG staff $username`)
	end

	if Sys.islinux() || Sys.isapple()
		try		
			run(`sudo Rscript -e "utils::install.packages('foreach', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('Rcpp', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('snow', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('forecast', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', dependencies=TRUE)"`)
		catch e			
			run(`sudo Rscript -e "install.packages('foreach', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
			run(`sudo Rscript -e "install.packages('Rcpp', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
			run(`sudo Rscript -e "install.packages('snow', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
			run(`sudo Rscript -e "install.packages('forecast', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', lib= '.', dependencies=TRUE)"`)
		end	
	end
		
	R"load_ahead <- try(library(ahead), silent = TRUE)"		
	
	# univariate time series forecasting models ----------------------------------------------

	""" 
	Dynamic regression model (see https://techtonique.r-universe.dev/ahead/doc/manual.html#dynrmf)

	# Details

	For now, the function uses only Ridge regression with automatic selection of the regularization parameter.

	# Examples

	```julia
	using Ahead
	val = Ahead.dynrmf([1,2,3,4,5,6,7,8,9,10], h = 5, level = 95)   
	println(val)
	````

	"""
	function dynrmf(y, h = 5, level = 95)	
		r_code = """
		ahead::dynrmf(y = $y, h = $h, level = $level)
		"""					
		return rcopy(R"$r_code")	
	end 	

	# multivariate time series forecasting models ---------------------------------------------- 

	"""
	Random Vector functional link (RVFL) nnetwork model with 2 regularization parameters (see https://techtonique.r-universe.dev/ahead/doc/manual.html#ridge2f)

	# Details

	The model is based on an RVFL model (see https://www.mdpi.com/2227-9091/6/1/22) with 2 regularization parameters, and provides some uncertainty quantification.

	# Examples

	```julia
	using Ahead
	using Distributions
	import Random
	Random.seed!(123)
	y = rand(100, 5)
	print(ridge2f(y, h = 5, level = 95))
	```

	""" 
	function ridge2f(
		y,
		xreg = nothing,
		h = 5,
		level = 95,
		lags = 1,
		nb_hidden = 5,
		nodes_sim = "sobol",
		activ = "relu",
		a = 0.01,
		lambda_1 = 0.1,
		lambda_2 = 0.1,
		dropout = 0,
		type_forecast = "recursive",
		type_pi = "gaussian",
		block_length = nothing,
		margins = "gaussian",
		seed = 1,
		B = 100,
		type_aggregation = "mean",
		centers = nothing,
		type_clustering = "kmeans",
		ym = nothing,
		cl = 1,
		show_progress = true,
		args...
	  )

	  if xreg == nothing
		xreg = RNULL()
	  end

	  if block_length == nothing	
		block_length = RNULL()
	  end

	  if centers == nothing
		centers = RNULL()
	  end

	  if ym == nothing
		ym = RNULL()
	  end
	  
	  r_code = """
	  ahead::ridge2f(y = $y, xreg = $xreg, h = $h, 
	  level = $level, lags = $lags, nb_hidden = $nb_hidden, 
	  nodes_sim = $nodes_sim, activ = $activ, a = $a, 
	  lambda_1 = $lambda_1, lambda_2 = $lambda_2, 
	  dropout = $dropout, type_forecast = $type_forecast,
	  type_pi = $type_pi, block_length = $block_length, 
	  margins = $margins, seed = $seed, B = $B, 
	  type_aggregation = $type_aggregation, 
	  centers = $centers, type_clustering = $type_clustering, 
	  ym = $ym, cl = $cl, show_progress = $show_progress, 
	  $args...)
	  """

	  return rcopy(R"$r_code")

	end 

end

