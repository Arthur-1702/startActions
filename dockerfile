# Import dotnet SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
# Set the working directory
WORKDIR /app

# Copy all
COPY . ./
# Restore dependencies
RUN dotnet restore
# Build the application and publish it ( -c configuration, -o output)
RUN dotnet publish -c Release -o out

# Até aqui o Build 

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]