# Unir todos los scripts de funciones en un único archivo

# Carpeta donde están las funciones
carpeta <- "funciones"

# Archivos ordenados alfabéticamente (puedes usar prefijos numéricos)
archivos <- list.files(carpeta, pattern = "\\.R$", full.names = TRUE)
archivos <- sort(archivos)

# Archivo final de salida
archivo_final <- "simulador_bolsa.R"

# Unir y escribir
cat("# Proyecto: Simulador de Bolsa de Valores\n", 
    "# Autor: Brian Norman Peña-Calero\n",
    "# Archivo generado automáticamente\n\n", 
    file = archivo_final)

for (archivo in archivos) {
  contenido <- readLines(archivo, warn = FALSE)
  cat("\n\n# ===== Archivo:", basename(archivo), "=====\n", file = archivo_final, append = TRUE)
  cat(paste(contenido, collapse = "\n"), file = archivo_final, append = TRUE)
}
