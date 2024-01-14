module Ahead	

	# exports 
	export dynrmf
	export ridge2f
		
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
			run(`sudo Rscript -e "utils::install.packages('foreach', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('Rcpp', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('snow', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('forecast', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('randtoolbox', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('VineCopula', repos='https://cran.rstudio.com', dependencies=TRUE)"`)
			run(`sudo Rscript -e "utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', dependencies=TRUE)"`)
		catch e1		
			try 	
				run(`sudo Rscript -e "install.packages('foreach', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('Rcpp', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('snow', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('forecast', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('randtoolbox', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
				run(`sudo Rscript -e "install.packages('VineCopula', repos='https://cran.rstudio.com', lib= '.', dependencies=TRUE)"`)
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
	
	function dynrmf(y, h)					
		return rcopy(R"try(ahead::dynrmf(y=$y, h=$h), silent = TRUE)")	
	end 	

	function ridge2f(y, h)					
		return rcopy(R"try(ahead::ridge2f(y=$y, h=$h), silent = TRUE)")	
	end 	
end

