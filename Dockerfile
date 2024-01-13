# Use the official Julia 1.6 base image
FROM julia:1.10

# Set the working directory inside the container
WORKDIR /app

# Install R and R development packages
RUN apt-get update && apt-get install -y \
    r-base \
    r-base-dev

# Copy all files from the current directory to /app in the container
COPY . .

# Install specific Julia packages, but only if the Project.toml or Manifest.toml changes
RUN julia --project=/app -e 'using Pkg; Pkg.add("RCall"); Pkg.add("Distributions"); Pkg.add("Random")'

# Run Julia commands during the image build process
# Set the project to /app and instantiate dependencies
RUN julia --project=/app -e 'using Pkg; Pkg.instantiate(); Pkg.build()'

# Specify the default command to run when the container starts
CMD ["julia", "--project=/app", "-e", "using Pkg; Pkg.test()"]