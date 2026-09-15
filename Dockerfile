# Usa a imagem oficial do Eclipse Temurin com Java 25
FROM eclipse-temurin:25-jdk

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de configuração do Maven e o wrapper
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./

# Dá permissão de execução ao Maven Wrapper e baixa as dependências (camada cacheada)
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copia o código-fonte restante do projeto
COPY src/ src/

# Expõe a porta padrão exigida pelo Render
EXPOSE 10000

# Executa o projeto diretamente via Spring Boot com a porta correta
CMD ["./mvnw", "spring-boot:run", "-Dspring-boot.run.arguments=--server.port=10000"]
