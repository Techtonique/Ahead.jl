module Ahead	

	# exports 
	export foo 
	
	if Sys.islinux()		
		run(`ls -la`)
		run(`sudo apt update`)
		run(`sudo apt install r-base r-base-dev -y`)
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

	R"options(repos = c(techtonique = 'https://techtonique.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'))"
	R"install_ahead <- try(utils::install.packages('ahead', dependencies=TRUE), silent = TRUE)"
	R"if(inherits(install_ahead, 'try-error')) { print('find or create another lib destination, ask ChatGPT')}"	
	R"load_ahead <- try(library(ahead), silent = TRUE)"
	
	function foo(x)
		# https://juliainterop.github.io/RCall.jl/stable/custom/#Nested-conversion
		print("in function 'foo'")		
			try
				res = rcopy(R"try(ahead::dynrmf(c(1, 2, 3, 4, 5)), silent = TRUE)")	
			finally					
				res = 0
			end
		return res
	end 	

end;