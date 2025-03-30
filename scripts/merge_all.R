# ===== ensamblar_simulador.R =====
# Une todos los scripts del juego en un único archivo ejecutable

# Archivos fuente ordenados
archivos <- c(
  "funciones/00_utils.R",
  "funciones/01_cargar_datos.R",
  "funciones/02_inicializar_juego.R",
  "funciones/03_mostrar_menu.R",
  "funciones/04_procesar_decision.R",
  "funciones/05_comprar_acciones.R",
  "funciones/06_vender_acciones.R",
  "funciones/07_generar_noticia.R",
  "funciones/08_actualizar_precios.R",
  "funciones/09_mostrar_estado_actual.R",
  "funciones/10_mantener.R",
  "funciones/11_finalizar_juego.R",
  "funciones/12_jugar_bolsa.R"
)

# Archivo final de salida
archivo_final <- "simulador_bolsa.R"

# Encabezado del archivo final
cat(
  "##############################################################\n",
  "# Proyecto: Simulador de Bolsa de Valores\n",
  "# Autor: Brian Norman Peña-Calero\n",
  "# Universidad Complutense de Madrid\n",
  "# Curso: Programación Avanzada en R\n",
  "# Descripción: Juego interactivo por consola para invertir\n",
  "#             en acciones ficticias según noticias económicas\n",
  "##############################################################\n\n",
  file = archivo_final
)

# Agregar los contenidos de cada archivo con secciones visibles
for (archivo in archivos) {
  nombre <- basename(archivo)
  contenido <- readLines(archivo, warn = FALSE)
  
  cat("\n\n##############################################################\n",
      "#", toupper(nombre), "\n",
      "##############################################################\n\n",
      paste(contenido, collapse = "\n"),
      "\n",
      file = archivo_final,
      append = TRUE
  )
}

# Agregar ejecución automática del juego
cat(
  "\n\n##############################################################\n",
  "# EJECUCIÓN DEL JUEGO AL EJECUTAR EL SCRIPT\n",
  "##############################################################\n\n",
  "jugar_bolsa()\n",
  file = archivo_final,
  append = TRUE
)

cat("✅ Archivo ensamblado: ", archivo_final, "\n")
