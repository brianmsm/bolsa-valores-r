# ===== procesar_decision() =====
# Lee y valida la entrada del jugador (opciones del menú)

procesar_decision <- function() {
  opciones_validas <- 1:6
  
  repeat {
    opcion <- readline(prompt = "Selecciona una opción (1-6): ")
    
    # Validar si es número y está dentro del rango
    if (grepl("^[1-6]$", opcion)) {
      return(as.integer(opcion))
    } else {
      cat("❌ Entrada inválida. Por favor elige un número entre 1 y 6.\n")
    }
  }
}
