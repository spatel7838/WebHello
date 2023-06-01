FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "Hello.csproj"
RUN dotnet publish "Hello.csproj" -c Release -o /app/publish 

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Hello.dll"]

EXPOSE 5068

ENV ASPNETCORE_URLS=http://+:5068
