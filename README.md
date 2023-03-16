
## 1. Create a new Julia environment and add the required packages.
```bash
mkdir ArgParse_CSV_DataFrames_FileIO
cd ArgParse_CSV_DataFrames_FileIO && julia -e 'using Pkg; Pkg.activate("."); Pkg.add(["ArgParse", "CSV", "DataFrames", "FileIO"]);'
```

## 2. Create the Dockerfile like this:

```Docker
FROM julia:latest
WORKDIR /env
COPY . .
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.precompile()'
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
```

and modify the entrypoint to reflect the required packages:

```bash
#!/bin/bash

# Set JULIA_PROJECT environment variable
export JULIA_PROJECT="/env"

# If no arguments are provided, start an interactive Julia session with the specified packages loaded
if [ "$#" -eq 0 ]; then
    julia -i --eval "using Pkg; Pkg.activate(\"/env\"); using ArgParse; using CSV; using DataFrames; using FileIO;" --banner=no
else
    # Execute the provided command with arguments
    exec "$@"
fi
```


## 3. build and push

to build (tag should be the installed packages):
```bash
docker build -t plaquette/julia_helper:ArgParse_CSV_DataFrames_FileIO .
```

to push (tag should be the installed packages)
```bash
docker push plaquette/julia_helper:ArgParse_CSV_DataFrames_FileIO  
 ```


## 4. run it
interactiv:
```bash
docker run -it plaquette/julia_helper:ArgParse_CSV_DataFrames_FileIO
```

or with a mounted script:
```bash
docker run -it -v "$(pwd):/scripts" plaquette/julia_helper:ArgParse_CSV_DataFrames_FileIO julia /scripts/wrapper.jl --i=/scripts/ref_coli.fa --k=10 --w=100 
 ```