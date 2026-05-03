# 💻 Skill de Código - Perfumería

Estándares técnicos para el manejo de fragancias.

## Arquitectura

- **Models**: `PerfumeModel` (nombre, marca, genero, precio_compra, precio_venta, stock).
- **Services**: `FirestoreService` gestionando la colección `perfumes`.
- **Utils**: Validadores para asegurar que el `precio_venta` sea mayor al `precio_compra`.

## Operaciones CRUD

- ✅ **CREATE**: Registro de nuevas fragancias por marca y género.
- ✅ **READ**: Listado dinámico filtrable por marca o género (Dama/Caballero/Unisex).
- ✅ **UPDATE**: Actualización de existencias y ajuste de precios de mercado.
- ✅ **DELETE**: Retiro de productos descontinuados.

## Reglas de Implementación

- Los campos de precio deben aceptar decimales (double).
- El stock debe ser un número entero positivo.
