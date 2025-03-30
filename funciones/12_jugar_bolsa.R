# ===== jugar_bolsa() =====
# Lógica principal del juego

jugar_bolsa <- function() {
  estado <- inicializar_juego()
  
  repeat {
    cat("\n=====================================\n")
    cat("📆 Día", estado$dia, "de 20\n")
    
    mostrar_menu()
    opcion <- procesar_decision()
    
    if (opcion == 1) {
      estado <- comprar_acciones(estado)
    } else if (opcion == 2) {
      estado <- vender_acciones(estado)
    } else if (opcion == 3) {
      estado <- mantener(estado)
    } else if (opcion == 4) {
      d <- generar_noticia(estado)
      if (!is.null(d)) {
        estado <- d$estado
        estado <- actualizar_precios(estado, d$noticia)
      }
    } else if (opcion == 5) {
      mostrar_estado_actual(estado)
    } else if (opcion == 6) {
      cat("🚪 Has decidido salir del juego.\n")
      break
    }
    
    # Avanzar al siguiente día solo si la opción no fue 5 (ver estado) o 6 (salir)
    if (opcion %in% c(1, 2, 3, 4)) {
      estado$dia <- estado$dia + 1
    }
    
    # Fin automático al día 20
    if (estado$dia > 20) {
      cat("\n⏳ Has llegado al final de los 20 días.\n")
      break
    }
  }
  
  finalizar_juego(estado)
}
