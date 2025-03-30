# ===== finalizar_juego() =====
# Muestra el resumen final del jugador

finalizar_juego <- function(estado) {
  cat("\n========= 🧾 RESUMEN FINAL =========\n")
  
  cat("💵 Capital final:", estado$capital, "euros\n")
  
  valor_acciones <- 0
  if (nrow(estado$cartera) > 0) {
    cartera_valorizada <- merge(
      estado$cartera,
      estado$datos_empresas[, c("ID", "PrecioActual")],
      by = "ID"
    )
    cartera_valorizada$ValorActual <- cartera_valorizada$Cantidad * cartera_valorizada$PrecioActual
    valor_acciones <- sum(cartera_valorizada$ValorActual)
    
    cat("\n📦 Valor actual de tus acciones:", valor_acciones, "euros\n")
  } else {
    cat("\n📦 No tienes acciones en tu cartera.\n")
  }
  
  patrimonio <- estado$capital + valor_acciones
  cat("💰 Patrimonio total:", patrimonio, "euros\n")
  
  if (patrimonio > 2000) {
    cat("\n=========================================\n")
    cat("🏆  ¡VICTORIA!\n")
    cat("🎉 ¡Felicidades! Terminaste con ganancias.\n")
    cat("=========================================\n")
  } else if (patrimonio < 2000) {
    cat("\n=========================================\n")
    cat("📉  PÉRDIDAS\n")
    cat("😬 Terminaste con pérdidas. ¡Sigue practicando!\n")
    cat("=========================================\n")
  } else {
    cat("\n=========================================\n")
    cat("😐  NEUTRO\n")
    cat("Terminaste igual que empezaste.\n")
    cat("=========================================\n")
  }
  
  return(invisible(estado))
}
