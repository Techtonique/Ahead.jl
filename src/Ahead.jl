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
			run(`ls -la`)
			run(`sudo apt update`)
			run(`sudo apt install r-base r-base-dev -y`)
			run(`sudo apt-get install libcurl4-openssl-dev`)
			run(`sudo apt update`)
			run(`sudo apt upgrade`)
			run(`Rscript --version`)
			username = strip(chomp(read(`whoami`, String)))
			run(`sudo chown -R $username:$username /usr/local/lib/R/site-library`) # check permissions
		catch e
			println("Either R is already installed, or can't be installed on this machine")
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
		println("R executable not found.")
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

	if Sys.islinux() || Sys.isapple()
		try	
			run(`sudo Rscript -e "utils::install.packages('remotes', repos='https://cran.rstudio.com', dependencies=TRUE)"`)	
			run(`sudo Rscript -e "utils::install.packages('fGarch', repos='https://cran.rstudio.com', dependencies=TRUE)"`)	
			run(`sudo Rscript -e "utils::install.packages('foreach', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('forecast', repos=' https://cloud.r-project.org', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('randtoolbox', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('Rcpp', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('snow', repos='https://cran.rstudio.com', dependencies=TRUE)"`)						
			run(`sudo Rscript -e "utils::install.packages('VineCopula', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "remotes::install_github('robjhyndman/forecast', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', dependencies=TRUE)"`)
		catch e1		
			try 
				run(`sudo Rscript -e "install.packages('remotes', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`sudo Rscript -e "install.packages('fGarch', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)	
				run(`sudo Rscript -e "install.packages('foreach', repos=' https://cloud.r-project.org', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('forecast', lib= '.', dependencies=TRUE)"`)												
				run(`sudo Rscript -e "install.packages('randtoolbox', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('Rcpp', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('snow', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('VineCopula', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "remotes::install_github('robjhyndman/forecast', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', lib= '.', dependencies=TRUE)"`)
			catch e2
				println("Can't run Rscript")
			end 
		finally 
			println("Can't run Rscript")
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

	function dynrmf(y; h=5, level=95)					
		return rcopy(R"ahead::dynrmf(y=$y, h=$h, level=$level)")	
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

