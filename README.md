# 🧠 Simulador de Bolsa de Valores en R

Este proyecto es un juego de simulación bursátil desarrollado íntegramente en **R base**, en el cual el jugador debe tomar decisiones de inversión a lo largo de 20 días simulados. El objetivo es aumentar el capital inicial (€2000) comprando, vendiendo o manteniendo acciones de empresas ficticias que se ven afectadas por noticias económicas generadas aleatoriamente.

---

## 📦 Estructura del proyecto

El código está organizado de forma **modular**, con funciones separadas en archivos dentro de la carpeta `funciones/`:

```
funciones/
├── 00_utils.R
├── 01_cargar_datos.R
├── 02_inicializar_juego.R
├── 03_mostrar_menu.R
├── 04_procesar_decision.R
├── 05_comprar_acciones.R
├── 06_vender_acciones.R
├── 07_generar_noticia.R
├── 08_actualizar_precios.R
├── 09_mostrar_estado_actual.R
├── 10_mantener.R
├── 11_finalizar_juego.R
└── 12_jugar_bolsa.R
```

Todas las funciones se ensamblan automáticamente en un único archivo ejecutable:  
**`simulador_bolsa.R`**, el cual puedes correr directamente.

---

## 🚀 ¿Cómo ejecutar el juego?

### 🖥️ Opción 1: Offline (recomendado para trabajo local)

1. Clona este repositorio:

```bash
git clone https://github.com/brianmsm/bolsa-valores-r.git
```

2. Abre R o RStudio y asegúrate de estar en la carpeta descargada.

3. Ejecuta el archivo principal:

```r
source("simulador_bolsa.R")
```

> 📂 Asegúrate de tener el archivo `noticias_bolsa.csv` en el mismo directorio.  
> Si no está, el script lo descargará automáticamente desde GitHub.

---

### 🌐 Opción 2: Ejecutar directamente desde internet

Puedes iniciar el simulador sin necesidad de clonar nada, ejecutando en tu consola R:

```r
source("https://raw.githubusercontent.com/brianmsm/bolsa-valores-r/refs/heads/main/simulador_bolsa.R")
```

El juego se ejecutará automáticamente, descargando el archivo de noticias si no está presente localmente.

---

## 🧩 ¿Qué incluye?

- Noticias económicas realistas con impacto en sectores específicos.
- Sistema de compra y venta de acciones con validaciones detalladas.
- Capital dinámico, precios actualizados y seguimiento de cartera.
- Interfaz amigable y mensajes con emojis para facilitar la interacción 😄.

---

## 🎮 Ejemplo de uso

A continuación, se muestra un ejemplo de una partida simulada paso a paso:

```
🎮 Bienvenido al Simulador de Bolsa
💰 Capital inicial: 2000 euros
📈 Turnos: 20 días
📦 Acciones disponibles: 5 empresas

📌 Instrucciones:
- Cada día recibirás una noticia económica.
- Basándote en ella, deberás decidir si comprar, vender o mantener tus inversiones.
- Pero ¡cuidado! Los efectos reales de la noticia se verán **después** de que tomes tu decisión.
- Tu objetivo es terminar con un patrimonio mayor a tu capital inicial.

¡Buena suerte, inversionista! 💼📊

=====================================
📆 Día 1 de 20
💵 Capital disponible: 2000 euros

======================================
   🎮 SIMULADOR DE BOLSA DE VALORES
======================================
Elige una opción:
1️⃣  Comprar acciones
2️⃣  Vender acciones
3️⃣  Mantener inversión
4️⃣  Mostrar estado actual 💰
5️⃣  Finalizar juego ❌
======================================
```

Al elegir compra de acciones:

```
Selecciona una opción (1-5): 1
💵 Capital disponible: 2000 euros


=== 📈 COMPRA DE ACCIONES ===
  ID     Nombre       Sector PrecioInicial PrecioActual AccionesDisponibles
1  1   TechNova   Tecnología           150          150                  20
2  2 FarmaSalud Farmacéutica            90           90                  25
3  3   GeoMiner      Minería            60           60                  30
4  4     Renova   Renovables           110          110                  22
5  5   VoltEner      Energía           100          100                  24
🔢 Ingresa el ID de la empresa que deseas comprar (0 para cancelar): 2
📦 ¿Cuántas acciones deseas comprar de FarmaSalud ? (0 para cancelar): 5
✅ Compra realizada. Has comprado 5 acciones de FarmaSalud 
```

Nuevo día, nuevo turno:

```
=====================================
📆 Día 2 de 20
💵 Capital disponible: 1550 euros

🗞️  NOTICIA DEL DÍA:
📰 Fuerte demanda en mercado asiático impulsa exportaciones energéticas 

======================================
   🎮 SIMULADOR DE BOLSA DE VALORES
======================================
Elige una opción:
1️⃣  Comprar acciones
2️⃣  Vender acciones
3️⃣  Mantener inversión
4️⃣  Mostrar estado actual 💰
5️⃣  Finalizar juego ❌
======================================
Selecciona una opción (1-5): 1
```

Luego, dependiendo como juegues, puedes finalizar y ganar:

```
Selecciona una opción (1-5): 5
🚪 Has decidido salir del juego.

========= 🧾 RESUMEN FINAL =========
💵 Capital final: 2372.2 euros

📦 No tienes acciones en tu cartera.
💰 Patrimonio total: 2372.2 euros

=========================================
🏆  ¡VICTORIA!
🎉 ¡Felicidades! Terminaste con ganancias.
=========================================
```


---

🎓 Proyecto desarrollado para el curso de **Programación Avanzada en R**  
Facultad de Psicología, Universidad Complutense de Madrid
