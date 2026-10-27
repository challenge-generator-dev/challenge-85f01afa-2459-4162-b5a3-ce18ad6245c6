package com.bank;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.util.Objects;

@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

@Component
class DatabaseInitializer {
    private final DataSource dataSource;

    public DatabaseInitializer(DataSource dataSource) {
        this.dataSource = Objects.requireNonNull(dataSource, "DataSource no puede ser nulo");
    }

    @EventListener(ApplicationReadyEvent.class)
    public void initializeDatabase() {
        try {
            ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
            populator.addScript(new ClassPathResource("sql/scripts/01_create_table.sql"));
            populator.addScript(new ClassPathResource("sql/scripts/02_insert_client.sql"));
            populator.execute(dataSource);
        } catch (Exception e) {
            throw new RuntimeException("Error al inicializar la base de datos", e);
        }
    }
}