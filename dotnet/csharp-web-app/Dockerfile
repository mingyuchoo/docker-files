# Step 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /src

# Copy the project files and restore dependencies
COPY . .
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o /release

# Step 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /release

# Copy the built application from the build image
COPY --from=build /release .

# Expose the port the release runs on
EXPOSE 8080

# Set the entry point for the application
ENTRYPOINT ["dotnet", "csharp-web-app.dll"]
