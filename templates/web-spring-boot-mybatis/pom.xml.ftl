<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<groupId>${projectName}</groupId>
	<artifactId>${projectName}</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>jar</packaging>

	<name>${projectName}</name>
	<description>${projectName}自动生成项目</description>

	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.4.3</version>
		<relativePath/> <!-- lookup parent from repository -->
	</parent>

	<properties>
        <java.version>1.8</java.version>
		<org.mapstruct.version>1.4.2.Final</org.mapstruct.version>
		<org.projectlombok.version>1.18.20</org.projectlombok.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
	</properties>

	<dependencies>

		<!--spring starter-->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-aop</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-validation</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-thymeleaf</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>

        <!--third party starter-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
            <version>1.1.10</version>
        </dependency>
		<dependency>
			<groupId>com.github.pagehelper</groupId>
			<artifactId>pagehelper-spring-boot-starter</artifactId>
			<version>1.3.0</version>
		</dependency>

		<#if (dbType!"")=="mysql">
		<!-- MySql -->
		<dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <scope>runtime</scope>
        </dependency>
		</#if>
		<#if (dbType!"")=="oracle">
		<!-- Oracle -->
		<dependency>
			<groupId>com.oracle.ojdbc</groupId>
			<artifactId>ojdbc8</artifactId>
			<version>19.3.0.0</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>com.oracle.ojdbc</groupId>
			<artifactId>orai18n</artifactId>
			<version>19.3.0.0</version>
			<scope>runtime</scope>
		</dependency>
		</#if>
		<#if (dbType!"")=="sqlserver">
		<!-- sqlserver -->
		<dependency>
            <groupId>com.hynnet</groupId>
            <artifactId>sqljdbc4-chs</artifactId>
            <version>4.0.2206.100</version>
			<scope>runtime</scope>
        </dependency>
		</#if>
		<#if (dbType!"")=="sqlite">
		<!-- sqlite-jdbc -->
		<dependency>
            <groupId>org.xerial</groupId>
            <artifactId>sqlite-jdbc</artifactId>
            <version>3.20.1</version>
			<scope>runtime</scope>
        </dependency>
		</#if>

		<!--jackson JSON -->
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-databind</artifactId>
		</dependency>

		<!--spring 配置-->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-configuration-processor</artifactId>
			<optional>true</optional>
		</dependency>

		<!--spring 测试-->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.restdocs</groupId>
			<artifactId>spring-restdocs-mockmvc</artifactId>
			<scope>test</scope>
		</dependency>

		<!--swagger 文档-->
        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-swagger-ui</artifactId>
            <version>2.10.5</version>
        </dependency>
        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-swagger2</artifactId>
            <version>2.10.5</version>
        </dependency>
        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-spring-webmvc</artifactId>
            <version>2.10.5</version>
        </dependency>
		<dependency>
			<groupId>com.github.xiaoymin</groupId>
			<artifactId>swagger-bootstrap-ui</artifactId>
			<version>1.9.6</version>
		</dependency>
		<#if hasLogin>

		<!-- 权限管理相关 spring shiro -->
		<dependency>
			<groupId>org.apache.shiro</groupId>
			<artifactId>shiro-spring</artifactId>
			<version>1.3.2</version>
		</dependency>

		<!-- JWT -->
		<dependency>
			<groupId>com.auth0</groupId>
			<artifactId>java-jwt</artifactId>
			<version>3.2.0</version>
		</dependency>
		</#if>

		<!-- 对象拷贝 -->
		<dependency>
			<groupId>org.mapstruct</groupId>
			<artifactId>mapstruct</artifactId>
			<version>${r'${org.mapstruct.version}'}</version>
		</dependency>
		<#if lang=="kotlin">
		<!--kotlin 语言-->
		<dependency>
			<groupId>org.jetbrains.kotlin</groupId>
			<artifactId>kotlin-stdlib-jdk8</artifactId>
		</dependency>
		<dependency>
			<groupId>org.jetbrains.kotlin</groupId>
			<artifactId>kotlin-reflect</artifactId>
		</dependency>
		<#else >
		<!-- 代码辅助 -->
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<optional>true</optional>
		</dependency>
		</#if>
		<#if features.has('network')>

		<!-- OK HTTP 网络请求-->
		<dependency>
			<groupId>com.squareup.retrofit2</groupId>
			<artifactId>retrofit</artifactId>
			<version>2.9.0</version>
		</dependency>
		<dependency>
			<groupId>com.squareup.retrofit2</groupId>
			<artifactId>converter-jackson</artifactId>
			<version>2.9.0</version>
		</dependency>
		</#if>

	</dependencies>

	<build>
		<#if lang=="kotlin">
		<sourceDirectory>${r'${project.basedir}'}/src/main/kotlin</sourceDirectory>
		<testSourceDirectory>${r'${project.basedir}'}/src/test/kotlin</testSourceDirectory>
		</#if>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
			<#if lang=="kotlin">
			<plugin>
				<artifactId>kotlin-maven-plugin</artifactId>
				<groupId>org.jetbrains.kotlin</groupId>
				<configuration>
					<args>
						<arg>-Xjsr305=strict</arg>
					</args>
					<compilerPlugins>
						<plugin>spring</plugin>
					</compilerPlugins>
				</configuration>
				<dependencies>
					<dependency>
						<groupId>org.jetbrains.kotlin</groupId>
						<artifactId>kotlin-maven-allopen</artifactId>
						<version>${r'${kotlin.version}'}</version>
					</dependency>
				</dependencies>
			</plugin>
			<#else >
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
					<annotationProcessorPaths>
						<path>
							<groupId>org.projectlombok</groupId>
							<artifactId>lombok</artifactId>
							<version>${r'${org.projectlombok.version}'}</version>
						</path>
						<path>
							<groupId>org.mapstruct</groupId>
							<artifactId>mapstruct-processor</artifactId>
							<version>${r'${org.mapstruct.version}'}</version>
						</path>
					</annotationProcessorPaths>
				</configuration>
			</plugin>
			</#if>
		</plugins>
	</build>

</project>
