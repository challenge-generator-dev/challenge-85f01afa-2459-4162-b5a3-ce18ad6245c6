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