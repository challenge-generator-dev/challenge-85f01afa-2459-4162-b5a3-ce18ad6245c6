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