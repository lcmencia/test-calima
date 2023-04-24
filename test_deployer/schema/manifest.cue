// Atributos comunes a la vertical (metadatos)
// -------------------------------------------

meta: {
    name: string        // Nombre de la vertical
    version: string     // Versión de la vertical
}

// Schema de suscripción
// ---------------------

#Subscription: {
  description?: string
  status: "active" | "inactive"
  subject: {
    entities: [...{
      idPattern: string
      type: string
    }],
    condition: {
      attrs: [...string]
      expression: _
    }
  }
  notification: {
    attrs: [...string]
    onlyChangedAttrs?: bool
    attrsFormat?: "normalized"
    covered?: bool
    http?: {
      url: "LASTDATA" | "HISTORIC" | "RULES" | string
    }
    httpCustom?: { 
      url: "LASTDATA" | "HISTORIC" | "RULES" | string 
      headers: {
        Fiware-Servicepath: _
      }
    }
  }
}

subscriptions: {
  [string]: #Subscription
}

// Una customHeader es simplemente un string que se resolverá
// contra el diccionario de customHeaders del deployment.
#customHeader: string
