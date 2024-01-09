module Ahead		
	
	using RCall

	run(`sudo usermod -a -G staff $(whoami)`)
	R"options(repos = c(techtonique = 'https://techtonique.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'))"
	rc.reval("utils::install.packages('ahead', dependencies=TRUE)")	

	@rimport base as rbase
	@rimport ahead as rahead

	function foo(x)
		rbase.sum([1, 2, 3], var"rm.na" = true)
	end 

	# exports 
	export foo 

end
