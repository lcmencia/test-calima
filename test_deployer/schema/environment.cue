environment: {
  // Service: nombre de servicio del cliente al que pertenece este entorno
  service: string

  // Database del entorno
  database: string

  // acceso a APIs
  api: {
    postgis:  string & =~ "host=.* port=.*" // formato reconocido por psycopg2
    orion:    string & =~ "http://.*"
    keystone: string & =~ "http://.*"
  }

  // endpoints: lista de URLs a usar en las suscripciones
  notificationEndpoints: {
    HISTORIC: string & =~ "http://.*"   // suscripciones a cygnus - sink histórico
    LASTDATA?: string & =~ "http://.*"  // suscripciones a cygnus - sink lastdata (opcional)
    RULES: string & =~ "http://.*"      // suscripciones a perseo
  }

  // Otros endpoints custom
  notificationEndpoints: [string]: string & =~"https?://.*"
}
