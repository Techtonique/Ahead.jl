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
			println("Either R is already installed, or can't be installed on this machine (check manually): https://cloud.r-project.org/")
		end
	end
	
	# Run the `which R` command to get the path to the R executable
	output = strip(chomp(read(`which R`, String)))

	# Check if the output is not an empty string (R executable path found)
	if output != ""
		# Set the obtained R executable path to ENV["R_HOME"]
		ENV["R_HOME"] = output
		println("R_HOME set to: ", ENV["R_HOME"])
	else
		println("R executable not found on this machine. Please install R (https://cloud.r-project.org/) and try again.")
	end

	using RCall

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

	if Sys.isapple()
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
		
	R"load_ahead <- try(library(ahead), silent = TRUE)"
	R"if(inherits(load_ahead, 'try-error')) {library(ahead, lib.loc='.')}"		
	
	# univariate -----
	function armagarchf(y; h=5, level=95)
		return rcopy(R"ahead::armagarchf(y=$y, h=$h, level=$level)")	
	end

	function eatf(y; h=5, level=95)
		return rcopy(R"ahead::eatf(y=$y, h=$h, level=$level)")	
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

	function loessf(y; h=5, level=95)					
		return rcopy(R"ahead::loessf(y=$y, h=$h, level=$level)")	
	end 	

	# multivariate -----
	function basicf(y; h=5, level=95)					
		return rcopy(R"ahead::basicf(y=$y, h=$h, level=$level)")	
	end 

	function ridge2f(y; h=5, level=95)					
		return rcopy(R"ahead::ridge2f(y=$y, h=$h, level=$level)")	
	end 
	
	function varf(y; h=5, level=95)					
		return rcopy(R"ahead::varf(y=$y, h=$h, level=$level)")	
	end 
	
end

