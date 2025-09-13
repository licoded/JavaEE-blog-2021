# --- STAGE 1: Build ---
# 使用一个包含 Maven 和 Java 17 的官方镜像作为构建环境
FROM maven:3.8-openjdk-8-slim AS builder

# 设置工作目录
WORKDIR /app

# 复制 pom.xml 并下载依赖。这一步可以利用 Docker 的缓存机制，
# 只有当 pom.xml 变化时才会重新下载依赖。
COPY pom.xml .
RUN mvn dependency:go-offline

# 复制所有源代码
COPY src ./src

# 执行打包命令，跳过测试
RUN mvn clean package -DskipTests

# --- STAGE 2: Run ---
# 使用一个非常小的、只包含 Java 运行环境的镜像
FROM openjdk:8-jre-slim

WORKDIR /app

# 从 builder 阶段复制打包好的 jar 文件
# 注意路径中的 target/*.jar 可能需要根据您项目的实际情况调整
COPY --from=builder /app/target/*.jar app.jar

# 暴露 Spring Boot 应用的端口
EXPOSE 8080

# 容器启动时运行 jar 包
ENTRYPOINT ["java", "-jar", "app.jar"]