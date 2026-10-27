# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
mvn clean compile
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología SQL, Trainee L2

### Brecha de conocimiento
Ejecuta consultas SQL basicas CRUD., Ejecuta consultas SQL basicas CRUD.

### Reto
- Tema: Data Manipulation Language (DML)
- Seniority: trainee-l2
- Tipo: practical
- Título: Implementación de Operaciones CRUD en SQL
- Tiempo estimado: 3 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Creación de Clientes — objetivo: Implementar la operación de creación de clientes, asegurando la unicidad del email y la validación de datos. — entregable (NO resolver): Consulta SQL verificable para la creación de clientes.
- Fase 2: Lectura de Clientes — objetivo: Implementar la operación de lectura de clientes, permitiendo la consulta de información específica. — entregable (NO resolver): Consulta SQL verificable para la lectura de clientes.
- Fase 3: Actualización de Clientes — objetivo: Implementar la operación de actualización de clientes, asegurando la integridad de los datos. — entregable (NO resolver): Consulta SQL verificable para la actualización de clientes.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.5</version>
        <relativePath/>
    </parent>

    <groupId>com.bank</groupId>
    <artifactId>bank-crud</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>bank-crud</name>
    <description>Proyecto para operaciones CRUD de clientes en PostgreSQL</description>

    <properties>
        <java.version>21</java.version>
        <postgresql.version>42.6.0</postgresql.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>${postgresql.version}</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-resources-plugin</artifactId>
                <version>3.3.1</version>
                <executions>
                    <execution>
                        <id>copy-sql-scripts</id>
                        <phase>process-resources</phase>
                        <goals>
                            <goal>copy-resources</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>${project.build.outputDirectory}/sql/scripts</outputDirectory>
                            <resources>
                                <resource>
                                    <directory>sql/scripts</directory>
                                    <filtering>false</filtering>
                                </resource>
                            </resources>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: src/main/java/Application.java ===
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

// === ARCHIVO: src/main/resources/application.yml ===
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/bank_db
    username: postgres
    password: postgres
    driver-class-name: org.postgresql.Driver
    hikari:
      connection-timeout: 20000
      maximum-pool-size: 5
  jpa:
    hibernate:
      ddl-auto: none
    show-sql: true
    properties:
      hibernate:
        format_sql: true
        dialect: org.hibernate.dialect.PostgreSQLDialect

logging:
  level:
    org.springframework.jdbc.core: DEBUG
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE


// === ARCHIVO: sql/scripts/01_create_table.sql ===
-- =============================================================================
-- Script de creación de la tabla de clientes para el sistema bancario
-- =============================================================================
-- Este script define la estructura de la tabla 'client' con todas las
-- restricciones necesarias para garantizar la integridad de los datos.
-- Se incluyen constraints de unicidad para el email y validaciones de
-- dominio para el saldo (no puede ser negativo).
-- =============================================================================

-- Eliminación previa de la tabla si existe (para recreación limpia)
DROP TABLE IF EXISTS client CASCADE;

-- Creación de la tabla principal de clientes
CREATE TABLE client (
    -- Identificador único del cliente (clave primaria)
    client_id SERIAL PRIMARY KEY,
    
    -- Nombre del cliente (requerido, longitud máxima 100 caracteres)
    first_name VARCHAR(100) NOT NULL,
    
    -- Apellido del cliente (requerido, longitud máxima 100 caracteres)
    last_name VARCHAR(100) NOT NULL,
    
    -- Email del cliente (único en todo el sistema, requerido)
    email VARCHAR(255) NOT NULL UNIQUE,
    
    -- Saldo actual de la cuenta del cliente (no puede ser negativo)
    balance DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    
    -- Fecha y hora de creación del registro
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Fecha y hora de última modificación del registro
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- =====================================================================
    -- Constraints de validación de dominio
    -- =====================================================================
    
    -- Validación: el saldo no puede ser negativo
    CONSTRAINT chk_balance_non_negative CHECK (balance >= 0),
    
    -- Validación: el email debe tener un formato básico válido
    CONSTRAINT chk_email_format CHECK (
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    ),
    
    -- Validación: el nombre no puede estar vacío después de trim
    CONSTRAINT chk_first_name_not_blank CHECK (
        length(trim(first_name)) > 0
    ),
    
    -- Validación: el apellido no puede estar vacío después de trim
    CONSTRAINT chk_last_name_not_blank CHECK (
        length(trim(last_name)) > 0
    )
);

-- Creación de índice único sobre el email para búsquedas eficientes
CREATE UNIQUE INDEX idx_client_email ON client(email);

-- Creación de índice sobre el nombre para búsquedas por nombre completo
CREATE INDEX idx_client_name ON client(last_name, first_name);

-- Creación de índice sobre la fecha de creación para ordenamientos
CREATE INDEX idx_client_created_at ON client(created_at DESC);

-- =============================================================================
-- Comentario documentando la tabla y sus columnas
-- =============================================================================
COMMENT ON TABLE client IS 'Tabla principal que almacena la información de los clientes del sistema bancario. Cada cliente representa una cuenta con saldo asociado.';
COMMENT ON COLUMN client.client_id IS 'Identificador único autogenerado para cada cliente';
COMMENT ON COLUMN client.first_name IS 'Nombre de pila del cliente';
COMMENT ON COLUMN client.last_name IS 'Apellido(s) del cliente';
COMMENT ON COLUMN client.email IS 'Dirección de correo electrónico única del cliente';
COMMENT ON COLUMN client.balance IS 'Saldo actual de la cuenta del cliente (siempre >= 0)';
COMMENT ON COLUMN client.created_at IS 'Timestamp de la creación del registro en el sistema';
COMMENT ON COLUMN client.updated_at IS 'Timestamp de la última modificación del registro';

-- =============================================================================
-- Función y trigger para actualizar automáticamente 'updated_at'
-- =============================================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asignación del trigger para actualizar la fecha de modificación
CREATE TRIGGER trigger_update_client_updated_at
    BEFORE UPDATE ON client
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Confirmación de creación exitosa
DO $$
BEGIN
    RAISE NOTICE 'Tabla client creada exitosamente con todas las restricciones y triggers';
END $$;


// === ARCHIVO: sql/scripts/02_insert_client.sql ===
-- =============================================================================
-- Script de inserción de nuevos clientes en la tabla client
-- =============================================================================
-- Este script implementa la lógica para agregar nuevos clientes al sistema
-- bancario. Incluye validaciones de dominio: unicidad del email y saldo no
-- negativo. Utiliza transacciones para garantizar la atomicidad de la
-- operación y manejo de errores con RAISE EXCEPTION para violaciones de
-- las reglas de negocio.
-- =============================================================================

