from fastapi import FastAPI
from routes.persona import persona
from routes.usuario import usuario

app=FastAPI(
    title="Hospital General PrivilegeCare",
    description="API para el almacenamiento de informacipn de un hospital"
)

app.include_router(persona)
app.include_router(usuario)
print("Bienvenido a mi aplicacion")