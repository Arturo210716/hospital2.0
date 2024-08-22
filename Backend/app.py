from fastapi import FastAPI
#from routes.persona import persona
#from routes.usuario import usuario
from routes.users import user
from routes.persons import person
from routes.roles import roles
from routes.usersrols import userrol
from routes.receta import receta
from routes.citas import cita
from routes.expediente import expediente
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Configurar CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Cambia "*" por una lista de orígenes permitidos
    allow_credentials=True,
    allow_methods=["*"],  # Permite todos los métodos (GET, POST, etc.)
    allow_headers=["*"],  # Permite todos los headers
)

#app.include_router(persona)
#app.include_router(usuario)
app.include_router(user)
app.include_router(person)
app.include_router(roles)
app.include_router(userrol)
app.include_router(receta)
app.include_router(cita)
app.include_router(expediente)



print("Bienvenido a mi aplicacion")