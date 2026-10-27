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