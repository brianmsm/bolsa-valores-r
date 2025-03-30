# Generar manualmente 50 noticias con impacto justificado

noticias <- data.frame(
  ID = 1:52,
  Area = c(
    "Tecnología", "Farmacéutica", "Energía", "Minería", "Renovables",
    "Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía",
    "Tecnología", "Farmacéutica", "Energía", "Minería", "Renovables",
    "Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía",
    "Tecnología", "Farmacéutica", "Energía", "Minería", "Renovables",
    "Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía",
    "Tecnología", "Farmacéutica", "Energía", "Minería", "Renovables",
    "Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía",
    "Tecnología", "Farmacéutica", "Energía", "Minería", "Renovables",
    "Tecnología", "Renovables", "General", "General", "General",
    "General", "General"
  ),
  Noticia = c(
    "Avance tecnológico mejora expectativas de crecimiento",                       # +55
    "Autorización de nueva vacuna genera confianza en el sector",                 # +50
    "Regulación ambiental favorece desarrollo de energías renovables",            # +42
    "Descubrimiento de nuevos yacimientos en zona estratégica",                   # +48
    "Subsidios estatales impulsan proyectos solares",                             # +45
    "Ciberataque compromete datos sensibles de empresas",                    # -50
    "Fuga de información sobre ensayo clínico genera dudas en inversionistas",    # -40
    "Huelga indefinida en zona minera afecta producción",                         # -55
    "Problemas logísticos reducen distribución de paneles solares",               # -30
    "Demora en aprobación de proyectos energéticos frena inversiones",            # -35
    "Lanzamiento de nuevo smartphone supera expectativas de ventas",              # +60
    "Nuevas alianzas estratégicas mejoran presencia internacional",               # +40
    "Fuerte demanda en mercado asiático impulsa exportaciones energéticas",       # +38
    "Desplome en precios de minerales afecta rentabilidad",                       # -45
    "Reducción en la eficiencia de paneles solares por fallos técnicos",          # -33
    "Informe financiero muestra crecimiento sostenido en sector tecnológico",     # +44
    "Campaña de desprestigio contra empresa farmacéutica afecta cotización",      # -32
    "Conflictos territoriales paralizan minería en región clave",                 # -48
    "Anuncio de fusión entre líderes en energías renovables",                     # +46
    "Cierre de plantas por mantenimiento afecta oferta energética",               # -20
    "Incremento de inversión en inteligencia artificial",                         # +35
    "Caída en ventas de medicamentos genéricos",                                  # -29
    "Expansión de red de distribución energética",                                # +33
    "Contaminación de río por empresa minera genera protestas",                   # -38
    "Nueva ley de incentivos para energías limpias",                              # +40
    "Hackeo a base de datos afecta confianza en el sector tecnológico",           # -37
    "Informe sobre efectos secundarios provoca retiro de medicamento",            # -52
    "Colapso de mina detiene producción y causa pérdidas",                        # -56
    "Fabricación local de baterías reduce costos de instalación solar",           # +30
    "Acuerdo internacional sobre energías limpias favorece al sector",            # +41
    "Anuncio de smartwatch ecológico atrae a nuevos consumidores",                # +36
    "Fracaso en ensayo de tratamiento experimental",                              # -41
    "Propuesta de ley busca nacionalizar industria energética",                   # -44
    "Deslizamiento de tierra afecta zona de explotación minera",                  # -34
    "Inversión en investigación para optimizar eficiencia solar",                 # +28
    "Presentación de nuevo chip mejora procesamiento de datos",                   # +39
    "Retiro de medicamentos del mercado genera desconfianza",                     # -30
    "Denuncias por prácticas laborales en minera internacional",                  # -29
    "Demora en entrega de paneles por escasez de materiales",                     # -21
    "Anuncio de acuerdo comercial con país europeo impulsa acciones",            # +37
    "Empresa tecnológica es premiada por sostenibilidad",                         # +32
    "Demanda judicial colectiva a farmacéutica por efectos adversos",            # -46
    "Reducción de aranceles favorece importación de componentes energéticos",     # +31
    "Colapso parcial en mina interrumpe operaciones",                             # -39
    "Reacondicionamiento de turbinas mejora eficiencia energética",               # +29
    "Hackeo global afecta múltiples industrias",                                  # -60
    "Inauguración de sede verde certificada por ONU",                             # +27
    "Celebración del día mundial del emprendimiento",                             # 0
    "Empresas dan una actualización estética de sus logos",                              # 0
    "Participación en feria internacional sin novedades destacadas",             # 0
    "Campaña publicitaria sin efectos en ventas",                                 # 0
    "Reconocimiento interno a los empleados del mes"                              # 0
  ),
  Impacto = c(
    55, 50, 42, 48, 45,
    -50, -40, -55, -30, -35,
    60, 40, 38, -45, -33,
    44, -32, -48, 46, -20,
    35, -29, 33, -38, 40,
    -37, -52, -56, 30, 41,
    36, -41, -44, -34, 28,
    39, -30, -29, -21, 37,
    32, -46, 31, -39, 29,
    -60, 27, 0, 0, 0,
    0, 0
  ),
  stringsAsFactors = FALSE
)

# Guardar archivo CSV
write.csv(noticias,
          "noticias_bolsa.csv",
          row.names = FALSE,
          fileEncoding = "UTF-8")


# Crear data frame de empresas

empresas <- data.frame(
  ID = 1:5,
  Nombre = c("TechNova", "FarmaSalud", "GeoMiner", "Renova", "VoltEner"),
  Sector = c("Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía"),
  PrecioInicial = c(150, 90, 60, 110, 100),
  AccionesDisponibles = c(20, 25, 30, 22, 24),
  stringsAsFactors = FALSE
)

# Exportar a CSV
write.csv(empresas,
          "datos_empresas.csv",
          row.names = FALSE,
          fileEncoding = "UTF-8")
