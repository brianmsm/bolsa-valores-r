# ===== mostrar_estado_actual() =====
# Muestra el estado financiero actual del jugador

mostrar_estado_actual <- function(estado) {
  cat("\n=== 💰 ESTADO ACTUAL ===\n")
  cat("📆 Día:", estado$dia, "\n")
  cat("💵 Capital disponible:", estado$capital, "euros\n")
  
  cat("\n📦 Cartera de acciones:\n")
  if (nrow(estado$cartera) == 0) {
    cat("No tienes acciones en tu cartera.\n")
  } else {
    print(estado$cartera[, c("ID", "Empresa", "Cantidad", "PrecioCompra")], row.names = FALSE)
  }

  cat("\n🏢 Empresas en el mercado:\n")
  print(estado$datos_empresas[, c("ID", "Nombre", "Sector", "PrecioInicial", "AccionesDisponibles")], row.names = FALSE)
}
