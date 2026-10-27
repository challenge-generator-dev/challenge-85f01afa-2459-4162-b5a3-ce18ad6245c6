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