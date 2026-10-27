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