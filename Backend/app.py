from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
#from routes.persona import persona
#from routes.usuario import usuario
from routes.users import user
from routes.persons import person
from routes.roles import roles
from routes.usersrols import userrol
from routes.receta import receta


app= FastAPI()
# Configuración de CORS
orig_cors_origins = [
    "http://localhost:8080",  # Cambia esto por el origen de tu frontend
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=orig_cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
#app.include_router(persona)
#app.include_router(usuario)
app.include_router(user)
app.include_router(person)
app.include_router(roles)
app.include_router(userrol)
app.include_router(receta)





print("Bienvenido a mi aplicacion")