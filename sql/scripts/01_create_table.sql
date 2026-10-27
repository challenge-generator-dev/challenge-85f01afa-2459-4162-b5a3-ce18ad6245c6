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