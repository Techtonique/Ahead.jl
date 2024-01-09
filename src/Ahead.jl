module Ahead		
	
	import RCall as rc 

	rc.reval("options(repos = c(
    techtonique = 'https://techtonique.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'));    
	install.packages("ahead")")	

	@rimport base as rbase
	@rimport ahead as rahead

	function foo(x)
		rbase.sum([1, 2, 3], var"rm.na" = true)
	end 

	# exports 
	export foo 

end
