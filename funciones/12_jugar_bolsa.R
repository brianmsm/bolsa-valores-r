# ===== jugar_bolsa() =====
# Lógica principal del juego

jugar_bolsa <- function() {
  estado <- inicializar_juego()

  cat("🎮 Bienvenido al Simulador de Bolsa\n")
  cat("💰 Capital inicial:", estado$capital, "euros\n")
  cat("📈 Turnos: 20 días\n")
  cat("📦 Acciones disponibles:", nrow(estado$datos_empresas), "empresas\n\n")
  
  cat("📌 Instrucciones:\n")
  cat("- Cada día recibirás una noticia económica.\n")
  cat("- Basándote en ella, deberás decidir si comprar, vender o mantener tus inversiones.\n")
  cat("- Pero ¡cuidado! Los efectos reales de la noticia se verán **después** de que tomes tu decisión.\n")
  cat("- Tu objetivo es terminar con un patrimonio mayor a tu capital inicial.\n\n")
  cat("¡Buena suerte, inversionista! 💼📊\n")
  
  repeat {
    cat("\n=====================================\n")
    cat("📆 Día", estado$dia, "de 20\n")
    cat("💵 Capital disponible:", estado$capital, "euros\n")

    # Día 1: sin noticia, sin impacto
    if (estado$dia > 1) {
      d <- generar_noticia(estado)
      if (!is.null(d)) {
        estado <- d$estado
        attr(estado, "noticia_actual") <- d$noticia  # guardamos para aplicar impacto luego
      }
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
      next
    } else {
      estado <- accion(estado)
      
      # Ahora sí, mostrar impacto del mercado tras la acción
      if (!is.null(attr(estado, "noticia_actual"))) {
        noticia <- attr(estado, "noticia_actual")
        estado <- actualizar_precios(estado, noticia)
        attr(estado, "noticia_actual") <- NULL  # limpiar
      }
      
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
