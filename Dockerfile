#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

# original
#FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base 
# tests
#FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS base 
FROM mcr.microsoft.com/dotnet/runtime:6.0-windowsservercore-ltsc2022 AS base 
#FROM mcr.microsoft.com/windows/servercore:ltsc2022-amd64 AS base 
#FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base 
#FROM mcr.microsoft.com/windows/servercore:20H2 AS base 
#FROM mcr.microsoft.com/dotnet/runtime:6.0-windowsservercore-ltsc2019 AS base


WORKDIR /app

#original
#FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
#test
FROM mcr.microsoft.com/dotnet/sdk:6.0-windowsservercore-ltsc2022 AS build
#FROM mcr.microsoft.com/windows/servercore:ltsc2022-amd64 AS build 
#FROM mcr.microsoft.com/dotnet/runtime:6.0 AS build
#FROM mcr.microsoft.com/windows/servercore:20H2 AS build
#FROM mcr.microsoft.com/dotnet/sdk:6.0-windowsservercore-ltsc2019 AS build
#FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS build 

WORKDIR /src
COPY ["DotNetConsoleApp.csproj", "."]
RUN dotnet restore "./DotNetConsoleApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DotNetConsoleApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DotNetConsoleApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotNetConsoleApp.dll"]