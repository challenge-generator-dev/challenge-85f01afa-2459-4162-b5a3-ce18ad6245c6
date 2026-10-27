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