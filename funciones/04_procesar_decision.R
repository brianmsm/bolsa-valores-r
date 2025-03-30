# ===== procesar_decision() =====
# Lee y valida la entrada del jugador (opciones del menú)

procesar_decision <- function() {
  opciones_validas <- 1:5
  
  repeat {
    opcion <- readline(prompt = "Selecciona una opción (1-5): ")
    
    # Validar si es número y está dentro del rango
    if (grepl("^[1-5]$", opcion)) {
      return(as.integer(opcion))
    } else {
      cat("❌ Entrada inválida. Por favor elige un número entre 1 y 5.\n")
    }
  }
}
