# Use the official Julia 1.6 base image
FROM julia:1.10

# Set the working directory inside the container
WORKDIR /app

# Install R and R development packages
RUN apt-get update && apt-get upgrade && apt-get install -y \
    r-base \
    r-base-dev
RUN apt install gfortran
RUN apt-get install libcurl4-openssl-dev
RUN apt install curl
RUN Rscript -e "try(utils::install.packages('remotes', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('curl', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('ranger', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"            
RUN Rscript -e "try(utils::install.packages('e1071', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"            
RUN Rscript -e "try(utils::install.packages('fBasics', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"        
RUN Rscript -e "try(utils::install.packages('fGarch', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"    
RUN Rscript -e "try(utils::install.packages('foreach', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('randtoolbox', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('Rcpp', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('snow', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('VineCopula', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('tseries', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('forecast', repos='https://cran.rstudio.com', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(remotes::install_github('robjhyndman/forecast', dependencies=TRUE), silent=TRUE)"
RUN Rscript -e "try(utils::install.packages('ahead', repos='https://techtonique.r-universe.dev', dependencies=TRUE), silent=TRUE)"

# Copy all files from the current directory to /app in the container
COPY . .

# Install specific Julia packages, but only if the Project.toml or Manifest.toml changes
RUN julia --project=/app -e 'using Pkg; Pkg.add("RCall"); Pkg.add("Distributions"); Pkg.add("Random")'

# Run Julia commands during the image build process
# Set the project to /app and instantiate dependencies
RUN julia --project=/app -e 'using Pkg; Pkg.instantiate(); Pkg.build()'

# Specify the default command to run when the container starts
CMD ["julia", "--project=/app", "-e", "using Pkg; Pkg.test()"]
