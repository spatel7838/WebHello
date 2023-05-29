FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 5068

ENV ASPNETCORE_URLS=http://+:5068


FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["Hello.csproj", "./"]
RUN dotnet restore "Hello.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Hello.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Hello.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Hello.dll"]
