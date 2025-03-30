# ===== jugar_bolsa() =====
# Lógica principal del juego

jugar_bolsa <- function() {
  estado <- inicializar_juego()
  
  repeat {
    cat("\n=====================================\n")
    cat("📆 Día", estado$dia, "de 20\n")

    # Generar noticia al inicio del día
    d <- generar_noticia(estado)
    if (!is.null(d)) {
      estado <- d$estado
      estado <- actualizar_precios(estado, d$noticia)
    }
    
    mostrar_menu()
    opcion <- procesar_decision()
    
    # Pasándolo con switch para no anidar múltiples if_else
    # Aunque igual hay que hacer algunas precisiones más abajo
    accion <- switch(opcion,
      comprar_acciones,
      vender_acciones,
      mantener,
      mostrar_estado_actual,
      "salir"
    )
    
    if (is.character(accion) && accion == "salir") {
      cat("🚪 Has decidido salir del juego.\n")
      break
    } else if (identical(accion, mostrar_estado_actual)) {
      accion(estado)
      next  # no avanza el día
    } else {
      estado <- accion(estado)
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
