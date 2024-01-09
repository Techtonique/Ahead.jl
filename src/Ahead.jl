module Ahead		
	
	using Pkg

	Pkg.add('RCall')
	Pkg.build('RCall')

	using RCall

	if Sys.islinux()		
		username = strip(chomp(read(`whoami`, String)))
		run(`sudo usermod -aG staff $username`)
	end

	R"options(repos = c(techtonique = 'https://techtonique.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'))"
	reval("utils::install.packages('ahead', dependencies=TRUE)")	

	@rimport base as rbase
	@rimport ahead as rahead

	function foo(x)
		rbase.sum([1, 2, 3], var"rm.na" = true)
	end 

	# exports 
	export foo 

end
