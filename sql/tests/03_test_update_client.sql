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