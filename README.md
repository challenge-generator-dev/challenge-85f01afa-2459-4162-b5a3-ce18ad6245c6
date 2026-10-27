# Implementación de Operaciones CRUD en SQL

El objetivo es crear un conjunto de consultas SQL que permitan realizar operaciones básicas de CRUD (Create, Read, Update, Delete) en una tabla de una base de datos. La tabla simulará un registro de clientes de un banco, donde cada cliente tiene un identificador único, nombre, apellido, email y saldo. Las operaciones deben cumplir con las reglas de negocio del dominio, como la prohibición de saldos negativos y la unicidad del email.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Data Manipulation Language (DML) |
| **Nivel** | trainee-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 3 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Creación de Clientes

**Objetivo:** Implementar la operación de creación de clientes, asegurando la unicidad del email y la validación de datos.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Diseña una consulta SQL para insertar un nuevo cliente en la tabla de clientes. Asegúrate de que el email sea único y que el saldo inicial no sea negativo.
- Define los criterios de aceptación para la operación de creación.

**Entregable:** Consulta SQL verificable para la creación de clientes.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las restricciones de unicidad y validación de datos en tu diseño.
- Piensa en cómo manejarías un intento de inserción con un email duplicado.

</details>

### Fase 2: Lectura de Clientes

**Objetivo:** Implementar la operación de lectura de clientes, permitiendo la consulta de información específica.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Diseña una consulta SQL para recuperar la información de un cliente específico por su identificador.
- Define los criterios de aceptación para la operación de lectura.

**Entregable:** Consulta SQL verificable para la lectura de clientes.

<details>
<summary>Pistas de conocimiento</summary>

- Considera cómo filtrar los resultados para obtener un cliente específico.
- Piensa en la eficiencia de la consulta en términos de tiempo de ejecución.

</details>

### Fase 3: Actualización de Clientes

**Objetivo:** Implementar la operación de actualización de clientes, asegurando la integridad de los datos.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Diseña una consulta SQL para actualizar la información de un cliente, incluyendo la validación de datos como el saldo.
- Define los criterios de aceptación para la operación de actualización.

**Entregable:** Consulta SQL verificable para la actualización de clientes.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las validaciones necesarias para actualizar el saldo de un cliente.
- Piensa en cómo manejarías una actualización que intenta establecer un saldo negativo.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una operación CRUD en el contexto de SQL?
- **paraQueSirve**: ¿Para qué sirve realizar operaciones CRUD en una base de datos?
- **comoSeUsa**: ¿Cómo se usa una consulta SQL para realizar una operación CRUD?
- **erroresComunes**: ¿Cuáles son los errores comunes al realizar operaciones CRUD y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño de una consulta SQL para operaciones CRUD?

## Criterios de Evaluacion

- Implementación correcta de una consulta SQL para crear clientes con validación de unicidad y datos.
- Implementación correcta de una consulta SQL para leer información de clientes por identificador.
- Implementación correcta de una consulta SQL para actualizar información de clientes con validación de datos.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
mvn clean compile
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