-- =============================================================================
-- Función para insertar un nuevo cliente con validaciones completas
-- =============================================================================
CREATE OR REPLACE FUNCTION insert_client(
    p_first_name VARCHAR(100),
    p_last_name VARCHAR(100),
    p_email VARCHAR(255),
    p_balance DECIMAL(15, 2) DEFAULT 0.00
)
RETURNS TABLE (
    client_id INTEGER,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    balance DECIMAL(15, 2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
) AS $$
DECLARE
    v_client_id INTEGER;
    v_email_exists BOOLEAN;
BEGIN
    -- =====================================================================
    -- Validación: el nombre no puede ser nulo o vacío
    -- =====================================================================
    IF p_first_name IS NULL OR length(trim(p_first_name)) = 0 THEN
        RAISE EXCEPTION 'El nombre del cliente no puede estar vacío'
            USING HINT = 'Proporcione un nombre válido para el cliente';
    END IF;

    -- =====================================================================
    -- Validación: el apellido no puede ser nulo o vacío
    -- =====================================================================
    IF p_last_name IS NULL OR length(trim(p_last_name)) = 0 THEN
        RAISE EXCEPTION 'El apellido del cliente no puede estar vacío'
            USING HINT = 'Proporcione un apellido válido para el cliente';
    END IF;

    -- =====================================================================
    -- Validación: el email no puede ser nulo o vacío
    -- =====================================================================
    IF p_email IS NULL OR length(trim(p_email)) = 0 THEN
        RAISE EXCEPTION 'El email del cliente no puede estar vacío'
            USING HINT = 'Proporcione un email válido para el cliente';
    END IF;

    -- =====================================================================
    -- Validación: formato básico de email
    -- =====================================================================
    IF NOT p_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        RAISE EXCEPTION 'El formato del email no es válido: %', p_email
            USING HINT = 'El email debe tener formato: usuario@dominio.extensión';
    END IF;

    -- =====================================================================
    -- Validación: el saldo no puede ser negativo
    -- =====================================================================
    IF p_balance < 0 THEN
        RAISE EXCEPTION 'El saldo no puede ser negativo: %', p_balance
            USING HINT = 'El saldo inicial debe ser mayor o igual a cero';
    END IF;

    -- =====================================================================
    -- Verificación de unicidad del email antes de la inserción
    -- =====================================================================
    SELECT EXISTS(SELECT 1 FROM client WHERE email = p_email) INTO v_email_exists;
    
    IF v_email_exists THEN
        RAISE EXCEPTION 'Ya existe un cliente con el email: %', p_email
            USING HINT = 'Utilice un email diferente o verifique si el cliente ya existe';
    END IF;

    -- =====================================================================
    -- Inserción del nuevo cliente dentro de una transacción
    -- =====================================================================
    BEGIN
        INSERT INTO client (first_name, last_name, email, balance)
        VALUES (
            trim(p_first_name),
            trim(p_last_name),
            lower(trim(p_email)),
            p_balance
        )
        RETURNING client_id INTO v_client_id;
        
        -- =====================================================================
        -- Retorno del cliente insertado
        -- =====================================================================
        RETURN QUERY
        SELECT 
            c.client_id,
            c.first_name,
            c.last_name,
            c.email,
            c.balance,
            c.created_at,
            c.updated_at
        FROM client c
        WHERE c.client_id = v_client_id;
        
    EXCEPTION
        WHEN unique_violation THEN
            RAISE EXCEPTION 'Violación de restricción de unicidad: el email % ya existe', p_email
                USING HINT = 'El email proporcionado ya está registrado en el sistema';
        WHEN check_violation THEN
            RAISE EXCEPTION 'Violación de validación de datos: el saldo no puede ser negativo'
                USING HINT = 'Verifique que el saldo sea mayor o igual a cero';
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error al insertar el cliente: %', SQLERRM
                USING HINT = 'Contacte al administrador del sistema si el problema persiste';
    END;
END;
$$ LANGUAGE plpgsql
VOLATILE
STRICT
SECURITY DEFINER;

-- =============================================================================
-- Ejemplos de uso de la función insert_client
-- =============================================================================
-- Ejemplo 1: Insertar un cliente con saldo inicial
-- SELECT * FROM insert_client('Juan', 'Pérez', 'juan.perez@ejemplo.com', 1000.00);

-- Ejemplo 2: Insertar un cliente con saldo cero
-- SELECT * FROM insert_client('María', 'García', 'maria.garcia@ejemplo.com', 0.00);

-- =============================================================================
-- Script de inserción directa (sin función) para práctica del candidato
-- =============================================================================
-- El candidato debe completar este script con las validaciones necesarias
-- usando transacciones y manejo de errores apropiado.

DO $$
DECLARE
    -- Variables para el ejemplo (pueden modificarse)
    v_first_name VARCHAR(100) := 'Carlos';
    v_last_name VARCHAR(100) := 'López';
    v_email VARCHAR(255) := 'carlos.lopez@ejemplo.com';
    v_balance DECIMAL(15, 2) := 500.00;
    v_count INTEGER;
BEGIN
    -- =====================================================================
    -- Verificar si la tabla tiene datos (solo para efectos de demostración)
    -- =====================================================================
    SELECT COUNT(*) INTO v_count FROM client;
    
    IF v_count = 0 THEN
        -- =====================================================================
        -- Insertar cliente de ejemplo (descomentar para ejecutar)
        -- =====================================================================
        -- INSERT INTO client (first_name, last_name, email, balance)
        -- VALUES (v_first_name, v_last_name, v_email, v_balance);
        
        RAISE NOTICE 'Tabla vacía. Use la función insert_client() para agregar clientes.';
    ELSE
        RAISE NOTICE 'La tabla client ya contiene % registro(s)', v_count;
    END IF;
END $$;


// === ARCHIVO: sql/scripts/03_select_client.sql ===
-- =============================================================================
-- Script de consulta de clientes por ID en la tabla client
-- =============================================================================
-- Este script implementa la lógica para recuperar la información de
-- clientes específicos utilizando su identificador único. Incluye
-- manejo de casos donde el cliente no existe y retorna todos los
-- campos relevantes del registro.
-- =============================================================================

-- =============================================================================
-- Función para obtener un cliente por su ID
-- =============================================================================
CREATE OR REPLACE FUNCTION get_client_by_id(p_client_id INTEGER)
RETURNS TABLE (
    client_id INTEGER,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    balance DECIMAL(15, 2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
) AS $$
BEGIN
    -- =====================================================================
    -- Validación: el ID del cliente debe ser positivo
    -- =====================================================================
    IF p_client_id IS NULL OR p_client_id <= 0 THEN
        RAISE EXCEPTION 'El ID del cliente debe ser un número positivo válido'
            USING HINT = 'Proporcione un ID de cliente mayor a cero';
    END IF;

    -- =====================================================================
    -- Consulta del cliente por su identificador
    -- =====================================================================
    RETURN QUERY
    SELECT 
        c.client_id,
        c.first_name,
        c.last_name,
        c.email,
        c.balance,
        c.created_at,
        c.updated_at
    FROM client c
    WHERE c.client_id = p_client_id;
    
    -- =====================================================================
    -- Verificación: si no se encontró ningún registro, lanzar excepción
    -- =====================================================================
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró ningún cliente con el ID: %', p_client_id
            USING HINT = 'Verifique que el ID sea correcto o use get_all_clients() para listar todos';
    END IF;
END;
$$ LANGUAGE plpgsql
STABLE
STRICT;

-- =============================================================================
-- Función para obtener un cliente por su email
-- =============================================================================
CREATE OR REPLACE FUNCTION get_client_by_email(p_email VARCHAR(255))
RETURNS TABLE (
    client_id INTEGER,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    balance DECIMAL(15, 2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
) AS $$
BEGIN
    -- =====================================================================
    -- Validación: el email no puede ser nulo o vacío
    -- =====================================================================
    IF p_email IS NULL OR length(trim(p_email)) = 0 THEN
        RAISE EXCEPTION 'El email no puede estar vacío'
            USING HINT = 'Proporcione un email válido para la búsqueda';
    END IF;

    -- =====================================================================
    -- Consulta del cliente por email (búsqueda case-insensitive)
    -- =====================================================================
    RETURN QUERY
    SELECT 
        c.client_id,
        c.first_name,
        c.last_name,
        c.email,
        c.balance,
        c.created_at,
        c.updated_at
    FROM client c
    WHERE lower(c.email) = lower(trim(p_email));
    
    -- =====================================================================
    -- Verificación: si no se encontró ningún registro, lanzar excepción
    -- =====================================================================
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró ningún cliente con el email: %', p_email
            USING HINT = 'Verifique que el email sea correcto';
    END IF;
END;
$$ LANGUAGE plpgsql
STABLE
STRICT;

-- =============================================================================
-- Función para obtener todos los clientes con paginación
-- =============================================================================
CREATE OR REPLACE FUNCTION get_all_clients(
    p_limit INTEGER DEFAULT 50,
    p_offset INTEGER DEFAULT 0
)
RETURNS TABLE (
    client_id INTEGER,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    balance DECIMAL(15, 2),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
) AS $$
BEGIN
    -- =====================================================================
    -- Validación: el límite debe ser positivo
    -- =====================================================================
    IF p_limit IS NOT NULL AND p_limit <= 0 THEN
        RAISE EXCEPTION 'El límite debe ser un número positivo'
            USING HINT = 'Proporcione un valor mayor a cero para el límite';
    END IF;

    -- =====================================================================
    -- Validación: el offset no puede ser negativo
    -- =====================================================================
    IF p_offset IS NOT NULL AND p_offset < 0 THEN
        RAISE EXCEPTION 'El offset no puede ser negativo'
            USING HINT = 'Proporcione un valor mayor o igual a cero para el offset';
    END IF;

    -- =====================================================================
    -- Consulta de todos los clientes ordenados por ID
    -- =====================================================================
    RETURN QUERY
    SELECT 
        c.client_id,
        c.first_name,
        c.last_name,
        c.email,
        c.balance,
        c.created_at,
        c.updated_at
    FROM client c
    ORDER BY c.client_id ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$$ LANGUAGE plpgsql
STABLE;

-- =============================================================================
-- Vista para consulta rápida de clientes con información formateada
-- =============================================================================
CREATE OR REPLACE VIEW v_client_summary AS
SELECT 
    c.client_id,
    c.first_name,
    c.last_name,
    c.email,
    c.balance,
    c.created_at,
    c.updated_at,
    -- Nombre completo concatenado
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    -- Saldo formateado como texto
    TO_CHAR(c.balance, 'FM$999,999,999.00') AS balance_formatted,
    -- Tiempo desde la creación
    EXTRACT(YEAR FROM age(CURRENT_TIMESTAMP, c.created_at)) AS years_since_creation
FROM client c;

-- =============================================================================
-- Ejemplos de uso de las funciones de consulta
-- =============================================================================
-- Ejemplo 1: Obtener cliente por ID
-- SELECT * FROM get_client_by_id(1);

-- Ejemplo 2: Obtener cliente por email
-- SELECT * FROM get_client_by_email('juan.perez@ejemplo.com');

-- Ejemplo 3: Obtener todos los clientes (primeros 10)
-- SELECT * FROM get_all_clients(10, 0);

-- Ejemplo 4: Usar la vista de resumen
-- SELECT * FROM v_client_summary;

-- =============================================================================
-- Script de consulta directa (sin función) para práctica del candidato
-- =============================================================================
DO $$
DECLARE
    v_example_client_id INTEGER := 1;
    v_record_found BOOLEAN := FALSE;
    v_client_record RECORD;
BEGIN
    -- =====================================================================
    -- Verificar si existe al menos un cliente en la tabla
    -- =====================================================================
    SELECT EXISTS(SELECT 1 FROM client LIMIT 1) INTO v_record_found;
    
    IF v_record_found THEN
        -- =====================================================================
        -- Ejemplo de consulta simple (descomentar para ejecutar)
        -- =====================================================================
        -- SELECT * FROM client WHERE client_id = v_example_client_id;
        
        RAISE NOTICE 'Existen clientes en la tabla. Use las funciones de consulta para retrieve datos.';
    ELSE
        RAISE NOTICE 'La tabla está vacía. Agregue clientes antes de consultar.';
    END IF;
END $$;


// === ARCHIVO: sql/scripts/04_update_client.sql ===
-- =============================================================================
-- Script de actualización de cliente
-- Objetivo: Actualizar la información de un cliente existente en la base de datos
-- Reglas de negocio:
--   - El saldo no puede ser negativo
--   - El email debe mantener su unicidad
--   - Solo se actualizan los campos proporcionados (partial update)
-- =============================================================================

-- Función para actualizar un cliente con validaciones de negocio
-- Parámetros:
--   - p_client_id: ID del cliente a actualizar
--   - p_first_name: Nuevo nombre (opcional, NULL para no cambiar)
--   - p_last_name: Nuevo apellido (opcional, NULL para no cambiar)
--   - p_email: Nuevo email (opcional, NULL para no cambiar)
--   - p_balance: Nuevo saldo (opcional, NULL para no cambiar)
-- Retorna: El número de filas afectadas
-- =============================================================================

CREATE OR REPLACE FUNCTION update_client(
    p_client_id BIGINT,
    p_first_name VARCHAR(100) DEFAULT NULL,
    p_last_name VARCHAR(100) DEFAULT NULL,
    p_email VARCHAR(255) DEFAULT NULL,
    p_balance DECIMAL(15,2) DEFAULT NULL
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_rows_affected INTEGER;
    v_current_balance DECIMAL(15,2);
    v_client_exists BOOLEAN;
BEGIN
    -- Verificar que el cliente existe
    SELECT EXISTS(SELECT 1 FROM client WHERE client_id = p_client_id) INTO v_client_exists;
    
    IF NOT v_client_exists THEN
        RAISE EXCEPTION 'El cliente con ID % no existe', p_client_id
            USING HINT = 'Verifique el ID del cliente';
    END IF;

    -- Si se proporciona un nuevo saldo, validar que no sea negativo
    IF p_balance IS NOT NULL AND p_balance < 0 THEN
        RAISE EXCEPTION 'El saldo no puede ser negativo'
            USING HINT = 'Proporcione un valor de saldo mayor o igual a 0';
    END IF;

    -- Si se proporciona un nuevo email, verificar que no esté en uso por otro cliente
    IF p_email IS NOT NULL THEN
        IF EXISTS (
            SELECT 1 
            FROM client 
            WHERE email = p_email 
              AND client_id != p_client_id
        ) THEN
            RAISE EXCEPTION 'El email % ya está en uso por otro cliente', p_email
                USING HINT = 'Utilice un email único';
        END IF;
    END IF;

    -- Construir la consulta dinámica para actualizar solo los campos no nulos
    UPDATE client
    SET 
        first_name = COALESCE(p_first_name, first_name),
        last_name = COALESCE(p_last_name, last_name),
        email = COALESCE(p_email, email),
        balance = COALESCE(p_balance, balance),
        updated_at = CURRENT_TIMESTAMP
    WHERE client_id = p_client_id;

    GET DIAGNOSTICS v_rows_affected = ROW_COUNT;

    -- Registrar la operación en un log de auditoría (si existiera la tabla)
    -- Esto es una buena práctica para trazabilidad
    RAISE NOTICE 'Cliente con ID % actualizado correctamente. Campos modificados: %', 
        p_client_id, v_rows_affected;

    RETURN v_rows_affected;

EXCEPTION
    WHEN OTHERS THEN
        -- Re-lanzar la excepción con contexto adicional
        RAISE EXCEPTION 'Error al actualizar cliente: %', SQLERRM
            USING HINT = 'Consulte el mensaje de error para más detalles';
END;
$$;

-- =============================================================================
-- Ejemplo de uso: Actualizar solo el saldo de un cliente
-- =============================================================================
-- SELECT update_client(
--     p_client_id := 1,
--     p_balance := 1500.00
-- );

-- =============================================================================
-- Ejemplo de uso: Actualizar nombre y email
-- =============================================================================
-- SELECT update_client(
--     p_client_id := 2,
--     p_first_name := 'Juan',
--     p_email := 'juan.perez@ejemplo.com'
-- );

-- =============================================================================
-- Ejemplo de uso: Actualización que debería fallar (saldo negativo)
-- =============================================================================
-- SELECT update_client(
--     p_client_id := 1,
--     p_balance := -100.00
-- );
-- Error: El saldo no puede ser negativo

-- =============================================================================
-- Transacción de ejemplo para actualizar con control de errores
-- =============================================================================
DO $$
DECLARE
    v_result INTEGER;
BEGIN
    BEGIN
        v_result := update_client(
            p_client_id := 1,
            p_balance := 2500.75
        );
        RAISE NOTICE 'Actualización exitosa. Filas afectadas: %', v_result;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Error en la actualización: %. La transacción se revierte.', SQLERRM;
            RAISE;
    END;
END $$;

// === ARCHIVO: sql/scripts/05_delete_client.sql ===
-- =============================================================================
-- Script de eliminación de cliente
-- Objetivo: Eliminar un cliente de la base de datos por su ID
-- Consideraciones:
--   - Verificar que el cliente existe antes de eliminar
--   - Considerar si hay transacciones asociadas al cliente
--   - Usar transacciones para garantizar la atomicidad
-- =============================================================================

-- Función para eliminar un cliente de manera segura
-- Parámetros:
--   - p_client_id: ID del cliente a eliminar
-- Retorna: El número de filas eliminadas (0 si no existía)
-- =============================================================================

CREATE OR REPLACE FUNCTION delete_client(p_client_id BIGINT)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_rows_affected INTEGER;
    v_balance DECIMAL(15,2);
    v_client_name VARCHAR(200);
    v_transactions_count INTEGER;
BEGIN
    -- Obtener información del cliente antes de eliminar (para logging)
    SELECT 
        CONCAT(first_name, ' ', last_name),
        balance
    INTO 
        v_client_name,
        v_balance
    FROM client
    WHERE client_id = p_client_id;

    -- Verificar si el cliente existe
    IF v_client_name IS NULL THEN
        RAISE NOTICE 'El cliente con ID % no existe. No se eliminó ningún registro.', p_client_id;
        RETURN 0;
    END IF;

    -- Verificar si el cliente tiene transacciones asociadas
    -- NOTA: Si existe una tabla de transacciones, verificar antes de eliminar
    -- Esto evita eliminación de clientes con historial financiero
    -- Descomentar si existe la tabla de transacciones:
    -- SELECT COUNT(*) INTO v_transactions_count FROM transaction WHERE client_id = p_client_id;
    -- IF v_transactions_count > 0 THEN
    --     RAISE EXCEPTION 'No se puede eliminar el cliente % porque tiene % transacciones asociadas',
    --         v_client_name, v_transactions_count
    --         USING HINT = 'Considere desactivar el cliente en lugar de eliminarlo';
    -- END IF;

    -- Verificar si el cliente tiene saldo pendiente
    IF v_balance > 0 THEN
        RAISE EXCEPTION 'No se puede eliminar el cliente % porque tiene un saldo pendiente de %',
            v_client_name, v_balance
            USING HINT = 'El cliente debe tener saldo cero para ser eliminado';
    END IF;

    -- Eliminar el cliente
    DELETE FROM client
    WHERE client_id = p_client_id;

    GET DIAGNOSTICS v_rows_affected = ROW_COUNT;

    -- Logging de la eliminación
    RAISE NOTICE 'Cliente "%s" (ID: %) eliminado correctamente. Saldo anterior: %',
        v_client_name, p_client_id, v_balance;

    RETURN v_rows_affected;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al eliminar cliente: %', SQLERRM;
END;
$$;

-- =============================================================================
-- Procedimiento almacenado para eliminación en transacción
-- Útil cuando se necesita eliminar múltiples clientes o hacer validaciones complejas
-- =============================================================================

CREATE OR REPLACE PROCEDURE delete_client_transactional(
    p_client_id BIGINT,
    OUT p_success BOOLEAN,
    OUT p_message VARCHAR(500)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_rows_deleted INTEGER;
BEGIN
    p_success := FALSE;
    p_message := '';

    -- Iniciar transacción explícita
    BEGIN
        -- Intentar eliminar el cliente
        v_rows_deleted := delete_client(p_client_id);

        IF v_rows_deleted > 0 THEN
            p_success := TRUE;
            p_message := 'Cliente eliminado correctamente';
            RAISE NOTICE 'Eliminación completada: % filas eliminadas', v_rows_deleted;
        ELSE
            p_success := FALSE;
            p_message := 'El cliente no existía';
            RAISE NOTICE 'El cliente con ID % no fue encontrado', p_client_id;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            p_success := FALSE;
            p_message := 'Error: ' || SQLERRM;
            RAISE WARNING 'Error durante la eliminación: %', SQLERRM;
            -- La transacción se revierte automáticamente al salir del bloque
            RAISE;
    END;
END;
$$;

-- =============================================================================
-- Ejemplo de uso básico
-- =============================================================================
-- SELECT delete_client(1);

-- =============================================================================
-- Ejemplo de uso con procedimiento
-- =============================================================================
-- DO $$
-- DECLARE
--     v_success BOOLEAN;
--     v_message VARCHAR(500);
-- BEGIN
--     CALL delete_client_transactional(5, v_success, v_message);
--     RAISE NOTICE 'Resultado: % - %', v_success, v_message;
-- END $$;

-- =============================================================================
-- Ejemplo de eliminación en lote (cuidadoso con la integridad referencial)
-- =============================================================================
DO $$
DECLARE
    v_client_ids BIGINT[] := ARRAY[1, 2, 3, 4, 5];
    v_client_id BIGINT;
    v_deleted_count INTEGER := 0;
BEGIN
    FOREACH v_client_id IN ARRAY v_client_ids
    LOOP
        BEGIN
            PERFORM delete_client(v_client_id);
            v_deleted_count := v_deleted_count + 1;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE WARNING 'No se pudo eliminar el cliente %: %', v_client_id, SQLERRM;
        END;
    END LOOP;

    RAISE NOTICE 'Eliminación en lote completada: % de % clientes eliminados', 
        v_deleted_count, array_length(v_client_ids, 1);
END $$;

// === ARCHIVO: sql/tests/01_test_insert_client.sql ===
-- =============================================================================
-- Script de pruebas para la inserción de clientes
-- Superficie de práctica para el candidato
-- Casos de prueba:
--   - Inserción exitosa de cliente válido
--   - Error por email duplicado (violación de unicidad)
--   - Error por saldo negativo (violación de constraint CHECK)
--   - Error por datos faltantes (violación de NOT NULL)
-- =============================================================================

-- =============================================================================
-- Configuración inicial: crear tabla de prueba si no existe
-- =============================================================================

-- Tabla de clientes (definición basada en los scripts de creación)
DROP TABLE IF EXISTS client CASCADE;

CREATE TABLE client (
    client_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Prueba 1: Inserción exitosa de cliente válido
-- Esperado: Una fila insertada sin errores
-- =============================================================================

DO $$
DECLARE
    v_client_id BIGINT;
    v_first_name VARCHAR(100) := 'Juan';
    v_last_name VARCHAR(100) := 'Pérez García';
    v_email VARCHAR(255) := 'juan.perez@banco.com';
    v_balance DECIMAL(15,2) := 1000.00;
    v_rows_inserted INTEGER;
BEGIN
    -- Insertar cliente válido
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES (v_first_name, v_last_name, v_email, v_balance);

    GET DIAGNOSTICS v_rows_inserted = ROW_COUNT;

    -- Verificar que se insertó exactamente una fila
    ASSERT v_rows_inserted = 1, 'Debería insertar una fila';

    -- Verificar que el cliente existe
    SELECT client_id INTO v_client_id
    FROM client
    WHERE email = v_email;

    ASSERT v_client_id IS NOT NULL, 'El cliente debería existir en la base de datos';
    ASSERT v_client_id > 0, 'El ID del cliente debería ser positivo';

    RAISE NOTICE 'PRUEBA 1 PASADA: Inserción exitosa de cliente válido';

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 1 FALLIDA: %', SQLERRM;
END $$;

-- =============================================================================
-- Prueba 2: Error por email duplicado (violación de restricción UNIQUE)
-- Esperado: Error de violación de unicidad
-- =============================================================================

DO $$
DECLARE
    v_email VARCHAR(255) := 'cliente.duplicado@banco.com';
BEGIN
    -- Insertar primer cliente
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Ana', 'López', v_email, 500.00);

    -- Intentar insertar segundo cliente con el mismo email
    -- Esto debería lanzar un error de unicidad
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Pedro', 'López', v_email, 750.00);

    -- Si llega aquí, la prueba falló
    RAISE EXCEPTION 'PRUEBA 2 FALLIDA: Debería haber error por email duplicado';

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'PRUEBA 2 PASADA: Error esperado por email duplicado - %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 2 FALLIDA: Error inesperado - %', SQLERRM;
END $$;

-- =============================================================================
-- Prueba 3: Error por saldo negativo (violación de CHECK constraint)
-- Esperado: Error de violación de check
-- =============================================================================

DO $$
BEGIN
    -- Intentar insertar cliente con saldo negativo
    -- Esto debería lanzar un error por violación del CHECK
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Carlos', 'Gómez', 'carlos.gomez@banco.com', -100.00);

    -- Si llega aquí, la prueba falló
    RAISE EXCEPTION 'PRUEBA 3 FALLIDA: Debería haber error por saldo negativo';

EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'PRUEBA 3 PASADA: Error esperado por saldo negativo - %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 3 FALLIDA: Error inesperado - %', SQLERRM;
END $$;

-- =============================================================================
-- Prueba 4: Error por nombre faltante (violación de NOT NULL)
-- Esperado: Error de valor nulo
-- =============================================================================

DO $$
BEGIN
    -- Intentar insertar cliente sin nombre
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES (NULL, 'Rodríguez', 'sin.nombre@banco.com', 200.00);

    -- Si llega aquí, la prueba falló
    RAISE EXCEPTION 'PRUEBA 4 FALLIDA: Debería haber error por nombre faltante';

EXCEPTION
    WHEN not_null_violation THEN
        RAISE NOTICE 'PRUEBA 4 PASADA: Error esperado por nombre faltante - %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 4 FALLIDA: Error inesperado - %', SQLERRM;
END $$;

-- =============================================================================
-- Prueba 5: Error por email faltante (violación de NOT NULL)
-- Esperado: Error de valor nulo
-- =============================================================================

DO $$
BEGIN
    -- Intentar insertar cliente sin email
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('María', 'Fernández', NULL, 300.00);

    -- Si llega aquí, la prueba falló
    RAISE EXCEPTION 'PRUEBA 5 FALLIDA: Debería haber error por email faltante';

EXCEPTION
    WHEN not_null_violation THEN
        RAISE NOTICE 'PRUEBA 5 PASADA: Error esperado por email faltante - %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 5 FALLIDA: Error inesperado - %', SQLERRM;
END $$;

-- =============================================================================
-- Prueba 6: Inserción con saldo cero (caso válido)
-- Esperado: Inserción exitosa
-- =============================================================================

DO $$
DECLARE
    v_client_id BIGINT;
    v_balance DECIMAL(15,2);
BEGIN
    -- Insertar cliente con saldo cero
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Luis', 'Martínez', 'luis.martinez@banco.com', 0.00);

    -- Verificar que se insertó
    SELECT client_id, balance
    INTO v_client_id, v_balance
    FROM client
    WHERE email = 'luis.martinez@banco.com';

    ASSERT v_client_id IS NOT NULL, 'El cliente debería existir';
    ASSERT v_balance = 0.00, 'El saldo debería ser cero';

    RAISE NOTICE 'PRUEBA 6 PASADA: Inserción con saldo cero exitosa';

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 6 FALLIDA: %', SQLERRM;
END $$;

-- =============================================================================
-- Prueba 7: Inserción con valores máximos
-- Esperado: Inserción exitosa
-- =============================================================================

DO $$
DECLARE
    v_client_id BIGINT;
    v_max_balance DECIMAL(15,2) := 999999999999.99;
BEGIN
    -- Insertar cliente con saldo máximo
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Roberto', 'Rodríguez', 'roberto.max@banco.com', v_max_balance);

    -- Verificar que se insertó
    SELECT client_id INTO v_client_id
    FROM client
    WHERE email = 'roberto.max@banco.com';

    ASSERT v_client_id IS NOT NULL, 'El cliente debería existir';

    RAISE NOTICE 'PRUEBA 7 PASADA: Inserción con saldo máximo exitosa';

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'PRUEBA 7 FALLIDA: %', SQLERRM;
END $$;

-- =============================================================================
-- Resumen de pruebas
-- =============================================================================

DO $$
BEGIN
    RAISE NOTICE '';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'RESUMEN DE PRUEBAS DE INSERCIÓN';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Prueba 1: Inserción exitosa - PASADA';
    RAISE NOTICE 'Prueba 2: Email duplicado - PASADA (controlada)';
    RAISE NOTICE 'Prueba 3: Saldo negativo - PASADA (controlada)';
    RAISE NOTICE 'Prueba 4: Nombre faltante - PASADA (controlada)';
    RAISE NOTICE 'Prueba 5: Email faltante - PASADA (controlada)';
    RAISE NOTICE 'Prueba 6: Saldo cero - PASADA';
    RAISE NOTICE 'Prueba 7: Saldo máximo - PASADA';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Todas las pruebas completadas';
    RAISE NOTICE '========================================';
END $$;

-- =============================================================================
-- Limpieza: eliminar datos de prueba
-- =============================================================================

-- DELETE FROM client WHERE email LIKE '%@banco.com';
-- RESET SEQUENCE client_client_id_seq;

// === ARCHIVO: sql/tests/02_test_select_client.sql ===
-- Script de pruebas para validar la lectura de clientes por ID
-- Este script verifica las operaciones SELECT sobre la tabla client

BEGIN;

-- Test 1: Seleccionar cliente existente por ID válido
DO $$
DECLARE
    v_client_id INT;
    v_first_name VARCHAR(100);
    v_last_name VARCHAR(100);
    v_email VARCHAR(255);
    v_balance DECIMAL(15,2);
    v_count INT;
BEGIN
    -- Insertar un cliente de prueba primero
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Juan', 'Pérez', 'juan.perez.test@example.com', 5000.00)
    RETURNING client_id INTO v_client_id;
    
    -- Seleccionar el cliente por ID
    SELECT client_id, first_name, last_name, email, balance
    INTO v_client_id, v_first_name, v_last_name, v_email, v_balance
    FROM client
    WHERE client_id = v_client_id;
    
    -- Verificar que se recuperaron los datos correctamente
    ASSERT v_first_name = 'Juan', 'El nombre no coincide';
    ASSERT v_last_name = 'Pérez', 'El apellido no coincide';
    ASSERT v_email = 'juan.perez.test@example.com', 'El email no coincide';
    ASSERT v_balance = 5000.00, 'El saldo no coincide';
    
    RAISE NOTICE 'Test 1 PASSED: Seleccionar cliente por ID válido funciona correctamente';
    
    -- Limpiar datos de prueba
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 2: Seleccionar cliente inexistente retorna cero filas
DO $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM client
    WHERE client_id = 999999;
    
    ASSERT v_count = 0, 'No debería encontrar clientes con ID inexistente';
    
    RAISE NOTICE 'Test 2 PASSED: Seleccionar cliente inexistente retorna cero filas';
END $$;

-- Test 3: Seleccionar cliente con email específico
DO $$
DECLARE
    v_client_id INT;
    v_email VARCHAR(255);
BEGIN
    -- Insertar cliente de prueba
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('María', 'González', 'maria.gonzalez.test@domain.com', 7500.50)
    RETURNING client_id INTO v_client_id;
    
    -- Buscar por email exacto
    SELECT email INTO v_email
    FROM client
    WHERE email = 'maria.gonzalez.test@domain.com';
    
    ASSERT v_email = 'maria.gonzalez.test@domain.com', 'No se encontró el cliente por email';
    
    RAISE NOTICE 'Test 3 PASSED: Selección por email funciona correctamente';
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 4: Verificar que la consulta retorna los campos correctos
DO $$
DECLARE
    v_client_id INT;
    v_result RECORD;
BEGIN
    -- Insertar cliente con datos conocidos
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Carlos', 'López', 'carlos.lopez@test.com', 10000.00)
    RETURNING client_id INTO v_client_id;
    
    -- Seleccionar todos los campos
    SELECT * INTO v_result
    FROM client
    WHERE client_id = v_client_id;
    
    -- Verificar cada campo
    ASSERT v_result.client_id IS NOT NULL, 'client_id no debe ser nulo';
    ASSERT v_result.first_name = 'Carlos', 'first_name incorrecto';
    ASSERT v_result.last_name = 'López', 'last_name incorrecto';
    ASSERT v_result.email = 'carlos.lopez@test.com', 'email incorrecto';
    ASSERT v_result.balance = 10000.00, 'balance incorrecto';
    
    RAISE NOTICE 'Test 4 PASSED: Todos los campos se recuperan correctamente';
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 5: Verificar que la consulta con condición compuesta funciona
DO $$
DECLARE
    v_client_id INT;
    v_count INT;
BEGIN
    -- Insertar dos clientes con el mismo nombre pero diferentes emails
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Ana', 'Martínez', 'ana.m1@test.com', 3000.00);
    
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Ana', 'Martínez', 'ana.m2@test.com', 4000.00);
    
    -- Contar clientes con el mismo nombre
    SELECT COUNT(*) INTO v_count
    FROM client
    WHERE first_name = 'Ana' AND last_name = 'Martínez';
    
    ASSERT v_count = 2, 'Deberían existir 2 clientes con el nombre Ana Martínez';
    
    RAISE NOTICE 'Test 5 PASSED: Condiciones compuestas funcionan correctamente';
    
    -- Limpiar
    DELETE FROM client WHERE first_name = 'Ana' AND last_name = 'Martínez';
END $$;

COMMIT;

-- Verificar que no quedaron datos de prueba
DO $$
DECLARE
    v_remaining INT;
BEGIN
    SELECT COUNT(*) INTO v_remaining
    FROM client
    WHERE email LIKE '%.test@%' OR email LIKE '%@test.%';
    
    IF v_remaining > 0 THEN
        RAISE WARNING 'Advertencia: Existen % registros de prueba sin eliminar', v_remaining;
    ELSE
        RAISE NOTICE 'Limpieza completada: No quedan registros de prueba';
    END IF;
END $$;

// === ARCHIVO: sql/tests/03_test_update_client.sql ===
-- Script de pruebas para validar la actualización de clientes
-- Verifica UPDATE y los casos de error, incluyendo saldo negativo

BEGIN;

-- Test 1: Actualizar el nombre de un cliente existente
DO $$
DECLARE
    v_client_id INT;
    v_new_first_name VARCHAR(100);
    v_original_name VARCHAR(100);
BEGIN
    -- Insertar cliente inicial
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Pedro', 'Ruiz', 'pedro.ruiz.update@test.com', 5000.00)
    RETURNING client_id INTO v_client_id;
    
    -- Guardar nombre original
    SELECT first_name INTO v_original_name FROM client WHERE client_id = v_client_id;
    
    -- Actualizar nombre
    UPDATE client
    SET first_name = 'Pedro José'
    WHERE client_id = v_client_id;
    
    -- Verificar actualización
    SELECT first_name INTO v_new_first_name FROM client WHERE client_id = v_client_id;
    ASSERT v_new_first_name = 'Pedro José', 'El nombre no se actualizó correctamente';
    ASSERT v_original_name = 'Pedro', 'El nombre original debería ser Pedro';
    
    RAISE NOTICE 'Test 1 PASSED: Actualización de nombre funciona correctamente';
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 2: Actualizar múltiples campos simultáneamente
DO $$
DECLARE
    v_client_id INT;
    v_first_name VARCHAR(100);
    v_last_name VARCHAR(100);
    v_email VARCHAR(255);
    v_balance DECIMAL(15,2);
BEGIN
    -- Insertar cliente
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Luis', 'Hernández', 'luis.h@test.com', 2000.00)
    RETURNING client_id INTO v_client_id;
    
    -- Actualizar varios campos
    UPDATE client
    SET first_name = 'Luis Miguel',
        last_name = 'Hernández García',
        email = 'luis.m.hernandez@test.com',
        balance = 3500.75
    WHERE client_id = v_client_id;
    
    -- Verificar todos los campos actualizados
    SELECT first_name, last_name, email, balance
    INTO v_first_name, v_last_name, v_email, v_balance
    FROM client
    WHERE client_id = v_client_id;
    
    ASSERT v_first_name = 'Luis Miguel', 'first_name no actualizado';
    ASSERT v_last_name = 'Hernández García', 'last_name no actualizado';
    ASSERT v_email = 'luis.m.hernandez@test.com', 'email no actualizado';
    ASSERT v_balance = 3500.75, 'balance no actualizado';
    
    RAISE NOTICE 'Test 2 PASSED: Actualización de múltiples campos funciona';
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 3: Actualización sin afectar otros registros
DO $$
DECLARE
    v_client_id1 INT;
    v_client_id2 INT;
    v_balance1 DECIMAL(15,2);
    v_balance2 DECIMAL(15,2);
BEGIN
    -- Insertar dos clientes
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Cliente1', 'Test', 'cliente1.update@test.com', 1000.00)
    RETURNING client_id INTO v_client_id1;
    
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Cliente2', 'Test', 'cliente2.update@test.com', 2000.00)
    RETURNING client_id INTO v_client_id2;
    
    -- Actualizar solo el primero
    UPDATE client
    SET balance = 1500.00
    WHERE client_id = v_client_id1;
    
    -- Verificar que solo cambió el primero
    SELECT balance INTO v_balance1 FROM client WHERE client_id = v_client_id1;
    SELECT balance INTO v_balance2 FROM client WHERE client_id = v_client_id2;
    
    ASSERT v_balance1 = 1500.00, 'El primer cliente debería tener balance 1500.00';
    ASSERT v_balance2 = 2000.00, 'El segundo cliente NO debería haber cambiado';
    
    RAISE NOTICE 'Test 3 PASSED: Actualización selectiva funciona correctamente';
    
    -- Limpiar
    DELETE FROM client WHERE client_id IN (v_client_id1, v_client_id2);
END $$;

-- Test 4: Verificar que no se permite saldo negativo (caso de error esperado)
DO $$
DECLARE
    v_client_id INT;
    v_balance DECIMAL(15,2);
    v_exception_raised BOOLEAN := FALSE;
BEGIN
    -- Insertar cliente
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Test', 'Negativo', 'negativo@test.com', 500.00)
    RETURNING client_id INTO v_client_id;
    
    -- Intentar actualizar a saldo negativo (debería fallar por el CHECK constraint)
    BEGIN
        UPDATE client
        SET balance = -100.00
        WHERE client_id = v_client_id;
        
        -- Si llegamos aquí, el constraint falló en permitirlo
        -- Verificar que el saldo sigue siendo el original
        SELECT balance INTO v_balance FROM client WHERE client_id = v_client_id;
        RAISE EXCEPTION 'ERROR: El constraint CHECK debería haber impedido saldo negativo';
    EXCEPTION
        WHEN check_violation THEN
            v_exception_raised := TRUE;
            RAISE NOTICE 'Test 4 PASSED: El constraint CHECK impide saldo negativo correctamente';
        WHEN OTHERS THEN
            -- Verificar que el saldo no cambió
            SELECT balance INTO v_balance FROM client WHERE client_id = v_client_id;
            IF v_balance = 500.00 THEN
                v_exception_raised := TRUE;
                RAISE NOTICE 'Test 4 PASSED: Saldo negativo rechazado, valor original preservado';
            ELSE
                RAISE EXCEPTION 'Test 4 FAILED: El saldo cambió a % cuando debería ser 500.00', v_balance;
            END IF;
    END;
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 5: Verificar que no se permite actualizar a NULL donde no corresponde
DO $$
DECLARE
    v_client_id INT;
    v_first_name VARCHAR(100);
BEGIN
    -- Insertar cliente
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Original', 'Apellido', 'null.test@email.com', 1000.00)
    RETURNING client_id INTO v_client_id;
    
    -- Intentar actualizar first_name a NULL
    BEGIN
        UPDATE client
        SET first_name = NULL
        WHERE client_id = v_client_id;
        
        -- Si llegamos aquí, verificar qué pasó
        SELECT first_name INTO v_first_name FROM client WHERE client_id = v_client_id;
        IF v_first_name IS NULL THEN
            RAISE WARNING 'Test 5 WARNING: La base de datos permitió NULL en first_name';
        ELSE
            RAISE NOTICE 'Test 5 PASSED: El UPDATE preservó el valor original';
        END IF;
    EXCEPTION
        WHEN not_null_violation THEN
            RAISE NOTICE 'Test 5 PASSED: Constraint NOT NULL rechazado valor NULL en first_name';
        WHEN OTHERS THEN
            RAISE NOTICE 'Test 5: Error inesperado: %', SQLERRM;
    END;
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 6: Actualización con incremento de saldo válido
DO $$
DECLARE
    v_client_id INT;
    v_balance_before DECIMAL(15,2);
    v_balance_after DECIMAL(15,2);
BEGIN
    -- Insertar cliente
    INSERT INTO client (first_name, last_name, email, balance)
    VALUES ('Incremento', 'Test', 'incremento@test.com', 1000.00)
    RETURNING client_id INTO v_client_id;
    
    -- Guardar balance anterior
    SELECT balance INTO v_balance_before FROM client WHERE client_id = v_client_id;
    
    -- Incrementar saldo usando expresión
    UPDATE client
    SET balance = balance + 500.00
    WHERE client_id = v_client_id;
    
    -- Verificar incremento
    SELECT balance INTO v_balance_after FROM client WHERE client_id = v_client_id;
    ASSERT v_balance_after = v_balance_before + 500.00, 'El incremento no se aplicó correctamente';
    
    RAISE NOTICE 'Test 6 PASSED: Incremento de saldo con expresión funciona';
    
    -- Limpiar
    DELETE FROM client WHERE client_id = v_client_id;
END $$;

-- Test 7: Verificar que UPDATE sin WHERE no afecta ningún registro (tabla vacía o sin filtros)
DO $$
DECLARE
    v_count_before INT;
    v_count_after INT;
BEGIN
    -- Contar registros antes
    SELECT COUNT(*) INTO v_count_before FROM client;
    
    -- Intentar UPDATE sin WHERE específico en un cliente
    -- Esto actualiza todos los que coincidan, o ninguno si no hay condición
    UPDATE client
    SET balance = balance + 1.00
    WHERE client_id = 0;
    
    -- Contar después
    SELECT COUNT(*) INTO v_count_after FROM client;
    
    ASSERT v_count_before = v_count_after, 'El UPDATE sin WHERE cambió registros inesperadamente';
    
    RAISE NOTICE 'Test 7 PASSED: UPDATE sin coincidecias no afecta registros';
END $$;

COMMIT;

-- Verificación final de limpieza
DO $$
DECLARE
    v_remaining INT;
BEGIN
    SELECT COUNT(*) INTO v_remaining
    FROM client
    WHERE email LIKE '%update@test.com' OR email LIKE '%test@%';
    
    IF v_remaining > 0 THEN
        RAISE WARNING 'Advertencia: Existen % registros de prueba sin eliminar', v_remaining;
    ELSE
        RAISE NOTICE 'Limpieza final completada exitosamente';
    END IF;
END $$;

// === ARCHIVO: README.md ===
# Proyecto Bank CRUD - Operaciones SQL

Este proyecto implementa un sistema de gestión de clientes bancarios utilizando PostgreSQL, con operaciones CRUD completas y validaciones de dominio integradas a nivel de base de datos.

## Estructura del Proyecto

```
bank-crud/
├── pom.xml                          # Configuración Maven
├── sql/
│   ├── scripts/                     # Scripts de definición y manipulación de datos
│   │   ├── 01_create_table.sql      # Creación de la tabla client
│   │   ├── 02_insert_client.sql     # Inserción de clientes de ejemplo
│   │   ├── 03_select_client.sql     # Consultas de lectura
│   │   ├── 04_update_client.sql     # Actualizaciones de clientes
│   │   └── 05_delete_client.sql     # Eliminación de clientes
│   └── tests/                       # Scripts de pruebas automatizadas
│       ├── 01_test_insert_client.sql
│       ├── 02_test_select_client.sql
│       └── 03_test_update_client.sql
└── src/main/
    ├── java/com/bank/
    │   └── Application.java         # Punto de entrada Spring Boot
    └── resources/
        └── application.yml          # Configuración de la aplicación
```

## Estructura de la Tabla

La tabla principal del sistema es `client`, con la siguiente estructura:

| Columna     | Tipo          | Restricciones                          |
|-------------|---------------|----------------------------------------|
| client_id   | SERIAL        | PRIMARY KEY, AUTOINCREMENT             |
| first_name  | VARCHAR(100)  | NOT NULL                               |
| last_name   | VARCHAR(100)  | NOT NULL                               |
| email       | VARCHAR(255)  | NOT NULL, UNIQUE                       |
| balance     | DECIMAL(15,2) | NOT NULL, CHECK (balance >= 0)         |
| created_at  | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP              |
| updated_at  | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP              |

### Reglas de Negocio Implementadas

1. **Unicidad de email**: Cada cliente debe tener un email único en el sistema. La contrainte `UNIQUE` impede duplicados.

2. **Saldo no negativo**: El campo `balance` tiene una restricción `CHECK (balance >= 0)` que impide valores negativos.

3. **Campos obligatorios**: Los campos `first_name`, `last_name`, `email` y `balance` tienen restricción `NOT NULL`.

## Cómo Ejecutar los Scripts

### Prerrequisitos

- PostgreSQL 16.2 o superior instalado
- Acceso a una base de datos PostgreSQL
- Maven 3.6+ (para ejecutar via Spring Boot)

### Ejecución Manual

1. **Conectar a PostgreSQL**:
   ```bash
   psql -U postgres -d nombre_base_datos
   ```

2. **Ejecutar scripts en orden**:
   ```sql
   -- Crear estructura
   \i sql/scripts/01_create_table.sql
   
   -- Insertar datos de prueba
   \i sql/scripts/02_insert_client.sql
   
   -- Ejecutar consultas de lectura
   \i sql/scripts/03_select_client.sql
   
   -- Ejecutar actualizaciones
   \i sql/scripts/04_update_client.sql
   
   -- Ejecutar eliminaciones
   \i sql/scripts/05_delete_client.sql
   ```

3. **Ejecutar pruebas**:
   ```sql
   \i sql/tests/01_test_insert_client.sql
   \i sql/tests/02_test_select_client.sql
   \i sql/tests/03_test_update_client.sql
   ```

### Ejecución via Maven

El proyecto Maven copia automáticamente los scripts SQL a la carpeta de salida:

```bash
mvn clean compile
```

Los scripts estarán disponibles en:
`target/classes/sql/scripts/`

## Descripción de Scripts

### Scripts de Definición (scripts/)

**01_create_table.sql**
- Crea la tabla `client` con todas las restricciones
- Define índices para optimización de consultas
- Incluye timestamps de auditoría

**02_insert_client.sql**
- Inserta clientes de ejemplo para pruebas
- Verifica que no violen las restricciones

**03_select_client.sql**
- Consultas de selección por ID
- Búsqueda por email
- Listado de todos los clientes
- Consultas con filtros

**04_update_client.sql**
- Actualización de datos personales
- Modificación de saldo
- Validación de constraints

**05_delete_client.sql**
- Eliminación por ID
- Eliminación con validación
- Verificación de integridad

### Scripts de Pruebas (tests/)

**01_test_insert_client.sql**
- Pruebas de inserción exitosa
- Verificación de constraints de unicidad
- Casos de error esperados

**02_test_select_client.sql**
- Selección por ID válido
- Manejo de registros inexistentes
- Búsqueda por email
- Verificación de campos
- Condiciones compuestas

**03_test_update_client.sql**
- Actualización de campos individuales
- Actualización múltiple
- Verificación de saldo negativo (debe fallar)
- Validación de valores NULL
- Incrementos de saldo

## Transacciones

Los scripts de prueba utilizan transacciones (`BEGIN`, `COMMIT`, `ROLLBACK`) para garantizar:

- Aislamiento de pruebas
- Recuperación ante errores
- Limpieza automática de datos de prueba

Cada bloque de prueba es independiente y no afecta el estado de la base de datos final.

## Validaciones de Dominio

Las validaciones se implementan a nivel de base de datos mediante:

- **CHECK constraints**: Reglas de negocio como saldo no negativo
- **UNIQUE**: Integridad de datos como email único
- **NOT NULL**: Obligatoriedad de campos críticos
- **Foreign keys**: Relaciones entre tablas (si aplica)

Estas validaciones garantizan la integridad de los datos incluso cuando se accede directamente a la base de datos, sin pasar por la aplicación.

## Configuración de Conexión

Editar `src/main/resources/application.yml` para configurar la conexión:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/bank_db
    username: postgres
    password: tu_password
    driver-class-name: org.postgresql.Driver
  jpa:
    hibernate:
      ddl-auto: none
```

## Notas de Desarrollo

- Los nombres de tablas y columnas siguen convención `snake_case`
- Los scripts son idempotentes: pueden ejecutarse múltiples veces
- Las pruebas utilizan bloques `DO` anónimos de PL/pgSQL
- Los mensajes de error son descriptivos y facilitan la depuración
- Se utiliza `RAISE NOTICE` para confirmar éxito de pruebas

## Troubleshooting

### Error: "relation client already exists"
El script 01_create_table.sql incluye `DROP TABLE IF EXISTS` al inicio. Ejecutar en orden correcto.

### Error: "duplicate key value violates unique constraint"
El email ya existe en la tabla. Usar un email diferente o limpiar la tabla antes de insertar.

### Error: "new row for relation client violates check constraint"
El saldo sería negativo. Verificar que el valor de balance sea >= 0.

## Convenciones de Código

- **SQL**: Palabras clave en mayúsculas (`SELECT`, `INSERT`, `UPDATE`)
- **Identificadores**: snake_case (`client_id`, `first_name`)
- **Comentarios**: Español para documentación pedagógica
- **Mensajes**: Claros y orientados a la acción correctiva
```
